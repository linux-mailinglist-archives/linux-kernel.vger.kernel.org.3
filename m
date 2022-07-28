Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20AC583D50
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbiG1LYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236948AbiG1LYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:24:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6024867CB9;
        Thu, 28 Jul 2022 04:21:47 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 49FEE6601B43;
        Thu, 28 Jul 2022 12:21:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659007305;
        bh=cQKa4cD8+Dc8uivpLk6aRVwpns1CsSwbo+ldgdagj1g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WSBPIdgbeM9yM9T8Rey7+jygYbHH7L6TwPmQFrJ3SlBTQwx4Lo3qnurhN8zy2+Fef
         TsObUv0p9KZHI2pRs72OVlwWSSgOPKBBE/qsNnVhPK2JZsEHCQL5VsTgW2ySr4Abio
         dAhGWWa1Al86qwOxaZbTiYKSmrmu/H/vcqUMzFUSt7p4c+2VFjVFka8DasdqPBVsAP
         OAK8xoAQp+4IyIjtszy1/Tw2Bmfjd66nZzwtQYFsJSAyuOGTSxNUNtPJm1EwxSsuFE
         /dUpJxahzl/ZhGPMrh5FHxvUwkghSbY2tTBAgxmFrS+QzebY8hsamBrHTAjGRALmwG
         sqxJNc8hVyi7Q==
Message-ID: <c455adea-2d18-60af-7175-a4e283e3dcb8@collabora.com>
Date:   Thu, 28 Jul 2022 13:21:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] arm64: dts: mt8173-oak: Switch to SMC watchdog
Content-Language: en-US
To:     Pin-yen Lin <treapking@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Eizan Miyamoto <eizan@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Evan Benn <evanbenn@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20220727094034.1372745-1-treapking@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220727094034.1372745-1-treapking@chromium.org>
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

Il 27/07/22 11:40, Pin-yen Lin ha scritto:
> Switch to SMC watchdog because we need direct control of HW watchdog
> registers from kernel. The corresponding firmware was uploaded in
> https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/3405.
> 
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
> 
> Changes in v2:
> - Move the modifications to mt8173-elm.dtsi and add some comments.
> 
>   arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> index e21feb85d822..b2269770abc3 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> @@ -161,6 +161,18 @@ hdmi_connector_in: endpoint {
>   			};
>   		};
>   	};
> +
> +	soc {
> +		/*
> +		 * Disable the original MMIO watch dog and switch to the SMC watchdog,
> +		 * which operates on the same MMIO.
> +		 */
> +		/delete-node/ watchdog@10007000;

Unfortunately, we're not quite there yet.
The comment is fine, but...

There's no need to /delete-node/: you can just do it like

/*
  * Disable the original MMIO watch dog and switch to the SMC watchdog,
  * which operates on the same MMIO.
  */
&watchdog {
	status = "disabled";
};

and...

> +
> +		watchdog {

This isn't addressable, hence it belongs to the root node, not to soc.
If you did that because of naming issues, I would propose to call it
smc-watchdog instead of watchdog.


> +			compatible = "arm,smc-wdt";

P.S.: No timeout-sec?

Regards,
Angelo

> +		};
> +	};
>   };
>   
>   &mfg_async {
> 

