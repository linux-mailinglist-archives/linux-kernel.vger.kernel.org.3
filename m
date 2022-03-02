Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FF74CAEE8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241912AbiCBTnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241902AbiCBTnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:43:00 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBCCC7D5D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646250137; x=1677786137;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=R1Fmxe77VIXvXjw0v+E/opMnmQzI/f1rgNL0Yh1AgeU=;
  b=ICIe3OLZWd7gzc1PW0DjHFwlCy4mzsdBJjhs1DBtnOVMu7V507TpwjCj
   zupGtsybbcHT90iu/vTZRkIJWoSGwhY7jt1KNUd1xr+WxCUCKfxvFN/z3
   zT9dN3ka4wS2fH4mtTEEFgToM43TL1NkotHbkTga4oAxghBNYgdAhWDMv
   h/fGUkIlilrcZ/VGuBfVPDJ1hBLDJseZTvYPzCqt9muvBYQ+9QXsim4TJ
   EPXvincGC+ze/FP/IMQgg2yeuZkhKeFQVcMcrNKUSUSatXmOWWY4+VIix
   dCLpBfPi1dYfG+qoebL2/kq88Ci47rMIHYhXKNyGW2lZZflBOLv5siimc
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="237000670"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="237000670"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 11:42:00 -0800
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="576225796"
Received: from harmanpr-mobl3.amr.corp.intel.com (HELO [10.209.50.39]) ([10.209.50.39])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 11:41:59 -0800
Message-ID: <6adfbd21-142d-5fe3-41c9-fb2996c9452a@intel.com>
Date:   Wed, 2 Mar 2022 11:41:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, knsathya@kernel.org, pbonzini@redhat.com,
        sdeep@vmware.com, seanjc@google.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-16-kirill.shutemov@linux.intel.com>
 <20220302174210.q5r6zl2lsa6hut6q@treble>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv5 15/30] x86/boot: Port I/O: allow to hook up alternative
 helpers
In-Reply-To: <20220302174210.q5r6zl2lsa6hut6q@treble>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/22 09:42, Josh Poimboeuf wrote:
> At the very least, please remove the ability for future code to> accidentally bypass 'pio_ops'.  Going forward, are we really expected
to> just remember to always use pio_ops for i/o?  Or else TDX will just>
silently break?  That's just not acceptable.
What did you have in mind here?  The in/out() instruction wrappers could
be moved to a spot where they're impossible to call directly, for instance.

I guess we could get really fancy and use objtool to look for any I/O
instructions that show up outside of the "official" pio_ops copies.
That would prevent anyone using inline assembly.

In the end, though, TDX *is* a new sub-architecture.  There are lots of
ways it's going to break silently and nobody will notice on bare metal.
 SEV is the same way with things like the C (encryption) bit in the page
tables.  Adding more safeguards sounds like a good idea but, in the end,
we're going to have to find the non-obvious issues with testing.
