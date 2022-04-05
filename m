Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BEB4F5172
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1846328AbiDFCDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573086AbiDERza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:55:30 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AB3DE09D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:53:30 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q14so18072342ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 10:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MYJtsikWi9hIB8NHNY8S76MVB/wVdm4tXnry+6+yiEo=;
        b=ijwBLjjh6lk3Bb+x9kE21mGPVSMbJnI+Yi/zPHj8mem2U9fEgN+edh+EmjEqa+XZcD
         n/lfaXf0Tweh9j3vMEvYaRq5AnA39APG5yQv6NKxIshzQR69mp6t6YhwSPfx9qs+WETe
         qzbk+Vb7I8DycQ3I99Ja5mziLFXJ/cQUDqh9BmEFPMUrEBXvhlToOea+VAhw6cZbQC74
         NLoIe5lNwslTIQJXZenzM6298KtFhaCaJ7H2Dofx9iOBYLBqokApBi/5kHOVzBOSha+8
         N0ViNXCPr1zN2Xi1NpaNTckkmR0R5uQew58xTxPUq6A6fCfWeEH1Zr8aSDV8F7XJ0RBt
         zqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MYJtsikWi9hIB8NHNY8S76MVB/wVdm4tXnry+6+yiEo=;
        b=U8dgLX2doJtGdh7Ko7qCbk3v2ADUZsYAwW37/VqBPk9FV38DDikGInK0mtFgFJZkt8
         3dJ0ToTELZqtVTDO3G0rccETyI4NhuvC1j6K2V8KQiMp014nwSlUZgfRa8oMianS8y6Z
         +fmQ05mvn47tM1hoLjnU9KpqIDCJI7asrS2QoS9xYcvJTUpAm2YRfUkZwzEeHPy57bj3
         7vfUCWc+5ttL8IoG2BUx2pyENUNm+jC+/dEIrjalareRIMsXhJFzJoMSz50HB0kF2E09
         derec2OBmaWGDap9bQEIMluwnXutrEH/k47eIRpRtGxc3Fp0Jy8EvLc2F8Cv2olr4/WP
         ubcw==
X-Gm-Message-State: AOAM533Td9OhvyDibARyylNxuHrNVvjylCMMy9GnJeKMRRhllKOSiXcx
        h94d5tZ8xfvVltP8fIijEeYrltdR/p6xjY0pd7a0Vw==
X-Google-Smtp-Source: ABdhPJxkfZhW0np+6HFZguzcslyOvUzoSGSv9BMWk5pjhEH5IyVC6Lb8xm3p/2a9i36EyTCg1IFq70K2lSb/IBVbZTs=
X-Received: by 2002:a2e:9ec4:0:b0:24b:115c:aedb with SMTP id
 h4-20020a2e9ec4000000b0024b115caedbmr2807694ljk.235.1649181208750; Tue, 05
 Apr 2022 10:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220319143456.2159540-1-trix@redhat.com>
In-Reply-To: <20220319143456.2159540-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 Apr 2022 10:53:17 -0700
Message-ID: <CAKwvOdkEnDBFUtio2+UVeV1J3QUwAJOc-YgcubDEUXHWMF5gbw@mail.gmail.com>
Subject: Re: [PATCH] media: platform: return early if the iface is not handled
To:     trix@redhat.com
Cc:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        nathan@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2022 at 7:35 AM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> Clang static analysis reports this issue
> ispcsiphy.c:63:14: warning: The left operand of '<<'
>   is a garbage value
>         reg |= mode << shift;
>                ~~~~ ^
> The iface switch-statement default case falls through
> to ISP_INTERFACE_CCP2B_PHY1.  Which is later checked
> to set the mode.  Since the default case is left out
> of this check mode is never set.  Instead of falling
> through and assuming a ISP_INTERFACE_CCP2B_PHY1
> iface, return.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/media/platform/ti/omap3isp/ispcsiphy.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/ti/omap3isp/ispcsiphy.c b/drivers/media/platform/ti/omap3isp/ispcsiphy.c
> index 6dc7359c5131d..1bde76c0adbee 100644
> --- a/drivers/media/platform/ti/omap3isp/ispcsiphy.c
> +++ b/drivers/media/platform/ti/omap3isp/ispcsiphy.c
> @@ -31,7 +31,8 @@ static void csiphy_routing_cfg_3630(struct isp_csiphy *phy,
>
>         switch (iface) {
>         default:
> -       /* Should not happen in practice, but let's keep the compiler happy. */
> +               /* Should not happen in practice, but let's keep the compiler happy. */
> +               return;
>         case ISP_INTERFACE_CCP2B_PHY1:
>                 reg &= ~OMAP3630_CONTROL_CAMERA_PHY_CTRL_CSI1_RX_SEL_PHY2;
>                 shift = OMAP3630_CONTROL_CAMERA_PHY_CTRL_CAMMODE_PHY1_SHIFT;
> --
> 2.26.3
>


-- 
Thanks,
~Nick Desaulniers
