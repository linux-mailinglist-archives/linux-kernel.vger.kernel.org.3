Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60FF48AFA4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242164AbiAKOgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240845AbiAKOgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:36:00 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD17C06173F;
        Tue, 11 Jan 2022 06:35:59 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id p12so18466970qvj.6;
        Tue, 11 Jan 2022 06:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R6SbhLZXTE9y0s9o09Kjn99I+DjMQbJ+T5cmQ6a+52M=;
        b=ZFff6+j1QVHHkEWKfORdsBwimZ67kiNyMYmTklHM0qo1IQV/zE8C1/NOQ6v78L8wLw
         LMXGIkZKiScMSFTRLG+2UFAMCMO981HrUpJXEAnJBLy8lBMBzyM2ZWtbrCNzKFAh5FLx
         UWr+MgHgviWf1o3NGtBYQvlCsXZtQYFxo7ePqkpnGLZZZTFh1QdzZjYZ5k2xG7sCOWLF
         braFDCyPHKn16T3YqvCgnDl2UzhC71bykNxXRhdbHBGQC57ZBM5CujwgNVCqpmiW5m9k
         tQO/5jt/k8McutDse48zKYJCSgn89e7EXJdnJOTbONUQvcQI8Y6kZGMxTqAYs9pnSD29
         4VjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R6SbhLZXTE9y0s9o09Kjn99I+DjMQbJ+T5cmQ6a+52M=;
        b=t8IMoY/saq4f1aXfmUXNj6eHATVvne5J8Lmm4uQwd/xACk1FT4dThA0u9R34rcEBDd
         +AoN3VSps8ae8IRmV+N5nk7HUmeCp4VJWcQ0OTUGxyLhmX/bPBPvCTYe6HIwOQTC2wRu
         aUx7LAD+E62LllOhznJ1sVuXX1EDZ6mxHsBCGxmwS3Jq/SaOio4LP4josWaLAVwBkrRf
         Coj5QsFRj+v5+ZbPwPi1Rz/GeXzAxkBdYFh7S9dQp88LfpImKjHUAGXstu2/OGQTEPUf
         FoHnz/QGWpJ1fwcle1VHsoydryLo1yQ4u3HXXz1QGKE24DA4AWv+zVmL5+1gifAs+9WZ
         KWmA==
X-Gm-Message-State: AOAM5317zkeOPSsBJSpzlHpNAFtIvdLIraUHzQ5HBaphKVKwGLvoC6q7
        dOxWIG905ODfvlD/pPPjxOk=
X-Google-Smtp-Source: ABdhPJzqPij37kVbCv9qrEOQ7BSX37ljJUP+rYaQs/1313I0RydKkHuo+xEBeLpaBMKJVjudhRw8Qw==
X-Received: by 2002:a05:6214:d0e:: with SMTP id 14mr3932730qvh.20.1641911758476;
        Tue, 11 Jan 2022 06:35:58 -0800 (PST)
Received: from shaak (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id r23sm6444786qkk.24.2022.01.11.06.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 06:35:57 -0800 (PST)
Date:   Tue, 11 Jan 2022 09:35:55 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v12 06/16] iio: afe: rescale: expose scale processing
 function
Message-ID: <Yd2Vy459hVq20xjV@shaak>
References: <20220108205319.2046348-1-liambeguin@gmail.com>
 <20220108205319.2046348-7-liambeguin@gmail.com>
 <CAHp75VdVBQPG0Qbo9H5Sro0-Uhr683WhWor9P2MXZ5a18HfRgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdVBQPG0Qbo9H5Sro0-Uhr683WhWor9P2MXZ5a18HfRgA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2022 at 03:07:58PM +0200, Andy Shevchenko wrote:
> On Sat, Jan 8, 2022 at 10:53 PM Liam Beguin <liambeguin@gmail.com> wrote:
> >
> > In preparation for the addition of kunit tests, expose the logic
> > responsible for combining channel scales.
> 
> ...
> 
> > +/*
> > + * Copyright (C) 2021 Liam Beguin <liambeguin@gmail.com>
> > + */
> 
> Despite the Rb tag by the author of the code the above is wrong.
> Please do not steal others work :-) (The smiley due to my believe that
> you have done this undeliberately)

Sorry about that was not my intention.
I'll replace with Peter's original copyright.

Cheers,
Liam

>  * IIO rescale driver
>  *
>  * Copyright (C) 2018 Axentia Technologies AB
>  *
>  * Author: Peter Rosin <peda@axentia.se>
> 
> -- 
> With Best Regards,
> Andy Shevchenko
