Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C5152AA64
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351984AbiEQSPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352065AbiEQSOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:14:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF91E51E5D
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652811254; x=1684347254;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LFevrhVgPSdgVLqtIHvJHP4bE5+ugDLGPj3YVhpJFZA=;
  b=QnL4Ag0bt2Hn+vhRXLZ6N1B5GkkLxxQj+hnNf0QjBNlbuOjKoCMFH8QE
   yvljPgdXljfq4sbNLLosqvn1QHucMXkC+rCjb9dZn+LH96NcbYaYKLpU1
   o8dFtUQv5POAxEzyAQwLl0Uy/t++Z5aqJ9VULNUk9LAlupN9tA2aTgyQh
   QS3H9I357LvI9g6OnE3tIjeVFNzVt4SYQgDfGb8V7ILcANLZ5vHI3ubmr
   KBMfDa7Bo8Sfat+ZHhnUwxzTBlUCce2HdhJ6MTy7KH25Tqt+F9QW3Iejr
   yrRf/eAm/VtwgUJciYrv+YJfqcvGO7GX9h+cvSD8kc7S0v67l/pcxzHKo
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="334320352"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="334320352"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 11:14:14 -0700
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="672977686"
Received: from danielga-mobl.amr.corp.intel.com (HELO [10.212.245.96]) ([10.212.245.96])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 11:14:13 -0700
Message-ID: <c761e774-8014-6fa9-cf21-e7cd8f7aca54@intel.com>
Date:   Tue, 17 May 2022 11:14:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] x86/tdx: Handle load_unaligned_zeropad() page-cross to a
 shared page
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        seanjc@google.com, thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220517153021.11116-1-kirill.shutemov@linux.intel.com>
 <e73cb19e-7dab-2fc1-b947-fac70fd607d2@intel.com>
 <20220517174042.v6s7wm3u5j2ebaoq@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220517174042.v6s7wm3u5j2ebaoq@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/22 10:40, Kirill A. Shutemov wrote:
>>
>> ve_info is a software structure.  Why not just add a:
>>
>> 	bool ip_adjusted;
>>
>> which defaults to false, then we have:
>>
>> 	/*
>> 	 * Adjust RIP if the exception was handled
>> 	 * but RIP was not adjusted.
>> 	 */
>> 	if (!ret && !ve_info->ip_adjusted)
>> 		regs->ip += ve_info->instr_len;
>>
>> One other oddity I just stumbled upon:
>>
>> static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
>> {
>> ...
>>         ve->instr_len = insn.length;
>>
>> Why does that need to override 've->instr_len'?  What was wrong with the
>> gunk in r10 that came out of TDX_GET_VEINFO?
> TDX module doesn't decode MMIO instruction and does not provide valid size
> of it. We had to do it manually, based on decoding.

That's worth a comment, don't you think?  I'd add one both in where the
ve_info is filled and where ve->instr_len is adjusted.

> Given that we had to adjust IP in handle_mmio() anyway, do you still think
> "ve->instr_len = 0;" is wrong? I dislike ip_adjusted more.

Something is wrong about it.

You could call it 've->instr_bytes_to_handle' or something.  Then it
makes actual logical sense when you handle it to zero it out.  I just
want it to be more explicit when the upper levels need to do something.

Does ve->instr_len==0 both when the TDX module isn't providing
instruction sizes *and* when no handling is necessary?  That seems like
an unfortunate logical multiplexing of 0.
