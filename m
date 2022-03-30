Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E05F4EC43B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 14:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344761AbiC3MhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 08:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344659AbiC3MhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 08:37:06 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C0329343A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 05:22:26 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nZXLE-0000QY-Ki; Wed, 30 Mar 2022 14:22:25 +0200
Message-ID: <49ae9e66-0fa1-7c9d-49e7-88a7c6cf9ddb@leemhuis.info>
Date:   Wed, 30 Mar 2022 14:22:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: scalability regressions related to hugetlb_fault() changes
Content-Language: en-US
To:     Ray Fucillo <Ray.Fucillo@intersystems.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <D3204B1E-50A1-4261-8C75-3DF77A302502@intersystems.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
In-Reply-To: <D3204B1E-50A1-4261-8C75-3DF77A302502@intersystems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1648642947;6a2ee22e;
X-HE-SMSGID: 1nZXLE-0000QY-Ki
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: I'm adding the regression report below to regzbot, the Linux
kernel regression tracking bot; all text you find below is compiled from
a few templates paragraphs you might have encountered already already
from similar mails.]

Hi, this is your Linux kernel regression tracker.

On 24.03.22 21:12, Ray Fucillo wrote:
> In moving to newer versions of the kernel, our customers have experienced dramatic new scalability problems in our database application, InterSystems IRIS.  Our research has narrowed this down to new processes that attach to the database's shared memory segment taking very long delays (in some cases ~100ms!) acquiring the i_mmap_lock_read() in hugetlb_fault() as they fault in the huge page for the first time.  The addition of this lock in hugetlb_fault() matches the versions where we see this problem.  It's not just slowing the new process that incurs the delay, but backing up other processes if the page fault occurs inside a critical section within the database application.
> 
> Is there something that can be improved here?  
> 
> The read locks in hugetlb_fault() contend with write locks that seem to be taken in very common application code paths: shmat(), process exit, fork() (not vfork()), shmdt(), presumably others.  So hugetlb_fault() contending to read turns out to be common.  When the system is loaded, there will be many new processes faulting in pages that may blocks the write lock, which in turn blocks more readers in fault behind it, and so on...  I don't think there's any support for shared page tables in hugetlb to avoid the faults altogether.
> 
> Switching to 1GB huge pages instead of 2MB is a good mitigation in reducing the frequency of fault, but not a complete solution.
> 
> Thanks for considering.
> 
> Ray

Thanks for the report. CCing the regression mailing list, as it should
be in the loop for all regressions, as explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

To be sure below issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced c0d0381ade79
#regzbot title mm: scalability regressions related to hugetlb_fault()
changes
#regzbot ignore-activity
#regzbot back-burner: looks like this will take some time to get sorted out

If it turns out this isn't a regression, free free to remove it from the
tracking by sending a reply to this thread containing a paragraph like
"#regzbot invalid: reason why this is invalid" (without the quotes).

Reminder for developers: when fixing the issue, please add a 'Link:'
tags pointing to the report (the mail quoted above) using
lore.kernel.org/r/, as explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'. Regzbot needs them to
automatically connect reports with fixes, but they are useful in
general, too.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

-- 
Additional information about regzbot:

If you want to know more about regzbot, check out its web-interface, the
getting start guide, and the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for reporters: when reporting a regression it's in your interest to
CC the regression list and tell regzbot about the issue, as that ensures
the regression makes it onto the radar of the Linux kernel's regression
tracker -- that's in your interest, as it ensures your report won't fall
through the cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot once
it's involved. Fix the issue as you normally would, just remember to
include 'Link:' tag in the patch descriptions pointing to all reports
about the issue. This has been expected from developers even before
regzbot showed up for reasons explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'.
