Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029A94FA935
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 17:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242398AbiDIPSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 11:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242437AbiDIPST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 11:18:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F30BFB
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 08:16:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45F5DB807E5
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 15:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75B2C385A0;
        Sat,  9 Apr 2022 15:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649517369;
        bh=lfcFAc+RhqZ1/cu2c6UePcSLmxOGoyzClv2kkRwyLNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nzub0L71StbPq58BmZC+BGa1div5LkIYJFBQSjcVZquUFVPlfEpwSsIIPcxORSsOy
         VTJg4UXipWRM2o36uMvMRBDRr7H8WLb19YzilJuYoUuDMR1aO4c/LE5kpWi/tYW0+s
         Y/mCZk9X+LaU26lbTvwxPMBW2QG71H1YsqS5bAXx/2diIpeMFNin55fyb+hezWzPAT
         KGW+r7qp1W5iKmoaTaexH2M023arLZ/b4QAHIiFpni/lA84061m9GfqQanr6w93ghl
         McMkKqQqdNmSXUIxMphWfY+86607ozvQiDzhrjxmBnPlYW4eBZ6eES8hPUAUeFcj2U
         YIBCJxKy1SXMg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 68CFD40407; Sat,  9 Apr 2022 12:16:07 -0300 (-03)
Date:   Sat, 9 Apr 2022 12:16:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix perf's libperf_print callback
Message-ID: <YlGjN1YOKakAWSVx@kernel.org>
References: <20220408132625.2451452-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408132625.2451452-1-adrian.hunter@intel.com>
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

Em Fri, Apr 08, 2022 at 04:26:25PM +0300, Adrian Hunter escreveu:
> eprintf does not expect va_list as the 4th parameter.
> Use veprintf because it does.

You forgot to add this:

Fixes: 428dab813a56ce94 ("libperf: Merge libperf_set_print() into libperf_init()")

Please consider doing it next time.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index 2f6b67189b42..6aae7b6c376b 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -434,7 +434,7 @@ void pthread__unblock_sigwinch(void)
>  static int libperf_print(enum libperf_print_level level,
>  			 const char *fmt, va_list ap)
>  {
> -	return eprintf(level, verbose, fmt, ap);
> +	return veprintf(level, verbose, fmt, ap);
>  }
>  
>  int main(int argc, const char **argv)
> -- 
> 2.25.1

-- 

- Arnaldo
