Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230234EBEE2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245442AbiC3KiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245435AbiC3KiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:38:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4602BB23;
        Wed, 30 Mar 2022 03:36:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 1464B1F41835
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648636590;
        bh=yjx1kf6POnDpobtQKgZbaVsr1GNaW5K6KF98SWEVWiM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=STXGHTZaL+HoSt7mA/RAo1TnYAHbOJ6tBgq4FSPAg8mEBjbHhc06wB6W33kfd7urQ
         gFg1Cqsu+u6hdBBSR1U6qOjnPacSYejBxGIYdQZL0osJPgS7lnJ5OZDdUFXwFeOuSG
         qmQrV0CyrS67EOCOJM4B6YZvuGYnZchS/YNwSEjzYvJ/A7wB6eNCVrLqSr1KeZmmPP
         VdG+modtas8Ru9tlRQSwabg0TpXkLAvn/TRy1iBWdtTCrRq0C0MKBHpsbmzVcExX6q
         USaswk6D+YAWBg1kEJU/EfolPlM24QHndy0aPj8eUWd4XKm6Wa+G7x34K2we/+BAUT
         lo8fLk1z2Hkfg==
Message-ID: <bf851834-7812-13f1-a382-1f64078ff2a5@collabora.com>
Date:   Wed, 30 Mar 2022 13:36:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v5 2/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-3-amhetre@nvidia.com>
 <9ab1a77c-82e6-39be-9b90-b394037fb574@gmail.com>
 <a62bb479-fed4-ada0-ac61-fb67a663a998@nvidia.com>
 <4ea801f4-7929-148d-4e69-d4126a9dfbf7@collabora.com>
 <44235c65-160c-04c7-294d-16b13d25605c@nvidia.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <44235c65-160c-04c7-294d-16b13d25605c@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/22 13:16, Ashish Mhetre wrote:
> 
> 
> On 3/30/2022 5:31 AM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 3/22/22 20:34, Ashish Mhetre wrote:
>>>>> +     switch (status & mc->soc->int_channel_mask) {
>>>>> +     case BIT(0):
>>>>> +             *mc_channel = 0;
>>>>> +             break;
>>>>> +
>>>>> +     case BIT(1):
>>>>> +             *mc_channel = 1;
>>>>> +             break;
>>>>> +
>>>>> +     case BIT(2):
>>>>> +             *mc_channel = 2;
>>>>> +             break;
>>>>> +
>>>>> +     case BIT(3):
>>>>> +             *mc_channel = 3;
>>>>> +             break;
>>>>> +
>>>>> +     case BIT(24):
>>>>> +             *mc_channel = MC_BROADCAST_CHANNEL;
>>>>> +             break;
>>>>> +
>>>>> +     default:
>>>>> +             pr_err("Unknown interrupt source\n");
>>>>
>>>> dev_err_ratelimited("unknown interrupt channel 0x%08x\n", status) and
>>>> should be moved to the common interrupt handler.
>>>>
>>> So return just error from default case and handle error in common
>>> interrupt handler with this print, right? I'll update this in next
>>> version.
>>
>> Yes, just move out the common print.
>>
>> Although, you could parameterize the shift per SoC and then have a
>> common helper that does "status >> intmask_chan_shift", couldn't you?
> 
> Do you mean shift to get the channel, like
> "channel = status >> intmask_chan_shift"?
> So to get rid of this callback completely and adding a variable in
> tegra_mc_soc for intmask_chan_shift, right? Or compute shift in this
> callback and use it in common handler?

Add variable to tegra_mc_soc.

The intmask_chan_shift is a misnomer, perhaps something like
status_reg_chan_shift will be a better name.

> If we are to remove this callback then how to handle unknown interrupt
> channel error?

Create a common helper function that returns ID of the raised channel or
errorno if not bits are set.

> Also we want to handle interrupts on one channel at a time and then
> clear it from status register. There can be interrupts on multiple
> channel. So multiple bits from status will be set. Hence it will be
> hard to parameterize shift such that it gives appropriate channel.
> So I think current approach is fine. Please correct me if I am wrong
> somewhere.

You may do the following:

1. find the first channel bit set in the status reg
2. handle that channel
3. clear only the handled status bit, don't clear the other bits
4. return from interrupt

If there are other bits set, then interrupt handler will fire again and
next channel will be handled.
