Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94255B2412
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiIHQ5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiIHQ4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:56:34 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DFB476D0;
        Thu,  8 Sep 2022 09:55:52 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id c2so18502839plo.3;
        Thu, 08 Sep 2022 09:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=4gnfYGW7hkW/eLBVsc13buXA0Lfe7uhj1byHBiJTDRI=;
        b=Ohbh45gaMmMICGgFtp37FFHwFP1Nw8eZ4Sv60CgaGDJO8DIuodhXzaxmpkHihlDr/V
         RSWLmSXwnN4IktZP0deSc+RC6V3YbaCDyTUlnzNOcbOZQaI0l5dcnhTcPRwz9gwYs1Q/
         +R1Bem68MiC5KpYF86rVuWBA7FWsVb4WVZi05w+qLuimvn5tsvbPJ8/QD+oWiuznZYd3
         6EfLysn+2MhEARAfR092UOZyg78k/OAfpNyMtygsi+foQkF+4YX/S6Ko8HE+jyFrQ8pu
         TfEInkk5GbOnG0iPtEKMOMSSZT0VVwzv4eCZDSBaNUHKoGXVBPQrkpYdDcamdyKVKnlV
         VJoA==
X-Gm-Message-State: ACgBeo3kLtqShlAvtJEjRW1sQmO3AHANNB5fvvgrHDT73Ov4lGnpKvo9
        9wvKDnAxL3ByfrbwqNEIHGI=
X-Google-Smtp-Source: AA6agR6l1KwW3pBEJAIDjWnoVF/aSh6gjMWbcDfanQE4KJyUAulbcj25bFqBdc1hXVQ0Ohdnmqj6+w==
X-Received: by 2002:a17:903:2449:b0:174:49c0:542 with SMTP id l9-20020a170903244900b0017449c00542mr9593480pls.113.1662656151659;
        Thu, 08 Sep 2022 09:55:51 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:71db:3cdf:3590:2e95? ([2620:15c:211:201:71db:3cdf:3590:2e95])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b00176d4b093e1sm6545631plc.16.2022.09.08.09.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 09:55:50 -0700 (PDT)
Message-ID: <28bd97af-2932-f75e-ecf5-6c5e42f8d7ad@acm.org>
Date:   Thu, 8 Sep 2022 09:55:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/1] tracing: Fix compile error in trace_array calls
 when TRACING is disabled
Content-Language: en-US
To:     Arun Easi <aeasi@marvell.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Petersen <martin.petersen@oracle.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, GR-QLogic-Storage-Upstream@marvell.com
References: <20220907233308.4153-1-aeasi@marvell.com>
 <20220907233308.4153-2-aeasi@marvell.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220907233308.4153-2-aeasi@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/22 16:33, Arun Easi wrote:
> diff --git a/include/linux/trace.h b/include/linux/trace.h
> index bf16961..b5e16e4 100644
> --- a/include/linux/trace.h
> +++ b/include/linux/trace.h
> @@ -2,8 +2,6 @@
>   #ifndef _LINUX_TRACE_H
>   #define _LINUX_TRACE_H
>   
> -#ifdef CONFIG_TRACING
> -
>   #define TRACE_EXPORT_FUNCTION	BIT(0)
>   #define TRACE_EXPORT_EVENT	BIT(1)
>   #define TRACE_EXPORT_MARKER	BIT(2)
> @@ -28,6 +26,8 @@ struct trace_export {
>   	int flags;
>   };
>   
> +#ifdef CONFIG_TRACING
> +
>   int register_ftrace_export(struct trace_export *export);
>   int unregister_ftrace_export(struct trace_export *export);
>   
> @@ -48,6 +48,38 @@ void osnoise_arch_unregister(void);
>   void osnoise_trace_irq_entry(int id);
>   void osnoise_trace_irq_exit(int id, const char *desc);
>   
> +#else /* CONFIG_TRACING */
> +static inline int register_ftrace_export(struct trace_export *export)
> +{
> +	return -EINVAL;
> +}
> +static inline int unregister_ftrace_export(struct trace_export *export)
> +{
> +	return 0;
> +}
> +static inline void trace_printk_init_buffers(void)
> +{
> +}
> +static inline int trace_array_printk(struct trace_array *tr, unsigned long ip,
> +				     const char *fmt, ...)
> +{
> +	return 0;
> +}
> +static inline int trace_array_init_printk(struct trace_array *tr)
> +{
> +	return -EINVAL;
> +}
> +static inline void trace_array_put(struct trace_array *tr)
> +{
> +}
> +static inline struct trace_array *trace_array_get_by_name(const char *name)
> +{
> +	return NULL;
> +}
> +static inline int trace_array_destroy(struct trace_array *tr)
> +{
> +	return 0;
> +}
>   #endif	/* CONFIG_TRACING */
>   
>   #endif	/* _LINUX_TRACE_H */

Thanks for having addressed my feedback. The above looks good to me. 
However, I'm not very familiar with the tracing framework so I will 
leave it to others to formally review this patch.

Thanks,

Bart.
