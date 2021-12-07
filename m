Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3446846B931
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhLGKez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhLGKey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:34:54 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF6DC061574;
        Tue,  7 Dec 2021 02:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=TByCTRHW55BcOFqbUdyHvNHFlb0beEGN8t+460a8BCo=; b=Ziy+y
        uXEx3royqe17pnNUbW8M6G7QdotxI8YJ9q0sKAnhQORmNOJegx7+JIvI5DjjkdTpa9dyE5Sw9tlaX
        CMA+XMrKFyYdsezflnORHsVJoCQZzG1T5x7HSl5PvjCmJY4C5qoBKf95tLTxRpi2sGjyqIejryfML
        QNyjmcgMcYWvE4waNEGZYS8f0o6MbWjpoUiTKHw1XdTViWSxSVk6vcvuErVYCm1Nr2uWPABnZxNbp
        nZQzYs+4PvMadT7G/XNVi6CzWoRSYCtT8JmE0VSvg4bmM5zCGpIKdINtBaM6HDlZEFHlL7Zr1I/E8
        lCpMn+NaRQ2rfzhavg17J7oD0/RYw==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1muXkm-00041Y-4b; Tue, 07 Dec 2021 10:31:20 +0000
Date:   Tue, 7 Dec 2021 10:31:15 +0000
From:   John Keeping <john@metanate.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH/RFC] tracing: make trace_marker{,_raw} stream-like
Message-ID: <Ya835b6JGrjBQCtF@donbot>
References: <20210909115734.3818711-1-john@metanate.com>
 <20210909083529.34ae09da@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909083529.34ae09da@gandalf.local.home>
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Thu, Sep 09, 2021 at 08:35:29AM -0400, Steven Rostedt wrote:
> On Thu,  9 Sep 2021 12:57:34 +0100
> John Keeping <john@metanate.com> wrote:
> 
> > The tracing marker files are write-only streams with no meaningful
> > concept of file position.  Using stream_open() to mark them as
> > stream-link indicates this and has the added advantage that a single
> > file descriptor can now be used from multiple threads without contention
> > thanks to clearing FMODE_ATOMIC_POS.
> > 
> > Note that this has the potential to break existing userspace by since
> > both lseek(2) and pwrite(2) will now return ESPIPE when previously lseek
> > would have updated the stored offset and pwrite would have appended to
> > the trace.  A survey of libtracefs and several other projects found to
> > use trace_marker(_raw) [1][2][3] suggests that everyone limits
> > themselves to calling write(2) and close(2) on these file descriptors so
> > there is a good chance this will go unnoticed and the benefits of
> > reduced overhead and lock contention seem worth the risk.
> > 
> > [1] https://github.com/google/perfetto
> > [2] https://github.com/intel/media-driver/
> > [3] https://w1.fi/cgit/hostap/
> > 
> > Signed-off-by: John Keeping <john@metanate.com>
> > ---
> > I'm marking this as RFC because it breaks the Prime Directive of Linux
> > development, as explained above.  But I'm hoping this is one of the
> 
> The "Prime Directive of Linux development" is the tree falling in the
> forest approach. If you break user space API but there's no user space
> application around to notice the break, did you really break it? The answer
> is "No".
> 
> > cases where we get away with it because this is a huge improvement for
> > multi-threaded programs when doing the simple thing of opening a single
> > trace_marker FD at startup and just writing to it from any thread.
> 
> I like the idea too.
> 
> > 
> > After writing this, I realised that an alternative solution to my
> > original problem would have been to use pwrite instead of write!  But I
> > still think fixing this at the source would be better.
> 
> I'm fine with adding this. But I'm going to add it after the merge window
> for the next release (5.16).
> 
> If someone complains that it broke their application, we may need to revert
> it, but I doubt that will happen.

Were you expecting more input from me on this?  The above sounded like
"will be added for 5.16" but I don't see this change in v5.16-rc4 and
the patch is still marked as "New" in patchwork [1]

[1] https://patchwork.kernel.org/project/linux-trace-devel/patch/20210909115734.3818711-1-john@metanate.com/


Thanks,
John
