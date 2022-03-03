Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB1D4CC399
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbiCCRVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiCCRVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:21:50 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89BC198D27;
        Thu,  3 Mar 2022 09:21:04 -0800 (PST)
Date:   Thu, 03 Mar 2022 17:20:51 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [Letux-kernel] [PATCH v16 1/4] drm/bridge: dw-hdmi: introduce
 dw_hdmi_enable_poll()
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Paul Boddie <paul@boddie.org.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Robert Foss <robert.foss@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Message-Id: <RUI68R.Z009SPJAAD8N1@crapouillou.net>
In-Reply-To: <ABC1BD09-383B-4499-B034-340CE88725B3@goldelico.com>
References: <cover.1645895582.git.hns@goldelico.com>
        <e54838849f80454b863f9f5634dd10f79ef7bb8f.1645895582.git.hns@goldelico.com>
        <983e9064-17ad-e646-f37d-ca9173ba0967@baylibre.com>
        <C8AE9A7A-E288-4637-ACAD-40CD33CD5F8C@goldelico.com>
        <3E620AF4-402E-45EA-9D92-92EAEA9647F5@goldelico.com>
        <SHH68R.Z3J9KSY0GQVA2@crapouillou.net>
        <ABC1BD09-383B-4499-B034-340CE88725B3@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus,

[snip]

>>  Well he said "the Ingenic DRM core" aka ingenic-drm-drv.c. You do 
>> have access to the main drm_device in the ingenic_drm_bind() 
>> function, so you can add it there (with a cleanup function calling 
>> drm_kms_helper_poll_fini() registered with 
>> drmm_add_action_or_reset()).
> 
> Well, do you really want to mix HPD detection between connector, 
> Synopsys bridge and Ingenic DRM core? These are independent...
> Or should be accessed only through the bridge chain pointers.
> 
> IMHO we should keep separate functions separate.

The drm_kms_helper_poll_init() just says "this DRM device may have 
connectors that need to be polled" so it very well fits inside the main 
driver, IMHO.

-Paul

> 
> And maybe this should also be conditional? Maybe not depend on 
> compatible = jz4780 but compatible = ci20?
> 
> Looks to me to be a quick fix in the wrong place.
> 
> Let's fix the CSC issue first.
> 
> BR,
> Nikolaus
> 


