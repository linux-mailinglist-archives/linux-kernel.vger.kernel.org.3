Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19624CEC10
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 16:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbiCFPVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 10:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiCFPVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 10:21:06 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68231EC54;
        Sun,  6 Mar 2022 07:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646580014; x=1678116014;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=oMTf5wyKDRnz60MW1+Ttx2dd6gbAHR2sf7Bt1/Kn3fU=;
  b=daBUx6tGCvRGyqU4YZtgXauigIQmrKxZZnQj0eouVXyxg0W0bofq5FLX
   NEsrXveT4bacAZyJ9wXyZcjJ+hXRO+4cO3IR1h/ug6xdoq++qMFKbr/6m
   T06bmy56skGz8+NrycHhD8avhRmOyMdhWP4mVnySOp50vwlQtOSCHOKwi
   TaS+xQnA9wVcn4OXeo4JDPwuRLeLk1xPsNDqAMePeJJxVXZgeMlKG8gp0
   7Cag5zeQlrhJ2yyXMZzPOtVmSvY5ykCI6+f0IrBWi6Z90Le+iBelIxRoH
   n4mHcpGzsT1Pe5HSp4kD7/2YrLi/7DqC85zk1NOEYjDKYHCgasHIYiv8n
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="234193744"
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; 
   d="scan'208";a="234193744"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 07:20:14 -0800
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; 
   d="scan'208";a="552831199"
Received: from hhuan26-mobl1.amr.corp.intel.com (HELO hhuan26-mobl1.mshome.net) ([10.255.37.141])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 06 Mar 2022 07:20:12 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     linux-sgx@vger.kernel.org, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc:     "Reinette Chatre" <reinette.chatre@intel.com>,
        "Nathaniel McCallum" <nathaniel@profian.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86: Add SGX_IOC_ENCLAVE_AUGMENT_PAGES
References: <20220304122852.563475-1-jarkko@kernel.org>
 <13e0c364328ed822c5d358416bb13aa5faea3195.camel@kernel.org>
Date:   Sun, 06 Mar 2022 09:20:11 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel Corp
Message-ID: <op.1il7jxj8wjvjmi@hhuan26-mobl1.mshome.net>
In-Reply-To: <13e0c364328ed822c5d358416bb13aa5faea3195.camel@kernel.org>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Mar 2022 07:50:43 -0600, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Fri, 2022-03-04 at 14:28 +0200, Jarkko Sakkinen wrote:
>> With SGX1 an enclave needs to be created with its maximum memory demands
>> allocated. Pages cannot be added to an enclave after it is initialized.
>> SGX2 introduces a new function, ENCLS[EAUG], that can be used to add  
>> pages
>> to an initialized enclave. With SGX2 the enclave still needs to set  
>> aside
>> address space for its maximum memory demands during enclave creation,  
>> but
>> all pages need not be added before enclave initialization. Pages can be
>> added during enclave runtime.
>>
>> Add support for dynamically adding pages to an initialized enclave with
>> SGX_IOC_ENCLAVE_AUGMENT_PAGES, which performs EAUG's to a given range of
>> pages. Do not enforce any particular permissions from kernel, like is  
>> done
>> for the pages added during the pre-initialization phase, as enclave
>> controls the final permissions and content for these pages by issuing
>> either ENCLU[EACCEPT] (empty RW) or ENCLU[EACCEPTCOPY] (arbitrary data  
>> and
>> permissions).
>>
>> Explicit EAUG ioctl is a better choice than an implicit EAUG from a page
>> fault handler because it allows to have O(1) number of kernel-enclave  
>> round
>> trips for EAUG-EACCEPT{COPY} process, instead of O(n), as it is in the  
>> case
>> when a page fault handler EAUG single page at a time.
>>
>> Cc: Reinette Chatre <reinette.chatre@intel.com>
>> Cc: Nathaniel McCallum <nathaniel@profian.com>
>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>> ---
>> Is contained in sgx2-v2.1 branch of  
>> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-sgx.git
>
> I created sgx2-v2.2 branch, which has #PF EAUG removed. I
> also moved selftests to the tail in the patch sets so that
> it is easier to update them reflecting these and future
> changes. Having them intervened makes things just complicated.
>
> I focus now to implement mmap() for Enarx with this, so no
> kselftest update just yet.
>
> Roughly the sequence in Enarx is:
>
> 1. Enclave traps on syscall (opcode).
> 2. Host jumps to shim expection handler.
> 3. Enclave copies the mmap() arguments to a buffer outside
>    the enclave.
> 4. Enclave exists back to the host.
> 5. Host performs EAUG to the mmap range.
> 6. Host performs mmap() to the mmap range, which succeeds
>    given that vm_max_prot_bits is RWX (i.e. disabled for
>    dynamic pages).
> 7. Host jumps back to the enclave and execution continues
>    there in the mmap handler.
> 8. mmap handler does a series of EACCEPTCOPY operations for
>    the range with given permissions and empty page as the
>    input data.
>
EACCEPTCOPY will require target pages with RW in PTE. So you would need to  
make mprotect to change PTE permissions afterwards depending on your  
target permissions.

Without knowing much your context, if your intent is to  
EACCEPTCOPY(EPCM.RX/EPCM.R, EPCM.pending), then I don't see how the page  
can be used later without making it RW again first, and copy real data  
into it.
So these empty EACCEPTCOPYs may be better just EACCEPTs(EPCM.RW,  
EPCM.pending). Then after copy real data into the pages, you do  
EMODPE/EMODPR as needed.


EACCEPTCOPY would make more sense when you already have data to be copied  
into the EAUG'd but pending EPC pages.

> Some details might differ a bit but this gives the basic idea.
> I like the fact the roud-trips are kind of in control and not
> variable, and it is pretty easy to use to implement the basic
> syscall behaviour. This has of course some corner cases but
> my sequence describes the main flow anyway.
>
> Take it or leave it but this does give at least for me a sound
> way to implement my workload. I'll use this up until my changes
> have been inducted to the original patch set, or it starts to
> look sane with other solutions. The original patch set simply
> does not work for us at all.
>
> BR, Jarkko
