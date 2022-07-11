Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D6B56FEAB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiGKKPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbiGKKON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:14:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C584AD5F;
        Mon, 11 Jul 2022 02:34:23 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2123466017A6;
        Mon, 11 Jul 2022 10:34:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657532061;
        bh=Q8aXS7UAPdgDFOD5KMy8Y+lPX5el8z3AKk3/QrPYySU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AtWudmr9LZIkFa+8leH6uC+sN6AJCdvs4MfWhRxTqrlvkN3Mb4bldFyF6Qjg38G+Z
         o8nmVmTlnQuEOehEi4YiB/5ysQvxGoDkZLKs+3l8k7WpM4qks1F8T1EikTiRkFE792
         Y+AfNo0YyPSqHlGjfxd5CSBstPbJTEJTD99EDL9ZW2lKs/ik+L9JAL0BnIZp9mNLR8
         SxmQgsOZPKw7Pio+BNIqEkxngpq6ayihUpW0ZuxBo0fQ+0kXb2Mh0VNJkiauwlegHZ
         YVVoQ/dWpTSrqL75a6Zy3F9nseIjfaZzBpnb44O+c7Hx2hI10z89jM8YZDDd5WHL9x
         m+7x/+70DCqVA==
Message-ID: <5a4e0bfe-e332-42af-5888-b59b3afff24d@collabora.com>
Date:   Mon, 11 Jul 2022 11:34:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] arm64: dts: mediatek: Add missing xHCI clocks for mt8192
 and mt8195
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220708194314.56922-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220708194314.56922-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/07/22 21:43, Nícolas F. R. A. Prado ha scritto:
> The MediaTek xHCI dt-binding expects a specific order for the clocks,
> but the mt8192 and mt8195 devicetrees were skipping some of the middle
> clocks. These clocks are wired to the controller hardware but aren't
> controllable.
> 
> Add the missing clocks as handles to fixed clocks, so that the clock
> order is respected and the dtbs_check warnings are gone.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> A previous attempt to solve this also made all clocks required and
> updated all MediaTek DTs using the xhci binding [1].
> 
> To avoid the DT change noise, the binding change is now being reverted
> [2] and only mt8192 and mt8195 DTs are updated in this commit to get rid
> of the warnings.
> 
> [1] https://lore.kernel.org/all/20220623193702.817996-4-nfraprado@collabora.com/
> [2] https://lore.kernel.org/all/20220708192605.43351-1-nfraprado@collabora.com
> 
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi |  9 ++++++---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 18 ++++++++++++++----
>   2 files changed, 20 insertions(+), 7 deletions(-)
