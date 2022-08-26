Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975875A3097
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 22:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344533AbiHZUlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 16:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbiHZUl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 16:41:28 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49935DB070
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 13:41:27 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-11e86b7379dso2254731fac.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 13:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=K/ePAycXqy51oFeXUt6JjGKkq1z8q/7xr7tRKH3+c5k=;
        b=obakSEJ4izX3iVZj3KOtetmevh8RAX2xSvFVa7lOs66USdVv4m+7jIkQj1Ee92YRzX
         vwdQC9/B3BhuefYfKDrm9t20eHKN0JvZbcXejyyvF1paXlrHa7K9Wjwgp7oKCM2jvMQG
         tKJBFGvX0TDPsP1Y8Meus7j6M++aQddvKd28Xm7kNzV8c39UusrUtqyaCZrF0TjA7sKO
         ZDm2gjuL77EL/lFb51mfkRWM5tyJwN5OaU0+A1uaIOGh1me6gckcgIhe0e18w4USDjqW
         Hv6ildtotiYcRQgWJTMDj1UsfIthh++fIZ7OAe/gIwNrxolE1eBJNegl5ScCqzJJBjfW
         5eHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=K/ePAycXqy51oFeXUt6JjGKkq1z8q/7xr7tRKH3+c5k=;
        b=F6dKK6JFkTy72KZ78eHi6vl9YXyHW1ceYcg2JFHogFYOfKYqIfZ1nH8u7GhY/effPK
         qF6+cYvltVKyCDENZsTPxoxVZw3GoycIaKzzPU04O0Lh9kPrCzfZL8CQBq57cdyKNZHC
         Za+uoGYXXKWZYOogAfQCzuemQbjKS/POh3WEnZnfiyC5xpBvxRFJ/iZVjhW+3A7q2hyJ
         PbacV4KOAYPTsS5p2v6XLxa1ia0xZ+dN1Go4u6avkpQYNPrsTDtJ5mWk27bTZdxpzAsH
         hU1KqNvmnADvlIfcOS18Z8BsnXATXVAxXxcSAj523FAhD1nCriqcAPere6zjb4M9q1Bv
         GgXg==
X-Gm-Message-State: ACgBeo1QqW2cdJSTdaDSIUCwbIClXduSDp8OFMXGRYSZZOT6lmH9MHxJ
        d7tHXzaISpW3x0OQnAcxjvAXjGiRX+FSNVLaa1k=
X-Google-Smtp-Source: AA6agR5p3NlrcAZYv3F09Emqjq7q5ADXiA7NQoyGpPUgZIrMlZUDjjJKMUTRMnsyxm2Jxr1CWDWn1fP7ntCneyFCZWk=
X-Received: by 2002:a05:6870:3484:b0:11e:4465:3d9b with SMTP id
 n4-20020a056870348400b0011e44653d9bmr2878995oah.46.1661546486597; Fri, 26 Aug
 2022 13:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220826085754.2296572-1-yangyingliang@huawei.com>
In-Reply-To: <20220826085754.2296572-1-yangyingliang@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 26 Aug 2022 16:41:15 -0400
Message-ID: <CADnq5_NomUqdzmoYcsPuOiFP9BCCiC=Vtt3AGiXqc=SmP6SODA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu: add missing pci_disable_device() in amdgpu_pmops_runtime_resume()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
        pavan.ramayanam@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Aug 26, 2022 at 4:50 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> Add missing pci_disable_device() if amdgpu_device_resume() fails.
>
> Fixes: 8e4d5d43cc6c ("drm/amdgpu: Handling of amdgpu_device_resume return value for graceful teardown")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 429fcdf28836..de7144b06e93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2563,8 +2563,11 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
>                 amdgpu_device_baco_exit(drm_dev);
>         }
>         ret = amdgpu_device_resume(drm_dev, false);
> -       if (ret)
> +       if (ret) {
> +               if (amdgpu_device_supports_px(drm_dev))
> +                       pci_disable_device(pdev);
>                 return ret;
> +       }
>
>         if (amdgpu_device_supports_px(drm_dev))
>                 drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
> --
> 2.25.1
>
