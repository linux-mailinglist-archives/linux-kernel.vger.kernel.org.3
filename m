Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B6B4715D5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 20:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhLKT5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 14:57:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43235 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231925AbhLKT5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 14:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639252626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2DFo9Dp28T64dYNt0j+jsMdK+yCDWDWA9qmn5tDJ3QQ=;
        b=i98u6uzxZdlt+Ay64eWj4XTIdsUdkEOTkdx7W3KtihGJ8sAlUHcEM4EQprUVnDLTdii63E
        Yk8uA88k30Bv8fKExpWBuhiHvzwoK3hrGYkxhmLpvQUSmSyehqYf+OiULNqIFBHcsH1/+8
        ASZ/ayxNgkmYaFTG9jgx0T4bsVSsYM4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-LEfwAlQ1MDacvp5FIsp0CQ-1; Sat, 11 Dec 2021 14:57:05 -0500
X-MC-Unique: LEfwAlQ1MDacvp5FIsp0CQ-1
Received: by mail-wm1-f70.google.com with SMTP id r129-20020a1c4487000000b00333629ed22dso8916639wma.6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 11:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2DFo9Dp28T64dYNt0j+jsMdK+yCDWDWA9qmn5tDJ3QQ=;
        b=KhLz3PfBYIGi1n9AbMYu+moyEjo2wXvBW+ZDL7Gv5+ENGOehHgXgygqmeZ/S2yQVZa
         h8CTcoQ3xTE3C9iqsiUWvi+8smQQ0LReZt6CXdBOD/m3ZmMyCdKJ/Whrf6Zo6iWKIABz
         DUb1UHNQgwuJPvJO9b9osuGyjeFffLL8oa1d58CFoPCEkpAwSGBW9nq0BJWAU+ZCESi+
         tMo3YMaseywgWToKGzgGQZEcLD/Eb7uDDI761Bx5tYlh713NHANMsyFP3u1eC8DSfX4v
         L8GrMt8m2/uCYsOjz+xcBAj+ofA/EuyPunqtnaJBWVpYFIjWYPj38te2GcxRGiRen01g
         aR3w==
X-Gm-Message-State: AOAM533ccEQdaLBLSJdlEiwJGtqKwdp2IoaOIdZCaKOq16/MeYDB6iKt
        GdDEJU5YIH25WrQnv1zYJcvaDgInitQX4vZEo3RM2HLgKdNymTdKtkvUlTNCxoahRDnpwpwRaPO
        aZjB01/JekOzWbhshABPqhf83
X-Received: by 2002:a7b:c770:: with SMTP id x16mr26571086wmk.66.1639252623861;
        Sat, 11 Dec 2021 11:57:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJydZc5cE76J6JywjIU7eqe3LfuKTKOpyovdO/qqcLgyrjjm5LowG3aJr3E764w27/gy6nztmg==
X-Received: by 2002:a7b:c770:: with SMTP id x16mr26571075wmk.66.1639252623706;
        Sat, 11 Dec 2021 11:57:03 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id w7sm5674611wru.51.2021.12.11.11.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 11:57:02 -0800 (PST)
Date:   Sat, 11 Dec 2021 20:57:00 +0100
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
Message-ID: <YbUCjKYiLBgnDqq8@krava>
References: <20211209200425.303561-1-jolsa@kernel.org>
 <CAM9d7cjyN_sxMe9yajgnuDRy5234NZQ5sd0e4ynBmCnQSv=WFQ@mail.gmail.com>
 <YbNGxMAu5LYvqtpq@krava>
 <CAM9d7cit-GKyDcVp435np7WSe_KW-+NYD7rHSC10EEoW1EpTSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cit-GKyDcVp435np7WSe_KW-+NYD7rHSC10EEoW1EpTSA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 10:41:49AM -0800, Namhyung Kim wrote:
> On Fri, Dec 10, 2021 at 4:23 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Thu, Dec 09, 2021 at 03:39:20PM -0800, Namhyung Kim wrote:
> > > Hi Jiri,
> > >
> > > On Thu, Dec 9, 2021 at 12:04 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > > >
> > > > hi,
> > > > after migrating to fedora 35 I found perf record hanging on exit
> > > > and it's because fedora 35 sets DEBUGINFOD_URLS that triggers
> > > > debuginfod query which might take long time to process.
> > > >
> > > > I discussed this briefly with Frank and I'm sending the change
> > > > to disable debuginfod by default in perf record.
> > > >
> > > > Frank had other idea we could discuss here to fork or just spawn
> > > > "/usr/bin/debuginfod-find ...." into background after perf record.
> > > >
> > > > Perhaps there are other ways as well, hence this is RFC ;-)
> > >
> > > I thought the debuginfod was for perf report, not record.
> > > Maybe I'm missing something but how about moving it to
> > > report?  We can talk to debuginfod after checking the local
> > > build-id cache and binary on the system.
> >
> > at the end of the perf record we populate buildid cache
> > with profiled binaries for the current perf.data
> >
> > **IF** there's DEBUGINFOD_URLS defined, that code will
> > also ask debuginfod for binaries it could not find on
> > the system
> 
> Yeah, I know what you're doing.  But I guess debuginfod
> contains binaries for the distro and they'd be available for
> a while.  Then I think we don't need to do it at perf record.

well there's also profiling of non system binaries, which you want
to cache, because you might want to check that profile later

so I think we should still do that in perf record, just to have
some control over debuginfod, which is executed as part of
build_id_cache__find_debug function

jirka

