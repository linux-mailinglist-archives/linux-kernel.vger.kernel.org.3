Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728F9507974
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355038AbiDSSzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347092AbiDSSzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:55:03 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9090D3DA59
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:52:19 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id bo5so9195504pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NooUuNCkNMvpIoZXYh5tmIEgwsCUJNTDomQ0FyzjCCY=;
        b=e5tBOqr4lavAAuGYjg9IsQpk5mL/uk7Hdvwg9DtAAbKtZmxEWJgmAQp7FQIqkewjbk
         4YGEK7NP2wBE01hyYpf1yzb59q/zCTRm5NqBDu7ia28oqZbmNm5BSCnuDm60j0QDysmX
         NLoyNLkz+clrh32C0DkZmjHlXO4s9ujkPH9I8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NooUuNCkNMvpIoZXYh5tmIEgwsCUJNTDomQ0FyzjCCY=;
        b=mlRkwvgEB/zIoZbmyPRVeSZLjt0PqIq4pAu20SjkUQ7y4zsewwM5Q1TS1u4kEhCgFD
         MeTvxU0MkiJQBgnJ4upHC95FkRyu04TEwKTc9QyJbcBdRyUfpvX8SEo/wRJLBhBlKMPK
         I+/8UdfASL4mO4mA+CRCStuIBZNmBqfVab8jj6b4zpZsu7K66LutqQiZT+QOuX9zU86X
         rNCdngXPHpdbWln2lvTUhH6ymMDOpjx7sASEA0V6vmONxMIwRaYw9P6J1CBfLNU+Rooi
         Fwu290wPbQePzZMXvRbZZU6Rs3ezv7yJZ0Exjr2HOlp4yIqy1Jwk7WIa7bcoUhxkfZcF
         UJoQ==
X-Gm-Message-State: AOAM530APL6W7yV1m69qyMngF+V8FjQ3smz2bUr0+lO8OS2spmYeTs1q
        MoKQ/FcUbzc29+QRcPIcEtPKlAmsVWEeJ7krW9cdIg==
X-Google-Smtp-Source: ABdhPJw9leYYKP26T9hLXHvp/ankYK20nLxEHwwASoB++NOIyzORrRT1SBQhNE7UnLrUPU92v21CkG2tpm8Ax/lQl0k=
X-Received: by 2002:a63:6e04:0:b0:398:409:2928 with SMTP id
 j4-20020a636e04000000b0039804092928mr15992700pgc.250.1650394339106; Tue, 19
 Apr 2022 11:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220419181444.485959-1-sashal@kernel.org> <20220419181444.485959-11-sashal@kernel.org>
In-Reply-To: <20220419181444.485959-11-sashal@kernel.org>
From:   Rob Clark <robdclark@chromium.org>
Date:   Tue, 19 Apr 2022 11:53:23 -0700
Message-ID: <CAJs_Fx7YVBn7qvaE23ThBOFzozKHBkefdSztfF+xtTw2hhgw2Q@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.4 11/14] drm/msm: Stop using iommu_present()
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You might want to drop this one, it seems to be causing some issues on
older generations.. I'll be sending another PR shortly with a revert.

https://patchwork.freedesktop.org/patch/482453

BR,
-R

On Tue, Apr 19, 2022 at 11:15 AM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Robin Murphy <robin.murphy@arm.com>
>
> [ Upstream commit e2a88eabb02410267519b838fb9b79f5206769be ]
>
> Even if some IOMMU has registered itself on the platform "bus", that
> doesn't necessarily mean it provides translation for the device we
> care about. Replace iommu_present() with a more appropriate check.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Rob Clark <robdclark@gmail.com>
> Patchwork: https://patchwork.freedesktop.org/patch/480707/
> Link: https://lore.kernel.org/r/5ab4f4574d7f3e042261da702d493ee40d003356.1649168268.git.robin.murphy@arm.com
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/gpu/drm/msm/msm_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 407b51cf6790..7322df9cf673 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -303,7 +303,7 @@ bool msm_use_mmu(struct drm_device *dev)
>         struct msm_drm_private *priv = dev->dev_private;
>
>         /* a2xx comes with its own MMU */
> -       return priv->is_a2xx || iommu_present(&platform_bus_type);
> +       return priv->is_a2xx || device_iommu_mapped(dev->dev);
>  }
>
>  static int msm_init_vram(struct drm_device *dev)
> --
> 2.35.1
>
