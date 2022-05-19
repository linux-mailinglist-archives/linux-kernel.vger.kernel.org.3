Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B7E52DCA1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243788AbiESSUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243449AbiESSUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:20:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3517DE31F
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652984402; x=1684520402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+VuGm4N3P21KFNW/0eDHoPsb2X5lWcoB1LwPTfwvwfE=;
  b=f7RvDR5b//jB91WwX3Q1HkZd7ozl71/kDQ1xY0Zj51/FuzpTJEm1tAVL
   QXfpXYGiWmQRU8YKQj0ZzonTemeOheyTQBdoEuZE36digXXNCnaw1JIIp
   zOWp+rJ3Vy56Ou8sy6ASp0hqgSpBg3DFtYnjgOONcitvVorKHQfYP94Hh
   2LxA08tGUg7RX1uwGPOFA8mu4Tnvs/3BF13ZcIANnG7TWVaadMDH5Ay4F
   /5157cc0yVAd4Z1BgKOvwfkHtSpKZkKec7glg3tm490tjtZQJKMAzhZMN
   LpewNPqIRJmbPK+sqxakJVDnd1b1Rm2tcZeabZv1zIyU/pDDEKKMGbR8B
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272444650"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="272444650"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 11:20:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="627743589"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 19 May 2022 11:19:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id DA7D9109; Thu, 19 May 2022 21:19:58 +0300 (EEST)
Date:   Thu, 19 May 2022 21:19:58 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tdx: Handle load_unaligned_zeropad() page-cross to a
 shared page
Message-ID: <20220519181958.libitxp2jws4prcr@black.fi.intel.com>
References: <20220517153021.11116-1-kirill.shutemov@linux.intel.com>
 <e73cb19e-7dab-2fc1-b947-fac70fd607d2@intel.com>
 <20220517174042.v6s7wm3u5j2ebaoq@black.fi.intel.com>
 <c761e774-8014-6fa9-cf21-e7cd8f7aca54@intel.com>
 <20220517201710.ixbpsaga5jzvokvy@black.fi.intel.com>
 <083519ab-752f-9815-7741-22b3fcc03322@intel.com>
 <YoQkTtrMiU2bff9i@google.com>
 <YoQnQIfX8GuOgKqH@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoQnQIfX8GuOgKqH@google.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 10:52:48PM +0000, Sean Christopherson wrote:
> On Tue, May 17, 2022, Sean Christopherson wrote:
> > On Tue, May 17, 2022, Dave Hansen wrote:
> > > On 5/17/22 13:17, Kirill A. Shutemov wrote:
> > > >>> Given that we had to adjust IP in handle_mmio() anyway, do you still think
> > > >>> "ve->instr_len = 0;" is wrong? I dislike ip_adjusted more.
> > > >> Something is wrong about it.
> > > >>
> > > >> You could call it 've->instr_bytes_to_handle' or something. Then it
> > > >> makes actual logical sense when you handle it to zero it out.  I just
> > > >> want it to be more explicit when the upper levels need to do something.
> > > >>
> > > >> Does ve->instr_len==0 both when the TDX module isn't providing
> > > >> instruction sizes *and* when no handling is necessary?  That seems like
> > > >> an unfortunate logical multiplexing of 0.
> > > > For EPT violation, ve->instr_len has *something* (not zero) that doesn't
> > > > match the actual instruction size. I dig out that it is filled with data
> > > > from VMREAD(0x440C), but I don't know where is the ultimate origin of the
> > > > data.
> > > 
> > > The SDM has a breakdown:
> > > 
> > > 	27.2.5 Information for VM Exits Due to Instruction Execution
> > > 
> > > I didn't realize it came from VMREAD.  I guess I assumed it came from
> > > some TDX module magic.  Silly me.
> > > 
> > > The SDM makes it sound like we should be more judicious about using
> > > 've->instr_len' though.  "All VM exits other than those listed in the
> > > above items leave this field undefined."  Looking over
> > > virt_exception_kernel(), we've got five cases from CPU instructions that
> > > cause unconditional VMEXITs:
> 
> Ideally, what the SDM says wouldn't matter at all.  The TDX module spec really
> should be the authorative source in this case, but it just punts to the SDM:
> 
>   The 32-bit value that would have been saved into the VMCS as VM-exit instruction
>   length if a legacy VM exit had occurred instead of the virtualization exception.
> 
> Even if the TDX spec wants to punt to the SDM, it would save a lot of headache and
> SDM reading if it also said something to the effect of:
> 
>   The INSTRUCTION_LENGTH and INSTRUCTION_INFORMATION fields are valid for all
>   #VEs injected by the Intel TDX Module.  The fields are undefined for #VEs
>   injected by the CPU due to EPT Violations.

I initiated update to the spec, but it will take time.

-- 
 Kirill A. Shutemov
