Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBCF57C061
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 00:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiGTW6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 18:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiGTW6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 18:58:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877885D0CB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 15:58:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CD2AB8222E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2266C341C7;
        Wed, 20 Jul 2022 22:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658357891;
        bh=WoBWhzEzDatHigwAp7WW78AXxwNWlr9H/kMGmBGhukw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MoyjKp/suhAMM1A1JhBCpFigwNBGijyP1YcVsHE0iYIlzVpGFyZIBVgaQg1p4+VdC
         24qppGEdHlb0ejxjQvHdbGj9qeVeo89ja1JveZN0wHYLrsclNeS+dg47y1KOk3l6R7
         7oHby2tB1/4C9ToxO8Cgx84Z24vgu9TjRwtuJlLhIYnqTxA6uJrfo7JS+gDXKkB4PW
         F/WJGqJiCHhU9HkTm0XmrhH6vQg1hut64+APTwaRIuRziOQ56P5FxbK8MKT19KHVOE
         YS1KYRI6mG7CDOhhGk3EXd0oKzA6d40BdJglL9oBBi5zc4jzk4284VsbyWTKn0YqG7
         n79bsnumQsNfA==
Date:   Wed, 20 Jul 2022 15:58:09 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH] lkdtm: Keep the rodata test from causing retbleed
 WARNINGS
Message-ID: <20220720225809.wtnlgvof6wi4owkq@treble>
References: <20220720155507.4f904a58@gandalf.local.home>
 <202207201311.775CB068@keescook>
 <20220720225615.lrt7xnxv3trmiyc7@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220720225615.lrt7xnxv3trmiyc7@treble>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 03:56:18PM -0700, Josh Poimboeuf wrote:
> On Wed, Jul 20, 2022 at 01:13:05PM -0700, Kees Cook wrote:
> > On Wed, Jul 20, 2022 at 03:55:07PM -0400, Steven Rostedt wrote:
> > > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > > 
> > > The rodata test checks if executable code in the .rodata section will not
> > > execute. But this also means that fix ups that the return hook code does
> > > will not be able to change this code at boot up, and this causes a
> > > warning.
> > > 
> > > By removing the RETHOOK_CFLAGS from the compilation of the rodata function
> > > makes it hidden from objtool and it will not add its return hook into the
> > > .returns section. This keeps the fix up code from trying and failing on
> > > modifying the rodata return call.
> > > 
> > > Link: https://lore.kernel.org/all/20220720125736.48164a14@gandalf.local.home/
> > > 
> > > Fixes: ee88d363d1561 ("x86,static_call: Use alternative RET encoding")
> > > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > 
> > Yeah, this matches a portion of what was suggested:
> > https://lore.kernel.org/lkml/20220713213133.455599-1-keescook@chromium.org/
> > 
> > But it still needed objtool fixes:
> > https://lore.kernel.org/lkml/20220715032333.neywlazczbb35w3b@treble/
> > 
> > Perhaps objtool has already had patches landed for this? (Otherwise the
> > patch you suggested would fail to build on x86 with rethunk support.)
> 
> I send this patch out a few days ago, nobody picked it up yet:
> 
> https://lkml.kernel.org/lkml/8ec0039712f252693049c70ed3891d39a2357112.1658155446.git.jpoimboe@kernel.org

Actually Peter said he grabbed it and is planning to push it to -tip
tomorrow.

-- 
Josh
