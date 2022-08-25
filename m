Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46DD5A1B32
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 23:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbiHYVhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 17:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiHYVhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:37:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50926C12E6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661463463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lzEVWEer35cPw5JxPAMEkuVirS7s66tnd49q7q+1wOU=;
        b=jWEH/nqJ7BNnYL+ioNGhljYHvs3NLFGxfXdZUmXcC/jYdXPcaGprfpR6/PVYvgbkvHdfgC
        U6dTD8ri17SdMYFK7D8d0/xfHBOIODYEC/VyKGaTmtYZRqH+Lg/5y6WUU5P08nYlM0vMZD
        pLNhOzareo3f+99N18CoqC+h3vZOUz0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-140-eChKvDtIPcmuH1WyQZIX5w-1; Thu, 25 Aug 2022 17:37:42 -0400
X-MC-Unique: eChKvDtIPcmuH1WyQZIX5w-1
Received: by mail-qt1-f199.google.com with SMTP id cj19-20020a05622a259300b003446920ea91so16190080qtb.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=lzEVWEer35cPw5JxPAMEkuVirS7s66tnd49q7q+1wOU=;
        b=TH8eD984x++yxM/os/arL3TKCxYG2MU8j19+v8lEM0ojuMzPejNx4JyR5NhbMzvu+y
         vx3L2m6/McUVs+yexL6mWAhYHCinVYeuon8Ir0QvZ2VBlrHvaKWGPJsAhHxtU4UB83Pw
         hrHLDGYA+DzO+uLScRmharOD49mad9WTT6pfToqAoGGiroRrlp2RaX1SEf38UYRAcb0R
         BwqQ4vt6IWJ5mgGiYqSUVGUSssHFioNl7BGhw3Vc0cBkNUYZRkH2Ux9L/lVfpK1IoNzG
         VM7PBpqab9COGIo3GoUK/CJ8Hbwq+PgwYQ70VNGpSRT8NNR2+TdCiiRqTXOo4xQtKR3/
         29XA==
X-Gm-Message-State: ACgBeo3XVllfyynX6fR7rERhCIj66ZQFPY3nry+bW74Z0ZPuE5G5ShGW
        hOD+G2DSXKSfvZ7/ZZfoJoi+m4GTiJ4WYNOwHEL5JIqkprq/0NJv6nDlq1MzfeCTKG8tJl6+ya0
        ohp/Sr1pI+WK8YVoVGpThwAHs
X-Received: by 2002:ac8:5c01:0:b0:344:90a5:b662 with SMTP id i1-20020ac85c01000000b0034490a5b662mr5481424qti.83.1661463461892;
        Thu, 25 Aug 2022 14:37:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4QAyVIIBu73nK0OKgNU1pWRJHgisQlO3B+CGHhuD9BcLuLp2NCQjg1PAJFo9ThttFfHFMpaw==
X-Received: by 2002:ac8:5c01:0:b0:344:90a5:b662 with SMTP id i1-20020ac85c01000000b0034490a5b662mr5481402qti.83.1661463461679;
        Thu, 25 Aug 2022 14:37:41 -0700 (PDT)
Received: from halaneylaptop ([2600:1700:1ff0:d0e0::48])
        by smtp.gmail.com with ESMTPSA id x1-20020ac86b41000000b00342f8984348sm18061qts.87.2022.08.25.14.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 14:37:41 -0700 (PDT)
Date:   Thu, 25 Aug 2022 16:37:39 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] arm64: dts: qcom: sc8280xp-thinkpad-x13s: Specify
 which LDO modes are allowed
Message-ID: <20220825213739.undn5q2ybzevtbtf@halaneylaptop>
References: <20220825164205.4060647-1-dianders@chromium.org>
 <20220825094155.4.I897770a7ac41f8dc3e37dfed12102bacdbf9da56@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825094155.4.I897770a7ac41f8dc3e37dfed12102bacdbf9da56@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 09:42:02AM -0700, Douglas Anderson wrote:
