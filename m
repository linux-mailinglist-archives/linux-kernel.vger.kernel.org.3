Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C6149BDBD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbiAYVKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbiAYVKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:10:45 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1160C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 13:10:45 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id a8so15557348pfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 13:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oTajAjIFl5J5w/Rcv1Jq4D73n55d0RoAmCIghJOGibE=;
        b=ZKQNRGS2URon4bqAWx+sEDzRBBpV7Xe9BsY8G3Bdj8hiy3srRL2yAOY3wK3xdUHbhQ
         0GtR6dOnpon+k8KnmSACtLufwTDy8gBHWQiYf1LxuujlpoIUIvFaithyoKebbgqHAIQt
         3OZ+maPPLrzfTBfnzn5AE1b9pD2OhRxS81rImxOS8w3w6bbeV2gqEsWDYyZgUd4RHk/O
         ksrFBe9LlcwVzOiS0aUVrPn9lht/QyihBJGQsf4n9LXqyuOmIKcOOYjjiY0r4a8Frtm0
         Oh5+AWbbeo7rLoq6Is1010UTApCBKXhUIR18eR8fHEwLOJ8PzQAsxxp7brbXxAStC6+s
         g27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oTajAjIFl5J5w/Rcv1Jq4D73n55d0RoAmCIghJOGibE=;
        b=hwt2q97sJ8LXL5uZjUMA6huyQcLQSPGkvW6BaWEaat7UAs+PqXF4LDPO38CQui44vK
         WR0T8vG2wft/4rZ4m3qGBAOrq7GMfHngog2uNRKjGrs1s242f6wcrWInA/S3alBwQu0Q
         xIHmJ3hlIsdwdsa0sOh4Cj07n0SFVxfDqGYup9jcjCKoNNME/668JqRGvXdx+MWT25VA
         L8Ix0hBizUoNRhqCRrJTlqw8beM60WzGOEmTuqR8gDCrPJUAR98Y7SLdM+A9EcBnuEOl
         SCOqJk0u+/tKPCL5DjOn9k3kb3J0dBA7iu6KUiP1Ch1ehHWwkL4W8j0rAJTruus8XNMf
         6efA==
X-Gm-Message-State: AOAM533OW4D3v1jFVqzNzquVvZexyctv2XRcWYHOgZUrkW7TUdv9yhAF
        6UmBL474SM99OB36MHjOhSE6Eg==
X-Google-Smtp-Source: ABdhPJwUGuw/olo0NQ+3jI3fshHSfEURm9sit3pjcxyIdakH1k4Of92wXKR2ERTDKbgL+HE+ZoRYzw==
X-Received: by 2002:a05:6a00:994:b0:4c9:d2a4:c5af with SMTP id u20-20020a056a00099400b004c9d2a4c5afmr9093566pfg.73.1643145044900;
        Tue, 25 Jan 2022 13:10:44 -0800 (PST)
Received: from google.com ([2620:15c:211:202:b678:e713:1931:1231])
        by smtp.gmail.com with ESMTPSA id l17sm7899369pfu.61.2022.01.25.13.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 13:10:43 -0800 (PST)
Date:   Tue, 25 Jan 2022 13:10:34 -0800
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Russell King <linux@armlinux.org.uk>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] ep93xx: clock: Fix UAF in ep93xx_clk_register_gate()
Message-ID: <YfBm/xBJLDtU/fo5@google.com>
References: <20220120133739.4170298-1-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120133739.4170298-1-alexander.sverdlin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 02:37:38PM +0100, Alexander Sverdlin wrote:
> arch/arm/mach-ep93xx/clock.c:151:2: note: Taking true branch
> if (IS_ERR(clk))
> ^
> arch/arm/mach-ep93xx/clock.c:152:3: note: Memory is released
> kfree(psc);
> ^~~~~~~~~~
> arch/arm/mach-ep93xx/clock.c:154:2: note: Use of memory after it is freed
> return &psc->hw;
> ^ ~~~~~~~~
> 
> Link: https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/B5YCO2NJEXINCYE26Y255LCVMO55BGWW/
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 9645ccc7bd7a ("ep93xx: clock: convert in-place to COMMON_CLK")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> ---
>  arch/arm/mach-ep93xx/clock.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
> index cc75087134d3..4aee14f18123 100644
> --- a/arch/arm/mach-ep93xx/clock.c
> +++ b/arch/arm/mach-ep93xx/clock.c
> @@ -148,8 +148,10 @@ static struct clk_hw *ep93xx_clk_register_gate(const char *name,
>  	psc->lock = &clk_lock;
>  
>  	clk = clk_register(NULL, &psc->hw);
> -	if (IS_ERR(clk))
> +	if (IS_ERR(clk)) {
>  		kfree(psc);
> +		return (void *)clk;

Prefer ERR_CAST to the raw cast. I think that's nicer when we're already
using the IS_ERR macros.

> +	}
>  
>  	return &psc->hw;
>  }
> -- 
> 2.34.1
> 
