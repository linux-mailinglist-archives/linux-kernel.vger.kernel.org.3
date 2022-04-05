Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873A04F4DBA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582897AbiDEXuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390737AbiDEPbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:31:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE4247396
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:39:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D364361899
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 13:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80635C385A1;
        Tue,  5 Apr 2022 13:39:01 +0000 (UTC)
Date:   Tue, 5 Apr 2022 09:38:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: vmlinux.o: warning: objtool: stackleak_erase()+0x35: call to
 ftrace_likely_update() leaves .noinstr.text section
Message-ID: <20220405093859.05660166@gandalf.local.home>
In-Reply-To: <20220405080335.GC30877@worktop.programming.kicks-ass.net>
References: <202204042008.sCQbEmVS-lkp@intel.com>
        <202204041125.500C28FD8@keescook>
        <20220404152502.0621caf9@gandalf.local.home>
        <20220405080335.GC30877@worktop.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2022 10:03:35 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > I think I'll just send a patch to nuke the tracer. I'm sure Peter Zijlstra
> > will be happy when I do that. But I still want the profiler, as I find that
> > useful.  
> 
> It'll explode the moment Lai's entry rework goes through. That'll make
> us run C code before we switch to the kernel address space, so your
> counters will not exist/be-mapped and *BOOM*.

We could black list those areas. Just add:

#define DISABLE_BRANCH_PROFILING at the top of any file and it will not
do the profiling.

-- Steve
