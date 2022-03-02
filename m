Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6A34CAB88
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243808AbiCBR0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243799AbiCBR0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:26:17 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA0ACCC6F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:25:31 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id u17-20020a056830231100b005ad13358af9so2231106ote.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 09:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A7p+Sua3vWTnrJZHdXkQWaCDCi1ogBb2wcZTsYiqgV4=;
        b=kSgjDYJtPfb9ROCmWxhJKur8Uaw3MOy+15dIiLp2BSKjF6NgN4VZPpOm11PH5Q2XrA
         r7UqQ8AaC5RLrjGi485c5S8PablqMesWLFYHzsnpfcYXW5sH7ojPTvi/b4Wtn1+Lb4LI
         u8Ki+p4BrjOZDvRVCNP8Yq6NvOGZ/t85CEOYWpgTSqxC7K326FpV9CyYlRyr7Dbr2eNx
         FAVu6BaRigJcOwFcbBaJDzoIRdc8l5qu53ZMTrJiSXmNLtU9wGjUkOmDJ9OFe1KyB66C
         FfM9f9NRMOu0nrjn4rjNuOs/xijBjaPfQMoRJ0OArmgDe2qhxEE2dOoW/gkO3qeFidbu
         eyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A7p+Sua3vWTnrJZHdXkQWaCDCi1ogBb2wcZTsYiqgV4=;
        b=oRdD7ByYIslMHm4+gs+8tWZSMRc1wAikovF9imXSLYkbuRPyN+nv5SmASy/FoSrzi6
         GYPi+KI7hmvI42YgqhCU740ekv4li4mrsRyKVFrJdbfGK7kz/oZ69iotZxAzu8cl89DV
         IDsOSvA7JZNdvey/R1UnobaqGeYOtCjk3ucdxZY4BRJQzaBfyojsaf0Bm/71zcTKHaN+
         dXS4uCITowIivWoBgDmg0L0/n423PUM2IpiMKP77bGh5Acx+pBhcxofr5bkNinsJXGFk
         sCVvOC8n+6ZTSs/ajQAtaM4PCaNWvA4rOIlCqqVW1hd4q7hzYGxa5VV0mqU1Ad9XNNC6
         mfjQ==
X-Gm-Message-State: AOAM532uzPhrljZ4N0tiJ+AyLsgIbdbqkk3xek41elTSM/Zrm84XRG1J
        1KmYJynFndxjzmy3w4SaLTniRFvccfKvIm2WR8fzYw==
X-Google-Smtp-Source: ABdhPJwwxzHWuf8viqR1OdWBAi0a7r41AOauclraB7d347YvqjAztRTJua35obzbRfApLE3btcmqP+cYlOjzbV8E/Ns=
X-Received: by 2002:a05:6830:314c:b0:5af:dc8a:d066 with SMTP id
 c12-20020a056830314c00b005afdc8ad066mr13881461ots.28.1646241930640; Wed, 02
 Mar 2022 09:25:30 -0800 (PST)
MIME-Version: 1.0
References: <20220302110508.69053-1-bhupesh.sharma@linaro.org>
 <20220302110508.69053-3-bhupesh.sharma@linaro.org> <CAA8EJprTiGfEnkPOeDPyobdRGkyzyC6=vHivfQ9zsk22JPjM3w@mail.gmail.com>
In-Reply-To: <CAA8EJprTiGfEnkPOeDPyobdRGkyzyC6=vHivfQ9zsk22JPjM3w@mail.gmail.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Wed, 2 Mar 2022 22:55:19 +0530
Message-ID: <CAH=2NtySLVEk_aLdftCS9DcfPS6egUxVAJTZnxjxLPQQnGb4aw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] clk: qcom: gcc: Add emac GDSC support for SM8150
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, tdas@codeaurora.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        robh+dt@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Wed, 2 Mar 2022 at 18:00, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, 2 Mar 2022 at 14:05, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
> >
> > Add the EMAC GDSC defines and driver structures for SM8150.
> >
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  drivers/clk/qcom/gcc-sm8150.c               | 34 +++++++++++++--------
> >  include/dt-bindings/clock/qcom,gcc-sm8150.h |  1 +
> >  2 files changed, 23 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
> > index 245794485719..08ba29e3a835 100644
> > --- a/drivers/clk/qcom/gcc-sm8150.c
> > +++ b/drivers/clk/qcom/gcc-sm8150.c
> > @@ -3448,22 +3448,31 @@ static struct clk_branch gcc_video_xo_clk = {
> >         },
> >  };
> >
> > +static struct gdsc emac_gdsc = {
> > +       .gdscr = 0x6004,
> > +       .pd = {
> > +               .name = "emac_gdsc",
> > +       },
> > +       .pwrsts = PWRSTS_OFF_ON,
> > +       .flags = POLL_CFG_GDSCR,
> > +};
> > +
> >  static struct gdsc usb30_prim_gdsc = {
> > -               .gdscr = 0xf004,
> > -               .pd = {
> > -                       .name = "usb30_prim_gdsc",
> > -               },
> > -               .pwrsts = PWRSTS_OFF_ON,
> > -               .flags = POLL_CFG_GDSCR,
> > +       .gdscr = 0xf004,
> > +       .pd = {
> > +               .name = "usb30_prim_gdsc",
> > +       },
> > +       .pwrsts = PWRSTS_OFF_ON,
> > +       .flags = POLL_CFG_GDSCR,
>
> Please move alignment changes to a separate patch

Right, Will fix it in v3.

Regards,
Bhupesh

> >  };
> >
> >  static struct gdsc usb30_sec_gdsc = {
> > -               .gdscr = 0x10004,
> > -               .pd = {
> > -                       .name = "usb30_sec_gdsc",
> > -               },
> > -               .pwrsts = PWRSTS_OFF_ON,
> > -               .flags = POLL_CFG_GDSCR,
> > +       .gdscr = 0x10004,
> > +       .pd = {
> > +               .name = "usb30_sec_gdsc",
> > +       },
> > +       .pwrsts = PWRSTS_OFF_ON,
> > +       .flags = POLL_CFG_GDSCR,
> >  };
> >
> >  static struct clk_regmap *gcc_sm8150_clocks[] = {
> > @@ -3714,6 +3723,7 @@ static const struct qcom_reset_map gcc_sm8150_resets[] = {
> >  };
> >
> >  static struct gdsc *gcc_sm8150_gdscs[] = {
> > +       [EMAC_GDSC] = &emac_gdsc,
> >         [USB30_PRIM_GDSC] = &usb30_prim_gdsc,
> >         [USB30_SEC_GDSC] = &usb30_sec_gdsc,
> >  };
> > diff --git a/include/dt-bindings/clock/qcom,gcc-sm8150.h b/include/dt-bindings/clock/qcom,gcc-sm8150.h
> > index 3e1a91876610..40596b9ded06 100644
> > --- a/include/dt-bindings/clock/qcom,gcc-sm8150.h
> > +++ b/include/dt-bindings/clock/qcom,gcc-sm8150.h
> > @@ -243,5 +243,6 @@
> >  /* GCC GDSCRs */
> >  #define USB30_PRIM_GDSC                     4
> >  #define USB30_SEC_GDSC                                         5
> > +#define EMAC_GDSC                                              6
> >
> >  #endif
> > --
> > 2.35.1
> >
>
>
> --
> With best wishes
> Dmitry
