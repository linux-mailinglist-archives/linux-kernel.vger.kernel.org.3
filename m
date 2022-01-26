Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC94149CFE1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243231AbiAZQkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbiAZQkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:40:51 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5398CC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 08:40:51 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id v74so240067pfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 08:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xlvtukPzO3AbDCendFmDfyQYe8h/PUQ59az8EWEzUIM=;
        b=Tme9WIGcNwKUvBZLe5uBmYfLFGOUWTb7ZOBDb6YzaqQHeVFLZ/Kf02fTmy5XUTXhtz
         Vdrs7J4JICea53k0jExmgiNaqeAXDYYh60NDrFiruQpSe0jHriYTNcGGwpr73CM3WH0Y
         aYLHRNmqdcXvH5ys19iNwkqCZFu86lMdSOkgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xlvtukPzO3AbDCendFmDfyQYe8h/PUQ59az8EWEzUIM=;
        b=qnDLGjSp4fthX80NE6VGP5tunisNB9V6A/7LThHkerSyce07HY48TswoGYpp8v5yR8
         rbS6l+aPkEg31CEK2uuQDV4dJGP2iBeGFCtybqtRjzkr0ZwbRQ3f57zKl+NEhDkjgEWC
         uTcs0TqtNsmizu/z8JRkaMCU8LwNVc0aHLFEwJ6xeQq38XSM5Wf7F8W8+IH5fyG6WHs1
         KzopBQtGJgxf07+iXWkMdqjuqftKI1lYGydiRV0pM5FnI3xYDGm1SYM9U29TaDw0oBEA
         A2CMZeaC7zaRVUeCx6n+Pxk3J4POTgOyJRl8BW/6S4NT7obvP+/IaduiR3Hq4CVpdm4U
         LvJw==
X-Gm-Message-State: AOAM530rGJ8wPWmOvZzl9678o1XB1Dum4LduBI+dWqSoZ7vxgjrBN/RJ
        oJ0BoT5BibDMDLmOXM/ApU6oOg==
X-Google-Smtp-Source: ABdhPJyazfih2Ue5JGMq/Tmv4ifP9hOFAC5jiPtgcSiXBdga/ZIDhLSQyaX3VcP8OzF1HUiV9tIBJg==
X-Received: by 2002:a63:2023:: with SMTP id g35mr19834474pgg.432.1643215250805;
        Wed, 26 Jan 2022 08:40:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mn2sm3393097pjb.38.2022.01.26.08.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 08:40:50 -0800 (PST)
Date:   Wed, 26 Jan 2022 08:40:49 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ariadne Conill <ariadne@dereferenced.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fs/exec: require argv[0] presence in
 do_execveat_common()
Message-ID: <202201260832.CCC8BB9@keescook>
References: <20220126114447.25776-1-ariadne@dereferenced.org>
 <YfFh6O2JS6MybamT@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfFh6O2JS6MybamT@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 02:59:52PM +0000, Matthew Wilcox wrote:
> On Wed, Jan 26, 2022 at 11:44:47AM +0000, Ariadne Conill wrote:
> > Interestingly, Michael Kerrisk opened an issue about this in 2008[1],
> > but there was no consensus to support fixing this issue then.
> > Hopefully now that CVE-2021-4034 shows practical exploitative use
> > of this bug in a shellcode, we can reconsider.
> > 
> > [0]: https://pubs.opengroup.org/onlinepubs/9699919799/functions/exec.html
> > [1]: https://bugzilla.kernel.org/show_bug.cgi?id=8408
> 
> Having now read 8408 ... if ABI change is a concern (and I really doubt
> it is), we could treat calling execve() with a NULL argv as if the
> caller had passed an array of length 1 with the first element set to
> NULL.  Just like we reopen fds 0,1,2 for suid execs if they were closed.

I was having similar thoughts this morning. We can't actually change the
argc, though, because of the various tests (see the debian code search
links) that explicitly tests for argc == 0 in the child. But, the flaw
is not the count, but rather that argv == argp in the argc == 0 case.
(Or that argv NULL-checking iteration begins at argv[1].)

But that would could fix easily by just adding an extra NULL. e.g.:

Currently:

argc = 1
argv = "foo", NULL
envp = "bar=baz", ..., NULL

argc = 0
argv = NULL
envp = "bar=baz", ..., NULL

We could just make the argc = 0 case be:

argc = 0
argv = NULL, NULL
envp = "bar=baz", ..., NULL

We need to be careful with the stack utilization counts, though, so I'm
thinking we could actually make this completely unconditional and just
pad envp by 1 NULL on the user stack:

argv = "what", "ever", NULL
       NULL
envp = "bar=baz", ..., NULL

My only concern there is that there may be some code out there that
depends on envp immediately following the trailing argv NULL, so I think
my preference would be to pad only in the argc == 0 case and correctly
manage the stack utilization.

-- 
Kees Cook
