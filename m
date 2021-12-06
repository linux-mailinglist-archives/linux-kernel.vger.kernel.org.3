Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED33A4695A9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243054AbhLFMcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:32:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36863 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232833AbhLFMcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638793734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GwJR9gZ9PzNf1CDN94rO/0aNcwLQX7/tXDK1ztedUis=;
        b=coeRnbU0gEGya1W+zQVTSVVwvN/bPSeWQlpT8sVeXEd3nWpm9WppoqwjQIQMRuBKpXk5XA
        WTUAFHKxG3ZEtq57cZJ6IGxOrYBxjSXCi4o0xYQhD4b4EmxssN3P2fhFgJrX0NVJFx5HYn
        9NxxM+jqrrIw+giDhL+XXvS5wK0ZpGk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-kUkTAwhmOSuKhck5MHx2WA-1; Mon, 06 Dec 2021 07:28:53 -0500
X-MC-Unique: kUkTAwhmOSuKhck5MHx2WA-1
Received: by mail-ed1-f71.google.com with SMTP id w5-20020a05640234c500b003f1b9ab06d2so8218963edc.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 04:28:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GwJR9gZ9PzNf1CDN94rO/0aNcwLQX7/tXDK1ztedUis=;
        b=BxW8QwXxLa+oXgEtYa1unqyDewQlqo7UFxe7a4tqyW6j1OJQ4QUhYZe+GRxq21aQjI
         yfgknNwIIXPc/zX3EdQoduNxky2XjBUYYu0YqPDyAG7yojwu9iLpEwlgGd8zS1jz9xdC
         GvwkHsfOlWbqxr8mLq0rJhiIKhXEj7b6g4rAVfI7Ryrj1zUvmgMKarJt0l627QtXZ8Ij
         y15dqnciww67Bxjsn3sYCFYvT07WF2jI/4lrBWNFlGnyG5YsaoZBlsmGD3g/qvpVtKGr
         SKihuBIm651XCK36E755F3+ieQKEtZohBFOWwOnm1jUDYdHxzX9tjpT1JHsfDmx9kbdA
         LZOg==
X-Gm-Message-State: AOAM531M6LGGA5ITfwa9pOtzvLsOSYDVOixUz1243UUz819aQc1W1bTW
        MyvSP2zIqwazWOIFxn6iCX6ZnXo3u5G5DtlTSnGe0C20PKPTQGaC+WO8rV6R/I5vKO2ESwUQSkp
        tuyk6HcJr7ZO35zQbHd0PxYra
X-Received: by 2002:a17:907:8a12:: with SMTP id sc18mr45924509ejc.274.1638793731838;
        Mon, 06 Dec 2021 04:28:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUTZ6NbFn0CF2OqrMKw4KtVY2lwzJTDH1VcjDi0WxS2ikl+V+VsRId2MZLJCNqPnY+LpkBAQ==
X-Received: by 2002:a17:907:8a12:: with SMTP id sc18mr45924495ejc.274.1638793731656;
        Mon, 06 Dec 2021 04:28:51 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id co10sm7821898edb.83.2021.12.06.04.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 04:28:51 -0800 (PST)
Date:   Mon, 6 Dec 2021 13:28:50 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] ftrace/samples: Add module to test multi direct
 modify interface
Message-ID: <Ya4CAt3WRoLra2DJ@krava>
References: <20211205232036.51996-1-jolsa@kernel.org>
 <20211205232036.51996-4-jolsa@kernel.org>
 <Ya3zMZPcrnSc0Szm@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya3zMZPcrnSc0Szm@osiris>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 12:25:37PM +0100, Heiko Carstens wrote:
> On Mon, Dec 06, 2021 at 12:20:36AM +0100, Jiri Olsa wrote:
> > Adding ftrace-direct-multi-modify.ko kernel module that uses
> > modify_ftrace_direct_multi API. The core functionality is taken
> > from ftrace-direct-modify.ko kernel module and changed to fit
> > multi direct interface.
> > 
> > The init function creates kthread that periodically calls
> > modify_ftrace_direct_multi to change the trampoline address
> > for the direct ftrace_ops. The ftrace trace_pipe then shows
> > trace from both trampolines.
> > 
> > Also adding SAMPLE_FTRACE_MULTI_DIRECT to enable build of
> > direct multi interface sample modules. It's used in Makefile,
> > but not defined at the moment.
> > 
> > Same as for ftrace-direct-multi.ko, the new module is enabled
> > only for x86_64, so there's no need to ifdef the inlined assembly.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  samples/Kconfig                             |   8 ++
> >  samples/ftrace/Makefile                     |   1 +
> >  samples/ftrace/ftrace-direct-multi-modify.c | 105 ++++++++++++++++++++
> >  3 files changed, 114 insertions(+)
> >  create mode 100644 samples/ftrace/ftrace-direct-multi-modify.c
> 
> I think your series is based on something before 5.16-rc2?
> 
> Because there are:
> 503e45108451 ("ftrace/samples: add missing Kconfig option for ftrace direct multi sample")
> 890e3dc8bb6e ("ftrace/samples: add s390 support for ftrace direct multi sample")
> 
> Which would conflict with your patches.

ah so we have some of the changes already.. I'll pick it up,
rebase and resend

thanks,
jirka

