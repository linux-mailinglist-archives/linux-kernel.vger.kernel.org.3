Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9920B4E7CFD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiCYTh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiCYThG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:37:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C229D262D61
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:22:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 107F161C2F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 18:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A865C2BBE4;
        Fri, 25 Mar 2022 18:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648232796;
        bh=Yv5kugbiA+mRs3zFVL6eQ1YikXvFcsnugzO/02LilQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QrN/QO2Vcrz8iMwlWpwFaM0KVbTn1FAetMcvMtkj8CyVqkIQvEk1KXym5fc4uMz4l
         JjW2blfCkc7uIIzHsPuYPeHL94LNdtLzMN1NZzvGRdFoRTVNRNwdt5oDJ0UEaRGLxq
         yKhA+6DP2jFVSdKIE4nh2xvCwn0gIxGDjI59J3L/zH0irrEyDAA4RFO0VVD8vsLi9B
         i6KWPHKTDjcMF5dPZXpF8fC+gFVcR8gkUntz3Ptfa8rvSBLQONeWfV/hNcSXvBeDL+
         I8Sp2fla1+YEFK1pFvqXbAsksnYcM2qyxY2pBfki+aLhQMVxTJ5JqHr/8jcJWmCHEc
         2r9+sxmaCf+bQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D572D40407; Fri, 25 Mar 2022 15:26:32 -0300 (-03)
Date:   Fri, 25 Mar 2022 15:26:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/3] perf lock: Add --synth=no option for record
Message-ID: <Yj4JWOeiRUy4jlGd@kernel.org>
References: <20220323230259.288494-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323230259.288494-1-namhyung@kernel.org>
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

Em Wed, Mar 23, 2022 at 04:02:57PM -0700, Namhyung Kim escreveu:
> The perf lock command has nothing to symbolize and lock names come
> from the tracepoint.  Moreover, kernel symbols are available even the
> --synth=no option is given.
> 
> This will reduce the startup time by avoiding unnecessary synthesis.

Thanks, applied the series.

- Arnaldo

 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-lock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 57b9ebd7118a..1ebff88bc5ba 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -990,7 +990,7 @@ static int __cmd_report(bool display_info)
>  static int __cmd_record(int argc, const char **argv)
>  {
>  	const char *record_args[] = {
> -		"record", "-R", "-m", "1024", "-c", "1",
> +		"record", "-R", "-m", "1024", "-c", "1", "--synth", "no",
>  	};
>  	unsigned int rec_argc, i, j, ret;
>  	const char **rec_argv;
> -- 
> 2.35.1.894.gb6a874cedc-goog

-- 

- Arnaldo
