Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EFF4985D7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244065AbiAXRGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbiAXRGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:06:43 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7E3C061747
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 09:06:42 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e8so13055500wrc.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 09:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=79KUbqnFovl8PcuSxk5IjbyVvI/kpEfdZ145RDlSlls=;
        b=XOmRM7d4TxVHfidejk880wpDt1/UvvgXdK/3jt//AlEZ8kOXfrXW1uVSNTFFKjxZCA
         C2v+s0laubCp0T/F2M1KhNHDAYPIa4oBnG55wyVmMV91QFcO2Kvf9PF4yR/yN9sKvHrG
         1DP/JkOPxMskk+4yyoIwqt7wFijpIo+tc7w+jntiuan7oPn9tBYhUJaRq+NjoWluubQM
         7lrKcfZM7tScpOEw8pkj+ZftvDartnYHOihAu07vUTaPJqq8leoOfx+HR+5k7eyLmH7x
         os2+jbWBzU2oQlY3BJbC39rZcVWETEx88WL4wmsT+aCA8Gqw7i6vJJiBleewO9+3zyEf
         sv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=79KUbqnFovl8PcuSxk5IjbyVvI/kpEfdZ145RDlSlls=;
        b=2nmbC95gP44E+cZOZWB06BY/IR3Qhae+xfNdcYHZ2Qh7Tc8cg5DM+Hdr+IwNGpkHr8
         8rkhc30a+dmUaIDqNiI8cwROlZoXGniEzqJEml40KPxu7hd4J5ShNfIrQ+NHbV6Dqlqe
         TfBecU598lrHju3RT5Uzn8lzNO0nlWsXj24heJl56nIj3bgsQkfJSOKXcTjzrSi9luhi
         1QRwK6LQ9YqfTz3aGn2/yR+THA07/TIROlPI03m8o0DrMkvBwGYS+bp/Gnzk0UxtCJLb
         kRXKfmWhVvgEDva42v4QOlY95eCQP5ZnKTf1chIjzPL02qOP5HJiyR/rd46EspPumQmk
         6pcQ==
X-Gm-Message-State: AOAM532amyRvkXseh9Cjb31DUkfwhYZOo1/Nr1NAQeMRJ5rGqJX0XnfL
        gZb7h86+/Bu7roUakWcREVwwCBeSnoSXjxaR7A8ZIg==
X-Google-Smtp-Source: ABdhPJyqVVxCcruvTsXSVTaMipUjCEqLhj13ZjMDqdYRuJ4h+DRF+V96pdHwRfAXJ0FslEzrwCgYkCbcQK7QYqme4MQ=
X-Received: by 2002:adf:ec8f:: with SMTP id z15mr14782424wrn.235.1643044001262;
 Mon, 24 Jan 2022 09:06:41 -0800 (PST)
MIME-Version: 1.0
References: <20220120155517.066795336@infradead.org> <20220120160822.914418096@infradead.org>
 <20220121114758.GF20638@worktop.programming.kicks-ass.net>
 <20220121151845.GB22849@worktop.programming.kicks-ass.net>
 <Ye635PiRpv4rXVl0@hirez.programming.kicks-ass.net> <Ye7XU666240YyRBH@hirez.programming.kicks-ass.net>
In-Reply-To: <Ye7XU666240YyRBH@hirez.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@google.com>
Date:   Mon, 24 Jan 2022 09:06:29 -0800
Message-ID: <CAPNVh5ftS=3+ip0Di=tT4Os+602Dwc4s3bbeim91nFh5iF+Vdg@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 5/5] sched: User Mode Concurency Groups
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca, mark.rutland@arm.com, posk@posk.io
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 8:44 AM Peter Zijlstra <peterz@infradead.org> wrote:

[...]
> >
> > Oh how I hate signals... this can get scribbled by a syscall/fault from
> > sigcontext :/
> >
> > Maybe I can recover the timo argument from the original syscall
> > pt_regs.. let me try.

I don't think we need to do anything special with timeouts if a signal
happens - just normally return -EINTR (after a resume from a server)
and let the userspace figure things out.

Alternatively, in my version of the patchset UMCG tasks ignore
non-fatal signals. :)

[...]
