Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5674ECD44
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350813AbiC3Tcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 15:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350781AbiC3TcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:32:21 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC24E18D;
        Wed, 30 Mar 2022 12:30:34 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id i23-20020a9d6117000000b005cb58c354e6so15598379otj.10;
        Wed, 30 Mar 2022 12:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=veUBsLDA8z1kapNgGskRdZV5ZEcmkX6JnZsbhXJYMpc=;
        b=adILIVBCDTIzWnSlVEVuzyyQeLmZJmMOFHyUGAJczwNVMWoAFV4NAzstETyw1aDTXU
         PeEQLPvBoGZwnev7kqXDVH894+ZJpStidUvOyd4/1a6OmOqL4s2xBS6X9x8cJk7Oihqe
         +0/HdD5+tmox7CuSPAksHZtqs2sUxMsx4ttZZY2Z+MG9vnVpDEQzjL4iWBd9R0AMRjb5
         hTGvCbUVUHgokVFAeJzbaRIPyaomR1Qfb+x/h6uFUfBCu2hUOp9EdtCusdpiPwU+kcPm
         wtQaZsJmez5fjcTI5em0IZ63LFU6tv0+hT7r7qlJyGmpPbqsVIKRICrNzYwhE75XWGOg
         r2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=veUBsLDA8z1kapNgGskRdZV5ZEcmkX6JnZsbhXJYMpc=;
        b=r/aGcmo2MO9HFDwPtJMN/RBiUCyN4neacn5kvJEPGVAkITXnOjUtvjGutlH0ntk1bV
         kI5j16IQAcMtpAucC4XHPG9FwmcfsHBP1hC0RmI1whCKZ0LIuomPGV/hRnECmiWNCZRZ
         aoXfniXm++ABb7un2oqoMYmiXhKZt6HabU8vac3lmJHziQZpcx2lResR8u0kh/uO1j53
         T8I6th3Wc7dwdAWTal7yJLc8sEptFRYnvqBjD6wt3pV7X1/47cM91NptI31abFQs3GjD
         ZfoHvyPLZe3+89hn1xty8aB2pxMB59h714zrC3exgw2pCJAF0+VMPfLK4PlOg/dHBdAc
         qgKw==
X-Gm-Message-State: AOAM530QqTgQI0TWe1HCTdeRX4IsPSi2I5oU05cdgv8fLU163ZyqQGYE
        FvernZ9g3j8Dau0KYaV4bx0=
X-Google-Smtp-Source: ABdhPJxKo3vtGI8m11rbEZM4uy18kOD2uIYcCWzcg87bQPdqYAMGuiXvFLPRZant4BK9y506jlNudQ==
X-Received: by 2002:a05:6830:3142:b0:5cb:3e2b:e1e with SMTP id c2-20020a056830314200b005cb3e2b0e1emr4070755ots.38.1648668634039;
        Wed, 30 Mar 2022 12:30:34 -0700 (PDT)
Received: from marsc.168.1.7 ([2804:30c:b6b:3900:e3fc:1545:cb91:17fb])
        by smtp.gmail.com with ESMTPSA id 24-20020a056870139800b000dea48c55d1sm8503795oas.39.2022.03.30.12.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 12:30:33 -0700 (PDT)
Date:   Wed, 30 Mar 2022 16:30:29 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     David Gow <davidgow@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-sparse@vger.kernel.org, cocci@inria.fr,
        smatch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>, julia.lawall@inria.fr
Subject: Re: [PATCH v2 2/2] Documentation: dev-tools: Enhance static analysis
 section with discussion
Message-ID: <YkSv1eUfS9MxotOz@marsc.168.1.7>
References: <cover.1648593132.git.marcelo.schmitt1@gmail.com>
 <11f4750c6d4c175994dfd36d1ff385f68f61bd02.1648593132.git.marcelo.schmitt1@gmail.com>
 <CABVgOSkb5CpnXDF_m7iy=A7RmN+KmY0T38TeZ4hKbmkdQgt6Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSkb5CpnXDF_m7iy=A7RmN+KmY0T38TeZ4hKbmkdQgt6Yw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/30, David Gow wrote:
