Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C513B584D22
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbiG2IGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbiG2IGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:06:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF9713D5A;
        Fri, 29 Jul 2022 01:06:50 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B57726601B60;
        Fri, 29 Jul 2022 09:06:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659082009;
        bh=tYySmgjWp/6y/bcrBAfoaiavL/NRLu2X5y8IVqdmHe0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QjwkqyeRqidTyYkvq1VvUujFlgVHE8C83paxdngMD0USYKmleJyVf8njOFjbheTrd
         JD9XUxghr1MXHphwmfTGUhpT2Etq0GXGMh9XREelZ5P9VWegn8S9GJu0UiIawf+l3Y
         gX5E5hs1UmJnz/rWmc/HT0KFqZAXRjPFHIfpDV8yzxDJ4lNdrTCwe3B8w0mxmfAGxr
         nhowyY89YEDW9L0j/BpsmD0x0DriJQuxdEz4VoUuQWeAfu2+W4XrFWboDIGjvgR5xM
         FhP4Pc7vz4Ltu7/PRygrW9uOsvqA5HhZhXQv178ZgpX7DV75AmZvg/t2pcTq9Mngmg
         GaBC+vhItNVjQ==
Message-ID: <0bcc1575-2c43-8843-8edd-8b73ddc4d0fb@collabora.com>
Date:   Fri, 29 Jul 2022 10:06:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 03/20] dt-bindings: power: mediatek: Refine multiple
 level power domain nodes
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>
Cc:     iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220729063208.16799-1-tinghan.shen@mediatek.com>
 <20220729063208.16799-4-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220729063208.16799-4-tinghan.shen@mediatek.com>
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

Il 29/07/22 08:31, Tinghan Shen ha scritto:
> Extract duplicated properties and support more levels of power
> domain nodes.
> 
> This change fix following error when do dtbs_check,
>      arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: power-controller: power-domain@15:power-domain@16:power-domain@18: 'power-domain@19', 'power-domain@20', 'power-domain@21' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	 From schema: Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

