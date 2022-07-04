Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC0A565F26
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiGDVjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiGDVjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:39:19 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49DF3888
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 14:39:17 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n185so6014711wmn.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 14:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=85xt8gfUylWcpZOgKCioxv2QzHKT4Z0Id5Y79nmNe0g=;
        b=DZvPEU0niRPSUg1uzGPh9s1PVrURtPh3cmG2Acv6IPUz019D1bbLrcQoOFs8/lQlyV
         5z8bFMsb7Z5botGnD+CF+p/j07Y/wL4p9BDp8cPijf4Vj6F1HF+FoXOYFeasKG6rhypA
         m/VQRymrff10HgSmuC6keRDMqkff7H0Ng5KQD7842RfSU0G3SECxj5JluIDUrbvoKzSk
         59GkHMcCoQGzUo4qZVqCOQi9t4WddmAY/on7/fWq5lDxNFiEjGdwkoC8ZXPFJy0rq9d7
         WTeQK6eqpJuHmmr8vvwYiKcMyy1+pfkZ3YYYJkxl/YdUYmb8Uo2/VxBSLEBxxCBtUZ/a
         E9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=85xt8gfUylWcpZOgKCioxv2QzHKT4Z0Id5Y79nmNe0g=;
        b=j9DRfiU3iW32lhBOatj1s5j+MJV63A027BcC4vImBb/PXcTmZ011jTd2+IZfGkBywU
         5Ov9GhL2IUv5Ds0ud5VaHxz27dZJtz1YvsKyjPw17QFg5Z9QUpM01jArsFQxlAFmxE5O
         kB936PneLVv+2QLskJhTCxTHk8olKGSB0g6TooH4hn5mQOJ40D+2XdG0Wa0sQKWdbBOH
         T7dhN4koDqSn07mObD64qe+DilpYMC9oSw1pU2VBg1WdPFKenMKKJTIByHGFQLfghDn6
         l3POCYc07IpsuQ1PAlXIhpgC6TE9vdyWSz5s4/3g2yKLmHWS55ExughNlmp4Zdsf+qTt
         S7Sg==
X-Gm-Message-State: AJIora9Bq/nY0XFWx+sGU12occSWduKLCaQHcnhj4vAwPeP2Ibq36cKy
        pp7nWBokZM05soelvdG72W8ja/NEj1qcsooArVkdwg==
X-Google-Smtp-Source: AGRyM1tgbpIUtnl6G41e9mMCxrIpjAX5Mn906pDW+/tjH/RghZlCNr9dPs9zTQlMxKYT7qaUntqPtN/W6f5EkG1sqw8=
X-Received: by 2002:a7b:ce86:0:b0:3a0:48a1:d0c6 with SMTP id
 q6-20020a7bce86000000b003a048a1d0c6mr33506068wmj.67.1656970756031; Mon, 04
 Jul 2022 14:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220612061508.1449636-1-asmadeus@codewreck.org>
In-Reply-To: <20220612061508.1449636-1-asmadeus@codewreck.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 4 Jul 2022 14:39:05 -0700
Message-ID: <CAP-5=fXgNTW1eXRZhz-s_AfP+v1Oyx1zdksm-Q0B4YVPAgjKxw@mail.gmail.com>
Subject: Re: [PATCH] perf parse: Allow names to start with digits
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 11:16 PM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
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
> @@ -211,7 +211,7 @@ bpf_source  [^,{}]+\.c[a-zA-Z0-9._]*
>  num_dec                [0-9]+
>  num_hex                0x[a-fA-F0-9]+
>  num_raw_hex    [a-fA-F0-9]+
> -name           [a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]!]*
> +name           [a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?.\[\]!]*

Perhaps this would be cleaner as:
name           [a-zA-Z0-9_*?\[\]!]+
except that would allow a name to start with an exclamation. Would
that be an issue?

Thanks,
Ian

>  name_tag       [\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
>  name_minus     [a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
>  drv_cfg_term   [a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
> --
> 2.36.1
>
