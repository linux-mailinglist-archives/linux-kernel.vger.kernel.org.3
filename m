Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F10591151
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238328AbiHLNY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbiHLNYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:24:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC54491083;
        Fri, 12 Aug 2022 06:24:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E3F1B82438;
        Fri, 12 Aug 2022 13:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BFBC433C1;
        Fri, 12 Aug 2022 13:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660310690;
        bh=YUlrJqV7OXDl0VwFu2JPlNjExMew8te/RhYglmsalYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PHfRVx8n4zP2uuRfW8ZvQd6cxz4DngbJJzM+oFUaKToIZDr9SzgHbKy3mArN+4UiF
         KEv0RzI8VNULwIhIW0lYELftoWwPdHws4bljRMlot/26sQuUauaOt3x4x/K+QJNMzo
         WIRdS67JKCVdVX6pri5kHN+5x2jw1qL7Bne2ix45kVvkRXPCPu4QHBc2IM41sWBlq5
         4PifvPMCrjXYpDbsRYcFjADIlUXLXPdeYzmMszmvvwKTSBO7FTUOZXto6VHxsQkRCi
         m7pP62WA9L26qO8BBTKavohU6aFxSiM2KQhPi171sZUe5smsYQoP6OthCiyIl03vBd
         CygdbU9DYgu8A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 03C7E4035A; Fri, 12 Aug 2022 10:24:47 -0300 (-03)
Date:   Fri, 12 Aug 2022 10:24:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf: Print debuginfod queries if -v option is used
Message-ID: <YvZUnxjDo0JxeRdE@kernel.org>
References: <2983e2e0-6850-ad59-79d8-efe83b22cffe@suse.cz>
 <325871cf-b71f-6237-8793-82182272ece8@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <325871cf-b71f-6237-8793-82182272ece8@suse.cz>
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

Em Fri, Aug 12, 2022 at 01:43:53PM +0200, Martin Liška escreveu:
> When ending a perf record session, the querying of a debuginfod
> server can take quite some time. Inform a user about it when
> -v options is used.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Martin Liska <mliska@suse.cz>
> ---
>  tools/perf/util/build-id.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 0cc68cdd84c8..d1cfce0613ee 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -653,7 +653,9 @@ static char *build_id_cache__find_debug(const char *sbuild_id,
>  
>  #ifdef HAVE_DEBUGINFOD_SUPPORT
>  	if (realname == NULL) {
> -		debuginfod_client* c = debuginfod_begin();
> +		debuginfod_client* c;
> +		pr_debug("Downloading debug info with build id %s\n", sbuild_id);
> +		c = debuginfod_begin();
>  		if (c != NULL) {
>  			int fd = debuginfod_find_debuginfo(c,
>  					(const unsigned char*)sbuild_id, 0,
> -- 
> 2.37.1

-- 

- Arnaldo
