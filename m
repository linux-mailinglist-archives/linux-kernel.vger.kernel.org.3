Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D83A514938
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359107AbiD2M1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359060AbiD2M1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:27:48 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D473EC8BDE;
        Fri, 29 Apr 2022 05:24:29 -0700 (PDT)
Received: from [2a02:8108:963f:de38:6624:6d8d:f790:d5c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nkPff-00068a-O0; Fri, 29 Apr 2022 14:24:27 +0200
Message-ID: <81b865bb-be46-cdf7-a49b-fd029de439fb@leemhuis.info>
Date:   Fri, 29 Apr 2022 14:24:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: [Regression] Resume process hangs for 5-6 seconds starting sometime
 in 5.16
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1651235069;14287da5;
X-HE-SMSGID: 1nkPff-00068a-O0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

Bart, I noticed a regression report in bugzilla.kernel.org that afaics
nobody acted upon since it was reported about a week ago, that's why I
decided to forward it to the lists and all people that seemed to be
relevant here. It's caused by a commit of yours. To quote from
https://bugzilla.kernel.org/show_bug.cgi?id=215880 :

> Previously reported on the Gentoo bug tracker: https://bugs.gentoo.org/837500
> 
> Basic issue: 
> 
> Starting sometime in 5.16, my GUI freezes up during resume for 5-6 seconds: the screen is frozen, and it seems key presses and mouse movements are not registered. If I suspend from a tty, the 'loginctl suspend' command takes about 5-6 seconds to finish after resuming, however here my key presses are registered. 
> 
> It seems like the first thing it does on resume is to suspend the device, as if the system powered off too quickly or something.
> 
> I used git bisect to identify the commit where the problem begins: 
> 
> ========
> commit a19a93e4c6a98c9c0f2f5a6db76846f10d7d1f85
> Author: Bart Van Assche <bvanassche@acm.org>
> Date:   Wed Oct 6 14:54:51 2021 -0700
> 
>     scsi: core: pm: Rely on the device driver core for async power management
>     
>     Instead of implementing asynchronous resume support in the SCSI core, rely
>     on the device driver core for resuming SCSI devices asynchronously.
>     Instead of only supporting asynchronous resumes, also support asynchronous
>     suspends.
>     
>     Link: https://lore.kernel.org/r/20211006215453.3318929-2-bvanassche@acm.org
>     Cc: Alan Stern <stern@rowland.harvard.edu>
>     Cc: Dan Williams <dan.j.williams@intel.com>
>     Cc: Hannes Reinecke <hare@suse.com>
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Martin Kepplinger <martin.kepplinger@puri.sm>
>     Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>     Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> 
>  drivers/scsi/hosts.c      |  1 +
>  drivers/scsi/scsi.c       |  8 --------
>  drivers/scsi/scsi_pm.c    | 44 ++------------------------------------------
>  drivers/scsi/scsi_priv.h  |  4 +---
>  drivers/scsi/scsi_scan.c  | 17 +++++++++++++++++
>  drivers/scsi/scsi_sysfs.c |  1 +
>  drivers/scsi/sd.c         |  1 -
>  7 files changed, 22 insertions(+), 54 deletions(-)
> ========
> 
> For git bisect I followed the instructions provided on the gentoo wiki: https://wiki.gentoo.org/wiki/Kernel_git-bisect, which uses the linux-stable repository.
> 
> Here is a sample dmesg output when I do not experience the bug ('good') and when I do ('bad'). Nothing to me seems obviously wrong. You do see some 'extra' lines in the 'bad' case at the end, but these lines also appear in the 'good' case later on; they don't have enough time to appear in the 'good' case when the system resumes quickly as normal. There are xHCI errors related to USB buses, but they appear in both cases.
> 
> Good: https://dpaste.org/S90gh
> Bad:  https://dpaste.org/9KQ6C
> 
> Hardware info:
> AMD Ryzen 3600
> AMD Radeon RX580 
> AMD Radeon 270X (usually bound to vfio-pci, otherwise amdgpu)
> ASUS Strix ROG B450-F (latest BIOS)
> Seasonic Prime GX-750 (brand new)
> I also have an M.2 NVME drive (boot), a SATA SSD, and one HDD.
> 
> 
> I'm happy to try any troubleshooting steps.

Could somebody take a look into this? Or was this discussed somewhere
else already? Or even fixed?

Anyway, to get this tracked:

#regzbot introduced: a19a93e4c6a98c9c0f2f5a6db76846f10d7d1f
#regzbot from: ericspero@icloud.com <ericspero@icloud.com>
#regzbot title: scsi: pm: Resume process hangs for 5-6 seconds starting
sometime in 5.16
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215880

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

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
