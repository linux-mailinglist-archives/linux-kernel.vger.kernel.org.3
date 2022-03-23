Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BF54E5891
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 19:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343847AbiCWSmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 14:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiCWSmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:42:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2344920F51
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 11:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648060832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JW98rsK+DU4n/BDhOTVrWPXjdqOazBe4CI/YrJiIZwA=;
        b=bsnRDvN6A5mHp1eDf92l0Cgz1b8fWZvNaLHE7eaR43pHQ+12N25pnwwWGyxRG7KFo7XV9P
        k+1l0O88z1+MUPhscEjf9KcjhQroDTHAqlCoMgqNxHaAM42cEczbTMLZ9mccGHr3SMSkBU
        DlmqYIP4AbWXXMTLFCHm32JmmkMZEoo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-Z6i5TGyyOSGQLsGkaTQiLQ-1; Wed, 23 Mar 2022 14:40:31 -0400
X-MC-Unique: Z6i5TGyyOSGQLsGkaTQiLQ-1
Received: by mail-qt1-f200.google.com with SMTP id t19-20020ac86a13000000b002e1fd2c4ce5so1882935qtr.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 11:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JW98rsK+DU4n/BDhOTVrWPXjdqOazBe4CI/YrJiIZwA=;
        b=40xJ2rDkVeeIeNmny4BicAHmi+L6yaCAFPKxLDjoP58okV0HvWKpEQjyvNt54QQsvf
         tf7Nr/WA+IMiJEGVJTk/Wcmw58PrzvfdpihJ26keJI11Z80wY051qPP8ukVVo7M+IqPE
         ktH4me9niglIXD4gf31JgIY9PTvtWMjj0jOpaj+4ovDq53R4BOm5sZ8NHS27dLuIMRpg
         X5ulTdEahKeGMGkghZ7++S5k6ucBK9P7QScvJjgZGsBPLg4lVKh35AqVpBjjP/tRShXz
         WzIQVHmetE4IRWCUMxI/rVHCUlHD8pIifre0qREol0HbREEasMloVE7xJ3jPDHCu7Q/C
         Fn1A==
X-Gm-Message-State: AOAM531V5oD3JZdQlCD6QInDieSzM7nMQDSPCDHphwJsqt87jlFLNdIh
        aP255HTGjSkRcCVGlgPMXgNG1miFaUWFPq1QH6Egxm2blk0mDM43cKukYzPGtLCXxr/F7j7Fjie
        X+PslqkW2RzWhBHnIUTfPcwrI
X-Received: by 2002:ac8:5b8f:0:b0:2e2:72c:9af0 with SMTP id a15-20020ac85b8f000000b002e2072c9af0mr1133529qta.498.1648060830566;
        Wed, 23 Mar 2022 11:40:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3rbLoEE5V+ODa3py9Eb7lebue0Oz5sU06to3xstB0M9N4horXwl81kaMzNBD+odql+lM2WA==
X-Received: by 2002:ac8:5b8f:0:b0:2e2:72c:9af0 with SMTP id a15-20020ac85b8f000000b002e2072c9af0mr1133505qta.498.1648060830252;
        Wed, 23 Mar 2022 11:40:30 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::e])
        by smtp.gmail.com with ESMTPSA id a129-20020a376687000000b0067d186d953bsm326347qkc.121.2022.03.23.11.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 11:40:29 -0700 (PDT)
Date:   Wed, 23 Mar 2022 11:40:26 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Artem Savkov <asavkov@redhat.com>
Cc:     tglx@linutronix.de, netdev@vger.kernel.org, davem@davemloft.net,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] timer: introduce upper bound timers
Message-ID: <20220323184026.wkj55y55jbeumngs@treble>
References: <20220323111642.2517885-1-asavkov@redhat.com>
 <20220323111642.2517885-2-asavkov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220323111642.2517885-2-asavkov@redhat.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 12:16:41PM +0100, Artem Savkov wrote:
> Add TIMER_UPPER_BOUND flag which allows creation of timers that would
> expire at most at specified time or earlier.
> 
> This was previously discussed here:
> https://lore.kernel.org/all/20210302001054.4qgrvnkltvkgikzr@treble/T/#u
> 
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Artem Savkov <asavkov@redhat.com>

Thanks Artem, this approach looks good to me.  Some kernel style nits...

The commit log could use some more background and motivation for the
change:

a) describe the current timer bound functionality and why it works for
   most cases

b) describe the type of situation where it doesn't work and why

c) describe the solution

> ---
>  include/linux/timer.h |  3 ++-
>  kernel/time/timer.c   | 36 ++++++++++++++++++++++--------------
>  2 files changed, 24 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/timer.h b/include/linux/timer.h
> index fda13c9d1256..9b0963f49528 100644
> --- a/include/linux/timer.h
> +++ b/include/linux/timer.h
> @@ -67,7 +67,8 @@ struct timer_list {
>  #define TIMER_DEFERRABLE	0x00080000
>  #define TIMER_PINNED		0x00100000
>  #define TIMER_IRQSAFE		0x00200000
> -#define TIMER_INIT_FLAGS	(TIMER_DEFERRABLE | TIMER_PINNED | TIMER_IRQSAFE)
> +#define TIMER_UPPER_BOUND	0x00400000
> +#define TIMER_INIT_FLAGS	(TIMER_DEFERRABLE | TIMER_PINNED | TIMER_IRQSAFE | TIMER_UPPER_BOUND)
>  #define TIMER_ARRAYSHIFT	22
>  #define TIMER_ARRAYMASK		0xFFC00000

This new flag needs a comment above, where the other user flags are also
commented.

>  	}
>  	return idx;
>  }
> @@ -607,7 +613,8 @@ static void internal_add_timer(struct timer_base *base, struct timer_list *timer
>  	unsigned long bucket_expiry;
>  	unsigned int idx;
>  
> -	idx = calc_wheel_index(timer->expires, base->clk, &bucket_expiry);
> +	idx = calc_wheel_index(timer->expires, base->clk, &bucket_expiry,
> +			timer->flags & TIMER_UPPER_BOUND);

Here and elsewhere, to follow kernel convention, the 2nd line needs
spaces after the tabs to align it with the previous line.  That makes it
more obvious that the 2nd line is just another function argument.  Like:

	idx = calc_wheel_index(timer->expires, base->clk, &bucket_expiry,
			       timer->flags & TIMER_UPPER_BOUND);

-- 
Josh

