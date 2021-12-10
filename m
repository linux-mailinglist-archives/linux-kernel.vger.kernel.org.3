Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92094701B1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 14:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241869AbhLJNh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhLJNh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:37:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D3EC061746;
        Fri, 10 Dec 2021 05:33:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E753BB82803;
        Fri, 10 Dec 2021 13:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DED6C341C8;
        Fri, 10 Dec 2021 13:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639143230;
        bh=uB6Jj9dxJpPC/J9UHECaOsrSSLTxFGGtQTNDbAV223w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ssgMAvnsyt6HuREzMNi9cWFCr1gfL8gn+XhiXT/z8WG6JB3Gby6vUVuQ1sQm1StHQ
         ci9v/Elq4YcOQ59OkUtJXopU9DzxJx+0Kj6S1KupTyDXB73ZS3FGBD4BetKtDUIOo4
         9l+V6KKIcDUrlBCYFVkDZGPuEoDdGrJQHiAOxATm/S2IfynjUXFTkV3EkZygehxDh9
         OfsoCFivtR1bbL1sXgXMz+6WXd66m8QGtpzzgIHhYrHShDBre4aqZXIyFLRheqMIkk
         tfUXby2ZhLjE/Ivhi8ijQ11JRExdiI3KZUB2lknq2T3dhu0Yy+X/R0QkS18roC1W1n
         aZA0IfH/wR2hQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8E3AB405D8; Fri, 10 Dec 2021 10:33:48 -0300 (-03)
Date:   Fri, 10 Dec 2021 10:33:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [RFC] perf record: Disable debuginfod by default
Message-ID: <YbNXPDVhplHIgayp@kernel.org>
References: <20211209200425.303561-1-jolsa@kernel.org>
 <20211210080425.GO16608@worktop.programming.kicks-ass.net>
 <YbNHCLi/OdMUfgI0@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbNHCLi/OdMUfgI0@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 10, 2021 at 01:24:40PM +0100, Jiri Olsa escreveu:
> On Fri, Dec 10, 2021 at 09:04:25AM +0100, Peter Zijlstra wrote:
> > On Thu, Dec 09, 2021 at 09:04:25PM +0100, Jiri Olsa wrote:
> > > Adding single perf_debuginfod_setup function and using
> > > it also in perf buildid-cache command.

> > I'm still running with --no-buildid --no-buildid-cache or something like
> > that by default. As long as that remains working I'm good.

> you're good ;-) that will bypass the problem completely

And these days buildids come in PERF_RECORD_MMAP records when possible
(kernel new enough), so no extra step at the end for traversing
PERF_RECORD_MMAP records, read the DSO, find the build id, etc:

$ git log --pretty=fuller -1 --author=jolsa kernel/events/
commit 88a16a1309333e43d328621ece3e9fa37027e8eb
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu Jan 14 14:40:44 2021 +0100
Commit:     Alexei Starovoitov <ast@kernel.org>
CommitDate: Thu Jan 14 19:29:58 2021 -0800

    perf: Add build id data in mmap2 event

    Adding support to carry build id data in mmap2 event.

    The build id data replaces maj/min/ino/ino_generation
    fields, which are also used to identify map's binary,
    so it's ok to replace them with build id data:

      union {
              struct {
                      u32       maj;
                      u32       min;
                      u64       ino;
                      u64       ino_generation;
              };
              struct {
                      u8        build_id_size;
                      u8        __reserved_1;
                      u16       __reserved_2;
                      u8        build_id[20];
              };
      };

    Replaced maj/min/ino/ino_generation fields give us size
    of 24 bytes. We use 20 bytes for build id data, 1 byte
    for size and rest is unused.

    There's new misc bit for mmap2 to signal there's build
    id data in it:

      #define PERF_RECORD_MISC_MMAP_BUILD_ID   (1 << 14)

    Signed-off-by: Jiri Olsa <jolsa@kernel.org>
    Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Link: https://lore.kernel.org/bpf/20210114134044.1418404-4-jolsa@kernel.org
$

- Arnaldo
