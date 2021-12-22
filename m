Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1B347D6FA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344780AbhLVSiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbhLVSiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:38:52 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0B0C061574;
        Wed, 22 Dec 2021 10:38:52 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id r6so3067574qvr.13;
        Wed, 22 Dec 2021 10:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nf5MgBjXqmTQasO6KZdp2Qw6UGHqoTSrSt9BT1Gsnd4=;
        b=TV2EmI7uhCw68jYA9t1cerE/vqxUO5eKp98LCALYoUvvrtXrvZLRIMjKaYrdlL3/36
         X1tjwqYFo0DO97WxkR7o33UfwVyJSJogDkBFjt+YjtGd5I4lS20oZdMng49Ygut4BOJh
         MdeY8wSUVzsmGPg4qCIYm/cpA4XFJbn2G3uvFQWZvwmLbns3t4luMtyYIO41ZZG/fFKy
         L9tYXjBHiaPqrrsnD65TbeF47Pkw9eUqwe9VsgI6SJb6XbM2cfErxBDRfyKuWuDyap3r
         IaWOjzWjU6hmsn65FEZvS2AsxqZc5FcqSg2vr6xPJmpT3ut6pVH4AuC7ghzBq6Pr0PVs
         zTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nf5MgBjXqmTQasO6KZdp2Qw6UGHqoTSrSt9BT1Gsnd4=;
        b=a3eG9Pu9jtKeMziMQ9FZgSuSSsbmYsECZ1tp4LFesvG7k3MPk94SYR/dNWufeoCYzj
         67/RoDd3aoGKFmvI3D/q0oAJjZbLJWSDhsexxjE8RAWlb4xd9M/4UNUc3vOUyYJUoeVJ
         LRLZFPc91i4Hgd6KdBdVpi/EWpBc5rDvSFwaTurORsK1Bg+NEhvtv7G12Q6BGn31WkRH
         pTPgEvDnW8ZwYWAeJRNziqno+BpW0cIihnleEyEhiJvhr5+OerOngfQ+WCxZ2zt8bfv1
         RTGfOJ9IWJAsodHXLTKktvl5HGMhESO4XYaJ61Thdx+5XiajbKonvQ65clyn0Di4x2fl
         jItQ==
X-Gm-Message-State: AOAM532fvjWubICvy7O+LpZy1C6rcCFwW2WDc9VQzHzK/jMTQBGm4AST
        l6hHrWc6lBF79O8/u6sPp04=
X-Google-Smtp-Source: ABdhPJwMUNy/FD+LSUG8fSt+A9sruxy6dsJ/uwwEFxfr394TsSBDePVrWrQBgiewiBYOCJzaydGJBA==
X-Received: by 2002:a05:6214:2a8e:: with SMTP id jr14mr3578976qvb.75.1640198331459;
        Wed, 22 Dec 2021 10:38:51 -0800 (PST)
Received: from shaak (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id n129sm2241061qkn.64.2021.12.22.10.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:38:50 -0800 (PST)
Date:   Wed, 22 Dec 2021 13:38:47 -0500
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
Message-ID: <YcNwt5RFMNFUimD/@shaak>
References: <20211222034646.222189-1-liambeguin@gmail.com>
 <20211222034646.222189-10-liambeguin@gmail.com>
 <CAHp75Vc0aWrFtNK1ZkHkwP62zNXQJaDcn9pc8Uhfq0kOnWzmJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vc0aWrFtNK1ZkHkwP62zNXQJaDcn9pc8Uhfq0kOnWzmJg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 02:29:04PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 22, 2021 at 5:47 AM Liam Beguin <liambeguin@gmail.com> wrote:
> >
> > From: Liam Beguin <lvb@xiphos.com>
> >
> > Reduce the risk of integer overflow by doing the scale calculation on
> > a 64-bit integer. Since the rescaling is only performed on *val, reuse
> > the IIO_VAL_FRACTIONAL_LOG2 case.
> 
> ...
> 
> > -               tmp = 1 << *val2;
> 
> At some point this should be BIT()

I'm not against changing this, but (to me at least) 1 << *val2 seems
more explicit as we're not working with bitfields. No?

> Rule of thumb (in accordance with C standard), always use unsigned
> value as left operand of the _left_ shift.

Right, that makes sense! In practice though, since we'll most likely
never use higher bits of *val2 with IIO_VAL_FRACTIONAL_LOG2, would it be
enough to simply typecast?

	tmp = 1 << (unsigned int)*val2;

Cheers,
Liam

> > +               if (scale_type == IIO_VAL_FRACTIONAL)
> > +                       tmp = *val2;
> > +               else
> > +                       tmp = 1 << *val2;
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
