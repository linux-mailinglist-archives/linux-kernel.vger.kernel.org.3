Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE970529BCA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242376AbiEQIIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237359AbiEQIH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:07:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07073BA65;
        Tue, 17 May 2022 01:07:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C074B1F441D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652774876;
        bh=tuq3VbAxgnS0xWzmyEnSJuvgMj+dNp4blLu8nvOqYac=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=igs8DLrZN4Gos9vjSRnjpGxorfB1377dTfD9fD5n8b+Nk4yBkVMVyscC91Mk+NWjV
         H2HBKftBFAu5UwKhI1XQrKvWbZTQzeh2C19Thy5oOcfAaJKN8MidSEae+ZYk0+NPGO
         M5m1URHuDjYnnlDSsI9L1kiOqY3Qf5T5Y3hJ1EaryIO0LBNwJd/Y4M4+2So4qdgBuS
         Bk9EjMdZDurNMq/ARdDMZpKTuIlPv+7p2eYjKfgdZj0gpitwkAUWwAo6XXq5bzKg3S
         VrORLF/gAOVcVZzTQDM6Sj1wctjKoGDlnrf/m5nmTOs05hKqn1mn7td8nQ20L/C6E5
         afVZ7ckSwKmeA==
Message-ID: <b65546e1-2d3a-d525-b664-1730dc06994f@collabora.com>
Date:   Tue, 17 May 2022 10:07:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 5/5] clk: mediatek: Add MediaTek Helio X10 MT6795 clock
 drivers
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de, y.oudjana@protonmail.com,
        jason-jh.lin@mediatek.com, ck.hu@mediatek.com,
        fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, chun-jie.chen@mediatek.com,
        weiyi.lu@mediatek.com, ikjn@chromium.org, miles.chen@mediatek.com,
        sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
References: <20220513165050.500831-1-angelogioacchino.delregno@collabora.com>
 <20220513165050.500831-6-angelogioacchino.delregno@collabora.com>
 <8177c547-2a38-691b-0a32-bc7e6ba1e2ed@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <8177c547-2a38-691b-0a32-bc7e6ba1e2ed@gmail.com>
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

Il 16/05/22 13:30, Matthias Brugger ha scritto:
> 
> 
> On 13/05/2022 18:50, AngeloGioacchino Del Regno wrote:
>> Add the clock drivers for the entire clock tree of MediaTek Helio X10
>> MT6795, including system clocks (apmixedsys, infracfg, pericfg, topckgen)
>> and multimedia clocks (mmsys, mfg, vdecsys, vencsys).
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Thanks a lot for taking care of this!
> I just wonder if we couldn't build most of the clock drivers as modules like done 
> for the mt6779. It would help us to keep the kernel image smaller.
> 

Hello Matthias!

You're welcome!
...but I simply couldn't stand at seeing partially working (..or actually, not
really working) SoCs upstream. If something is upstream, it must work, or it
shouldn't be here for real :-)

Regarding your question about the clock drivers as module... I believe we can,
but that'd be only for {vdec,venc}sys and *maybe* MFG (gpu clocks): I don't know
if it'd be worth to do, as these are about... 8 clocks out of... I haven't counted
them, but more than 250, I think?

It *should* be straightforward though, just about giving them a tristate in Kconfig
instead of a bool, but that would still be limited to just those three...

The reason for me excluding clk-mt6795-mm from this choice is that - at least for
me - my development platform is a commercial smartphone, where the only thing that
"saves you" is having some display output... I mean - I *do* have a UART port, but
that's only because I've been able to solder thin wires on 0.2mm pads... you surely
agree on the fact that this isn't a common practice, even across developers.

Besides, if you think that clk-mt6795-mm should indeed be a module by default,
well, that.. is.. possible - I don't see why it shouldn't be... obviously keeping
in mind that this will largely slow down the boot process, which isn't a big issue.

In any case, it is *not* possible to compile as module *any* of the clock drivers
that I have included in the CONFIG_COMMON_CLK_MT6795 (apmixed, infra, peri, topck)
as.. you know.. these are "a bit critical" on older platforms :-)


How would you proceed?

Cheers,
Angelo
