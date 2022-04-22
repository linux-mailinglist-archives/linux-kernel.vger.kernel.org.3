Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3252F50B2D3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445046AbiDVI1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352900AbiDVI1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:27:15 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9DA52E5D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 01:24:22 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id p18so4347601edr.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 01:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RZF7fteh3q3LP6E7WzcUmzKI7oYS0jt30novDY2XRO0=;
        b=Y0Xvxr9UwrjqmuFJy7vUi66ruoxyGoLIKgLOH+S4eNo1znwJDqmrJ4l2WsOMe4z1ys
         eS6Z8AHvzip01IZzcmcxA5PFKD7EwTtROkK/lpDEeJHPy6zjj3GapgRGyeDtYvt530EO
         2kQJ4ZdnanEtFvEd1aQ0aMpiUgGgx0AXzILGHXRTa8KtPMO5N1imF4AyfnoekUFnTd6P
         VSkLs2cNP8/Q9pozs1CkWMdoUJ9fgtAOaWLwV1L3aVCOeXzs9J+yyq7whVLUkpewUiBQ
         OMMzheWffJhnVHENKvCOF7a/D48l0jJCzaaKMS/8FR8gTN8W/WIgA/SbZkvorg1xgwcm
         oI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RZF7fteh3q3LP6E7WzcUmzKI7oYS0jt30novDY2XRO0=;
        b=vhbo4UYDwzRQdchcVSjOgkbS0n4a9DSvUvZ7QjnQjur98BwrF3I7M7QSYHs5Kq5Xai
         zw8z7Ivpauhc22YDA7J1mq20Ljr0WdjlE7Uidj4PS1bpOGsalt/DoUccJWxuKK15umlb
         WVeRy1+54x1MAJQa9HXm6LH/I/b+iR7mSaIjGUhIhHiuUSNbG9fNyJ/1pmP3OVoiCuBo
         LzcMGVEZA5kahlJn8YCrKaUn0b2q303/7+dhKg+TZO/lFpNmmwDZeeFHn2LgvihJkaBb
         RsnI40F4GL+GVjyQ+blkYYB08z5TDZ7Jh9TU1wwTvToTzQ4//DzEExzuI3nx4//aqLW5
         OcEQ==
X-Gm-Message-State: AOAM5330OkM6F77pzaN6n5Q7Rz0QzOtpVVhzBazv4SBedN+FGT4KKlez
        BrjjNuLjdiU4AkY3vfRVjmlLl3CToaT3IVo4Ng4Zo6AuGvkZgw==
X-Google-Smtp-Source: ABdhPJzXFLJyddsWoNVeno0wBPe4x/nOfcWCsbpOWBsjoPy3RidBDJm0TXSnhvWLyUm3J2dytsVC1Bjl980EsZymiSk=
X-Received: by 2002:aa7:db0f:0:b0:41d:7b44:2613 with SMTP id
 t15-20020aa7db0f000000b0041d7b442613mr3609611eds.126.1650615861253; Fri, 22
 Apr 2022 01:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220415094518.380543-1-cccheng@synology.com> <20220415094518.380543-2-cccheng@synology.com>
 <87czhitr13.fsf@mail.parknet.co.jp>
In-Reply-To: <87czhitr13.fsf@mail.parknet.co.jp>
From:   Chung-Chiang Cheng <shepjeng@gmail.com>
Date:   Fri, 22 Apr 2022 16:24:10 +0800
Message-ID: <CAHuHWtnL4_HV2yGZJ9qY_cSf9t3ot2bVDPJdkKVGehS9iGMMVg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fat: make ctime and mtime identical explicitly
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Chung-Chiang Cheng <cccheng@synology.com>,
        linux-kernel@vger.kernel.org, kernel@cccheng.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 9:28 PM OGAWA Hirofumi
<hirofumi@mail.parknet.co.jp> wrote:
>
> Chung-Chiang Cheng <cccheng@synology.com> writes:
>
> > -     fat_truncate_time(dir, NULL, S_ATIME|S_MTIME);
> > +     fat_truncate_time(dir, NULL, S_ATIME|S_CTIME|S_MTIME);
>
> fat_truncate_time() updates i_ctime too. So S_CTIME should not be
> necessary here. And I think this is better to use only S_MTIME to tell
> this is the point of mtime update.
>
> (And, in fat_truncate_time(), I think S_CTIME is not required, because
> we ignore ctime change, isn't it?)
>
> >       clear_nlink(inode);
> > -     fat_truncate_time(inode, NULL, S_CTIME);
> > +     fat_truncate_time(inode, NULL, S_CTIME|S_MTIME);
>
> This is the point to update ctime. You want to affect ctime change to
> mtime? As I said in previous post, I think we are better to ignore ctime
> change, because it may become yet another incompatible behavior.
>

Thanks for the feedback. I will change the behavior to ignore ctime
updates in the next version of the patch.
