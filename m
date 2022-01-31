Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84294A4B9A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380145AbiAaQPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244114AbiAaQPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:15:23 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE48AC061714;
        Mon, 31 Jan 2022 08:15:23 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o16-20020a17090aac1000b001b62f629953so11355814pjq.3;
        Mon, 31 Jan 2022 08:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5uZdVWjoxhGFYA4YBIqUe/MBlikRDu2EIuXigUfny90=;
        b=oXRLDPEH8AVlANH6vdTalKtCkhVKMT14DaYRCck6DHCJtoJIp7tn4u2SjCdVrsSBFu
         E7pvcJtSFTlVSsUlEz3Fawx+zkcF1yoaxq+mrG3GFJrV82bTJDyx0IT6HxZw/R92X2UR
         AP9DK1Z/KXKi9dHcxc9kqOkbdQ7dT7QYYWihCwfziuMdr83llOUxMJK1CL4UBORzK3cR
         T06LKgZRO0yzboIbTUNT1viraucpCjk9NbhcoBBlubmFMKWRmf5h8j0A0UnIdAsS5vol
         +S3Asl1ysNFX5VIQqZqOf7m/P77iECcXg+C6yK8pNWvuSkv2bBXjK9qjnpTElxz4uv3Y
         wiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5uZdVWjoxhGFYA4YBIqUe/MBlikRDu2EIuXigUfny90=;
        b=ukj+0HW/IHm6eS2lI7Y3HnsMRkblnjGxjGn7nOWcUmJb7tNfWLXZZK2Z5JXShs3R6X
         APlIOIE5vCZJEir1MxEuguM0xyDKt7jTTS2YgrvN+8xzplM92kx9RxNNVhNsdObNz9+n
         dUtbriK+K6h10hqu6tIfaTKhzLMwbNik0Aqcuq31BEK7kYMfLzSmhuPDKW/VIjE4EqKm
         Lr1B7fQqM86QizvNrzxMIsmI1hD1xjQ19SoirUNmyphhHdkl0mVpvD7e4Q/PmtNBlO1q
         73sC98RriV97HZlQlXTUI7N7LT/Jda/6vTnxmJFrhPEHw5D2DNaakVoEBr0w9YUWg4/v
         SrcQ==
X-Gm-Message-State: AOAM530S8b1S163ialcpN23So2aqlmMKJx7fUB927Sh79ms+0cPoSxEc
        eymCjoppG+Us00d44D8cn54=
X-Google-Smtp-Source: ABdhPJzqfE5lcy9pvkNWJyr+blfeSltYancWrC5kZUylapUH26mElwHhpAQoZJzAGqJzNJILftolYQ==
X-Received: by 2002:a17:90a:c68c:: with SMTP id n12mr20218277pjt.219.1643645723102;
        Mon, 31 Jan 2022 08:15:23 -0800 (PST)
Received: from google.com ([2620:15c:202:201:6213:1c4:865f:204c])
        by smtp.gmail.com with ESMTPSA id u16sm19342543pfg.192.2022.01.31.08.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 08:15:21 -0800 (PST)
Date:   Mon, 31 Jan 2022 08:15:17 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: spear-keyboard - Simplify resource management
Message-ID: <YfgLFXZkbsIFJzP6@google.com>
References: <c4b6e8b122259198ce76f42bf786b75cfd0cbffc.1643530826.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4b6e8b122259198ce76f42bf786b75cfd0cbffc.1643530826.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 09:20:44AM +0100, Christophe JAILLET wrote:
> Since the commit in the Fixes tag below, 'kbd->input' is a managed resource
> that doesn't need to be explicitly unregistered or freed (see
> devm_input_allocate_device() documentation)
> 
> So, remove a unless line of code to slightly simplify it.
> 
> Fixes: 6102752eb354 ("Input: spear-keyboard - switch to using managed resources")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only
> ---
>  drivers/input/keyboard/spear-keyboard.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
> index 9838c79cb288..c36836159fb3 100644
> --- a/drivers/input/keyboard/spear-keyboard.c
> +++ b/drivers/input/keyboard/spear-keyboard.c
> @@ -278,7 +278,6 @@ static int spear_kbd_remove(struct platform_device *pdev)
>  {
>  	struct spear_kbd *kbd = platform_get_drvdata(pdev);
>  
> -	input_unregister_device(kbd->input);
>  	clk_unprepare(kbd->clk);

This is wrong for the same reason as the other patch: it changes the
order of operations.

>  
>  	return 0;
> -- 
> 2.32.0
> 

Thanks.

-- 
Dmitry
