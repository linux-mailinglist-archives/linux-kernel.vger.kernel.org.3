Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056075AE8DC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiIFMyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240211AbiIFMyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:54:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD07D74E26;
        Tue,  6 Sep 2022 05:53:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E6B661500;
        Tue,  6 Sep 2022 12:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12C3C433C1;
        Tue,  6 Sep 2022 12:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662468809;
        bh=fldsy+P2Q7PF4mFLFUGFtLZ/KojrACP13eE47+4QOLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ucylPzXrD7R0fNl3OILAPn6lz+kQHL5B9dok/3TaEJwy3KnlDGitr9hTyiSekDiQh
         5VuZvSYD6NEPcREhkN07Xkfvw0HQbuaPgKeDhKCHwiQjh8UuoDiSnESGR2yAe1FJVS
         o4oFsHDScad7GIEe0i0F57qOvna5Np7Yvr+4xSyVQYQJ5boQQ4bmqHWeRdkC8OCVu0
         JooftswuuOGi01wdQBIrLio2pKEOvLixctayUf8XiiJ6sggHG8NICrHgPnPU7kSNNb
         K+9EKGKsWrcJ0KIDTw4F2umkPmJJQBjRygFfWt0yOIAdsMqw1OUG616hGKMu++Bu6m
         /OuUEKVFxY6sA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8253D404A1; Tue,  6 Sep 2022 09:53:27 -0300 (-03)
Date:   Tue, 6 Sep 2022 09:53:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH V2] libperf evlist: Fix per-thread mmaps for
 multi-threaded targets
Message-ID: <YxdCx6UPU6wI95kc@kernel.org>
References: <20220905114209.8389-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220905114209.8389-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 05, 2022 at 02:42:09PM +0300, Adrian Hunter escreveu:
> The offending commit removed mmap_per_thread(), which did not consider
> the different set-output rules for per-thread mmaps i.e. in the per-thread
> case set-output is used for file descriptors of the same thread not the
> same cpu.
> 
> Fixes: ae4f8ae16a07 ("libperf evlist: Allow mixing per-thread and per-cpu mmaps")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

I added these:

Reported-by: Tomáš Trnka <trnka@scm.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=216441

Jiri made a comment, can you please reply?

Applied locally for further tests,

Thanks,

- Arnaldo
