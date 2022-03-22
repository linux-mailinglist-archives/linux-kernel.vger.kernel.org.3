Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA71E4E457F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239892AbiCVRw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239841AbiCVRwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:52:25 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F106D3BC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:50:56 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id w7so31077866lfd.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xVTkoL6IvScupcc82uGKxY6t/dEoMhywmokb0M6nLRQ=;
        b=SxzIsWJtVeaoBw1JvaNfWaX6iOJGZ1awG+smm6ZI3+2778B8fIRobefB0fFKcM4q6y
         2r4/TVzojriOvGIybdvH82leIyhyqc+uKQhIoA5t/IeWmMqoqy0YAgzr+NxHjUuOLxlx
         Q2wcsmI+T+V32+6FiBPcrXt1ViZUuv3r4KJS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xVTkoL6IvScupcc82uGKxY6t/dEoMhywmokb0M6nLRQ=;
        b=xzYBK97pebPrZag6cYoqLl7JigHXZk5UjFWa9hEhCkDH+2YYzzmNlOZtqvlKu2WpvI
         JCTJutVHJEReQmCrfPXhCmZuJR8j9ChAZ86yC5MPv0AS9pHYaHApS47vGQDt2LwAm2aH
         zek0FrCdRnGUkvkUxAyiOcyBjdkrpnHvRl10POffYztrl0WDz/ycTykKmQZ9vty03fzc
         VqUmG5P5T/flDu5ZUow5OKX5DTudcfVnZEAajqrSkmun9L+Rsqp1BBqqU/GhglcCHzwO
         s2tDldc3npnHhjOeYykTOYb3P3QGdmbDW9MyvRiZczXD4A530LjQeLWoc7niAVu3nJbY
         NQvw==
X-Gm-Message-State: AOAM530mQsBEQr/dyiwimNhn6DTyWvVM62EBfIFw6SNxbKAvqOvv7jFe
        vnfUwiaMXq6CzDnyfMJ24RbpTJwLSuHTLrigz3g=
X-Google-Smtp-Source: ABdhPJwmTntAlNcdrpCzHUJgWtqFqeUPVaKX1JwLNZ2enCdj6LC5U30nc84iRSGWeAyVEjhCX0YlIw==
X-Received: by 2002:ac2:5bcb:0:b0:44a:1fd6:6b14 with SMTP id u11-20020ac25bcb000000b0044a1fd66b14mr11745765lfn.186.1647971453692;
        Tue, 22 Mar 2022 10:50:53 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id h8-20020ac25d68000000b00447b5cad2a7sm2270462lft.228.2022.03.22.10.50.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 10:50:52 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id u3so25094704ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:50:51 -0700 (PDT)
X-Received: by 2002:a2e:9904:0:b0:247:ec95:fdee with SMTP id
 v4-20020a2e9904000000b00247ec95fdeemr20114422lji.291.1647971451760; Tue, 22
 Mar 2022 10:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <YjjihIZuvZpUjaSs@google.com> <CAHk-=wgsmvoJFKFWxQ2orEVUOWH1agk9iUNZ=-DFh5OXZL=Ldw@mail.gmail.com>
 <51cded74-3135-eed8-06d3-0b2165e3b379@redhat.com>
In-Reply-To: <51cded74-3135-eed8-06d3-0b2165e3b379@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Mar 2022 10:50:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=Xsekgj7zfw_vpOM673CG24vznmz-yx9G05rWSAAYXg@mail.gmail.com>
Message-ID: <CAHk-=wi=Xsekgj7zfw_vpOM673CG24vznmz-yx9G05rWSAAYXg@mail.gmail.com>
Subject: Re: [GIT PULL] f2fs for 5.18
To:     Waiman Long <longman@redhat.com>, Tim Murray <timmurray@google.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
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

On Tue, Mar 22, 2022 at 10:37 AM Waiman Long <longman@redhat.com> wrote:
>
> AFAICS, the read-unfair rwsem code is created to resolve a potential
> lock starvation problem that they found on linux-5.10.y stable tree. I
> believe I have fixed that in the v5.11 kernel, see commit 2f06f702925
> ("locking/rwsem: Prevent potential lock starvation").

Ahh.

Adding Tim Murray to the cc, since he was the source of that odd
reader-unfair thing.

I really *really* dislike people thinking they can do locking
primitives, because history has taught us that they are wrong.

Even when people get the semantics and memory ordering right (which is
not always the case, but at least the f2fs code uses real lock
primitives - just oddly - and should thus be ok), it invariably tends
to be a sign of something else being very wrong.

And I can easily believe that in this case it's due to a rmsem issue
that was already fixed long long ago as per Waiman.

Can people please test with the actual modern rwsem code and with the
odd reader-unfair locks disabled?

            Linus
