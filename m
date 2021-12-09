Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223D946F797
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 00:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbhLIXnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 18:43:10 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:36506 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhLIXnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 18:43:07 -0500
Received: by mail-lf1-f43.google.com with SMTP id k37so15087590lfv.3;
        Thu, 09 Dec 2021 15:39:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R1sOw782ij7VT+oHmIJRrDqdq4cl5dydAg6hTJDnPW8=;
        b=wNwOW14ghCN0gKJh7NKJg4B8LWADf4ahHueRn2gdPqd9WH6JTz8/zfeGriJHm78cbX
         ZoCjbE0mmxhye+UKyQ/hAV5iU7PMVJbKxeUkX/Jzg94UykjDPk3yukgYEs0KEhiVjULu
         3+zMahgUObWFL5r4pIU1iN0+CWZiHjuZr+pWRuye/di8lqvuODHbsDuOxy0p/9Rw7ueC
         afkc79mgMBriDuIIOTaHRNfjWrSf/d8wn6Uc2poCWs3I8YEJZn0ergTNJa5Hds9CjkSg
         mcQmFxz/2ppfDoBwN/IHKEPM8l/DsymUMKrLCwJDup4sXR8TfzLb6oZtYy+BRz3zA7ib
         KSsw==
X-Gm-Message-State: AOAM533fnsfzZ79k3EzSWpWc8OhgpsLjTZbtMKnp+wRnWgYbEAv6LQHR
        a7kCS9oxS+7hEmMwWKqJ4ph7Bu7UQIwdofK1tdIYKp96
X-Google-Smtp-Source: ABdhPJwdyV40u3vYU6XnMrwwSDxehp6b2A7BvLtcZSa/cqBYJn2UVm9XZsRjmkM+BmnxSJZs1MOlAQY08QxCCeXFuHk=
X-Received: by 2002:a05:6512:b8c:: with SMTP id b12mr8847965lfv.99.1639093172216;
 Thu, 09 Dec 2021 15:39:32 -0800 (PST)
MIME-Version: 1.0
References: <20211209200425.303561-1-jolsa@kernel.org>
In-Reply-To: <20211209200425.303561-1-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 9 Dec 2021 15:39:20 -0800
Message-ID: <CAM9d7cjyN_sxMe9yajgnuDRy5234NZQ5sd0e4ynBmCnQSv=WFQ@mail.gmail.com>
Subject: Re: [RFC] perf record: Disable debuginfod by default
To:     Jiri Olsa <jolsa@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Thu, Dec 9, 2021 at 12:04 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> hi,
> after migrating to fedora 35 I found perf record hanging on exit
> and it's because fedora 35 sets DEBUGINFOD_URLS that triggers
> debuginfod query which might take long time to process.
>
> I discussed this briefly with Frank and I'm sending the change
> to disable debuginfod by default in perf record.
>
> Frank had other idea we could discuss here to fork or just spawn
> "/usr/bin/debuginfod-find ...." into background after perf record.
>
> Perhaps there are other ways as well, hence this is RFC ;-)

I thought the debuginfod was for perf report, not record.
Maybe I'm missing something but how about moving it to
report?  We can talk to debuginfod after checking the local
build-id cache and binary on the system.

Still, we can have perf buildid-cache to move it from the
debuginfod to local cache.

Thanks,
Namhyung
