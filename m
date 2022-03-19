Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1282C4DEA00
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 19:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243862AbiCSSVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 14:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242170AbiCSSVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 14:21:08 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B3919A558
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 11:19:46 -0700 (PDT)
Received: from [192.168.1.101] (abxi119.neoplus.adsl.tpnet.pl [83.9.2.119])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id A90313F696;
        Sat, 19 Mar 2022 19:19:44 +0100 (CET)
Message-ID: <7575fca0-28dd-427c-022f-6087fbd7a34b@somainline.org>
Date:   Sat, 19 Mar 2022 19:19:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 09/15] arm64: dts: qcom: msm8992-libra: Fix up the
 framebuffer
Content-Language: en-US
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220319174645.340379-1-konrad.dybcio@somainline.org>
 <20220319174645.340379-10-konrad.dybcio@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220319174645.340379-10-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.03.2022 18:46, Konrad Dybcio wrote:
> Make sure the necessary clocks are kept on after clk_cleanup (until MDSS
> is properly handled by its own driver) and touch up the fb address to
> prevent some weird shifting. It's still not perfect, but at least the
> kernel log doesn't start a third deep into your screen..
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  .../arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
> index e638fc489539..4e06641eb384 100644
> --- a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
> @@ -29,13 +29,25 @@ chosen {
>  		#size-cells = <2>;
>  		ranges;
>  
> -		framebuffer0: framebuffer@3404000 {
> +		framebuffer0: framebuffer@3403f48 {
Actually it turns out that 0x3400000 should be the address here and 2 lines below,
instead of 0x3403f48 (thanks Stephan & lk2nd!)..

If you don't mind this janky way of sending a fixup patch (resending a series of 15 seems a bit over the top), here's the fixed version:



From e01cb8b11d42e5885998faca3964b029563174e8 Mon Sep 17 00:00:00 2001
From: Konrad Dybcio <konrad.dybcio@somainline.org>
Date: Sat, 19 Mar 2022 17:32:25 +0100
Subject: [PATCH] arm64: dts: qcom: msm8992-libra: Fix up the framebuffer

Make sure the necessary clocks are kept on after clk_cleanup (until MDSS
is properly handled by its own driver) and touch up the fb address to
prevent some weird shifting.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
index e638fc489539..7748b745a5df 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
+++ b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
@@ -29,13 +29,25 @@ chosen {
                #size-cells = <2>;
                ranges;
 
-               framebuffer0: framebuffer@3404000 {
+               framebuffer0: framebuffer@3400000 {
                        compatible = "simple-framebuffer";
-                       reg = <0 0x3404000 0 (1080 * 1920 * 3)>;
+                       reg = <0 0x3400000 0 (1080 * 1920 * 3)>;
                        width = <1080>;
                        height = <1920>;
                        stride = <(1080 * 3)>;
                        format = "r8g8b8";
+                       /*
+                        * That's a lot of clocks, but it's necessary due
+                        * to unused clk cleanup & no panel driver yet..
+                        */
+                       clocks = <&mmcc MDSS_AHB_CLK>,
+                                <&mmcc MDSS_AXI_CLK>,
+                                <&mmcc MDSS_VSYNC_CLK>,
+                                <&mmcc MDSS_MDP_CLK>,
+                                <&mmcc MDSS_BYTE0_CLK>,
+                                <&mmcc MDSS_PCLK0_CLK>,
+                                <&mmcc MDSS_ESC0_CLK>;
+                       power-domains = <&mmcc MDSS_GDSC>;
                };
        };
 
-- 
2.35.1
