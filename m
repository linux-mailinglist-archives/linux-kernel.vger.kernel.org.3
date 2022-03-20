Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459B64E1D34
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 18:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245738AbiCTRjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 13:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiCTRjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 13:39:14 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD3518C0FA
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 10:37:50 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id kc20so6238551qvb.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 10:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=UpAsH3HNGYUb6pJqoGNbhy4ESgXn7LYmalYBo847NcU=;
        b=JGkyMerAd2g6F8muIKP6vKHK0v40lHv193s/7K77f/6/3RSE90D42rwWgO9T9yN08/
         IEGiL+f+vNycabezRrx40IBJIx1xq8R54iLvVMqzlKFpsY8GlAbvrRSOUofIx1zradjb
         Gw4nCwaxwZvwZeTXmQSoqf4odwfcLQGJWTL7OG1D4zejn+ChGrXQn0dmkyrKGrg/8qjv
         4dNDH3S48w2AzRA0w9PznJM7yBFyVbWLbig9q7xomTEp8XQBUfN4lcB8n8SIHhYPBcwt
         8ENRpNGp7OQsVot7pDepfZvt96m1Jx64kOrW1ISj2fTkTuOArAwwQvkYlTy9NZQoXy7Q
         p7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=UpAsH3HNGYUb6pJqoGNbhy4ESgXn7LYmalYBo847NcU=;
        b=IWDSy1h9muoD+e2q8L4U5dzkbVIGwFxjbsI9D0Xrr52PR0xF7HBgOyxtC/1kSbSrJU
         bRe0C+EmzE9IgOw0qnCoRl7786oGXvfoLyEBzzoAUnOdhmTXw4XILsdbu8HvcVdcxRuw
         du+cRKrj6EqVLtSEFojXzbgAuyhdrFraee/L10M1eyIpQ7mlbHWQVoJJ5aU4+M8r4488
         icfd3X9b6iR+wd1fbjN8oZTk/d94e0Y0Qruk95uiiFIDBGsLl1CNu9juKTM+zek7H1JX
         aoaJWHIj8dfK/Rlp35Ji6CNdLDF0x4LazoNZPxYc3lQH4wlPeShlxeiSqeezo16lfKma
         2vDQ==
X-Gm-Message-State: AOAM531TMlmCImgwvUTJbWhDxE3T5/TJpTa0k8Osoeypiw2LTCz6okPB
        2GC7Rg2mh8Jtq+Yr1g1fLRrev0wCKw==
X-Google-Smtp-Source: ABdhPJwh8QvADQKYx6DPR/dSdi1tzGg9wqeQVW1DOYXcHRPN0dHNgQHiyPZiuCqDYB1s0/59ZXi2HQ==
X-Received: by 2002:a05:6214:c2a:b0:440:f702:2195 with SMTP id a10-20020a0562140c2a00b00440f7022195mr10715396qvd.37.1647797869914;
        Sun, 20 Mar 2022 10:37:49 -0700 (PDT)
Received: from serve.minyard.net ([47.184.144.75])
        by smtp.gmail.com with ESMTPSA id n8-20020ac85a08000000b002e06aa02021sm10151220qta.49.2022.03.20.10.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 10:37:49 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:299c:3142:517:f2da])
        by serve.minyard.net (Postfix) with ESMTPSA id 58F3F180004;
        Sun, 20 Mar 2022 17:37:48 +0000 (UTC)
Date:   Sun, 20 Mar 2022 12:37:47 -0500
From:   Corey Minyard <minyard@acm.org>
To:     trix@redhat.com
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] ipmi: initialize len variable
Message-ID: <20220320173747.GH3457@minyard.net>
Reply-To: minyard@acm.org
References: <20220320135954.2258545-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320135954.2258545-1-trix@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 06:59:54AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this issue
> ipmi_ssif.c:1731:3: warning: 4th function call
>   argument is an uninitialized value
>   dev_info(&ssif_info->client->dev,
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The 4th parameter is the 'len' variable.
> len is only set by a successful call to do_cmd().
> Initialize to len 0.

Thanks, it's queued for next release..

-corey

> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/char/ipmi/ipmi_ssif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index ba779f1abb5b2..f199cc1948446 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -1625,7 +1625,7 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	unsigned char     *resp;
>  	struct ssif_info   *ssif_info;
>  	int               rv = 0;
> -	int               len;
> +	int               len = 0;
>  	int               i;
>  	u8		  slave_addr = 0;
>  	struct ssif_addr_info *addr_info = NULL;
> -- 
> 2.26.3
> 
