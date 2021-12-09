Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2904D46F46F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhLIUBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhLIUBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:01:17 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEFDC061746;
        Thu,  9 Dec 2021 11:57:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E8840CE2817;
        Thu,  9 Dec 2021 19:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E764C004DD;
        Thu,  9 Dec 2021 19:57:39 +0000 (UTC)
Date:   Thu, 9 Dec 2021 14:57:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/13] user_events: Add minimal support for
 trace_event into ftrace
Message-ID: <20211209145738.4da346ba@gandalf.local.home>
In-Reply-To: <20211209194235.GA21676@kbox>
References: <20211201182515.2446-1-beaub@linux.microsoft.com>
        <20211201182515.2446-3-beaub@linux.microsoft.com>
        <20211208181905.62f8f999@gandalf.local.home>
        <20211209005823.GA21399@kbox>
        <20211208210336.40c7741b@yoga.local.home>
        <20211209174050.GA21553@kbox>
        <20211209124735.3d1a9707@gandalf.local.home>
        <20211209194235.GA21676@kbox>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2021 11:42:35 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> User program task:
> CPU0: ioctl(fd, REG)
> CPU1: close(fd)
> 
> IE: Some program registers and then immediately calls close on the file.
> If the CPU migrates right between the 2 and the close swaps, it is
> possible this could occur.
> 
> This could be attempted in tight loops maliciously as well.
> 
> I assume with a mutex there that some barrier is imposed to ensure
> correct reads in this condition? (By virtue of the mutex acquire/check)

But as I stated before, the ioctl() uses fdget() which will prevent he
close from calling the release. Even if they get swapped. If close goes
first and starts down the path of the release, then the ioctl is guaranteed
to return -EBADF. If it gets the fd, then close will be a nop, and the exit
of the ioctl will call the release.

If this wasn't the case, then the race I was concerned about would be an
issue.

Because we are both confused by this, add the mutex! :-)

-- Steve
