Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7374E56544E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbiGDMGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbiGDMGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:06:11 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6092AF8;
        Mon,  4 Jul 2022 05:06:10 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1o8Kq7-0003VK-1C; Mon, 04 Jul 2022 14:06:07 +0200
Message-ID: <30feb08e-83d0-34e2-06bb-40f4960c8be4@leemhuis.info>
Date:   Mon, 4 Jul 2022 14:06:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [EXT] Re: [REGRESSION] qla2xxx: tape drive not removed after
 unplug FC cable
Content-Language: en-US
To:     Arun Easi <aeasi@marvell.com>,
        Tony Battersby <tonyb@cybernetics.com>
Cc:     Saurav Kashyap <skashyap@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <baef87c3-5dad-3b47-44c1-6914bfc90108@cybernetics.com>
 <alpine.LRH.2.21.9999.2205271524460.4730@mvluser05.qlc.com>
 <5bcb5963-9da0-fd59-45c5-d27af02e7748@leemhuis.info>
 <178e4e7a-64fc-a442-cdda-45100eaebda0@cybernetics.com>
 <alpine.LRH.2.21.9999.2206211156470.4730@mvluser05.qlc.com>
 <d41671b4-8d29-b940-da37-b8dbe81f4d72@cybernetics.com>
 <alpine.LRH.2.21.9999.2206221557150.4730@mvluser05.qlc.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <alpine.LRH.2.21.9999.2206221557150.4730@mvluser05.qlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1656936370;8e6840f3;
X-HE-SMSGID: 1o8Kq7-0003VK-1C
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.22 01:03, Arun Easi wrote:
> On Wed, 22 Jun 2022, 7:56am, Tony Battersby wrote:
> 
>> On 6/21/22 18:05, Arun Easi wrote:
>>> Thanks for the info. Just to reiterate, you've reported two issues (though 
>>> this log was showing only 1 of them).
>>>
>>> Issue 1 - Tape device never disappears when removed
>>> Issue 2 - When a direct connected tape 1 was replaced with tape 2, tape 2 
>>>           was not discovered.
>>>
>>> For Issue-2, please try the attached patch. This may not be the final fix, 
>>> but wanted to check if that would fix the issue for you.
>>>
>>> For Issue-1, the behavior was intentional, though that behavior needs 
>>> refinement. These tape drives support something called FC sequence level 
>>> error recovery (added in FCP-2), which can make tape I/Os survive even 
>>> across a short cable pull. This is not a simple retry of the I/O, rather a 
>>> retry done at the FC sequence level that gives the IO a better chance of
>>> revival. In other words, the said patch that caused regression, while 
>>> introduces an incorrect reporting of the state of the device, makes backup 
>>> more resilient.
>>>
>>> Now, onto the behavior when device state is reported immediately. What we 
>>> have observed, at least with one tape drive from a major vendor, is that, 
>>> across a device loss and device back case with both the events reported to 
>>> upper layers, the backup operation was getting failed. This is due to a 
>>> REPORT LUNS command being issued during device reappearance reporting 
>>> (fc_remote_port_add -> SCSI scan), which the tape drive was not expecting 
>>> and caused the backup to fail.
>>>
>>> I know that some tape drives do not support multiple commands to it at the 
>>> same time, but not sure if that is still the norm these days.
>>>
>>> So, perhaps one way to make the behavior better, is to either report the 
>>> disappearing device a bit delayed or have intelligence added in SCSI scan 
>>> to detect ongoing tape IO operations and delay/avoid the REPORT LUNs. 
>>> Former is a more contained (in the LLD) fix.
>>>
>>> Regards,
>>> -Arun
>>
>> Your patch does fix Issue-2 for me.  For Issue-1, it would be fine with
>> me if qla2xxx reported device removal to the upper level a bit delayed,
>> as you said.
>>
> 
> Thanks for testing and verifying the patch.

BTW, that patch should have 'Link:' tags pointing to all reports about
this issue, e.g. the start of this thread.

These tags are important, as they allow others to look into the
backstory now and years from now. That is why they should be placed in
cases like this, as Documentation/process/submitting-patches.rst and
Documentation/process/5.Posting.rst explain in more detail.
Additionally, my regression tracking bot ‘regzbot’ relies on these tags
to automatically connect reports with patches that are posted or
committed to fix the reported issue. BTW, let me tell regzbot to monitor
this thread:

> We will post the patch upstream after due testing.
That was more than two weeks ago now and I didn't see any progress. Or
did I miss it?

Reminder, things should take this long. For details see the section
"Prioritize work on fixing regressions" in this document:
https://docs.kernel.org/process/handling-regressions.html

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

#regzbot poke