> On Wed, Mar 30, 2022 at 7:23 AM Marcelo Schmitt
> <marcelo.schmitt1@gmail.com> wrote:
> >
> > Enhance the static analysis tools section with a discussion on when to
> > use each of them.
> >
> > This was mainly taken from Dan Carpenter and Julia Lawall's comments on
> > the previous documentation patch for static analysis tools.
> >
> > Lore: https://lore.kernel.org/linux-doc/20220329090911.GX3293@kadam/T/#mb97770c8e938095aadc3ee08f4ac7fe32ae386e6
> >
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > Cc: Julia Lawall <julia.lawall@inria.fr>
> > ---
> 
> Thanks: this sort of "when to use which tool" information is really
> what the testing guide page needs.
> 
> I'm not familiar enough with these tools that I can really review the
> details properly, but nothing stands out as obviously wrong to me.
> I've made a few comments below regardless, but feel free to ignore
> them if they're not quite right.
> 
> Acked-by: David Gow <davidgow@google.com>
> 
> Cheers,
> -- David
> 
> >  Documentation/dev-tools/testing-overview.rst | 33 ++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
> > index b5e02dd3fd94..91e479045d3a 100644
> > --- a/Documentation/dev-tools/testing-overview.rst
> > +++ b/Documentation/dev-tools/testing-overview.rst
> > @@ -146,3 +146,36 @@ Documentation/dev-tools/coccinelle.rst documentation page for details.
> >
> >  Beware, though, that static analysis tools suffer from **false positives**.
> >  Errors and warns need to be evaluated carefully before attempting to fix them.
> > +
> > +When to use Sparse and Smatch
> > +-----------------------------
> > +
> > +Sparse is useful for type checking, detecting places that use ``__user``
> > +pointers improperly, or finding endianness bugs. Sparse runs much faster than
> > +Smatch.
> 
> Given that the __user pointer and endianness stuff is found as a
> result of Sparse's type checking support, would rewording this as
> "Sparse does type checking, such as [detecting places...]" or similar
> be more clear?

Myabe. I tried changing it a little while adding a bit of information from
https://lwn.net/Articles/689907/

"Sparse does type checking, such as verifying that annotated variables do not
cause endianness bugs, detecting places that use ``__user`` pointers improperly,
and analyzing the compatibility of symbol initializers."

Does it sound better?

> 
> > +
> > +Smatch does flow analysis and, if allowed to build the function database, it
> > +also does cross function analysis. Smatch tries to answer questions like where
> > +is this buffer allocated? How big is it? Can this index be controlled by the
> > +user? Is this variable larger than that variable?
> > +
> > +It's generally easier to write checks in Smatch than it is to write checks in
> > +Sparse. Nevertheless, there are some overlaps between Sparse and Smatch checks
> > +because there is no reason for re-implementing Sparse's check in Smatch.
> 
> This last sentence isn't totally clear to me. Should this "because" be "so"?

Smatch uses (is shipped with) a modified Sparse implementation which it uses as
a C parser. Apparently, Sparse does some checkings while parsing the code for
Smatch so that's why we have some overlapping between the checks made when we
run Smatch and the ones made when we run Sparse alone.

I didn't dig into the code, but I guess further modifying Sparse to prevent it
from doing some types of cheks wouldn't add much to Smatch. That last saying
should've reflected this fact, but it seems to cause confusion without a proper
context. Reading the sentence back again, I think we could just drop the last
part:

"Nevertheless, there are some overlaps between Sparse and Smatch checks."

> 
> > +
> > +Strong points of Smatch and Coccinelle
> > +--------------------------------------
> > +
> > +Coccinelle is probably the easiest for writing checks. It works before the
> > +pre-compiler so it's easier to check for bugs in macros using Coccinelle.
> > +Coccinelle also writes patches fixes for you which no other tool does.
> > +
> > +With Coccinelle you can do a mass conversion from
> 
> (Maybe start this with "For example," just to make it clear that this
> paragraph is mostly following on from how useful it is that Coccinelle
> produces fixes, not just warnings.)

Will do

> 
> > +``kmalloc(x * size, GFP_KERNEL)`` to ``kmalloc_array(x, size, GFP_KERNEL)``, and
> > +that's really useful. If you just created a Smatch warning and try to push the
> > +work of converting on to the maintainers they would be annoyed. You'd have to
> > +argue about each warning if can really overflow or not.
> > +
> > +Coccinelle does no analysis of variable values, which is the strong point of
> > +Smatch. On the other hand, Coccinelle allows you to do simple things in a simple
> > +way.
> > --
> > 2.35.1
> >
