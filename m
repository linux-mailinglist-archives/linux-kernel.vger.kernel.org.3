Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CCB48A446
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 01:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242906AbiAKAVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 19:21:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59320 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238346AbiAKAVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 19:21:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC49E614C5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 00:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A045C36AE5;
        Tue, 11 Jan 2022 00:21:05 +0000 (UTC)
Date:   Mon, 10 Jan 2022 19:21:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v2] tracing: Add test for user space strings when
 filtering on  string pointers
Message-ID: <20220110192104.5daaabe7@gandalf.local.home>
In-Reply-To: <7c2789f990394df5b7907287fc0e1232@AcuMS.aculab.com>
References: <20220110115532.536088fd@gandalf.local.home>
        <31c11a47a8bc4e34a1a64d54a54bb944@AcuMS.aculab.com>
        <20220110122436.5302128f@gandalf.local.home>
        <7c2789f990394df5b7907287fc0e1232@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 22:03:20 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> > Only root has access to the information read here. All tracing requires
> > root or those explicitly given access to the tracing data, which pretty
> > much allows all access to kernel internals (including all memory). So
> > nothing to worry about here ;-)  
> 
> Is this filtering trace using a filename passed to a system call by a user program?
> In which case a user program can set up a system call that normally fails
> (because the copy_from_user() errors) but if root tries to run a system
> call event trace on that process can read arbitrary addresses and
> thus crash the system?
> 
> While unlikely root might be persuaded to try to run the trace.

Yes. That's exactly what the code does today, and why it's a bug.

This patch instead uses copy_from_user_nofault/copy_from_kernel_nofault and
copies it into a temp buffer and then compares against that.

If a user passes in a crazy pointer, the copy_from_user/kernel_nofault()
will not read it, and the filter simply fails to match. Nothing bad will
happen.

-- Steve
