Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9987581C22
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 00:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiGZWmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 18:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiGZWmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 18:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A849925C73
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 15:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658875332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sDAwsVQbSAzmWkAITnnVnLl/3BbAkl6tpRMtqlMRgEQ=;
        b=Sdqbd3IXBwG74VDcE4N05+KnKzCyJyWfpthN88oPA++IHC4axvl7zh4x1FqW4fI36iv0wO
        tO9jyiHmr4kFx3P2FoA7Ib8uC5xfhsPuDWcuwXCe+/6e8i1ZH+rMmg8GX4SBB5b3cSLPn3
        FEOcWyWaajd7/HSB5kVM6wF/M78kToY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-mnb0Ew6mMYmePElQuMFuAg-1; Tue, 26 Jul 2022 18:42:11 -0400
X-MC-Unique: mnb0Ew6mMYmePElQuMFuAg-1
Received: by mail-qk1-f199.google.com with SMTP id i15-20020a05620a404f00b006b55998179bso13113726qko.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 15:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sDAwsVQbSAzmWkAITnnVnLl/3BbAkl6tpRMtqlMRgEQ=;
        b=0GteWLB0iS3Wn7Xoe2Jx9FAwfcUhXZQcNTNrdtoLRpJP1Ets80ElPqqZUfOBTrWgxv
         hwJoxFzqJWCYI8wAUsSXO224KnAD7US/d7XwKLYHlw3Vjw9TGtqLvEeyvhUZBuYWkuFn
         Kl/GtjvhUsgUCoqvDeYrhAaRINNKXFeF2wd3+7P0b30i/U6mj4UfJF+nNad0vupueB22
         DnzMKEPIiXPRyKaDuxYLSUZeL5vGeA3q1eTx+F4V04M/Ew8ycTegSiKE/0oYvj2AK05F
         PKYgwu//6FHxzBmmwpR6UsO7uO5uPQj0DGaF9tDqOH2PSMAE/muoxTvqHNvfaCdLeGu5
         EEZg==
X-Gm-Message-State: AJIora8rfKDj8aYheU5ykoPKubu1xDJau3SOmfEve+Qakx1InFNVjykt
        8q6K15S7TNDeSRTiowic/qfDBiZLX3lPtNsdwdvXltFV+JsAfaQz35EWgwCZh4qg6lNdny16024
        6CNR183d6PaFwx3uBQL7xfQ2r
X-Received: by 2002:a05:622a:130a:b0:31f:450f:ac8e with SMTP id v10-20020a05622a130a00b0031f450fac8emr3159057qtk.498.1658875330839;
        Tue, 26 Jul 2022 15:42:10 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uM26EC6KJaFiAwJ6GkqSfsxbzc020dldipuxBJxnu5hv3GD6krWz6DSGonxqZSNIR8MINX/A==
X-Received: by 2002:a05:622a:130a:b0:31f:450f:ac8e with SMTP id v10-20020a05622a130a00b0031f450fac8emr3159046qtk.498.1658875330570;
        Tue, 26 Jul 2022 15:42:10 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::49])
        by smtp.gmail.com with ESMTPSA id f12-20020ac8014c000000b0031ef6dd9700sm10551841qtg.55.2022.07.26.15.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 15:42:10 -0700 (PDT)
Date:   Tue, 26 Jul 2022 15:42:06 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Artem Savkov <asavkov@redhat.com>
Subject: Re: [PATCH v5 0/2] Upper bound kernel timers
Message-ID: <20220726224206.kbcveqaw2fjar3el@treble>
References: <87zgkwjtq2.ffs@tglx>
 <20220505131811.3744503-1-asavkov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220505131811.3744503-1-asavkov@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Ping?

On Thu, May 05, 2022 at 03:18:09PM +0200, Artem Savkov wrote:
> As previously discussed [1] we had a report of a regression in TCP keepalive
> timer where timers were up to 4 minutes late resulting in disconnects.
> 
> This patchset tries to fix the problem by introducing upper bound kernel timers
> and making tcp keepalive timer use those.
> 
> [1] https://lore.kernel.org/all/20210302001054.4qgrvnkltvkgikzr@treble/T/#u
> 
> ---
> Changes in v5:
>   - The least intrusive and most straightforward approach. This avoids touching
>     any of existing code. The timeout supplied is always reduced by a known
>     timer wheel error margin of 12.5%.
>   - Commit message adjustments.
> 
> Changes in v4:
>   - Drop any attempts to be smart when calculating timer adjustment and always
>     substract LVL_GRAN so that base clock lag won't be such a problem. This
>     means that in some cases we will always be early, but all we want is not to
>     be late.
> 
> Changes in v3:
>   - A different approach: instead of introducing upper bound timers try to
>     account for timer wheen granularity on timer (re)arming step.
>   - Not sure whether moving lvl calculation into a separate function is worth
>     it.
>   - Had a hard time naming the upper_bount_timeout() function - any suggestions
>     welcome.
> 
> Changes in v2:
>   - TIMER_UPPER_BOUND flag description added as a comment in timer.h
>   - Code style fixes
>   - More elaborate commit message in timer commit
> 
> Artem Savkov (2):
>   timer: add a function to adjust timeouts to be upper bound
>   net: make tcp keepalive timer upper bound
> 
>  include/linux/timer.h           |  1 +
>  kernel/time/timer.c             | 14 ++++++++++++++
>  net/ipv4/inet_connection_sock.c |  2 +-
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> -- 
> 2.34.1
> 

-- 
Josh

