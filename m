Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40224E5054
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 11:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243536AbiCWKbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 06:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243497AbiCWKbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 06:31:22 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9CC23149;
        Wed, 23 Mar 2022 03:29:53 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o30-20020a05600c511e00b0038c9cfb79cbso2848784wms.1;
        Wed, 23 Mar 2022 03:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NPCBeK8EmlJTLX7b8VpEEv5X7dyNwlhHhnCggdFBrcE=;
        b=qCdS83+Qfa6n9umTyVz3zBeCN4SuOd83241gKDfei+pW0vIEpIF7/yBTmxVFUjunnX
         2hdou67Rw8yuOKtQjBGjB6l8T7axLIFyZM0rA8UxjHYIvCzYdWZ/OAngIna0jfD+/aVV
         quEtdxTe4Zt36sJLG3b9I/ZviguWfUVLrBMzNhJ9GLawtO/x1s3PI1mADTbR4G2U4g7I
         OKoHhF1Zdf8bbUJmXLPb3VjmaLqJUtSFTpaVmZULmjwaLBshuBMFp0pIPB8wfphmoTEF
         l9IfSpcuedD3pwQbVTtJF50DGCfV0wzMJUo81ikY320MwUIFf23hMTMv07XQKiP78GmT
         /l0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NPCBeK8EmlJTLX7b8VpEEv5X7dyNwlhHhnCggdFBrcE=;
        b=1b79UelmdjbTKPrGmk5hOigaFMQXnLtgGnLBQ1myc3ijRCyzXPUWTSf1SCNiQ/Ug9U
         PFmpyjjqQsYVTMlDRTpnPWV4P0yoygCiZHK8d/EIxrDvyz0dMaU50R2OAAm5xSJRWI6k
         npfz1mGJx74Cv2Bp0j3Hrq+WKVRRyWSf7EwDp9hroTFpWEr64uCGFBfEAXBCKJF+EJKZ
         nMIUODpDj4Gk/XCKG5BeEYAJCLzof4Av9NIEJbG9MIisbK3ITF6dUIct77Mq5iFaOl1a
         5mHFXDHFNIecEr0R3xw/vDCH1vk/guRXCdZB/0ezTBTGWO1JEr1mVVSoUrZ5J7fJaSUh
         SWCg==
X-Gm-Message-State: AOAM532CjHKGFhKbAUmmVkdPJx1Tzw5r3YErM2zDkOlaQexcDPyTWzcN
        iSy1T+E0heCVB3AnUOvgHUs=
X-Google-Smtp-Source: ABdhPJyHea6O2q1bz2HV4g4AFBLS35QU0I+LtFAlaTzAWOVC/Wo0vznM+u/mxodCJm04FmQER/vFyA==
X-Received: by 2002:a1c:c904:0:b0:38c:8dc1:87a3 with SMTP id f4-20020a1cc904000000b0038c8dc187a3mr8671232wmb.101.1648031391419;
        Wed, 23 Mar 2022 03:29:51 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.gmail.com with ESMTPSA id x13-20020adfec0d000000b00203ff46f802sm17017681wrn.36.2022.03.23.03.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 03:29:51 -0700 (PDT)
Date:   Wed, 23 Mar 2022 11:29:50 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 17/18] dt-bindings: arm: msm: Convert kpss-gcc driver
 Documentation to yaml
Message-ID: <Yjr2nkIrQ356DMUI@Ansuel-xps.localdomain>
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
 <20220321231548.14276-18-ansuelsmth@gmail.com>
 <1647913851.222685.941035.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647913851.222685.941035.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 08:50:51PM -0500, Rob Herring wrote:
> On Tue, 22 Mar 2022 00:15:47 +0100, Ansuel Smith wrote:
> > Convert kpss-gcc driver Documentation to yaml. Since kpss-gcc expose a
> > clock add the required '#clock-cells' binding while converting it.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ------------
> >  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 69 +++++++++++++++++++
> >  2 files changed, 69 insertions(+), 44 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/1607962
> 
> 
> clock-controller@2011000: '#clock-cells' is a required property
> 	arch/arm/boot/dts/qcom-ipq8064-ap148.dt.yaml
> 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dt.yaml
> 
> clock-controller@2011000: compatible:0: 'qcom,kpss-gcc' is not one of ['qcom,kpss-gcc-ipq8064', 'qcom,kpss-gcc-apq8064', 'qcom,kpss-gcc-msm8974', 'qcom,kpss-gcc-msm8960']
> 	arch/arm/boot/dts/qcom-ipq8064-ap148.dt.yaml
> 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dt.yaml
> 
> clock-controller@2011000: compatible:1: 'qcom,kpss-gcc' was expected
> 	arch/arm/boot/dts/qcom-ipq8064-ap148.dt.yaml
> 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dt.yaml
> 
> clock-controller@2011000: compatible: ['qcom,kpss-gcc', 'syscon'] is too short
> 	arch/arm/boot/dts/qcom-ipq8064-ap148.dt.yaml
> 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dt.yaml
> 

Sorry for the very stupid question but it's something i'm searching for
a bit now... I can't really find Documentation or a guide on how to
check single yaml and dts instead of using the make command and check
everything. Am I missing something or this is not supported?

-- 
	Ansuel
