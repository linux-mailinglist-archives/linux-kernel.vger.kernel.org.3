Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A12F54BA79
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 21:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbiFNTY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 15:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiFNTYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:24:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E9419022;
        Tue, 14 Jun 2022 12:24:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0530F60C6A;
        Tue, 14 Jun 2022 19:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398C2C3411B;
        Tue, 14 Jun 2022 19:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655234692;
        bh=xJD7b4c406YOoDqHxaDs+stVjMjykI9ulQJDvKWMsg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tRyeik4sjF52fNvPA5D5HHRlCVKK43zcbvEk/2B1HLylcxKCJtieNcESKMZv2QcCh
         2iuN3uGF+BxH/DOaaVhCbwYVWrHdLur2ZejlGWV+JZUa4VmTAa05FBEPJm23Gi004d
         U6OddF8uc6zWoFsyK0a0fl1Qi7u7K0vv8xxZnhi6JYJCRGSR0YPqrlsEY0BqpPckrI
         V4EWGcG/j1FkUXotrtY4IL/Cq8G7tGR09vWkftn52Ep4TW7CoaTyrWWeK/EvCEgJmY
         Zn8k6NtykxXPC36lTB5XFuOUtCoZ4w2QElfC8BLnEb4YAaLBz+Ie3qVOZbQ4QN2MUA
         kQZP5RMM2bu/Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DE9E54096F; Tue, 14 Jun 2022 16:24:49 -0300 (-03)
Date:   Tue, 14 Jun 2022 16:24:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Linux v5.19-rc1] tools/perf/a.out remains after make -C
 tools/perf clean
Message-ID: <YqjggY64PKfog0YW@kernel.org>
References: <20220607000851.39798-1-irogers@google.com>
 <CA+icZUWpSF6ge76JVp1qBC5QhC1AwNacs5Di=e1QSbAD+SVKUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUWpSF6ge76JVp1qBC5QhC1AwNacs5Di=e1QSbAD+SVKUA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 07, 2022 at 08:59:31PM +0200, Sedat Dilek escreveu:
> Hi,
> 
> I observed this some time ago - so this is not only Linux v5.19-rc1 related.
> 
> $ LC_ALL=C make -C tools/perf clean 2>&1 | tee ../make-log_perf-clean.txt
> make: Entering directory '/home/dileks/src/linux-kernel/git/tools/perf'
>  CLEAN   x86
>  CLEAN   libtraceevent
>  CLEAN   libapi
>  CLEAN   libbpf
>  CLEAN   libsubcmd
>  CLEAN   libperf
>  CLEAN   fixdep
>  CLEAN   feature-detect
>  CLEAN   python
>  CLEAN   bpf-skel
>  CLEAN   core-objs
>  CLEAN   core-progs
>  CLEAN   core-gen
>  CLEAN   Documentation
> make: Leaving directory '/home/dileks/src/linux-kernel/git/tools/perf'
> 
> $ git status -s
> M tools/perf/util/unwind-libunwind-local.c
> ?? tools/perf/a.out
> 
> $ rm -v tools/perf/a.out
> 'tools/perf/a.out' deleted
> 
> $ git checkout -- tools/perf/util/unwind-libunwind-local.c
> 
> $ git status -s
> [ empty ]

Interesting, since Linus complained at some point that after building
perf some new temp file was left there I added 'git status' to my
scripts to always get this flagged.

I'm not seeing this here.

- Arnaldo
