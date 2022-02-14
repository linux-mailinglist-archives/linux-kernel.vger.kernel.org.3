Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320CE4B5CCF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiBNV3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:29:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiBNV3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:29:05 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F8B10E2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644874136; x=1676410136;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=vQTr1pJP/ZuLa7nTq51NMvNV6GS8nBWlHsGKMteM/68=;
  b=Bq3lWyY2JoauNzTneViDvv2mByySxKFNSqKtrsPvtfJO56o3X3O0IeaS
   d9dcQB/aa7NFC4mpUI5LZAQYFuiGRrqRVJG5VCaqZs/6NwSpEdiy/GXdw
   fPrFpeCmqZeCoY0TK1I0vFWWiSm3b+lHgAsxcW+GR7Z8OEcrFmlw/jQ2S
   wt4Y4MJhBsIYDSD58RFearsWQKwm3W+5E5hXgTCRz2Z/cp11d1USsBXIw
   H4O103C5ODHV4BfY5oJG6dfPbTU3G16FSfxoBfMdq9ILaOfzmTxTZVGpm
   2+mIGNqMf8oNwdn9Q96lp6kCS9DgRblqvsznFiY1p9UtHNAZU7iHkS1an
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="313440827"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="313440827"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 11:20:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="543849190"
Received: from racamill-t15-2.amr.corp.intel.com (HELO [10.251.23.156]) ([10.251.23.156])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 11:20:24 -0800
Message-ID: <6b50671d-883f-561a-bf7d-5ae01c2cc312@intel.com>
Date:   Mon, 14 Feb 2022 11:20:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-7-ira.weiny@intel.com>
 <9c4a8275-236d-67b6-07f9-5e46f66396c0@intel.com>
 <20220128231015.GK785175@iweiny-DESK2.sc.intel.com>
 <f72b0e17-11bf-b12e-fe7a-d38b0833acdc@intel.com>
 <20220204190851.GY785175@iweiny-DESK2.sc.intel.com>
 <20220209053430.GL785175@iweiny-DESK2.sc.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V8 06/44] mm/pkeys: Add Kconfig options for PKS
In-Reply-To: <20220209053430.GL785175@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/22 21:34, Ira Weiny wrote:
>>> In other words, there are two things that must happen before the code
>>> gets compiled in:
>>>
>>> 1. Arch support
>>> 2. One or more features to use the arch support
>> Yes.  I really think we are both say the same thing with different words.
> Is the following more clear?
> 
> <commit>
> 
> PKS is only useful to kernel consumers and is only available on some
> architectures.  If no kernel consumers are configured or PKS support is
> not available the PKS code can be eliminated from the compile.
> 
> Define a Kconfig structure which allows kernel consumers to detect
> architecture support (ARCH_HAS_SUPERVISOR_PKEYS) and, if available,
> indicate that PKS should be compiled in (ARCH_ENABLE_SUPERVISOR_PKEYS).
> 
> In this patch ARCH_ENABLE_SUPERVISOR_PKEYS remains off until the first
> kernel consumer sets it.

It's a bit more clear.  I wish it was more clear about the problem.  I
think it would be well-served to add some specifics and clarify the
*problem*.  Maybe something like:

== Problem ==

PKS support is provided by core x86 architecture code.  Its consumers,
however, may be far-flung device drivers like NVDIMM support.  The PKS
core architecture code is dead weight without a consumer.

--- maybe add one example ---

== Solution ==

Avoid even compiling in the core PKS code if there are no consumers.

== Details ==
