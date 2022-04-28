Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7096C513F13
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 01:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353292AbiD1XfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 19:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbiD1XfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 19:35:23 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1126780216
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 16:32:07 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id bg25so3746356wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 16:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U18JmttrWXC+dMo65uq1AVze/9tijl7gVBdfgYMLOyc=;
        b=dX9s//oHOCgopIuh3/A/jI+WEXOGKTKLEl1fzmJAb9QtU1665WwAQNu/TnAhm50dnd
         SZeauD6KXsQ1PXfV705MgU640OoFev6np8mR5Z8sPGZ1APl3djuoXdw460r937n2mjqo
         pIFTa7dVYqZ2+92z9GRM+6J7S003TEFajVvD3HT7Ms755YkKGGAQGXEKXFcIug1kceLs
         vqpGjUQztPBzJX42bsMmDQbckFmMr1ptJOdf6ceQpDx9PoGERjx9o8adaHEamHR06mNX
         PRVDPwEC9kKpXxc79wjKG3h+PNmS28HpyHsF8jbi29NxoNpwSPrITsPRdQefUqSU7lm+
         4vrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U18JmttrWXC+dMo65uq1AVze/9tijl7gVBdfgYMLOyc=;
        b=QEHxm2/ZJrc80Kh8svD3yBMUz3hX23NKaXtGCy5PQDWLmw11OjpWibHIzz+3jbcXt2
         +RMmRhJS6+SX6Fc5TFjHTLZIjgbHYfhInoJHFskYwqDr5tRcAWGXACwMw+x9mNP7Y2Be
         HuDc3cAnBMtlJSYcHCktViI6O9qNmNc5oE5XdH2vhzSf1toybt7ItpZlW7e8ZA6HdHwj
         bDUv/VOHi0hY1skKqMNDRtgaNwxfQM6Nz5CcMfFkTFK1dQnjXVnFhSfVa+WbQDo5ZOLt
         F5UgUNLiWuJcSzKgPbx42H7miRz2A19806Pi8kVX6ACsbXNBTDuDf/xlvl89IR2fSBcw
         bN6A==
X-Gm-Message-State: AOAM531Y4/buwPNOWUh+tUEOv2MvYE+wYPUZwApDWsWOZx0+i9OajYam
        ULkkBmPqquC859bbZbgK8AvwbJcUpz+qo94s
X-Google-Smtp-Source: ABdhPJzeLS0evOGxFcyadWvNaI6tE7OR9+Bv6XXsfNEOqOFDlQEkwhUCDFe5/ZOEPsY0FtRHk0uWXQ==
X-Received: by 2002:a05:600c:4f54:b0:392:9267:7930 with SMTP id m20-20020a05600c4f5400b0039292677930mr488739wmq.63.1651188725615;
        Thu, 28 Apr 2022 16:32:05 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id g20-20020a7bc4d4000000b003941f18086dsm95913wmk.30.2022.04.28.16.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 16:32:05 -0700 (PDT)
Date:   Fri, 29 Apr 2022 00:32:03 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] cdrom: mark CDROMGETSPINDOWN/CDROMSETSPINDOWN
 obsolete
Message-ID: <Ymsj8wJ/T/vxsVu+@equinox>
References: <20220427132436.12795-1-paul.gortmaker@windriver.com>
 <20220427132436.12795-3-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427132436.12795-3-paul.gortmaker@windriver.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 09:24:34AM -0400, Paul Gortmaker wrote:
> These were only implemented by the IDE CD driver, which has since
> been removed.  Given that nobody is likely to create new CD/DVD
> hardware (and associated drivers) we can mark these appropriately.
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Phillip Potter <phil@philpotter.co.uk>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  Documentation/userspace-api/ioctl/cdrom.rst | 6 ++++++
>  include/uapi/linux/cdrom.h                  | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/ioctl/cdrom.rst b/Documentation/userspace-api/ioctl/cdrom.rst
> index 682948fc88a3..2ad91dbebd7c 100644
> --- a/Documentation/userspace-api/ioctl/cdrom.rst
> +++ b/Documentation/userspace-api/ioctl/cdrom.rst
> @@ -718,6 +718,9 @@ CDROMPLAYBLK
>  
>  
>  CDROMGETSPINDOWN
> +	Obsolete, was ide-cd only
> +
> +
>  	usage::
>  
>  	  char spindown;
> @@ -736,6 +739,9 @@ CDROMGETSPINDOWN
>  
>  
>  CDROMSETSPINDOWN
> +	Obsolete, was ide-cd only
> +
> +
>  	usage::
>  
>  	  char spindown
> diff --git a/include/uapi/linux/cdrom.h b/include/uapi/linux/cdrom.h
> index 804ff8d98f71..011e594e4a0d 100644
> --- a/include/uapi/linux/cdrom.h
> +++ b/include/uapi/linux/cdrom.h
> @@ -103,7 +103,7 @@
>  #define CDROMREADALL		0x5318	/* read all 2646 bytes */
>  
>  /* 
> - * These ioctls are (now) only in ide-cd.c for controlling 
> + * These ioctls were only in (now removed) ide-cd.c for controlling
>   * drive spindown time.  They should be implemented in the
>   * Uniform driver, via generic packet commands, GPCMD_MODE_SELECT_10,
>   * GPCMD_MODE_SENSE_10 and the GPMODE_POWER_PAGE...
> -- 
> 2.33.0
> 

Same for this one, looks good, will send on. Many thanks.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
