Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8548E57D3B4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiGUS5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiGUS5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:57:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0099988F2A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658429844; x=1689965844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zaXk1/QSYHxGTZcLT61E2h91LFbSgj46agJuVRtVTLk=;
  b=L0wKG0ARGaS6SJj3GVczHm+EcxdVsjh+9r8EpauKLbIgt5S+pauP6LUh
   bTZkQOfYt8DXuoDe5W7hGp1Mh4TEewXiCDMw5pBNNJOcYcbjTgbF4nvyT
   lMq9SPquGyVoYqLlXRourrZxMGl5S8PU0fQbXfKhSY1ksd2ScxVQz0fOJ
   Duutlyi8Fwz39JDCEfoRBBK9lveGSrEKOU3tranzvzT/xG4Z5M1FEyd7+
   XFZMF6/SxuaOH5Fx2GoGNuZjaN/t6HnGebLH1xQciF2ZirEjc4saMpl4e
   cniZYqRP2Gk2sL7AlWGDl/Eqzxz2eQ+LTllvsZwzPVYPA88ZlPc3ILq+5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="351141619"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="351141619"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 11:57:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="598585208"
Received: from sattaran-mobl1.amr.corp.intel.com (HELO [10.212.246.186]) ([10.212.246.186])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 11:57:23 -0700
Message-ID: <d0a3d1cc-dfea-0731-c801-97c8eb2cd535@linux.intel.com>
Date:   Thu, 21 Jul 2022 11:57:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <d3808510-9974-258e-0c7b-9a76e0868d48@intel.com>
 <f043d9f5-8f89-4ef3-2ce1-75665122bb3a@linux.intel.com>
 <214e24f0-5236-be8d-024a-da48737d854a@intel.com>
 <e280aaf4-57da-6453-c31c-6996dc85219c@linux.intel.com>
 <a65473db-b307-c076-6d2f-8f2084d81eb5@intel.com>
 <b8af932e-13da-ddcd-4ecb-bd8369853242@linux.intel.com>
 <fb9cbec5-6f64-4647-3bc2-30f07a0b6b59@intel.com>
 <20220721184221.GA3288872@ls.amr.corp.intel.com>
 <1fdecc17-8f4f-fceb-8da0-4a21ca0d58be@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <1fdecc17-8f4f-fceb-8da0-4a21ca0d58be@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/22 11:52 AM, Dave Hansen wrote:
> On 7/21/22 11:42, Isaku Yamahata wrote:
>> Regarding to the size of quote, there is no hard limit because it's for future
>> usage.  But here is a rough idea about it.
>>
>> - 4KB(1 page) can accommodate TDREPORT that is defined right now.
>> - 128KB is too small for foreseen use cases.
>> - 1MB is too big. big enough for future.
> 
> Again, we're off in the weeds.
> 
> How does the VMM know how much to read/write?  I have a theory: the spec
> says that R12 is:
> 
> 	"Shared 4KB GPA as input – the memory contains a
> 	TDREPORT_STRUCT."
> 
> That's *A* 4KB GPA.  The maximum is one 4KB page.  That's the only thing
> that makes sense because there's no length in the ABI anywhere.
> 
> What am I missing?

I think you are looking into the old spec. Please check the version
"FEBRUARY 2022"

Following are the ABI details:

R11 - TDG.VP.VMCALL< GetQuote > sub-function per Table 2-3
R12 - Shared GPA as input – the memory contains a TDREPORT_STRUCT. The
       same buffer is used as output – the memory contains a TD Quote.
R13 -  Size of shared GPA. The size must be 4KB-aligned.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
