Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77F248DD4D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbiAMR57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbiAMR55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:57:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D06C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 09:57:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F21661D12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 17:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9215EC36AEB;
        Thu, 13 Jan 2022 17:57:55 +0000 (UTC)
Date:   Thu, 13 Jan 2022 12:57:54 -0500
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
Message-ID: <20220113125754.0cb5273f@gandalf.local.home>
In-Reply-To: <yt9d8rvmt2jq.fsf@linux.ibm.com>
References: <20220110115532.536088fd@gandalf.local.home>
        <31c11a47a8bc4e34a1a64d54a54bb944@AcuMS.aculab.com>
        <20220110122436.5302128f@gandalf.local.home>
        <7a0fefb7ed3542b4a49dee1e78b1668b@AcuMS.aculab.com>
        <yt9d8rvmt2jq.fsf@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 21:55:53 +0100
Sven Schnelle <svens@linux.ibm.com> wrote:

> > Isn't there also at least one architecture where you can't differentiate
> > between user and kernel pointers by looking at the address?
> > (Something like sparc ASI is used for user accesses so both user
> > and kernel get the full 4G address range. But it isn't sparc (or pdp/11))
> > ISTR it causing issues with the code for kernel_setsockopt() and
> > required a separate flag.  
> 
> On s390 TASK_SIZE is defined as -PAGE_SIZE, so with the patch above the
> kernel would always try to fetch it from user space. I think it would be
> the same for parisc.

As a work around for these cases, would something like this work?

-- Steve

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 91352a64be09..06013822764c 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -676,7 +676,15 @@ static __always_inline char *test_string(char *str)
 	ubuf = this_cpu_ptr(ustring_per_cpu);
 	kstr = ubuf->buffer;
 
-	if (likely((unsigned long)str >= TASK_SIZE)) {
+	/*
+	 * Test the address of ustring_per_cpu against TASK_SIZE, as
+	 * comparing TASK_SIZE to determine kernel/user space address
+	 * is not enough on some architectures. If the address is less
+	 * than TASK_SIZE we know this is the case, in which we should
+	 * always use the from_kernel variant.
+	 */
+	if ((unsigned long)&ustring_per_cpu < (unsigned long)TASK_SIZE ||
+	    likely((unsigned long)str >= TASK_SIZE)) {
 		/* For safety, do not trust the string pointer */
 		if (!strncpy_from_kernel_nofault(kstr, str, USTRING_BUF_SIZE))
 			return NULL;
