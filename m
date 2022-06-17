Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47544550035
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 00:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347556AbiFQWwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 18:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiFQWwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 18:52:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C4659322
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 15:52:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DFF4B825F3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 22:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30599C3411B;
        Fri, 17 Jun 2022 22:51:59 +0000 (UTC)
Date:   Fri, 17 Jun 2022 18:51:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] x86/ftrace: Remove OBJECT_FILES_NON_STANDARD usage
Message-ID: <20220617185157.3c6f442a@gandalf.local.home>
In-Reply-To: <b7a7a42fe306aca37826043dac89e113a1acdbac.1654268610.git.jpoimboe@kernel.org>
References: <b7a7a42fe306aca37826043dac89e113a1acdbac.1654268610.git.jpoimboe@kernel.org>
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

On Fri,  3 Jun 2022 08:04:44 -0700
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> The file-wide OBJECT_FILES_NON_STANDARD annotation is used with
> CONFIG_FRAME_POINTER to tell objtool to skip the entire file when frame
> pointers are enabled.  However that annotation is now deprecated because
> it doesn't work with IBT, where objtool runs on vmlinux.o instead of
> individual translation units.
> 
> Instead, use more fine-grained function-specific annotations:
> 
> - The 'save_mcount_regs' macro does funny things with the frame pointer.
>   Use STACK_FRAME_NON_STANDARD_FP to tell objtool to ignore the
>   functions using it.
> 
> - The return_to_handler() "function" isn't actually a callable function.
>   Instead of being called, it's returned to.  The real return address
>   isn't on the stack, so unwinding is already doomed no matter which
>   unwinder is used.  So just remove the STT_FUNC annotation, telling
>   objtool to ignore it.  That also removes the implicit
>   ANNOTATE_NOENDBR, which now needs to be made explicit.
> 
> Fixes the following warning:
> 
>   vmlinux.o: warning: objtool: __fentry__+0x16: return with modified stack frame
> 
> Fixes: ed53a0d97192 ("x86/alternative: Use .ibt_endbr_seal to seal indirect calls")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
> v2:
> - fix return_to_handler()

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
