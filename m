Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863CD48DFDF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 22:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbiAMVvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 16:51:20 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54818 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbiAMVvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 16:51:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E13BB61C36
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 21:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE16C36AEA;
        Thu, 13 Jan 2022 21:51:17 +0000 (UTC)
Date:   Thu, 13 Jan 2022 16:51:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, hca@linux.ibm.com,
        deller@gmx.de
Subject: Re: [PATCH v2] tracing: Add test for user space strings when
 filtering on  string pointers
Message-ID: <20220113165115.0c844df9@gandalf.local.home>
In-Reply-To: <yt9dwnj3wcke.fsf@linux.ibm.com>
References: <20220110115532.536088fd@gandalf.local.home>
        <31c11a47a8bc4e34a1a64d54a54bb944@AcuMS.aculab.com>
        <20220110122436.5302128f@gandalf.local.home>
        <7a0fefb7ed3542b4a49dee1e78b1668b@AcuMS.aculab.com>
        <yt9d8rvmt2jq.fsf@linux.ibm.com>
        <20220113125754.0cb5273f@gandalf.local.home>
        <yt9dwnj3wcke.fsf@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2022 22:28:01 +0100
Sven Schnelle <svens@linux.ibm.com> wrote:
> 
> Hmm, i don't see how. On s390, TASK_SIZE is -PAGE_SIZE, which means
> 0xfffffffffffff000 so i think the if() condition below is always true.

Yes, I did that to just use the kernel version and not the user space one.

This is just a workaround for now.

> 
> Too bad that the __user attribute is stripped during a normal compile.
> But couldn't we add the information whether a pointer belongs to user
> or kernel space in the trace event definition? For syscall tracing it's
> easy, because pointer types in SYSCALL_DEFINE() and friends are always
> userspace pointers?

We could add something later. As it is currently the merge window, and this
is a real bug, I'm going to just leave it as is, and we can work to fix the
other archs later. I need to get a pull request ready by tomorrow.

-- Steve
