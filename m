Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB98486DAE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245467AbiAFXYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbiAFXYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:24:20 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2478BC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 15:24:20 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id i8so3888020pgt.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 15:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OGz+KTMNaQJ31AH4jyNlIzitAxhmTUfwOup337ea6Eo=;
        b=cAYrjwHAhyUVWaSD9ze5qUSKTz4/MkkKhrEflwSvkyFNCwjtpW7o0tLw31wwBiX3tX
         SogtFxbF2pTg0GBKeGTlXNeTGeUcMspymNRNsU76qtDDCQ0BXkBXMT3cmSYEtLQ3qTiy
         7pnfu+cwPEQFtV09x+YgZKTB2CJCOITfsDzHVCihk4ACGYsi5wOBzXPLpm+njs8vf6F1
         rs2RO/Dy6gQ6IenOQi4NxJ4Jxg8/gI4JdLaayBrwMlv7WHujmhMZwrC4aNvyfMN5aDBg
         czHxH13bEXod7OqxL3RnzRoZ6aOSR87zjMyelxXQxnyqxOBxjuQSKvpDMxGZxfXqPzNU
         9m5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OGz+KTMNaQJ31AH4jyNlIzitAxhmTUfwOup337ea6Eo=;
        b=32galVn7k731EXzx/9D24bmeGOTDIxeHpxrddusZFxPCG3Zk0LGabtQe/O0nZuBPgY
         1zTJEZDyOlWeO8BjcKsbjVJNF8oY88ujaAt2JB34+5WCOYPVY4m8SEHQgRy2AzPx4VYU
         sgNGOwgyE5OdUHvGRrW6DK+AkF3xhComwYiqaMRwFucdZblg+rY1iBWgc6GO2v81SrC5
         SpwIAyo/0Ca38UnWgFnE2OVPxq60t2qQDHuaHogZLiwJgPsp/d4b2sNLvSXJxDCV70dj
         yMscW3ico0UAT9jp4rkhg4Eh9j18nG8AOt6q20rd0z0ULMfKb47GVZbcXRX+X9oHRtF2
         qLXQ==
X-Gm-Message-State: AOAM5307SkyzzbXkymgkzTk6KZbt86T5So1AegcOYo4wvhXtTasCZ9Vp
        f/cDAJWOBV/vymoNXaF+W90=
X-Google-Smtp-Source: ABdhPJxD9O0dnp9kdv3hMwibX0/0xyQlA+s7c/q46/kx9Na07Z83MCqm5ccvoAWFGThBRtuRgjlnow==
X-Received: by 2002:a63:4554:: with SMTP id u20mr54315435pgk.463.1641511459629;
        Thu, 06 Jan 2022 15:24:19 -0800 (PST)
Received: from google.com ([2620:15c:211:201:e32:b92d:27fe:aa55])
        by smtp.gmail.com with ESMTPSA id nu14sm3784167pjb.17.2022.01.06.15.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 15:24:19 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 6 Jan 2022 15:24:17 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>, huww98@outlook.com
Subject: Re: [RFC v2] mm: introduce page pin owner
Message-ID: <Ydd6IRTxI5RU/Sp1@google.com>
References: <20211228175904.3739751-1-minchan@kernel.org>
 <978452be-6377-69e3-4720-520410d32b31@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <978452be-6377-69e3-4720-520410d32b31@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 02:27:48PM -0800, John Hubbard wrote:
> On 12/28/21 09:59, Minchan Kim wrote:
> > A Contiguous Memory Allocator(CMA) allocation can fail if any page
> > within the requested range has an elevated refcount(a pinned page).
> > 
> > Debugging such failures is difficult, because the struct pages only
> > show a combined refcount, and do not show the callstacks or
> > backtraces of the code that acquired each refcount. So the source
> > of the page pins remains a mystery, at the time of CMA failure.
> > 
> > In order to solve this without adding too much overhead, just do
> > nothing most of the time, which is pretty low overhead. However,
> > once a CMA failure occurs, then mark the page (this requires a
> > pointer's worth of space in struct page, but it uses page extensions
> > to get that), and start tracing the subsequent put_page() calls.
> > As the program finishes up, each page pin will be undone, and
> > traced with a backtrace. The programmer reads the trace output and
> > sees the list of all page pinning code paths.
> > 
> > This will consume an additional 8 bytes per 4KB page, or an
> > additional 0.2% of RAM. In addition to the storage space, it will
> > have some performance cost, due to increasing the size of struct
> > page so that it is greater than the cacheline size (or multiples
> > thereof) of popular (x86, ...) CPUs.
> > 
> > The idea can apply every user of migrate_pages as well as CMA to
> > know the reason why the page migration failed. To support it,
> > the implementation takes "enum migrate_reason" string as filter
> > of the tracepoint(see below).
> > 
> 
> Hi Minchan,
> 
> If this is ready to propose, then maybe it's time to remove the "RFC"
> qualification from the subject line, and re-post for final review.
> 
> And also when you do that, could you please specify which tree or commit
> this applies to? I wasn't able to figure that out this time.

Sorry for that. It was based on next-20211224.

> 
> > Usage)
> 
> This extensive "usage" section is probably helpful, but the commit
> log is certainly not the place for the "how to" documentation. Let's
> find an .rst file to stash it in, I think.

I wanted to get some review for implementation/interface/usage before
respin removing the RFC. Otherwise, the the documentation need to keep
update heavily. Based on your comment, I think you are almost agree
with as-is. Then, yeah, let me cook up the doc and repost it with
removing the RFC tag.

Thanks.
