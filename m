Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E715AF39C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 20:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiIFSeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 14:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiIFSeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 14:34:12 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D866F81693
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 11:34:10 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b16so16324701edd.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 11:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=YxnHTWcYZvzF+VRDJKigMnC8f9W9KZNVnVDsV1AMwoc=;
        b=i6UFTEKSIUMhWtO1MB9MaGSXXbI4dolkonGKMDDYoABfTxvn4aAvu7nmcyUyY1b3BZ
         bBTLJrnIQNFJggguSrDPV7Wd11brAm9lT19cfqsF5+BXnE6HqCzs991vyvYX29VZh/xg
         Zzd6OPaWiDw2GdXL8byNUqR5AQXvDJZJVu/qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=YxnHTWcYZvzF+VRDJKigMnC8f9W9KZNVnVDsV1AMwoc=;
        b=6u5UyXse6Zl7kpIDEhfrI/GLwxljnYpeWoTESv8LihGFfHFewteiqsZZkjL9TWBR9z
         HnFFTuPvHTvHdM0SRRKfoA+bq1JWw/0rQNz8MCctI9AkjzJyRLIs8AySSGUcb6At0Wwp
         D7BndJepE9CKH1J5QNPLAcdwd5bMKERK8GV1HUS8wfBrMdbOAJNNr1WQUSxSRXk9piIf
         lrMpHTJLfbdUw1ABiV5JbSL8IUop+ONgV+X1cYqV4QXmVCAfo7cWIICR275pD7ZV7CTe
         67W/bW2f2MN28ulHCTn/z3T8tuGbdgjuwnF6EqHlH4VtrTjJxHVPvvwK5AueANKOQU6h
         T3pQ==
X-Gm-Message-State: ACgBeo2eKkOFaj+Rirqm8ErcZ6/OmK5tP6OSgQoWcKbdU907DXvmC/ej
        itz18TiavEetBGHhnuFYkZKoTOZJW8M4Og==
X-Google-Smtp-Source: AA6agR4gS7BXfDjMYIEH5S2zxLngdVKwFGOG3fHB9vj8F78eijxIdM65+lRCU9GlidqT/GTM4e5H4w==
X-Received: by 2002:a05:6402:496:b0:443:a5f5:d3b with SMTP id k22-20020a056402049600b00443a5f50d3bmr50389444edv.331.1662489249197;
        Tue, 06 Sep 2022 11:34:09 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id b15-20020a17090630cf00b0073dd1ac2fc8sm6971492ejb.195.2022.09.06.11.34.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 11:34:08 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id k17so7339478wmr.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 11:34:08 -0700 (PDT)
X-Received: by 2002:a05:600c:4e8b:b0:3a5:f5bf:9c5a with SMTP id
 f11-20020a05600c4e8b00b003a5f5bf9c5amr14894307wmq.85.1662489247864; Tue, 06
 Sep 2022 11:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220901102946.v2.1.I347ea409ee3134bd32a29e33fecd1a6ef32085a0@changeid>
In-Reply-To: <20220901102946.v2.1.I347ea409ee3134bd32a29e33fecd1a6ef32085a0@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 6 Sep 2022 11:33:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WBzVTaz1dtMswNMWhBzBBUQZTxqXff_DgiuP6WJgG8Qg@mail.gmail.com>
Message-ID: <CAD=FV=WBzVTaz1dtMswNMWhBzBBUQZTxqXff_DgiuP6WJgG8Qg@mail.gmail.com>
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
        <devicetree@vger.kernel.org>
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

On Thu, Sep 1, 2022 at 10:29 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> The dwc3 USB controller of the sc7180 supports USB remote
> wakeup, configure it as a wakeup source.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
> Changes in v2:
> - use qcom/arm64-for-6.1 as base, v1 was unintendedly based on a
>   downstream branch that was used for testing
>
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index e8debb0da411..af5bab27eaf3 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -2782,6 +2782,8 @@ usb_1: usb@a6f8800 {
>                                         <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3 0>;
>                         interconnect-names = "usb-ddr", "apps-usb";
>
> +                       wakeup-source;
> +

The patch documenting this property has landed in commit 416b61893860
("dt-bindings: usb: qcom,dwc3: add wakeup-source property"). I guess
the only question is whether this should be in the general sc7180
device tree file or just for trogdor. Any chance it could cause
problems for devices that aren't designed like trogdor?
