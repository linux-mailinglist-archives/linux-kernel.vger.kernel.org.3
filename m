Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDBF513F10
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 01:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353277AbiD1XcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 19:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbiD1XcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 19:32:07 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3F9BCB71
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 16:28:49 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q23so8667571wra.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 16:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AXuxilFt8bJ4TZzFoEehtqH1L61QxOPFeWD14sA1KQ4=;
        b=kVB3werFcuHON4QX+/OUCotuXYa3W3x13MoRWMIGj26V9rGs2dQ3RC0L4IVjEM/ugE
         PpT64lSYNqkTKIxDxpILxZoHX+wJ9nL1nV4g/hJ/e5nJIfPUXwFlX2CR1qYbCIHq2lf2
         Jriu6al3z6pQ806XQWQuNs1BvAxJyvPNYIHnAMmLbZEptYiLGtJ/6TtAPdlK2a5Z5Es1
         MqpIfH0nluvXRbRGG8ArFOvxsPdwBSff8V7cpoJcANPG3Q3/zKZWt7DkNhe9tyBtRWTW
         Xj5kuAdMxkVLiFTDAiE9trlEjdSupiLgss7UqQ3YZk2qQlk2EFO6EteZ2XOAp8bdYE6p
         P5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AXuxilFt8bJ4TZzFoEehtqH1L61QxOPFeWD14sA1KQ4=;
        b=UMpz6RgyOdSOWp3r/NNS6Jox8kD2uXxO+LtSmVOEWXtY/oPUAw3YwbThdTNRS49pLx
         vez8lmYQ+lal4ibd7EEn+S1TEwugtj8A3M89VIeeDetKbOAlauoD8x1aXnvJmdkm5+aS
         0RGRFnioE4AmeIZ2Y4oHdG3BNYI8/fWOOkvSlXn2OoUZkJh1oXIViAOZvG369Sjp5oLr
         j5yLVsypriP7WolulpdmyhOq71xv7sn4xcJTCoi2uzAj0mDGj8oSZ4f0EtG3yEZzPXPa
         wTecCn5RzXwOD00Qyqrus7mndX1Keswr1Dv5Zvd7/UuNzdGsI9BEWgsjc5yUVdxyoNKV
         P4yg==
X-Gm-Message-State: AOAM5325IKJEPFkZGuqWG4pHQC86PlmxLgnftxiwf8PkCCBiUQ4clyYO
        yf5qgZWgD4kL85HOWUrUJoifog==
X-Google-Smtp-Source: ABdhPJyLMnx0MArgAV/mK24K7aUqkpV2X3TMJIQ9RSnXzkai27jhSVBe+fph9u+WWElyurpBPsNCOA==
X-Received: by 2002:a05:6000:124a:b0:20a:df42:3d4e with SMTP id j10-20020a056000124a00b0020adf423d4emr16141395wrx.33.1651188528248;
        Thu, 28 Apr 2022 16:28:48 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id g13-20020a5d64ed000000b0020a9e488976sm1061761wri.25.2022.04.28.16.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 16:28:47 -0700 (PDT)
Date:   Fri, 29 Apr 2022 00:28:45 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] cdrom: remove the unused driver specific disc change
 ioctl
Message-ID: <YmsjLd5wuWE06dDl@equinox>
References: <20220427132436.12795-1-paul.gortmaker@windriver.com>
 <20220427132436.12795-2-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427132436.12795-2-paul.gortmaker@windriver.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 09:24:33AM -0400, Paul Gortmaker wrote:
> This was only used by the ide-cd driver, which went away in
> commit b7fb14d3ac63 ("ide: remove the legacy ide driver")
> so we might as well take advantage of that and get rid of
> this hook as well.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Phillip Potter <phil@philpotter.co.uk>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  Documentation/cdrom/cdrom-standard.rst | 10 ----------
>  drivers/cdrom/cdrom.c                  |  8 --------
>  include/linux/cdrom.h                  |  1 -
>  3 files changed, 19 deletions(-)
> 
> diff --git a/Documentation/cdrom/cdrom-standard.rst b/Documentation/cdrom/cdrom-standard.rst
> index 52ea7b6b2fe8..7964fe134277 100644
> --- a/Documentation/cdrom/cdrom-standard.rst
> +++ b/Documentation/cdrom/cdrom-standard.rst
> @@ -218,7 +218,6 @@ current *struct* is::
>  		int (*tray_move)(struct cdrom_device_info *, int);
>  		int (*lock_door)(struct cdrom_device_info *, int);
>  		int (*select_speed)(struct cdrom_device_info *, int);
> -		int (*select_disc)(struct cdrom_device_info *, int);
>  		int (*get_last_session) (struct cdrom_device_info *,
>  					 struct cdrom_multisession *);
>  		int (*get_mcn)(struct cdrom_device_info *, struct cdrom_mcn *);
> @@ -419,15 +418,6 @@ this `auto-selection` capability, the decision should be made on the
>  current disc loaded and the return value should be positive. A negative
>  return value indicates an error.
>  
> -::
> -
> -	int select_disc(struct cdrom_device_info *cdi, int number)
> -
> -If the drive can store multiple discs (a juke-box) this function
> -will perform disc selection. It should return the number of the
> -selected disc on success, a negative value on error. Currently, only
> -the ide-cd driver supports this functionality.
> -
>  ::
>  
>  	int get_last_session(struct cdrom_device_info *cdi,
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 2dc9da683a13..0a858bfea849 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -2443,14 +2443,6 @@ static int cdrom_ioctl_select_disc(struct cdrom_device_info *cdi,
>  			return -EINVAL;
>  	}
>  
> -	/*
> -	 * ->select_disc is a hook to allow a driver-specific way of
> -	 * seleting disc.  However, since there is no equivalent hook for
> -	 * cdrom_slot_status this may not actually be useful...
> -	 */
> -	if (cdi->ops->select_disc)
> -		return cdi->ops->select_disc(cdi, arg);
> -
>  	cd_dbg(CD_CHANGER, "Using generic cdrom_select_disc()\n");
>  	return cdrom_select_disc(cdi, arg);
>  }
> diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
> index 0a89f111e00e..67caa909e3e6 100644
> --- a/include/linux/cdrom.h
> +++ b/include/linux/cdrom.h
> @@ -77,7 +77,6 @@ struct cdrom_device_ops {
>  	int (*tray_move) (struct cdrom_device_info *, int);
>  	int (*lock_door) (struct cdrom_device_info *, int);
>  	int (*select_speed) (struct cdrom_device_info *, int);
> -	int (*select_disc) (struct cdrom_device_info *, int);
>  	int (*get_last_session) (struct cdrom_device_info *,
>  				 struct cdrom_multisession *);
>  	int (*get_mcn) (struct cdrom_device_info *,
> -- 
> 2.33.0
> 

Hi Paul,

Thanks for the patch, looks good. I'll send onto Jens during the next
merge window.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
