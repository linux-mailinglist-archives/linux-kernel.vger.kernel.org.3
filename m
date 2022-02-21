Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7194BEC42
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 22:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbiBUVPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 16:15:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbiBUVO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:14:59 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0471623BE3;
        Mon, 21 Feb 2022 13:14:36 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id gb39so36468577ejc.1;
        Mon, 21 Feb 2022 13:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g7mw0l92vfH8JBkO22iszRnQuSIydwt1+m601yxyXUo=;
        b=U0Rvz4sRnYPkspaxX+xkhxMaUeeqwGKwqR147NeaOJxt7xyy3lBf/KwWAh1LImA1jx
         3Hkkt1SFZTf1jy6Orwda5tmTIgAFulqVSz0AwcU4IB+19sKODFCMLQfc1Fjw9b9zaEfY
         GiK0TcGM7v8+cqvjXZmoVNyOwZW4LWYbL54+2aNxN8x4PFDxSXydVDRrqycn+wuawXAS
         mtgyIEPRtRh+9/orLEsAVIO1BjgRjCl0YuvMJkcNfJwaCf8pNV/NHY/sctZKKXGlOKbt
         q2PMdlPlUKWMNbLvCOfcwTxLe51uCeIs+dEHQ6u03nnvMBMgNxOG80tiUePDMddak1So
         u/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g7mw0l92vfH8JBkO22iszRnQuSIydwt1+m601yxyXUo=;
        b=DX//7zxVMc672bIZCtlduUNpMInaO45adzRUHC0pXVONpmoWI5xJE0r7NPVvmoBslT
         qsucK1jFHnofWGQtxH3oYcCATq54SyBqEhmkF1cTCJpzzhC6UhFnkl1ISYO13fVJ4BdI
         YAQCDlAe1hxOed5uPudhsyOeW8eFGgRA++2FjFg5OhnpP5UjKwtzToaFzOwc/6OGz6ms
         8pxcTGZKWx3Gh4D+k3gWttz82/uedkIHReCiQtpRC8AS15JUw+EMg/Dy32kNTPAcGEa4
         tbjRvFENcNnoBwLNfp4yOlZ9hpAZP4mcTUCanicq0HOgFRXoo4jpjZa28JGuS79Olv4c
         GhHA==
X-Gm-Message-State: AOAM533dj8PZ1CbvDPKajYDtZ/dipA4hat4EQdt+SLaWQeNe1KXs1tNs
        5ftG4kR3y3uO7KrjVsrIMac=
X-Google-Smtp-Source: ABdhPJz9AeDiOmv4PDMn7D8rSrzZSPOjNsNe23d6gXNlFYzG5sa1vngsWH684VdFS94pqNoQnEy9ow==
X-Received: by 2002:a17:906:d7aa:b0:6cf:1fb3:2986 with SMTP id pk10-20020a170906d7aa00b006cf1fb32986mr17406202ejb.594.1645478074401;
        Mon, 21 Feb 2022 13:14:34 -0800 (PST)
Received: from krava ([2a00:102a:500a:4c07:3c4e:83d8:8cd9:974f])
        by smtp.gmail.com with ESMTPSA id qf12sm5473295ejc.54.2022.02.21.13.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 13:14:34 -0800 (PST)
Date:   Mon, 21 Feb 2022 22:14:31 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Mahmoud Abumandour <ma.mandourr@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf data: don't mention --to-ctf if it's not supported
Message-ID: <YhQAt+iSkc2VcvEP@krava>
References: <20220220113952.138280-1-ma.mandourr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220220113952.138280-1-ma.mandourr@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2022 at 01:39:52PM +0200, Mahmoud Abumandour wrote:
> From: Mahmoud Mandour <ma.mandourr@gmail.com>
> 
> The option `--to-ctf` is only available when perf has libbabeltrace
> support. Hence, on error, we shouldn't state that user must include
> `--to-ctf` unless it's supported.
> 
> The only user-visible change for this commit is that when `perf` is not
> configured to support libbabeltrace, the user is only prompted to
> provide the `--to-json` option instead of bothe `--to-json` and
> `--to-ctf`.
> 
> Signed-off-by: Mahmoud Mandour <ma.mandourr@gmail.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/builtin-data.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
> index b7f9dc85a407..c22d82d2a73c 100644
> --- a/tools/perf/builtin-data.c
> +++ b/tools/perf/builtin-data.c
> @@ -62,10 +62,17 @@ static int cmd_data_convert(int argc, const char **argv)
>  		pr_err("You cannot specify both --to-ctf and --to-json.\n");
>  		return -1;
>  	}
> +#ifdef HAVE_LIBBABELTRACE_SUPPORT
>  	if (!to_json && !to_ctf) {
>  		pr_err("You must specify one of --to-ctf or --to-json.\n");
>  		return -1;
>  	}
> +#else
> +	if (!to_json) {
> +		pr_err("You must specify --to-json.\n");
> +	return -1;
> +}
> +#endif
>  
>  	if (to_json)
>  		return bt_convert__perf2json(input_name, to_json, &opts);
> -- 
> 2.30.2
> 
