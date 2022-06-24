Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C095597BD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 12:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiFXKVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 06:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiFXKVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 06:21:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746AA7C503;
        Fri, 24 Jun 2022 03:21:34 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1CE1F66017E1;
        Fri, 24 Jun 2022 11:21:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656066093;
        bh=XiQqaDDVsr9ct3XTN5uUy3VFBouJw2oayLQC2BD4/ig=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=B5+Qof2yy7qYYHlV/E/zYtNZe9KOOGts0UL40hc5pHask88etXUGsINGHgCieqMcR
         AwODsgtze+9SM0LRZgskDgBWfDJIYbP4iGXlTWHpoV3KTVtkCpVsSw9nc0cdAz2Bhv
         XFFAAzQ+OO2DDPIuBMa2k+ZvSyLmzR6esYY+r0GqDrnK+h3N53uVw+V/HLcsOr5PlL
         LcAuPwJK8wlHvz9Pt6Hz3GatnFdLsjGtzn1ie40TwLmB17LL0GviBJ/GH0XWUAXUO6
         kpnW13gwDPutFDHN4o293k04vXkbW0xQuQR+mH32ICYQmgy+I2ChtOy5oZ0Y59hN+I
         wIdGa+eZ2VcDQ==
Message-ID: <cb36b4a2-86b0-630c-8012-d1df1b0a42de@collabora.com>
Date:   Fri, 24 Jun 2022 12:21:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/7] MediaTek Helio X10 MT6795 - MT6331/6332 PMIC Wrapper
Content-Language: en-US
To:     lee.jones@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, zhiyong.tao@mediatek.com,
        henryc.chen@mediatek.com, johnson.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220520124039.228314-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220520124039.228314-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/05/22 14:40, AngeloGioacchino Del Regno ha scritto:
> In an effort to give some love to the apparently forgotten MT6795 SoC,
> I am upstreaming more components that are necessary to support platforms
> powered by this one apart from a simple boot to serial console.
> 
> This series introduces support in the PMIC Wrapper for a different PMIC
> topology, which is commonly found on smartphone boards, using one main
> PMIC and one Companion PMIC;
> be aware that this kind of topology is not *specific to* the Helio X10
> SoC, but common across many kinds of MediaTek smartphone oriented SoCs
> and board designs.
> 
> That said, support for the PMIC combo MT6331+MT6332 is provided in this
> series in a form that will be able to initialize the PMICs with crypto
> and DualIO but nothing else: these PMICs are very featureful, so I have
> decided to add this support in more than just one step, as there will
> be multiple patches for multiple different subsystems (..it's a mfd!..).
> 
> Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.
> 
> AngeloGioacchino Del Regno (7):
>    soc: mediatek: pwrap: Move PMIC read test sequence in function
>    soc: mediatek: pwrap: Add kerneldoc for struct pwrap_slv_type
>    soc: mediatek: mtk-pmic-wrap: Add support for companion PMICs
>    dt-bindings: mfd: Add compatible for MT6331 PMIC
>    soc: mediatek: mtk-pmic-wrap: Add support for MT6331 w/ MT6332
>      companion
>    dt-bindings: mediatek: pwrap: Add a compatible for MT6795 Helio X10
>    soc: mediatek: pwrap: Add support for MT6795 Helio X10
> 
>   .../devicetree/bindings/mfd/mt6397.txt        |   1 +
>   .../bindings/soc/mediatek/pwrap.txt           |   1 +
>   drivers/soc/mediatek/mtk-pmic-wrap.c          | 287 ++++++++++++++++--
>   3 files changed, 263 insertions(+), 26 deletions(-)
> 


Matthias, please, can you check this series?

This doesn't depend on any other series that I've sent and besides that,
Lee has acked the actual MFD PMIC code, so this should be good to go.

Thanks,
Angelo
