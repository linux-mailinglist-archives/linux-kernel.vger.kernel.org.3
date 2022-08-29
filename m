Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050555A5580
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiH2UZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiH2UY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:24:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567911ADB7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661804697; x=1693340697;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dIutmK2nvu7/Pg6n0QbHO+cKZ3dKMCCaRoKlyNt9gLA=;
  b=Bq8XMp9RZ8YE8CfZY3pAjs1oSIEiUJTTgL64Ewtzs9I4JBnr7FlBxmWO
   Vh6oNIIY/vnTQP2GYLeXVJxPTt40Ej1MRjAIuS8mNIBOtNDUCCIA9G4sC
   /r7L9kAsDMi5qtVZR8kvYsUZkdSN5J9Wo+hgSl2dlsbbaCgecJWhCYaVm
   l6T7opDMD6qscW9O9hXQudNVdzdA5OZJ9/rpqWpcdQUiv7SfeQFGeEIDw
   z1S0qjD/tbfGoQhECg5deFqQuchEaufnNGdykCWZKlKec2pQL7gDzyC5m
   1XlfUGWZyBNaEl1O+RVdYOrPfyG3o8YN6XfXLYCn0AG2RAvQJGCJEYcwd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="381290076"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="381290076"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 13:24:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="611432215"
Received: from rlacadex-mobl.amr.corp.intel.com (HELO [10.209.116.122]) ([10.209.116.122])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 13:24:55 -0700
Message-ID: <b519135c-2241-4172-747a-b1f2f492f48c@intel.com>
Date:   Mon, 29 Aug 2022 13:24:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/microcode/intel: Allow late loading only if a min rev
 is specified
Content-Language: en-US
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>
References: <20220829180436.716672-1-ashok.raj@intel.com>
 <e46c20a5-9f43-6ec4-6c2e-ea6891a8ce0d@intel.com>
 <Yw0LAbFITDDFGek3@araj-dh-work>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Yw0LAbFITDDFGek3@araj-dh-work>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/22 11:52, Ashok Raj wrote:
> The enforcement is not in hardware and limited to kernel loader enforcing
> the requirement. It is not required for early loading of microcode to
> enforce this requirement, since the new features are only
> evaluated after early loading in the boot process.

That's _related_ to what I was asking, but it doesn't quite cover it.

Right now, the min_rev guarantee is something along the lines of:

	Intel will always set min-rev its its microcode releases when
	software-visible features change between microcode revisions.

That's subtly different from

	The microcode header will bump min-rev when software-
	visible features change between microcode revisions.

The kernel (and its developers) should at least be *aware* that features
can change even if there's no min-rev bump.  That could be because:

	1. A user is trying to do the microcode equivalent of "modprobe
	   --force", by hacking the header
	2. The user is applying microcode from the USB stick they found
	   in the parking lot.
	3. Intel isn't sticking to its end of the bargain (or we never
	   really agreed about what the bargain was in the first place).

I'm not saying that your patch can or should do this, but the min_rev
feature does *not* mean that we can just start to forego any sanity
checks about features being added or removed as the result of a late load.

I think those three ^ cases are even worth calling out in the changelog
because it's very easy to confuse what min_rev really *MEANS* in the
end.  It only has meaning when the ucode image is unmodified between
Intel and the kernel, *AND* if Intel keeps up its end of the contract.

BTW, about #3...  I fully trust Intel to be a good actor here.  But,
Intel employs actual humans and humans do make mistakes.  Let's make
sure the kernel is resilient in the face of any mistakes.
