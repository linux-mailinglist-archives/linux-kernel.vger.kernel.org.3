Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D911548AFCF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242508AbiAKOnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbiAKOnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:43:53 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08782C06173F;
        Tue, 11 Jan 2022 06:43:53 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 15so3375246qvp.12;
        Tue, 11 Jan 2022 06:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1VSQxPEnyKxjPycIz8yIdliFZqgD/ZbY2jUfYCItQXE=;
        b=e0BZU1usKUdamK1k5Ht+R/+7td3nOKWgPXOrIQUgKJ6LDA8OaOS0pvjL85Ch8M6CRc
         I86tsG4/Quhuubfod2BmYyRgdL0mxd0TCEBoBZ2PGOXLwP7B6LzhpNKTfdH0yVrdqvNj
         JmAOPgevOm8QOk9tPSLFTaLwfy4ZSBOW6vFdQ3Vp9EIVC7SHCSQS8NFRpsQduSdGoo8Y
         fmCqogcDNu1aMx4YCwMb5UuF28OGFi4xbqITDqCVATTAQ1Sm6vH7B2kwkJAGCcUXf/+E
         IlzfJPRFKRDY9tsedjCkmWKdsFG7XogzJrdm4B56q0Dt29eHmC/pvqJyCtqPDHDK215+
         fhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1VSQxPEnyKxjPycIz8yIdliFZqgD/ZbY2jUfYCItQXE=;
        b=kxAgj/n2vVdIuyMfo3l9AVnGLtT3zLvcdYt4OMPAANI/AglpRM1rUNpiOLiNUPj+Uf
         Y2NK6kcI+A/GUSxaE4Xo6ajYuwSpSzWze6rOgtI59XGB7XRRd5sBOJ8VR25fjORgoum6
         0Za8ll7Lso4nG5fMUNQ8D53yC4moLjvLTC1wRxDWqFx8mKSN+xKTro6m361DulYHCZI8
         sgGA08v6HtTRxfHRdn57ZIKAHrqEtTtXDVNU2h6NWJdGVc+uxeOykFxMh2E5hW1+yL+V
         nE9NqlpSvqLFCfIsZwvDaxp/Bf0wYhJSdQeXYzIgLyr9nCZZOlYb2VkpZ0EekbCeJlkY
         pkrw==
X-Gm-Message-State: AOAM530pyTO5n8hyLTuoyA3SmtIkAFNi4yhxV6+t7ZyoaVeXKD9XagTH
        p+zrOBJ6x/z9Q+TRN9s9m9U=
X-Google-Smtp-Source: ABdhPJzN69V45Ry4h9LVVfj/OBYrKHAGt/8ewnQQrINr4Yq0TGldOs4GMC29uYMruU0w/LNDhXrw+g==
X-Received: by 2002:a05:6214:76a:: with SMTP id f10mr4301105qvz.54.1641912232213;
        Tue, 11 Jan 2022 06:43:52 -0800 (PST)
Received: from shaak (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id w12sm2457798qtj.64.2022.01.11.06.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 06:43:51 -0800 (PST)
Date:   Tue, 11 Jan 2022 09:43:49 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v12 06/16] iio: afe: rescale: expose scale processing
 function
Message-ID: <Yd2XpUgKzqYnZVdS@shaak>
References: <20220108205319.2046348-1-liambeguin@gmail.com>
 <20220108205319.2046348-7-liambeguin@gmail.com>
 <CAHp75VdVBQPG0Qbo9H5Sro0-Uhr683WhWor9P2MXZ5a18HfRgA@mail.gmail.com>
 <25cab0ad-f282-9cf8-df8a-1d288cb80cd1@axentia.se>
 <0eaf35a7-20cc-408f-5df1-978cff99f629@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0eaf35a7-20cc-408f-5df1-978cff99f629@axentia.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2022 at 09:25:53PM +0100, Peter Rosin wrote:
> 
> 
> On 2022-01-09 21:19, Peter Rosin wrote:
> > On 2022-01-09 14:07, Andy Shevchenko wrote:
> >> On Sat, Jan 8, 2022 at 10:53 PM Liam Beguin <liambeguin@gmail.com> wrote:
> >>>
> >>> In preparation for the addition of kunit tests, expose the logic
> >>> responsible for combining channel scales.
> >>
> >> ...
> >>
> >>> +/*
> >>> + * Copyright (C) 2021 Liam Beguin <liambeguin@gmail.com>
> >>> + */
> >>
> >> Despite the Rb tag by the author of the code the above is wrong.
> >> Please do not steal others work :-) (The smiley due to my believe that
> >> you have done this undeliberately)
> >>
> >>  * IIO rescale driver
> >>  *
> >>  * Copyright (C) 2018 Axentia Technologies AB
> >>  *
> >>  * Author: Peter Rosin <peda@axentia.se>
> >>
> > 
> > For the record, I did notice this myself but did let it slide. It's only
> > a trivial header, and is it even copyrightable? Shrug...
> 
> Oh, and by the way Liam, feel free to add a copyright line to the
> iio-rescale.c file somewhere in the series if you like (if you didn't
> already). You've certainly deserved it...

Thanks Peter! Sure, I'll add it somewhere in the series.

Cheers,
Liam

> Cheers,
> Peter
