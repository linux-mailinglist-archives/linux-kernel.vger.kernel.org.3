Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206D154F209
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380564AbiFQHfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347758AbiFQHfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:35:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9138D4A3C1;
        Fri, 17 Jun 2022 00:35:35 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 524266601798;
        Fri, 17 Jun 2022 08:35:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655451333;
        bh=6OlSCHB6/1AgdhTBa59KtFNBtIbrr/K3qDKoofVrLIc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L3r/BTfW0+I/X3sUn+BdiylDXpmsjf8iieZgFV8CwmcjK/UAFCpaCnYgreBZMhcFx
         GuPdOIM9G+rkv+JMVAIVuD2zmNojIBAY4uzMdY19I94mxP6FiWxAd1ZxGaBBKHMnZC
         GxzOqetg+zTQ2VRx8lje6scxRmLGnSL2Bczr2CG1e6Z5v9vzTNxcBqiLDFqO6fOcrF
         zTchzC/wAT7SwN48po97IdCIYyYgQ/jyv33++011ERNL2tmIUxIAW8DDF02cHNI5m1
         5AZCrrk74KGsFRKA3ikjjogNvyfX5h4Buav/CCkr5idGuiwzTBAEuOkDLYevQk0KcG
         Rz8S2h+ROUFBw==
Message-ID: <ef6d3ee1-550c-c243-31c1-7e088cc0f9c3@collabora.com>
Date:   Fri, 17 Jun 2022 09:35:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] mfd: mt6397: Add basic support for MT6331+MT6332 PMIC
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, johnson.wang@mediatek.com,
        hsin-hsiung.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220520124617.228808-1-angelogioacchino.delregno@collabora.com>
 <20220520124617.228808-3-angelogioacchino.delregno@collabora.com>
 <Yqt5HPIXbOab6ik5@google.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <Yqt5HPIXbOab6ik5@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/06/22 20:40, Lee Jones ha scritto:
> On Fri, 20 May 2022, AngeloGioacchino Del Regno wrote:
> 65;6800;1c
>> Add support for the MT6331 PMIC with MT6332 Companion PMIC, found
>> in MT6795 Helio X10 smartphone platforms.
>>
>> This combo has support for multiple devices but, for a start,
>> only the following have been implemented:
>> - Regulators (two instances, one in MT6331, one in MT6332)
>> - RTC (MT6331)
>> - Keys (MT6331)
>> - Interrupts (MT6331 also dispatches MT6332's interrupts)
>>
>> There's more to be implemented, especially for MT6332, which
>> will come at a later stage.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/mfd/mt6397-core.c            |  47 ++
>>   drivers/mfd/mt6397-irq.c             |   9 +-
>>   include/linux/mfd/mt6331/core.h      |  53 +++
>>   include/linux/mfd/mt6331/registers.h | 584 ++++++++++++++++++++++++
>>   include/linux/mfd/mt6332/core.h      |  53 +++
>>   include/linux/mfd/mt6332/registers.h | 642 +++++++++++++++++++++++++++
>>   include/linux/mfd/mt6397/core.h      |   2 +
>>   7 files changed, 1389 insertions(+), 1 deletion(-)
>>   create mode 100644 include/linux/mfd/mt6331/core.h
>>   create mode 100644 include/linux/mfd/mt6331/registers.h
>>   create mode 100644 include/linux/mfd/mt6332/core.h
>>   create mode 100644 include/linux/mfd/mt6332/registers.h
> 
> For my own reference (apply this as-is to your sign-off block):
> 
>    Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 

I've already pushed a v2 of this one :-)
Should I resend?
