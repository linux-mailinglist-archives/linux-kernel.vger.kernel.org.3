Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57D158ECFB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiHJNUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiHJNUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:20:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC7022539
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:20:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA6B76145B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 13:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DAFC433C1;
        Wed, 10 Aug 2022 13:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660137609;
        bh=D8egAcVyx9nyX+rLpLoHkmEminmNpNiyOe5zon2sIdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QRNYCh6eQDEF4vSVZkimKDXz6bP40nS5E1QaCFeb3YXm06qE7zpquno63FxIsT3j3
         4uxdPpelvD8kIebW0RK9dsKZVRLv2V1lxoVDG/Rmdb++qeQe4fM/IK8yagvAyqtx8y
         /Akd5NeP3zSVg21PFlaH8TXMfe++fR7QM709Z5z8G3FAZ1Gyrrhd/+m9doqoCxfjP7
         zsJdDrVCNSgtq5xi7b9jNp1AoCRea9El//BsSGdYyX61juOekisBuZg7C46nvNzysj
         9o7w0bg2OXfX7FHGTdpqA7Wxuifq7E9xEljhwqi3oA7QJGRj77fREg9hnUt9sUt7Wb
         oCvpYcsbDGxkw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 264574035A; Wed, 10 Aug 2022 10:20:07 -0300 (-03)
Date:   Wed, 10 Aug 2022 10:20:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix missing free of
 machine->kallsyms_filename
Message-ID: <YvOwhyuJkyDqmR68@kernel.org>
References: <20220809130758.12800-1-adrian.hunter@intel.com>
 <CAP-5=fWx_evrzai1Q_6FsowHG-V2H5jX58-s5AetJJcG4C0+2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWx_evrzai1Q_6FsowHG-V2H5jX58-s5AetJJcG4C0+2g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 09, 2022 at 09:51:12AM -0700, Ian Rogers escreveu:
> On Tue, Aug 9, 2022 at 6:08 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > Add missing free of machine->kallsyms_filename to machine__exit().
> >
> > Fixes: a5367ecb5353 ("perf tools: Automatically use guest kcore_dir if present")
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/util/machine.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index facc13fbf16e..2a16cae28407 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -236,6 +236,7 @@ void machine__exit(struct machine *machine)
> >         zfree(&machine->root_dir);
> >         zfree(&machine->mmap_name);
> >         zfree(&machine->current_tid);
> > +       zfree(&machine->kallsyms_filename);
> >
> >         for (i = 0; i < THREADS__TABLE_SIZE; i++) {
> >                 struct threads *threads = &machine->threads[i];
> > --
> > 2.25.1
> >

-- 

- Arnaldo
