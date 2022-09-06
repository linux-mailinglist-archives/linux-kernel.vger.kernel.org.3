Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5F65AF45B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiIFTXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiIFTW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:22:57 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EF0A927B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:22:56 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dc5so5697077ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 12:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5bwFM9UuatV/9s8ea3bTh+4VZX12Y9aX8P2/k8aLadI=;
        b=hcEkiN0x5Rv0as/DYY7Tm7xnP5Xa+yJ7efy26/W2MLY3B+YYG5B48z5mwaEeXTqWr+
         n/b1GDFCeQmeLKWox9YdDw6r1NGqEwx1cR1KJMNGYAbTfQwW8lS1lKeV1RcrD0ZkHqww
         +2t/j2981gd/8Xo31O63L9z5KSUenBdc/b+6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5bwFM9UuatV/9s8ea3bTh+4VZX12Y9aX8P2/k8aLadI=;
        b=64UZGcQj9lJK4YqviaJYShFGTvS4KHPZxTvw4woqvWI6/bkTRROl+RSMzmKD5XR3Ch
         IkyufoIsBs4czKsMtWr5Vr5sUJPXuHM2XzEXWCZdGoYJYxFHyHvTp6VkJxIfrdsnpq1N
         tERjxJtDs+dHacZbbVPz+aJXy9ncdPdKsc3X09WEG3EcBjlX8rNoI2O64H4xStAUhO+L
         ij1CoiLVj+BciFbcjTbqbjRfmpoi6a2BGPnxUl93t0gZ31Pb3tvAc3ktkGQ3rVN7yCb7
         cogI6eq23WZPLE86b1W/9e3u2VuAcOLpoPex/HYhK4z56FMkBJv0nZ6pBi8VdJawp+Ac
         xbJA==
X-Gm-Message-State: ACgBeo2em1CLrr9AUsP7CbZY2/xhPGNw8j4d9EMB9zJsFNlKxNCGKSni
        bJQV4mcxRvkBPqpuorySZUpXqjVSLtFudHIg
X-Google-Smtp-Source: AA6agR6AHMuxUiPf7UWmxLjcovyrEixBzeRQflPL+aXpldw5GK9rvgaXPH8ho6kv5UcUL4FGIoUcsQ==
X-Received: by 2002:a17:906:7952:b0:74f:25e3:7a7c with SMTP id l18-20020a170906795200b0074f25e37a7cmr16410403ejo.105.1662492174992;
        Tue, 06 Sep 2022 12:22:54 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id y4-20020aa7c244000000b004479df2ff82sm9058506edo.51.2022.09.06.12.22.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 12:22:53 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id h1so7390359wmd.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 12:22:53 -0700 (PDT)
X-Received: by 2002:a05:600c:42c3:b0:3a6:431:91bf with SMTP id
 j3-20020a05600c42c300b003a6043191bfmr13994897wme.188.1662492173404; Tue, 06
 Sep 2022 12:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220901102946.v2.1.I347ea409ee3134bd32a29e33fecd1a6ef32085a0@changeid>
 <CAD=FV=WBzVTaz1dtMswNMWhBzBBUQZTxqXff_DgiuP6WJgG8Qg@mail.gmail.com> <YxeZrvKvRB/ct3Ss@google.com>
In-Reply-To: <YxeZrvKvRB/ct3Ss@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 6 Sep 2022 12:22:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VsRi2kt9K9E+VOEGqdJFT43-aj415Gk2Q=OP64L-JAUA@mail.gmail.com>
Message-ID: <CAD=FV=VsRi2kt9K9E+VOEGqdJFT43-aj415Gk2Q=OP64L-JAUA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7180: Configure USB as wakeup source
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 6, 2022 at 12:04 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Hi Doug,
>
> On Tue, Sep 06, 2022 at 11:33:56AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Sep 1, 2022 at 10:29 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> > >
> > > The dwc3 USB controller of the sc7180 supports USB remote
> > > wakeup, configure it as a wakeup source.
> > >
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > >
> > > Changes in v2:
> > > - use qcom/arm64-for-6.1 as base, v1 was unintendedly based on a
> > >   downstream branch that was used for testing
> > >
> > >  arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > > index e8debb0da411..af5bab27eaf3 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > > @@ -2782,6 +2782,8 @@ usb_1: usb@a6f8800 {
> > >                                         <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3 0>;
> > >                         interconnect-names = "usb-ddr", "apps-usb";
> > >
> > > +                       wakeup-source;
> > > +
> >
> > The patch documenting this property has landed in commit 416b61893860
> > ("dt-bindings: usb: qcom,dwc3: add wakeup-source property"). I guess
> > the only question is whether this should be in the general sc7180
> > device tree file or just for trogdor.
>
> I had a similar comment on the patch for sc7280 [1], there the rationale
> for putting the property into the .dtsi of the SoC was that the wakeup
> capability is provided by the SoC.
>
> For sc8280xp.dtsi the property is also in the .dtsi of the SoC:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/tree/arch/arm64/boot/dts/qcom/sc8280xp.dtsi?h=arm64-for-6.1#n1315
>
> > Any chance it could cause problems for devices that aren't designed like
> > trogdor?
>
> Probably not in a functional sense, however power consumption during system
> suspend is slightly higher (2-3 mW) when USB wakeup is enabled. Boards can
> disable wakeup by deleting the property in their .dtsi file, though it
> is not necessarily evident that this is an option to reduce power
> consumption.
>
> [1] https://patchwork.kernel.org/project/linux-arm-msm/patch/1649321104-31322-7-git-send-email-quic_c_sanm@quicinc.com/

OK then.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
