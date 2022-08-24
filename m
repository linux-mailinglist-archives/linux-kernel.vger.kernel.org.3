Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D70259F520
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbiHXIY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbiHXIYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:24:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C468E98A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661329458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Alnumo20Oy3ca2IuzGzDSmL567uiguE1m7emVxPRSkQ=;
        b=J7HEcWEkZxu1Vu4ZsUANUZq9cuoxyGxD5N+USr1l7+lQa0Wkq8lrC9DUt1CaF0gfmXvDAx
        NQ7zfJDKqRNwOVkW3JJ6kVv8PuWzGAoVPIpPZqnYmY/R0fiJBG4K7d2ZFXfwURTFmvmGcu
        j42bsVPGdP7tDEkppRu4BP5bvDoqszA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-61-ZQSLMWKyNkKIYuVLX43StQ-1; Wed, 24 Aug 2022 04:24:17 -0400
X-MC-Unique: ZQSLMWKyNkKIYuVLX43StQ-1
Received: by mail-wm1-f71.google.com with SMTP id c64-20020a1c3543000000b003a61987ffb3so9126476wma.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Alnumo20Oy3ca2IuzGzDSmL567uiguE1m7emVxPRSkQ=;
        b=YgSphDCi8+04Ka1YPBAChPWkX1/eZj/ONEf2DLbwdtYLXeURfJERvtO2BsJACR891h
         AYFFXIaKH+flHFO1wZQZa+Y8Q1shya391jf06F5+T5pJItI9gn72OGwWg7bnYIgrFaTO
         rEeJkAEWGHbclAFoMzirRmxMi1xU0nu2IPa1SGCjS3apJXUXQavpmX9dPkEOzcG2vJiD
         Gx3j+jvUmatZrt80V9UkpG0DtHfUTIaSMzoTkqIrbvM9hTlrbX+32DJytKHlFrqLHjwG
         Mfx1pnAembcDR4Lx52B9XBT05XYWp2+pT/+j+O4k8anUCcO3vp6ZcfNyRUIDgVVZiMAx
         qLjg==
X-Gm-Message-State: ACgBeo3pw8+kzyw3OggiqCaL127Bx2gPmbx/vqjnzBka254FKANVVXTX
        Zkl/hSxPf/f/TPBPZd+07OL9tEre7kreIpayl3TKB5skbtBfRT7pahpQVjkFXjNGq5/ZSK2QE31
        l7iCAf76zuQaLQVY6QKJ7C2UX
X-Received: by 2002:adf:eb4c:0:b0:220:6aaf:ef5e with SMTP id u12-20020adfeb4c000000b002206aafef5emr14863556wrn.488.1661329456457;
        Wed, 24 Aug 2022 01:24:16 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4DRt/CvtfFa7EIJB4D+MrT0BEPBR42D92q1aP42xUNrGosIyBAbzKLmB5DsyKJdDueEmCfaw==
X-Received: by 2002:adf:eb4c:0:b0:220:6aaf:ef5e with SMTP id u12-20020adfeb4c000000b002206aafef5emr14863538wrn.488.1661329456139;
        Wed, 24 Aug 2022 01:24:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:c500:5445:cf40:2e32:6e73? (p200300cbc707c5005445cf402e326e73.dip0.t-ipconnect.de. [2003:cb:c707:c500:5445:cf40:2e32:6e73])
        by smtp.gmail.com with ESMTPSA id j30-20020a05600c1c1e00b003a31fd05e0fsm6646867wms.2.2022.08.24.01.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 01:24:15 -0700 (PDT)
Message-ID: <e5223895-6319-1911-28bf-09449ded96c9@redhat.com>
Date:   Wed, 24 Aug 2022 10:24:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] mm: slince possible data races about pgdat->kswapd
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     muchun.song@linux.dev, linux-kernel@vger.kernel.org
References: <20220824071909.192535-1-wangkefeng.wang@huawei.com>
 <20220824071909.192535-2-wangkefeng.wang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220824071909.192535-2-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.08.22 09:19, Kefeng Wang wrote:
> The pgdat->kswapd could be accessed concurrently by kswapd_run() and
> kcompactd(), it don't be protected by any lock, which could leads to
> data races, adding READ/WRITE_ONCE() to slince it.

Okay, I think this patch here makes it clearer that we really just want
proper synchronization instead of hacking around it.

What speaks against protecting pgdat->kswapd this using some proper
locking primitive?

> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/compaction.c | 4 +++-
>  mm/vmscan.c     | 8 ++++----
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 640fa76228dd..aa1cfe47f046 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1983,7 +1983,9 @@ static inline bool is_via_compact_memory(int order)
>  
>  static bool kswapd_is_running(pg_data_t *pgdat)
>  {
> -	return pgdat->kswapd && task_is_running(pgdat->kswapd);
> +	struct task_struct *t = READ_ONCE(pgdat->kswapd);
> +
> +	return t && task_is_running(t);
>  }
>  
>  /*
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 08c6497f76c3..65b19ca8c8ee 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4644,7 +4644,7 @@ void kswapd_run(int nid)
>  	pg_data_t *pgdat = NODE_DATA(nid);
>  	struct task_struct *t;
>  
> -	if (pgdat->kswapd)
> +	if (READ_ONCE(pgdat->kswapd))
>  		return;
>  
>  	t = kthread_run(kswapd, pgdat, "kswapd%d", nid);
> @@ -4653,7 +4653,7 @@ void kswapd_run(int nid)
>  		BUG_ON(system_state < SYSTEM_RUNNING);
>  		pr_err("Failed to start kswapd on node %d\n", nid);
>  	} else {
> -		pgdat->kswapd = t;
> +		WRITE_ONCE(pgdat->kswapd, t);
>  	}
>  }
>  
> @@ -4663,11 +4663,11 @@ void kswapd_run(int nid)
>   */
>  void kswapd_stop(int nid)
>  {
> -	struct task_struct *kswapd = NODE_DATA(nid)->kswapd;
> +	struct task_struct *kswapd = READ_ONCE(NODE_DATA(nid)->kswapd);
>  
>  	if (kswapd) {
>  		kthread_stop(kswapd);
> -		NODE_DATA(nid)->kswapd = NULL;
> +		WRITE_ONCE(NODE_DATA(nid)->kswapd, NULL);
>  	}
>  }
>  


-- 
Thanks,

David / dhildenb

