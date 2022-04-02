Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD76F4F00EF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 13:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237523AbiDBLHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 07:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237128AbiDBLHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 07:07:44 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327A81A2A3D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 04:05:53 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w127so5232665oig.10
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 04:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5nNjTIYgpRbZw5I/VzC+f5/bljYzlHsJFDDO5VmuXF4=;
        b=ZALJ1zIYb+btHV9fF5mqAUH3lr58JYRyAtclQkdj24wtnkG8korJrsq6BGNI5Taa/8
         htEUb9QhjwVs8pDoXQ8D825fh4TCbN9lA2RsR16RVoy+V2GEkSYWknnbbrlj/lxJJYzx
         ztaOPs4SDSiKbekB8T5S9v/c/61//RT6Vj9FdlgCiVSItpqpz2M/vfS4p6mL3Uq2HGgF
         y0hPIdsDiBvxoJP2XfTDyy1f1efPWcdAUhhbuej3SJHxjWEXSl1JH6ZJ+UJ0kwijEKcd
         10teOP1iedzJPBGcHLTOqSrbSJX6UiGjiaQ1//oCQfCEeEpuCSt0pkKN1oIvpEFGCHV6
         j3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5nNjTIYgpRbZw5I/VzC+f5/bljYzlHsJFDDO5VmuXF4=;
        b=2kmQGzSbJBhl5ftfqrTEDK/YSXHMgtatTJz83NSQW0njbECrdzgm3eOaP4eUjmisiI
         q4MbRjNvbb5rg1SwivNjnBIM2roEuD68ltEZm3Swuchhwocciv1uolRlcKeY3aDXAynV
         /IC3RbaYFa/G6V+h5C1Vh4OO1FWLaGtRSTH22ojuj5LMeqMEA2qD2eTejpgZAGDQY9ps
         cdUML9Txj2D48lA8v98HijtPvgF16SgVHIfWfFd+J/msBtKQ9v7TSrOdGOT/Mc101K5p
         piLl5ForATVu2n8VQxhosEdAFpJzHVzb0gK/fn+oUWcDQaObFI5ilVLOvAqgQXYWCoOK
         d/Ng==
X-Gm-Message-State: AOAM530i4qTfihfzcO+ZeCpq946r2+LgzanlA/14DNyzbiC3sOTTH7LQ
        Th3Z1Eq79rNxn9VnNGpxWsneDz8thsAR4Q==
X-Google-Smtp-Source: ABdhPJzPRczjH6KHvYSlj/i+EL+piiYu7Xx2mZo2CtSLq9y3JKUxXPusvcgWdoeQIGT46zZyG6a1GA==
X-Received: by 2002:a05:6808:1413:b0:2ef:4a81:2ee8 with SMTP id w19-20020a056808141300b002ef4a812ee8mr6278818oiv.125.1648897552507;
        Sat, 02 Apr 2022 04:05:52 -0700 (PDT)
Received: from eze-laptop ([2803:9800:98c2:8470:9f4:8e2a:88e5:ec01])
        by smtp.gmail.com with ESMTPSA id m15-20020a9d644f000000b005ce0a146bfcsm2174508otl.59.2022.04.02.04.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 04:05:51 -0700 (PDT)
Date:   Sat, 2 Apr 2022 08:05:46 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/23] media: rkvdec: Stop overclocking the decoder
Message-ID: <YkguChEzVz7T9qZV@eze-laptop>
References: <20220331193726.289559-1-nicolas.dufresne@collabora.com>
 <20220331193726.289559-13-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331193726.289559-13-nicolas.dufresne@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 03:37:14PM -0400, Nicolas Dufresne wrote:
> While this overclock hack seems to work on some implementations
> (some ChromeBooks, RockPi4) it also causes instability on other
> implementations (notably LibreComputer Renegade, but there were more
> reports in the LibreELEC project, where this has been removed). While
> performance is indeed affected (tested with GStreamer), 4K playback
> still works as long as you don't operate in lock step and keep at
> least 1 frame ahead of time in the decode queue.
> 
> After discussion with ChromeOS members, it would seem that their
> implementation indeed used to synchronously decode each frames, so
> this hack was simply compensating for their code being less
> efficient. In my opinion, this hack should not have been included
> upstream.
> 
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>

Fixes: cd33c830448ba ("media: rkvdec: Add the rkvdec driver")
Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Thanks,
Ezequiel

> ---
>  drivers/staging/media/rkvdec/rkvdec.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
> index c0cf3488f970..2df8cf4883e2 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.c
> +++ b/drivers/staging/media/rkvdec/rkvdec.c
> @@ -1027,12 +1027,6 @@ static int rkvdec_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	/*
> -	 * Bump ACLK to max. possible freq. (500 MHz) to improve performance
> -	 * When 4k video playback.
> -	 */
> -	clk_set_rate(rkvdec->clocks[0].clk, 500 * 1000 * 1000);
> -
>  	rkvdec->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(rkvdec->regs))
>  		return PTR_ERR(rkvdec->regs);
> -- 
> 2.34.1
> 
