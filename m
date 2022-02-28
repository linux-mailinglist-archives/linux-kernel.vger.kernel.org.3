Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353EE4C7DF6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 00:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiB1XGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 18:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiB1XGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:06:12 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC851DA64
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646089533; x=1677625533;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=aJFUREQF4g+hepgFPW1vGzF13KIn40MVOYBMZl7kvDw=;
  b=BdgGNdvmIvGSyVQdwp6Kr0Qs7GahJ8hkCX7dhWHYjVKgZkZ3JwaNkgi9
   dUd3yyssjvofcsQPnzjazzh+nSHo/HHgfr21jUXdyGHkP9kDCou+dRYhC
   vL1sArME/Dt5YtDPNjYbgyAUPp6E+MZx4y0qYUj+NH6XoYlhkYYbQlIRn
   u0xQ2kQmjHNe9lcy77XNiFarU+McalGEL7q86TLv9RUDKXdn3/Y68rleD
   3RVILdWslXMxO3bRueJOjdQM87hagwEMEDcp1GB7hz1asxnXVONawu+qe
   HQ4keR5zj+xUgk0D5dDRgqGEr0wTLyns3BTU2Oh0mVjQVgbFCADnfXlhm
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="232978247"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="232978247"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 15:05:33 -0800
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="550453365"
Received: from simpleku-mobl.amr.corp.intel.com (HELO [10.209.11.92]) ([10.209.11.92])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 15:05:31 -0800
Message-ID: <76b54855-d2b6-e224-ccb4-3f6c4cd1f7e7@intel.com>
Date:   Mon, 28 Feb 2022 15:05:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-11-kirill.shutemov@linux.intel.com>
 <51b6613d-eabd-941d-19b2-95b33ec27e99@intel.com>
 <20220227010733.abapkmyaroglcafl@black.fi.intel.com>
 <7a8c4e5e-c0ba-ee8e-a912-c71f89b4d4f2@intel.com>
 <20220228225336.k3lxk5qqm4vpaocv@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 10/30] x86/tdx: Handle CPUID via #VE
In-Reply-To: <20220228225336.k3lxk5qqm4vpaocv@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/22 14:53, Kirill A. Shutemov wrote:
> On Mon, Feb 28, 2022 at 08:41:38AM -0800, Dave Hansen wrote:
>>> We realise that this is possible vector of attack and plan to implement
>>> proper filtering. But it is beyon core enabling.
>>>
>>>> Is this better than just returning 0's, for instance?
>>> Plain 0 injection breaks the boot. More complicated solution is need.
>> OK, so we're leaving the kernel open to something that might be an
>> attack vector: we know that we don't know how this might be bad.  It's a
>> "known unknown"[1].
> I looked deeper. The only CPUIDs that actually required are from the
> hypervisor range (the range is reserved and never will be used by CPU, so
> hypervisors adopt it for own use).
> 
> So this filtering makes kernel boot (I didn't test much beyond that).
> 
> 	/*
> 	 * Only allow VMM to control range reserved for hypervisor
> 	 * communication.
> 	 *
> 	 * Return all-zeros for any CPUID outside the range.
> 	 */
> 	if (regs->ax < 0x40000000 || regs->ax > 0x4FFFFFFF) {
> 		regs->ax = regs->bx = regs->cx = regs->dx = 0;
> 		return true;
> 	}
> 
> We may tighten the range further (only few leafs from the range is
> actually used during the boot), but this should be good enough for this
> stage of enabling.

Seems sane to me.  This closes off basically any ability for the VMM to
confuse the guest with CPUID values except for the ones that *must* by
hypervisor-controlled.

Does this, in practice, keep TDX guests from detecting any features that
it supports today?

