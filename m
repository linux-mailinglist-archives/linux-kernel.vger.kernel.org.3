Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8C353E610
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbiFFKLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbiFFKKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:10:50 -0400
X-Greylist: delayed 3169 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Jun 2022 03:08:29 PDT
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8941483DF;
        Mon,  6 Jun 2022 03:08:27 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7E5046601E55;
        Mon,  6 Jun 2022 11:08:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654510098;
        bh=6Uvj8oSgSh3XaO2x3wCFADsMs6ooqEZD3nKhYNDXhaU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ddmp06anVxj0htfEdxrQB9l1y8xBbyqy8NggFB1A5XDgxBm7VWo6W7kkYG9k2S2hb
         q9IT4CktJcVWrqVq6XkUuGcFoR+sSPhuUJaNewUwBNsk73dIZuMDMOqCj8oNuqc9jS
         TzCR7/np/ULwlYCTf+77J6Rt6B0La/iLi1puO//xoS+VpHHRfDzITe+jqMs6ETSDCu
         hUv0ETuyKgrVEyfk6QPgw4YLCqg8p8XaWMrGt7cV0iRPoMhgO0ifYdJjQ4ap3Ju79n
         CaOQsSK2KjzcB9YJmeCPUwEeedRqRN8eTevRGLOAVKc8biC6FGnQJK8t1ZAX+1VKYE
         1tIETrX9MCmNg==
Message-ID: <4062e8be-3ac7-c6e5-dc15-bb11bd6051fc@collabora.com>
Date:   Mon, 6 Jun 2022 12:08:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1 05/15] remoteproc: mediatek: Add SCP core 1 driver for
 dual-core scp
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Dustin L. Howett" <dustin@howett.net>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        weishunc@google.com
References: <20220601112201.15510-1-tinghan.shen@mediatek.com>
 <20220601112201.15510-6-tinghan.shen@mediatek.com>
 <dd12145b-bbb3-b771-b8f7-075ea20bee17@collabora.com>
 <fe9fae165443f0db55f2bac2bbe214f3b018052d.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <fe9fae165443f0db55f2bac2bbe214f3b018052d.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/06/22 11:52, Tinghan Shen ha scritto:
> On Mon, 2022-06-06 at 11:15 +0200, AngeloGioacchino Del Regno wrote:
>> Il 01/06/22 13:21, Tinghan Shen ha scritto:
>>> MT8195 SCP is a dual-core processor. The mtk_scp.c driver only controls
>>> SCP core 0. This patch adds a basic driver to control the another core.
>>>
>>> Core 1 and core 0 of the SCP are housed in the same subsys.They see
>>> registers and memory in the same way.
>>>
>>> Core 1 of the SCP features its own set of core configuration registers,
>>> interrupt controller, timers, and DMAs. The rest of the peripherals
>>> in this subsystem are shared by core 0 and core 1.
>>>
>>> As for memory, core 1 has its own cache memory, and the SCP SRAM is shared
>>> by core 0 and core 1.
>>>
>>
>> Hello Tinghan,
>>
>> checking all the patches that are introducing support for the secondary SCP core,
>> it's clear that you're practically reusing *most of* mtk_scp in mtk_scp_dual.
>>
>> I don't think that adding a new configuration option for MTK_SCP_DUALCORE (nor a
>> new file just for that) is a good idea... the code is "short enough" so you should
>> really just add support for multi-core SCP in mtk_scp.c instead.
>>
>> After doing so, I have a hunch that we'll be able to reduce the size of this
>> implementation even more, as I see literally too much common code :-)
>>
> 
> Hi Angelo,
> 
> Thanks for your review.
> 
> This series has 2 new files, mtk_scp_dual.c and mtk_scp_subdev.c.
> Is your advice to merge both files into mtk_scp.c,
> or to merely merge mtk_scp_dual.c to mtk_scp.c?
> 
> Thanks,
> TingHan
> 
> 
> 

I suggest to merge both into mtk_scp.c and commonize/generalize functions inside
of there as much as possible... including the removal of #if IS_ENABLED(...)
macro usages, as you can simply check that during runtime by setting a bool
variable to true when it's dual-core.

Let's do this first step.
I'll give you a more exhaustive review on v2, when this main step is done.

Cheers,
Angelo
