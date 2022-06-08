Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593D3543B63
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 20:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiFHSV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 14:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbiFHSVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 14:21:54 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2EF1C116;
        Wed,  8 Jun 2022 11:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=XkHYb+oSLXpBEo6cMCxhRVOvyJgyvCtSljAnI7lNXXs=; b=dMHipBDXa0Xk7SK9ngGdmavKtu
        1iGj6Wpj4Oup+A1YqQ38iNCwOd6Z0Dp9AYpaGR6Wodq86/c2sw2fPweXbUW8qf8WUF0p/OjEJpVI0
        DmYiI7SVKaCkBEebjgJ4fsaBCakf+w/0HzcENdOY6m5WXlRn5IsJYdsFag/mhpg9AJJTUwSoBEDkZ
        GNP8av8fYRVGWzCXSeldXEmIW9QkY1BKk5SPjgcR2mHVggTjPLK+D67BEhPT9eVpf4doOsGSSsNec
        ogK9HDp1Atv+v2LQpzqUGm8EHynoNyyzqyqSTNAHHYiOTgA8dXxqsIAejkeK7DgHIQ6031aM5/tOd
        u1Y7TwGg==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nz0JP-0028yT-Ow; Wed, 08 Jun 2022 12:21:48 -0600
Message-ID: <08b80caa-d726-b9f3-7ce0-f486b8080ec5@deltatee.com>
Date:   Wed, 8 Jun 2022 12:21:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Song Liu <song@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Christoph Hellwig <hch@lst.de>
References: <20220608162756.144600-1-logang@deltatee.com>
 <20220608162756.144600-5-logang@deltatee.com>
 <CAPhsuW6-kt+MvmaT_5aii7bnJ8N352S30Gr6wVoP4xjP20-GiQ@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <CAPhsuW6-kt+MvmaT_5aii7bnJ8N352S30Gr6wVoP4xjP20-GiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: song@kernel.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, hch@infradead.org, buczek@molgen.mpg.de, guoqing.jiang@linux.dev, xni@redhat.com, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v4 04/11] md/raid5: Ensure array is suspended for calls to
 log_exit()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-06-08 11:59, Song Liu wrote:
> On Wed, Jun 8, 2022 at 9:28 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>>
>> The raid5-cache code relies on there being no IO in flight when
>> log_exit() is called. There are two places where this is not
>> guaranteed so add mddev_suspend() and mddev_resume() calls to these
>> sites.
>>
>> The site in raid5_remove_disk() has a comment saying that it is
>> called in raid5d and thus cannot wait for pending writes; however that
>> does not appear to be correct anymore (if it ever was) as
>> raid5_remove_disk() is called from hot_remove_disk() which only
>> appears to be called in the md_ioctl(). Thus, the comment is removed,
>> as well as the racy check and replaced with calls to suspend/resume.
>>
>> The site in raid5_change_consistency_policy() is in the error path,
>> and another similar call site already has suspend/resume calls just
>> below it; so it should be equally safe to make that change here.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  drivers/md/raid5.c | 18 ++++++------------
>>  1 file changed, 6 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>> index 5d09256d7f81..3ad37dd4c5cd 100644
>> --- a/drivers/md/raid5.c
>> +++ b/drivers/md/raid5.c
>> @@ -7938,18 +7938,9 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
>>
>>         print_raid5_conf(conf);
>>         if (test_bit(Journal, &rdev->flags) && conf->log) {
>> -               /*
>> -                * we can't wait pending write here, as this is called in
>> -                * raid5d, wait will deadlock.
>> -                * neilb: there is no locking about new writes here,
>> -                * so this cannot be safe.
>> -                */
>> -               if (atomic_read(&conf->active_stripes) ||
>> -                   atomic_read(&conf->r5c_cached_full_stripes) ||
>> -                   atomic_read(&conf->r5c_cached_partial_stripes)) {
>> -                       return -EBUSY;
>> -               }
>> +               mddev_suspend(mddev);
> 
> Unfortunately, the comment about deadlock is still true, and we cannot call
> mddev_suspend here. To trigger it:

Ah, yes. What a tangle. I think we can just drop this patch. Now that we
are removing RCU it isn't actually necessary to fix the bug I was
seeing. It's still probably broken as the comment notes though.

Thanks,

Logan
