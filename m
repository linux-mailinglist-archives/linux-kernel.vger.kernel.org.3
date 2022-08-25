Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7345A1B10
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 23:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242106AbiHYVbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 17:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbiHYVbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B2EBBA74
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661463060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LY0dJI+HK3FIyhOwsV0Ul5xZhYFbnAopq+3Lt6Gqi0I=;
        b=G1fqFeAHvps63Mn8tv5t4pkbwOc66+PonVVxXq2+x1IF07eUSMzPfeGVf9qhPgwJAGw6Ww
        YmFyDtGuuQ3DgW9K3fnqxk6eyAsDtfDcyDZ1RvKsmUYHTe6ne8XNBMFoMqZyKWtPAvx4fx
        pjT1az+CqCTRWakUeyj54VPhaUWVd90=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-164-G_XCS01SNzCqW37XTw7xOw-1; Thu, 25 Aug 2022 17:30:57 -0400
X-MC-Unique: G_XCS01SNzCqW37XTw7xOw-1
Received: by mail-qt1-f199.google.com with SMTP id cj19-20020a05622a259300b003446920ea91so16178999qtb.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=LY0dJI+HK3FIyhOwsV0Ul5xZhYFbnAopq+3Lt6Gqi0I=;
        b=XEC+3M8zAIGOi1mSoi5yr0ODc5lT0B2cX7vMYEqHF1qR9/nivgx3jXc3KKsQaC5vTM
         OgxlvDFAkldFlskp7Jx71laHpqijDEUOnNs4pzWGBMjkfUYy0eDmZlRn469KzzxghHdv
         7k1NlG4AWWFryXt8oS+x7cCZ0m2ScJqSqRF/h0DY3UpNPzY2t9KTWwosqFeNCC+BTWyW
         rNJ3Lp1ew3kOMM9/3R9imcz/ZqSmAsRIUyeEaftAwrGyOMBHMJm+Ve736KUhmHZdRjo5
         QbzN/g8b4N31R9UapbiWBaN9fgLOwNQ3occ/O8GTBxmaCFM8ufHbN8y0xagNgB3mkQl0
         58yA==
X-Gm-Message-State: ACgBeo1miiSc0tEQ5wmYciN+qlAB7O6sRxbiwR0Rn8tpVzUmK5Gt+Ibj
        ffW6Q93D+rwYC6aQxH6yk8jqYHS2GCEuRjUHcIzB4O75lWmScR539sGzHo9nk/Szo8eCozCwubc
        dXXZqKUGp3fRUANyhuvI6BaUt
X-Received: by 2002:ad4:5de2:0:b0:477:f5e6:e13 with SMTP id jn2-20020ad45de2000000b00477f5e60e13mr5423067qvb.31.1661463056660;
        Thu, 25 Aug 2022 14:30:56 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7xkZetSsMyk6rm1K+UpYZVkmzuXPO46vRqd+KLaE2CVCyFwQLP8z/A95Kj/ZKZzhHK07guDg==
X-Received: by 2002:ad4:5de2:0:b0:477:f5e6:e13 with SMTP id jn2-20020ad45de2000000b00477f5e60e13mr5423047qvb.31.1661463056397;
        Thu, 25 Aug 2022 14:30:56 -0700 (PDT)
Received: from halaneylaptop ([2600:1700:1ff0:d0e0::48])
        by smtp.gmail.com with ESMTPSA id m14-20020a05620a24ce00b006b9a89d408csm427775qkn.100.2022.08.25.14.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 14:30:55 -0700 (PDT)
Date:   Thu, 25 Aug 2022 16:30:53 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] arm64: dts: qcom: sa8155p-adp: Specify which LDO
 modes are allowed
Message-ID: <20220825213053.5xxiljfjkhnpy53p@halaneylaptop>
References: <20220825164205.4060647-1-dianders@chromium.org>
 <20220825094155.1.Id59c32b560c4662d8b3697de2bd494d08d654806@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825094155.1.Id59c32b560c4662d8b3697de2bd494d08d654806@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 09:41:59AM -0700, Douglas Anderson wrote:
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
> Fixes: 5b85e8f2225c ("arm64: dts: qcom: sa8155p-adp: Add base dts file")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> index ba547ca9fc6b..ddb9cb182152 100644
> --- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> @@ -43,7 +43,6 @@ vreg_s4a_1p8: smps4 {
>  
>  		regulator-always-on;
>  		regulator-boot-on;
> -		regulator-allow-set-load;

I could see this deserving its own commit or a line in the commit
message, but not a big deal to me:

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

>  
>  		vin-supply = <&vreg_3p3>;
>  	};
> @@ -137,6 +136,9 @@ vreg_l5a_0p88: ldo5 {
>  			regulator-max-microvolt = <880000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-allow-set-load;
> +			regulator-allowed-modes =
> +			    <RPMH_REGULATOR_MODE_LPM
> +			     RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l7a_1p8: ldo7 {
> @@ -152,6 +154,9 @@ vreg_l10a_2p96: ldo10 {
>  			regulator-max-microvolt = <2960000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-allow-set-load;
> +			regulator-allowed-modes =
> +			    <RPMH_REGULATOR_MODE_LPM
> +			     RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l11a_0p8: ldo11 {
> @@ -258,6 +263,9 @@ vreg_l5c_1p2: ldo5 {
>  			regulator-max-microvolt = <1200000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-allow-set-load;
> +			regulator-allowed-modes =
> +			    <RPMH_REGULATOR_MODE_LPM
> +			     RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l7c_1p8: ldo7 {
> @@ -273,6 +281,9 @@ vreg_l8c_1p2: ldo8 {
>  			regulator-max-microvolt = <1200000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-allow-set-load;
> +			regulator-allowed-modes =
> +			    <RPMH_REGULATOR_MODE_LPM
> +			     RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l10c_3p3: ldo10 {
> -- 
> 2.37.2.672.g94769d06f0-goog
> 

