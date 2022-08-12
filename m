Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24301591161
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238655AbiHLN2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbiHLN14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:27:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9EF9676F;
        Fri, 12 Aug 2022 06:27:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E646261796;
        Fri, 12 Aug 2022 13:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BBEC433C1;
        Fri, 12 Aug 2022 13:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660310873;
        bh=cmb2NY59G28HxU+zeB3Bvu59tXMPnTojd4k1tey0wIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OfsTPUB+qTeTidebw5eZ5Hl2PBnTTaxB0iU0jiw+BDPRS0AIJAf2zrynh4wJjXRaw
         5ViGjqJB3W030x6YwJG/9qUje2SoZOzHguin1ID2Xpx9KERyoaWzqUxEwDLgGy0aMn
         erg4txxKflOyB4nnw1HkC2F1azUBjC86WXcgcSfF3DDF2ZCqnb28I0VpX6eISwWIMi
         tniLfIxMRFXYFgUisC/EMVFNAy7hTueF49Ce7KNhNUS/viRGc3Ysu9M8ezVagLPWl5
         sKzs2Ey0fkgKL731vKfhPnvI5dF1exFfXvXw7GzdreqLTN4ahG6BdWHopYLMef2BrY
         Oq1PVNI6z7rDA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DE72B4035A; Fri, 12 Aug 2022 10:27:50 -0300 (-03)
Date:   Fri, 12 Aug 2022 10:27:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf record: improve error message of -p not_existing_pid
Message-ID: <YvZVVjrfKLCfJ/ig@kernel.org>
References: <8e00eda1-4de0-2c44-ce67-d4df48ac1f7c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e00eda1-4de0-2c44-ce67-d4df48ac1f7c@suse.cz>
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

Em Fri, Aug 12, 2022 at 01:40:49PM +0200, Martin Liška escreveu:
> When one uses -p $not_existing_pid, the output of --help is printed:
> 
> $ perf record -p 123456789 2>&1 | head -n3
> 
>  Usage: perf record [<options>] [<command>]
>     or: perf record [<options>] -- <command> [<options>]
> 
> Let's change it something similar what perf top -p $not_existing_pid
> prints:
> 
> $ ./perf top -p 123456789 --stdio
> Error:
> Couldn't create thread/CPU maps: No such process
> 
> Newly suggested error message:
> 
> $ ./perf record -p 123456789
> Couldn't create thread/CPU maps: No such process

Thanks, tested and applied.

- Arnaldo

 
> Signed-off-by: Martin Liska <mliska@suse.cz>
> ---
>  tools/perf/builtin-record.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index cf5c5379ceaa..4713f0f3a6cf 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -3996,8 +3996,15 @@ int cmd_record(int argc, const char **argv)
>  		arch__add_leaf_frame_record_opts(&rec->opts);
>  
>  	err = -ENOMEM;
> -	if (evlist__create_maps(rec->evlist, &rec->opts.target) < 0)
> -		usage_with_options(record_usage, record_options);
> +	if (evlist__create_maps(rec->evlist, &rec->opts.target) < 0) {
> +		if (rec->opts.target.pid != NULL) {
> +			pr_err("Couldn't create thread/CPU maps: %s\n",
> +				errno == ENOENT ? "No such process" : str_error_r(errno, errbuf, sizeof(errbuf)));
> +			goto out;
> +		}
> +		else
> +			usage_with_options(record_usage, record_options);
> +	}
>  
>  	err = auxtrace_record__options(rec->itr, rec->evlist, &rec->opts);
>  	if (err)
> -- 
> 2.37.1

-- 

- Arnaldo
