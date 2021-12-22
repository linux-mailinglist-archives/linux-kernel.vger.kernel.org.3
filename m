Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAB047D815
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345364AbhLVT7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345346AbhLVT7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:59:03 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2913C061574;
        Wed, 22 Dec 2021 11:59:02 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id a9so3260270qvd.12;
        Wed, 22 Dec 2021 11:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0glwfJ1+6hPNLqILfcBccYJ9Fimpt8DeheiL8u4NZ7w=;
        b=nvaD1ClkgEPQILfuamlGvxIS40pE2PZWmPwJRfysBVP2QreaX1hxbnaQCk5XQNLQpD
         K6prAqDaR4dG5Om3vp5UveFGvOt8lf9WJumgq4regGVxpSRs+B95r1oQ3Z5OovasQ3Gb
         +BtDwm0Iep/soYnXm3BU+407w53PsbuIO5UOjOUEIM/Lom2U0S6/zUktwZAJLrzzlGHn
         mn6dCZ5Cd1wDkPAR+RDkcoFrXEHnBErFhdPWx4rthIxlRkTRkAq4IHvygoadnqEVKYpI
         EVtc/k2Eflf0OauSNYadLjVHNt7PXGmigSE0x7ROOx2Jctty+aNflVGV2AELiQTaqWGd
         V94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0glwfJ1+6hPNLqILfcBccYJ9Fimpt8DeheiL8u4NZ7w=;
        b=fyrkcY334M3kCW1XnZi4u0txuX4+g/FeBKqMOs1CItVdAnxfNUFZQtfPPdWwoeHna8
         4LpJr53cTBh7ZGe+61J9GiRSQb6GxPa/lA6jF2BCzQk0TsMV2wErY+YUcrg2300W9Wck
         7jT8BpAkOgU7/LQhb+URINVX+V1rXg+jj/4OMG8SGCazBSlCq9BvfHq8FV9vFnKucjJU
         PAF5aYdl/T+t6ISB3eS9CbIV41Q0FGhsF44/bTpqaL0l9XeBMVRfi3yLQneUyXUIa9GS
         7+bHGE0ukkb7nen4oJkwAotB4BTAJOxFgpnUaH3kjoOZ5/LOPuHqhOgqoGUfJkhuX9Xm
         0x2g==
X-Gm-Message-State: AOAM533NLyE6ZLkxTAYfNIJ3HJahYoSgBRzOxF+tYNf/o811Ds1MG4g9
        e3mFCqmW7HrLV15+vNCGG/c=
X-Google-Smtp-Source: ABdhPJz4/qtvHmEMYnGaHwGIVAm0B3yFhw67iqoCZx70WSTaDXgXri6jlP9pvdWSHmqHEvGMMhwAuw==
X-Received: by 2002:a05:6214:21e9:: with SMTP id p9mr3785717qvj.100.1640203142029;
        Wed, 22 Dec 2021 11:59:02 -0800 (PST)
Received: from shaak (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id bm35sm2644916qkb.86.2021.12.22.11.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 11:59:01 -0800 (PST)
Date:   Wed, 22 Dec 2021 14:58:58 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v11 09/15] iio: afe: rescale: reduce risk of integer
 overflow
Message-ID: <YcODglDWiknz2oeV@shaak>
References: <20211222034646.222189-1-liambeguin@gmail.com>
 <20211222034646.222189-10-liambeguin@gmail.com>
 <CAHp75Vc0aWrFtNK1ZkHkwP62zNXQJaDcn9pc8Uhfq0kOnWzmJg@mail.gmail.com>
 <YcNwt5RFMNFUimD/@shaak>
 <CAHp75VdrLTNLWZRgWkLXD23RAF28zh29XybywAPyMtb=GNxXbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdrLTNLWZRgWkLXD23RAF28zh29XybywAPyMtb=GNxXbw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 08:56:12PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 22, 2021 at 8:38 PM Liam Beguin <liambeguin@gmail.com> wrote:
> > On Wed, Dec 22, 2021 at 02:29:04PM +0200, Andy Shevchenko wrote:
> > > On Wed, Dec 22, 2021 at 5:47 AM Liam Beguin <liambeguin@gmail.com> wrote:
> 
> ...
> 
> > > > -               tmp = 1 << *val2;
> > >
> > > At some point this should be BIT()
> 
> Forgot to add, If it's 64-bit, then BIT_ULL().
> 
> > I'm not against changing this, but (to me at least) 1 << *val2 seems
> > more explicit as we're not working with bitfields. No?
> 
> You may add a comment. You may use int_pow(), but it will be suboptimal.
> 
> > > Rule of thumb (in accordance with C standard), always use unsigned
> > > value as left operand of the _left_ shift.
> >
> > Right, that makes sense! In practice though, since we'll most likely
> > never use higher bits of *val2 with IIO_VAL_FRACTIONAL_LOG2, would it be
> > enough to simply typecast?
> >
> >         tmp = 1 << (unsigned int)*val2;
> 
> No, it's about the _left_ operand.
> I haven't checked if tmp is 64-bit, then even that would be still wrong.

Okay so your recommendation is to not use a left shift?

I can look into that but given how unlikely it is to fall into those bad
cases, I'd rather keep things as they are. Would that be okay?

Also, I don't think using BIT() or BIT_ULL() would address this as they
both do the same shift, with no extra checks.

Cheers,
Liam

> -- 
> With Best Regards,
> Andy Shevchenko
