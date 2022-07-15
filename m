Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EBE5759F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 05:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240831AbiGODXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 23:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiGODXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 23:23:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFE125D5;
        Thu, 14 Jul 2022 20:23:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B98C4621EF;
        Fri, 15 Jul 2022 03:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE6DC34115;
        Fri, 15 Jul 2022 03:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657855416;
        bh=Tiz39a+fQBBvhJrzoj9LYYwXD+rBScSLrHuQAUtB3x8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jXNHDeXXkhakwcPHiZ2+Lwc2iDc9LzG0xw/YavTl0q1s9JxifW/LPdbkBiYgzByco
         wU+e+IfodY6EFQJpGVb0kuA2hUUxanICcWhhuV0iFJanLycMnRT6rGGMid7FUZ5zEX
         bcoet+qWEKFxy586hdGObbMoztrmTSLRUcZZNprgdx5Vkx1hr65lA0vshaNEx8gt/r
         R8nNjgLrqh5yFL4tHppbc3XbgKoqKSMY4DP1bJmItjuxqBwHhyQ+3du6TDDJlEqV29
         Oy22Acz52xUSTUpPwr574VLwabYsDQx/JUJRXSBe+WkzzGurK84tcV9XsY2xg/SIRR
         /wAAhhy/WQXvQ==
Date:   Thu, 14 Jul 2022 20:23:33 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <oliver.sang@intel.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86: Allow for exclusions in checking RETHUNK
Message-ID: <20220715032333.neywlazczbb35w3b@treble>
References: <20220713213133.455599-1-keescook@chromium.org>
 <20220713235556.umnau6nd7u6bz72m@treble>
 <Ys/DNIyc+4ju7Qmb@worktop.programming.kicks-ass.net>
 <20220714185006.6brfnnzhz7p7zw3u@treble>
 <20220714185605.jo5iubnsgz6jr2wb@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220714185605.jo5iubnsgz6jr2wb@treble>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 11:56:07AM -0700, Josh Poimboeuf wrote:
> On Thu, Jul 14, 2022 at 11:50:08AM -0700, Josh Poimboeuf wrote:
> > On Thu, Jul 14, 2022 at 09:18:12AM +0200, Peter Zijlstra wrote:
> > > On Wed, Jul 13, 2022 at 04:55:56PM -0700, Josh Poimboeuf wrote:
> > > > Here's the ANNOTATE_UNSAFE_RET idea.
> > > 
> > > Right, I suppose that strictly speaking the compiler can do whatever and
> > > there's no actual guarantee the annotation hits the RET instruction, in
> > > practise it should work, esp. since noinstr.
> > 
> > Hm, KASAN is introducing a weird function, resulting in a naked return
> > warning since we have RETHUNK_CFLAGS removed on that file.
> > 
> > 0000000000000000 <_sub_I_00099_0>:
> >    0:	e8 00 00 00 00       	call   5 <_sub_I_00099_0+0x5>	1: R_X86_64_PLT32	__tsan_init-0x4
> >    5:	c3                   	ret    
> > 
> > 
> > Looks like the "KASAN_SANITIZE_rodata.o := n" isn't working somehow?
> 
> Oh never mind, I got KASAN/KCSCAN mixed up.  Needs both disabled :-/

Well, my ANNOTATE_UNSAFE_RET trick didn't quite work either, as it
results in .discard.retpoline_safe pointing to .rodata when IBT is
enabled.

Instead I'll just do OBJECT_FILES_NON_STANDARD_rodata.o.  That shouldn't
break LTO/IBT because the linked code lives in .rodata anyway.

Will have patches tomorrow, if they pass bot testing.

-- 
Josh
