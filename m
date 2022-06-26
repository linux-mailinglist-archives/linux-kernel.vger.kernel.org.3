Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC28355B2A1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 17:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiFZPbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 11:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiFZPbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 11:31:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A36AF59E;
        Sun, 26 Jun 2022 08:31:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D21A608D4;
        Sun, 26 Jun 2022 15:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29B3C34114;
        Sun, 26 Jun 2022 15:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656257468;
        bh=xJWX94FOqGcXiYCcQofa7ahQQMmze1AnF9eDIB/IUHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QEsmiGMc8vC9VXs3EXOM92rhbLq04WVRJctt/S9+XkGyJadjsDOCvVPws3JYXhpvx
         0EC1PBEgX350SoDjHigW7uyimfoDxpY+x2IBg+4N28R5+yDYJShe2rDjJRYikxU9g9
         ucLQjfiyebBYunR7eYTGoLdKslgFTMuWqkeHkMB+DVyF63SiiXF06I/wkoiw5AQjN3
         G9FGkRDoJtijt7SF/N9ATG4LTGdTCECgyp9wOWo6pqozDcqSbwK93qP4CsQuNqkOOm
         XhGUL+Tb3tI3cOkWqwFtsfA2k/EhfSgm7wwpQD2rMgWCHyLKc2R3f/KPCrEaQUODL0
         3/UGvFvEtIsmg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 997EB4096F; Sun, 26 Jun 2022 12:31:05 -0300 (-03)
Date:   Sun, 26 Jun 2022 12:31:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Linux v5.19-rc1] tools/perf/a.out remains after make -C
 tools/perf clean
Message-ID: <Yrh7uSL0AybSqd0V@kernel.org>
References: <20220607000851.39798-1-irogers@google.com>
 <CA+icZUWpSF6ge76JVp1qBC5QhC1AwNacs5Di=e1QSbAD+SVKUA@mail.gmail.com>
 <YqjggY64PKfog0YW@kernel.org>
 <CA+icZUUx_Re+w9S7eHXma9aC=8T8ypp8=+tkJy7zJMrUocMSKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUUx_Re+w9S7eHXma9aC=8T8ypp8=+tkJy7zJMrUocMSKQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 15, 2022 at 12:11:48AM +0200, Sedat Dilek escreveu:
> On Tue, Jun 14, 2022 at 9:24 PM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Tue, Jun 07, 2022 at 08:59:31PM +0200, Sedat Dilek escreveu:
> > > Hi,
> > >
> > > I observed this some time ago - so this is not only Linux v5.19-rc1 related.
> > >
> > > $ LC_ALL=C make -C tools/perf clean 2>&1 | tee ../make-log_perf-clean.txt
> > > make: Entering directory '/home/dileks/src/linux-kernel/git/tools/perf'
> > >  CLEAN   x86
> > >  CLEAN   libtraceevent
> > >  CLEAN   libapi
> > >  CLEAN   libbpf
> > >  CLEAN   libsubcmd
> > >  CLEAN   libperf
> > >  CLEAN   fixdep
> > >  CLEAN   feature-detect
> > >  CLEAN   python
> > >  CLEAN   bpf-skel
> > >  CLEAN   core-objs
> > >  CLEAN   core-progs
> > >  CLEAN   core-gen
> > >  CLEAN   Documentation
> > > make: Leaving directory '/home/dileks/src/linux-kernel/git/tools/perf'
> > >
> > > $ git status -s
> > > M tools/perf/util/unwind-libunwind-local.c
> > > ?? tools/perf/a.out
> > >
> > > $ rm -v tools/perf/a.out
> > > 'tools/perf/a.out' deleted
> > >
> > > $ git checkout -- tools/perf/util/unwind-libunwind-local.c
> > >
> > > $ git status -s
> > > [ empty ]
> >
> > Interesting, since Linus complained at some point that after building
> > perf some new temp file was left there I added 'git status' to my
> > scripts to always get this flagged.
> >
> > I'm not seeing this here.
> >
> 
> Just re-checked with Linux v5.19-rc2 and attaching tools/perf/a.out +
> tools/perf/Makefile.config.
> 
> Check perf binary:
> 
> $ ~/bin/perf -vv
> perf version 5.19.0-rc2
>                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
>    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
>                 glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
>         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
>                libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
>            debuginfod: [ OFF ]  # HAVE_DEBUGINFOD_SUPPORT
>                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
>             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
>             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
>    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
>                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
>             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
>                   aio: [ on  ]  # HAVE_AIO_SUPPORT
>                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
>               libpfm4: [ OFF ]  # HAVE_LIBPFM
> 
> Tried `make distclean`.
> Tried `make tools/ clean` but tools/tracing/rtla produces errors (rm clean).
> Still exists: tools/perf/a.out.

I started seeing this here, will investigate and re-read your reports,
thanks for sending them!

- Arnaldo
