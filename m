Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752C7535458
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348914AbiEZUS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiEZUS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:18:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27955C964A
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653596307; x=1685132307;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U+Ch9vTrwploO8vWhtYTLVwOMyG4nbopiYBQXxPiejI=;
  b=hypdEUT/ErJF4YQ7CixmrujZiFV2fDPrv88/wmFcmo0Q8xeOn8TkpyRR
   BMjDtzNL5Z2tExDeDqgkHjk8gxphMQXSWC4TO9SpmmRuNQXLKjsi4z5kG
   NUlXZO1oHz0GcXv1g7wnB+xK0aOgvD8AqEgJue8JKHwb/emn8Rgdd9XVk
   So9XVgtcDX49ci3AbiEOhLTh3hJ+Tozv05bMy5+/qpBF0syCSTJ3mNeCf
   Knkj6EK5oGXkZPeOR0s8K0CuWLDWQ2ktBGIJpx+kjr9jugJHswKYe6ADh
   /vZm3aYYQjLT+62p9aqIbsEE1epOEJoxc+m1kaaLgorIxoHV65rFTtRFY
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="261893360"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="261893360"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 13:18:26 -0700
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="643053535"
Received: from tjeziers-mobl1.amr.corp.intel.com (HELO [10.251.23.34]) ([10.251.23.34])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 13:18:25 -0700
Message-ID: <cc7ee242-31dd-5df5-7685-219b38b6f499@intel.com>
Date:   Thu, 26 May 2022 13:18:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv3 2/3] x86/tdx: Clarify RIP adjustments in #VE handler
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org
References: <20220524221012.62332-1-kirill.shutemov@linux.intel.com>
 <20220524221012.62332-3-kirill.shutemov@linux.intel.com>
 <89f55141-a71c-1fd8-e1be-96355c63c03a@intel.com>
 <20220526201354.v5a6fsi4aiuet2d7@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220526201354.v5a6fsi4aiuet2d7@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/22 13:13, Kirill A. Shutemov wrote:
>> I'm not super happy with how this comment ended up.  First, let's put
>> the comment next to the code to which it applies, like:
>>
>> 	/*
>> 	 * ve->instr_len is not defined for EPT violations.  For those,
>> 	 * the kernel must decode instructions manually and should not
>> 	 * be using this function.
>> 	 */
>> 	if (WARN_ON_ONCE(ve->exit_reason == EXIT_REASON_EPT_VIOLATION))
>> 		return 0;
>>
>> 	/*
>> 	 * Assume that the #VE occurred due to instruction execution.
>> 	 */
>> 	return ve->instr_len;
> Would it be helpful if the function has a whitelist of exit resons where
> using ve->instr_len is safe? WARN_ONCE() and return 0 otherwise.

Maybe.  I was hoping to avoid mostly duplicating the
virt_exception_kernel() switch().

