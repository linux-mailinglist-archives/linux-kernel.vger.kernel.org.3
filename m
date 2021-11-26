Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5DC463590
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240938AbhK3Ni4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:38:56 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:34032 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240845AbhK3Nix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:38:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 494CDCE19D7;
        Tue, 30 Nov 2021 13:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7EDC53FC1;
        Tue, 30 Nov 2021 13:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638279331;
        bh=A7emTsiLpMS+Sn830n/U1zp0GbImTego1HfXFcUoxpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jvQkqYsr6gE6KOPgsQ/Y1Fvh3biX5laQy1dhLdFmhD9lroXyUhbMFYH/NzSg9BWrm
         ofv3oCUjfPbyeFlo4eFa7000MFMTKL2d5llyWKZduAX0SJr7Fl+evPJahylodu4cCj
         7Znpdh2yVHY2QDSBNX1iUx/fD2IQMbRaCGbrwjEhbcDGbeAEtK83fUhjQEPfiFJPfU
         RToWTTGasvPKJQzbCJkdqRVJzKz6fTfRu7hxS3G3SIWGBe64Mxk2Z9mbJhwnDp6GB0
         gI06wdd8Zgt/b7urNN6j4fTc78T0y/V2tqZbCaoBtJ60KvimsukhLQmZAd2fx8FSkM
         qJePE4zYjQ5yQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0E8324079C; Fri, 26 Nov 2021 15:50:10 -0300 (-03)
Date:   Fri, 26 Nov 2021 15:50:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [FYI][PATCH 1/1] tools headers UAPI: Sync s390 syscall table
 file changed by new futex_waitv syscall Reply-To:
Message-ID: <YaEsYUorLFBidQ7+@kernel.org>
References: <YZ/2qRW/TScYTP1U@kernel.org>
 <YaCug8LEHYmZ9G6E@osiris>
 <E1590C4C-2941-4922-A388-30780C9E01FA@gmail.com>
 <YaDFDApOMj8TQ4IJ@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaDFDApOMj8TQ4IJ@osiris>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 26, 2021 at 12:29:16PM +0100, Heiko Carstens escreveu:
> On Fri, Nov 26, 2021 at 07:01:16AM -0300, Arnaldo Carvalho de Melo wrote:
> > >> To pick the changes in this cset:
> > >> 
> > >>   6c122360cf2f4c5a ("s390: wire up sys_futex_waitv system call")
> > >> 
> > >> That add support for this new syscall in tools such as 'perf trace'.
> > >...
> > >> This addresses this perf build warnings:
> > >> 
> > >>   Warning: Kernel ABI header at 'tools/perf/arch/s390/entry/syscalls/syscall.tbl' differs from latest version at 'arch/s390/kernel/syscalls/syscall.tbl'
> > >>   diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl
> > >> 
> > >> Cc: Heiko Carstens <hca@linux.ibm.com>
> > >> Cc: Vasily Gorbik <gor@linux.ibm.com>
> > >> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > >> ---
> > >>  tools/perf/arch/s390/entry/syscalls/syscall.tbl | 1 +
> > >>  1 file changed, 1 insertion(+)
> > >
> > >I can happily pick this up for the s390 tree, but I'm not sure if that
> > >is want you want?
> > 
> > Just FYI and to give the opportunity to people to chime in in case something is wrong somehow.
> > 
> > Also to advertise the feature.
> > 
> > I'm pushing this upstream myself,
> 
> Thanks for taking care of this! FWIW:
> 
> Acked-by: Heiko Carstens <hca@linux.ibm.com>

Thanks, acked-by tag collected :-)

- Arnaldo
