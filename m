Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427A44AFF81
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 22:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbiBIVyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 16:54:50 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbiBIVyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:54:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9AD6C0F8692
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 13:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644443689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G4Vjp3ISdYeY8fzvSFlPeRWv5ed2FS1oG8JSf5nd0SI=;
        b=A2FS0a6d2G9hm6VIn5H7aBkDn3D0hSlTMuygs6HOx2WK0rVx/x5v3d/cV+WuROBngCRn3t
        dGvVySRu9z1UhC07sJaoHifQPZAYhE+qjXyI5PZz8nVEJWGUnxpUQgVwyF4oTdpXtQCAuf
        a6iDl+ztYlzTuK/s8ggxTmmPKQpn9IQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-BF1fIRiiOum0U1YYNO03KQ-1; Wed, 09 Feb 2022 16:54:48 -0500
X-MC-Unique: BF1fIRiiOum0U1YYNO03KQ-1
Received: by mail-qt1-f198.google.com with SMTP id w25-20020ac84d19000000b002d2966d66a8so2758143qtv.18
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 13:54:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G4Vjp3ISdYeY8fzvSFlPeRWv5ed2FS1oG8JSf5nd0SI=;
        b=EOIgoP8Ngkb0lVvc9CoS3fo9vTpVhmh6IZFAv/GnoSL7prb9cvNRK70ZiGlE4Uji0E
         Dhwfz+aD6JKZYyRm2MVZrAIoPyQTk58+GWqJav3o1WVOeA1dvEnYSNA4oMdcvBoi7Gfk
         0oYjMq6ZNI11tGtXiXhytaAtBx34/aXWkeUUAe3i1sNRG9UBLAosjSqFH599tH68DfNX
         2OLHM8lR+xFxiBURXAPrQPWlvrS/6Q2y+aMbU3N73eOXDjtMK2DBWQH5CzA/tq2ImhaP
         SXAOccRVZou+GKlljjOV63eg0yqAItWtgSHBsL1F0EGwXaN39NiADcgcSgPtXjglLW0i
         G3FQ==
X-Gm-Message-State: AOAM532389bZMflv1k/kn0jNM89IGOI5xHE6yuYheRoqKATztEI4Bm+y
        oG7thYD66jCiecos055eUKTdsEgFZNSztNcsjTaEa4XsVY1vP5PuT6ZAyOrPEYCgV7w+dU/Ic5D
        +APFDQzl7bKSCsZdwpDsu0UwE
X-Received: by 2002:a05:622a:296:: with SMTP id z22mr2881541qtw.13.1644443688305;
        Wed, 09 Feb 2022 13:54:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFrCPJ+6XKauKxJ7NxYVD3KF/sK7bZF7uFmE4jil0rZlccWMwS7SraCxnnG1yIwW1HMuPj9A==
X-Received: by 2002:a05:622a:296:: with SMTP id z22mr2881528qtw.13.1644443688085;
        Wed, 09 Feb 2022 13:54:48 -0800 (PST)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id d11sm9667430qtd.63.2022.02.09.13.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 13:54:47 -0800 (PST)
Date:   Wed, 9 Feb 2022 15:54:44 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     rostedt@goodmis.org, matthias.bgg@gmail.com,
        akpm@linux-foundation.org, mhiramat@kernel.org, vbabka@suse.cz,
        wangkefeng.wang@huawei.com, linux@rasmusvillemoes.dk,
        keescook@chromium.org, valentin.schneider@arm.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com
Subject: Re: [PATCH] init: Use ktime_us_delta() to make initcall_debug log
 more precise
Message-ID: <20220209215444.sxuxutqwcyisbbld@halaneylaptop>
References: <20220209053350.15771-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209053350.15771-1-mark-pk.tsai@mediatek.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 01:33:50PM +0800, Mark-PK Tsai wrote:
> Use ktime_us_delta() to make the initcall_debug log more precise than
> right shifting the result of ktime_to_ns() by 10 bits.
> 
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---
>  init/main.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 65fa2e41a9c0..c8edcc3029b1 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1246,15 +1246,11 @@ trace_initcall_start_cb(void *data, initcall_t fn)
>  static __init_or_module void
>  trace_initcall_finish_cb(void *data, initcall_t fn, int ret)
>  {
> -	ktime_t *calltime = (ktime_t *)data;
> -	ktime_t delta, rettime;
> -	unsigned long long duration;
> +	ktime_t rettime, *calltime = (ktime_t *)data;
>  
>  	rettime = ktime_get();
> -	delta = ktime_sub(rettime, *calltime);
> -	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
>  	printk(KERN_DEBUG "initcall %pS returned %d after %lld usecs\n",
> -		 fn, ret, duration);
> +		 fn, ret, (unsigned long long)ktime_us_delta(rettime, *calltime));
>  }
>  
>  static ktime_t initcall_calltime;
> -- 
> 2.18.0
> 

I took this for a spin while playing around with other things today,
cleans things up nicely imo.

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com>

