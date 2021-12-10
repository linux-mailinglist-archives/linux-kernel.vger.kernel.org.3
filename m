Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49461470095
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 13:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240937AbhLJM1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 07:27:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26975 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237629AbhLJM1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 07:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639139017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KioUMvWRyu6MZM3/L8Y/jHqD4lh7+63A4Z1HNFMR0vs=;
        b=ZyIse436iYxUfu9pcmMFojUfgCR6exzMGUBs81GPP9khsfGQija1gYI6sxxDz2cpQoWnu5
        mz2fqMzHrmX2eQnIrN+d+FSC1/xbl7c3OE2QdB1TNhRaktzgCCW6BjwnBgBeCyL4mgITtH
        QJQQOTWnjs7Ogwxm1bA6+zlIlrsgxQ8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-Ze0m8L11OsqzmBj-jNW2qA-1; Fri, 10 Dec 2021 07:23:35 -0500
X-MC-Unique: Ze0m8L11OsqzmBj-jNW2qA-1
Received: by mail-wr1-f70.google.com with SMTP id q5-20020a5d5745000000b00178abb72486so2212997wrw.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 04:23:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KioUMvWRyu6MZM3/L8Y/jHqD4lh7+63A4Z1HNFMR0vs=;
        b=dI+yK0rXoU9XNSC58jzqhprLPMkxB8bks9Bd15svJSY0+WX/Rizt4o9WMHnfVLePVW
         m8/05YHYOiLXlONYE95bLZsbqzC1xV0k7VIIeFRvK4oJHAukVqiN4tx+Zgwa+1lBd1Ax
         cweyme0tiYsP/mQqECY5A0YoFIKSUYjhPT+o2cHvvymdxH7xSgxyjLTS18WFSN2eSUPH
         x1LypXoinUSIOOJMqqbx4RpMCne6WthHRcJx+IYsWQndlybRq9loMRkl9HdZVNvDiEpQ
         8JqJBYYgopjwoddsY6q1N1eu1A5LzNgY4CbDAVktDl8RarF7mbfLtumRNpwmyV0x4UPG
         tR8g==
X-Gm-Message-State: AOAM532GvlWO8T3DMZLlrlPANbukFo7F/CVTGf9c9dEPX5ECyV/QDZer
        tpYdMVV8hXlED4eLZhkKkyPlqEjVU7svzembiQI0pkqvK+zW8dRBT3/ycIghhAregnmTDuHnsMi
        S02Bd1uNdEYPuYPjNESkmTPbB
X-Received: by 2002:adf:f352:: with SMTP id e18mr13953160wrp.39.1639139014736;
        Fri, 10 Dec 2021 04:23:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZdAIQO1BeoJ43lLB5AhJ1t+/ESbqQBresHP3hRbQSRzO+zkD1RIkj4eHCsDEjipAo3EGUGA==
X-Received: by 2002:adf:f352:: with SMTP id e18mr13953136wrp.39.1639139014568;
        Fri, 10 Dec 2021 04:23:34 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id l5sm3298402wrs.59.2021.12.10.04.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 04:23:34 -0800 (PST)
Date:   Fri, 10 Dec 2021 13:23:32 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [RFC] perf record: Disable debuginfod by default
Message-ID: <YbNGxMAu5LYvqtpq@krava>
References: <20211209200425.303561-1-jolsa@kernel.org>
 <CAM9d7cjyN_sxMe9yajgnuDRy5234NZQ5sd0e4ynBmCnQSv=WFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjyN_sxMe9yajgnuDRy5234NZQ5sd0e4ynBmCnQSv=WFQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 03:39:20PM -0800, Namhyung Kim wrote:
> Hi Jiri,
> 
> On Thu, Dec 9, 2021 at 12:04 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > hi,
> > after migrating to fedora 35 I found perf record hanging on exit
> > and it's because fedora 35 sets DEBUGINFOD_URLS that triggers
> > debuginfod query which might take long time to process.
> >
> > I discussed this briefly with Frank and I'm sending the change
> > to disable debuginfod by default in perf record.
> >
> > Frank had other idea we could discuss here to fork or just spawn
> > "/usr/bin/debuginfod-find ...." into background after perf record.
> >
> > Perhaps there are other ways as well, hence this is RFC ;-)
> 
> I thought the debuginfod was for perf report, not record.
> Maybe I'm missing something but how about moving it to
> report?  We can talk to debuginfod after checking the local
> build-id cache and binary on the system.

at the end of the perf record we populate buildid cache
with profiled binaries for the current perf.data

**IF** there's DEBUGINFOD_URLS defined, that code will
also ask debuginfod for binaries it could not find on
the system

> 
> Still, we can have perf buildid-cache to move it from the
> debuginfod to local cache.

yep, we have that already

jirka

