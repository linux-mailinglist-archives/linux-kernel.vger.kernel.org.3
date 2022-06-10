Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2706054663B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347471AbiFJMEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241046AbiFJMEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:04:05 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174AE36E1C;
        Fri, 10 Jun 2022 05:04:01 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2142C60008;
        Fri, 10 Jun 2022 12:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654862639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wk/jtq8xnieuXpnFHV28FbZhaagmc7D9cxAaLwaoz9Y=;
        b=CYs4u8lBEb8T+7VflaieA4F8cQQ+Wv8XFP5a/KeI75L8Lulgv/WMPFpaLVkcv17QBvKyhg
        03amMT0xX+/StH3JDr4WY276TWhEPhsQT4TRU7UjBxh7qaUx9++aDUv0KPSd5xYZ8em+Ks
        k/oujVqIwLA/wMQBb4YBQr701dNHLLcG51tvgbmXG9tm+w6FrBVd6/dUn2zE7dw13jewa4
        XMZT9wL3Nr9GZskUdAYx3YNJxcEFeVmj1asPRMnHBMIxE0sXPKcXancUaxGpUmr3JEc7P+
        CkarAIjFkWTwuxglW+tKo2Hcy2ViMfe8J8/w00sWGiCjg7a2/XrvCLsb8ek1bw==
Date:   Fri, 10 Jun 2022 14:03:55 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@xilinx.com,
        sgoud@xilinx.com, shubhraj@xilinx.com, srinivas.neeli@amd.com,
        neelisrinivas18@gmail.com, devicetree@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@xilinx.com
Subject: Re: [PATCH V7 3/3] rtc: zynqmp: Updated calibration value
Message-ID: <YqMzK50DbPAm1+dl@mail.local>
References: <20220610113709.2646118-1-srinivas.neeli@xilinx.com>
 <20220610113709.2646118-3-srinivas.neeli@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610113709.2646118-3-srinivas.neeli@xilinx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2022 17:07:09+0530, Srinivas Neeli wrote:
> As per RTC spec default calibration value is 0x7FFF.
> 

Having that as a second patch breaks the calculation in your previous
patch, really, this should just be a single patch.

> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> ---
> Changes in V7:
> -New patch
> -TRM not updated yet, Internal design document contains 0x7FFF as
>  default value. TRM Will update in next release.
> ---
>  drivers/rtc/rtc-zynqmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
> index 39b23f88ee26..1dd389b891fe 100644
> --- a/drivers/rtc/rtc-zynqmp.c
> +++ b/drivers/rtc/rtc-zynqmp.c
> @@ -37,7 +37,7 @@
>  #define RTC_OSC_EN		BIT(24)
>  #define RTC_BATT_EN		BIT(31)
>  
> -#define RTC_CALIB_DEF		0x198233
> +#define RTC_CALIB_DEF		0x7FFF
>  #define RTC_CALIB_MASK		0x1FFFFF
>  #define RTC_ALRM_MASK          BIT(1)
>  #define RTC_MSEC               1000
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
