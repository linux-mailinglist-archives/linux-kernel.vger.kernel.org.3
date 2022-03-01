Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5EC4C8AE7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 12:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbiCALgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 06:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiCALgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:36:45 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B679091AD4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 03:36:01 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 176AB3F1A7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 11:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646134560;
        bh=FR+SbHRa0KC8qQpAb/sagwLABgKAHd7lv9qTbcr0XM0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Q8iO6kBWTS8gsLGw+O0aetXjEQItnmRenQdKR6JylMt9w/ghPdhMIdCaXJUk4PmHN
         Bs0yAvcR8w6/ZpRBV0oQhVoZhQSARgvVti4oxUGRXr6psilKuvNlLl1cGNFHOVY1l3
         kdmzj7O09W8DUMhfnYtAWQuqf5dZmM0QiOEhEKJDQxMm+bhn79g5sRBFgunYBSdz+e
         jIcgi2zU+gFm6ZpKt59vL87RtDQ05i2tzmauukGnnDOIdsDYwYBgsNMWdIK45Uzmc0
         GMeI7dOFHargywAvvONpFrvyH/O+GEAElsOAPWOQI9nuLN1JMn2TQWJRgo2WkVCiOu
         b1TenU+3r6gow==
Received: by mail-ej1-f72.google.com with SMTP id hq34-20020a1709073f2200b006d677c94909so3575362ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 03:36:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FR+SbHRa0KC8qQpAb/sagwLABgKAHd7lv9qTbcr0XM0=;
        b=hZZiDEzt1y5mOhFPX66vyhQBGVkiPjxcNWx2uNOQOPn0MQEkQoI0UEvzQtFd+Uv1jX
         8LN3r/BveTyN3K/vUFDpA9N6FQVgoO9QsTTeshFBXz/VLue7Ru97Yd6obUhQRRKbMnZl
         0P0AGZXsO30S92cFVUKrHTv8ZIDTzVVty8NPRtaIelyxrtfmyhWwOcoWv7JerBgPWW1k
         dk3YT8iGyFCkgrTXeqaH7t2/UJRHtB0NPU1ek4BYmDhRVFO7FORWXLe1oGklqyx69lno
         Tu4CezY5J0cBtI81yTPQllCxLT81hA0tkP6YSruPTTFIgWgWJ+nKaAntpUk1Nlmze8bB
         rZTQ==
X-Gm-Message-State: AOAM5318/m/QEaaQnx3Z3Q5U69lPs/RfRB9rbL6ssxvMb7VtEJXzRpBp
        fXBZDJiI9UpTMLZTQjiaCdW9sVWVTaYMpqzMKFW8V8XJfZhIM3lJSuirTlRLDknjW8Y2ycmZ2xg
        rnOspOXqb66xpVLeBAwl69hUCYos4mM70T6XUDS7ezQ==
X-Received: by 2002:aa7:d2da:0:b0:410:b9f1:ff35 with SMTP id k26-20020aa7d2da000000b00410b9f1ff35mr24361358edr.217.1646134559805;
        Tue, 01 Mar 2022 03:35:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxO1Re57fRymXGOQld9AekbmcAN8BBIo9RFZ7jtwa+7Mxv++/eT4zsN40e6JUE1cz8Fwj5FFQ==
X-Received: by 2002:aa7:d2da:0:b0:410:b9f1:ff35 with SMTP id k26-20020aa7d2da000000b00410b9f1ff35mr24361344edr.217.1646134559639;
        Tue, 01 Mar 2022 03:35:59 -0800 (PST)
Received: from [192.168.0.136] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id gg38-20020a17090689a600b006ba4896f2d7sm5253927ejc.140.2022.03.01.03.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 03:35:59 -0800 (PST)
Message-ID: <02d97f5a-b711-6e7e-abd5-ab2387dc3bca@canonical.com>
Date:   Tue, 1 Mar 2022 12:35:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V1] arm64: dts: qcom: sc7280: Add GCC hardware register dt
 entry
Content-Language: en-US
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org
Cc:     quic_asutoshd@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1646133123-22256-1-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1646133123-22256-1-git-send-email-quic_c_sbhanu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2022 12:12, Shaik Sajida Bhanu wrote:
> Add GCC hardware register dt entry for eMMC and SD card.

Aren't you adding reset, not a hardware register? The same in subject.

> 
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index c07765d..2b8461d 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -881,6 +881,9 @@
>  			mmc-hs400-1_8v;
>  			mmc-hs400-enhanced-strobe;
>  
> +			/* Add dt entry for gcc hw reset */

This comment seems unrelated and duplicating commit msg. Basically you
wrote same sentence four times: subject, commit msg and twice here...

> +			resets = <&gcc GCC_SDCC1_BCR>;
> +			reset-names = "core_reset";
>  			sdhc1_opp_table: opp-table {
>  				compatible = "operating-points-v2";
>  
> @@ -2686,6 +2689,9 @@
>  
>  			qcom,dll-config = <0x0007642c>;
>  
> +			/* Add dt entry for gcc hw reset */

Ditto.

> +			resets = <&gcc GCC_SDCC2_BCR>;
> +			reset-names = "core_reset";
>  			sdhc2_opp_table: opp-table {
>  				compatible = "operating-points-v2";
>  


Best regards,
Krzysztof
