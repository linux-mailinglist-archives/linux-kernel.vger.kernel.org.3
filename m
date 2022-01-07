Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410B54875AE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346878AbiAGKgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346811AbiAGKgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:36:39 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23349C0611FF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 02:36:37 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id p1so9368009uap.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 02:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PdULxgeJgX8+A1cdZ258MGjOqiluPf6EFrTzZ37jHOw=;
        b=LZcA3nUGjgfyqBPNVe0WTr7yH6LtHr4pPbD6WPCs7D6agcc5rs++0wOJESRnlBFv/p
         NtHPUripp1I5QlVhAXEX2NH7tSQc5LaqB+DxNuOEgwW6+/XOe24UshOh33xNVDcRfOwK
         06p9PwvzCYyx9PXFPZUyNF8G7IhlC3l1oVaEJM/NDhCqfwY5tGJddN3eDKyGzFuTpHha
         Q+Ox0C/2oUww9ydD0R9PTsghV9q9pVECsMlVXYBpmfoUWuPJsf7EN7XBRef4vqN31Vpx
         9KG2LKj8kYXJ3pQlPIUhLMT897M27KJ1VNV072Wzw/npE/6CdivNqXnd+igCJWPeC/5r
         SHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PdULxgeJgX8+A1cdZ258MGjOqiluPf6EFrTzZ37jHOw=;
        b=ey4JOtACMRk7YPuK00ZJh9OpYGqkmFojSMjal/208Jw6o52uE43dWNEiovwjmJSuOx
         MRE1UJrHTe8VAlftyNw3X+zvJVDZORN7OL+zUtUa6VMPiWgrDA5dpxCauhbc41m9JCyZ
         4PS1sHZRW8BLrCUT3p73xbROyjFRLIFVUJG2QdYXAjh++zlDaUsYsvd9M0ncVeQuDZ69
         Dsigf/jzdhluszd6+kLydLd+3utr5uFnQESIHfCZwgBy6bHVKI3xM7i+I/TqaV31W0cd
         Xmy3Ldq+UPH/dqq+56SdhtBEJtSAeopPXapppJmqLlzxkZi6stVz5Bo+qZ8NnS/T8l4Z
         wsuA==
X-Gm-Message-State: AOAM530mkYH5MYPaSFFjwCCrhJoU7uJKdBT9J8iiVLBy7ZKZsALd3d8+
        XNBqtowqp4IOIkWiOhUa91av7PpCIPKwaw==
X-Google-Smtp-Source: ABdhPJzeQinVyWPndd+8G2FDbxw+Vw/Uya4GsMOkBH0gI97jL36HuA3gU7z3alG7jx8vTazqddpWXQ==
X-Received: by 2002:a05:6102:736:: with SMTP id u22mr21042957vsg.60.1641551796284;
        Fri, 07 Jan 2022 02:36:36 -0800 (PST)
Received: from localhost.localdomain ([181.23.70.139])
        by smtp.gmail.com with ESMTPSA id g4sm2803896vkd.46.2022.01.07.02.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 02:36:35 -0800 (PST)
Date:   Fri, 7 Jan 2022 07:36:20 -0300
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, nsaenz@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        juerg.haefliger@canonical.com, rdunlap@infradead.org,
        dave.stevenson@raspberrypi.com, stefan.wahren@i2se.com,
        unixbhaskar@gmail.com, mitaliborkar810@gmail.com,
        phil@raspberrypi.com, len.baker@gmx.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: Re: [PATCH 5/6] staging: vc04_services: rename macros
 BM2835_MMAL_VERSION and BM2835_MMAL_MODULE_NAME
Message-ID: <YdgXpPS51cWgQY3a@localhost.localdomain>
References: <cover.1641414449.git.gascoar@gmail.com>
 <d450b9e22e5ab335a61591dbf0d2104031c9fc46.1641414449.git.gascoar@gmail.com>
 <YdbzKaKQW7N04QgA@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdbzKaKQW7N04QgA@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 02:48:25PM +0100, Greg KH wrote:
> On Wed, Jan 05, 2022 at 05:35:47PM -0300, Gaston Gonzalez wrote:
> > In the kernel, all names related to the chip BCM2835 are always named
> > bcm2835_*. To avoid confusion, and to make things more consistent,
> > rename the macros BM2835_MMAL_VERSION and BM2835_MMAL_MODULE_NAME
> > accordingly.
> > 
> > While at it, some realignments were made to improve readability.
> > 
> > Suggested-by: Stefan Wahren <stefan.wahren@i2se.com>
> > Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
> > ---
> >  .../vc04_services/bcm2835-camera/bcm2835-camera.c  | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> > index aaf529f2186c..c729b1b7de71 100644
> > --- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> > +++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> > @@ -33,8 +33,8 @@
> >  #include "mmal-parameters.h"
> >  #include "bcm2835-camera.h"
> >  
> > -#define BM2835_MMAL_VERSION "0.0.2"
> > -#define BM2835_MMAL_MODULE_NAME "bcm2835-v4l2"
> > +#define BCM2835_MMAL_VERSION "0.0.2"
> 
> MODULE_VERSION means nothing when the code is in the kernel tree, this
> shold just be removed entirely.
> 
> > +#define BCM2835_MMAL_MODULE_NAME "bcm2835-v4l2"
> 
> KBUILD_MODULE_NAME provides this, please delete this and just use that
> instead.
> 
> This can be 2 different commits because of this.
> 
> thanks,
> 
> greg k-h
> 

Hi Greg,

Thanks for reviewing.

Ok, will do.

Gaston
