Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C430558184B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239249AbiGZRXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiGZRXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:23:32 -0400
Received: from mailrelay2-1.pub.mailoutpod1-cph3.one.com (mailrelay2-1.pub.mailoutpod1-cph3.one.com [46.30.210.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962EB6417
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=DRhy3XGBmLg1udTr5AzppCNHJ5niWdcLqIRyqjodBfk=;
        b=WjxRbfix1MCn3AHDG4/RtcQv+EzdA3eiL4shpZvwJACVJOLxrnswwthO+jIkI+i/f/QKYWt2avfWp
         xAICJ7IFqLQibFSzQtRYFmmich3+/SMFjDbJT2v4b9PfZETuQvZtyMiAhvQrxZAPDxgN3J9zey2u2Z
         PgiDe8o1Ltj4DCNiQV3cbCTVKmadjsm+VZ6snH7pgabukXe5xtoQ4Svx0wuDukyBZiEM130cuVhjjM
         HvePA3LpRGXJCVo8IE8dpOCsmtZ8Ao9rR+iCuuXBEW3m8ylBdqBO+SUcS0Gf9LKYMRnRpchYqnOrFa
         hPZAjE0svApuPEa48IntjxbLZfRZc0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=DRhy3XGBmLg1udTr5AzppCNHJ5niWdcLqIRyqjodBfk=;
        b=p9eDkL0uW+povVlhVLWBkM7guKTDciPkoswB7Y1byvekhfRAg+6rQSPsjQtcNXu1k+RMRwpLmXdf4
         hlmJfCUAw==
X-HalOne-Cookie: 1ab96e00759eec4218229468b5eaeefe3b442357
X-HalOne-ID: a97ad866-0d07-11ed-a918-d0431ea8a290
Received: from mailproxy1.cst.dirpod3-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id a97ad866-0d07-11ed-a918-d0431ea8a290;
        Tue, 26 Jul 2022 17:23:28 +0000 (UTC)
Date:   Tue, 26 Jul 2022 19:23:26 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Alisa Khabibrakhmanova <khabibrakhmanova@ispras.ru>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        ldv-project@linuxtesting.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/via: Add new condition to via_dma_cleanup()
Message-ID: <YuAjDvYey1hhI1AJ@ravnborg.org>
References: <20220725104555.124044-1-khabibrakhmanova@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725104555.124044-1-khabibrakhmanova@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alisa,

On Mon, Jul 25, 2022 at 01:45:55PM +0300, Alisa Khabibrakhmanova wrote:
> Pointer dev_priv->mmio, which was checked for NULL at via_do_init_map(),
> is passed to via_do_cleanup_map() and is dereferenced there without check.
> 
> The patch adds the condition in via_dma_cleanup() which prevents potential NULL
> pointer dereference.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 22f579c621e2 ("drm: Add via unichrome support")
> Signed-off-by: Alisa Khabibrakhmanova <khabibrakhmanova@ispras.ru>

Thanks for your patch. Due to other changes in drm-misc where we
maintain the via driver this patch fails to apply.
It would be great if you could redo the patch after -rc2 - on top of
-next. Then we can apply it to drm-misc.

You will see that the individual files for the driver is merged to a
single file, and this change does not hit -next until later.

	Sam
