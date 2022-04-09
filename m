Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0824FA9F4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 19:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242900AbiDIRex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 13:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbiDIRew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 13:34:52 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9011785664
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 10:32:44 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ndEwz-0001ZG-Qa; Sat, 09 Apr 2022 19:32:42 +0200
Message-ID: <19141ae9-5930-4a53-53b6-9afbf96539b3@leemhuis.info>
Date:   Sat, 9 Apr 2022 19:32:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: AMDGPU: regression on 5.17.1 #forregzbot
Content-Language: en-US
To:     regressions@lists.linux.dev
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20220403132322.51c90903@darkstar.example.org>
 <CADnq5_M+M_iykM0Ag6RF+kxzgpEopUBtp82h7tRM3G+B3AWZ2w@mail.gmail.com>
 <20220404213940.09a56d15@darkstar.example.org>
 <CADnq5_PhaFbVCb=-AUCx4L-sCyPCPOsY3tNpiAg=gfCN7hFcJA@mail.gmail.com>
 <20220409182831.185e5d92@darkstar.example.org>
From:   Thorsten Leemhuis <linux@leemhuis.info>
In-Reply-To: <20220409182831.185e5d92@darkstar.example.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1649525564;96f01c89;
X-HE-SMSGID: 1ndEwz-0001ZG-Qa
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWIMC: this mail is primarily send for documentation purposes and for
regzbot, my Linux kernel regression tracking bot. These mails usually
contain '#forregzbot' in the subject, to make them easy to spot and filter.

On 09.04.22 18:28, Michele Ballabio wrote:
> On Tue, 5 Apr 2022 10:23:16 -0400
> Alex Deucher <alexdeucher@gmail.com> wrote:
> 
>> On Mon, Apr 4, 2022 at 3:39 PM Michele Ballabio
>> <ballabio.m@gmail.com> wrote:
>>>
>>> On Mon, 4 Apr 2022 13:03:41 -0400
>>> Alex Deucher <alexdeucher@gmail.com> wrote:
>>>
>>>> On Sun, Apr 3, 2022 at 10:19 AM Michele Ballabio
>>>> <ballabio.m@gmail.com> wrote:
>>>>>
>>>>> Hi,
>>>>>         I've hit a regression on 5.17.1 (haven't tested 5.17.0,
>>>>> but 5.16-stable didn't have this problem).
>>>>>
>>>>> The machine is a Ryzen 5 1600 with AMD graphics (RX 560).
>>>>>
>>>>> The regression I hit seems to trigger when the machine is left
>>>>> idle at boot (I don't boot straight to X, I boot to a tty, login
>>>>> and then start X). The machine after a while blanks the screen.
>>>>> Usually, the screen unblanks as the keyboard is hit or the mouse
>>>>> moves, but with kernel 5.17.1 the screen does not wake up. The
>>>>> machine seems to run mostly fine: I can login from ssh, but I
>>>>> cannot reboot or halt it: a sysrq sequence is needed for that.
>>>>> Note that if the screen goes blank under X, it wakes up fine.
>>>>>
>>>>> Below a dmesg and two traces from syslog (they're quite
>>>>> similar).
>>>>
>>>> Can you bisect?  Does setting amdgpu.runpm=0 help?
>>>
>>> I can try to bisect, should I narrow the search to drivers/gpu/drm/
>>> ?
>>
>> I would just do a full bisect if possible in case the change happens
>> to be outside of drm.
>>
>>>
>>> Setting amdgpu.runpm=0 works, the display now unblanks without
>>> problems.
>>
> 
> Hi,
>     I bisected this, and the first bad commit is
> [087451f372bf76d971184caa258807b7c35aac8f] drm/amdgpu: use generic fb
> helpers instead of setting up AMD own's.

#regzbot introduced: 087451f372bf76d971184caa258807b7c35aac8f
