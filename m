Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F157C495D20
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379803AbiAUJ5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349787AbiAUJ5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:57:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DD3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 01:57:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8142DB81F86
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 09:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1095EC340E1;
        Fri, 21 Jan 2022 09:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642759020;
        bh=qR8VRYTCz1DGsP6TG4tf/9SSEqtJu9KSNoIFjCNdds4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VVQqOz9uMKa1SiorJ1jdHxE/y7sxPOPEm3xQTwwIF4pQMa8Z06Koa1fgjHD6ibvJO
         KpIi0ShE7YobgQo2mgLZdB/p/QguJP2oRrB9C6ZPVVYSxL85FctCWxzh6BnmVeVW3L
         mWicYzvXD+ChznQenltM/g0HDZ00Rfyovc9Zssd6G3CRJt2HRusynZJWwqP2dgI2hM
         CQFrVB4zotfL8X13KvEVfrOgRx0BRnl8YoVdHUEwT5GOrv10Oq8QxkDDgGU64iZZDC
         Inpu17W0k3lCYuVq+eqgaNWAoEzkVZj28aiicMRvvyzusY4EBximpqMDQEqbYyD9OS
         Y5YPrPCdU7itg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3664640C99; Thu, 20 Jan 2022 12:47:27 -0300 (-03)
Date:   Thu, 20 Jan 2022 12:47:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Eric Lin <eric.lin@sifive.com>
Cc:     Eduardo Habkost <ehabkost@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yao Jin <yao.jin@linux.intel.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: Re: About perf tool set exclude_guest = 1 on guest environment
Message-ID: <YemED+3SzJQR+tZq@kernel.org>
References: <CAPqJEFoUyHiyNj8Hx-wRaw86NLb5hGo-WT4ysqV4RGerYyDyJA@mail.gmail.com>
 <CAM9d7chL4_hY8BLHV=q2J_HJ14gUj07t5QvUvUBOj+4hmvY7hQ@mail.gmail.com>
 <CAPqJEFqJpnq1TF-ZA7Worsy2Yx6au-KHBPkCN0cSnQuyGbwsfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPqJEFqJpnq1TF-ZA7Worsy2Yx6au-KHBPkCN0cSnQuyGbwsfw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 20, 2022 at 09:35:59PM +0800, Eric Lin escreveu:
> On Wed, Jan 19, 2022 at 1:02 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > On Mon, Jan 17, 2022 at 8:05 PM Eric Lin <eric.lin@sifive.com> wrote:
> > > Currently, I run the perf command 'perf record -e branches:u ls'  and
> > > 'perf record -e branches ls'. It will set exclude_guest = 1 as below:
> > >
> > > # perf record -e branches:u ls
> > > # perf evlist -v
> > > branches:u: .., exclude_kernel: 1, exclude_hv: 1,, exclude_guest: 1, ..
> > >
> > > # perf record -e branches ls
> > > # perf evlist -v
> > > branches: ..., exclude_guest: 1, ...
> > >
> > > As I understand it, set exclude_guest =1 will not include guest counting.
> > > May I ask if I run the above commands as a guest user, should the
> > > architecture implementation ignore this exclude_guest flags and still
> > > make perf can count guest events in Linux kernel?
> >
> > So do you want to run the command in the host?
> > Then you can use both 'H' and 'G' modifiers like
> >
> >   # perf record -e branches:HG ls
> >
> > or (for user-mode only)
> >
> >   # perf record -e branches:uHG ls
> >
> 
> Actually, I want to run the commands in the guest.
> But when I run the commands "perf record -e branches:u ls" and "perf
> record -e branches ls", it will set exclude_guet = 1.
> According to the documentation[1] exclude_guest definition, it should
> not count guest events.
> So, if I run these commands as a guest user can I get the profile data?
> 
> [1] https://man7.org/linux/man-pages/man2/perf_event_open.2.html

The tool shouldn't know that it is running in a guest, right?

And the kernel, running on a guest should exclude its guests if
attr.exclude_guest is set, not itself and its non-guest userland.

So, before delving into how the kernel running on guest _actually_
handles attr.exclude_guest=1 behaves, what are the results you are
getting from running perf on a guest?

Lemme see...

On a fedora:35 guest:

[root@fedora ~]# perf record ls
anaconda-ks.cfg  perf.data
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.014 MB perf.data (3 samples) ]
[root@fedora ~]# perf evlist -v
cpu-clock:pppH: type: 1, size: 128, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERIOD, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
[root@fedora ~]#

IIRC there is some extra magic to allow 'cycles' to be seen on the
guest, but apart from that it seems to work.

Eduardo, can you help us here?

- Arnaldo
