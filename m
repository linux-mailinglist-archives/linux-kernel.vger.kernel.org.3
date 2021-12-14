Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8391E47397D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 01:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244445AbhLNAWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 19:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242786AbhLNAWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:22:31 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9E3C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 16:22:31 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id 14so21094036ioe.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 16:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xdDuB1YG6XTXDhWwkGkmln0E+/N5BEU+BrEQQgdpPmY=;
        b=gwhbkJpHH5rTNp0Z6uxU5d66XAXmNYxGmy0drFgtfDh+geMk3+7EMaZf7sCjgI/5dp
         WUIYDPOrkylCGZ0bu9Bmvw9tzrpkcO2HpVPhI6E+WKqfjWQhw05snOM3fHY6lwHZrPoM
         oVsLRQuiea1Cw8ul/DTzFiVBFASI9arLmfmM5b28xIih0qSGDPqEHxI6tViuxe7/Fk17
         Hd++hOSc1UsKmzQsFdOjfiu458/cgzOqhBOURC2RSjG1my9MG077fkZAmEVWI7bpDeMZ
         Pwt8rSyuBUNWIAc0M4jGSRXGHzos9DXq+C1Vni+0z8ZOGAnnzrhS8c+Wtv001oejjzJX
         BSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xdDuB1YG6XTXDhWwkGkmln0E+/N5BEU+BrEQQgdpPmY=;
        b=H0JPEBy1CbqFvr4xX/bEZwARa6fNbTXKQJudhnK/1vgG9sLrC4sjCpFRRA44ugnAr1
         IvYACgSAhFl/L7HUJqBZwBZIJ1+DskV3cDVlJxaz77Yj7j8/efIH0AMia1sokG+6dnP5
         qAk4pnoSYyZdFTNRHvx6zgTAGACNsKG8gH7s6HHncSb54kN/DfS41V53nDLD2gmdpKNU
         hPEAJfs2wOM8BQkBq+3J14AcIyKGrosMuhjI+ShysSEcAi3I2SsvYuy25lLP7TmGT8na
         Y7ppvMRNAyJQ0/VGlcrPqD7vOQBQlDCVwD1N7d96+gzDlz/FlFf6H9fDlTpSf/Li2+C+
         UBSA==
X-Gm-Message-State: AOAM533TgNsByf2wj7lyy2bx/wsoF3Ti1qijbugc3WKr7wSTk2WGjRaf
        HK3NcbKPD31QnXni8yHJj0NlfxuZzJnA9ylPDoYQEQ==
X-Google-Smtp-Source: ABdhPJyCHKaf9UKVoATEck3LTMSSftVTZ/0PQGYg+50WAy0eM15osVpyM19KBCZdRXcUqPPpyYL26Oca5akvBsAqT/w=
X-Received: by 2002:a6b:ea0a:: with SMTP id m10mr1382455ioc.91.1639441350311;
 Mon, 13 Dec 2021 16:22:30 -0800 (PST)
MIME-Version: 1.0
References: <20211123000102.4052105-1-almasrymina@google.com> <YaMBGQGNLqPd6D6f@casper.infradead.org>
In-Reply-To: <YaMBGQGNLqPd6D6f@casper.infradead.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 13 Dec 2021 16:22:19 -0800
Message-ID: <CAHS8izM5as_AmN4bSmZd1P7aSXZ86VAfXgyooZivyf7-E5gZcQ@mail.gmail.com>
Subject: Re: [PATCH v7] mm: Add PM_THP_MAPPED to /proc/pid/pagemap
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 8:10 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Nov 22, 2021 at 04:01:02PM -0800, Mina Almasry wrote:
> > Add PM_THP_MAPPED MAPPING to allow userspace to detect whether a given virt
> > address is currently mapped by a transparent huge page or not.  Example
> > use case is a process requesting THPs from the kernel (via a huge tmpfs
> > mount for example), for a performance critical region of memory.  The
> > userspace may want to query whether the kernel is actually backing this
> > memory by hugepages or not.
>
> But what is userspace going to _do_ differently if the kernel hasn't
> backed the memory with huge pages?

Sorry for the late reply here.

My plan is to expose this information as metrics right now and:
1. Understand the kind of hugepage backing we're actually getting if any.
2. If there are drops in hugepage backing we can investigate the
cause, whether it's due to normal memory fragmentation or some
bug/issue.
3. Schedule machines for reboots to defragment the memory if the
hugepage backing is too low.
4. Possibly motivate future work to improve hugepage backing if our
numbers are too low.
