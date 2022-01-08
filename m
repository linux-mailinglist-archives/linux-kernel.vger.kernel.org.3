Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B544948848B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 17:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbiAHQe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 11:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiAHQe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 11:34:56 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101CAC06173F;
        Sat,  8 Jan 2022 08:34:56 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id c15so8540733qtc.4;
        Sat, 08 Jan 2022 08:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ir0fUBlJOSxIKJ5kZssUGKPR5Sf2B0VkC+VrvjdSBaM=;
        b=KtEIObBVBgUUq62VNIUSeZ5W2yR2/dw7e8HJu6LnPPpvfyFHfRifjjibMqwvS6wosP
         JnXln5aKPkjmwth1AJfix/kXTyfj1gSZsVWHxvlTtl2I4ynEsbUnEmil3XV6tlKmB3JH
         M21QokQZZ7P3MHzEffD7yCJ248o20YOdqzeZZJbgsIVN21QP8KKlJ3CjIJjPr9O4s4Fy
         H8BYXsdvXazUntCMhXAvyk+13pzcyy3njcLvY81HC0AE6pzxK6iF1lFendL2i+muDOFT
         rCDy/ChVrM0tGtuURQrs2ZdeMAnE82sXQJfs8Z9Mrmh0cR+tTExn8hWfrVw/CSe53ClZ
         62Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ir0fUBlJOSxIKJ5kZssUGKPR5Sf2B0VkC+VrvjdSBaM=;
        b=mI7RUN43YlnAhADP+mq9e3u8jQfwz+UOYMF0kUsgS7gceea6lVqNptpDotR02o7/iu
         65Q+9tUtC3LGH5VJMpNGvFHG4PswRfCehlbxLtA859TmLMpLO7Na54mNM7dz6cyboisr
         bl7dYndLnGO8AWqKgSwt6c38wEvi8hJdfGrYzeohluTmAU29jvdOM3IVt42Hjjwaeqd1
         9XWiWIzF2SBz9++FBAsTSrnZ3Z7mPDyFrl3MTsZ9eZCAG4nqkozaozyImx+T64sgs1Ne
         flGZzrzxvNE1hv/VF4ItFKGLA2BSBPi7a/9FpMLgUZDOvuBtUWYpyM6Qw2bHqupdvowJ
         c0sg==
X-Gm-Message-State: AOAM5310rgt/+oyC4yVjQvjNLKTh3oI62PkPOcGlfg1ZyKrKVS7zeHI9
        41K6RwwE70pZAZ1qFV4REeo=
X-Google-Smtp-Source: ABdhPJy20tpp8O0kcl4aDH3SX+8JaeJaoDFyiNgwGe1V587lbQ99xsZ30YXqamGXPwAImXhrRiMpjA==
X-Received: by 2002:ac8:758b:: with SMTP id s11mr60096920qtq.51.1641659695139;
        Sat, 08 Jan 2022 08:34:55 -0800 (PST)
Received: from shaak (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id q25sm1215898qkj.102.2022.01.08.08.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 08:34:54 -0800 (PST)
Date:   Sat, 8 Jan 2022 11:34:51 -0500
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
Message-ID: <Ydm9K3Zx3jPPv70B@shaak>
References: <20211222034646.222189-1-liambeguin@gmail.com>
 <20211222034646.222189-10-liambeguin@gmail.com>
 <CAHp75Vc0aWrFtNK1ZkHkwP62zNXQJaDcn9pc8Uhfq0kOnWzmJg@mail.gmail.com>
 <YcNwt5RFMNFUimD/@shaak>
 <CAHp75VdrLTNLWZRgWkLXD23RAF28zh29XybywAPyMtb=GNxXbw@mail.gmail.com>
 <YcODglDWiknz2oeV@shaak>
 <CAHp75Vejfr_S7iK7fAvs7ELxE1TJUECvmKv0-G5Zwunyc6nDQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vejfr_S7iK7fAvs7ELxE1TJUECvmKv0-G5Zwunyc6nDQA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Wed, Dec 22, 2021 at 11:32:24PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 22, 2021 at 9:59 PM Liam Beguin <liambeguin@gmail.com> wrote:
> > On Wed, Dec 22, 2021 at 08:56:12PM +0200, Andy Shevchenko wrote:
> > > On Wed, Dec 22, 2021 at 8:38 PM Liam Beguin <liambeguin@gmail.com> wrote:
> > > > On Wed, Dec 22, 2021 at 02:29:04PM +0200, Andy Shevchenko wrote:
> > > > > On Wed, Dec 22, 2021 at 5:47 AM Liam Beguin <liambeguin@gmail.com> wrote:
> 
> ...
> 
> > > > > > -               tmp = 1 << *val2;
> > > > >
> > > > > At some point this should be BIT()
> > >
> > > Forgot to add, If it's 64-bit, then BIT_ULL().
> > >
> > > > I'm not against changing this, but (to me at least) 1 << *val2 seems
> > > > more explicit as we're not working with bitfields. No?
> > >
> > > You may add a comment. You may use int_pow(), but it will be suboptimal.
> > >
> > > > > Rule of thumb (in accordance with C standard), always use unsigned
> > > > > value as left operand of the _left_ shift.
> > > >
> > > > Right, that makes sense! In practice though, since we'll most likely
> > > > never use higher bits of *val2 with IIO_VAL_FRACTIONAL_LOG2, would it be
> > > > enough to simply typecast?
> > > >
> > > >         tmp = 1 << (unsigned int)*val2;
> > >
> > > No, it's about the _left_ operand.
> > > I haven't checked if tmp is 64-bit, then even that would be still wrong.
> >
> > Okay so your recommendation is to not use a left shift?
> 
> No, I recommend not to use int type as a _leftside_ operand.
> BIT() / BIT_ULL() does a left shift anyway.

Oh, got it. Sorry for misreading your message.
would something like this be good enough?

	s64 tmp;
	u64 tmp2;

	tmp2 = 1 << *val2;
	tmp = tmp2;

	...

How can I validate this?

> > I can look into that but given how unlikely it is to fall into those bad
> > cases, I'd rather keep things as they are. Would that be okay?
> 
> > Also, I don't think using BIT() or BIT_ULL() would address this as they
> > both do the same shift, with no extra checks.
> 
> They do slightly different versions of it. They use an unsigned int type.
> 
> Open coded or not, it's up to you. Just convert to unsigned int.
> 
> -- 
> With Best Regards,
> Andy Shevchenko

Cheers,
Liam
