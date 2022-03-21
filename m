Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93514E2E35
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351298AbiCUQkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbiCUQkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:40:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BD917E18;
        Mon, 21 Mar 2022 09:39:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B68D9B8184C;
        Mon, 21 Mar 2022 16:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCE3C340F2;
        Mon, 21 Mar 2022 16:39:07 +0000 (UTC)
Date:   Mon, 21 Mar 2022 12:39:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        mhiramat@kernel.org, ast@kernel.org, hjl.tools@gmail.com,
        rick.p.edgecombe@intel.com, rppt@kernel.org,
        linux-toolchains@vger.kernel.org, Andrew.Cooper3@citrix.com,
        ndesaulniers@google.com
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-ID: <20220321123905.5696c6c0@gandalf.local.home>
In-Reply-To: <20220321122259.28146a7a@gandalf.local.home>
References: <20220321140327.777f9554@canb.auug.org.au>
        <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
        <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net>
        <20220321112805.1393f9b9@gandalf.local.home>
        <YjiiDFHIQg78QwSb@hirez.programming.kicks-ass.net>
        <20220321121209.3b95e406@gandalf.local.home>
        <20220321121549.1c8588c5@gandalf.local.home>
        <20220321122259.28146a7a@gandalf.local.home>
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

On Mon, 21 Mar 2022 12:22:59 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Or maybe another solution is:
> 
> funcA:
> 	[..]
> 	jmp funcB
> 	call __fexit__
> 	ret
> 
> And if funcA is being traced, we change jmp to a call.
> 
> 	[..]
> 	call funcB
> 	call __fexit__

We could also make __fexit__ a tail call:

> 	ret


funcA:
	[..]
	call funcB
	jmp __fexit__

We would also need a way to know that funcA has a tail call at the end. So
more help from either the compiler or objtool.

-- Steve
