Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC7B4DCA21
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbiCQPi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbiCQPiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:38:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1787320A960;
        Thu, 17 Mar 2022 08:37:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A96D361994;
        Thu, 17 Mar 2022 15:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77EDC340E9;
        Thu, 17 Mar 2022 15:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647531423;
        bh=xhgfUKiVqQtSHtmU2U28r1pERnVBDnXfHHXOPYtszO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rq7Ms0SURyvlpzuJSRzl1pBUY9hAAgSJ4+8uneJoPbm5IvKuWPIGaXBdhnMB5yC9Q
         ZZ5WjPzsTYMV0qb5MSD4nDX6NcwexcJpIDaR3mK4rRiXQJwUJg6bp1ITGcAQF9nFPO
         Eruv2IGgTHcPN/Wx6iaEHkqPk9VmN0id3+HPukkyTPhRVt/A7vyYCGrUR50qE2lo9v
         Z/2itluZsDw8Fd3HN+ryMpubEhDs7RPYviocNqA3uUkpwv61XSzcZckLURbo087WI1
         1lFI4R5qQ9X4Z6tUq1IT0yUZvgIzPP12qSuq9vW/C3ojegHTVx3Jg5Dy/POGNaLcKl
         wLhg3RDWNSmNA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4B3F640407; Thu, 17 Mar 2022 12:37:00 -0300 (-03)
Date:   Thu, 17 Mar 2022 12:37:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        jolsa@kernel.org, atrajeev@linux.vnet.ibm.com, maddy@linux.ibm.com,
        kjain@linux.ibm.com
Subject: Re: [PATCH] perf symbols: Fix symbol size calculation condition
Message-ID: <YjNVnA+tToooxUV+@kernel.org>
References: <20220317135536.805-1-mpetlan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317135536.805-1-mpetlan@redhat.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 17, 2022 at 02:55:36PM +0100, Michael Petlan escreveu:
> Before this patch, the symbol end address fixup to be called, needed two
> conditions being met:
> 
>   if (prev->end == prev->start && prev->end != curr->start)
> 
> Where
>   "prev->end == prev->start" means that prev is zero-long
>                              (and thus needs a fixup)
> and
>   "prev->end != curr->start" means that fixup hasn't been applied yet
> 
> However, this logic is incorrect in the following situation:
> 
> *curr  = {rb_node = {__rb_parent_color = 278218928,
>   rb_right = 0x0, rb_left = 0x0},
>   start = 0xc000000000062354,
>   end = 0xc000000000062354, namelen = 40, type = 2 '\002',
>   binding = 0 '\000', idle = 0 '\000', ignore = 0 '\000',
>   inlined = 0 '\000', arch_sym = 0 '\000', annotate2 = false,
>   name = 0x1159739e "kprobe_optinsn_page\t[__builtin__kprobes]"}
> 
> *prev = {rb_node = {__rb_parent_color = 278219041,
>   rb_right = 0x109548b0, rb_left = 0x109547c0},
>   start = 0xc000000000062354,
>   end = 0xc000000000062354, namelen = 12, type = 2 '\002',
>   binding = 1 '\001', idle = 0 '\000', ignore = 0 '\000',
>   inlined = 0 '\000', arch_sym = 0 '\000', annotate2 = false,
>   name = 0x1095486e "optinsn_slot"}
> 
> In this case, prev->start == prev->end == curr->start == curr->end,
> thus the condition above thinks that "we need a fixup due to zero
> length of prev symbol, but it has been probably done, since the
> prev->end == curr->start", which is wrong.
> 
> After the patch, the execution path proceeds to arch__symbols__fixup_end
> function which fixes up the size of prev symbol by adding page_size to
> its end offset.

You missed this:

Fixes: 3b01a413c196c910 ("perf symbols: Improve kallsyms symbol end addr calculation")

I'll add it to the patch, ok?

- Arnaldo
 
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> ---
>  tools/perf/util/symbol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index fb075aa8f8f2..dea0fc495185 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -231,7 +231,7 @@ void symbols__fixup_end(struct rb_root_cached *symbols)
>  		prev = curr;
>  		curr = rb_entry(nd, struct symbol, rb_node);
>  
> -		if (prev->end == prev->start && prev->end != curr->start)
> +		if (prev->end == prev->start || prev->end != curr->start)
>  			arch__symbols__fixup_end(prev, curr);
>  	}
>  
> -- 
> 2.18.4

-- 

- Arnaldo
