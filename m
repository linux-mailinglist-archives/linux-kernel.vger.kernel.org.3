Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C314A529E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 23:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbiAaWtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 17:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiAaWth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 17:49:37 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC274C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 14:49:37 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id f8so13598156pgf.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 14:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8wir+6pnMqsrQN0JTKY9MVVmL8DYWhxBrqC2WV+lKqk=;
        b=VjAau0dRv2pBIMNXN0K9d2B5FLQG+EVsT1VvprxIcF5tDK9444uEsuO4i8ZZ3f3K5I
         QHW5xDQzF277epoHtVEnx0HWFfuWYQ/iYtvG4HkMmeueTpiaVZ0MF8l6qyDfKCwg7Hcz
         mI9e2nloraRVjCx467VHEozrCrlc0zX7Fkpyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8wir+6pnMqsrQN0JTKY9MVVmL8DYWhxBrqC2WV+lKqk=;
        b=sKqxH9hsqj+zrzfFuJOEaNmhyQ3wFTAHcDT34sK88I6LC1Y0U+kyATPfm98AvHwZ0/
         30dzzoHHvZYfSYe2DoL29vanV6ZS3O7CvqQMD1Q3jssrYvIvsCI0bgeMhhqzFHOAyPe8
         7k+Rax4H1xnfDjTzx7e1sMyeviLfgE0K+dEXU53Q6S8PSiCJoRma+bYjSmaJy2wBuqRB
         Zvbdiv77YOMlEp6oOX0MuDd9pUoBiI9kjGfeqCZVoWcoc+8GPaHhrNcd59B1vHDGIjpB
         xlZwoqCJ1kqH5O5KUURhKOyGosTrdfmaQbhe9aEvwvWr5Nzfn6nO/4rvYLc+VIl41+UY
         wqsw==
X-Gm-Message-State: AOAM530FNG3OcJNYCIzUv5gfi0DiG5qxcwlewJ8O4YFDpNIMo9Hw7Avo
        n0cU/Ub4rzXFqGe+sqQgeHxEClWNC8bO5A==
X-Google-Smtp-Source: ABdhPJz+YkwU7ATFKX2Qclfrkfe/Lhh1AMyaXK3ADBFnJOq28Oae1+USoXmwL894u2iu9dgheaXpCQ==
X-Received: by 2002:a63:2c0c:: with SMTP id s12mr15167611pgs.331.1643669377455;
        Mon, 31 Jan 2022 14:49:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a125sm11726190pfa.205.2022.01.31.14.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:49:37 -0800 (PST)
Date:   Mon, 31 Jan 2022 14:49:36 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        kernel test robot <oliver.sang@intel.com>,
        Ariadne Conill <ariadne@dereferenced.org>,
        0day robot <lkp@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Rich Felker <dalias@libc.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [fs/exec]  80bd5afdd8: xfstests.generic.633.fail
Message-ID: <202201311447.4A1CCAF@keescook>
References: <20220127000724.15106-1-ariadne@dereferenced.org>
 <20220131144352.GE16385@xsang-OptiPlex-9020>
 <20220131150819.iuqlz3rz6q7cheap@wittgenstein>
 <Yff9+tIDAvYM5EO/@casper.infradead.org>
 <20220131153707.oe45h7tuci2cbfuv@wittgenstein>
 <YfgFeWbZPl+gAUYE@casper.infradead.org>
 <20220131161415.wlvtsd4ecehyg3x5@wittgenstein>
 <20220131171344.77iifun5wdilbqdz@wittgenstein>
 <20220131135940.20790cff1747e79dd855aaf4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131135940.20790cff1747e79dd855aaf4@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 01:59:40PM -0800, Andrew Morton wrote:
> On Mon, 31 Jan 2022 18:13:44 +0100 Christian Brauner <brauner@kernel.org> wrote:
> 
> > > in other words, the changes that you see CMD_ARGS[0] == NULL for
> > > execveat() seem higher than for path-based exec.
> > > 
> > > To counter that we should probably at least update the execveat()
> > > manpage with a recommendation what CMD_ARGS[0] should be set to if it
> > > isn't allowed to be set to NULL anymore. This is why was asking what
> > > argv[0] is supposed to be if the binary doesn't take any arguments.
> > 
> > Sent a fix to our fstests now replacing the argv[0] as NULL with "".
> 
> As we hit this check so quickly, I'm thinking that Ariadne's patch
> "fs/exec: require argv[0] presence in do_execveat_common()" (which
> added the check) isn't something we'll be able to merge into mainline?

I think the next best would be to mutate an NULL argv into { "", NULL }.
However, I still think we should do the pr_warn().

Thoughts?

-- 
Kees Cook
