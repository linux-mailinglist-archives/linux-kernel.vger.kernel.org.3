Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BF54F20B4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 04:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiDECAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiDEB75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 21:59:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB953568E2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649121369; x=1680657369;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vd8a/QnNBSw3XlEeVYk+lJcby3alpNsJHuOnY1+hlpQ=;
  b=S7OV/KWObLUFXMPkMuIGO+HLdGMLiJZdKo5rzJTE49diyWyvwb+lMRuO
   WyD0/aMmCgbW7B/UCG4Ja9KpBCmTxFc3TQd/G0iKmu+Jvff8Ucd9nwklt
   mGUAt0HKxeDZvlO3wu62QLJYrgIzkOYeOwOP0wxUKU2M7sbqQ64Sskv9L
   rqMogHFCRiLEP4S4aPOyg7Xen7fyGv8MGyKtwMqKda3KAnv7FKxhlGoUN
   Ngtn5cLdCRlsBiDCZ9F7oQCGFqxLfaaIFqNhiXt2JO+sjuL+5StLZLf7X
   mQcuOp8sRaOBzyntyFU/G55HiJIKSFiqpyuGVdU4JwuyEyDloe2JcXVNu
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="285591198"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="285591198"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 17:23:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="651686256"
Received: from cwebber-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.54.91])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 17:23:46 -0700
Message-ID: <a3d68966dbabc800adabef96b9a7e5d325d5b5f7.camel@intel.com>
Subject: Re: [PATCHv7.1 02/30] x86/tdx: Provide common base for SEAMCALL and
 TDCALL C wrappers
From:   Kai Huang <kai.huang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        bp@alien8.de
Cc:     aarcange@redhat.com, ak@linux.intel.com, brijesh.singh@amd.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Date:   Tue, 05 Apr 2022 12:23:44 +1200
In-Reply-To: <5263978a-19ef-fff3-cc61-b272a833171f@intel.com>
References: <YjXtK4awY6utz3wE@zn.tnic>
         <20220321160245.42886-1-kirill.shutemov@linux.intel.com>
         <9f8f57fdbbf76e70471541dc42b04f8a89be4a56.camel@intel.com>
         <dd5c52ad-9c61-54c3-6654-7a30c56b1917@intel.com>
         <2fcd12bb42c7d30f0e7bd09a7f66d76122493b32.camel@intel.com>
         <5263978a-19ef-fff3-cc61-b272a833171f@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-04 at 17:01 -0700, Dave Hansen wrote:
> On 4/4/22 16:35, Kai Huang wrote:
> > Both error code formats defined by P-SEAMLDR and TDX module has some reserved
> > bits which will never be set to 1.  I think we can just add a simple comment
> > explaining that and choose a value which has 1 set for those reserved bits (even
> > doesn't have to be -1). For example:
> > 
> > 	/*
> > 	 * Use -1ULL which will never conflict with any actual error code
> > 	 * returned by both the P-SEAMLDR and the TDX module to represent
> > 	 * VMfailInvalid.  Both error code definitions defined by the
> > 	 * P-SEAMLDR and the TDX module have some reserved bits which will
> > 	 * never be set to 1.
> > 	 */
> > 	#define TDX_SEAMCALL_VMFAILINVALID	GENMASK_ULL(63, 0)
> 
> The vague "some reserved bits" magic works for exactly *one* error code.
>  If you ever want to make it two, then you subject some some poor future
> dope to a trip to TDX documentation purgatory.
> 
> All I'm asking is that this code stand on its own.  Just declare what
> the *ACTUAL* reserved bits are.  Not some vague reference to "some
> bits".  There are *REAL* documented bits.  Use them, please.

OK.  How about below:

	/*
	 * VMfailInvalid happens before any actual internal logic of the
	 * P-SEAMLDR and the TDX module is reached.  Use a unique value which
	 * will never conflict with any actual error code returned by both the
	 * P-SEAMLDR and the TDX module to represent this case.
	 *
	 * Both error code definitions of the P-SEAMLDR and the TDX module have
	 * some reserved bits (bits 61:48 for the TDX module and bits 62:32 for
	 * the P-SEAMLDR) which will never be set to 1.  Choose -1ULL as it
will
	 * never be returned as error code by both of them.
	 */
	#define TDX_SEAMCALL_VMFAILINVALID	GENMASK_ULL(63, 0)

-- 
Thanks,
-Kai
