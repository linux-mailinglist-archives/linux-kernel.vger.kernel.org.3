Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA07468BA9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbhLEPRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:17:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27640 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235486AbhLEPRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638717231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kFHqY4WvaLPPdAitwIbOAjCJRLRq0SKgR+vsKb+KShY=;
        b=ImRb2J4HAqmP2DgFSB6quaSSb8QeaJLE9RTXAQemY+y/IKT6bjZ7DlRDAOJYnvEDeV9bdS
        6rzZdYcEw4t/vk3GG0nnPeDWv0nAeNWed5wUfQ4TiCBcm52y3d4SX7r9cDX18JnXB/Yki0
        p5ACE48hRpcr4tY16N3f2FFne389U+k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-7wEj02CyNVyoVQZsD08kgQ-1; Sun, 05 Dec 2021 10:13:50 -0500
X-MC-Unique: 7wEj02CyNVyoVQZsD08kgQ-1
Received: by mail-wm1-f70.google.com with SMTP id ay17-20020a05600c1e1100b0033f27b76819so4650444wmb.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 07:13:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kFHqY4WvaLPPdAitwIbOAjCJRLRq0SKgR+vsKb+KShY=;
        b=YsBk6aF+EDDsjeFf/kJlnmXUc0xjs+R2Lrv1MMJnH0CcgttP6cnjbNkUC5Z4zOd8sD
         iLaUAw0f8WgLrK768OkMmMjgNMcZ7hBCtdDyz8YmU5UbNp8Pur6HV2iWIAk4MIQLviKE
         Qdhxi13DRKW3b5YrwRz6JKBZsBByg2rHg25cwAe22vD74/TFgHUhRgmoCmeU/Sg5llgl
         OBN8gLWMqwLIvPKKKDmNHeRagd1xyxgta+jVGQdze52jVwLOWHbPLtI0kqFlPWnZT49i
         J2S+6YLaqPfrJbVx1UfREE5KPHEgkgJHVe04IArlfIiLUajyRNBud5ogxa9kFLxmvMQ1
         Vqcg==
X-Gm-Message-State: AOAM533FiAm26pU5w20TW58DTzN2f3EnkNN+3zLF5Cs/xFfrTFWPE2ZW
        9Gw6ZNWLeU/ngRR0UKkQdjfZs/jqMcRlbWAtCEbQAvpOW6n6/LHu9kd7S3BrM3ccuOZ05kOD1CP
        PXnYStX/kqM0NEQo3fiQ8jXNa
X-Received: by 2002:adf:cc8d:: with SMTP id p13mr36561853wrj.274.1638717229569;
        Sun, 05 Dec 2021 07:13:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxB1FHjqVzHBXz++pNZsHwC5mURaue3xSCvcEI2FgVb9dhHxw/aRQ8vu6ilEeIp126F4WpvgQ==
X-Received: by 2002:adf:cc8d:: with SMTP id p13mr36561837wrj.274.1638717229401;
        Sun, 05 Dec 2021 07:13:49 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id q8sm8527650wrx.71.2021.12.05.07.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 07:13:48 -0800 (PST)
Date:   Sun, 5 Dec 2021 16:13:46 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH v12 13/16] perf record: Extend --threads command line
 option
Message-ID: <YazWyEU9cUabmmYC@krava>
References: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
 <f103a65518a1a41700f739df75f57cb0b46fbf19.1637675515.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f103a65518a1a41700f739df75f57cb0b46fbf19.1637675515.git.alexey.v.bayduraev@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 05:08:09PM +0300, Alexey Bayduraev wrote:

SNIP

> +
>  static int record__parse_threads(const struct option *opt, const char *str, int unset)
>  {
> +	int s;
>  	struct record_opts *opts = opt->value;
>  
> -	if (unset || !str || !strlen(str))
> +	if (unset || !str || !strlen(str)) {
>  		opts->threads_spec = THREAD_SPEC__CPU;
> +	} else {
> +		for (s = 1; s < THREAD_SPEC__MAX; s++) {
> +			if (s == THREAD_SPEC__USER) {
> +				opts->threads_user_spec = strdup(str);

we should bail out if strdup fails

jirka

> +				opts->threads_spec = THREAD_SPEC__USER;
> +				break;
> +			}
> +			if (!strncasecmp(str, thread_spec_tags[s], strlen(thread_spec_tags[s]))) {
> +				opts->threads_spec = s;
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (opts->threads_spec == THREAD_SPEC__USER)
> +		pr_debug("threads_spec: %s\n", opts->threads_user_spec);
> +	else
> +		pr_debug("threads_spec: %s\n", thread_spec_tags[opts->threads_spec]);
>  
>  	return 0;
>  }
> @@ -3263,6 +3327,17 @@ static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_c
>  		set_bit(cpus->map[c], mask->bits);
>  }
>  

SNIP

