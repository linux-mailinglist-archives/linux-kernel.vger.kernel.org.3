Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4ABD4799EA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 10:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhLRJOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 04:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhLRJOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 04:14:04 -0500
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C47FC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 01:14:03 -0800 (PST)
Received: from [192.168.1.101] (83.6.165.42.neoplus.adsl.tpnet.pl [83.6.165.42])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id C67B71F8F4;
        Sat, 18 Dec 2021 10:13:59 +0100 (CET)
Message-ID: <57058c58-03d8-4b9a-7416-c32b61c423cc@somainline.org>
Date:   Sat, 18 Dec 2021 10:13:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFC/patch 0/2] arm64: boot: dts: qcom: sm8150: enable
 framebuffer for Surface Duo
Content-Language: en-US
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustave Monce <gustave.monce@outlook.com>,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20211217125757.1193256-1-balbi@kernel.org>
 <da9a88a5-46bf-3eab-7318-6db4dfeef994@somainline.org>
 <87czlu4bz7.fsf@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <87czlu4bz7.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18.12.2021 08:17, Felipe Balbi wrote:
> Hi Konrad,
>
> Konrad Dybcio <konrad.dybcio@somainline.org> writes:
>
>> On 17.12.2021 13:57, Felipe Balbi wrote:
>>> From: Felipe Balbi <felipe.balbi@microsoft.com>
>>>
>>> Hi folks,
>>>
>>> I'm trying to enable the framebuffer on Microsoft Surface Duo. Looking
>>> through some internal docs, it came to my attention that the bootloader
>>> will fill up the framebuffer address and size to a memory node names
>>> splash_region. Adding the node, I can see the address of the
>>> framebuffer. Creating the relevant framebuffer device using
>>> simple-framebuffer, I can't see it working. Tried dd if=/dev/urandom
>>> of=/dev/fb0 and fb-test. None of which manage to get rid of what's
>>> already on the screen, put there by the bootloader (platform Logo).
>>>
>>> Wondering if any of you have seen a behavior such as this and how did
>>> you manage to get framebuffer working on SM8150 (I see at least Sony
>>> Xperia has the node).
>>>
>>> Felipe Balbi (2):
>>>   arm64: boot: dts: qcom: sm8150: add a label for reserved-memory
>>>   arm64: boot: dts: qcom: surface duo: add minimal framebuffer
>>>
>>>  .../dts/qcom/sm8150-microsoft-surface-duo.dts | 19 +++++++++++++++++++
>>>  arch/arm64/boot/dts/qcom/sm8150.dtsi          |  2 +-
>>>  2 files changed, 20 insertions(+), 1 deletion(-)
>> Hi,
>>
>>
>> this issue is totally unique to the Duo and your bootloader configuration.
>>
>>
>> Gus (CCd, co-author of Lumia 950/XL patches) and I were dissecting
>> this precise issue (albeit for a different usecase) and in our testing
>> it turned out that XBL likely kills the display stack upon exiting
>> Boot Services and jumping to LinuxLoader. This may be a bug that comes
>> from the legacy of this device, as exiting Boot Services would be
>> rather undesirable in that scenario..
> This is very nice background information which I didn't have. Thanks :-)
>
>> One fix would be to ask the bootloader team to look into it and fix it
>> from there, otherwise you'd have to bring up the display using the
>> DPU1 driver, or perhaps in a third-stage-bootloader (pls don't do it
> I'll give DPU1 a shot, thanks for the pointer

Won't work yet. Your display (well, displays.. hehe) are CMD mode and

have DSC. Both of which are unsupported on SM8150. DSC patches by Vinod

seem to only work on 845 (or at least don't work on 8250 for me) and Marijn

from SoMainline (added to CC) is working on cleaning up CMD mode

support, as Qualcomm moved the pingpong functionality (basically

the way of SoC telling the panel HEY IT'S TIME TO DRAW A FRAME)

to a different hardware block and that needs some care in code).


>> for the sanity of us all :D)
> no 3rd stages :-)
>
Good :P


Konrad

