Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C94C598985
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344109AbiHRQ5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239140AbiHRQ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:57:46 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F958C9903;
        Thu, 18 Aug 2022 09:57:46 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u22so1986993plq.12;
        Thu, 18 Aug 2022 09:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=2PnCdUMGwdUWAF1sPmD2LHJJ11XyuXr7oIvXc0TsARM=;
        b=dooABrmq+eV00UmaLlz0HKPbtLLkl8thQFvIBKXQ4Hhci/oAVT+bXo/zdlW7porL0Z
         BF2aE9jqAOtmefN4yAzDFHmV0rqHMEYWzSUQ4Oc8et/xrUHfYl4XGNBGRJNtavAERrxN
         5KElOdBv4hpnKaO2Xa0toMKwf14X5HEgq4X9RkCsXVHKRoeSUtAfpncODNFNLgEk5Spu
         s3Z5qoeH2u4unDlY3sBYunnTB99oviJfKIm54Oi7EwT3PIU06QhbgMQ4awL8hfjkopZd
         kVXbs8+kMbumcqu4SL+lKrRj1iz+LcURXN9w+SfdZvDRgGOFMu2b4nCVk4EWTclgL9nZ
         ogww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=2PnCdUMGwdUWAF1sPmD2LHJJ11XyuXr7oIvXc0TsARM=;
        b=Iy/85WRNY5jfW9npCeAxoVBErOVm2mTN8ali89BwHrTqtj15OXap18p7Mg06qbJeXH
         DWoRukHlWojhmTZ4q+Udsk0fwvJBBXaep9S1A2604HYR+w1Et14H8H1qOmT6n51vWLD8
         mVkTJFuK5SAA3Jj1znhRBlWDmP1o8OT8m7gWOqPuFdkvC0Np46uBCPIveQKlOcUXueMm
         si2bv2+W2DpXARBAi1vAuMihimlE86r+LqhFpHtaFomDhUPO137AKqGFMrQkMrE2g6v1
         RQWq5+SuhLDWvxBEU0E2bFK2lAVJO7jiJtS0mAFQzBzj8IQY/1p/sNCVUn1wqLiBXGKN
         0g3w==
X-Gm-Message-State: ACgBeo12QevKslryOgDSJkBTzrxMl6g1ETzRVMBFKW+6PH0qt7GIrFZS
        zP5Z+ATrir1jgMJ3rVl//lY=
X-Google-Smtp-Source: AA6agR7GcFXm9f5Yy/hhZGtiamqh3mztxw34V+qsdabNTbsjVIM4sPXe0X3UxNyE0do/2DJwA0+tog==
X-Received: by 2002:a17:90b:3892:b0:1f5:8be1:d8a0 with SMTP id mu18-20020a17090b389200b001f58be1d8a0mr3966475pjb.162.1660841865489;
        Thu, 18 Aug 2022 09:57:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n5-20020a170902e54500b00172bd84c8b4sm116146plf.98.2022.08.18.09.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 09:57:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 18 Aug 2022 09:57:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexey Klimov <aklimov@redhat.com>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux-kernel@vger.kernel.org, klimov.linux@gmail.com
Subject: Re: [PATCH REVIEW 2/2] watchdog: add wd_data->lock mutex locking to
 watchdog_open()
Message-ID: <20220818165743.GB923105@roeck-us.net>
References: <20220818020624.2386475-1-aklimov@redhat.com>
 <20220818020624.2386475-2-aklimov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818020624.2386475-2-aklimov@redhat.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 03:06:24AM +0100, Alexey Klimov wrote:
> watchdog_open() does not have wd_data->lock locks at all unlike
> the watchdog_release() for instance. Also watchdog_open() calls
> watchdog_start() that should be called with wd_data->lock acquired.
> The mutex lock should be acquired in the beginning of the function
> after getting struct watchdog_core_data wd_data pointer to deal with
> different status fields and be able to call watchdog_start(); and
> released on exit and on different error paths.
> 
Again, I am missing which problem you are fixing here. You are making
a claim that a lock is needed, but you do not explain _why_ this is really
needed, why test_and_set_bit() is insufficient, and what problem is solved
that has been observed with the current code.

Guenter

> Signed-off-by: Alexey Klimov <aklimov@redhat.com>
> ---
>  drivers/watchdog/watchdog_dev.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 804236a094f6..d07a864036d9 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -836,7 +836,7 @@ static int watchdog_open(struct inode *inode, struct file *file)
>  	struct watchdog_core_data *wd_data;
>  	struct watchdog_device *wdd;
>  	bool hw_running;
> -	int err;
> +	int err = -EBUSY;
>  
>  	/* Get the corresponding watchdog device */
>  	if (imajor(inode) == MISC_MAJOR)
> @@ -845,9 +845,10 @@ static int watchdog_open(struct inode *inode, struct file *file)
>  		wd_data = container_of(inode->i_cdev, struct watchdog_core_data,
>  				       cdev);
>  
> +	mutex_lock(&wd_data->lock);
>  	/* the watchdog is single open! */
>  	if (test_and_set_bit(_WDOG_DEV_OPEN, &wd_data->status))
> -		return -EBUSY;
> +		goto out_unlock;
>  
>  	wdd = wd_data->wdd;
>  
> @@ -856,10 +857,8 @@ static int watchdog_open(struct inode *inode, struct file *file)
>  	 * to be unloaded.
>  	 */
>  	hw_running = watchdog_hw_running(wdd);
> -	if (!hw_running && !try_module_get(wdd->ops->owner)) {
> -		err = -EBUSY;
> +	if (!hw_running && !try_module_get(wdd->ops->owner))
>  		goto out_clear;
> -	}
>  
>  	err = watchdog_start(wdd);
>  	if (err < 0)
> @@ -878,6 +877,7 @@ static int watchdog_open(struct inode *inode, struct file *file)
>  	 * applied.
>  	 */
>  	wd_data->open_deadline = KTIME_MAX;
> +	mutex_unlock(&wd_data->lock);
>  
>  	/* dev/watchdog is a virtual (and thus non-seekable) filesystem */
>  	return stream_open(inode, file);
> @@ -886,6 +886,8 @@ static int watchdog_open(struct inode *inode, struct file *file)
>  	module_put(wd_data->wdd->ops->owner);
>  out_clear:
>  	clear_bit(_WDOG_DEV_OPEN, &wd_data->status);
> +out_unlock:
> +	mutex_unlock(&wd_data->lock);
>  	return err;
>  }
>  
> -- 
> 2.37.2
> 
