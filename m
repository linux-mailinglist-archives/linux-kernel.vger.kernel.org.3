Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48DD52CBC4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 08:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbiESGJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 02:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiESGJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 02:09:22 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1AC819AC
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 23:09:20 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id q130so5006500ljb.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 23:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PNDXrv+ygiGRP7Ew+ogCVIR6dtT/3oMpUNbrS/sX8rY=;
        b=JraGpmG0cqUHEyLAfLVhlpM+dTRiEpUtcsF0rqAjnl/+B59Y9yXJff5hLwRoGkgk2O
         u72zMcTB48oO881CVG7a9/iVM6gTiRqxMW8zSp/jYsjniUTfyl5utHeSoPkgeFEeQO3j
         cA6EdnCYdvzttofR8wbD6CHz6CDBp6FhqCBBLyUQTg1SV7w0YZvLo3eMR1RZosUFO1ez
         8iH/WaeMwUSQeKHqCyGGsWhY3M/8VhwtwJwXk8y/UGsehKGk4eMffFH3aXiKrNW27wFI
         ld/fW3048PVpXv45bNZK5u27I6G3mDoNlycNroowpREKpCQB5/lu4aZrCpO61LTzwjlh
         /X3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PNDXrv+ygiGRP7Ew+ogCVIR6dtT/3oMpUNbrS/sX8rY=;
        b=Dnl7s/cNT9Vifg3/IOxVwP05OhiNujf7ie2VvHLWuPZYGHBtOLsp5pVUqYbyKigY1K
         YUW3+7+dN8GFFG9p/6r38DWOg1Sba0DbKIx8PeGmgdJx+L4cRP7bEtnG4yaX1IgfjD1N
         BoTaZj3jP3/G5fSFm9wpuDJHwlGwnGth5lJKxKjItdDXOmuLxxhs1G7H1SuuMWnmQuh1
         Kvul+se8QT5BmXCRSnOwoQr5xPn3tKl22NkJUn9QPIsendXDMZMe51DBWgA+6bWVYQSI
         O17M1eoXlso6jRutFp+8X2t9kKH8lo4kXBDXUMlsewOhCJWNpbcrI3P3Ne1o0ujIUz1z
         KKow==
X-Gm-Message-State: AOAM531yI+xaWFS9VBQHfpTqkr9YT84QdT22e1lXGrRv3efDAv1VsNpW
        YLQMNgmy4pIaBnLhiQtfzD5f5/eN5R6N6/go2bs=
X-Google-Smtp-Source: ABdhPJz2CZJFdxXN0qnPt5mP007Oh9MW3+s8BmVyfAOyENDI/3SMbwSwAPrScF2SF7YTdQ+xcMrnZhyu9OlPiQQHjKI=
X-Received: by 2002:a2e:8210:0:b0:250:87c9:fb69 with SMTP id
 w16-20020a2e8210000000b0025087c9fb69mr1723105ljg.470.1652940557605; Wed, 18
 May 2022 23:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220518023123.2455827-1-liuchao@coolpad.com> <7d1878ef-e1ae-0550-7d6d-2a2ff858586c@kernel.org>
In-Reply-To: <7d1878ef-e1ae-0550-7d6d-2a2ff858586c@kernel.org>
From:   Chao Liu <chaoliu719@gmail.com>
Date:   Thu, 19 May 2022 14:09:06 +0800
Message-ID: <CAKaaq-WTHtxF28h_5uJD2y0SGz9q2greBtTaGLhCpBhfsA3xtw@mail.gmail.com>
Subject: Re: [PATCH] f2fs: make f2fs_read_inline_data() more readable
To:     Chao Yu <chao@kernel.org>
Cc:     Chao Liu <liuchao@coolpad.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 11:23 PM Chao Yu <chao@kernel.org> wrote:
>
> On 2022/5/18 10:33, Chao Liu wrote:
> > In f2fs_read_inline_data(), it is confused with checking of
> > inline_data flag, as we checked it before calling. So this
> > patch add some comments for f2fs_has_inline_data().
> >
> > Signed-off-by: Chao Liu
>
> It looks email address is missing, but it shows after I can apply this
> patch to my local git repo...
>
> Could you please check your email client configuration?

Oh, sorry, this may be caused by my SMTP server, I will try to
resend it later via this email address.

>
> Thanks,
>
> > ---
> > fs/f2fs/f2fs.h | 4 ++++
> > 1 file changed, 4 insertions(+)
> >
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index f579e2ed0f14..5071f6636e41 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -3167,6 +3167,10 @@ static inline int inline_xattr_size(struct inode *inode)
> > return 0;
> > }
> >
> > +/*
> > + * Notice: check inline_data flag without inode page lock is unsafe.
> > + * It could change at any time by f2fs_convert_inline_page().
> > + */
> > static inline int f2fs_has_inline_data(struct inode *inode)
> > {
> > return is_inode_flag_set(inode, FI_INLINE_DATA);
> > --
> > 2.25.1
> >
