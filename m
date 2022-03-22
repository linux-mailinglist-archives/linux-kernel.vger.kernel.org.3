Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975374E3EBC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbiCVMsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiCVMsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:48:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665401B7B4;
        Tue, 22 Mar 2022 05:46:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C9C8DCE1DE9;
        Tue, 22 Mar 2022 12:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14E7C340EC;
        Tue, 22 Mar 2022 12:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647953195;
        bh=wZ3oIwVDZDmNROUcHtUdRyFl6dXJ+VpbUzC1mZmGrmc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=muAtEfcagfShZa7+gWpyrzfPnx4sXjQXQFwVLQvC6ubXFFW/0cp1m/mYtM0/ajpPt
         u7HqTrzTAWnk5nOHD2WmnsfmoMIdv9O5kAI7JoSaGlrNEz+DjFbQc6S8xbx2NrSg/b
         JPNxbVKFHqcJcqBGPOpc5e01gvPIRUx9WK89A5txGJgpxPvrqMQO/0/J4lfQB65ksS
         V5JpShqoy7nErJeRQri/Mm08KQ2Uk8+UnEk4yc63cSXzKHfZ4hVEe10r3+GjthNBxN
         N2sSBsGBHZE5OQUCCcbfRH6gr31TxiV+gGPYk729iBrLl6zCTvJL7iLnCUMjMTzZDu
         qg5++8QToB6ZQ==
Date:   Tue, 22 Mar 2022 21:46:29 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        rostedt@goodmis.org, ast@kernel.org, hjl.tools@gmail.com,
        rick.p.edgecombe@intel.com, rppt@kernel.org,
        linux-toolchains@vger.kernel.org, Andrew.Cooper3@citrix.com,
        ndesaulniers@google.com
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-Id: <20220322214629.2bf40306e3beba23d88d509f@kernel.org>
In-Reply-To: <Yjm+TmKyO+HDOBgN@hirez.programming.kicks-ass.net>
References: <20220321140327.777f9554@canb.auug.org.au>
        <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
        <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net>
        <YjisdqdofbDIYj2U@hirez.programming.kicks-ass.net>
        <20220322143136.0e78366c3521b54b7b9385b8@kernel.org>
        <Yjm+TmKyO+HDOBgN@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2022 13:17:18 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Mar 22, 2022 at 02:31:36PM +0900, Masami Hiramatsu wrote:
> 
> > > But I still think it's fairly terrible to get a (flawed) carbon copy of
> > > the kretprobe code.
> > 
> > Indeed. I would like to replace the trampoline code of kretprobe with
> > rethook, eventually. There is no reason why we keep the clone.
> > (But I need more arch maintainers help for that, there are too many
> >  archs implemented kretprobes)
> 
> CONFIG_KPROBE_ON_RETHOOK - and then implement archs one by one?

Sounds good! Maybe we will see different data structure fields
which depends on that config, but those are internal fields, so
user will not access it.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
