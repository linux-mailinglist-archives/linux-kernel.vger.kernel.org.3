Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9470C528017
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242006AbiEPIvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiEPIvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:51:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D9D388B;
        Mon, 16 May 2022 01:51:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8F8C11F407CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652691107;
        bh=gV9kB7ivZNyAdhSFNP1wk4K4CwcgA76yv2I+a7JWfyg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YoFKzksDbBZNLg5EvKENN0GqsHSebAGPsYmisWzx/3PKbAn+FxzB1wSvHECYq75z0
         2CrtSBGa4usFd2gFvY35Ld/+ec2frrs6NJtvafPe8B4Z9/HQpDr1sLWIUFFRGNUazb
         c8z2LV3fPBryI42a//xFvhkD/8sIJIZldQGpGqzrX1uPidLBW6pKIzVBTliXJ3MQSY
         V0K470gXhu3Ydl9xoSWZKHUxGk1PrXWv0TwGBPu6hWb/GYj+6dRLSyvUtcgn1JHHqS
         Vh+QtQqE+jSuQgV8I2QLruXX35ODzyrRWauKwQSk3syvwBVq9FVD5bbi9dOp+JTzX6
         uXM5G0La9lXMA==
Message-ID: <0f303425-3b12-7573-b201-030d4d044db8@collabora.com>
Date:   Mon, 16 May 2022 10:51:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 5/7] arm64: dts: mediatek: mt6795: Add fixed clocks for
 32kHz and 26MHz XOs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
References: <20220513171617.504430-1-angelogioacchino.delregno@collabora.com>
 <20220513171617.504430-6-angelogioacchino.delregno@collabora.com>
 <03e99a02-1233-3882-e1e5-24ab1bbaf257@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <03e99a02-1233-3882-e1e5-24ab1bbaf257@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/05/22 09:10, Krzysztof Kozlowski ha scritto:
> On 13/05/2022 19:16, AngeloGioacchino Del Regno wrote:
>> Add the 32kHz and 26MHz oscillators as fixed clocks in devicetree to
>> provide a good initial clock spec, since this SoC features two always
> 
> I don't understand that part with actual patch. You claim here you add
> clocks, but in DTS they were already before.
> 
> Additionally, these clocks do not belong to DTSI because, AFAIU, these
> are properties of boards. At least their frequencies should be moved to
> the board DTS.
> 
> 

I should reword the commit description to be clearer, sorry about that: I
went with "exactly what I've done", but looking at the actual diff, it is
just a rename. What my brain was ticking on here was about removing clocks
that didn't really exist (uart_clk is not a fixed clock, etc), and adding
the ones that do exist.... but then again, the result, casually, is a rename.

In any case... no, these clocks are not board-specific for two reasons:
1. AFAIK, these fixed clock outputs are from the SoC itself, not from
    external components placed on the board, and
2. Even if these were from external components, the SoC *needs* these
    ones to work and any board that doesn't have these fixed XOs simply
    wouldn't be able to work.

Cheers,
Angelo
