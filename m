Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B088C526EC3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiENDVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 23:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiENDVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 23:21:38 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45FF6394
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 20:21:35 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id m128so18328117ybm.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 20:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kuZ/tZDybeSTawcvTvpI2RevU8flYBPshQ+5iLiR3Zs=;
        b=3HyREbUctyjj+4zETcpZCbkOwqWi5d2oHqeDX/s9l2k4m/D9uEht6xBYURXsrGFFgu
         zx6B1LesVKBJX10wRMUvEncov61nsk/UiFZL6BeOpJPOZ2qggq5WHOMEaMaCUxilsB9B
         qjxAAfZKAkOaOMzSO6WYJaJzKfuzeCP0JMQPRYWVrkqNMh30kdS6S24w4CCTm/Mas8xn
         dnG/FwkfE50Kf94mMdeI9h0v4GpjMW7oAuMsYWFCbZQpYb/s28URsC2+MqOztlU2oi/Y
         vUc+FdADGfZOr+4uBa50IM0FtdTyMcA6T+edXmk+FCW65rU+4nSuW5Ps6k52T379m1rw
         fP+Q==
X-Gm-Message-State: AOAM531S5XcjwfOV9P9PeFwcl2WvhbOgKwc7Z8rj/CmoaUSRyJ49d/oR
        Lx9Z2j3uN+4huMMcVZANDIO9RQnmhNBYKZvvtbc=
X-Google-Smtp-Source: ABdhPJw/iZb6aGqYy+jy1pkWQ3eM5+6OebS7EYxdeOUQ+fM8ZVNz0ofDPbxScDtE3nYeMVvqOaJ1CQ4FCe41R+gjm+A=
X-Received: by 2002:a25:e705:0:b0:645:781a:f870 with SMTP id
 e5-20020a25e705000000b00645781af870mr7849685ybh.630.1652498494973; Fri, 13
 May 2022 20:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220426155229.436681-1-mailhol.vincent@wanadoo.fr>
 <20220507131146.834810-1-mailhol.vincent@wanadoo.fr> <20220507131146.834810-3-mailhol.vincent@wanadoo.fr>
 <CAK7LNATuvQhiZZ8A9+RcLYKmbugi6S61Aw5CStc3xbfGM-L34Q@mail.gmail.com>
In-Reply-To: <CAK7LNATuvQhiZZ8A9+RcLYKmbugi6S61Aw5CStc3xbfGM-L34Q@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sat, 14 May 2022 12:21:24 +0900
Message-ID: <CAMZ6Rq+bUdxhVOc_oxtWiXt+9MFZSDPaOqxHBA0bA7hg=+SBjA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] kbuild: call check-atomics.sh only if
 prerequisites change
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat. 14 May 2022 at 04:01, Masahiro Yamada <masahiroy@kernel.org> wrote:
> On Sat, May 7, 2022 at 10:13 PM Vincent Mailhol
> <mailhol.vincent@wanadoo.fr> wrote:
> >
> > check-atomics.sh is executed unconditionally. Most developers will not
> > modify the files being checked by this script and thus do not need to
> > execute it again for each iterative make.
> >
> > We first add an additional dependency to include/linux/atomic/* to
> > make sure that the script gets executed again if the headers are
> > modified. We then use the if_change macro instead of cmd. c.f. [1] and
> > create the dot file scripts/atomic/.check-atomics which is used for
> > the target timestamp. Finally, the dot file is added to the
> > CLEAN_FILES target.
> >
> > [1] https://www.kernel.org/doc/html/latest/kbuild/makefiles.html#command-change-detection
> >
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>
>
> I do not like this approach.
>
> I wrote a different patch.
> https://lore.kernel.org/lkml/20220513185340.239753-1-masahiroy@kernel.org/T/#u
>
> This naturally works by comparing the timestamp
> between *_shipped and include/generated/*.

Thank you very much for taking the time to fully rewrite it in order
to simply discard the check-atomics.sh. I like the idea.
