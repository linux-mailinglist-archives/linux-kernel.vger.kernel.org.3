Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565894F1E0E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379885AbiDDVrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380275AbiDDT1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 15:27:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F137926AD7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 12:25:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B1CC60DFF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 19:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267E1C2BBE4;
        Mon,  4 Apr 2022 19:25:04 +0000 (UTC)
Date:   Mon, 4 Apr 2022 15:25:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: vmlinux.o: warning: objtool: stackleak_erase()+0x35: call to
 ftrace_likely_update() leaves .noinstr.text section
Message-ID: <20220404152502.0621caf9@gandalf.local.home>
In-Reply-To: <202204041125.500C28FD8@keescook>
References: <202204042008.sCQbEmVS-lkp@intel.com>
        <202204041125.500C28FD8@keescook>
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

On Mon, 4 Apr 2022 11:27:47 -0700
Kees Cook <keescook@chromium.org> wrote:

> I got CCed on this because of stackleak_erase() triggering, this, but it
> appears to be an existing issue for other callers too. It looks like
> __branch_check__() shouldn't be emitting ftrace_likely_update() calls
> for noinstr functions...
> 
> I have no idea how a macro is meant to check for function attributes,
> though... :(

Ignore it. It's the branch tracer enabled (that is, every "if ()" is being
traced).

Although I still use the branch profiler, I do not believe anyone uses the
branch tracer. The branch profiler updates an array of counters that tells
when the branch was true or false, the branch tracer actually traces
(records an event) for every branch in the system!

I think I'll just send a patch to nuke the tracer. I'm sure Peter Zijlstra
will be happy when I do that. But I still want the profiler, as I find that
useful.

-- Steve
