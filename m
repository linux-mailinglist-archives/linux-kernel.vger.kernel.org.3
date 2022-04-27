Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F938511DD8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243520AbiD0QzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243460AbiD0QzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:55:05 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E6748595F;
        Wed, 27 Apr 2022 09:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=URL+c5/vZ6aofEkqFHrvdQ7mBKLC6V/tbjHWkNdjhBQ=; b=Mo/RWVda43s65aSJsiNQxY3QX/
        hcB+PIpJKk/ykLCq+WHBe0ACNkgZML2ZTHgQvAbgz3s+VpR65foBLUb3bCQq6fUMG3wt/wBN7KQOF
        c3wSNNRWVLZYecewOR7sAAYaCFh5cC0tFXuIQuog7MyD1tx47X6u58H3MtzykfPkLTEeCLoDvnzw0
        ywkQGRaNk9+6vBtyjMLHU8iU5TJFoGHhq7MjIAy7qP+IZ5GLAAzziuofdHCyE/yC1XswJhV02rORp
        q0HlimHxXoExG2RDlMohRoDwUZjy6RZjoEBwKmM9wv7APZ3g32x0SBS1YUQeGTic6TqmBuqlbMQ69
        t1TZH0hw==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1njkMg-000KFO-M4; Wed, 27 Apr 2022 10:18:08 -0600
Message-ID: <67153d42-93c0-def1-95d9-a09678cf343d@deltatee.com>
Date:   Wed, 27 Apr 2022 10:18:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-13-logang@deltatee.com>
 <61411981-6401-aaa7-9d3d-6a9ac1fec4f2@linux.dev>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <61411981-6401-aaa7-9d3d-6a9ac1fec4f2@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: guoqing.jiang@linux.dev, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2 12/12] md/raid5: Pivot raid5_make_request()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-04-26 20:06, Guoqing Jiang wrote:
>>   +static int add_all_stripe_bios(struct stripe_head *sh, struct bio *bi,
>> +        sector_t first_logical_sector, sector_t last_sector,
>> +        int forwrite, int previous)
>> +{
>> +    int dd_idx;
>> +    int ret = 1;
>> +
>> +    spin_lock_irq(&sh->stripe_lock);
>> +
>> +    for (dd_idx = 0; dd_idx < sh->disks; dd_idx++) {
>> +        struct r5dev *dev = &sh->dev[dd_idx];
>> +
>> +        clear_bit(R5_BioReady, &dev->flags);
>> +
>> +        if (dd_idx == sh->pd_idx)
>> +            continue;
>> +
>> +        if (dev->sector < first_logical_sector ||
>> +            dev->sector >= last_sector)
>> +            continue;
>> +
>> +        if (stripe_bio_overlaps(sh, bi, dd_idx, forwrite)) {
>> +            set_bit(R5_Overlap, &dev->flags);
>> +            ret = 0;
>> +            continue;
>> +        }
>> +
>> +        set_bit(R5_BioReady, &dev->flags);
> 
> Is  it possible to just call __add_stripe_bio here? And change above
> "continue"
> to "return",

No. The reason it was done this way is because we either have to add the
bio to all the disks or none of them. Otherwise, if one fails and we
have to retry and we can't know which stripes were already added or not.

>> @@ -5869,6 +5911,10 @@ enum stripe_result {
>>   struct stripe_request_ctx {
>>       bool do_flush;
>>       struct stripe_head *batch_last;
>> +    sector_t disk_sector_done;
>> +    sector_t start_disk_sector;
>> +    bool first_wrap;
>> +    sector_t last_sector;
>>   };
> 
> Could you add some comments to above members if possible?

Yes, Christoph already asked for this and I've reworked this patch to
make it much clearer for v3.

>>   static enum stripe_result make_stripe_request(struct mddev *mddev,
>> @@ -5908,6 +5954,36 @@ static enum stripe_result
>> make_stripe_request(struct mddev *mddev,
>>         new_sector = raid5_compute_sector(conf, logical_sector, previous,
>>                         &dd_idx, NULL);
>> +
>> +    /*
>> +     * This is a tricky algorithm to figure out which stripe_heads that
>> +     * have already been visited and exit early if the stripe_head has
>> +     * already been done. (Seeing all disks are added to a stripe_head
>> +     * once in add_all_stripe_bios().
>> +     *
>> +     * To start with, the disk sector of the last stripe that has been
>> +     * completed is stored in ctx->disk_sector_done. If the
>> new_sector is
>> +     * less than this value, the stripe_head has already been done.
>> +     *
>> +     * There's one issue with this: if the request starts in the
>> middle of
>> +     * a chunk, all the stripe heads before the starting offset will be
>> +     * missed. To account for this, set the first_wrap boolean to true
>> +     * if new_sector is less than the starting sector. Clear the
>> +     * boolean once the start sector is hit for the second time.
>> +     * When first_wrap is set, ignore the disk_sector_done.
>> +     */
>> +    if (ctx->start_disk_sector == MaxSector) {
>> +        ctx->start_disk_sector = new_sector;
>> +    } else if (new_sector < ctx->start_disk_sector) {
>> +        ctx->first_wrap = true;
>> +    } else if (new_sector == ctx->start_disk_sector) {
>> +        ctx->first_wrap = false;
>> +        ctx->start_disk_sector = 0;
>> +        return STRIPE_SUCCESS;
>> +    } else if (!ctx->first_wrap && new_sector <=
>> ctx->disk_sector_done) {
>> +        return STRIPE_SUCCESS;
>> +    }
>> +
> 
> Hmm, with above tricky algorithm, I guess the point is that we can avoid
> to call below
> stripe_add_to_batch_list where has hash_lock contention. If so, maybe we
> can change
> stripe_can_batch for the purpose.

No, that's not the purpose. The purpose is to add the bio to the stripe
for every disk, so that we can avoid calling find_get_stripe() for every
single page and only call it once per stripe head.


>> diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
>> index 638d29863503..e73b58844f83 100644
>> --- a/drivers/md/raid5.h
>> +++ b/drivers/md/raid5.h
>> @@ -308,6 +308,7 @@ enum r5dev_flags {
>>       R5_Wantwrite,
>>       R5_Overlap,    /* There is a pending overlapping request
>>                * on this block */
>> +    R5_BioReady,    /* The current bio can be added to this disk */
> 
> This doesn't seem right to me, since the comment describes bio status
> while others
> are probably for r5dev.

I'm not sure I understand the objection. If you have a better option
please let me know.

I'm still working on this patch. Caught a couple more rare bugs that I'm
working to fix. The next version should also hopefully be clearer.

Thanks,

Logan


