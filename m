Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0439653D256
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 21:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349203AbiFCTYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 15:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344263AbiFCTYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 15:24:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92D7BE22;
        Fri,  3 Jun 2022 12:24:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 568EC61A40;
        Fri,  3 Jun 2022 19:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FF6C385B8;
        Fri,  3 Jun 2022 19:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654284243;
        bh=yt+bB3Q+W8oVkpzAEgMcRoEXyzhk3C1iaR9Ljh12V+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O9MHOZXYaNO1a0uNf4TGQcDx2TvE/MXiR8+rLcoxIoSZe/ykSV82GLX9qufcBKcK3
         XeYlZBUGLdwXWglLZo/ct9mgVN+bWTjnCFPWMzLw5l51uvjZ8uHO1KmSwyF4dxJNT1
         U6Z31jCH/wDI75npKvF3m7dYGx6WgLubziWrnzu/JesQV58NM8lHiDAI3AuqLbN481
         THO0RULtZ0jyhxUixw270coBskVc/QYq0Pk7EsHUUBWw7i7HsgrlMxy1bMfc72wSqu
         OITLuH13u+7gnw4BIUekewYEuBoZ/NglJy2mU6a7oosx+LZWupfU8oG7GAHjfzKGLX
         trNk6TfYBiqhg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AB1C14096F; Fri,  3 Jun 2022 21:24:01 +0200 (CEST)
Date:   Fri, 3 Jun 2022 21:24:01 +0200
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Fangrui Song <maskray@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sebastian Ullrich <sebasti@nullri.ch>
Subject: Re: [PATCH v2] perf: Fix segbase for ld.lld linked objects
Message-ID: <Yppf0ZOhRWZunQDx@kernel.org>
References: <20220527182039.673248-1-maskray@google.com>
 <CAP-5=fWXm-G8M_MTBjj2h_JkHgj6WU27GDqJ0hcRthtYG-m4AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWXm-G8M_MTBjj2h_JkHgj6WU27GDqJ0hcRthtYG-m4AQ@mail.gmail.com>
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

Em Fri, May 27, 2022 at 11:51:54AM -0700, Ian Rogers escreveu:
> On Fri, May 27, 2022 at 11:20 AM Fangrui Song <maskray@google.com> wrote:
> >
> > segbase is the address of .eh_frame_hdr and table_data is segbase plus
> > the header size. find_proc_info computes segbase as `map->start +
> > segbase - map->pgoff` which is wrong when
> >
> > * .eh_frame_hdr and .text are in different PT_LOAD program headers
> > * and their p_vaddr difference does not equal their p_offset difference
> >
> > Since 10.0, ld.lld's default --rosegment -z noseparate-code layout has
> > such R and RX PT_LOAD program headers.
> >
> >     ld.lld (default) => perf report fails to unwind `perf record
> >     --call-graph dwarf` recorded data
> >     ld.lld --no-rosegment => ok (trivial, no R PT_LOAD)
> >     ld.lld -z separate-code => ok but by luck: there are two PT_LOAD but
> >     their p_vaddr difference equals p_offset difference
> >
> >     ld.bfd -z noseparate-code => ok (trivial, no R PT_LOAD)
> >     ld.bfd -z separate-code (default for Linux/x86) => ok but by luck:
> >     there are two PT_LOAD but their p_vaddr difference equals p_offset
> >     difference
> >
> > To fix the issue, compute segbase as dso's base address plus
> > PT_GNU_EH_FRAME's p_vaddr. The base address is computed by iterating
> > over all dso-associated maps and then subtract the first PT_LOAD p_vaddr
> > (the minimum guaranteed by generic ABI) from the minimum address.
> >
> > In libunwind, find_proc_info transitively called by unw_step is cached,
> > so the iteration overhead is acceptable.
> >
> > Reported-by: Sebastian Ullrich <sebasti@nullri.ch>
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1646
> > Signed-off-by: Fangrui Song <maskray@google.com>
> > Cc: Ian Rogers <irogers@google.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

