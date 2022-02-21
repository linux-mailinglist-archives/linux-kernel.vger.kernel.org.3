Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE9F4BEB54
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbiBUTrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 14:47:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiBUTrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:47:02 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAFC2250E;
        Mon, 21 Feb 2022 11:46:37 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x5so31445021edd.11;
        Mon, 21 Feb 2022 11:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qhLO7zpU6Ok1BEkgLsF/1jPyZK2Xr++VMNkWs/naTT0=;
        b=GuFOY9zOpmwiZ6qsWzV3Ob4Q2vJx6q8tyl62PY7KwZ1u/rFrzPOsNXu0nSEzzGajxy
         B2vLVHRCnvb+4R/qGo0rKWFBlgQXUIC460Hc3Z++P67Mv9L8httjzBTCOX+ND3srXtDQ
         OF5HJdURvvhpCFLwztlIsGFBewSiT5bh7BGoQXR1zW7XNh8eDKZUjTXbybTQkLFHOKbs
         IcrFRrwPspSNfTkDsP9Z/Nk/mr2gRgiWJyp2/g2VQa9GAM0JZtX9w9YeUGKBb9pQaUdi
         l4MHL88sTGORywWH51uSGjnyua70UxlZ1ECuDOPVjwKioyK2a2pzuHSeF9JEMK/v8KPh
         2M3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qhLO7zpU6Ok1BEkgLsF/1jPyZK2Xr++VMNkWs/naTT0=;
        b=51AhXKp+hxtQROzLRd7MSHX2dxsyRQpDTcQn85Sfx+RKrAPSAVwtlKSUJCjZruysNg
         zrY/6efvwXAVdQ3oXlFpwDzaQRJPRtmffSprI7B53qj/0H7/E2Y4czCiFssuDUjgPyhB
         kkzdqlc5CbT3V4kpvvgvXZ2Ck7r3U+j4Y4jfAetoomnuAn6dWKL0u1QB2htBsdeAQlFn
         TsFIpQ3UjtPdnuvO1Bv7ndKqi9hpILm0rUo4RwNHyUYWqkIoac+cshlW2mAo+pEj9Pxl
         ZBEX3mOf7Stvg7gcPsmc73wPI+7rGI8qEiIU/iF0OIpHHyFN8/fim+YyahjJuveXr2re
         L5Wg==
X-Gm-Message-State: AOAM531oQ0iLFpbQrlJx1g0nWs2ljPGjE/J1HyUECR0Hu8/nERB8gr5W
        EFJWMXd91rCSLWYL9q4uHrdf8gap6LSJow==
X-Google-Smtp-Source: ABdhPJyN4rN3M9n8q76WpHH0H4narSI5TIdnq54Do9wsBk1QrJfDCLLfw9VrgLg85Q9iWq5VmE7Kdg==
X-Received: by 2002:a05:6402:2805:b0:405:f6a8:f74 with SMTP id h5-20020a056402280500b00405f6a80f74mr22516090ede.241.1645472795822;
        Mon, 21 Feb 2022 11:46:35 -0800 (PST)
Received: from krava ([2a00:102a:500a:4c07:3c4e:83d8:8cd9:974f])
        by smtp.gmail.com with ESMTPSA id nc40sm3198715ejc.127.2022.02.21.11.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 11:46:35 -0800 (PST)
Date:   Mon, 21 Feb 2022 20:46:32 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf script: Fix error when printing 'weight' field
Message-ID: <YhPh5pHMGeP8Arx6@krava>
References: <20220221171707.62960-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221171707.62960-1-german.gomez@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 05:17:06PM +0000, German Gomez wrote:
> In SPE traces the 'weight' field can't be printed in perf-script because
> the 'dummy:u' event doesn't have the WEIGHT attribute set.
> 
> Use evsel__do_check_stype(..) to check this field, as it's done with
> other fields such as "phys_addr".
> 
> Before:
> 
> $ perf record -e arm_spe_0// -- sleep 1
> $ perf script -F event,ip,weight
> Samples for 'dummy:u' event do not have WEIGHT attribute set. Cannot print 'weight' field.
> 
> After:
> 
> $ perf script -F event,ip,weight
>    l1d-access:               12 ffffaf629d4cb320
>    tlb-access:               12 ffffaf629d4cb320
>        memory:               12 ffffaf629d4cb320
> 
> Fixes: b0fde9c6e291 ("perf arm-spe: Add SPE total latency as PERF_SAMPLE_WEIGHT")
> Signed-off-by: German Gomez <german.gomez@arm.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/builtin-script.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 9e032343f..6ce581067 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -463,7 +463,7 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
>  		return -EINVAL;
>  
>  	if (PRINT_FIELD(WEIGHT) &&
> -	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT_TYPE, "WEIGHT", PERF_OUTPUT_WEIGHT))
> +	    evsel__do_check_stype(evsel, PERF_SAMPLE_WEIGHT_TYPE, "WEIGHT", PERF_OUTPUT_WEIGHT, allow_user_set))
>  		return -EINVAL;
>  
>  	if (PRINT_FIELD(SYM) &&
> -- 
> 2.25.1
> 
