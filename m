Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76BB58E93B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbiHJJDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiHJJC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:02:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E7786C06
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:02:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B8563352B6;
        Wed, 10 Aug 2022 09:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660122175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9tcVsVn5VClQjk7I12jMWIHY3wKjQAIG7Omh7DjQH00=;
        b=21rn5ZzzCFPhkvjqCeNHpYOpU2hheNmBGaRQrQI3owYryz/iPkWsEagB82sDVjez1pKk+b
        Ays3MBJKZ2U90brtPggRXZvYVjW24Bz+IpMm0QpPDG4JmwcUN4uXpseR/2L+cfOe3QMwQW
        iBATsdtzdEzVob/Fr33+k5UjdJyKYU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660122175;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9tcVsVn5VClQjk7I12jMWIHY3wKjQAIG7Omh7DjQH00=;
        b=uGMCzgk1tQxH/LrROKTU1jPj3nkJKBGy83dZZDPewIlWv2IpVvbssQjCJJ78+K74P3jg9C
        Q6Fps/pS1REj4ODw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B11813A7E;
        Wed, 10 Aug 2022 09:02:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0d9xHD9082LYEQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 10 Aug 2022 09:02:55 +0000
Message-ID: <fdb181de-adc7-47aa-c4d7-c26fb50454b2@suse.cz>
Date:   Wed, 10 Aug 2022 11:02:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v5] mm/page_owner.c: add llseek for page_owner
Content-Language: en-US
To:     Kassey Li <quic_yingangl@quicinc.com>,
        "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
        akpm@linux-foundation.org
Cc:     minchan@kernel.org, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220809024725.31980-1-quic_yingangl@quicinc.com>
 <ab4f79ea-0a02-9556-645f-cca32dea3cad@kernel.org>
 <8f64c6d5-940f-f081-7671-53e1507c8051@quicinc.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <8f64c6d5-940f-f081-7671-53e1507c8051@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 03:33, Kassey Li wrote:
> 
> 
> On 8/9/2022 5:30 PM, Vlastimil Babka (SUSE) wrote:
>> On 8/9/22 04:47, Kassey Li wrote:
>>> There is usage to dump a given cma region page_owner
>>> instead of all page's.
>>>
>>> This change allows to specify a ppos as start_pfn
>>> by fseek.
>>>
>>> Any invalid ppos will be skipped, so it did not
>>> broken the origin dump feature.
>>>
>>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>>> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
>>> ---
>>>    Documentation/vm/page_owner.rst | 6 ++++++
>>>    mm/internal.h                   | 5 +++++
>>>    mm/page_owner.c                 | 9 ++++++---
>>>    3 files changed, 17 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
>>> index f5c954afe97c..8d33d976da8a 100644
>>> --- a/Documentation/vm/page_owner.rst
>>> +++ b/Documentation/vm/page_owner.rst
>>> @@ -95,6 +95,12 @@ Usage
>>>    	PFN XXX ...
>>>    	// Detailed stack
>>>    
>>> +   By default, it will do full pfn dump, to start with a given pfn,
>>> +   page_owner supports fseek.
>>> +
>>> +   FILE *fp = fopen("/sys/kernel/debug/page_owner", "r");
>>> +   fseek(fp, pfn_start, SEEK_SET);
>>> +
>>>       The ``page_owner_sort`` tool ignores ``PFN`` rows, puts the remaining rows
>>>       in buf, uses regexp to extract the page order value, counts the times
>>>       and pages of buf, and finally sorts them according to the parameter(s).
>>> diff --git a/mm/internal.h b/mm/internal.h
>>> index c0f8fbe0445b..1ad8f86e6e33 100644
>>> --- a/mm/internal.h
>>> +++ b/mm/internal.h
>>> @@ -189,6 +189,11 @@ extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason
>>>     */
>>>    extern pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address);
>>>    
>>> +/*
>>> + * in mm/page_owner.c:
>>
>> This should say where it's defined, not used from, and that's
>> fs/proc/base.c. But it's already declared in fs/proc/internal.h so maybe
>> page_owner.c could just include that header (although it's a bit meh).
> ok, let's do it.

Sorry, my suggestion was wrong as the kernel test bot just showed us. 
mem_lseek() may be unavailable without CONFIG_PROC_FS.
The easiest way is you add a page_owner specific one back, but make it 
correct for SEEK_CUR. Thanks.

>>
>>> + */
>>> +extern loff_t mem_lseek(struct file *, loff_t, int);
>>> +
>>>    /*
>>>     * in mm/page_alloc.c
>>>     */
>>> diff --git a/mm/page_owner.c b/mm/page_owner.c
>>> index e4c6f3f1695b..dcbe05e206e1 100644
>>> --- a/mm/page_owner.c
>>> +++ b/mm/page_owner.c
>>> @@ -497,8 +497,10 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>>>    		return -EINVAL;
>>>    
>>>    	page = NULL;
>>> -	pfn = min_low_pfn + *ppos;
>>> -
>>> +	if (*ppos == 0)
>>> +		pfn= min_low_pfn;
>>
>> missing space before '='
> 
>     my bad, for v6
> 
> ./scripts/checkpatch.pl
> v6-0001-mm-page_owner.c-add-llseek-for-page_owner.patch
> total: 0 errors, 0 warnings, 46 lines checked
> 
> v6-0001-mm-page_owner.c-add-llseek-for-page_owner.patch has no obvious
> style problems and is ready for submission.
>>
>>> +	else
>>> +		pfn = *ppos;
>>>    	/* Find a valid PFN or the start of a MAX_ORDER_NR_PAGES area */
>>>    	while (!pfn_valid(pfn) && (pfn & (MAX_ORDER_NR_PAGES - 1)) != 0)
>>>    		pfn++;
>>> @@ -561,7 +563,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>>>    			continue;
>>>    
>>>    		/* Record the next PFN to read in the file offset */
>>> -		*ppos = (pfn - min_low_pfn) + 1;
>>> +		*ppos = pfn + 1;
>>>    
>>>    		return print_page_owner(buf, count, pfn, page,
>>>    				page_owner, handle);
>>> @@ -660,6 +662,7 @@ static void init_early_allocated_pages(void)
>>>    
>>>    static const struct file_operations proc_page_owner_operations = {
>>>    	.read		= read_page_owner,
>>> +	.llseek 	= mem_lseek,
>>>    };
>>>    
>>>    static int __init pageowner_init(void)
>>

