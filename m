Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A0F559CF6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 17:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbiFXPBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 11:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbiFXPAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 11:00:55 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21668C23E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:57:15 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so3078239pjz.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B9+Xw3AgWFPb9gceKYuL3mWDfeTAT5uMLzXq4cAey3o=;
        b=jC+7oE29NkwkDTiv2sg5tyMbaUK+6JxfQ3DjYs4EzOmT7MtdHWe1aI4qyisAIaUVq9
         /SONkAn8+h+LjDEBqrXaNNefRLfm5GH4uDzZu7B+t1oC3XezcWnu4BUoSMww8vVJjMtS
         I0sLvxFJKmgC45wYmAoYmMyWsUDn2zLi25Hc11p1bJxCksWmzEMZWc/i7WKsw1qbW+JI
         QmE+zmLPCZE5IJGgQLOYV4XhmBSGgJb3cx+g5aJHINDusu9Gc4MOA5SYo2rS/IsJAX4B
         y1DIG/Eh9pMQ5RM2rClALsYWreh5zIBKwMTiVA/l3kC1zdruYQRXMS9aQ6RAV5/lQLjk
         D06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B9+Xw3AgWFPb9gceKYuL3mWDfeTAT5uMLzXq4cAey3o=;
        b=kdILn7GVaXkG3d48GqPL4/ybOFyqXZUkgMpCild3UPTVMEVMOEuSPM5Z/oX8gpPZrJ
         lA582zg9ski8H3yCID9vKFUpA9+/QVPpyfydbF7E0fxECZMlj/l3mhr5iiwiv/iWKBp2
         W2YudxnrpAdnaFejPVDJlyFjUw98BUzml1lqzLN+6Zod1BRxW0npbtrnCKf0cjKyB4nd
         sYwdrdLN1tLZyHUuXdsBpqo1/SS9CwWU/Q17Ja3Ct9fA7dw7fXn1/i+eNBo4jzka5FP2
         uD49g/XVqjegl0PdIC9YSuR6T4fSGTAyf3QRa/N//bse6oJACjryaP4sTO7JJVoYgXtg
         O/hg==
X-Gm-Message-State: AJIora9gF/8/3VP65tWu5T3iDtEBJGUuAuWvvViIx+U7NKL6Qb5KkOLA
        juwmV8VysFrNHSdsPzqfwmRm8TtfMgztZkb3ZN5XDW80D2A=
X-Google-Smtp-Source: AGRyM1ss7nIP21Ejb0LMt/Kt1S+VHFVqLZHccryP7/8ZyXFSmcq2oI7fvQZMrmcY/DET/wU+hCAOoxVEwu16TXxwXE8=
X-Received: by 2002:a17:902:dac1:b0:16a:3ebe:c722 with SMTP id
 q1-20020a170902dac100b0016a3ebec722mr16770844plx.169.1656082635427; Fri, 24
 Jun 2022 07:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220619231837.1150499-1-jcmvbkbc@gmail.com> <20220624140139.GA2050137@lothringen>
In-Reply-To: <20220624140139.GA2050137@lothringen>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 24 Jun 2022 07:57:09 -0700
Message-ID: <CAMo8BfLY333gAdztZJa6nm2=mpNyFsBds+d2nRzx6KQ7iWuxsQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] xtensa: context tracking updates
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 7:01 AM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> On Sun, Jun 19, 2022 at 04:18:35PM -0700, Max Filippov wrote:
> > Hi Frederic,
> >
> > your recent conversion of CONTEXT_TRACKING to CONTEXT_TRACKING_USER
> > missed the xtensa architexture. These two patches hopefully fix it.
> > Please take them to the tree that holds the rest of the conversion.
> > (Even better if they could be folded into the corresponding conversion
> >  patches).
> >
> > Max Filippov (2):
> >   xtensa: rename context_tracking_user_{enter,exit}
> >   xtensa: rename CONTEXT_TRACKING to CONTEXT_TRACKING_USER
> >
> >  arch/xtensa/Kconfig        | 2 +-
> >  arch/xtensa/kernel/entry.S | 8 ++++----
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > --
> > Thanks.
> > -- Max
>
> Thanks a lot for these fixes. I'm likely going to reissue this
> patchset so I'm going to fold your changes inside if you don't mind
> (with your Signed-off-by).

Sure, by all means.

-- 
Thanks.
-- Max
