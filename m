Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C60859C00E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbiHVNED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbiHVND6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:03:58 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F0C65F4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:03:55 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d10so9858771plr.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xCwRRSOAI8NTFENMJB9POgmpe2aeGgmWc81Fota2RZQ=;
        b=cQprBtTZHQFpLzv2+41gOj70u6H6qx39V2iiBysGguJzbcAK9u8lwqU0xB6DzqE3xN
         fgEK4NxxA8iavdul3svoFSE1oDymCtPWrQLtjaSpUOO4qHul+975UZelVwslwFAUTvbb
         kjezuMksPNHCa0LcbTDQPU9SAI3KSTFdLMFWByj6mXrbrKkyN2/JNBofNvXey5f+EuPN
         r/jpj/9NeBbgtBM2Go0Z48MFSCADhMSvsxYoWemYk4L4Miobnjq9KIo7DrlEX5KS3HMa
         qFkyLB5B5hv3gD/JWKy9obUYrPG3pPEMCT/f/lRBiE6IenAREJEaxsUDx99Ni4MGxDK0
         QL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xCwRRSOAI8NTFENMJB9POgmpe2aeGgmWc81Fota2RZQ=;
        b=ekn+f3kzWD25rA7VrpkLOXF1RbAvIsPEcMra0dCOP8H3ulpGmtTi/awSAfgWif4wrp
         By6n2CfsrPqc0LhyC6WohJHZU08vNOmZ9aHIkWFRKpTEMb8dU3+hkKNjvPNrUyj0v5DY
         al9SBX720LoE5qQUHE+/19Vhjox1orP9fBJka6X34YH0MLra0JXvzU2JXv6m6Lk19mms
         W1zRTXEWoZzRgjv1yyaO6YR+BGzyYiR+Zfx2O0nW2BO9N21aEEAQfaE5K7s/V+M5GUB1
         BJZQqANXzUH7oxy+ys3iCbguLiObhwWrI26IodCTqQn5K7oVtUW0jYfHPa66+WCwwp4n
         btMQ==
X-Gm-Message-State: ACgBeo0J883ZlT+q47RgvkSYu3PzHizAlpZtjXphLanq9rkTU/z/zR4R
        O8W/19RSw385Zb8k7iUwbNet80lS83wQFRvLcd9VuQ==
X-Google-Smtp-Source: AA6agR5eL07OPXjLdDZdPY4zqYAKnvhGdzM/+MIxIyIqRKU6U3n7CoCKAbzZBxprdaqHJo9ki2OFdh+xc5qR2NH+PUw=
X-Received: by 2002:a17:902:c411:b0:170:91ff:884b with SMTP id
 k17-20020a170902c41100b0017091ff884bmr20195671plk.58.1661173434289; Mon, 22
 Aug 2022 06:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220819153829.135562864@linuxfoundation.org> <20220819153853.762825860@linuxfoundation.org>
 <20220822111546.GA7795@duo.ucw.cz>
In-Reply-To: <20220822111546.GA7795@duo.ucw.cz>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 22 Aug 2022 15:03:43 +0200
Message-ID: <CAHUa44HBBgMtT=xAJYmNPkwZntLt=cNCmE8eb29DWm2+1PxF-g@mail.gmail.com>
Subject: Re: [PATCH 5.10 540/545] tee: add overflow check in register_shm_helper()
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Nimish Mishra <neelam.nimish@gmail.com>,
        Anirban Chakraborty <ch.anirban00727@gmail.com>,
        Debdeep Mukhopadhyay <debdeep.mukhopadhyay@gmail.com>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 22, 2022 at 1:15 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > From: Jens Wiklander <jens.wiklander@linaro.org>
> >
> > commit 573ae4f13f630d6660008f1974c0a8a29c30e18a upstream.
> >
> > With special lengths supplied by user space, register_shm_helper() has
> > an integer overflow when calculating the number of pages covered by a
> > supplied user space memory region.
> >
> > This causes internal_get_user_pages_fast() a helper function of
> > pin_user_pages_fast() to do a NULL pointer dereference:
>
> Maybe this needs fixing, but this fix adds a memory leak or two. Note
> the goto err, that needs to be done.

Thanks for bringing this up. I believe the best option is to take the
backport I just did for 5.4, it should apply cleanly on the 5.10
stable kernel too.

Greg,  can you cherry-pick the 5.4 backport patch, or would you rather
have an explicit backport for this stable kernel?

Cheers,
Jens

>
> Best regards,
>                                                                 Pavel
>
> Signed-off-by: Pavel Machek <pavel@denx.de>
>
> > +++ b/drivers/tee/tee_shm.c
> > @@ -222,6 +222,9 @@ struct tee_shm *tee_shm_register(struct
> >               goto err;
> >       }
> >
> > +     if (!access_ok((void __user *)addr, length))
> > +             return ERR_PTR(-EFAULT);
> > +
> >       mutex_lock(&teedev->mutex);
> >       shm->id = idr_alloc(&teedev->idr, shm, 1, 0, GFP_KERNEL);
> >       mutex_unlock(&teedev->mutex);
> >
>
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 6e662fb131d5..283fa50676a2 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -222,8 +222,10 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
>                 goto err;
>         }
>
> -       if (!access_ok((void __user *)addr, length))
> -               return ERR_PTR(-EFAULT);
> +       if (!access_ok((void __user *)addr, length)) {
> +               ret = ERR_PTR(-EFAULT);
> +               goto err;
> +       }
>
>         mutex_lock(&teedev->mutex);
>         shm->id = idr_alloc(&teedev->idr, shm, 1, 0, GFP_KERNEL);
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
