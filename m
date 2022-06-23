Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A064557E27
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiFWOts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiFWOtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:49:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4037025E9B;
        Thu, 23 Jun 2022 07:49:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D549061E6C;
        Thu, 23 Jun 2022 14:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB45C341C4;
        Thu, 23 Jun 2022 14:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655995785;
        bh=OvG65GhwKQTbl8Ynp1orQ26fx51gHndrm9PpnBDSVnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VsOySaRM4OQGeLKpQVr/xu1CdGLfbjeApZv7IKFcPdFdxoW3+gWpkYNbkqAOwm/z2
         uDh6VOuy0QBDhZ4sE+XHF+PRlgJlJ0E8QAkgd8aHK96sziYNXVsa1xfsbrcZnekxIL
         N0U6jGZSYe2w/fViO38okjEz7X6ooOVxMa8rQX59iUxWh8xXmF5y+mqpzU+5kvi+MQ
         F0V8rS9GnPpfYRnVxM9awxjmZRGkxoPgA7QEPYPti3H6gcnPk6c1sVLK/7GLdyPOcK
         nGFslz9w2ZuWKjtmfu5/POKMZoW8etUigrWOrZnbCXShRw1xV8vFYYp2qZ2oo3+8Bt
         Livuio6EUTCPw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CAE174096F; Thu, 23 Jun 2022 11:49:42 -0300 (-03)
Date:   Thu, 23 Jun 2022 11:49:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1] perf stat: Enable ignore_missing_thread for
 stat
Message-ID: <YrR9hljHVltIe0aW@kernel.org>
References: <20220622030037.15005-1-ligang.bdlg@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622030037.15005-1-ligang.bdlg@bytedance.com>
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

Em Wed, Jun 22, 2022 at 11:00:37AM +0800, Gang Li escreveu:
> perf already support ignore_missing_thread for -p, but not yet
> applied to `perf stat -p <pid>`. This patch enables ignore_missing_thread
> for `perf stat -p <pid>`.

Thanks, will add it and stick the original explanation about
ignore_missing_thread so that reviewers of this patch can get a
refresher:

From  ca8000684ec4e66f965e1f9547a3c6cb834154ca
----------
    While monitoring a multithread process with pid option, perf sometimes
    may return sys_perf_event_open failure with 3(No such process) if any of
    the process's threads die before we open the event. However, we want
    perf continue monitoring the remaining threads and do not exit with
    error.
----------

Thanks,

- Arnaldo
 
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
> ---
>  tools/perf/builtin-stat.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 4ce87a8eb7d7..d2ecd4d29624 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2586,6 +2586,8 @@ int cmd_stat(int argc, const char **argv)
>  	if (evlist__initialize_ctlfd(evsel_list, stat_config.ctl_fd, stat_config.ctl_fd_ack))
>  		goto out;
>  
> +	/* Enable ignoring missing threads when -p option is defined. */
> +	evlist__first(evsel_list)->ignore_missing_thread = target.pid;
>  	status = 0;
>  	for (run_idx = 0; forever || run_idx < stat_config.run_count; run_idx++) {
>  		if (stat_config.run_count != 1 && verbose > 0)
> -- 
> 2.20.1

-- 

- Arnaldo
