Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F65486783
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 17:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241113AbiAFQRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 11:17:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48812 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241052AbiAFQRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 11:17:42 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6FED71F37F;
        Thu,  6 Jan 2022 16:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641485861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jiujcEw1K7Aihwam1nGHQCL1WPhq/6cKdLiFVo++R3c=;
        b=ufwsRGd/FAFSnNurr1idklThXc8LwBLYgJV1EMzyI+FcwXo4765ZgS1rrPr2SeIcuIzAnr
        Qz4oPL+EShKMJyF/TCs94cyS3cFUxMuOwWgiXtUwbuPcHE6tPcT5sfgFyaEmSqXyyPurGp
        WTGPEzwD6r+hPpBJqRPJK6LRMaR/z5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641485861;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jiujcEw1K7Aihwam1nGHQCL1WPhq/6cKdLiFVo++R3c=;
        b=226XJuqQmhTHAxGxJccyOlu2FmeDoOd5e59bAFWXy3zITmcJmXbjP4qXgwZ7rlGZs25eRZ
        SylzAKQ0qBaZkMBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A6C113C5E;
        Thu,  6 Jan 2022 16:17:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rt3wOCIW12FhCgAAMHmgww
        (envelope-from <colyli@suse.de>); Thu, 06 Jan 2022 16:17:38 +0000
Message-ID: <bd98488b-dbb8-0510-3ccc-f80cbfe5e3ff@suse.de>
Date:   Fri, 7 Jan 2022 00:17:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH] bcache: make stripe_size configurable and persistent for
 hardware raid5/6
Content-Language: en-US
To:     Eric Wheeler <bcache@lists.ewheeler.net>
Cc:     linux-block@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BCACHE (BLOCK LAYER CACHE)" <linux-bcache@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <d3f7fd44-9287-c7fa-ee95-c3b8a4d56c93@suse.de>
 <1561245371-10235-1-git-send-email-bcache@lists.ewheeler.net>
 <200638b0-7cba-38b4-20c4-b325f3cfe862@suse.de>
 <alpine.LRH.2.11.1906241800350.1114@mx.ewheeler.net>
 <8a9131dc-9bf7-a24a-f7b8-35e0c019e905@suse.de>
 <fdb85dc1-eee6-e55e-8e9c-fa1f36b4a37@ewheeler.net>
From:   Coly Li <colyli@suse.de>
In-Reply-To: <fdb85dc1-eee6-e55e-8e9c-fa1f36b4a37@ewheeler.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/22 11:29 AM, Eric Wheeler wrote:
> On Tue, 25 Jun 2019, Coly Li wrote:
>> On 2019/6/25 2:14 上午, Eric Wheeler wrote:
>>> On Mon, 24 Jun 2019, Coly Li wrote:
>>>
>>>> On 2019/6/23 7:16 上午, Eric Wheeler wrote:
>>>>> From: Eric Wheeler <git@linux.ewheeler.net>
>>>>>
>>>>> While some drivers set queue_limits.io_opt (e.g., md raid5), there are
>>>>> currently no SCSI/RAID controller drivers that do.  Previously stripe_size
>>>>> and partial_stripes_expensive were read-only values and could not be
>>>>> tuned by users (eg, for hardware RAID5/6).
>>>>>
>>>>> This patch enables users to save the optimal IO size via sysfs through
>>>>> the backing device attributes stripe_size and partial_stripes_expensive
>>>>> into the bcache superblock.
>>>>>
>>>>> Superblock changes are backwards-compatable:
>>>>>
>>>>> *  partial_stripes_expensive: One bit was used in the superblock flags field
>>>>>
>>>>> *  stripe_size: There are eight 64-bit "pad" fields for future use in
>>>>>     the superblock which default to 0; from those, 32-bits are now used
>>>>>     to save the stripe_size and load at device registration time.
>>>>>
>>>>> Signed-off-by: Eric Wheeler <bcache@linux.ewheeler.net>
>>>> Hi Eric,
>>>>
>>>> In general I am OK with this patch. Since Peter comments lots of SCSI
>>>> RAID devices reports a stripe width, could you please list the hardware
>>>> raid devices which don't list stripe size ? Then we can make decision
>>>> whether it is necessary to have such option enabled.
>>> Perhaps they do not set stripe_width using io_opt? I did a grep to see if
>>> any of them did, but I didn't see them. How is stripe_width indicated by
>>> RAID controllers?
>>>
>>> If they do set io_opt, then at least my Areca 1883 does not set io_opt as
>>> of 4.19.x. I also have a LSI MegaRAID 3108 which does not report io_opt as
>>> of 4.1.x, but that is an older kernel so maybe support has been added
>>> since then.
>>>
>>> Martin,
>>>
>>> Where would stripe_width be configured in the SCSI drivers? Is it visible
>>> through sysfs or debugfs so I can check my hardware support without
>>> hacking debugging the kernel?
>>>
>>>> Another point is, this patch changes struct cache_sb, it is no problem
>>>> to change on-disk format. I plan to update the super block version soon,
>>>> to store more configuration persistently into super block. stripe_size
>>>> can be added to cache_sb with other on-disk changes.
>> Hi Eric,
>>
>>> Maybe bumping version makes sense, but even if you do not, this is safe to
>>> use on systems without bumping the version because the values are unused
>>> and default to 0.
>> Yes, I understand you, it works as you suggested. I need to think how to
>> organize all options in struct cache_sb, stripe_size will be arranged
>> then. And I will ask help to you for reviewing the changes of on-disk
>> format.
> Hi Coli,
>
> Just checking in, its been a while and I didn't see any more discussion on
> the topic:

Hi Eric,

Thank you for reminding me. The persistent on-disk options were that 
much as I thought, so using a reserved space from the on-disk super 
block is fine.

> This would benefit users with older RAID controllers using RAID-5/6 that
> don't set io_opt.
>
> Even new new RAID controlers that _do_ provide `io_opt` still do _not_
> indicate partial_stripes_expensive (which is an mdraid feature, but Martin
> please correct me if I'm wrong here).  Thus, all hardware RAID-5/6 users
> could benefit by manually flagging partial_stripes_expensive to get burst
> writes out of bcache that fit their stride width.

Yeah, I agree with you.

> This patch probably needs rebased and documentation updated about io_opt,
> but here is the original patch with documentation for your reference:
> 	https://lkml.org/lkml/2019/6/22/298
>
> What do you think?

Yes please rebase the patch with latest mainline kernel and let's start 
the review.

Thank you.

Coly Li
