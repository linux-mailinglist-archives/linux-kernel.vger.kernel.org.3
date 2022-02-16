Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175464B8A67
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbiBPNjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:39:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiBPNi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:38:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA78F2A39D3;
        Wed, 16 Feb 2022 05:38:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4779F617AA;
        Wed, 16 Feb 2022 13:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B0DC004E1;
        Wed, 16 Feb 2022 13:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645018726;
        bh=lGZYCEXOcR02XYggRTWM1b9CDKi7VMUH72BM91/hGls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cha2GYyt/bfElVjonGLrtpt5ooygJ/bLDXKzEjBRkIwqcCLhCBHLgnSPhJGhsTJ/B
         CvvlYOafarNHZKswdOj6WgDCbu8kcuS6wid9R2znnNvdlbDeIQRwEhQ2yrFDVVZFd6
         PULSt7pEaRph174ZmAbvf3x9UzxbbEUfL5vAFNG3Gmvd1R7AQDDwahCoL/tWd7h2T3
         zSitWue2Njdx9UqQ2aI1N2I4FvF421uPlrGB0tkpJcASNoxRNWExcI7nxclfjIcojP
         V2MQ6zfFmtaUbcJKbAUpCbyHdf7DZp2eT1ZOmG1WNp9R3mqpFB2QO6y8bCly6dJc+G
         wneAnckFQpIDQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E7E09400FE; Wed, 16 Feb 2022 10:38:43 -0300 (-03)
Date:   Wed, 16 Feb 2022 10:38:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     tangmeng <tangmeng@uniontech.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf tools: Remove redundant err variable
Message-ID: <Ygz+Y0uaXRY8tibF@kernel.org>
References: <20220216030425.27779-1-tangmeng@uniontech.com>
 <20220216030425.27779-2-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216030425.27779-2-tangmeng@uniontech.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 16, 2022 at 11:04:25AM +0800, tangmeng escreveu:
> The variable err in the perf_event__process_sample is only used
> in the only one judgment statement, it is not used in other places.
> 
> So, use the return value from hist_entry_iter__add() directly
> instead of taking this in another redundant variable.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: tangmeng <tangmeng@uniontech.com>
> ---
>  tools/perf/builtin-top.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 1fc390f136dd..3c8c60b7f6f0 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -746,7 +746,6 @@ static void perf_event__process_sample(struct perf_tool *tool,
>  {
>  	struct perf_top *top = container_of(tool, struct perf_top, tool);
>  	struct addr_location al;
> -	int err;
>  
>  	if (!machine && perf_guest) {
>  		static struct intlist *seen;
> @@ -839,8 +838,7 @@ static void perf_event__process_sample(struct perf_tool *tool,
>  
>  		pthread_mutex_lock(&hists->lock);
>  
> -		err = hist_entry_iter__add(&iter, &al, top->max_stack, top);
> -		if (err < 0)
> +		if (hist_entry_iter__add(&iter, &al, top->max_stack, top) < 0)
>  			pr_err("Problem incrementing symbol period, skipping event\n");
>  
>  		pthread_mutex_unlock(&hists->lock);
> -- 
> 2.20.1
> 
> 

-- 

- Arnaldo
