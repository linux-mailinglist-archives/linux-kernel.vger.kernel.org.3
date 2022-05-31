Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F365389AA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 03:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243434AbiEaBiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 21:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbiEaBiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 21:38:16 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8393E60D9A
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 18:38:15 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 31 May
 2022 09:38:04 +0800
Received: from [172.16.137.70] (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 31 May
 2022 09:38:03 +0800
Message-ID: <45fce6db-2e9d-0e0e-3a71-97575d7bb722@meizu.com>
Date:   Tue, 31 May 2022 09:38:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/nouveau/therm: Fix pointer dereferenced before
 checking
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        "Lyude Paul" <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <1653880246-23670-1-git-send-email-baihaowen@meizu.com>
From:   baihaowen <baihaowen@meizu.com>
In-Reply-To: <1653880246-23670-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/5/30 上午11:10, Haowen Bai 写道:
> The fan->base is dereferencing before null checking, so move
> it after checking.
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/therm/fanpwm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/fanpwm.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/fanpwm.c
> index 340f37a299dc..b13ba9b2f6be 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/fanpwm.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/fanpwm.c
> @@ -98,10 +98,10 @@ nvkm_fanpwm_create(struct nvkm_therm *therm, struct dcb_gpio_func *func)
>  		return -ENODEV;
>  
>  	fan = kzalloc(sizeof(*fan), GFP_KERNEL);
> -	therm->fan = &fan->base;
>  	if (!fan)
>  		return -ENOMEM;
>  
> +	therm->fan = &fan->base;
>  	fan->base.type = "PWM";
>  	fan->base.get = nvkm_fanpwm_get;
>  	fan->base.set = nvkm_fanpwm_set;
Sorry, plz ignore this patch.

fan->base is dereferenced, &fan->base is just a pointer math for pointer address offset, so it would not cause a bug(dereferencing null pointer).

 

-- 
Haowen Bai

