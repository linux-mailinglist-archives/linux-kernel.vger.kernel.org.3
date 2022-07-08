Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB3656BDA4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238610AbiGHPNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbiGHPNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:13:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530E84F661
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 08:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657293205; x=1688829205;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qigLlHz72omGc2V/B7goHZMXhuZ8SUNrG2eXAMYhtjo=;
  b=GgfIJ9xg4VvQo95BGQVKLb5AAuZ0dvjL2XHLdn/gd6ggUO7JwE4Mt6X5
   c2fcZA8ZWyiBIYzNWMjmvoFsfo2VPYTDYu3K0pkndTXzYFB/zZv0QXJJ8
   YZw1c7ZFzJRzHp/XWrVI/IV4RgwnTGYAlGuY+4trkA4QH0QzXQ4KfdfBh
   n3POnqwNtYDMpth+dlsboKby4SbaFs0JlXnc3BLXaGVNZIi81t8rv7edf
   W3MqUqqysBs0Z6fNyK76MqBAOehAfa0ZvoBXvSWhANkM+V1Pp3Pdc2XGQ
   aN4BkaLKgs17MDF4XKQo265qjqmywAQpPsbE5BqX/keU6wBtdaBAHxHJM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="264713688"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="264713688"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 08:13:24 -0700
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="626729479"
Received: from yyan2-mobl2.amr.corp.intel.com (HELO [10.212.242.16]) ([10.212.242.16])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 08:13:21 -0700
Message-ID: <283d7660-000a-81af-1d6b-4fdedcb6dfd8@intel.com>
Date:   Fri, 8 Jul 2022 08:13:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] x86/mm/tlb: ignore f->new_tlb_gen when zero
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Linux MM <linux-mm@kvack.org>,
        Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
References: <20220708003053.158480-1-namit@vmware.com>
 <b573a9c6-2ee0-20dc-1f28-84d3a81d40a2@redhat.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <b573a9c6-2ee0-20dc-1f28-84d3a81d40a2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/22 04:40, David Hildenbrand wrote:
>> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
>> index d9314cc8b81f..d81b4084bb8a 100644
>> --- a/arch/x86/mm/tlb.c
>> +++ b/arch/x86/mm/tlb.c
>> @@ -771,14 +771,14 @@ static void flush_tlb_func(void *info)
>>  		return;
>>  	}
>>  
>> -	if (f->new_tlb_gen <= local_tlb_gen) {
>> +	if (unlikely(f->new_tlb_gen != 0 && f->new_tlb_gen <= local_tlb_gen)) {
>>  		/*
>>  		 * The TLB is already up to date in respect to f->new_tlb_gen.
>>  		 * While the core might be still behind mm_tlb_gen, checking
>>  		 * mm_tlb_gen unnecessarily would have negative caching effects
>>  		 * so avoid it.
>>  		 */
>> -		return;
>> +		goto done;
> Does this affect the performance numbers from aa44284960d5 ("x86/mm/tlb:
> Avoid reading mm_tlb_gen when possible")?

It depends on how many batched flushes that workload had.  From the
looks of it, they're all one page:

	madvise(addr + i, pgsize, MADV_DONTNEED);

so there shouldn't be *much* batching in play.  But, it wouldn't hurt to
re-run them in either case.
