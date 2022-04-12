Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D01C4FE76C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358518AbiDLRp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244494AbiDLRpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:45:19 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE8462A36
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:43:01 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id g21so23077712iom.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dcXTBW+sUCZX4Cryulv5BVBeuZPCS9qn8OqGe1EBsRg=;
        b=OwSJ+o/DINsy0kUQ8NGR8qNvLghh3S9TSDUUroWlUdPQj+3PrbyYg6E9tq3EHEPgZi
         CU3JbEHbN78HreL+OxeGoQ2Io0q9cBLhjTapimELKg/sNn8VkU6UHH7Ywpjq0diFP2VX
         b61tLJ9Is+uMXOATce52nwkyAlWyIOlE1Dgso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dcXTBW+sUCZX4Cryulv5BVBeuZPCS9qn8OqGe1EBsRg=;
        b=J546ihzFUGOY7FNv29kkQmQsWgSrwp9ZfY1bYU7ILnmlMDQs356xddjJTlIGo1S958
         CCie0+G5CwP06rXN7QQ4wpqBft8PQKUrTYMh+gvoUsLvvZnR+OxAE65f2vtlcOSKYplO
         G7vm3QDvkWTpWOF0E9RjXdKZIIC82nkgh3FVNGZ7hj0hNSjExIRPer1auvJ0cYFrJhU9
         NwxlUv0zxbG2DlX/afnqNdpsbqv1NM2k8XVI4sE8b3Jk7z35j4DCmUCPgp34lCnSryt8
         g0Vg2354RUeep3L1oU8p7dDP5gU8xC2uk/Hw/pfMztwIraHnE+uuI/ttNmZfXgPNNPR/
         /h1Q==
X-Gm-Message-State: AOAM533cVoNQHV73xJpJi2+hnJyyj3JT7QrlLez3P6fkpj1mXGPJJlLt
        MFl4i62nIHcdXB+SEcQ2FQBCXKclsWGsyhzx
X-Google-Smtp-Source: ABdhPJy9oc0Fo6GK0klyfIWpndXaviXR6CAzj2eOhd9ezbHeThdxZb+Xdhoq3A0sdrwYrbY9HvM57g==
X-Received: by 2002:a05:6602:2f01:b0:5ec:f99a:93a1 with SMTP id q1-20020a0566022f0100b005ecf99a93a1mr16139537iow.109.1649785381357;
        Tue, 12 Apr 2022 10:43:01 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id f20-20020a6be814000000b00649d9a4db2asm22329588ioh.27.2022.04.12.10.42.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 10:43:00 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id r11so14092101ila.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:42:58 -0700 (PDT)
X-Received: by 2002:a05:6e02:144f:b0:2ca:391d:5664 with SMTP id
 p15-20020a056e02144f00b002ca391d5664mr16693061ilo.220.1649785378331; Tue, 12
 Apr 2022 10:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <1649769281-12458-1-git-send-email-quic_srivasam@quicinc.com>
 <1649769281-12458-2-git-send-email-quic_srivasam@quicinc.com>
 <YlWNt7f5EUk7I4by@builder.lan> <50953847-3c7f-ce2e-3447-87ba1893a976@quicinc.com>
In-Reply-To: <50953847-3c7f-ce2e-3447-87ba1893a976@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 12 Apr 2022 10:42:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VicFiX6QkBksZs1KLwJ5x4eCte6j5RWOBPN+WwiXm2Cw@mail.gmail.com>
Message-ID: <CAD=FV=VicFiX6QkBksZs1KLwJ5x4eCte6j5RWOBPN+WwiXm2Cw@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] arm64: dts: qcom: sc7280: Add pinmux for I2S
 speaker and Headset
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        quic_rohkumar@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 12, 2022 at 7:43 AM Srinivasa Rao Mandadapu
<quic_srivasam@quicinc.com> wrote:
>
> On 4/12/2022 8:03 PM, Bjorn Andersson wrote:
> Thanks for your time Bjorn!!!
> > On Tue 12 Apr 08:14 CDT 2022, Srinivasa Rao Mandadapu wrote:
> >
> >> Add pinmux nodes for primary and secondary I2S for SC7280 based platforms.
> >>
> >> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> >> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> >> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> >> ---
> >>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 14 +++++++++++
> >>   arch/arm64/boot/dts/qcom/sc7280.dtsi     | 40 ++++++++++++++++++++++++++++++++
> >>   2 files changed, 54 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> >> index ecbf2b8..1fc94b5 100644
> >> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> >> @@ -359,6 +359,20 @@
> >>      bias-disable;
> >>   };
> >>
> >> +&mi2s1_data0 {
> >> +    drive-strength = <6>;
> >> +    bias-disable;
> >> +};
> >> +
> >> +&mi2s1_sclk {
> >> +    drive-strength = <6>;
> >> +    bias-disable;
> >> +};
> >> +
> >> +&mi2s1_ws {
> >> +    drive-strength = <6>;
> >> +};
> >> +
> >>   &pm7325_gpios {
> >>      key_vol_up_default: key-vol-up-default {
> >>              pins = "gpio6";
> >> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >> index f0b64be..6e6cfeda 100644
> >> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >> @@ -3522,6 +3522,46 @@
> >>                              function = "edp_hot";
> >>                      };
> >>
> >> +                    mi2s0_data0: mi2s0-data0 {
> > Are these ever going to be selected individually, or could this be:
> >
> > mi2s0_state: mi2s0-state {
> >       data0 {
> >               ...;
> >       };
> >
> >       data1 {
> >               ...;
> >       };
> >
> >       mclk {
> >               ...;
> >       };
> >
> >       etc
> > };
> >
> > mi2s1-state {
> >       ...;
> > };
> >
> > And then a single pinctrl-0 = <&mi2c0_state>;
> >
> > Regards,
> > Bjorn
>
> We are not selecting individually. Actually we were following the same,
> but Doug Anderson suggested this way of handling in 1st version of patches.
>
> So changed accordingly.

Right. The problem with the syntax Bjorn is suggesting is that it's
harder for board files to override. They essentially have to replicate
your hierarchy in their board file when they're setting drive
strengths / pullups and that gives them the chance to make typos in
the names of the nodes. It also means that if someone
reorganizes/renames the pinctrl in the SoC dtsi file that it could
unintentionally break a board. I talked about this a little in commit
f9800dde34e6 ("arm64: dts: qcom: sc7280: Clean up sdc1 / sdc2
pinctrl").

-Doug
