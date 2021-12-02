Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BA1466A89
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbhLBTjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhLBTjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:39:24 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52050C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 11:36:01 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 200so787767pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 11:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0SCOI+o2Z/owL9Mbm+7ldS+Ld81vbYtWdoGHtJnRY5Y=;
        b=jHbX+QSaWPnnpWzqq1tRWLqe5/ckDCq0fs1OiUAHUuBYHXNsRp4tNlKtFROZysh7Xm
         5w6QTpy5Qznt44TW+gPAkDSU63d5O+gpQL9KTXA9nUXnBHzGX8gGzY2sUkX4KjBFQWKN
         j5uzRf9R9g65wpU4/lec6bpGPCY9iEi/i3utQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0SCOI+o2Z/owL9Mbm+7ldS+Ld81vbYtWdoGHtJnRY5Y=;
        b=KlIdPBtzIxnl+R9PQHstvFBjfWFB7HvoRS8wbkGOlAxEpdwNYWPyLDpHuC5HSsOznx
         9SFuxsBq9rauDH+W2r9DhU9pASXuzU2mmQskI1Xrft3s2v9+RD9gaWQfRdCCO0RLUzBB
         tzo78alWmCp6VwypiXxPJm1maRxQ1kozhj82roFgeJgCuNvhrDzVW25QYsyINO2NPY/0
         9MVbFNoUgcN0ENs7Xy4gTOJxw+KH7YZ+6VBrmV3mDnO13gSGZxGK8SHqr32HmaaazaTI
         ydfvIRA7uTOsm1PPzEuuLGba8gFCsv43cD7CYFuDWlSM2PRisM1ZSRQi0Ok3OQXtvvvA
         ntoQ==
X-Gm-Message-State: AOAM530W/+fjAW3K7xWFhy2i6Uqt/oQPmzzz/bsDqz0nlhfxIpz5CwKp
        S6rL86TUwf1+0s04Dr9dqrClxQ==
X-Google-Smtp-Source: ABdhPJwG+2Ng4ORjTZPJ/DNAPaqRQbpeTyovONbGKBGWpSTCR3gwh2Oq8LwoJrRPz9k5/eNQ1u98/g==
X-Received: by 2002:a05:6a00:8cf:b0:4a8:3ae:1a78 with SMTP id s15-20020a056a0008cf00b004a803ae1a78mr14246553pfu.7.1638473760881;
        Thu, 02 Dec 2021 11:36:00 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id na15sm3632525pjb.31.2021.12.02.11.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 11:36:00 -0800 (PST)
Date:   Thu, 2 Dec 2021 11:35:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yang Guang <cgel.zte@gmail.com>
Cc:     Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: use swap() to make code cleaner
Message-ID: <202112021134.7ECC69C1@keescook>
References: <20211028003526.7117-1-yang.guang5@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028003526.7117-1-yang.guang5@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 12:35:26AM +0000, Yang Guang wrote:
> Using swap() make it more readable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> ---
>  scripts/gcc-plugins/randomize_layout_plugin.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
> index 334741a31d0a..feee5ba8fa2b 100644
> --- a/scripts/gcc-plugins/randomize_layout_plugin.c
> +++ b/scripts/gcc-plugins/randomize_layout_plugin.c
> @@ -244,11 +244,8 @@ static void full_shuffle(tree *newtree, unsigned long length, ranctx *prng_state
>  	unsigned long i, randnum;
>  
>  	for (i = length - 1; i > 0; i--) {
> -		tree tmp;
>  		randnum = ranval(prng_state) % (i + 1);
> -		tmp = newtree[i];
> -		newtree[i] = newtree[randnum];
> -		newtree[randnum] = tmp;
> +		swap(newtree[i], newtree[randnum]);
>  	}
>  }

Hmm, I don't think you compile-tested this? The gcc plugins are build in
userspace without the kernel headers (i.e. no "swap" macro). I'd be
happy to avoid open-coding this, but that would require a new macro
specific to the gcc plugins (to avoid std::swap). Also, there are two
other open-coded swaps in here that could be changed too. :)

-Kees

-- 
Kees Cook
