Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12145489E64
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238357AbiAJR3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237928AbiAJR3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:29:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A36AC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 09:29:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6422AB815CB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 17:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6942EC36AE3;
        Mon, 10 Jan 2022 17:29:39 +0000 (UTC)
Date:   Mon, 10 Jan 2022 12:29:38 -0500
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
Message-ID: <20220110122938.7b6a8847@gandalf.local.home>
In-Reply-To: <20220110122436.5302128f@gandalf.local.home>
References: <20220110115532.536088fd@gandalf.local.home>
        <31c11a47a8bc4e34a1a64d54a54bb944@AcuMS.aculab.com>
        <20220110122436.5302128f@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 12:24:36 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > > Pingfan reported that the following causes a fault:
> > > 
> > >   echo "filename ~ \"cpu\"" > events/syscalls/sys_enter_openat/filter
> > >   echo 1 > events/syscalls/sys_enter_at/enable
> > > 
> > > The reason is that trace event filter treats the user space pointer
> > > defined by "filename" as a normal pointer to compare against the "cpu"
> > > string. If the string is not loaded into memory yet, it will trigger a
> > > fault in kernel space:    
> > 
> > If a userspace pointer can end up the kernel structure then presumably
> > a 'dodgy' user program can supply an arbitrary kernel address instead?
> > This may give the user the ability to read arbitrary kernel addresses
> > (including ones that are mapped to PCIe IO addresses).
> > Doesn't sound good at all.  
> 
> Only root has access to the information read here. All tracing requires
> root or those explicitly given access to the tracing data, which pretty
> much allows all access to kernel internals (including all memory). So
> nothing to worry about here ;-)

BTW, this patch doesn't give any new access to anything. It only protects
if the pointer is pointing someplace that will give a fault. The user could
today point that pointer to anything in kernel memory and trace it (but
only read it if you are root). And worse, if the pointer is to something
that can fault, it will trigger a BUG(). This could happen if root creates
the filter, and a non-privileged user sets that pointer to something bad.
Which means anyone can cause the machine to fault if root does this kind
of tracing. This is why I added the stable tag.

This patch is to prevent that BUG() from happening.

-- Steve
