Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00284515F43
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 18:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383112AbiD3QfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 12:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiD3QfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 12:35:00 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B83918358
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 09:31:37 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d6so12248851ede.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 09:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:cc;
        bh=jcv14XD1FEIAH5YEbByn5Xomdekt/dYfYEZFWkwU5FU=;
        b=FRH+xRdGg7HZsiLz5JoAPLsGDaJ6SDVwMQmh9FMmarSedeV1GjontilhGFXsQrmCgR
         8xOVJZjJ+SNbtOvnpzFfYS7EM3NA+q35uK6EBlPzy3LY0hNxhzSZH5pnv5c31Kmi7Ujk
         BQhjrMnOrFhsjfuaNkUptVNjiijRPJABsGZgLVX9ZdyURmYBMeKKzgiOtJCFcEHpATtU
         doHOz1WLeAQdDgU3JpCkwl+p8zF3WSrQMop5Nyml64gyrpO/Erh89GGHgIPd1MsmRS5L
         gjGAAdAzNMyuMy5qs6C5KDawCLGRwNUm0BvI2DYghxD40GfBvn0i54JTVaoJUjSvqfq0
         rlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:cc;
        bh=jcv14XD1FEIAH5YEbByn5Xomdekt/dYfYEZFWkwU5FU=;
        b=lvHBMM5wwWbYtuNN797cpfOyRyJDM7YnVNVlc3y4ZBxXe5Mlg40wLzYURrVRRNOhDc
         eO9Leo33Nud8Sb+R8h+XNxAxfQqACLBuot1OUrKFerRUfu0xbMWkDkW4NaPDE+pW+MKe
         nPg9qRoXuUx3rtIA++M4dJOOlFLA1pmL5zFOITOPQSoRSTI+5tPSsXRSKo2L/SnbTOWE
         wd0f29AEOP47wFEyGKmMl/kxJHnlXn9AXr2CuRn2FKjs+3qL0yHi5VGC5JnjQQ/Ayiji
         Hlpq750ubzBfqhgkEO6Q23Z8mc2r84pWoy8v0Jdc/O6pOl819SWCPWL5DxWV+PwLSxf8
         x8dQ==
X-Gm-Message-State: AOAM532MraagzHHzhpFIaBXiIDwPYHOayjR1aHtA1VFAZ4WLGDK82iOk
        sz/gZm/2LCGSci3fqaX1xox3Ixnbm6Y3kt8Jwb4=
X-Received: by 2002:a05:6402:51d3:b0:426:3a20:738b with SMTP id
 r19-20020a05640251d300b004263a20738bmt3631993edd.342.1651336295872; Sat, 30
 Apr 2022 09:31:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a98:b407:0:b0:151:9bf6:acf5 with HTTP; Sat, 30 Apr 2022
 09:31:35 -0700 (PDT)
Reply-To: israelbarney287@gmail.com
In-Reply-To: <CAF-T75joUqZCnKLjTy0ws0wri4apjzyDy2xJEQ+wVRtpFyvEew@mail.gmail.com>
References: <CAF-T75gCfRi-3ajFv6SxOuyvU=a53EaJ9Y6k6xvgYDrgWE6_yQ@mail.gmail.com>
 <CAF-T75i0DRaY2=SqzwqgxS3fs1OABt_Pin1r1HT69PuqRSk7VA@mail.gmail.com>
 <CAF-T75gY0h3MiFKFKRkhhpD5jO2x5sUcxg4iFnCWQNXmWCqhaQ@mail.gmail.com>
 <CAF-T75iHvDnp-qORWAmPtN_Q8G5t2+Ppv4QR3qLm-WUc=b+Bwg@mail.gmail.com>
 <CAF-T75iKJPcTV_aD+e7+fi8DkhfcACzGKnF2=rtFXxOaGosXNg@mail.gmail.com>
 <CAF-T75gKkab1n+ts4ToW2wF6Ayu2k4tj6Dj1i39nT9FaFySzhg@mail.gmail.com>
 <CAF-T75guFoGW90bJ2DO0RB8PjFcvX8=k9V8YCQRUOcJEuB30fA@mail.gmail.com>
 <CAF-T75gNPuSx0o700+8GXUFkqt1SJQQVOBr3GHKZ2q0vVYbvdg@mail.gmail.com>
 <CAF-T75htvXoJLO4gwC74r-=OUQW69hp02n8n0C5u4WkR29grzg@mail.gmail.com>
 <CAF-T75gYLYdux641hd1Tmq6wy2PN9DjYenx539bxPPgiywxjXg@mail.gmail.com>
 <CAF-T75hvApZy=YiaDG4nwqU5aG-siGc6hp2vMj+iCRTC4iiJYQ@mail.gmail.com>
 <CAF-T75iWuH0138VjCNFJDYNYwF6dZHOd-Lm-oTZx2QVfBehdSg@mail.gmail.com>
 <CAF-T75jkroU0dqF=JC7Q0f-FLKqpSnfT0NzRRfp0ewZeDAv0+A@mail.gmail.com> <CAF-T75joUqZCnKLjTy0ws0wri4apjzyDy2xJEQ+wVRtpFyvEew@mail.gmail.com>
From:   israel barney <gkristen481@gmail.com>
Date:   Sat, 30 Apr 2022 16:31:35 +0000
Message-ID: <CAF-T75ghupSgrdhyU+5Befp9kMQxRrq9F_FsPGQMEj_sEpZ9MA@mail.gmail.com>
Subject: Hi
Cc:     israelbarney287@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        MISSING_HEADERS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URG_BIZ
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings to you! Please did you receive my previous message? I need
your urgent response.

My regards,
Mr. Israel Barney.
