Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA4D56738F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbiGEPy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiGEPyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:54:08 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268251B794
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:52:55 -0700 (PDT)
Received: from rustam-GF63-Thin-9RCX (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPS id AC12440737BD;
        Tue,  5 Jul 2022 15:52:51 +0000 (UTC)
Message-ID: <f483778df438c24ac57d660785c71402a1ba2d2c.camel@ispras.ru>
Subject: [POSSIBLE BUG] Unreachable code or possible dereferencing of NULL
 pointer
From:   Subkhankulov Rustam <subkhankulov@ispras.ru>
To:     David Airlie <airlied@linux.ie>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Date:   Tue, 05 Jul 2022 18:52:45 +0300
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Version: 5.19-rc5

In function 'via_do_init_map' (drivers/gpu/drm/via/via_map.c: 54)
'drm_legacy_findmap' can return NULL pointer. If that happens,it calls
'via_do_cleanup_map' (drivers/gpu/drm/via/via_map.c: 58).

---------------------------------------------------------------------
54    dev_priv->mmio = drm_legacy_findmap(dev, init->mmio_offset);
55    if (!dev_priv->mmio) {
56        DRM_ERROR("could not find mmio region!\n");
57        dev->dev_private = (void *)dev_priv;
58        via_do_cleanup_map(dev);
59        return -EINVAL;
60    }
---------------------------------------------------------------------

'via_do_cleanup' functions calls
'via_dma_cleanup'(drivers/gpu/drm/via/via_map.c: 78).

---------------------------------------------------------------------
76    int via_do_cleanup_map(struct drm_device *dev)
77    {
78        via_dma_cleanup(dev);
79
80        return 0;
81    }
---------------------------------------------------------------------

In 'via_dma_cleanup' there is another conditional construction
(drivers/gpu/drm/via/via_dma.c: 168). 

---------------------------------------------------------------------
168   if (dev_priv->ring.virtual_start) {
169       via_cmdbuf_reset(dev_priv);
170
171       drm_legacy_ioremapfree(&dev_priv->ring.map, dev);
172       dev_priv->ring.virtual_start = NULL;
173   }
---------------------------------------------------------------------

It seems like there are two possible ways: 

1) dev_priv->ring.virtual_start != 0. 

In that case function call chain happens: 'via_cmdbuf_reset',
'via_cmdbuf_flush', 'via_hook_segment' and 'via_read'
(drivers/gpu/drm/via/via_drv.h: 124).
In 'via_read' dereferencing of "dev_priv->mmio" happens, which is NULL.

---------------------------------------------------------------------
124    static inline u32 via_read(struct drm_via_private *dev_priv, u32
reg)
125    {
126        return readl((void __iomem *)(dev_priv->mmio->handle +
reg));
127    }
---------------------------------------------------------------------

2) dev_priv->ring.virtual_start == 0.
Then all function calls located inside conditional construction
(drivers/gpu/drm/via/via_dma.c: 168) do not happen.

Thus, if dev_priv->mmio == NULL, call of 'via_do_cleanup_map'
(drivers/gpu/drm/via/via_map.c: 58) may result in either an error or
nothing at all.
Should we remove call to via_do_cleanup_map(dev) or should we somehow
avoid NULL pointer dereference in 'via_read'?

Found by Linux Verification Center (linuxtesting.org) with SVACE.

regards,
Rustam Subkhankulov

