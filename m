Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF338465A84
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344185AbhLBASR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344287AbhLBASC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:18:02 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1A3C0613FD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 16:13:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EA250CE212B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 00:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B3AC53FAD;
        Thu,  2 Dec 2021 00:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404027;
        bh=e2WW//HnsATfHJono364sgw3a4+9Xl+8LhE997wQAJc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FLOTI0K7m/oMwjOvQn5j0mlN6XuDbSM+fdqoM7YegNrQ+xyTN9J7h3Csx/TL1VDTk
         9n/OY7KnGSZjNb4rmeleUPPchOL0lWA9CSiF0LsEOlp1rSfHDxP+yjmq+3bzwWnxsD
         pjZJ4y68uWCibHA71D8WYGYtJPy/omaR8gFdW72BFDe8lDImvHVI46PQuqWJq781DV
         wR9TOm6nzxXjlP0x+hakkp2NhuFAv1hwj/F+uplgBZ0nYKK6EmPE2Kf7LUtb8S8G+X
         npFeCz5c8i8uQELYUpYQVNvClxQEGANM6oZw7gzzay96u714zzODGZo8HpWsjw4hwh
         Sparo69R6HRNA==
Date:   Thu, 2 Dec 2021 09:13:44 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        zhangyue <zhangyue1@kylinos.cn>, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net
Subject: Re: [PATCH] kprobes: Limit max data_size of the kretprobe instances
Message-Id: <20211202091344.f9725841b0cf704b9342b5f2@kernel.org>
In-Reply-To: <20211201111922.2c52047d@gandalf.local.home>
References: <163836995040.432120.10322772773821182925.stgit@devnote2>
        <20211201111922.2c52047d@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2021 11:19:22 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed,  1 Dec 2021 23:45:50 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > The kretprobe::data_size is unsigned (size_t) but it is
> > used as 'data_size + sizeof(struct kretprobe_instance)'.
> > Thus, it can be smaller than sizeof(struct kretprobe_instance)
> > while allocating memory for the kretprobe_instance.
> 
> The above doesn't make sense.
> 
> data_size is unsigned but it is used as
>  'data_size + sizeof(struct kretprobe_instance)'. 
> 
> What does that mean?
> 
> What can be smaller than sizeof(struct kretprobe_instance) and why does it
> matter?

OK, what about this ?

The 'kprobe::data_size' is unsigned, thus it can not be negative.
But if user sets it enough big number (e.g. (size_t)-8), the result
of 'data_size + sizeof(struct kretprobe_instance)' becomes smaller than
sizeof(struct kretprobe_instance) or zero. In result, the kretprobe_instance
are allocated without enough memory, and kretprobe accesses outside of
allocated memory.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
