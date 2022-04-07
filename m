Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4524F7B85
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbiDGJ0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbiDGJ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:26:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72D12CE16
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SV21BjX7P49KNLAmx5QmrX8Qf7AJrN7J0ADqi+mbeyI=; b=k97/CnGSb5mhw6lp1h+s+Z3Htc
        mH4FivpzEF0rslNQ42eRr02aF8vOCz91eKL3ZZ3TGdTM+0UE0BF8Q1tS/t0ytWom4jYcAlbIs6vz/
        lUc7mUtPl+b+Go9D0m//Fb1dOL4/VFuk8RhIjEsMJgtecV3pqJIt8qMAgVRPq177Oa+CsA8r88YF4
        qXeHM09xH7KBKngPD2RvUkC8jBXWQB6KtYNL4xcdPGYJj/UJcXaEFdkqR7Ue/siR4/3rmxDgmZLEl
        Vz1KTAh7iFwOTEqxCQlDU0y9zD9yanQUtlgrFlCBzuGKOyk4+PMthlGi9Puj77RBf4GuB0Utl0EZO
        LjFCkdJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncON7-002Rk2-31; Thu, 07 Apr 2022 09:24:09 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E70F89862CF; Thu,  7 Apr 2022 11:24:05 +0200 (CEST)
Date:   Thu, 7 Apr 2022 11:24:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, mbenes@suse.cz, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, hjl.tools@gmail.com
Subject: Re: drivers/gpu/drm/i915/i915.prelink.o: warning: objtool:
 __intel_wait_for_register_fw.cold()+0xce: relocation to !ENDBR:
 vlv_allow_gt_wake.cold+0x0
Message-ID: <20220407092405.GI2731@worktop.programming.kicks-ass.net>
References: <202204041241.Hw855BWm-lkp@intel.com>
 <YkxLqznOz0ldTz5a@hirez.programming.kicks-ass.net>
 <20220406000500.5hlaqy5zrdqsg5mg@treble>
 <87czhv11k1.ffs@tglx>
 <20220406053251.6dyfxrjmmgdwocfc@treble>
 <20220406074330.GD34954@worktop.programming.kicks-ass.net>
 <20220406163703.hhet4ai7ztd7g4j4@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406163703.hhet4ai7ztd7g4j4@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 09:37:03AM -0700, Josh Poimboeuf wrote:
> On Wed, Apr 06, 2022 at 09:43:30AM +0200, Peter Zijlstra wrote:
> > On Tue, Apr 05, 2022 at 10:32:51PM -0700, Josh Poimboeuf wrote:
> > > More broadly, this issue could theoretically happen in some other places
> > > throughout the kernel tree, since _THIS_IP_ is fundamentally unreliable
> > > as currently written.
> > > 
> > > So we could look at making _THIS_IP_ more predictable.
> > > 
> > > Inline asm would work better ("lea 0(%rip), %[rip]"), but then you need
> > > an arch-dependent implementation...
> > 
> > Well, there's a ton of _THIS_IP_ instances all around, and it would be
> > unfortunate to have them grow into actual code :/
> 
> What do you mean by growing into actual code?  It's still just a single
> instruction, as was the immediate load before.

Aah, indeed. I was somehow thinking we'd get extra instructions.

> Though, you pasted this on irc:
> 
>   #define _THIS_IP_  ({ __label__ __here; __here: asm_volatile_goto ("":::: __here); (unsigned long)&&__here; })
> 
> which seems decent to me, though less than ideal because it grows an
> ENDBR.  But I like its arch-independence, so yeah, LGTM.

I did send hjl an email about that extra endbr, because I really don't
like that. And jump_label (also using asm-goto) doesn't grow those endbr
instructions, so something is weird.
