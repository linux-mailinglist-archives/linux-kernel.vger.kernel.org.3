Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A5F531051
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbiEWMCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbiEWMCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:02:41 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E10B237FC
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:02:37 -0700 (PDT)
Received: from [10.1.250.9] (riviera.nat.ds.pw.edu.pl [194.29.137.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id B0E1B3F600;
        Mon, 23 May 2022 14:02:34 +0200 (CEST)
Message-ID: <02ab0276-b078-fe66-8596-fcec4378722b@somainline.org>
Date:   Mon, 23 May 2022 14:02:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: Removal of qcom,board-id and qcom,msm-id
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     agross@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, olof@lixom.net, robh@kernel.org,
        sboyd@kernel.org
References: <a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org>
 <20220522195138.35943-1-konrad.dybcio@somainline.org>
 <53d5999b-88ee-24db-fd08-ff9406e2b7b7@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <53d5999b-88ee-24db-fd08-ff9406e2b7b7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/05/2022 09:21, Krzysztof Kozlowski wrote:
> On 22/05/2022 21:51, Konrad Dybcio wrote:
>> Hi,
>>
>> removing these properties will not bring almost any benefit (other than making
>> some checks happy any saving some <200 LoC) and will make the lives of almost
>> all people doing independent development for linux-on-msm harder. There are
>> almost unironically like 3 people outside Linaro and QUIC who have
>> non-vendor-fused development boards AND the sources to rebuild the
>> bootloader on their own. Making it harder to boot is only going to
>> discourage people from developing on these devices, which is already not
>> that pleasant, especially with newer platforms where you have to fight with
>> the oh-so-bright ideas of Android boot chain..
>>
>> This only concerns devices released before sm8350, as the new ones will not
>> even boot with these properties present (or at least SONY Sagami, but I
>> doubt it's an isolated case), so other than completing support for older
>> devices, it won't be an issue going forward, anyway. But there are give
>> or take 50 locked down devices in mainline right now, and many more waiting
>> to be upstreamed in various downstream close-to-mainline trees that should
>> not be disregarded just because Qualcomm is far from the best at making
>> their BSP software stack clean.
> I actually wonder why do you need these properties for community work on
> such boards? You ship kernel with one concatenated DTB and the
> bootloader does not need the board-id/msm-id fields, doesn't it?

If that were the case, I would have never complained about this! It's 
the bootloader itself that needs it, you can see it in a "Best match 
[blah blah] 258/0x1000/...." log line, where it walks through the 
appended (or otherwise compiled into the boot.img) DTBs and looks for 
matches for the burnt-in msm-, board- and (on newer-older platforms) 
pmic-id. If it cannot find these, it refuses to boot with an Android 
Verified Boot red state and you get a not-so-nice "Your device has been 
unlocked and the boot image is not working" or something like this on 
your screen.


>
> Not mentioning that in the past bootloader was actually not using these
> properties at all, because it was the dtbTool who was parsing them.

Not sure when that was the case, maybe with very old arm32 bootloaders 
in the times before I did development on Qualcomm devices.


>   So
> in any case either your device works fine without these properties or
> you have to use dtbTool, right?

To the best of my idea, wrong :( Unless the vendor modified the LK/XBL 
code on their own, it looks for a "best match" (but if it's not a 
precise match, it won't even bother trying to boot, just fyi..), meaning 
it tries to go through a list of SoC ID and revision pairs (msm-id), 
board IDs (board-id) and PMIC id+rev pairs (pmic-id) and if no match is 
found, it doesn't even exit the bootloader and says something like "no 
dtbs found".


And hence, they are absolutely necessary one way or another.


Konrad

>
>> One solution is to chainload another, (n+1)-stage bootloader, but this is
>> not ideal, as:
>>
>> 1) the stock bootloader can boot Linux just fine on most devices (except
>> for single exceptions, where beloved OEMs didn't implement arm64 booting or
>> something)
>>
>> 2) the boot chain on MSM is already 3- or 4- stage and adding to that will
>> only create an unnecessary mess
>>
>> 3) the job of kernel people is not to break userspace. If the
>> device can not even exit bootloader after a kernel upgrade, it's a big
>> failure.
> The job of kernel people is to follow bindings and since they were
> introduced 7 years ago, I would say there was plenty of time for that.
>
> If the dtbTool support for the bindings is there, then there is no
> breakage, because you had to use dtbTool before so you have to use now.
>
>> If you *really really really* want these either gone or documented, we can
>> for example use them in the SOCID driver, read the values from DTB and
>> compare against what SMEM has to say and for example print a warning when
>> there are inconsistencies or use it as a fallback when it fails for any
>> reason, such as using a newer SoC on an older kernel, without updates
>> for SOCID read (which are sometimes necessary, which was the case for 8450
>> recently, iirc).
>>
>> My stance is to just leave them as is, as moving them anywhere, or removing
>> them at all will cause unnecessary mess and waste time that could have been
>> spent on more glaring issues..
>>
>> Konrad
>
> Best regards,
> Krzysztof
