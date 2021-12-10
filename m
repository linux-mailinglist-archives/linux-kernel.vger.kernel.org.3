Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19D3470658
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244023AbhLJQx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:53:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41416 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233753AbhLJQxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:53:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639155017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JOYJ/utoBMVaS9HCfRFEQqBbZe9TQqR0k0Gsd0aUb4o=;
        b=OT9xhKdF9Cqo9VhLs/JJg4u9SFSUr+oJRPVtNf1/qqReECw0r6xaZyIW7nfeVdDFXM5/KK
        6lvgjL4YizWrJS22isXgzHBZZn7lVl21e5p1mgUUmeSL9m1XyU0hooWnd3PweFFEtbTDFH
        lg/LJO7ud8iOMKKqv4wvpJf81CPfeCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-XoRgWfLXO7qfWOWiInyj1w-1; Fri, 10 Dec 2021 11:50:14 -0500
X-MC-Unique: XoRgWfLXO7qfWOWiInyj1w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 964BD593AE;
        Fri, 10 Dec 2021 16:50:12 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 642095D6D7;
        Fri, 10 Dec 2021 16:50:12 +0000 (UTC)
Received: from fche by redhat.com with local (Exim 4.94.2)
        (envelope-from <fche@redhat.com>)
        id 1mvj62-0008Hz-GG; Fri, 10 Dec 2021 11:50:10 -0500
Date:   Fri, 10 Dec 2021 11:50:10 -0500
From:   "Frank Ch. Eigler" <fche@redhat.com>
To:     Jiri Olsa <jolsa@redhat.com>
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
Message-ID: <20211210165010.GA30236@redhat.com>
References: <20211209200425.303561-1-jolsa@kernel.org>
 <CAM9d7cjyN_sxMe9yajgnuDRy5234NZQ5sd0e4ynBmCnQSv=WFQ@mail.gmail.com>
 <YbNGxMAu5LYvqtpq@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbNGxMAu5LYvqtpq@krava>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

On Fri, Dec 10, 2021 at 01:23:32PM +0100, Jiri Olsa wrote:
> [...]
> at the end of the perf record we populate buildid cache
> with profiled binaries for the current perf.data
> 
> **IF** there's DEBUGINFOD_URLS defined, that code will
> also ask debuginfod for binaries it could not find on
> the system

Consider doing this only at the end of the run, and in the background,
just as a prefetch for the perf report step?  The main downside there
could be if one runs many perf record jobs in close proximity,
overlapping larger prefetch download tasks.  That might waste some
network traffic.

- FChE

