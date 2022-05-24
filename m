Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C345331CD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbiEXTgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240969AbiEXTf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:35:59 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45DE71D81
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:35:57 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso3128667pjg.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dOQqJipjB7XvkB7vBfeZvym+R0VGemcRWEp42KC5/do=;
        b=Wq7LLslOzGJL9kfe/q0uEybu7QvXvdl07qEMXiycgbsX9H9w3un7Yb2KlWsbaNeKvx
         GYPng7tBLKJcK6DC6kN1Z8dZFR1A3GlGf3LnEBIErRAyJNsYJ6HhqvP25x5Nh+/rj8WK
         L2hGpCfJG6hzW74j8YeR5giyHeZZygYiKthnGtFU4QQtOSLhRgFeonMSEvR0mvuF26DW
         dfyQnKd69M1XN6ZumpMXiMbK9jzwTgDvwJf6towsdC39T3bHQ1LJURjpkbakrTLf2yie
         yxmtFWuKf5UvAewl3hRiF43th2wRFmIk883p00PDm7W+wgNXUgu4maXbeIOQfdpV1P70
         UZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dOQqJipjB7XvkB7vBfeZvym+R0VGemcRWEp42KC5/do=;
        b=ZdkNKAU6uUmPk/fDK/hOjYzSwY7icVfYlH3CnhkliaqPPkuKl59vJd9WuRkoP/qt1s
         X37i1XeTPERbvULNK+Yf5DDPTkAOhk3MCnHhTZpHxIXKU+rjhrLxwTCvWscbP6C49pVV
         1T8aZGWZz8tNAv7JXVKZKUbFxR1dT1ykvkyYd1HB6KpBQt+hcCf8i1GVVY77dTm/TfHx
         yB0qq0nLv3w+AuENu1+YgOobsCYtc9jY7Kh3sm52XB1D16Qffz992q/BLZicrvrLBweP
         rGx3MRVhtWmNTm5Tn62GItls2cAe1+AtArzI9shBo55LMQizREzpT8BJd6Zlx3M7Ws0A
         vpvw==
X-Gm-Message-State: AOAM533ubW0dcttUg/MUJS3xrSugaiXXTUoje1IsSqG4m9SwPUITDKZN
        H+2iD6zRejGpPBO0vrN3Ye10sIJ0JAiSag==
X-Google-Smtp-Source: ABdhPJyH1Zkdu32w5va1hZu7bLMZ9V1k6vip5S6YIxb0m8wD8/tNl4g58vAsT46JwafkST2fDpJmig==
X-Received: by 2002:a17:90b:3284:b0:1e0:97e7:2e4d with SMTP id ks4-20020a17090b328400b001e097e72e4dmr1657886pjb.187.1653420956940;
        Tue, 24 May 2022 12:35:56 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w15-20020a63b74f000000b003f26c2f583asm6842111pgt.61.2022.05.24.12.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 12:35:56 -0700 (PDT)
Date:   Tue, 24 May 2022 19:35:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com, mst@redhat.com,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        pbonzini@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] virtio_balloon: Introduce memory recover
Message-ID: <Yo0zmP28FqpivlxF@google.com>
References: <20220520070648.1794132-1-pizhenwei@bytedance.com>
 <20220520070648.1794132-4-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520070648.1794132-4-pizhenwei@bytedance.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022, zhenwei pi wrote:
> @@ -59,6 +60,12 @@ enum virtio_balloon_config_read {
>  	VIRTIO_BALLOON_CONFIG_READ_CMD_ID = 0,
>  };
>  
> +/* the request body to commucate with host side */
> +struct __virtio_balloon_recover {
> +	struct virtio_balloon_recover vbr;
> +	__virtio32 pfns[VIRTIO_BALLOON_PAGES_PER_PAGE];

I assume this is copied from virtio_balloon.pfns, which also uses __virtio32, but
isn't that horribly broken?  PFNs are 'unsigned long', i.e. 64 bits on 64-bit kernels.
x86-64 at least most definitely generates 64-bit PFNs.  Unless there's magic I'm
missing, page_to_balloon_pfn() will truncate PFNs and feed the host bad info.

> @@ -494,6 +511,198 @@ static void update_balloon_size_func(struct work_struct *work)
>  		queue_work(system_freezable_wq, work);
>  }
>  
> +/*
> + * virtballoon_memory_failure - notified by memory failure, try to fix the
> + *                              corrupted page.
> + * The memory failure notifier is designed to call back when the kernel handled
> + * successfully only, WARN_ON_ONCE on the unlikely condition to find out any
> + * error(memory error handling is a best effort, not 100% coverd).
> + */
> +static int virtballoon_memory_failure(struct notifier_block *notifier,
> +				      unsigned long pfn, void *parm)
> +{
> +	struct virtio_balloon *vb = container_of(notifier, struct virtio_balloon,
> +						 memory_failure_nb);
> +	struct page *page;
> +	struct __virtio_balloon_recover *out_vbr;
> +	struct scatterlist sg;
> +	unsigned long flags;
> +	int err;
> +
> +	page = pfn_to_online_page(pfn);
> +	if (WARN_ON_ONCE(!page))
> +		return NOTIFY_DONE;
> +
> +	if (PageHuge(page))
> +		return NOTIFY_DONE;
> +
> +	if (WARN_ON_ONCE(!PageHWPoison(page)))
> +		return NOTIFY_DONE;
> +
> +	if (WARN_ON_ONCE(page_count(page) != 1))
> +		return NOTIFY_DONE;
> +
> +	get_page(page); /* balloon reference */
> +
> +	out_vbr = kzalloc(sizeof(*out_vbr), GFP_KERNEL);
> +	if (WARN_ON_ONCE(!out_vbr))
> +		return NOTIFY_BAD;

Not that it truly matters, but won't failure at this point leak the poisoned page?
