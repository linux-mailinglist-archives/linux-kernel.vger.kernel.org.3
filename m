Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DE251E16A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 23:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444589AbiEFV60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 17:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbiEFV6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 17:58:21 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C98A6FA15;
        Fri,  6 May 2022 14:54:37 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id hf18so7030857qtb.0;
        Fri, 06 May 2022 14:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RwE9cq9p0Nlb5WXcx6miQbDi/yCUsV/mHE4B3DAunEQ=;
        b=XBjKjnmoAxI4U0zjITutiDy4hvb6gAkXbGpivr33VkTd3yXk046a9ztdGeEmoM8xmq
         viKWdYYQfgz/9kE4Yg3VViyBRWrngMQ+CYisgxaF7Yy07Hm3KEs0CMQ3wAgV0y/jgMbw
         hl0m2eg+knwyjh8UOWlDRShpxjXdFrw/zwBADtcDL51HoarIoYBNvfrvg6Fvq8owwl6I
         03Kj+u1smm7ys8OGB+uymtUOQOY/zU6Oy7idBZl5LsucdrsafoofLKL4QmvpNdPjAYMG
         a+M81ZX3QL10EVljZXaEtEP2ngXk0DRgDvME1Qrmr88QSHjs23rooxoYa+cgE7svNIBx
         4pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RwE9cq9p0Nlb5WXcx6miQbDi/yCUsV/mHE4B3DAunEQ=;
        b=mcJVlRBXAKTqbmyGm/FppKgicHopPS7wVy9p15czdTYVpBtyGyQ2Jkj1dO9qFFSGbP
         e+beocbA6ExEMBHufts2tv6sa/1ooQXxoMCB2LX5GfAdd3agaYzACxhd4m2Uud8Mo/WJ
         x5GOOOdOu7ElAoBW+cPgYVWfLNdXXuxwqwSQw1z2v+wJVYfvqQr1wf09q3I6sirGhCaw
         nf6l6RttoN+/CNnW0CCEZ1fX3ecq4ERLHUkcNZZj4EF/rThVkU9VuRRuv6ob2NyTShJE
         fRyqf7giJe+MukCGtd+fAmM4MfdVKUBJULH2aO+fYiGf8UQwl/6WhtUtVB+pyVFsBVMI
         LhUA==
X-Gm-Message-State: AOAM533NFRpzSJC5lkCAkA52b4GNpK03/b2lvYgQFB/uJxgl6gZ7/1mk
        I41PKmtun2n2HD3Gz3pvOHH5wGAVLOi4hZnq/II=
X-Google-Smtp-Source: ABdhPJwxY/50SN1+xVwy4AdOMSL/WvUMQPV+2K5V61Yi3kCKeGyqxkZqly9+WDBG/E9q8eqf/qN7lNQrTbZltStTOzE=
X-Received: by 2002:a05:622a:155:b0:2f3:9484:c38e with SMTP id
 v21-20020a05622a015500b002f39484c38emr4801986qtw.494.1651874076599; Fri, 06
 May 2022 14:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220425182249.2753690-1-robimarko@gmail.com> <20220425182249.2753690-2-robimarko@gmail.com>
 <YnSW+mNgAp17e/YE@builder.lan>
In-Reply-To: <YnSW+mNgAp17e/YE@builder.lan>
From:   Robert Marko <robimarko@gmail.com>
Date:   Fri, 6 May 2022 23:54:25 +0200
Message-ID: <CAOX2RU4B6hqQtJCW3ifXfxd9dMCGE+FygDimGQOP49PRjp_y3g@mail.gmail.com>
Subject: Re: [PATCH 2/7] clk: qcom: ipq8074: disable USB GDSC-s SW_COLLAPSE
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Abhishek Sahu <absahu@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>
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

On Fri, 6 May 2022 at 05:33, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
>
> On Mon 25 Apr 13:22 CDT 2022, Robert Marko wrote:
>
> > Like in IPQ6018 Qualcomm intentionally disables the SW_COLLAPSE on the USB
> > GDSC-s in the downstream 5.4 kernel.
> >
> > This could potentially be better handled by utilizing the GDSC driver, but
> > I am not familiar with it nor do I have datasheets.
>
> Could you please give it a try before we pick this up?
> Look at e.g. drivers/clk/qcom/gcc-sdm845.c how usb30_prim_gdsc and
> usb30_sec_gdsc are defined, the offsets in specified in .gdscr should be
> the same offsets you give below.
>
> Then you specify an array of struct gdsc *, associating the two gdscs
> you have specified to some identifier (USB30_PRIM_GDSC and
> USB30_SEC_GDSC is used in sdm845) and reference this list as .gdscs and
> num_gdscs in the gcc_ipq8074_desc.
>
> The last part is to tie the USB controllers to the two GDSCs, this is
> done by simply specifying:
>
>         power-domains = <&gcc USB30_PRIM_GDSC>;
>
> and USB30_SEC_GDSC, in the two USB nodes in DeviceTree. SW_COLLAPSE will
> be toggled by the PM state of the USB driver, like it's done on e.g.
> sdm845.

Hi Bjorn, thanks for the tips, it makes more sense now.
The only thing I am not sure about are the feature flags for these GDSCs,
how to figure out which ones are correct as I dont have datasheets and QCA
does not use GDSCs in the downstream kernel?
POLL_CFG_GDSCR will cause the GDSC not to get enabled, while VOTABLE
seems to work.

Regards,
Robert

>
> Regards,
> Bjorn
>
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >  drivers/clk/qcom/gcc-ipq8074.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
> > index 2ebd1462db78..65249a03a672 100644
> > --- a/drivers/clk/qcom/gcc-ipq8074.c
> > +++ b/drivers/clk/qcom/gcc-ipq8074.c
> > @@ -4806,6 +4806,11 @@ static int gcc_ipq8074_probe(struct platform_device *pdev)
> >       if (IS_ERR(regmap))
> >               return PTR_ERR(regmap);
> >
> > +     /* Disable SW_COLLAPSE for USB0 GDSCR */
> > +     regmap_update_bits(regmap, 0x3e078, BIT(0), 0x0);
> > +     /* Disable SW_COLLAPSE for USB1 GDSCR */
> > +     regmap_update_bits(regmap, 0x3f078, BIT(0), 0x0);
> > +
> >       clk_alpha_pll_configure(&ubi32_pll_main, regmap, &ubi32_pll_config);
> >       clk_alpha_pll_configure(&nss_crypto_pll_main, regmap,
> >                               &nss_crypto_pll_config);
> > --
> > 2.35.1
> >
