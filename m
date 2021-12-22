Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690B447D669
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344572AbhLVSUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhLVSUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:20:38 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777ABC061574;
        Wed, 22 Dec 2021 10:20:38 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id l17so2701415qtk.7;
        Wed, 22 Dec 2021 10:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nE81ujb6OmoPtIGC2vwOgu441bnmiMYHv33pIJNjxXM=;
        b=a+8t54TA0h6q1QRbxVEiuA7iBhJd3+sdf5jvdegQWzDd8jwFbZTuVugkotOxLtA3Gv
         GLvjzrn0TCCcx/JCjQyTa+3weU6iaHOeeen45jjHNBCv63tktH5VqCGbwKegQKwNaGUA
         btF2fsP20zHPTpTzkvIg/a1+fWrqHDJHaFJrYPP+jPsFO/LE2zmfzhH7Q7cr71YcOEYC
         PiLXPcD+ImAQgx/8fag8M3iEXml+DfnHKZHYfIgUo9SPKJlKCaoBpfS+j5ln4LpN0ztq
         v1TQOO+BZcwfItZ6MxFXHM/9J3+CIouQlV+QrygdhjHHTQmXskCUttJLa/q1C94txZ+o
         D10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nE81ujb6OmoPtIGC2vwOgu441bnmiMYHv33pIJNjxXM=;
        b=k8z/0VGr7SidT0htE1cSzRNzYsZegdsSU1B4MJ1l1zWzGQScMJ8ieGva5QLnKoU5nG
         78xHe6VDzVl8rhQsaTVY3jAiO9ED60Ck11g0+xtdDKQBrpY3t59VHelw39qvPBX4xYOm
         JraYorK4QL/Wznff4n4jnAXr/AFfsEoOoaboVLGK1F+/YRqtQVBlgugJZjUk4etVxF1Q
         1ydhZJjJ6y8qHKr+BxKX3Ll7HuDVmFN3uCupzpqag0HSEu/USZsjZB4BeBJ0n/aFNrTw
         qV9tXglAYdPJz+KnGWxI53cylGNyPtTBZDRe4VU020wtGP6132y5cJWFZ0DKWv/nY4qv
         8IrA==
X-Gm-Message-State: AOAM533PaJ59Y/zZ6fQFZMGNjNIqNU/+RtFmabQiKqC54vpsNcWgapw5
        qx0VZ82vFFneQL9dZ15fTyk=
X-Google-Smtp-Source: ABdhPJymXvYVqa076ox4DDt3Mhp8PglCNBk265y6xXNkc3Y8cGlhE9mv67NO5hmRs9rc8tsq29teWQ==
X-Received: by 2002:ac8:5fcc:: with SMTP id k12mr3256383qta.217.1640197236454;
        Wed, 22 Dec 2021 10:20:36 -0800 (PST)
Received: from shaak (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id bk25sm2365949qkb.13.2021.12.22.10.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:20:35 -0800 (PST)
Date:   Wed, 22 Dec 2021 13:20:32 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v11 04/15] iio: afe: rescale: expose scale processing
 function
Message-ID: <YcNscJ/fQhI7h6Uq@shaak>
References: <20211222034646.222189-1-liambeguin@gmail.com>
 <20211222034646.222189-5-liambeguin@gmail.com>
 <CAHp75Vc009o5EunYP3QAB8up8hMrRL7oNax7cjphCFVUgSKXRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vc009o5EunYP3QAB8up8hMrRL7oNax7cjphCFVUgSKXRw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Wed, Dec 22, 2021 at 12:21:01PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 22, 2021 at 5:46 AM Liam Beguin <liambeguin@gmail.com> wrote:
> >
> > From: Liam Beguin <lvb@xiphos.com>
> >
> > In preparation for the addition of kunit tests, expose the logic
> > responsible for combining channel scales.
> 
> ...
> 
> >  #include <linux/gcd.h>
> >  #include <linux/iio/consumer.h>
> >  #include <linux/iio/iio.h>
> > +#include <linux/iio/afe/rescale.h>
> 
> It should go before the consumer.h, no?

I don't mind making the change, but why should it go before consumer.h?

> And I would rather move the entire IIO group of headers...

I can do that too. Do we have a convention for the ordering of #includes?
What's usually the rule/guideline for this?

> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/property.h>
> 
> ... somewhere here (with blank line above).
> 
> >
> > -struct rescale;
> 
> ...
> 
> > +#ifndef __IIO_RESCALE_H__
> > +#define __IIO_RESCALE_H__
> > +
> > +#include <linux/iio/iio.h>
> 
> Missed types.h and forward declarations like
> struct device;

Okay. will add linux/types.h

Cheers,
Liam

> -- 
> With Best Regards,
> Andy Shevchenko
