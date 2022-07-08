Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC6D56C26A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239245AbiGHSyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 14:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238146AbiGHSyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 14:54:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1476E18376
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 11:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657306457; x=1688842457;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b23vSjsdeOkIyTIQwYwog34KD9buj9nWZwXKb+E8F1M=;
  b=jgCGVHTEaeKjgxg0c5o1ZCAtIJVkv0AZK6o6ByBNoHyTGStgDNhBc0JD
   4MUGp4yWSh2seXGw5k9MBrjn0L5nOOYPKDtUMjX8WH16ydDSYEblk+WQw
   R4I3zcD4igkOCQ8YeRMhRxEFVfnfcL8F5tSl9uBqYNasuNzXhB4MiyCQH
   KJQYPCvnEXBD7KlVEqqVIO+S3cTqLK7G0kYSd9k2zx3zx//Y/XpvJI+Xp
   TbP3iEDmTbZ0GB0gjUm8y3IsXUdvuy0xG/A5/5PCYTD/+EIveppd0oW5Z
   avdeSP3XX5j39/BetByeTEhnAJ0+01ZiWkR4BQ/bxSRGBb7mg4LxK4cEd
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="285472827"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="285472827"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 11:54:16 -0700
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="626796171"
Received: from yyan2-mobl2.amr.corp.intel.com (HELO [10.212.242.16]) ([10.212.242.16])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 11:54:16 -0700
Message-ID: <2e4d0193-1c5a-ec30-53a1-8009370cde36@intel.com>
Date:   Fri, 8 Jul 2022 11:54:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] x86/mm/tlb: ignore f->new_tlb_gen when zero
Content-Language: en-US
To:     Nadav Amit <namit@vmware.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
References: <20220708003053.158480-1-namit@vmware.com>
 <c5edb95c-3ca3-9339-47d6-6304f9bfd708@intel.com>
 <4F7D1BBF-9695-4DE2-A40E-2D2546B2BAAE@vmware.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <4F7D1BBF-9695-4DE2-A40E-2D2546B2BAAE@vmware.com>
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

On 7/8/22 10:04, Nadav Amit wrote:
> On Jul 8, 2022, at 7:49 AM, Dave Hansen <dave.hansen@intel.com> wrote:
>> On 7/7/22 17:30, Nadav Amit wrote:
>> You might want to fix the clock on the system from which you sent this.
>> I was really scratching my head trying to figure out how you got this
>> patch out before Hugh's bug report.
>>
>>> From: Nadav Amit <namit@vmware.com>
>>>
>>> Commit aa44284960d5 ("x86/mm/tlb: Avoid reading mm_tlb_gen when
>>> possible") introduced an optimization of skipping the flush if the TLB
>>> generation that is flushed (as provided in flush_tlb_info) was already
>>> flushed.
>>>
>>> However, arch_tlbbatch_flush() does not provide any generation in
>>> flush_tlb_info. As a result, try_to_unmap_one() would not perform any
>>> TLB flushes.
>>>
>>> Fix it by checking whether f->new_tlb_gen is nonzero. Zero value is
>>> anyhow is an invalid generation value.
>>
>> It is, but the check below uses 'f->end == TLB_FLUSH_ALL' as the marker
>> for f->new_tlb_gen being invalid.  Being consistent seems like a good
>> idea on this stuff.
> 
> If we get a request to do a flush, regardless whether full or partial,
> that logically we have already done, there is not reason to do it.
> 
> I therefore do not see a reason to look on f->end. I think that looking
> at the generation is very intuitive. If you want, I can add a constant
> such as TLB_GENERATION_INVALID.

That's a good point.

But, _my_ point was that there was only really one read site of
f->new_tlb_gen in flush_tlb_func().  That site is guarded by the "f->end
!= TLB_FLUSH_ALL" check which prevented it from making the same error
that your patch did.

Whatever we do, it would be nice to have a *single* way to check for
"does f->new_tlb_gen have an actual, valid bit of tlb gen data in it?"

Using something like TLB_GENERATION_INVALID seems reasonable to me.

