Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4D855F01E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 23:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiF1VCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 17:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiF1VCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 17:02:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA433393DF;
        Tue, 28 Jun 2022 14:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656450167; x=1687986167;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wZ/uTrA3bjyScAuweu7zLmoZX9qpUo9vDnaXIZOrcKs=;
  b=g/hIDkwQ47/ktR4JtVBeDbfARqwRF65lQARKj80eJ5VAxnH0SgZqp+oZ
   nvlldvupjNiBnGTKYD6WcePml9afjzxsKMdBQqe39anVH2vB003Ck2CQQ
   FALbnT0JGXqXmW8tKZzlBJeCxe1MnZqWl9g3Cdb5wFWMindOOaxwSB8O8
   tb5g2eAtZulxPZBXMtsI945Tbnn6exfI6447FQB9aztnASKNVYKNLcqIa
   aR2z0C70TwmlimuFwtCcysTH7SORkaToHefCYln1CEEVU+Cgc4u7Mu59Z
   GXXhc9Ro0y0Yi6ebauijHAIXtKZ5UcHGC8ayaOnMNByXlYgAC2IiEH5Kw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="368160480"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="368160480"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 14:02:47 -0700
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="588004851"
Received: from staibmic-mobl1.amr.corp.intel.com (HELO [10.209.67.166]) ([10.209.67.166])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 14:02:46 -0700
Message-ID: <6934b82d-db12-8a17-7dea-7bcbd4fe8566@intel.com>
Date:   Tue, 28 Jun 2022 14:01:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 0/6] Add hardware prefetch control driver for A64FX and
 x86
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "eugenis@google.com" <eugenis@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "pcc@google.com" <pcc@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "marcos@orca.pet" <marcos@orca.pet>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "ast@kernel.org" <ast@kernel.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Paolo Valente <paolo.valente@unimore.it>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
 <YqNCDrqcp9t8HlUJ@kroah.com>
 <OSBPR01MB203749DA00C7BEE5741AFEB980AA9@OSBPR01MB2037.jpnprd01.prod.outlook.com>
 <YqiAY689pOJbHKUd@kroah.com>
 <TY2PR01MB20426C7822E46B2E8B2525FB80AF9@TY2PR01MB2042.jpnprd01.prod.outlook.com>
 <CACRpkdaV8+06gzxi3ou4+nxa28R5Rhzg+KJ8HWh4gyK4AkoC9g@mail.gmail.com>
 <086370dd-281f-5ac6-3a0f-f1b80500c668@intel.com>
 <CACRpkdYTNuszctk=stB+RLr5kKwhR2ebF2MJCYQwMwYYPPReLg@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CACRpkdYTNuszctk=stB+RLr5kKwhR2ebF2MJCYQwMwYYPPReLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/22 13:20, Linus Walleij wrote:
> On Tue, Jun 28, 2022 at 5:47 PM Dave Hansen <dave.hansen@intel.com> wrote:
>> On 6/27/22 02:36, Linus Walleij wrote:
>>> The right way to solve this is to make the Linux kernel contain the
>>> necessary heuristics to identify which tasks and thus cores need this
>>> to improve efficiency and then apply it automatically.
>>
>> I agree in theory.  But, I also want a pony in theory.
>>
>> Any suggestions for how to do this in the real world?
> 
> Well if the knobs are exposed to userspace, how do people using
> these knobs know when to turn them? A profiler? perf? All that
> data is available to the kernel too.

They run their fortran app.  Change the MSRs.  Run it again.  See if it
simulated the nuclear weapon blast any faster or slower.  Rinse.  Repeat.

One thing that is missing from the changelog and cover letter here: On
x86, there's a 'wrmsr(1)' tool.  That took pokes at Model Specific
Registers (MSRs) via the /dev/cpu/X/msr interface.  That interface is a
very, very thinly-veiled wrapper around the WRMSR (WRite MSR) instruction.

In other words, on x86, our current interface allows userspace programs
to arbitrarily poke at our most sensitive hardware configuration
registers.  One of the most common reasons users have reported doing
this (we have pr_warn()ings about it) is controlling the prefetch hardware.

This interface would take a good chunk of the x86 wrmsr(1) audience and
convert them over to a less dangerous interface.  That's a win on x86.
We don't even *remotely* have line-of-sight for a generic solution for
the kernel to figure out a single "best" value for these registers.
