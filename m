Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A04255E72E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbiF1Oj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346535AbiF1OjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:39:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245E42A249;
        Tue, 28 Jun 2022 07:39:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B372161B10;
        Tue, 28 Jun 2022 14:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E474BC3411D;
        Tue, 28 Jun 2022 14:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656427160;
        bh=iXjQOMUw2pEqEisHPWIOBTot93+QZsYt/nHRRPucOyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LqR9CN0wDjLJFmWy9tW2JNnugtju01skjVmIwyQGlS5tghYgB2YEq4/jUGrLRfGT3
         X9BHevJs3fCge08w6NZKeppOw+9z51olocTjzUylhUoMuUjoONGWH1B1zIv6nECXaZ
         V6mALMeromolaLDKWIpQyYIqr4t120G2e7uibto8Dz8RlAXXtdc2+YNNKEbDmUYnRo
         aliyLR4CE1KvCCv916ievOlW2XY5G+VY0U09vTItsQI/XUdhnLRaIvaK648LtRee3m
         UCPoM7dMfsLjLGBlbZtgzdnDQ0jtFNrp2sdvZPdfT/SfnRwSahuRVM3F3bVi6TJeXg
         63yRl8mMg8C7g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6C2E04096F; Tue, 28 Jun 2022 11:39:16 -0300 (-03)
Date:   Tue, 28 Jun 2022 11:39:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Linux v5.19-rc1] tools/perf/a.out remains after make -C
 tools/perf clean
Message-ID: <YrsSlH8OCR0JSlxA@kernel.org>
References: <20220607000851.39798-1-irogers@google.com>
 <CA+icZUWpSF6ge76JVp1qBC5QhC1AwNacs5Di=e1QSbAD+SVKUA@mail.gmail.com>
 <YqjggY64PKfog0YW@kernel.org>
 <CA+icZUUx_Re+w9S7eHXma9aC=8T8ypp8=+tkJy7zJMrUocMSKQ@mail.gmail.com>
 <Yrh7uSL0AybSqd0V@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrh7uSL0AybSqd0V@kernel.org>
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

Em Sun, Jun 26, 2022 at 12:31:05PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Jun 15, 2022 at 12:11:48AM +0200, Sedat Dilek escreveu:
> >                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
> >                   aio: [ on  ]  # HAVE_AIO_SUPPORT
> >                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
> >               libpfm4: [ OFF ]  # HAVE_LIBPFM
> > 
> > Tried `make distclean`.
> > Tried `make tools/ clean` but tools/tracing/rtla produces errors (rm clean).
> > Still exists: tools/perf/a.out.
> 
> I started seeing this here, will investigate and re-read your reports,
> thanks for sending them!

This is only happening when I use CC=clang, here I have clang 13, just
making a note, seems related to a feature check,
tools/build/feature/test-hello.c.

- Arnaldo
