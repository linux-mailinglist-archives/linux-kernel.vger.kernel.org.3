Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E8B54D562
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 01:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbiFOXew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 19:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350553AbiFOXev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 19:34:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FF51A077
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 16:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655336089; x=1686872089;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FVibG3O2Jo4wE/8uawKSqXUP1QevxdRcM/UXljHqIJU=;
  b=BHRmxsMg380f1oJMBB9HtZ4qpNP3bQEB4V1fj83+PAFOWktIPAPsArKB
   1CivRE9WAD1CRkGymR/6NL6J2BX6MyLHJZkndyys1Aoh+n3T7EyBvpN0l
   ysxyF7cgWfkGwaCuI7OcNxxCqIueX51BwKUggPq1GI156NFC8XoSlCQTA
   EGc8YiUUa5S9lb4rM/DrlPNihIJeXw2qbq9B5Cm3aEhAsargLPeFrKOep
   5pEXxc/l05pG8WMf/4zH6pQn3/erYm8CXf+1riZNIMOXtFrSPseWnRLIl
   n7Vdh+7Q5wlmeODnS2bMawfp4gNsUtWv7ERVOlyXfeTKLQacdaYABQ8g6
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="277920172"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="277920172"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 16:34:48 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="559425521"
Received: from mjortiz-mobl.amr.corp.intel.com (HELO [10.212.185.241]) ([10.212.185.241])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 16:34:48 -0700
Message-ID: <db63853f-dbd8-7593-032d-e674046bff8e@intel.com>
Date:   Wed, 15 Jun 2022 16:34:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv4 3/3] x86/tdx: Handle load_unaligned_zeropad() page-cross
 to a shared page
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org
References: <20220614120135.14812-1-kirill.shutemov@linux.intel.com>
 <20220614120135.14812-4-kirill.shutemov@linux.intel.com>
 <20220615225200.lflv4tbqus6lnj5u@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220615225200.lflv4tbqus6lnj5u@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 15:52, Kirill A. Shutemov wrote:
>> +	vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
>> +	if (vaddr / PAGE_SIZE != (vaddr + size) / PAGE_SIZE)
> Oops. I just realized it has off-by-one. It supposed to be:
> 
> 	if (vaddr / PAGE_SIZE != (vaddr + size - 1) / PAGE_SIZE)

That was bugging me.  Glad you caught this.

Wouldn't this be more obviously correct?

	if (ALIGN_DOWN(vaddr,        PAGE_SIZE) !=
	    ALIGN_DOWN(vaddr + size, PAGE_SIZE))
		...

I don't think we have a PAGE_ALIGN_DOWN().
