Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EC45B125A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 04:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiIHCHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 22:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiIHCHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 22:07:53 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD12DCCD6D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 19:07:52 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso628173wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 19:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=BLF2kMmdrofDBi9O5TGkANVsUhpE8WNQauup993bzoc=;
        b=nczWRa35lOHHeQ8shY0JxNDzyMHqVdRYOe8HN2jvgFdoqs55hP2m9qZLvzNbVdkdAu
         dU0i8dvLoTSTRyHu2GnF4Y06hg47lwqbypR8Nf4LgAR4TtH/pJtLY9GNlPV6I2uqeET4
         ygyhzJ0MlBKvz6/kVtTiobHimOu3uYJ+OjmZEz/PfJZ9hpEwqDkQoWUsSigehgsUkyDB
         bnjkVoesWlE94tFprdCXTOFVtWKkdKEYQQiGbP6zMhVnJsjyMwKsUj/NnrqguNxOhMWi
         stGwck/Zi2MSrkmiQCEsOaakLZyXT0PVfo91GbmyC1iOuKxboKK6mOHxGT4TW0MIAH/j
         bp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=BLF2kMmdrofDBi9O5TGkANVsUhpE8WNQauup993bzoc=;
        b=iXKUyoa0IB0Gu6QRzRZyoV9Yayw3eapu2171DAUbkdrVvUrSPzYGSMF7+DzjUkvUyg
         8eHmGsclBzUI0HYdPFqETRNx+PnmL4H8Vippj/ynhoaFzz/1CxQeR/mTKmyAJWx7aIew
         8tnbH6pak4+qBQTGYOonbq0DazIJe55Vm4bfBXMFMDFnXGOoMZUNX9+67jRXYxUsA8PC
         zKqhvR4PKpr0OQ+UN+lAx+knDWDKcPvxI+j5LTDPhkGRjlpwXOAM4k6kGdhLIxg/Vgel
         Iooh8bGvCQynOApcmBo3bRowzCTnN18GxUypvrMt9p6iOEt/HnRj2D0tqUyQMrDlq4Tu
         LdAg==
X-Gm-Message-State: ACgBeo3b9KTJ8djGCpJwXMnNZvKRVXWOkxfDJHPJaOwc7EC6oDVCrXjC
        RCoUcXrbUtVAwV6UaA7FriZ/g7eALqye6T3m3JxJgTULAQ==
X-Google-Smtp-Source: AA6agR6y0eqoFREYh6JFMwVB8xkR/uvm2w5XlkdWiHPsD4CFhbocmlXGD5OSu6iqw+MkKNoKkrowkm5FaTJNVzR5zJE=
X-Received: by 2002:a05:600c:1554:b0:3a6:23d7:1669 with SMTP id
 f20-20020a05600c155400b003a623d71669mr657805wmg.70.1662602871310; Wed, 07 Sep
 2022 19:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <1662568262-20925-1-git-send-email-kaixuxia@tencent.com> <20220907174207.61191-1-sj@kernel.org>
In-Reply-To: <20220907174207.61191-1-sj@kernel.org>
From:   Kaixu Xia <xiakaixu1987@gmail.com>
Date:   Thu, 8 Sep 2022 10:07:39 +0800
Message-ID: <CAGjdHukJ+HVxZo66oVGnETy6Zm+LMDyVS6upEzQ14ucpj8NvXA@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/vaddr: remove unnecessary switch case DAMOS_STAT
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Kaixu Xia <kaixuxia@tencent.com>
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

Hi SJ,

On Thu, Sep 8, 2022 at 1:42 AM SeongJae Park <sj@kernel.org> wrote:
>
> Hi Kaixu,
>
> On Thu, 8 Sep 2022 00:31:02 +0800 xiakaixu1987@gmail.com wrote:
>
> > From: Kaixu Xia <kaixuxia@tencent.com>
> >
> > The switch case DAMOS_STAT and switch case default have same
> > return value in damon_va_apply_scheme(), so we can combine them.
>
> Good point.  I have a comment below, though.
>
> >
> > Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> > ---
> >  mm/damon/vaddr.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index 3c7b9d6dca95..94ae8816a912 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -643,8 +643,6 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
> >       case DAMOS_NOHUGEPAGE:
> >               madv_action = MADV_NOHUGEPAGE;
> >               break;
> > -     case DAMOS_STAT:
> > -             return 0;
>
> IMHO, keeping the 'case' makes the code easier to read, as we can find what is
> the expected flow for DAMOS_STAT here immediately, instead of asking readers to
> find what are the actions that not specified here and therefore fall though to
> 'default'.
>
> Also, my another intention here is to mark 'DAMOS_STAT' is supported by
> 'vaddr'.
>
> >       default:
> >               return 0;
>
> That is, 'default' case here is for DAMOS actions that not supported by
> 'vaddr'.  So, I'd like to keep the code as is.  Maybe we could add a comment
> saying 'default' case is for DAMOS actions that not yet supported by 'vaddr'.
>
Yeah,  it might make sense to add a comment here, thanks.
> >       }
> > --
> > 2.27.0
>
>
> Thanks,
> SJ
