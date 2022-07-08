Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AACD56B4AA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbiGHIpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237239AbiGHIpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:45:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF45814B6;
        Fri,  8 Jul 2022 01:45:29 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CE32366015BA;
        Fri,  8 Jul 2022 09:45:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657269928;
        bh=nL4EphTxTGIn93JKt1KWZWPGficfXAV2gqP5apqt848=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=S/tslfd35NfROb1/gP9GcNLN4NQ/6dH9fx0Uy3IpVBAO3wpMiTDiLLgKG2TTw5UFO
         tVTnvB9Zg9WxJ3bhEcmLy4JNQI5Kct3gTnDyDoXo3SD7DNrrOBDHwj9j2KEf9Wp9Ow
         2URxBRLhdef2HoME8wIOdN9rlYFL3cdrq2QQ92yo9HPjitetMu1kz2G7hXlTh/ejP2
         J/nFmlvS6y4OMBHnHDdXLA1xU1TE2tmfAMO4iNtjimWyZJ0ZWlmTSIzUocq6+q20ZM
         ox8KOEf38ZCMM0r7xGUrckoJ7x1SjEMeNqCf2WFQcP/ui5uUc0KR3iDsVhORuYnJ9k
         1WnwqbQzoeBLA==
Message-ID: <217695f5-55d3-e347-ea04-d30aaee6e712@collabora.com>
Date:   Fri, 8 Jul 2022 10:45:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 0/2] MediaTek SoC ARM/ARM64 System Timer
Content-Language: en-US
To:     daniel.lezcano@linaro.org
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org
References: <20220613133819.35318-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220613133819.35318-1-angelogioacchino.delregno@collabora.com>
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

Il 13/06/22 15:38, AngeloGioacchino Del Regno ha scritto:
> In an effort to give some love to the apparently forgotten MT6795 SoC,
> I am upstreaming more components that are necessary to support platforms
> powered by this one apart from a simple boot to serial console.
> 
> This series introduces support to start the System Timer for the CPU
> cores found in various MediaTek SoCs including, but not limited to the
> MT6795 Helio X10 - and will most probably unblock many developers for
> the upstreaming of various platforms.
> 
> For a broad overview of why/what/when, please look at the description
> of patch [2/2] in this series.
> 
> Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.
> 
> Changes in v4:
>   - Changed statement in documentation, now saying:
>     "MediaTek SoCs have different timers on different platforms"
> 
> Changes in v3:
>   - Merged mtk_cpux_{enable,disable}_irq() as one mtk_cpux_set_irq() function
>     as suggested by Matthias
> 
> Changes in v2:
>   - Added back a lost line in commit 2/2 (sorry, commit didn't get amended...!)
>   - Tested again for safety
> 
> AngeloGioacchino Del Regno (2):
>    dt-bindings: timer: mediatek: Add CPUX System Timer and MT6795
>      compatible
>    clocksource/drivers/timer-mediatek: Implement CPUXGPT timers
> 
>   .../bindings/timer/mediatek,mtk-timer.txt     |   6 +-
>   drivers/clocksource/timer-mediatek.c          | 114 ++++++++++++++++++
>   2 files changed, 119 insertions(+), 1 deletion(-)
> 


Gentle ping for this one - I need it to start upstreaming devicetrees for
that MT6795 Xperia M5 smartphone, or it won't be able to boot.

Thanks,
Angelo
