Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415244AB66F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343995AbiBGIQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241772AbiBGIPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:15:00 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930A9C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 00:14:58 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id y6-20020a7bc186000000b0037bdc5a531eso64006wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 00:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=fczIWa54IaZDc4T1CWGAuqTrmTb2eOKwrkRnh84PvKY=;
        b=7DQlnj++q+oWqpt0+suM56O/9jbGYLBVZ9uG389OK4Z14l6csp4EzWcanXR+trSHGW
         B4WZ7GlfBYkC0hu3irlq/aSadsOLk581sk427DrgitunJVRUx9upQNOsS3nFBmAWK1kH
         LRVNTpYViSIHQ7FUdCntexsSOnZPguuYS3ycpDA83CPjHHh863fgGnlFIt5Czll35dXT
         y5CA/S6q00nfwTA6cYjeNRPqS6ubRF1hOkXM/5nY+6gNdE8uxAeBYJlQ7rY5Lb0Wab2w
         81hcBoCIeiSvq5WMBaPebyRazK2K0x9Q1zI6oNCBvaJ1eXCBHZhg/GnbnpiIUTvW/JmO
         UbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=fczIWa54IaZDc4T1CWGAuqTrmTb2eOKwrkRnh84PvKY=;
        b=F+9gehg0hFSVYoDJMvfSR3y/p2xMu020ioXdLu5CcTmsWnXX2t3BKbwzavpnMi70hb
         mGCYSoMV87WtfVV2xRBSENw/Hpw7I2sbi418xfuCpro6hyVsgrWUbSiLuFvO0/TSgrxg
         oMoZBqfaLgr21+59JIRopaMJRD4DrS/3cEx8pGXBU4eWbcXtJKgDBD+4DbjiAkSO8F0N
         9ZrJIC36JqICTxrAzt8ib4o12brBHfp/CcFCWsp0ArOpn3IR9KIgNw0wOfegThUOCmE+
         M83oIBti+a53Fn9uBUGmJsT1VBYPT1NHf8CvWnqm2IXGSk3CuKxZ83iCS0lM4g6VcQEX
         i0Uw==
X-Gm-Message-State: AOAM532IXk0TokNRByVfaNWZTwXtBYDsOxo5rFKYFvV+u5ZosJV6gK+i
        ZEwEOTM38u7uzif9smVCFPrhgA==
X-Google-Smtp-Source: ABdhPJyp3Dsj/2D1xPD5Qeeh8DKBvGDfrGuqnqvdGnd5qSAnPA2vA2jzi7lVA+gJhKbpWfAEfBP4Ow==
X-Received: by 2002:a05:600c:34c6:: with SMTP id d6mr13602354wmq.103.1644221697111;
        Mon, 07 Feb 2022 00:14:57 -0800 (PST)
Received: from ?IPV6:2001:861:44c0:66c0:b2bb:1b67:73da:334d? ([2001:861:44c0:66c0:b2bb:1b67:73da:334d])
        by smtp.gmail.com with ESMTPSA id u19sm8286068wmm.39.2022.02.07.00.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 00:14:56 -0800 (PST)
Message-ID: <42c51f9d-d122-2d09-cdcd-f733cbc60d5b@baylibre.com>
Date:   Mon, 7 Feb 2022 09:14:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] add pmu to amlogic meson sm1
Content-Language: en-US
To:     Benjamin Mordaunt <crawford.benjamin15@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220205234554.4403-1-crawford.benjamin15@gmail.com>
 <20220206144343.2194-1-crawford.benjamin15@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220206144343.2194-1-crawford.benjamin15@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/02/2022 15:43, Benjamin Mordaunt wrote:
> ---
> The dts for meson sm1 appears to omit the SoC's PMU,
> which is essential for accessing perf events regarding
> e.g. cache on e.g. the Odroid C4 platform. Add it.
> 
>   arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> index 3d8b1f4f2..4147eecd2 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> @@ -6,6 +6,8 @@
>   
>   #include "meson-g12-common.dtsi"
>   #include <dt-bindings/clock/axg-audio-clkc.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/power/meson-sm1-power.h>
>   #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
>   #include <dt-bindings/reset/amlogic,meson-g12a-audio-reset.h>
> @@ -90,7 +92,16 @@ l2: l2-cache0 {
>   			compatible = "cache";
>   		};
>   	};
> -
> +	
> +	arm-pmu {
> +		compatible = "arm,cortex-a55-pmu";
> +		interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> +	};
> +	
>   	cpu_opp_table: opp-table {
>   		compatible = "operating-points-v2";
>   		opp-shared;

Please see Marc's comments about PMU support:
http://lore.kernel.org/r/8735pcq63o.wl-maz@kernel.org

Neil
