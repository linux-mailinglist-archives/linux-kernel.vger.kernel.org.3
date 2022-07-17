Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1351D5777E6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 21:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiGQTQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 15:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGQTQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 15:16:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC1ADF1F
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 12:16:21 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658085344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FFwnWRc7IGxS0ZRT94RlPjA97CP88nVxc93qcbHA/Ow=;
        b=sln340O3/2iUuiJ06gTUqABPkCRF9ZYktow7T/iiFSb9WRp7ZejtXJzn01nZd340pSnOQL
        3cRX3zg4nh+3p+EwPSRvFqAbffVCZlYaA1JczX9rT+4vBnQmVw1cwwofL6VdBW3bmUSK1n
        wE9HdUioMM2slNwBFKLtFlcfTmcBx4fqEfTRSftJdANvgNMzU+M1QYRGbXsMTp19qTUiSX
        zbyXfwhJKIUtA2aKjxhBZ61CL/asudLLJYjSYxKtEoQKhgYe+7udfWTdCATfK0tErYsFZ2
        WnmSKraztplHhYGAqtTzVQtQoH4yC9gVmrZB2XlrjZCJPgacOBwz5uvXeE+vZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658085344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FFwnWRc7IGxS0ZRT94RlPjA97CP88nVxc93qcbHA/Ow=;
        b=TVt5jDIyiH0B9YjBQPkEOtWDJoP5moTUaOhdy7Yk9aVVtGCZeiUcUtqvpZi1dqX/3Bc0ix
        pgxRh6E5l+27GbBg==
To:     David Laight <David.Laight@ACULAB.COM>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: RE: [patch 00/38] x86/retbleed: Call depth tracking mitigation
In-Reply-To: <24673619e9e2411bb1d5f287aab2aa87@AcuMS.aculab.com>
References: <20220716230344.239749011@linutronix.de>
 <f9fd86acac4f49bc8f90b403978e9df3@AcuMS.aculab.com> <8735ezye00.ffs@tglx>
 <24673619e9e2411bb1d5f287aab2aa87@AcuMS.aculab.com>
Date:   Sun, 17 Jul 2022 21:15:44 +0200
Message-ID: <87wncbwnxb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17 2022 at 17:56, David Laight wrote:
> From: Thomas Gleixner
>> On Sun, Jul 17 2022 at 09:45, David Laight wrote:
> I was thinking about what happens after the RSB has underflowed.
> Which is when (I presume) the BTB based speculation happens.
>
>> The intra function call in the retpoline is of course adding a RSB entry
>> which points to the speculation trap, but that gets popped immediately
>> after that by the return which goes to the called function.
>
> I'm remembering the 'active' instructions in a retpoline being 'push; ret'.
> Which is an RSB imbalance.

Looking at the code might help to remember correctly:

        call   1f
        speculation trap
1:      mov     %reg, %rsp
        ret

Thanks,

        tglx
