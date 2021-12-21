Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968EC47BBD8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbhLUI3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:29:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33553 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233887AbhLUI3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640075387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1W8wUPzbCrAk3S6JCr16h2JbAhwXYjogBXl0aWQ+aYA=;
        b=ekdmnLJmGr2e7MbDAfoczRXaGJsBeFwoV7vI4YEm8+m9Z2nVbqcd3UY82cMjz/B7Bqt/dX
        6i3N40EjWwKDbw7glaPmk1FXf4JONjxOdrJR4YKvkQnIuYaTz4Y4uaMhY/XBzjNzbAxJAU
        8CkSTAZ3VI0KFEidr1i7Mi3zgBQ1aGU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510-FcNTJz8DN1avlpRH9bnprw-1; Tue, 21 Dec 2021 03:29:43 -0500
X-MC-Unique: FcNTJz8DN1avlpRH9bnprw-1
Received: by mail-wr1-f72.google.com with SMTP id a11-20020adffb8b000000b001a0b0f4afe9so4410635wrr.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 00:29:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1W8wUPzbCrAk3S6JCr16h2JbAhwXYjogBXl0aWQ+aYA=;
        b=APmo6/UkBmrIG+/PyCaU2STUImhgfp0/6or3xMRi8wVWtcMmuTRPIzcB0zNc1HGE+u
         KThktsuZUhUonNlDSXIvmnsV2BGOwpc9JsnEWYNbuGCvw9zZHFfZgKO95q+LD8hU+kdF
         p23KPDEcvK/GKMOtKNXuuNkUQU4Jb9HQwIustiCOSdpX/Y1KT336K6SmLeZhH473xbU6
         9PLP97+tjDvs0lIfNYglIW8evEeflh0pA+Ar7ozBTE1alt3jdX5jXbQDcl6udQtNvdTP
         vZ66v5kyscmiH6YkTMtkd1aDKvQwysPMr2GQdqDVUk9pyzysGDqfSran7fIzkQCdDCyx
         HKNg==
X-Gm-Message-State: AOAM530QUbMz98ctWqM/Nbzh4TQ3MsM2Vfba/GKnK2kiqhmzK8r9oyAY
        S0+AE5hzaMyn5V5pJdNSH+I7ebxvR7npfKjAsI5ldhh63MBimnR5vNpBq0sIn6RD8ZxMmtZktuE
        4LDA8nC9X4hWrqZo+aLu3Qr1s
X-Received: by 2002:adf:a18b:: with SMTP id u11mr1589685wru.397.1640075382633;
        Tue, 21 Dec 2021 00:29:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUJYDFM/617lziZE38H9pnQj4BM0jN9B5H2PlbUCKbwrgOCkxAXXoYFP0QilZjvohv3vUfaw==
X-Received: by 2002:adf:a18b:: with SMTP id u11mr1589672wru.397.1640075382492;
        Tue, 21 Dec 2021 00:29:42 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id b2sm9895293wrd.35.2021.12.21.00.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 00:29:42 -0800 (PST)
Date:   Tue, 21 Dec 2021 09:29:40 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf expr: Fix return value of ids__new
Message-ID: <YcGQdFQ7tjdiFoJ5@krava>
References: <20211214011030.20200-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214011030.20200-1-linmq006@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 01:10:27AM +0000, Miaoqian Lin wrote:
> callers of ids__new() function only do NULL checking for the return
> value. ids__new() calles hashmap__new(), which may return
> ERR_PTR(-ENOMEM). Instead of changing the checking one-by-one.
> return NULL instead of ERR_PTR(-ENOMEM) to keep
> consistent.
> 
> ---
> Changes in v3:
> fix compilation error and add tags.

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> Tested-by: German Gomez <german.gomez@arm.com>
> Reviewed-by: German Gomez <german.gomez@arm.com>
> ---
>  tools/perf/util/expr.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 1d532b9fed29..f225247acc01 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -12,6 +12,7 @@
>  #include "expr-bison.h"
>  #include "expr-flex.h"
>  #include "smt.h"
> +#include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/zalloc.h>
>  #include <ctype.h>
> @@ -65,7 +66,12 @@ static bool key_equal(const void *key1, const void *key2,
>  
>  struct hashmap *ids__new(void)
>  {
> -	return hashmap__new(key_hash, key_equal, NULL);
> +	struct hashmap *hash;
> +
> +	hash = hashmap__new(key_hash, key_equal, NULL);
> +	if (IS_ERR(hash))
> +		return NULL;
> +	return hash;
>  }
>  
>  void ids__free(struct hashmap *ids)
> -- 
> 2.17.1
> 

