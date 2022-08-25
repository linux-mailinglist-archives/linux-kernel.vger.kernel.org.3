Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83685A0BC7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238569AbiHYIoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237360AbiHYIoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:44:07 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DE3792C2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:44:06 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 12so17291564pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=g8Y5dsHHhJYS52xRzplhahO0NkTsTfjBUPYQHi8QPVc=;
        b=RUDXiUVsRg7m6do2EZWM6ADd/flJOXOuQum5MOPKx3jkA2GhiRQT1GNxcjwtteX1LF
         Oaz1L3Vxvc+OvNQ6xQdEv1SsghL1i+D95UIKT4QYJs+QXh++tnQ/6AzSZHwEbHcmgrV0
         zesv6E7J+v/ZrJUZMqFQ2wOPiS8ugZUspZHJfezntOfv4g9DYwwDmewC+6gTLt6WEkzJ
         b8lm5ySL7/nWkhfbOnesiNkJMx/g7oW4E6GpQWHvP4q3b3mLVfXB2OCP5kCOxtg1OzaM
         wOFtMIV23cDgi2jpGvYLH5sstvEOg8r1KMYKcuXw150M6FOqmAjixP0VCFZJ2e24RIsl
         vKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=g8Y5dsHHhJYS52xRzplhahO0NkTsTfjBUPYQHi8QPVc=;
        b=fTqpqX9lZwi0r7Ce17ctfTazHtdt/WVmAd/FCtiOa0vguiy0RPw8jDNyncKiTA6kOr
         0zhoOMQ0RYFM0gexCOycH+92lhvqbd1QB0bH6uv7Fx/LuR2LOeQzAzs/AMArDhrDxar/
         1pTiw6nntKl9ocwZIuS/C48xZfK2AwrmN54gBmh+BrLI6zPsAdEvsp0wx/vUyra+Nfzi
         V7Wr9yhRoCnu5fttRDZWwEKiHcVzaegOSv4cL3bbO4lFYiZzzu+1DxLbg+9TEzVV5cBr
         9htbHYUNgH8L7S+T13MIDS+zCt8qfKZ/In1bBYVt8yxgTPyqUshJwmjneQX9rcZorgfm
         XhqQ==
X-Gm-Message-State: ACgBeo0+dX+G1jt+B6VrG1ag8j1bPoCVDcEXOr2P/linFVLrEaS8sYWp
        HeJMZUazTTiTcKLfaLriP+bkGrRn1SuoY0BQLkf14Q==
X-Google-Smtp-Source: AA6agR5o3v0v910FDe4gRvb1F+IL4KXzxz4JK1pmeJcknCleOQ2t0bzh/msJ/sRlY3RoyjRQk6casQj2CgdfgDtNHn0=
X-Received: by 2002:a63:e102:0:b0:41b:3901:990e with SMTP id
 z2-20020a63e102000000b0041b3901990emr2399648pgh.107.1661417045945; Thu, 25
 Aug 2022 01:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220822082846.3558520-1-jens.wiklander@linaro.org> <CAFA6WYMytTKk_Z5u=6cd6JWCGp==jA9jDhC+oBboeZODGa+EOQ@mail.gmail.com>
In-Reply-To: <CAFA6WYMytTKk_Z5u=6cd6JWCGp==jA9jDhC+oBboeZODGa+EOQ@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 25 Aug 2022 10:43:55 +0200
Message-ID: <CAHUa44EpnrsYaoLTgwzSOTT=V2XRB5=e_zEJ3gx1jZvYuvGjuw@mail.gmail.com>
Subject: Re: [PATCH] tee: fix compiler warning in tee_shm_register()
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Jerome Forissier <jerome.forissier@linaro.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 10:39 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Mon, 22 Aug 2022 at 13:58, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Include <linux/uaccess.h> to avoid the warning:
> >    drivers/tee/tee_shm.c: In function 'tee_shm_register':
> > >> drivers/tee/tee_shm.c:242:14: error: implicit declaration of function 'access_ok' [-Werror=implicit-function-declaration]
> >      242 |         if (!access_ok((void __user *)addr, length))
> >          |              ^~~~~~~~~
> >    cc1: some warnings being treated as errors
> >
> > Fixes: 573ae4f13f63 ("tee: add overflow check in register_shm_helper()")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/tee_shm.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

Thanks, I'm picking this up now.

Cheers,
Jens

>
> -Sumit
>
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index 1175f3a46859..27295bda3e0b 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/slab.h>
> >  #include <linux/tee_drv.h>
> > +#include <linux/uaccess.h>
> >  #include <linux/uio.h>
> >  #include "tee_private.h"
> >
> > --
> > 2.31.1
> >
