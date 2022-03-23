Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FC14E583A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 19:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241132AbiCWSRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 14:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240730AbiCWSRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:17:21 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FEA88B37
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 11:15:50 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s25so3040066lji.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 11:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OKiw1+dfHR1oJ1PoIXl9ySrLBwZ9Y+hJ7Cft5fMLtK4=;
        b=F3Hg9tR6hI9m7GduNctQa5hlBlKl7woLHfkGzUI+GiVEaDJpyTgVPM5TZlxF7yczSQ
         DCUFOYeVes9h7clyW/vZvBow5Q9xAw0VXaFmCBfO6Y9S0zfXNCOiNXO/DcUUdO3Olb8i
         ZYrlKmpBePlrXaVfbGmAoDmkbihmFzFupyTXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OKiw1+dfHR1oJ1PoIXl9ySrLBwZ9Y+hJ7Cft5fMLtK4=;
        b=vIJVqm2WwPmZ3tm7+IJZSVpCGQzIH8t7ESgM8HiJ4UlJ+BcksgGzYHzE4BZXyqq6OW
         okvBhhwNEQZJU6f4+vLl8FYZKxyeAHbRmuRA0zkao++nNAl1fyCmsXmLRd6m9CG0Ky9R
         8c760Q0MaZmLuknH8T23bNLLe7jCaKSGI+qIcx1JvxWSxSj2P+0Z83IyK6qD07jQEjuY
         wTj9UsXmT7TA8hxLS8khsnSlzJ2VbUXrQLJQ4RD+3M5kk//3cAYLKZc4f/lYNJRh2TTU
         xb056RaKuvq5nd2L9ybk2E8ZN2nv7Hwj59vFciiYb7ksoJj4Z4lXFUybLajhrOsgJMCq
         GYvw==
X-Gm-Message-State: AOAM530AzMqnWwS7org9YxyFghEulNut16Hs7r1yKRtpatiNWVzmBcq7
        KAywOolosdBf2selqjKdPtS0FvJrNUT7MNtifz8=
X-Google-Smtp-Source: ABdhPJybqGLHUjNLMwEg0TDDTQ+4RABfRjyKpV0UR/DK7wpJG8IRvOMIAwN0SgR6sok5zsQEdVh08g==
X-Received: by 2002:a2e:87d4:0:b0:249:a34a:2532 with SMTP id v20-20020a2e87d4000000b00249a34a2532mr1123652ljj.328.1648059348496;
        Wed, 23 Mar 2022 11:15:48 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id s20-20020a2e1514000000b00247e5d4e37fsm70761ljd.28.2022.03.23.11.15.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 11:15:47 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id m3so4044272lfj.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 11:15:47 -0700 (PDT)
X-Received: by 2002:a05:6512:3055:b0:44a:3914:6603 with SMTP id
 b21-20020a056512305500b0044a39146603mr843069lfb.435.1648059347285; Wed, 23
 Mar 2022 11:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220321103035.564a1df5@gandalf.local.home>
In-Reply-To: <20220321103035.564a1df5@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Mar 2022 11:15:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=whxmA86E=csNv76DuxX_wYsg8mW15oUs3XTabu2Yc80yw@mail.gmail.com>
Message-ID: <CAHk-=whxmA86E=csNv76DuxX_wYsg8mW15oUs3XTabu2Yc80yw@mail.gmail.com>
Subject: Re: [GIT PULL] tracing/rtla: Updates to the RTLA tool
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 7:30 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I'm sending this as a separate pull request from my normal tracing tree, as
> it had dependencies to commits in your tree but not in my development
> branch. As it only affects the tools/ directory, I kept it separate as it
> has no changes to the kernel itself.

Yes, please keep the tooling updates separate from the kernel ones,
the way we now for some time have for the perf tooling too.

That said, mentioning the perf tools, I wish the tracing tools would
do a bit more package checking and helpful error messages too, rather
than just fail with

    fatal error: tracefs.h: No such file or directory

when (presumably) libtracefs and friends are needed.

Hmm?

              Linus
