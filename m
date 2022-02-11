Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273D94B2B01
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351761AbiBKQvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:51:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351834AbiBKQvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:51:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9CBD89
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:51:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A49761722
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 16:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD57C340E9;
        Fri, 11 Feb 2022 16:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644598278;
        bh=eqJp5kusit163YSRYDtIcvv2sDK0KRwBffqeDOeE/Vc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lbLr6Dojm2iW6wMKQqFRGiQWXwAVcG+lzh26HmIPCC40Nc/qMYxBQTO8Ws1/2lFuy
         fQCakb28wf4i5sMuMz6vR9yukjGyHWtnqOCufDFE9OVnNrI1f3NSm7wHw2Yh7UTxsk
         rpnjDyG+BR/BKRatCdR5daAC3K87GJgemHuUaxyK1rQHMctGhtiOZqzQQiwkYfZoVO
         Ry1QPN9CSoko+Lj0iGfTIr8B2JNrzKvvEZUQWsubYwzO9SY4CfuRr5qcv03U8JovbW
         rjl7Lc2afNRsQkgnCCQVZNdl1odbaDmUYKlKC1+OQizA0AZE85gjTH93R2LDnjn/Vg
         prILrao0rlxSw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0A98D400FE; Fri, 11 Feb 2022 13:51:16 -0300 (-03)
Date:   Fri, 11 Feb 2022 13:51:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH v13 03/16] perf record: Introduce thread specific data
 array
Message-ID: <YgaUA4O2wvFFeeQJ@kernel.org>
References: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
 <fc9f74af6f822d9c0fa0e145c3564a760dbe3d4b.1642440724.git.alexey.v.bayduraev@linux.intel.com>
 <YfhXG5yEHhrGDjvl@kernel.org>
 <Yfhg1zH9rQ3lBP9N@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfhg1zH9rQ3lBP9N@kernel.org>
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

Em Mon, Jan 31, 2022 at 07:21:11PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Jan 31, 2022 at 06:39:39PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Some changes to reduce patch size, I have them in my local tree, will
> > publish later.
> 
> Its in perf/threaded at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
> 
> Will continue tomorrow, testing it and checking the speedups on my
> 5950x, I think the things I found so far can be fixed in follow up
> patches, to make progress and have this merged sooner.
> 
> I'll try and add committer notes with the test for some 'perf bench'
> workload without/with parallel recording, something I missed in your
> patch descriptions.

Didn't manage to do that, but my considerations are minor at this point
and plenty of informed people acked, reviewed, tested, so I'm not going
to be the one to prevent this from going upstream.

If we find problems (oh well), we'll fix it and progress.

Thank you, Alexei Budankov, Jiri, Namhyung and Riccardo for working on
making perf scale at the record phase for so long,

I'm pushing this to perf/core, that should get into 5.18.

Also, as a heads up, I'll change 'perf/core' to 'perf/next', to align
with the kool kids out there,

Thanks,

- Arnaldo
