Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B66D542DF3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237480AbiFHKfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236929AbiFHKdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:33:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107FB1C4203;
        Wed,  8 Jun 2022 03:25:59 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 246C0660181B;
        Wed,  8 Jun 2022 11:25:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654683948;
        bh=CbCEHZf0MESeLkAV+KaRIb58SJLwsWDBEd1XfSKloiU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JL6CAQRzPNxS11sdv1lqG3+jYQQBX0szDXfzGlqNeAmSTxcSN4hrnxHXiJK4TI/5o
         4lG3gsRwQhONwG+w5NxnfRzA+cI5lF3VjstoVw0s3HPCKYvYr7kER2ucKauN9+qgMT
         mTsntlQDlE0JrPQUTJURaOqHDSkyIi90kFHMkUae1FEGncdiXfftKujwqhZzPtMcGC
         hldbDeeSFn1Hvs5EIWixyoS9jStUbJyl1AVxxnbAxcZhEJiSgkRbwBUWK0306fSYfO
         mWuaO/tU/mF4L7Eqymam34ABQMq66ZhWoW9r442GAmDfk2QCk2U4rXjVa10NTpdz0t
         8aV3MpGHtXuKQ==
Message-ID: <4f6f1ec4-2c68-5446-e0e0-85e1631a84cf@collabora.com>
Date:   Wed, 8 Jun 2022 12:25:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/6] iommu/qcom: Use the asid read from device-tree if
 specified
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Martin Botka <martin.botka@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        jamipkettunen@somainline.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
 <20220527212901.29268-2-konrad.dybcio@somainline.org>
 <20220531154631.GA25502@willie-the-truck>
 <CAF6AEGsWsHfQZnszG=NgP0BufxO-DP4LwvsAYkrz2wRhcJuOXw@mail.gmail.com>
 <20220531161910.GE25502@willie-the-truck>
 <CAF6AEGvF+5mf6jE9Xac1qR9P+-=ELLu_LzoJhUV-Dx2RYH20Ag@mail.gmail.com>
 <6efeafbc-d366-bddd-faa4-4359f3a56f4a@somainline.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <6efeafbc-d366-bddd-faa4-4359f3a56f4a@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/06/22 20:03, Konrad Dybcio ha scritto:
> 
> 
> On 31.05.2022 22:57, Rob Clark wrote:
>> On Tue, May 31, 2022 at 9:19 AM Will Deacon <will@kernel.org> wrote:
>>>
>>> On Tue, May 31, 2022 at 09:15:22AM -0700, Rob Clark wrote:
>>>> On Tue, May 31, 2022 at 8:46 AM Will Deacon <will@kernel.org> wrote:
>>>>>
>>>>> On Fri, May 27, 2022 at 11:28:56PM +0200, Konrad Dybcio wrote:
>>>>>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>>>>>
>>>>>> As specified in this driver, the context banks are 0x1000 apart.
>>>>>> Problem is that sometimes the context number (our asid) does not
>>>>>> match this logic and we end up using the wrong one: this starts
>>>>>> being a problem in the case that we need to send TZ commands
>>>>>> to do anything on a specific context.
>>>>>
>>>>> I don't understand this. The ASID is a software construct, so it shouldn't
>>>>> matter what we use. If it does matter, then please can you explain why? The
>>>>> fact that the context banks are 0x1000 apart seems unrelated.
>>>>
>>>> I think the connection is that mapping from ctx bank to ASID is 1:1
>>>
>>> But in what sense? How is the ASID used beyond a tag in the TLB? The commit
>>> message hints at "TZ commands" being a problem.
>>>
>>> I'm not doubting that this is needed to make the thing work, I just don't
>>> understand why.
>>
>> (disclaimer, it has been quite a while since I've looked at the smmu
>> setup with earlier tz, ie. things that use qcom_iommu, but from
>> memory...)
>>
>> We cannot actually assign the context banks ourselves, so in the dt
>> bindings the "ASID" is actually the context bank index.
> I think so.
> 
>    I don't
>> remember exactly if this was a limitation of the tz interface, or
>> result of not being able to program the smmu's global registers
>> ourselves.
> 
> As far as I understand, it's the latter, as changing the defaults is not allowed by the security policy on consumer devices.
> 
> Qualcomm arbitrarily chose some numbers that may or may have not aligned with their usual index-is-offset-divided-by-0x1000 and hardcoded them in the BSP, and now the secure side (if required, and well, it is..) expects precisely that configuration.
> 
> 
> Konrad
> 

I can confirm that it's the latter, as described by Konrad.
The inability of programming the global registers from Linux is due to the
hypervisor disallowing that (in different ways depending on the SoC's firmware
but with the same outcome: AP reset by HYP).

Cheers,
Angelo
