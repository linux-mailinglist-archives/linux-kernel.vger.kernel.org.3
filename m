Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B9857FB7B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbiGYIjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiGYIjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:39:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D341814021;
        Mon, 25 Jul 2022 01:39:34 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0577766015E7;
        Mon, 25 Jul 2022 09:39:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658738373;
        bh=ojpTXZTQJqDfEMFXIHLgukOi8M5NtPDHqx0YNvu4X4o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TvNY0IfDDfipUKcc1jXZRjpHzoa3j4G/O1NkQ4sgngOH2OUuZoa8DAA9KnmF/Meg0
         Ikb6dW4HTsdZN/wc+djjkvYK7CqJwnVvmLuys0agsNns+iUXI3yqRQyyItE4GK5om8
         CebdaW8fzwoz0RXkGi9r+RailDOmb2GITE1G7d358w1SYqArLOlyjKmBIL1SMQjjqC
         LbJ29g0bRnUkNpK7JDp4AuaU34EiG8YEQIx5W95sJH5FCrbTDw0EsrvQkVdYccpmDV
         wIdK/zCmtq61WqVXju9Jb6rUKXsMm+lpJFAw9SDVZbwaN33sXh7L++nOzk6S9W5oEP
         qBMLpOu12stEw==
Message-ID: <5856610d-510f-46dc-63b2-79e571956a7c@collabora.com>
Date:   Mon, 25 Jul 2022 10:39:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] arm64: dts: mt8173-oak: Switch to SMC watchdog
Content-Language: en-US
To:     Pin-yen Lin <treapking@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        Evan Benn <evanbenn@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20220725082447.2613231-1-treapking@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220725082447.2613231-1-treapking@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/07/22 10:24, Pin-yen Lin ha scritto:
> Switch to SMC watchdog because we need direct control of HW watchdog
> registers from kernel. The corresponding firmware was uploaded in
> https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/3405.
> 

There's a fundamental issue with this change, I think.

What happens if we run this devicetree on a device that does *not* have
the new(er) firmware?

The kernel *shall not* get broken when running on devices that are running
on older firmware, especially because that's what was initially supported
and what is working right now.

For this reason, I think that we should get some code around that checks
if the SMC watchdog is supported and, if not, resort to MMIO wdog.

Regards,
Angelo


> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
> 
>   arch/arm64/boot/dts/mediatek/mt8173.dtsi | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index a2aef5aa67c1..2d1c776740a5 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -528,10 +528,8 @@ power-domain@MT8173_POWER_DOMAIN_MFG {
>   			};
>   		};
>   
> -		watchdog: watchdog@10007000 {
> -			compatible = "mediatek,mt8173-wdt",
> -				     "mediatek,mt6589-wdt";
> -			reg = <0 0x10007000 0 0x100>;
> +		watchdog {
> +			compatible = "arm,smc-wdt";
>   		};
>   
>   		timer: timer@10008000 {
> 


