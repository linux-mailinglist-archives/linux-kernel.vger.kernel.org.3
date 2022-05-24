Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6837C532DC7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239020AbiEXPpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbiEXPpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:45:43 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DC995A11;
        Tue, 24 May 2022 08:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=T6zlot3ktjW4h9JkP+I087i4ffSVuTb7wcQm48Kac30=; b=TQ65ng/jNoH4DKot65FILApX5O
        daYYM9H80SQbqsyKw7cSXg+f0tDknOSMcc0FZHFPbFg6o8QfR25ctkCDW4+dR5gPffciVq4AV0yTw
        QQ+T8XP8Q4f7w37IgBRKkMESoQ4TA+dmcLjTccuqs5clzz5C7VsolEVgeTpM6A+stLEDle8GpDjvE
        lefhtPefz2fDhIHYO2euUlvuqcGmaB4SLBa6SAThgCE6boUBZ81D3/7X9PA2pWrYH67t1krrZOYep
        19z9KkZ1MeLctBGD00n5t7fNycbyiPDiExZFbkqvnO0NrSQmqRI4mWsOB+kpZuRmOfhkc1RhUQkuk
        U0l0oXUg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1ntWj1-006QyR-KH; Tue, 24 May 2022 09:45:39 -0600
Message-ID: <951ee1ca-88e9-3c62-fbf9-a147451b443e@deltatee.com>
Date:   Tue, 24 May 2022 09:45:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-CA
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220519191311.17119-1-logang@deltatee.com>
 <20220519191311.17119-15-logang@deltatee.com>
 <YojSVXNF1ITIhlUl@infradead.org>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <YojSVXNF1ITIhlUl@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@infradead.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, guoqing.jiang@linux.dev, xni@redhat.com, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v1 14/15] md: Ensure resync is reported after it starts
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-05-21 05:51, Christoph Hellwig wrote:
> On Thu, May 19, 2022 at 01:13:10PM -0600, Logan Gunthorpe wrote:
>> The 07layouts test in mdadm fails on some systems. The failure
>> presents itself as the backup file not being removed before the next
>> layout is grown into:
>>
>>   mdadm: /dev/md0: cannot create backup file /tmp/md-test-backup:
>>       File exists
>>
>> This is because the background mdadm process, which is responsible for
>> cleaning up this backup file gets into an infinite loop waiting for
>> the reshape to start. mdadm checks the mdstat file if a reshape is
>> going and, if it is not, it waits for an event on the file or times
>> out in 5 seconds. On faster machines, the reshape may complete before
>> the 5 seconds times out, and thus the background mdadm process loops
>> waiting for a reshape to start that has already occurred.
>>
>> mdadm reads the mdstat file to start, but mdstat does not report that the
>> reshape has begun, even though it has indeed begun. So the mdstat_wait()
>> call (in mdadm) which polls on the mdstat file won't ever return until
>> timing out.
>>
>> The reason mdstat reports the reshape has started is due to an issue
>> in status_resync(). recovery_active is subtracted from curr_resync which
>> will result in a value of zero for the first chunk of reshaped data, and
>> the resulting read will report no reshape in progress.
>>
>> To fix this, if "resync - recovery_active" is zero: force the value to
>> be 4 so the code reports a resync in progress.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>  drivers/md/md.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 8273ac5eef06..dbac63c8e35c 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -8022,10 +8022,18 @@ static int status_resync(struct seq_file *seq, struct mddev *mddev)
>>  		if (test_bit(MD_RECOVERY_DONE, &mddev->recovery))
>>  			/* Still cleaning up */
>>  			resync = max_sectors;
>> -	} else if (resync > max_sectors)
>> +	} else if (resync > max_sectors) {
>>  		resync = max_sectors;
>> -	else
>> +	} else {
>>  		resync -= atomic_read(&mddev->recovery_active);
>> +		if (!resync) {
>> +			/*
>> +			 * Resync has started, but if it's zero, ensure
>> +			 * it is still reported, by forcing it to be 4
>> +			 */
>> +			resync = 4;
> 
> Where does this magic 4 come from?

There are a bunch of existing magic numbers in this code. Just before
this hunk there's a if (resync <= 3) and just after the code there's an
if (resync < 3).

There's a comment in md_do_sync() indicating overloaded values for 1 and
2. I can try and turn this into an enum for v2.

Logan

