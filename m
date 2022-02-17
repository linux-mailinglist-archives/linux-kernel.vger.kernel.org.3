Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F124B95DD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 03:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiBQCWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 21:22:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiBQCWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 21:22:14 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C8C24F1A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 18:22:00 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d187so3724636pfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 18:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l2wDoQKYuNxljocz4UAEvWSyuBrgmqvYiOg3RhZ22sY=;
        b=SU/DICxPj/U3ZSlhmSelDtgozNYgEtWejBOTojQQ7I3RSnCuaa0dLkMd/sb/Hhu5if
         XaDrZReyDf4qPeW2q2hTxFRCvrMSWKMbJy7I3XrXKwWlnmVIpK+oqNZNA7FR0w/P0C38
         r7GdHdhLYXdE0NhwfNrgnFm+n2jBqJEWB9EIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l2wDoQKYuNxljocz4UAEvWSyuBrgmqvYiOg3RhZ22sY=;
        b=ZpGcKLfdaN4S/7B+P5ss4SK2w5CEUgrREZ9KgYIgCMhk/gZ7D2jj7fHLXZI+Eylxle
         9kcDonxgPc2am/CYgu1n44M+KNsMe2jPcd9gwpA0KSCwZyox3eSe+3s9EU92S5LuWT/H
         +A77+Mzhe4oDhoyUYyUvNT/2SUjlDxelH4rY6Q0JbVliHUioW3R2Aj2HFQZZt/nyZgWZ
         pZkrBEf+vgZhNRYJ1pHtTYN5g6skGgHz3dNgnlLbJrSytahTTo9k38y87gYe+AC/+N1E
         OkUnmvJxdlZUp/fSJ28+ArvLcGuWB5nNJh6JjlCTBteW/uaHMpk28+WWvPB2sosfpQRM
         zGcA==
X-Gm-Message-State: AOAM531Y5U0A0FIkXWR9OX1/zm9czHp/CjDko1AaAVFI5d9yKNFHSg/5
        SrTuRG1zvz+2dwzTREMJlnp75w==
X-Google-Smtp-Source: ABdhPJyq97MyXix4mwZYBk16SX0okICsB1fPbw+C3Th6ZyTMCMGMxgzmoXJ5l5B2Qja16/wzhhdCrw==
X-Received: by 2002:aa7:9112:0:b0:4e1:3b6:683 with SMTP id 18-20020aa79112000000b004e103b60683mr962375pfh.63.1645064519953;
        Wed, 16 Feb 2022 18:21:59 -0800 (PST)
Received: from chromium.org (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l13sm6409461pgs.16.2022.02.16.18.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 18:21:59 -0800 (PST)
Date:   Thu, 17 Feb 2022 02:21:58 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] platform/chrome: cros_ec: determine
 `wake_enabled` in cros_ec_suspend()
Message-ID: <Yg2xRup53gP39SBs@chromium.org>
References: <20220216080306.3864163-1-tzungbi@google.com>
 <20220216080306.3864163-4-tzungbi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216080306.3864163-4-tzungbi@google.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 16 16:03, Tzung-Bi Shih wrote:
> `wake_enabled` indicates cros_ec_resume() needs to call
> disable_irq_wake() to undo enable_irq_wake() in cros_ec_suspend().
> 
> Determine `wake_enabled` in cros_ec_suspend() instead of
> reset-after-used in cros_ec_resume().
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>

I don't see what is the issue with reset-after-use here, as long as the
variable is initialized correctly. This patch strikes me as larger than
it really needs to me. Anyway, FWIW:

Reviewed-by: Prashant Malani <pmalani@chromiu.org>

> ---
> Changes from v4:
> (https://patchwork.kernel.org/project/chrome-platform/patch/20220216043639.3839185-4-tzungbi@google.com/)
> - Undo changes from v3; rollback to v2.
> 
> Changes from v3:
> (https://patchwork.kernel.org/project/chrome-platform/patch/20220209095703.517608-4-tzungbi@google.com/)
> - Change the patch title.
> - Simplify by initializing wake_enabled in cros_ec_register().
> 
> No changes from v2.
> 
> Changes from v1:
> (https://lore.kernel.org/lkml/20220125101527.1812887-1-tzungbi@google.com/T/#u)
> - Use imperative mood in commit message.
> 
>  drivers/platform/chrome/cros_ec.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> index 25cd8df6e7b0..a013fbceeb03 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -342,6 +342,8 @@ int cros_ec_suspend(struct cros_ec_device *ec_dev)
>  
>  	if (device_may_wakeup(dev))
>  		ec_dev->wake_enabled = !enable_irq_wake(ec_dev->irq);
> +	else
> +		ec_dev->wake_enabled = false;
>  
>  	disable_irq(ec_dev->irq);
>  	ec_dev->suspended = true;
> @@ -383,10 +385,9 @@ int cros_ec_resume(struct cros_ec_device *ec_dev)
>  		dev_dbg(ec_dev->dev, "Error %d sending resume event to ec",
>  			ret);
>  
> -	if (ec_dev->wake_enabled) {
> +	if (ec_dev->wake_enabled)
>  		disable_irq_wake(ec_dev->irq);
> -		ec_dev->wake_enabled = 0;
> -	}
> +
>  	/*
>  	 * Let the mfd devices know about events that occur during
>  	 * suspend. This way the clients know what to do with them.
> -- 
> 2.35.1.265.g69c8d7142f-goog
> 