> This board uses RPMH, specifies "regulator-allow-set-load" for LDOs,
> but doesn't specify any modes with "regulator-allowed-modes".
> 
> Prior to commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
> get_optimum_mode(), not set_load()") the above meant that we were able
> to set either LPM or HPM mode. After that commit (and fixes [1]) we'll
> be stuck at the initial mode. Discussion of this has resulted in the
> decision that the old dts files were wrong and should be fixed to
> fully restore old functionality.
> 
> Let's re-enable the old functionality by fixing the dts.
> 
> [1] https://lore.kernel.org/r/20220824142229.RFT.v2.2.I6f77860e5cd98bf5c67208fa9edda4a08847c304@changeid
> 
> Fixes: 32c231385ed4 ("arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad X13s devicetree")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
> 
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 16c6e4d920bb..0c2534b4ec24 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -80,6 +80,9 @@ vreg_l3b: ldo3 {
>  			regulator-max-microvolt = <1200000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-allow-set-load;
> +			regulator-allowed-modes =
> +			    <RPMH_REGULATOR_MODE_LPM
> +			     RPMH_REGULATOR_MODE_HPM>;
>  			regulator-boot-on;
>  		};
>  
> @@ -89,6 +92,9 @@ vreg_l4b: ldo4 {
>  			regulator-max-microvolt = <912000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-allow-set-load;
> +			regulator-allowed-modes =
> +			    <RPMH_REGULATOR_MODE_LPM
> +			     RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l6b: ldo6 {
> @@ -97,6 +103,9 @@ vreg_l6b: ldo6 {
>  			regulator-max-microvolt = <880000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-allow-set-load;
> +			regulator-allowed-modes =
> +			    <RPMH_REGULATOR_MODE_LPM
> +			     RPMH_REGULATOR_MODE_HPM>;
>  			regulator-boot-on;
>  			regulator-always-on;	// FIXME: VDD_A_EDP_0_0P9
>  		};
> @@ -112,6 +121,9 @@ vreg_l1c: ldo1 {
>  			regulator-max-microvolt = <1800000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-allow-set-load;
> +			regulator-allowed-modes =
> +			    <RPMH_REGULATOR_MODE_LPM
> +			     RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l12c: ldo12 {
> @@ -120,6 +132,9 @@ vreg_l12c: ldo12 {
>  			regulator-max-microvolt = <1800000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-allow-set-load;
> +			regulator-allowed-modes =
> +			    <RPMH_REGULATOR_MODE_LPM
> +			     RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l13c: ldo13 {
> @@ -128,6 +143,9 @@ vreg_l13c: ldo13 {
>  			regulator-max-microvolt = <3072000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-allow-set-load;
> +			regulator-allowed-modes =
> +			    <RPMH_REGULATOR_MODE_LPM
> +			     RPMH_REGULATOR_MODE_HPM>;
>  		};
>  	};
>  
> @@ -143,6 +161,9 @@ vreg_l3d: ldo3 {
>  			regulator-max-microvolt = <1200000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-allow-set-load;
> +			regulator-allowed-modes =
> +			    <RPMH_REGULATOR_MODE_LPM
> +			     RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l4d: ldo4 {
> @@ -151,6 +172,9 @@ vreg_l4d: ldo4 {
>  			regulator-max-microvolt = <1200000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-allow-set-load;
> +			regulator-allowed-modes =
> +			    <RPMH_REGULATOR_MODE_LPM
> +			     RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l7d: ldo7 {
> @@ -159,6 +183,9 @@ vreg_l7d: ldo7 {
>  			regulator-max-microvolt = <3072000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-allow-set-load;
> +			regulator-allowed-modes =
> +			    <RPMH_REGULATOR_MODE_LPM
> +			     RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l9d: ldo9 {
> @@ -167,6 +194,9 @@ vreg_l9d: ldo9 {
>  			regulator-max-microvolt = <912000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-allow-set-load;
> +			regulator-allowed-modes =
> +			    <RPMH_REGULATOR_MODE_LPM
> +			     RPMH_REGULATOR_MODE_HPM>;
>  		};
>  	};
>  };
> -- 
> 2.37.2.672.g94769d06f0-goog
> 

