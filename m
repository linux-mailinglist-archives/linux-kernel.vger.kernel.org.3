Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0A84FA958
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 17:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242529AbiDIPrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 11:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiDIPrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 11:47:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DCBF7B;
        Sat,  9 Apr 2022 08:45:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03EEEB80688;
        Sat,  9 Apr 2022 15:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D50C385A4;
        Sat,  9 Apr 2022 15:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649519098;
        bh=MpiCpl1K2EcLuCQxwXCkDuh690V+U0S2LFvoqsVv5u4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PqzVJKdk6P/gOxqUCQ8Us8E6q+yTz8PRNUL8tbzGILdlUXfWNR5Zs58Cwv2ezMJmH
         p3XfvMkDAsCqBFSraGqOJF9Yu5/hPLrgZPFX46pYqd4/gV63ND++nxu1ASRXfB8qiR
         iY4GjtrYXArp0ElOOX2G5RMXcZ+0ul4an1RSfj1FWPrqmnpHXl6OK7H9D3bs8Xd+WT
         0bgHuRC7hdubDvjoeXhflvXqdh/Fa8M9GGPM9TefROGjWGcdqRGOIfOK83TG2aOnvO
         PLbFvFRqw1lZGaZILDJt/pqdM54G7nqv8EhiYEbWHJ0+zVejXSXOJjI1UIqBV5LlgJ
         lY044ep8Wo9lg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C88AE40407; Sat,  9 Apr 2022 12:44:56 -0300 (-03)
Date:   Sat, 9 Apr 2022 12:44:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        William Cohen <wcohen@redhat.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Lexi Shao <shaolexi@huawei.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Denis Nikitin <denik@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/5] perf annotate: Drop objdump stderr
Message-ID: <YlGp+EVwne5QbjtY@kernel.org>
References: <20220407230503.1265036-1-irogers@google.com>
 <20220407230503.1265036-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407230503.1265036-2-irogers@google.com>
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

Em Thu, Apr 07, 2022 at 04:04:59PM -0700, Ian Rogers escreveu:
> If objdump writes to stderr it can block waiting for it to be read. As
> perf doesn't read stderr then progress stops with perf waiting for
> stdout output.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/annotate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index e4c641b240df..82cc396ef516 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2047,6 +2047,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  	objdump_process.argv = objdump_argv;
>  	objdump_process.out = -1;
>  	objdump_process.err = -1;
> +	objdump_process.no_stderr = 1;
>  	if (start_command(&objdump_process)) {
>  		pr_err("Failure starting to run %s\n", command);
>  		err = -1;
> -- 
> 2.35.1.1178.g4f1659d476-goog

-- 

- Arnaldo
