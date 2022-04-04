Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3FC4F0DB5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 05:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242144AbiDDD1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 23:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238989AbiDDD1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 23:27:30 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57F837BFA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 20:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649042732; x=1680578732;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rZxfQT1LZ7mM3SWSQPDqLJc2u7dHrqo2RdnzpnwyPYg=;
  b=Q1dZZV51ZYF3l6kZVIBmWFexKKiQ5t/+nLVDyyE/qWfoOV+IfvUxsNzE
   UQay4BNbqdnI9nPecrqIMrngEMjfEtomLW1Ukn/x4xPyK6d4jZ5+Nm3qC
   gQjnI9CJ7jtwusE35NlDSglItRZz04jiJvCd3sIS7+0pwlGOiwcKPQaEr
   isqEOW6ZJaTKTjB/oV/LP1FZ0IEZz+V60FzYXyuKcJGtEPl/9yndW67jA
   JpsASjm+yHSaY+NUipU5P+RZIBvADqHSy+tpIfQQ5QozgsYHuJZWxjyur
   4FCOX8CR2Zf3gmDlc2WS/jpL23XQ6r18B66uzG3PPVewnGkEG/jlyoCAC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="346869555"
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="346869555"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 20:25:31 -0700
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="556009803"
Received: from slkortic-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.251.132.173])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 20:25:25 -0700
Message-ID: <9b36957a908c95d1f9cc8edaa287b6ce675176a5.camel@intel.com>
Subject: Re: [PATCHv7.1 02/30] x86/tdx: Provide common base for SEAMCALL and
 TDCALL C wrappers
From:   Kai Huang <kai.huang@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        bp@alien8.de
Cc:     aarcange@redhat.com, ak@linux.intel.com, brijesh.singh@amd.com,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        dave.hansen@linux.intel.com, david@redhat.com, hpa@zytor.com,
        jgross@suse.com, jmattson@google.com, joro@8bytes.org,
        jpoimboe@redhat.com, knsathya@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Date:   Mon, 04 Apr 2022 15:25:23 +1200
In-Reply-To: <9f8f57fdbbf76e70471541dc42b04f8a89be4a56.camel@intel.com>
References: <YjXtK4awY6utz3wE@zn.tnic>
         <20220321160245.42886-1-kirill.shutemov@linux.intel.com>
         <9f8f57fdbbf76e70471541dc42b04f8a89be4a56.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-04 at 15:19 +1200, Kai Huang wrote:
> On Mon, 2022-03-21 at 19:02 +0300, Kirill A. Shutemov wrote:
> > +/*
> > + * SW-defined error codes.
> > + *
> > + * Bits 47:40 == 0xFF indicate Reserved status code class that never used by
> > + * TDX module.
> > + */
> > +#define TDX_ERROR			_BITUL(63)
> > +#define TDX_SW_ERROR			(TDX_ERROR | GENMASK_ULL(40, 47))
> > +#define TDX_SEAMCALL_VMFAILINVALID	(TDX_SW_ERROR | _UL(0xFFFF0000))
> 
> Hi Kirill,
> 
> GENMASK_ULL(40, 47) should be GENMASK_ULL(47, 40), otherwise I am getting error
> while building TDX host code:
> 
> arch/x86/virt/vmx/tdx/tdx.c: In function ‘seamcall’:
> ./include/linux/build_bug.h:16:51: error: negative width in bit-field
> ‘<anonymous>’
>    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> 
> Btw, perhaps you should also explicitly include <linux/bits.h> where
> GENMASK_ULL() is defined in this header file.
> 
> Btw, I previous suggested perhaps we can just use -1ULL instead of above value
> for TDX_SEAMCALL_VMFAILINVALID, but didn't get response.  The reason is this
> value will only be used when detecting P-SEAMLDR using P-SEAMLDR's SEAMLDR.INFO
> SEAMCALL.  Note your above SW-defined error codes is based on error code
> definition for TDX module, but actually P-SEAMLDR has different error code
> definition:
> 
> "The Intel P-SEAMLDR module returns error codes in the format
> 0x80000000_cccceeee, where the value cccc specifies the error class, and the
> value eeee specifies the error code within that class"
> 
> The above value happens to work for P-SEAMLDR but it doesn't follow P-SEAMLDR's
> error code definition.
> 
> More information:
> https://lore.kernel.org/lkml/20220224155630.52734-1-kirill.shutemov@linux.intel.com/T/#m5242e88e58a52a7e1da69dde3b63f19a717d3118
> 
> 

Sorry forgot to add, how TDX_SEAMCALL_VMFAILINVALID is used to detect P-SEAMLDR
and TDX module is here:

https://lore.kernel.org/lkml/cover.1647167475.git.kai.huang@intel.com/T/#m0b0896572bc79546045d03d6af65897b05ba89a4


-- 
Thanks,
-Kai


