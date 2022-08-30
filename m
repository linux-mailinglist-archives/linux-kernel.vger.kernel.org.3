Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDA35A5AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 06:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiH3Esi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 00:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiH3EsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 00:48:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89146B02BA;
        Mon, 29 Aug 2022 21:48:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B2F9B811B9;
        Tue, 30 Aug 2022 04:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FF2C433D7;
        Tue, 30 Aug 2022 04:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661834894;
        bh=fx/2R2KpWM7H7A+xXD+jhcW9b7yHd7jYx/HOk0b0+FM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lfi5ILY7H7MlFVkOoxKjJwpESchr+4w3n5xuiE4sXXJySElHGle+AWHp2j3itzS/b
         1FzA3t1FdGjnVZpulB3FDolZ28wXbpWg1dj89dYE+zEyh4ULGAyH4Pn4ti9NS7kvxL
         K11VRl/0ic+6/L5rpXm1QLo+sjBgLzjVKzzmR/DvYWjgx5I3b2qk/6RuMVQvknoRhA
         sGmj3xCJFv8VUlPM5CB2RDBWUnn6HRiWsxt+X6LehzqNuKGmcOjtydPaKZFHoxTSXV
         Gtf83tVJQvUOyRhdABK9Yi23Y++hAN5DD7CYfhNW6wdjLoBWWb3wrqYuZprKL9yPMz
         2ebaN29wWwh9g==
Date:   Mon, 29 Aug 2022 21:48:11 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Peter Zijlstra' <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Michael Matz <matz@suse.de>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/sev: Mark snp_abort() noreturn
Message-ID: <20220830044811.jad66k4sxdfnprul@treble>
References: <20220824152420.20547-1-bp@alien8.de>
 <20220824172929.GA25951@gate.crashing.org>
 <YwaN2HtMyM0YEdSB@worktop.programming.kicks-ass.net>
 <20220824224144.GC25951@gate.crashing.org>
 <YwcZjxVkO/lspvmv@worktop.programming.kicks-ass.net>
 <ce56926842dc49ecb08ddb9d828590af@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce56926842dc49ecb08ddb9d828590af@AcuMS.aculab.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 01:12:42PM +0000, David Laight wrote:
> ...
> > Objtool follows control flow. As you said above, noreturn functions
> > behave differently and code-gen after a call to a noreturn function
> > stops.
> 
> Thinks....
> 
> How near is objtool to outputting a list of functions and the
> stack offset at which they call something else?

It basically already does this.

> With the 'magic numbers' to track indirect jumps that is very
> nearly enough information to do full static stack depth checking.

What do you mean by 'magic numbers'?

-- 
Josh
