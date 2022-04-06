Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F6E4F6588
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbiDFQb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237734AbiDFQal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:30:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4B12EF17E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:44:20 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649209459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0FQc76hjkumZRb0ef3sm4lyuJ9dDneJQs2XYFpXinew=;
        b=213m3rZ0KLU5Eu0hBKewzbweOZpySZN6OV61gHJimd/7JeEreR71y3Ey0y35wKxn4WJrzI
        TFdGe1p/602glRhZx+wBjf4nc9XvKV8Hi9OGH9S/b1UjWDSzk1FKEH8+vmp56Kb0bV2W9l
        UFHFvlX/yUCmHioI8bEoP7cx6Bt/ARs7eD7n/A6aIeYmTVNC1SjiouR4ACO5CNmd7HzFah
        fu14BJSyaD/Br0lv7RVox4Aec98GwcFkY0NCuqr8XrOok1R8veUjE+VmQBhKydGZ79RqfX
        6+cmkZsrcL8ktGXfj4rI1epqU9A4C0/nZZBB2OqrL1FiIOAevQ3VTy6IlDZqjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649209459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0FQc76hjkumZRb0ef3sm4lyuJ9dDneJQs2XYFpXinew=;
        b=EYz1XW4YJ5aPrJtrGMIWZkcekdSxXo4QFhSDh+PbKmMOwBcWReyVnH3jdH/AnruKBHEH7o
        XC6RaRq4LPl0UbDw==
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
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
Subject: RE: [PATCH] x86: Prefer MWAIT over HALT on AMD processors
In-Reply-To: <BL1PR12MB515702C06E483DF4EB78A7ADE2E49@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220405130021.557880-1-wyes.karny@amd.com>
 <YkxNFyXqC12nXyfM@hirez.programming.kicks-ass.net>
 <7cdc2103-c6d4-e1b6-9804-6739112eee4d@intel.com>
 <BL1PR12MB515745615F4C92627033CD5BE2E49@BL1PR12MB5157.namprd12.prod.outlook.com>
 <5873a444-bb32-f0d5-27f1-173f469baf21@intel.com>
 <BL1PR12MB515702C06E483DF4EB78A7ADE2E49@BL1PR12MB5157.namprd12.prod.outlook.com>
Date:   Wed, 06 Apr 2022 03:44:18 +0200
Message-ID: <87a6cz0yvh.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mario,

On Tue, Apr 05 2022 at 20:40, Mario Limonciello wrote:

> [Public]

Really useful information that your post is public while some of the
earlier posts in this _public_ thread were marked '[AMD confidential]'.

>> >> This seem _bit_ at odds with the commit message (and the AMD SSBD
>> >> whitepaper):
>> >>
>> >>>     Add the necessary synchronization logic for AMD family 17H.
>> >> So, is X86_FEATURE_ZEN for family==0x17, or family>=0x17?
>> > There are Zen family CPUs and APUs from family 0x19.  Perhaps at the
>> > time of the whitepaper there weren't yet though.
>> 
>> Is this a gap in the documentation, then?  Is there some documentation
>> of the availability of SSBD mitigations on family 0x19?
>
> It looks like a misinterpretation of the document.

Not at all. The document does not mention family 19h at all. So where is
the misinterpretation?

Dave was asking for documentation for family 0x19, right?

> Notice it mentions in Non-architectural MSRs explicitly:
>
> "some models of family 17h have logic that allow loads to bypass older stores 
> but lack the architectural SPEC_CTRL or VIRT_SPEC_CTR"

That's relevant to Dave's question in which way? 

> But that is not for all family 17h nor for family 19h.  You can see earlier in
> the document the method to detect presence for SSBD which applies to the
> rest of 17h and 19h.

We know how to read this document. But this document does not mention
anything else than family 17h. So what are you talking about?

> That code in amd_set_core_ssb_state is only used for one of the
> mitigation codepaths without MSR support, not for all Zen CPUs.

Again, how is that relevant to the legitimate question whether that
document applies to family 17h only or to 17h+ which includes 19h?

We need to make a decison about what X86_FEATURE_ZEN means. Is it that
hard to give an authoritive answer?

Thanks,

        tglx
