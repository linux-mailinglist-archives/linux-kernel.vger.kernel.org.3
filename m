Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C761E4AAF32
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 13:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbiBFMfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 07:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiBFMfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 07:35:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE84C043182;
        Sun,  6 Feb 2022 04:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dlHtdM4jQUdvr1gEwIXtPFjy6fGyO2EwwEyEZ5or8OU=; b=OIGEw3agOpqRHgP0nDkT/shAk3
        TpkVNeFyNQyVWGCRjh+I2Je04yaXNi1YZMED2c7lvLEou41dDO6cpq1rwjrxCfmd/NlWV0NfmLGae
        wysJEljAtaELp+Mn95zsTWOG/ksJhXoqtHs5k5IgkahkVyyyBLoyMpRneUFk19I0ISMEIIvdcBENs
        M21n0KEk8ti1Lt4WC+vAK4U6KBSQAbUpPgMrYsDzL5fchly0hHD/GcIV4jFGT/nwmEPSxuupsaRCV
        HTsKE6ZrByjgEiawuo3furVzAFH0s26dDW4BduC2E0EkrkD7E+gArbC5vp3pr8sVZ6EY4typg0ogB
        UB2nWT8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGgla-00E0m9-L1; Sun, 06 Feb 2022 12:35:43 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A0BD98622D; Sun,  6 Feb 2022 13:35:41 +0100 (CET)
Date:   Sun, 6 Feb 2022 13:35:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] gcc-plugins/stackleak: Use noinstr in favor of notrace
Message-ID: <20220206123541.GB23216@worktop.programming.kicks-ass.net>
References: <20220203201754.1145358-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203201754.1145358-1-keescook@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 12:17:54PM -0800, Kees Cook wrote:
> While the stackleak plugin was already using notrace, objtool is now a
> bit more picky. Update the notrace uses to noinstr. Silences the
> following objtool warnings when building with:
> 
> CONFIG_DEBUG_ENTRY=y
> CONFIG_STACK_VALIDATION=y
> CONFIG_VMLINUX_VALIDATION=y
> CONFIG_GCC_PLUGIN_STACKLEAK=y
> 
> vmlinux.o: warning: objtool: do_syscall_64()+0x9: call to stackleak_track_stack() leaves .noinstr.text section
> vmlinux.o: warning: objtool: do_int80_syscall_32()+0x9: call to stackleak_track_stack() leaves .noinstr.text section
> vmlinux.o: warning: objtool: exc_general_protection()+0x22: call to stackleak_track_stack() leaves .noinstr.text section
> vmlinux.o: warning: objtool: fixup_bad_iret()+0x20: call to stackleak_track_stack() leaves .noinstr.text section
> vmlinux.o: warning: objtool: do_machine_check()+0x27: call to stackleak_track_stack() leaves .noinstr.text section
> vmlinux.o: warning: objtool: .text+0x5346e: call to stackleak_erase() leaves .noinstr.text section
> vmlinux.o: warning: objtool: .entry.text+0x143: call to stackleak_erase() leaves .noinstr.text section
> vmlinux.o: warning: objtool: .entry.text+0x10eb: call to stackleak_erase() leaves .noinstr.text section
> vmlinux.o: warning: objtool: .entry.text+0x17f9: call to stackleak_erase() leaves .noinstr.text section
> 
> Note that the plugin's addition of calls to stackleak_track_stack()
> from noinstr functions is expected to be safe, as it isn't runtime
> instrumentation and is self-contained.
> 
> Cc: Alexander Popov <alex.popov@linux.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

No, I didn't suggest this and it is actively wrong. noinstr *really*
should mean no instrumentation, nothing, nada, zip.

