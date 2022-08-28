Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8755A3D31
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 12:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiH1KY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 06:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiH1KYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 06:24:25 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B853E4CA00;
        Sun, 28 Aug 2022 03:24:23 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oSFSn-0006qz-Ha; Sun, 28 Aug 2022 12:24:21 +0200
Message-ID: <9968ab01-f9c4-ee47-9dd0-9e46560e459e@leemhuis.info>
Date:   Sun, 28 Aug 2022 12:24:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: regression caused by block: freeze the queue earlier in
 del_gendisk
Content-Language: en-US
To:     Dusty Mabe <dusty@dustymabe.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hch@lst.de,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <017845ae-fbae-70f6-5f9e-29aff2742b8c@dustymabe.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <017845ae-fbae-70f6-5f9e-29aff2742b8c@dustymabe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1661682263;b86e50f9;
X-HE-SMSGID: 1oSFSn-0006qz-Ha
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker. Thx for the report.

CCing the regression mailing list, as it should be in the loop for all
regressions, as explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

On 26.08.22 18:15, Dusty Mabe wrote:
> 
> I think I've found a regression introduced by:
> a09b314 o block: freeze the queue earlier in del_gendisk

Just FYI, in case you are not aware of it already: there was another
report that this commit causes problems. See this thread for details:
https://lore.kernel.org/all/72a5bf2e-cd56-a85c-2b99-cb8729a66fed@deltatee.com/#t

Anyway, let me add this report to the regressions tracking:

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

> In Fedora CoreOS we have tests that set up RAID1 on the /boot/ and /root/ partitions
> and then subsequently removes one of the disks to simulate a failure. Sometime recently
> this test started timing out occasionally. Looking a bit closer it appears instances are
> getting stuck during reboot with a bunch of looping messages:
> 
> ```
> [   17.978854] block device autoloading is deprecated and will be removed.
> [   17.982555] block device autoloading is deprecated and will be removed.
> [   17.985537] block device autoloading is deprecated and will be removed.
> [   17.987546] block device autoloading is deprecated and will be removed.
> [   17.989540] block device autoloading is deprecated and will be removed.
> [   17.991547] block device autoloading is deprecated and will be removed.
> [   17.993555] block device autoloading is deprecated and will be removed.
> [   17.995539] block device autoloading is deprecated and will be removed.
> [   17.997577] block device autoloading is deprecated and will be removed.
> [   17.999544] block device autoloading is deprecated and will be removed.
> [   22.979465] blkdev_get_no_open: 1666 callbacks suppressed
> ...
> ...
> ...
> [  618.221270] blkdev_get_no_open: 1664 callbacks suppressed
> [  618.221273] block device autoloading is deprecated and will be removed.
> [  618.224274] block device autoloading is deprecated and will be removed.
> [  618.227267] block device autoloading is deprecated and will be removed.
> [  618.229274] block device autoloading is deprecated and will be removed.
> [  618.231277] block device autoloading is deprecated and will be removed.
> [  618.233277] block device autoloading is deprecated and will be removed.
> [  618.235282] block device autoloading is deprecated and will be removed.
> [  618.237370] block device autoloading is deprecated and will be removed.
> [  618.239356] block device autoloading is deprecated and will be removed.
> [  618.241290] block device autoloading is deprecated and will be removed.
> ```
> 
> Using the Fedora kernels I narrowed it down to being introduced between 
> `kernel-5.19.0-0.rc3.27.fc37` (good) and `kernel-5.19.0-0.rc4.33.fc37` (bad).
> 
> I then did a bisect and found:
> 
> ```
> $ git bisect bad
> a09b314005f3a0956ebf56e01b3b80339df577cc is the first bad commit
> commit a09b314005f3a0956ebf56e01b3b80339df577cc
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Tue Jun 14 09:48:27 2022 +0200
> 
>     block: freeze the queue earlier in del_gendisk
>     
>     Freeze the queue earlier in del_gendisk so that the state does not
>     change while we remove debugfs and sysfs files.
>     
>     Ming mentioned that being able to observer request in debugfs might
>     be useful while the queue is being frozen in del_gendisk, which is
>     made possible by this change.
>     
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>     Link: https://lore.kernel.org/r/20220614074827.458955-5-hch@lst.de
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
>  block/genhd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> ```
> 
> Reverting this commit on top of latest git master (4c612826b) gave me successful results.
> 
> Any ideas on what could be amiss here? Luckily the patch is tiny so hopefully it might
> be obvious.
> 
> More details (including logs) in the following locations:
> 
> - https://bugzilla.redhat.com/show_bug.cgi?id=2121791
> - https://github.com/coreos/fedora-coreos-tracker/issues/1282
> 
> 
> Thanks!
> Dusty
> 

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced a09b314005f3a0
#regzbot title block: timeouts when removing a disk from a RAID1
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replies to), as explained for
in the Linux kernel's documentation; above webpage explains why this is
important for tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
