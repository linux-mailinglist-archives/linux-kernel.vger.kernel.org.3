Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6D04F9E14
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbiDHUPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiDHUPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:15:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E703542AC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649448778; x=1680984778;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=vmQiNW54rZS2Zv3iTVjzQEeCKYMBTIT3uJw3ckMo2Gk=;
  b=YmSKkmR1jSP3OIBjt5D2uvjhY1Mtqd8E9LSwTn+e2ygZS8zKLrrwp7y8
   3JUQkULOTbo0UJelOlRGZWr6Mi3si9bSB9G7GRjoBrCSImhDY88GThQNb
   lE2itRy+tHIBjSzpXLdktwnAdy1JQD7NO29M4JDPOKGIUfnMkNHfVQAZz
   yypXjrBqmLvnVUCztjHaD4G5r0mRGZqmki5UsjzFnO8W+SVjB4OdJPeqh
   fjx0r3lriAO9ULTk0JXH5zE9JDlOu2aXkhhJp/jNvRFIixEuOYl9CekLw
   ZpYuY++013wI+mheu/cImL3zKBaIArha8ex62E6esBkZP6BRhyB9he7Fd
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="260519279"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="260519279"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 13:12:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="525509993"
Received: from tsungtae-mobl.amr.corp.intel.com (HELO [10.134.43.198]) ([10.134.43.198])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 13:12:41 -0700
Message-ID: <416590b1-5164-3c77-f617-b52eb8459318@intel.com>
Date:   Fri, 8 Apr 2022 13:12:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
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
References: <YjXtK4awY6utz3wE@zn.tnic>
 <20220321160245.42886-1-kirill.shutemov@linux.intel.com>
 <9f8f57fdbbf76e70471541dc42b04f8a89be4a56.camel@intel.com>
 <dd5c52ad-9c61-54c3-6654-7a30c56b1917@intel.com>
 <2fcd12bb42c7d30f0e7bd09a7f66d76122493b32.camel@intel.com>
 <5263978a-19ef-fff3-cc61-b272a833171f@intel.com>
 <a3d68966dbabc800adabef96b9a7e5d325d5b5f7.camel@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv7.1 02/30] x86/tdx: Provide common base for SEAMCALL and
 TDCALL C wrappers
In-Reply-To: <a3d68966dbabc800adabef96b9a7e5d325d5b5f7.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/22 17:23, Kai Huang wrote:
>> The vague "some reserved bits" magic works for exactly *one* error code.
>>  If you ever want to make it two, then you subject some some poor future
>> dope to a trip to TDX documentation purgatory.
>>
>> All I'm asking is that this code stand on its own.  Just declare what
>> the *ACTUAL* reserved bits are.  Not some vague reference to "some
>> bits".  There are *REAL* documented bits.  Use them, please.
> OK.  How about below:
> 
> 	/*
> 	 * VMfailInvalid happens before any actual internal logic of the
> 	 * P-SEAMLDR and the TDX module is reached.  Use a unique value which
> 	 * will never conflict with any actual error code returned by both the
> 	 * P-SEAMLDR and the TDX module to represent this case.
> 	 *
> 	 * Both error code definitions of the P-SEAMLDR and the TDX module have
> 	 * some reserved bits (bits 61:48 for the TDX module and bits 62:32 for
> 	 * the P-SEAMLDR) which will never be set to 1.  Choose -1ULL as it
> will
> 	 * never be returned as error code by both of them.
> 	 */
> 	#define TDX_SEAMCALL_VMFAILINVALID	GENMASK_ULL(63, 0)

Kai, I think I've failed horribly in explaining myself.

Here's what I want:

#define TDX_ERROR_RSVD_P_SEAMLDR	GENMASK_ULL(62, 32)
#define TDX_ERROR_RSVD_MODULE		GENMASK_ULL(61, 48)

The P-SEAMLDR and the TDX module itself each define reserved bits in
their error codes.  These bits will never be set after a SEAMCALL to
those two entities.  Define a error code which can be returned by
software which uses those reserved bits and can be used for either the
P-SEAMLDR or the TDX module:

#define	TDX_SEAMCALL_VMFAILINVALID	(TDX_ERROR_RSVD_P_SEAMLDR &
					 TDX_ERROR_RSVD_MODULE)

See what that does?  It does what you said in english, but does it in
code.  Take two things from the specs (the reserved masks), and find a
value that satisfies both entities.

Now, I'm not sure why you *need* TDX_SEAMCALL_VMFAILINVALID, but this is
how I'd like it to be defined.  Sure, -1 *works*, but it's basically an
opaque value.  It's also not *obviously* correct.
