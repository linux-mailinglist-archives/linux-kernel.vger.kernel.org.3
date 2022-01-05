Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DD1485C11
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 00:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245304AbiAEXKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 18:10:36 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60752 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbiAEXKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 18:10:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1864B81E1F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 23:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00ED8C36AE9;
        Wed,  5 Jan 2022 23:10:30 +0000 (UTC)
Date:   Wed, 5 Jan 2022 18:10:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Xiangyang Zhang <xyz.sun.ok@gmail.com>, mingo@redhat.com,
        oleg@redhat.com, namhyung.kim@lge.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/kprobes: 'nmissed' not showed correctly for
 kretprobe
Message-ID: <20220105181029.4fa08f6a@gandalf.local.home>
In-Reply-To: <20220106073203.123c4f7e38cc07eccd02aa9b@kernel.org>
References: <20211211150032.7568-1-xyz.sun.ok@gmail.com>
        <20220105141556.12fb2ceb@gandalf.local.home>
        <20220105142208.1dbc20cc@gandalf.local.home>
        <20220106073203.123c4f7e38cc07eccd02aa9b@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2022 07:32:03 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> OK, this is a good catch :), but there are 2 issues.
> 
> 1. kretprobe can be skipped by 2 reasons, shortage of kretprobe_instance which
> is counted by rp.nmissed, and kprobe itself is missed by some reason (this
> can be happen if KPROBE_EVENTS_ON_NOTRACE=n. Thus, better solution is to show
> 'tk->rp.nmissed + tk->rp.kp.nmissed'.
> 
> 2. the commit c31ffb3ff633 is not actual commit which introduce this issue.
>   this was introduced by 4a846b443b4e ("tracing/kprobes: Cleanup kprobe tracer code.")
> 
> 'git blame' tells you the commit which changes that line, but that can be just
> a refactoring (renaming). I recommend you to search the correct one by 'git log -p'.

Masami, thanks for the review.

Xiangyang, can you please send a v2 with Masami's suggestions?

-- Steve
