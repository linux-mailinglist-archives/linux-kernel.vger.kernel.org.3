Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB1247D7E6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345298AbhLVTmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhLVTmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:42:14 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073F2C061574;
        Wed, 22 Dec 2021 11:42:14 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id l17so2909810qtk.7;
        Wed, 22 Dec 2021 11:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r5plYkDKDQhkLjCFvQaIPKKi/bkznMOuAEcbc1q96jE=;
        b=cdv5W5aKxAgD7OFo+6buOuhuxg4SVAPYaZIAiu3wnE5kz2UOObg8AqvilUHM1GJMPj
         Bx0ZWvqPE4n7a9i27DRDuII3npxs7dck2N1SHui+T9/aayi9+IxivnjvaYrkTbrUz+K7
         R2htEu5XKVRD6C4UWfvDIYabzs6CWrTMZnGjvGJ8U4KhbOjnYjHJ/kCftqh6cx66czf+
         9FtFqRo7nihjnk1mt0AdLZHOwQdoLRua05zJhbb9KUWG0QlYCJr2pmhGcHthjdEtxB3U
         bGLecWkSibZsvgIawCs7lmdhyOjhZ0Ow8YjfOIuqo5tZnVX5ocx53fuiekJmtBbRVwzD
         XfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r5plYkDKDQhkLjCFvQaIPKKi/bkznMOuAEcbc1q96jE=;
        b=rrWIjP4FDMMp3cWhY0PFWLmhTL0Yvswf1OIIsoEg9kNcedOV0nd4LkCzJ7PIiMVwbT
         Rs2DXhNPF4+A7TIz81rZ54y71hjBIQJ5RPRbG5jiO8KUKqQ31ig/pVFdxyZ6KW5QGdqe
         jOScKecB1sIqQHh4GP5Ng2AlchnKU7AmJa6r0Mt2D5v3MfDcZyUZ0O3PxqjmVSGXFyev
         N33K8ptKksrLI8/IBUrxrI8zgR8FV3lZA5TW7Dtwbztksl1mtD5Qmnx4v1WNBEMtQW24
         6ar8F6O2kqkS07dKXH1ISIB0PbYUkhCb3Ahgf45rowPyW9BGvwNwOS2vLPu7A8s7WmUV
         on9w==
X-Gm-Message-State: AOAM531wOBG5TCKaWbOInNl/ANm3atltUgKs/e2PfiVFXckPUBHeTa9z
        SvRP2IaCxVCwZNMTHyJm1RQ=
X-Google-Smtp-Source: ABdhPJyxJWiGGi3Ni8qP0vVgP+6/LKLjawF/7omDc90qxOdts15hm53TwwDJ30g6cxVqZyFPgB1rUA==
X-Received: by 2002:a05:622a:50a:: with SMTP id l10mr3361160qtx.491.1640202133241;
        Wed, 22 Dec 2021 11:42:13 -0800 (PST)
Received: from shaak (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id u21sm2359241qke.95.2021.12.22.11.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 11:42:12 -0800 (PST)
Date:   Wed, 22 Dec 2021 14:42:10 -0500
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
Message-ID: <YcN/kkazUGyyazNF@shaak>
References: <20211222034646.222189-1-liambeguin@gmail.com>
 <20211222034646.222189-5-liambeguin@gmail.com>
 <CAHp75Vc009o5EunYP3QAB8up8hMrRL7oNax7cjphCFVUgSKXRw@mail.gmail.com>
 <YcNscJ/fQhI7h6Uq@shaak>
 <CAHp75Vf6iN7yEdubKFkf+fXupVTco-toZN=a5+KNXG4Yv6oT3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vf6iN7yEdubKFkf+fXupVTco-toZN=a5+KNXG4Yv6oT3Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 08:52:30PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 22, 2021 at 8:20 PM Liam Beguin <liambeguin@gmail.com> wrote:
> > On Wed, Dec 22, 2021 at 12:21:01PM +0200, Andy Shevchenko wrote:
> > > On Wed, Dec 22, 2021 at 5:46 AM Liam Beguin <liambeguin@gmail.com> wrote:
> 
> ...
> 
> > > >  #include <linux/iio/consumer.h>
> > > >  #include <linux/iio/iio.h>
> > > > +#include <linux/iio/afe/rescale.h>
> > >
> > > It should go before the consumer.h, no?
> >
> > I don't mind making the change, but why should it go before consumer.h?
> 
> 'a' is earlier than 'c' in the alphabet, no?
> 
> ...
> 
> > > And I would rather move the entire IIO group of headers...
> >
> > I can do that too. Do we have a convention for the ordering of #includes?
> > What's usually the rule/guideline for this?
> 
> Guidelines suggest sorting without clear instructions. But in IIO and
> pin control I suggest people use this kind of grouping.

Understood, will update.

> > > >  #include <linux/module.h>
> > > >  #include <linux/of.h>
> > > >  #include <linux/of_device.h>
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/property.h>
> > >
> > > ... somewhere here (with blank line above).
> > >
> > > > -struct rescale;
> 
> ...
> 
> > > Missed types.h and forward declarations like
> > > struct device;
> >
> > Okay. will add linux/types.h
> 
> What about forward declaration?

I'm not sure I understand what you mean here.

Cheers,
Liam

> -- 
> With Best Regards,
> Andy Shevchenko
