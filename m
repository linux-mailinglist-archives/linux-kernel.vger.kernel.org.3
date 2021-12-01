Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BFB465862
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 22:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242427AbhLAVgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 16:36:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30217 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243044AbhLAVfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 16:35:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638394332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hR6RJijQLokVgEFjxEQ3aZXqHZ0XjZRBbla2kzv4Thk=;
        b=Q7NIGEPW0F72j0SwEJOdb1Qt/S1DymD7kkzXdnzhL5phG50BLcF9hNVtknDyjhwEgEEEXR
        LFA2svYI1SEbre3l/SslFqxr+AI3acJucbwYszXJzBADYfAl95/3qHqdQm/1ygpd7D4TW2
        IMw5HYSXpgRAIjpbAH7hJrqiIHGB2Zo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-chOZCEi1Ofay3v9T6bms7g-1; Wed, 01 Dec 2021 16:32:11 -0500
X-MC-Unique: chOZCEi1Ofay3v9T6bms7g-1
Received: by mail-wm1-f71.google.com with SMTP id a85-20020a1c7f58000000b0033ddc0eacc8so491290wmd.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 13:32:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hR6RJijQLokVgEFjxEQ3aZXqHZ0XjZRBbla2kzv4Thk=;
        b=D7BDVp/ahZ3ULI23nQ6FePj0wojdH5egXKhdnI/q1GedyEUJaXLs7qoy6afbOpUphs
         vSdWbylV3W3oRWF5HHoITFUz+mNIjq+7W2dLxv1w7TWdXRLYVNSTqjdk9/B5xlKLk8+A
         Hi5XwWV7WolnjTsz8E++Q4Y7yLktCwD8jJDjDEVQXvNqDiesb3tB/Vu0Ppq5XbCPhlIH
         276hmhX8JYQgTEaiGE2XVBDEkZneTTJx+ABL299oEobriLPYaTINn4mjDlPt6Bb3GvOx
         vLsYv0S8CkCCROE3n5X2l37576WPsZBqwv0tPhVXLuK3NTX/ZFmra9G/D5jVUr5A9MOv
         31hw==
X-Gm-Message-State: AOAM532GWToSyesupIzcxR7hrxUHkjsJAzAisqdQZqqfdhTCSQF7NUF9
        CPYpYGAVvvIctgp7rdzKdpnZtHEII2QGRiGoQjh01KjZg5AtA1Z+D4lPZcwjzhlwPCfl9ly384V
        Ckt0SuhujPjYQnjJDi5ExpLjf
X-Received: by 2002:a1c:f609:: with SMTP id w9mr940924wmc.99.1638394330242;
        Wed, 01 Dec 2021 13:32:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxvrBWJq3xbgO7QxKasHxqpVsb5CuMxjPF1wwnEESDuqXVu0+WHF/7Xi7WN0Vve1QSXptdQ3Q==
X-Received: by 2002:a1c:f609:: with SMTP id w9mr940885wmc.99.1638394330001;
        Wed, 01 Dec 2021 13:32:10 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id y6sm879328wrh.18.2021.12.01.13.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 13:32:09 -0800 (PST)
Date:   Wed, 1 Dec 2021 22:32:07 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH 1/8] perf/kprobe: Add support to create multiple probes
Message-ID: <Yafp193RdskXofbH@krava>
References: <20211124084119.260239-1-jolsa@kernel.org>
 <20211124084119.260239-2-jolsa@kernel.org>
 <CAEf4Bzb5wyW=62fr-BzQsuFL+mt5s=+jGcdxKwZK0+AW18uD_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzb5wyW=62fr-BzQsuFL+mt5s=+jGcdxKwZK0+AW18uD_Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 10:53:58PM -0800, Andrii Nakryiko wrote:
> On Wed, Nov 24, 2021 at 12:41 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > Adding support to create multiple probes within single perf event.
> > This way we can associate single bpf program with multiple kprobes,
> > because bpf program gets associated with the perf event.
> >
> > The perf_event_attr is not extended, current fields for kprobe
> > attachment are used for multi attachment.
> 
> I'm a bit concerned with complicating perf_event_attr further to
> support this multi-attach. For BPF, at least, we now have
> bpf_perf_link and corresponding BPF_LINK_CREATE command in bpf()
> syscall which allows much simpler and cleaner API to do this. Libbpf
> will actually pick bpf_link-based attachment if kernel supports it. I
> think we should better do bpf_link-based approach from the get go.
> 
> Another thing I'd like you to keep in mind and think about is BPF
> cookie. Currently kprobe/uprobe/tracepoint allow to associate
> arbitrary user-provided u64 value which will be accessible from BPF
> program with bpf_get_attach_cookie(). With multi-attach kprobes this
> because extremely crucial feature to support, otherwise it's both
> expensive, inconvenient and complicated to be able to distinguish
> between different instances of the same multi-attach kprobe
> invocation. So with that, what would be the interface to specify these
> BPF cookies for this multi-attach kprobe, if we are going through
> perf_event_attr. Probably picking yet another unused field and
> union-izing it with a pointer. It will work, but makes the interface
> even more overloaded. While for LINK_CREATE we can just add another
> pointer to a u64[] with the same size as number of kfunc names and
> offsets.

I'm not sure we could bypass perf event easily.. perhaps introduce
BPF_PROG_TYPE_RAW_KPROBE as we did for tracepoints or just new
type for multi kprobe attachment like BPF_PROG_TYPE_MULTI_KPROBE
that might be that way we'd have full control over the API

> 
> But other than that, I'm super happy that you are working on these
> complicated multi-attach capabilities! It would be great to benchmark
> one-by-one attachment vs multi-attach to the same set of kprobes once
> you arrive at the final implementation.

I have the change for bpftrace to use this and even though there's
some speed up, it's not as substantial as for trampolines

looks like we 'only' got rid of the multiple perf syscall overheads,
compared to rcu syncs timeouts like we eliminated for trampolines 

I'll make full benchmarks once we have some final solution

jirka

