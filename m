Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB1C4F89CB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiDGVS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiDGVSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:18:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367E4189A03
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649366212; x=1680902212;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=hMHOYuH6Qtn094r1Rs7lqDX/WXJ3ASVgHkU0fj2CT9Y=;
  b=Mr/aBdoqBWG6dMyDF0JHwFZb0Rd+uP/ScTVc1c4Gk/FxWMMIRp8q7WrE
   CjAl4GU+wtrS28hbgyuExl+xKbM4OezROTx1bpdR17YfgSewKaHOl3gxr
   8h8Rv3qtZyoPUzKsIGvNMl6qdJH+811bforZoKlsr3qUXu8j2ib8hzriC
   Mp5ZhJydb9p/SKGGoAG7bxGWsyrHhrBnXYf543+o2kjA3r7YKDw0QparF
   mlt5se6zqOnHifZG1RahMHV2+sKknPg+Aa7XztATrMyu9nLjYqYcBc8iY
   txLxZ0EtcKegxf8axGqJdHSsHlI+Qgh3fYh3nf5k4JoP2Kpx+jiUebrEG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="347882433"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="347882433"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 14:16:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="659223236"
Received: from okathe-mobl.amr.corp.intel.com (HELO [10.255.228.211]) ([10.255.228.211])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 14:16:50 -0700
Message-ID: <7a95b837-e347-0ad3-3a2c-f347f12d6625@intel.com>
Date:   Thu, 7 Apr 2022 14:16:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Karny, Wyes" <Wyes.Karny@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Carroll, Lewis" <Lewis.Carroll@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Narayan, Ananth" <Ananth.Narayan@amd.com>,
        "Rao, Bharata Bhasker" <bharata@amd.com>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "metze@samba.org" <metze@samba.org>,
        "zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
References: <20220405130021.557880-1-wyes.karny@amd.com>
 <YkxNFyXqC12nXyfM@hirez.programming.kicks-ass.net>
 <7cdc2103-c6d4-e1b6-9804-6739112eee4d@intel.com>
 <BL1PR12MB515745615F4C92627033CD5BE2E49@BL1PR12MB5157.namprd12.prod.outlook.com>
 <5873a444-bb32-f0d5-27f1-173f469baf21@intel.com>
 <BL1PR12MB515702C06E483DF4EB78A7ADE2E49@BL1PR12MB5157.namprd12.prod.outlook.com>
 <87a6cz0yvh.ffs@tglx>
 <BL1PR12MB51573FC5B880ED914628A95BE2E79@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] x86: Prefer MWAIT over HALT on AMD processors
In-Reply-To: <BL1PR12MB51573FC5B880ED914628A95BE2E79@BL1PR12MB5157.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/22 07:23, Limonciello, Mario wrote:
> To confirm the availability of the MSR for a particular CPU, you can look
> at the PPR for a family 19h CPU.  For example here is family 19h model 01h:
> https://www.amd.com/en/support/tech-docs/processor-programming-reference-ppr-for-amd-family-19h-model-01h-revision-b1?msclkid=f5047d01b5b211ec8d619d1385260e2d

I don't want to give you too hard of a time on this.  But, that's not
architecture, that's just telling folks what the implementation is on
*one* CPU model.  Don't get me wrong: these model-specific docs are
great, and I wish Intel published something like that.

But, the code as written depends on behavior for *all* of family 0x19:

>         case 0x17: fallthrough;
>         case 0x19: init_amd_zn(c); break;

So, while the docs for "family 19h model 01h" are *consistent* with this
code, there's also nothing preventing the docs for "family 19h model
02h" from breaking this new MWAIT code.

Now, AMD is full of smart folks that aren't going out of their way to
try and break existing software.  But, actual documentation of the
*architecture* is really preferable to what we have now.  It helps
establish a shared hardware/software contract that keeps both sides honest.

What's missing is something that says:

	All AMD family 0x17 and 0x19 that enumerate support for MWAIT
	also support this "early MWAIT" implementation

That represents a promise from AMD that this can't break in the future.
 It both gives us something unambiguous to write code with *and*
something to help nudge our hardware and microcode colleagues if they
start to do something funny in the future.

Just having that in the changelog would be fine, and a genuine
improvement over what we have now.  Having it one of the
model-independent architecture manuals would be even better.
