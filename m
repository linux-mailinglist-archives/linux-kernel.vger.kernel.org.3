Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E165E46F4B1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhLIUOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:14:50 -0500
Received: from linux.microsoft.com ([13.77.154.182]:44528 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhLIUOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:14:47 -0500
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9531320B7179;
        Thu,  9 Dec 2021 12:11:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9531320B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1639080673;
        bh=MwKzx6KIgQvdDykBif/d+ueE+LUk28ZQxSjpQ1njwRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CRkT7Af5CLZ0GAd26QCO9/Fw0YVw6fiupTN9wBKCe/L9VCzZPfGpXhxCf4BlF1tJZ
         JXDWKNuh59e/eCbzo9BppSZ1oy1dw33RPXQMFI3LIZqcJjLQLmIg/Cmu+iJsK1L1/n
         XlM67F+il8/FQqA27Zvhj8iEzmQzY6qLRCzM7cKE=
Date:   Thu, 9 Dec 2021 12:11:12 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/13] user_events: Add minimal support for
 trace_event into ftrace
Message-ID: <20211209201112.GB21676@kbox>
References: <20211201182515.2446-1-beaub@linux.microsoft.com>
 <20211201182515.2446-3-beaub@linux.microsoft.com>
 <20211208181905.62f8f999@gandalf.local.home>
 <20211209005823.GA21399@kbox>
 <20211208210336.40c7741b@yoga.local.home>
 <20211209174050.GA21553@kbox>
 <20211209124735.3d1a9707@gandalf.local.home>
 <20211209194235.GA21676@kbox>
 <20211209145738.4da346ba@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209145738.4da346ba@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 02:57:38PM -0500, Steven Rostedt wrote:
> On Thu, 9 Dec 2021 11:42:35 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > User program task:
> > CPU0: ioctl(fd, REG)
> > CPU1: close(fd)
> > 
> > IE: Some program registers and then immediately calls close on the file.
> > If the CPU migrates right between the 2 and the close swaps, it is
> > possible this could occur.
> > 
> > This could be attempted in tight loops maliciously as well.
> > 
> > I assume with a mutex there that some barrier is imposed to ensure
> > correct reads in this condition? (By virtue of the mutex acquire/check)
> 
> But as I stated before, the ioctl() uses fdget() which will prevent he
> close from calling the release. Even if they get swapped. If close goes
> first and starts down the path of the release, then the ioctl is guaranteed
> to return -EBADF. If it gets the fd, then close will be a nop, and the exit
> of the ioctl will call the release.
> 
> If this wasn't the case, then the race I was concerned about would be an
> issue.
> 
> Because we are both confused by this, add the mutex! :-)
> 
> -- Steve

Agreed, I will add the mutex. :)

I guess I am being paranoid about an architecture that does not have
automatic cache consistency and while the write / read don't happen at
the exact time, they happen close together. Close enough that one CPU
reads the old value from a cache line and gets it wrong.

I don't believe that is possible on Intel, but I don't know if it's
possible on other architectures (especially older ones).

Thanks,
-Beau
