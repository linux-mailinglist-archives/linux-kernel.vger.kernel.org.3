Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BE24C429A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239695AbiBYKkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239691AbiBYKkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:40:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F14868F9E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:39:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EA49221114;
        Fri, 25 Feb 2022 10:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645785588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ahs8xAWJnTUeFm8mayyoprYbMUR2xi8uypk5DkAI7Jk=;
        b=li02W+4CVQaEnfPXLfd+rNHAW9NiRUJ9keX1sztepXJ/9vi+6SoZyAH2OWSHt7B5mOfMmz
        VJnxpZMKAni6EBeJl5tSQa2rPsjtxn8ZoLudn6rGxaa2WS5rooI06DkuJaWgJRpLMRTOeE
        Y8Djg+789HA/LUhOrfzyM+6sj5wOy8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645785588;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ahs8xAWJnTUeFm8mayyoprYbMUR2xi8uypk5DkAI7Jk=;
        b=Dyg22q9OODbCq/87IZuFouV9ej6aWXRNegKPYGtW3hn1IVrSH175qsaJEENlKapHVCfwdX
        sQpMuw7bxCQHrzCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B721713ACB;
        Fri, 25 Feb 2022 10:39:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id r+IELPSxGGJ4eAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 25 Feb 2022 10:39:48 +0000
Message-ID: <d7f56188-5512-1365-243a-1e70acddf5c1@suse.cz>
Date:   Fri, 25 Feb 2022 11:39:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>,
        =?UTF-8?Q?Jakub_Mat=c4=9bna?= <matenajakub@gmail.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "willy@infradead.org" <willy@infradead.org>,
        "hughd@google.com" <hughd@google.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "riel@surriel.com" <riel@surriel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "peterz@infradead.org" <peterz@infradead.org>
References: <20220218122019.130274-1-matenajakub@gmail.com>
 <20220218122019.130274-5-matenajakub@gmail.com>
 <20220218195729.oa5olrcsq6yox7hp@revolver>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH 4/4] [PATCH 4/4] mm: add tracing for VMA merges
In-Reply-To: <20220218195729.oa5olrcsq6yox7hp@revolver>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/22 20:57, Liam Howlett wrote:
>>  	/*
>>  	 * Can we merge both predecessor and successor?
>>  	 */
>> -	if (merge_prev && merge_next)
>> +	if (merge_prev >= MERGE_OK && merge_next >= MERGE_OK) {
> 
> What happened to making vma_merge easier to read?  What does > MERGE_OK
> mean?  I guess this answers why booleans were not used, but I don't like

It's similar to e.g. enum compact_priority where specific values are defined
as well as more abstract aliases.

> it.   Couldn't you just log the err/success and the value of
> merge_prev/merge_next?  It's not like the code tries more than one way
> of merging on failure..

An initial version had the "log" (trace point really) at multiple places and
it was uglier than collecting details in the variables and having a single
tracepoint call site.

Note that the tracepoint is being provided as part of the series mainly to
allow evaluation of the series. If it's deemed too specific to be included
in mainline in the end, so be it.

>>  		merge_both = is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL);
>> +	}
>>  
>> -	if (merge_both) {	 /* cases 1, 6 */
>> +	if (merge_both >= MERGE_OK) {	 /* cases 1, 6 */
>>  		err = __vma_adjust(prev, prev->vm_start,
>>  					next->vm_end, prev->vm_pgoff, NULL,
>>  					prev);
>>  		area = prev;
>> -	} else if (merge_prev) {			/* cases 2, 5, 7 */
>> +	} else if (merge_prev >= MERGE_OK) {			/* cases 2, 5, 7 */
>>  		err = __vma_adjust(prev, prev->vm_start,
>>  					end, prev->vm_pgoff, NULL, prev);
>>  		area = prev;
>> -	} else if (merge_next) {
>> +	} else if (merge_next >= MERGE_OK) {
>>  		if (prev && addr < prev->vm_end)	/* case 4 */
>>  			err = __vma_adjust(prev, prev->vm_start,
>>  					addr, prev->vm_pgoff, NULL, next);
>> @@ -1252,7 +1255,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
>>  	} else {
>>  		err = -1;
>>  	}
>> -
>> +	trace_vm_av_merge(err, merge_prev, merge_next, merge_both);
>>  	/*
>>  	 * Cannot merge with predecessor or successor or error in __vma_adjust?
>>  	 */
>> @@ -3359,6 +3362,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>>  		/*
>>  		 * Source vma may have been merged into new_vma
>>  		 */
>> +		trace_vm_pgoff_merge(vma, anon_pgoff_updated);
>> +
>>  		if (unlikely(vma_start >= new_vma->vm_start &&
>>  			     vma_start < new_vma->vm_end)) {
>>  			/*
>> -- 
>> 2.34.1
>> 

