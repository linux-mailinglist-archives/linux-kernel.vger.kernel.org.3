Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6EF48351B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbiACQuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:50:16 -0500
Received: from mga17.intel.com ([192.55.52.151]:6628 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232538AbiACQuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:50:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641228615; x=1672764615;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=4PcZgTJRVZUX2mg/QMiWfHqsdL4H4I8uxPNWmtCtJcM=;
  b=KEaGE1ZxN1IoeAH+UQI+BR6//CFI7ZZ+4yXOpYW11KBtbfgi2ot/apXw
   EoGZVJrv9QM288aeTxDprWUeH2nM5l59Z4yqBznMeIzIwuvIDCgAMd0Vr
   nQ7vxhnp0LIsha4J57vAZDMG0974EedQ/dSCzdPYyFx2tB1rx9VY6sGvN
   QmVxISETxJYQgnk/r8sh2ZeLqxrLN2k/k633FEjE6b/fiwuLaP9HLRe4X
   Uve2apsnkMn3u2VbGbWOl/IB2hPQABoI3EkWKX0qk1Qt9uHMCD9AR8uox
   bc+qEKZicOMFVaqb/5vylR5sOwfSx121/XcbsQ9lt6jm+SqNQADH779fl
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10215"; a="222762846"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="222762846"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 08:50:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="512151374"
Received: from cdeng1-mobl.amr.corp.intel.com (HELO [10.209.35.83]) ([10.209.35.83])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 08:50:14 -0800
Subject: Re: [PATCH 19/26] x86/tdx: Make pages shared in ioremap()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, tglx@linutronix.de,
        mingo@redhat.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <87c288d6-9bf8-5a94-a628-1e0aaa7de690@amd.com>
 <20211223171530.v73posbqizb5l3md@black.fi.intel.com>
 <f61b591b-a06c-bc29-4b9b-a5d46111fe4e@intel.com> <YcTTt4LXKfDO+9u3@zn.tnic>
 <20211223205604.g44kez5d7iedatfo@box.shutemov.name>
 <YcTlhp1PUfrMOelI@zn.tnic>
 <20211224110300.7zj3nc5nbbv7jobp@black.fi.intel.com>
 <33914dc1-37e8-f0bb-6468-71c3b5f4169d@amd.com>
 <20220103141705.6hqflhwykqmtfim6@black.fi.intel.com>
 <YdMIWAT42el4D6wJ@zn.tnic>
 <20220103151516.pfcz2pap5l7r2rzv@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
Message-ID: <b4b54116-1cd7-468a-0889-d497268cbfb2@intel.com>
Date:   Mon, 3 Jan 2022 08:50:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220103151516.pfcz2pap5l7r2rzv@box.shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/22 7:15 AM, Kirill A. Shutemov wrote:
> On Mon, Jan 03, 2022 at 03:29:44PM +0100, Borislav Petkov wrote:
>> On Mon, Jan 03, 2022 at 05:17:05PM +0300, Kirill A. Shutemov wrote:
>>> I'm not sure how to unwind this dependency hell. Any clues?
>> Forward-declaration maybe?
>>
>> I.e., something like
>>
>> struct task_struct;
>>
>> at the top of arch/x86/include/asm/switch_to.h, for example...
> Forward-declaration only works if you refer the struct/union by pointer,
> not value.
> 
> And pgprot_t is not always a struct and when it is a struct it is
> anonymous.
> 
> See "git grep 'typedef.*pgprot_t;'".

In the end, the new functions get used like this:

	prot = pgprot_decrypted(prot);

I think they _could_ be:

	pgprot_set_decrypted(&prot);

Which would let you have a declaration like this:

	extern void pgprot_cc_set_decrypted(pgprot_t *prot);

It does not exactly give me warm and fuzzy feelings, but it would work
around the header problem.
