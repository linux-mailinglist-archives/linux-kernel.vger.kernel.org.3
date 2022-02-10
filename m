Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AF74B078F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbiBJHw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:52:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236615AbiBJHwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:52:25 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504261080;
        Wed,  9 Feb 2022 23:52:26 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id y22so1279341eju.9;
        Wed, 09 Feb 2022 23:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kPf2sZmm3KzS9i74yQ9nkr8+GPeqJ7r3m+kQq3HmOzM=;
        b=XUoSYYCnEOFr+/Eug0X0hNZJjYQC+snDUu6tyY1n/y/OzxugZsf8PGqYKmsLe7YqGi
         JxZeeVuwRBrKW/Xa2FMK3iAVWMMg0T8nI+M9YGxWPtxRD3iOxzwllVTEycK1eeC3nzTR
         6ksU0bo5Swwag963W2sQh9GoiL1Mp+JH0H72tLBTNGYymIhQfbuYhXvRSCWJObJ+Imzx
         o1KocaeFL3N3b+azqkO7/6GxXw3dhzh61zgofml13dZwx4TRgbMZVDshQBMMoP77xwuN
         mMCSDxV0HYxXEVKBH4zysgdazdfvCcAEMzBixLsHxZ+6KioCpCkKatZNUpCpKfGQMeFj
         ySew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kPf2sZmm3KzS9i74yQ9nkr8+GPeqJ7r3m+kQq3HmOzM=;
        b=QMYa1fJbTWraKVstEEPrVXt8O3yBX+2/XG9i0OiheiXfXV0Sx68ed7ayS1chc0w2f1
         C7M2dzAfAY5hITLYvshRkKQI83nlcMkJnxOcRfVTkieEkjHdLZ2bbLZ9Wt2paAHK3PLO
         35ODmA1UbvJirxWZlgDg6sHL9FpiT7pbOrkk/LNaXldw5n1LD8s1q/cYjwYgGRTbzHm2
         J/VznA8LyUx5gIHQKVje2MS4KUw9HDimJZrDuDIiU/6qfPgfQhxd3V7EphYCS0Yw8/kD
         wOvlwkGuNLX8jAd5EwAIYe2xIIr1rPWq/NP8e13HuCGsdt1sT5V7HVy5ojTl2gWd5bzC
         i/uw==
X-Gm-Message-State: AOAM533aQ1PGEEFiJ8egSGE7w614guYOZ+blWfw9n5QjR7WPG643HzvH
        a7fcUfyP4TARzkX/1qtp/F4=
X-Google-Smtp-Source: ABdhPJxRyZvTb2CR1V0Na9h2ZlpeJGwvvgCnWRXnDt5rhHTs+WPe6+Jf8ykOYYxj1JK4HxAuBnKGdQ==
X-Received: by 2002:a17:907:961c:: with SMTP id gb28mr5471521ejc.725.1644479544760;
        Wed, 09 Feb 2022 23:52:24 -0800 (PST)
Received: from krava ([2a00:102a:5010:3235:47fb:6193:ef68:761d])
        by smtp.gmail.com with ESMTPSA id i9sm7847130eda.35.2022.02.09.23.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 23:52:24 -0800 (PST)
Date:   Thu, 10 Feb 2022 08:52:20 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Eelco Chaudron <echaudro@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf scripting python: expose symbol offset and source
 information
Message-ID: <YgTENKDfI/2+DZhJ@krava>
References: <164389947295.382219.17025049915445689710.stgit@wsfd-netdev64.ntdv.lab.eng.bos.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164389947295.382219.17025049915445689710.stgit@wsfd-netdev64.ntdv.lab.eng.bos.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 09:44:33AM -0500, Eelco Chaudron wrote:
> This change adds the symbol offset to the data exported for each
> call-chain entry. This can not be calculated from the script and
> only the ip value, and no related mmap information.
> 
> In addition, also export the source file and line information, if
> available, to avoid an external lookup if this information is needed.

could you please update Documentation/perf-script-python.txt with that?

any example script under scripts/python would be great

thanks,
jirka

> 
> Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
> ---
>  .../util/scripting-engines/trace-event-python.c    |   42 ++++++++++++++------
>  1 file changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index e752e1f4a5f0..0f392b4ff663 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -392,6 +392,18 @@ static const char *get_dsoname(struct map *map)
>  	return dsoname;
>  }
>  
> +static unsigned long get_offset(struct symbol *sym, struct addr_location *al)
> +{
> +	unsigned long offset;
> +
> +	if (al->addr < sym->end)
> +		offset = al->addr - sym->start;
> +	else
> +		offset = al->addr - al->map->start - sym->start;
> +
> +	return offset;
> +}
> +
>  static PyObject *python_process_callchain(struct perf_sample *sample,
>  					 struct evsel *evsel,
>  					 struct addr_location *al)
> @@ -443,6 +455,24 @@ static PyObject *python_process_callchain(struct perf_sample *sample,
>  					_PyUnicode_FromStringAndSize(node->ms.sym->name,
>  							node->ms.sym->namelen));
>  			pydict_set_item_string_decref(pyelem, "sym", pysym);
> +
> +			if (node->ms.map) {
> +				struct map *map = node->ms.map;
> +				struct addr_location node_al;
> +				unsigned long offset;
> +
> +				node_al.addr = map->map_ip(map, node->ip);
> +				node_al.map  = map;
> +				offset = get_offset(node->ms.sym, &node_al);
> +
> +				pydict_set_item_string_decref(
> +					pyelem, "sym_off",
> +					PyLong_FromUnsignedLongLong(offset));
> +			}
> +			if (node->srcline && strcmp(":0", node->srcline))
> +				pydict_set_item_string_decref(
> +					pyelem, "sym_srcline",
> +					_PyUnicode_FromString(node->srcline));

nit missing { } for multiline if code

>  		}
>  
>  		if (node->ms.map) {
> @@ -520,18 +550,6 @@ static PyObject *python_process_brstack(struct perf_sample *sample,
>  	return pylist;
>  }
>  
> -static unsigned long get_offset(struct symbol *sym, struct addr_location *al)
> -{
> -	unsigned long offset;
> -
> -	if (al->addr < sym->end)
> -		offset = al->addr - sym->start;
> -	else
> -		offset = al->addr - al->map->start - sym->start;
> -
> -	return offset;
> -}
> -
>  static int get_symoff(struct symbol *sym, struct addr_location *al,
>  		      bool print_off, char *bf, int size)
>  {
> 
