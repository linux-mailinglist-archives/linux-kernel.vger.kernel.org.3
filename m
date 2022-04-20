Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C978507F04
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 04:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358993AbiDTCsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 22:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239192AbiDTCsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:48:03 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C01725284
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:45:18 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id md20-20020a17090b23d400b001cb70ef790dso3683880pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1syVurlPdZtVxfD77EA07da6Q0rSSJ2SEOZ9IIvMxUw=;
        b=TGBBcj36GCla9UWEXP4zSj1zN0lOz5f2ul/fVLRyFgR+Vmtff+G7616OT5lwErhECF
         9l49f5c5cC6fMMAfxNJcj0Bb8iXOIzz6GM+mMs2I7aEAwJCy25tk/uj4wogq/zPS9Qgq
         2cK93xOr7di3AU/YzmT6A8NyM/aHbOBD2bq2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1syVurlPdZtVxfD77EA07da6Q0rSSJ2SEOZ9IIvMxUw=;
        b=T1OS3Dig8V3IMcNwIYdukXPS1tGY2hOwnwByLIWgizyaz3AfOQncjD9kNy87Ic/zTK
         05JlLJktTPlR80AOrcMCLr/0NdrnhDKNEduURcMw0YoO14b+fqHAaaDRte5QABI5I+Td
         a+SReysvC0GUaIlDCzAnaTOIR5MwyPj0WrkI0k569fntA3C3kvaLRHEsUbeNTgL1m67y
         V5hwI/9pOXPnYl4CYatGo23MzJ5ff1IvjYy57Q2LARtWq70uBDoOWgzUWWtkJ9RGWpHE
         uDely52ZWQXiHGAw7IpaYOA89trSkiHv8eF5+j3UUqtoGNTJY9g4hqihuZKJ329AlyWB
         /G/A==
X-Gm-Message-State: AOAM533vmN+1vcxBprVj96TuWk97xJZIhsbyhKE2TnPIGVybc+DzoG7T
        7MeT2xpyDzigoorFv8x4qTSSRw==
X-Google-Smtp-Source: ABdhPJyY7WO8H0dT1tmNr/jgQbtrjy7gcp4/rbnWxhnW4FecMs7HlQysjTPVoOohhl8xgekBtwjY2w==
X-Received: by 2002:a17:90a:31cb:b0:1d2:8998:61f9 with SMTP id j11-20020a17090a31cb00b001d2899861f9mr1854240pjf.186.1650422717621;
        Tue, 19 Apr 2022 19:45:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n3-20020a056a000d4300b0050ac8dbfd0csm745637pfv.163.2022.04.19.19.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 19:45:17 -0700 (PDT)
Date:   Tue, 19 Apr 2022 19:45:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     joao@overdrivepizza.com
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        peterz@infradead.org, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, samitolvanen@google.com,
        mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 10/11] linux/interrupt: Fix prototype matching
 property
Message-ID: <202204191942.3C273AB@keescook>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420004241.2093-11-joao@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420004241.2093-11-joao@overdrivepizza.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 05:42:40PM -0700, joao@overdrivepizza.com wrote:
> Unions will make function pointers with different prototypes be used through
> the same call. This leads into the same call instruction being used for
> calling functions with different prototypes, making them unsuitable for
> prototype-based fine-grained CFI.

Why? Shouldn't the callers be using different prototypes?

> Fix this CFI policy violation by removing the function pointer union in
> the tasklet struct.

The good news is that tasklet is on the way out the door[1], so this may
quickly become a non-issue, but also to that end, this fix is hardly a
problem for a deprecated API...

-Kees

[1] https://lore.kernel.org/linux-hardening/20220419211658.11403-1-apais@linux.microsoft.com/

> 
> Signed-off-by: Joao Moreira <joao@overdrivepizza.com>
> ---
>  include/linux/interrupt.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index f40754caaefa..8d5504b0f20b 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -650,10 +650,8 @@ struct tasklet_struct
>  	unsigned long state;
>  	atomic_t count;
>  	bool use_callback;
> -	union {
> -		void (*func)(unsigned long data);
> -		void (*callback)(struct tasklet_struct *t);
> -	};
> +	void (*func)(unsigned long data);
> +	void (*callback)(struct tasklet_struct *t);
>  	unsigned long data;
>  };
>  
> -- 
> 2.35.1
> 

-- 
Kees Cook
