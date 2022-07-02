Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881AB563F52
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 11:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiGBJt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 05:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBJt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 05:49:57 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460CF13CD1;
        Sat,  2 Jul 2022 02:49:55 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id B0CE7C01F; Sat,  2 Jul 2022 11:49:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1656755393; bh=kWnM5HmL8ZFxmHvTL3mAW3KL5okW54pgpZzMeub04BA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K5PVBEieNp9VipJHL//Pd2ri4iffFUOyGAFlu/85gzuYeX/TZ2eyfWxjEcAxxbMk7
         iOeH5ij3NjubZSuHjyEUfMl9tUDFomKzARqomzh4gjq9ZwTQa7kxbuhMkb9QhOkbgg
         EpHv6+ZcTzF0qBBg44C6CG/dR/niGBTuMzKFPtP0moKjMp0A3GFj3TCS1MNomRDtkI
         cNF6A23XLFLFtVcNcQXt3ReJyQbzAz5oqGDevBHXrH3b7dZqEaIbuE4AObp5IBn0YX
         gEMO7db99yj87MC6qmf6eTOpRH1IA4k9z2KatjNSt75E7zAQD2+ELNwcFcprLKIHs8
         Cte4UEIHv+2xg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 69C2AC009;
        Sat,  2 Jul 2022 11:49:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1656755393; bh=kWnM5HmL8ZFxmHvTL3mAW3KL5okW54pgpZzMeub04BA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K5PVBEieNp9VipJHL//Pd2ri4iffFUOyGAFlu/85gzuYeX/TZ2eyfWxjEcAxxbMk7
         iOeH5ij3NjubZSuHjyEUfMl9tUDFomKzARqomzh4gjq9ZwTQa7kxbuhMkb9QhOkbgg
         EpHv6+ZcTzF0qBBg44C6CG/dR/niGBTuMzKFPtP0moKjMp0A3GFj3TCS1MNomRDtkI
         cNF6A23XLFLFtVcNcQXt3ReJyQbzAz5oqGDevBHXrH3b7dZqEaIbuE4AObp5IBn0YX
         gEMO7db99yj87MC6qmf6eTOpRH1IA4k9z2KatjNSt75E7zAQD2+ELNwcFcprLKIHs8
         Cte4UEIHv+2xg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 14cf811d;
        Sat, 2 Jul 2022 09:49:46 +0000 (UTC)
Date:   Sat, 2 Jul 2022 18:49:31 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf parse: Allow names to start with digits
Message-ID: <YsAUqwzeO8U6cIJA@codewreck.org>
References: <20220612061508.1449636-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220612061508.1449636-1-asmadeus@codewreck.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

just making sure my mail didn't get lost -- would anyone have time to
look at this?

I don't mind if it's slow or another solution is taken, I'd just like to
be able to use 9p probes with perf eventually :)

Thanks!

Dominique Martinet wrote on Sun, Jun 12, 2022 at 03:15:08PM +0900:
> Tracepoints can start with digits, although we don't have many of these:
> 
> $ rg -g '*.h' '\bTRACE_EVENT\([0-9]'
> net/mac802154/trace.h
> 53:TRACE_EVENT(802154_drv_return_int,
> ...
> 
> net/ieee802154/trace.h
> 66:TRACE_EVENT(802154_rdev_add_virtual_intf,
> ...
> 
> include/trace/events/9p.h
> 124:TRACE_EVENT(9p_client_req,
> ...
> 
> Just allow names to start with digits too so e.g. perf probe -e '9p:*'
> works
> 
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
>  tools/perf/util/parse-events.l | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index 5b6e4b5249cf..4133d6950d29 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -211,7 +211,7 @@ bpf_source	[^,{}]+\.c[a-zA-Z0-9._]*
>  num_dec		[0-9]+
>  num_hex		0x[a-fA-F0-9]+
>  num_raw_hex	[a-fA-F0-9]+
> -name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]!]*
> +name		[a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?.\[\]!]*
>  name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
>  name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
>  drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
