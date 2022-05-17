Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E43C52AC95
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352906AbiEQURR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiEQURP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:17:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6140A51E65
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652818634; x=1684354634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jWdssyub1ndaTO5AKMJmUoU3GkFbxb2fOG5t9/sxMwI=;
  b=IuXXudhzM0cWG32mjqrYPHUqPnNF06PgprnwP+eHuO4dgaJSwcoUNvyq
   O/Hk6/Yl3F3RLIErmuenZgoOEAeUqPrbCM6H1AvPyc7Akqefj38sm7som
   /+lWP+OQLC2d5Zx3fk5qIe+SZ+MBXFeUuLzFbFgAjDsqDak1s4R20Tz8A
   sq+qCwQedPxAiwg174FdIO6Gpj6NTgyzW599m2ZiOrHiOpalkQWgGmFSC
   TZW3F3Um5TjiPgBh/DxnRYln9Y7fNbHd8OJb0U/gbTNO1UiTVKonY3lUM
   qfcu+J+buA5iIumRivgFxSX1UIkiDg9uxWKYmKhZgrJ7oJcs2RSrW9+Zz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="251214887"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="251214887"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 13:17:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="897847237"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 17 May 2022 13:17:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 49364CE; Tue, 17 May 2022 23:17:10 +0300 (EEST)
Date:   Tue, 17 May 2022 23:17:10 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, seanjc@google.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tdx: Handle load_unaligned_zeropad() page-cross to a
 shared page
Message-ID: <20220517201710.ixbpsaga5jzvokvy@black.fi.intel.com>
References: <20220517153021.11116-1-kirill.shutemov@linux.intel.com>
 <e73cb19e-7dab-2fc1-b947-fac70fd607d2@intel.com>
 <20220517174042.v6s7wm3u5j2ebaoq@black.fi.intel.com>
 <c761e774-8014-6fa9-cf21-e7cd8f7aca54@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c761e774-8014-6fa9-cf21-e7cd8f7aca54@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 11:14:13AM -0700, Dave Hansen wrote:
> On 5/17/22 10:40, Kirill A. Shutemov wrote:
> >>
> >> ve_info is a software structure.  Why not just add a:
> >>
> >> 	bool ip_adjusted;
> >>
> >> which defaults to false, then we have:
> >>
> >> 	/*
> >> 	 * Adjust RIP if the exception was handled
> >> 	 * but RIP was not adjusted.
> >> 	 */
> >> 	if (!ret && !ve_info->ip_adjusted)
> >> 		regs->ip += ve_info->instr_len;
> >>
> >> One other oddity I just stumbled upon:
> >>
> >> static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> >> {
> >> ...
> >>         ve->instr_len = insn.length;
> >>
> >> Why does that need to override 've->instr_len'?  What was wrong with the
> >> gunk in r10 that came out of TDX_GET_VEINFO?
> > TDX module doesn't decode MMIO instruction and does not provide valid size
> > of it. We had to do it manually, based on decoding.
> 
> That's worth a comment, don't you think?  I'd add one both in where the
> ve_info is filled and where ve->instr_len is adjusted.

Okay. Will do.
 
> > Given that we had to adjust IP in handle_mmio() anyway, do you still think
> > "ve->instr_len = 0;" is wrong? I dislike ip_adjusted more.
> 
> Something is wrong about it.
> 
> You could call it 've->instr_bytes_to_handle' or something. Then it
> makes actual logical sense when you handle it to zero it out.  I just
> want it to be more explicit when the upper levels need to do something.
> 
> Does ve->instr_len==0 both when the TDX module isn't providing
> instruction sizes *and* when no handling is necessary?  That seems like
> an unfortunate logical multiplexing of 0.

For EPT violation, ve->instr_len has *something* (not zero) that doesn't
match the actual instruction size. I dig out that it is filled with data
from VMREAD(0x440C), but I don't know where is the ultimate origin of the
data.

I don't understand virtualization side of the thing well enough. 

Maybe someone who knows virtualtion could comment here. Sean?

-- 
 Kirill A. Shutemov
