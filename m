Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3D947A08D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 14:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbhLSNEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 08:04:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235685AbhLSNEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 08:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639919090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eXmHN81vfmm8jQ+V+OC16FdNhEz31y0+JZmjNOAeaus=;
        b=MUkWoDBbFbhi5nYtdQYTEWsHMkFYsYQgVJrLbMr6lWZek2Q5oa2Ky9bSmCR4Fw/P+NUWBr
        RzEk/ksyozt8os6KXEW5toKOCe8SqXYtTncx3weevC3BKN8sVXe0FwL3VhB222OQDbg8J1
        TofO7vi66lhQPpsu4e+0EuiAZI8al/k=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-I5kLTkpXPma0sO3Lf6W_oQ-1; Sun, 19 Dec 2021 08:04:49 -0500
X-MC-Unique: I5kLTkpXPma0sO3Lf6W_oQ-1
Received: by mail-ed1-f70.google.com with SMTP id t1-20020a056402524100b003f8500f6e35so504790edd.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 05:04:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eXmHN81vfmm8jQ+V+OC16FdNhEz31y0+JZmjNOAeaus=;
        b=hTAPNrWTrPIqWw/pShfU+CUzSbMAMw1dBAukbPUPcmJheeGC0jWBAd3qMf/LySa931
         H2plQnKxaTOnK/K5pKRF0T5l9oCPaj/X2xPRnKkanokw94Ar6jatUu9764sq1Mz5SnAK
         Q6h2e3HJXFG4xlMLv8NllNyxGD3Aqm10jAsCsEvos+ytvR2SvIbtK7ys6ZQYVEkcsDpJ
         s0nOwD0yztiwSwLsFmGaLaL54w35jA1dX7O1IEdjOM9PbYlszqsYjOtKbobesN2NNmLg
         b4+l6I4CuhCpIDy7M+pF+g8fl4ZfDmWkHUtakGE0OobI1QZ3hZ/R1GcyZusSczay8yPr
         6yUQ==
X-Gm-Message-State: AOAM531EJl3WiP4GTU+6ttMMw6ycKEqB64uaXhF6NAIUNRC7x9v8q87d
        c3vKJ7YnVuzyGEfVQEmJZ3EK9iDZC8HsMLjKgn/HcMj9qczMRcgCQW9c2izA6VSbVbBy4EBK5Bj
        I6XV78C1/OH3UxJMQVSPoudjQ
X-Received: by 2002:a05:6402:849:: with SMTP id b9mr11128659edz.373.1639919088100;
        Sun, 19 Dec 2021 05:04:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwuMSvCz6jgAqcDfr8JZ5Redg8BT9D2bwd830D7+OFEPcqMx3S2r88Rr14WTIghJYYLW8PS6g==
X-Received: by 2002:a05:6402:849:: with SMTP id b9mr11128643edz.373.1639919087909;
        Sun, 19 Dec 2021 05:04:47 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id dm7sm1422567edb.7.2021.12.19.05.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 05:04:47 -0800 (PST)
Date:   Sun, 19 Dec 2021 14:04:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Frank Ch. Eigler" <fche@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [RFC] perf record: Disable debuginfod by default
Message-ID: <Yb8t7R577H3DiJGz@krava>
References: <20211209200425.303561-1-jolsa@kernel.org>
 <CAM9d7cjyN_sxMe9yajgnuDRy5234NZQ5sd0e4ynBmCnQSv=WFQ@mail.gmail.com>
 <YbNGxMAu5LYvqtpq@krava>
 <20211210165010.GA30236@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210165010.GA30236@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 11:50:10AM -0500, Frank Ch. Eigler wrote:
> Hi -
> 
> On Fri, Dec 10, 2021 at 01:23:32PM +0100, Jiri Olsa wrote:
> > [...]
> > at the end of the perf record we populate buildid cache
> > with profiled binaries for the current perf.data
> > 
> > **IF** there's DEBUGINFOD_URLS defined, that code will
> > also ask debuginfod for binaries it could not find on
> > the system
> 
> Consider doing this only at the end of the run, and in the background,
> just as a prefetch for the perf report step?  The main downside there
> could be if one runs many perf record jobs in close proximity,
> overlapping larger prefetch download tasks.  That might waste some
> network traffic.

right, IMO it's too much for default behaviour but I think could
do this under new (config) option, if there's a need for that

thanks,
jirka

