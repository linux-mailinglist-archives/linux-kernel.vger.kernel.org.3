Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C265A7DE9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiHaMtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiHaMtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:49:32 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6973D41B1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:49:19 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l5so10139753pjy.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=yA2/9N4xi7ZPMoKFpntu3pK2hkjpVar1Y2ui8GJz2Bw=;
        b=B9hpPhTzmoRRaDHOU388irP8AqHxgSbN2C+MlGBd8UIjtP9cjgHAMms59dUT2nDrxU
         fONvO+tyRd5J0wISJtbDMlCxydGMoniRKie9WqVVKQ2wFwLBia4Nj5P2oJVJvuNdl5Hu
         LQP5tK0bbOJlSpbEwVMsFitwFQ8Eh5Y1W7bMUjb/j5g0UdkZZz63SDuTuEMVgG9WgmkI
         Wg9BDIsgLSf9FJwvay9FEX9cZAV60VTdO2eziooXss1uwwUVlNgyD0nCgNywsu/jfM42
         I784KgwJjS2HEpRODRgtLZlC4LixlsLdzl2O4sRFHvVb8zEovUtM+wyXmqqnmrzXRDbH
         As8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=yA2/9N4xi7ZPMoKFpntu3pK2hkjpVar1Y2ui8GJz2Bw=;
        b=5Bflug9bMKERPrjsmFPjpezJ0ciGeM4IfVzdSSD0Ks7Mazes2wmabspWChB0nR2RRk
         6rLbnWpNp5J8FjL2cZyyaKnlV8hVHq0mhdcB4rwgb8X1q7e/jKTu9zaBbShpYgwa2Ff+
         mTUO9sG5xPIxKoVz43m7OzgnJ8x/fSPBETMS9J+YNjLqc841+TkvScHwzVcJQ7zoLIOO
         6rOTXzSO81kpYEJXR/JqlVLEBZcRWubdWMF03/3FxioxFIyCz5twiQnbcqmB5C3E6Kzl
         XjZ0tRMBh6tlgFWv+ex7osPoCA0SsN6/SPqaDkatgqL7YqMnay3VPdVR8ajW0opVvaaw
         ZNmg==
X-Gm-Message-State: ACgBeo1OR8Sd7BlYoERBEHzGuJACKc25epPfihqO47I7rXJ9VEmBjSMY
        Ap8B/WQvLDMMYrDYPItZzUbWlaTw+cg=
X-Google-Smtp-Source: AA6agR6zhAELrP9TI9cvm1M3hfV7uqEmoECW4QhhfZi3I8k84nKDZWvEP+QsUyyzob/QyFbDfOh64A==
X-Received: by 2002:a17:902:b184:b0:172:766e:7f35 with SMTP id s4-20020a170902b18400b00172766e7f35mr25397505plr.174.1661950158051;
        Wed, 31 Aug 2022 05:49:18 -0700 (PDT)
Received: from carlis-virtual-machine ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id x128-20020a623186000000b005379dd2deb5sm11165664pfx.137.2022.08.31.05.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 05:49:14 -0700 (PDT)
Date:   Wed, 31 Aug 2022 20:49:06 +0800
From:   <zhangxuezhi3@gmail.com>
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     hsweeten@visionengravers.com, gregkh@linuxfoundation.org,
        zhangxuezhi1@coolpad.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] comedi: sysfs: convert sysfs snprintf to sysfs_emit
Message-ID: <20220831204906.730b0363@carlis-virtual-machine>
In-Reply-To: <0a0e568e-e3fc-56da-8370-e4796b480fe3@mev.co.uk>
References: <20220831121456.210835-1-zhangxuezhi3@gmail.com>
        <0a0e568e-e3fc-56da-8370-e4796b480fe3@mev.co.uk>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2022 13:33:18 +0100
Ian Abbott <abbotti@mev.co.uk> wrote:

> On 31/08/2022 13:14, Xuezhi Zhang wrote:
> > From: zhangxuezhi1 <zhangxuezhi1@coolpad.com>
> > 
> > Fix up all sysfs show entries to use sysfs_emit
> > 
> > Signed-off-by: zhangxuezhi1 <zhangxuezhi1@coolpad.com>  
> 
> The patch looks fine apart from the Signed-off-by line.  Please use a 
> proper name for the Signed-off-by line.  Generally, a romanized
> version of the forename(s) (given name(s)) followed by the surname
> (family name) is preferred, for example: Xuezhi Zhang.
> 
> Could you please post a "PATCH v2" with a proper Signed-off-by line? 
> Thanks.
Hi,
  OK, I see.

Thanks.

> > ---
> >   drivers/comedi/comedi_fops.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/comedi/comedi_fops.c
> > b/drivers/comedi/comedi_fops.c index 55a0cae04b8d..e2114bcf815a
> > 100644 --- a/drivers/comedi/comedi_fops.c
> > +++ b/drivers/comedi/comedi_fops.c
> > @@ -396,7 +396,7 @@ static ssize_t max_read_buffer_kb_show(struct
> > device *csdev, mutex_unlock(&dev->mutex);
> >   
> >   	comedi_dev_put(dev);
> > -	return snprintf(buf, PAGE_SIZE, "%u\n", size);
> > +	return sysfs_emit(buf, "%u\n", size);
> >   }
> >   
> >   static ssize_t max_read_buffer_kb_store(struct device *csdev,
> > @@ -452,7 +452,7 @@ static ssize_t read_buffer_kb_show(struct
> > device *csdev, mutex_unlock(&dev->mutex);
> >   
> >   	comedi_dev_put(dev);
> > -	return snprintf(buf, PAGE_SIZE, "%u\n", size);
> > +	return sysfs_emit(buf, "%u\n", size);
> >   }
> >   
> >   static ssize_t read_buffer_kb_store(struct device *csdev,
> > @@ -509,7 +509,7 @@ static ssize_t max_write_buffer_kb_show(struct
> > device *csdev, mutex_unlock(&dev->mutex);
> >   
> >   	comedi_dev_put(dev);
> > -	return snprintf(buf, PAGE_SIZE, "%u\n", size);
> > +	return sysfs_emit(buf, "%u\n", size);
> >   }
> >   
> >   static ssize_t max_write_buffer_kb_store(struct device *csdev,
> > @@ -565,7 +565,7 @@ static ssize_t write_buffer_kb_show(struct
> > device *csdev, mutex_unlock(&dev->mutex);
> >   
> >   	comedi_dev_put(dev);
> > -	return snprintf(buf, PAGE_SIZE, "%u\n", size);
> > +	return sysfs_emit(buf, "%u\n", size);
> >   }
> >   
> >   static ssize_t write_buffer_kb_store(struct device *csdev,  
> 

