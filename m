Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0273453AE58
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 22:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiFAUpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 16:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiFAUpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:45:17 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7891842DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 13:31:08 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t25so4613794lfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 13:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XQjh59P+YL657/ugkQgJkelCDXFl1T1Vs2NaT8wJJmg=;
        b=ZZSpwU9hNx1vIgT23ZqORpMaSlb67mK71XYRdg7+sMMlwAstjUOjkA0TEXRoOiSjBx
         1jZ+YVX1Q02lET6yIsH0PSBUu0oWXEAM0SWXWzAqwObT9JFumL5b5q+9KN6/0sp3uyvB
         Pok3GJX3EYSYz40c743Gtv1qk9/v1YKTSe4Gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XQjh59P+YL657/ugkQgJkelCDXFl1T1Vs2NaT8wJJmg=;
        b=Aq36YJOkbvQ6rWH0ckGQfBKoh5wYM82EIKl8jdSd7GiuREjrzOiW9boWCmy9o7YwRk
         nW9ivShbIplBxa5V9yyvCyxq3Yzd3M2xItnIE8tqFKQHgbOmg79WHmoujVyHJXqwwIBj
         I8hmkN2ZOMHmgsKwXfxuDNpe56o0CowXFG8FHrlHszy25qvHJ5sU+CbFLFmcU+7MRlgL
         Uv2h0ihZxtEDlqy2y2xpuOTyewbebug1JVXw4e6ccIiMpiA7KwPslgYqPfCFuaUMW/r5
         LXDOiSo/BBtQMP1TJhPntnJd67kWZOdhSZvBws5bbRUResSZ6G4d0u7LAwH7G9t1c0VD
         Hzcg==
X-Gm-Message-State: AOAM532idqESG2E7vo52WDHTYBGyaU4bt4qNk3rSr18ryM4V0xq9j3Cg
        1hiNZZTot4/WhtkKReE/3dlm5J3wW9BaEWpo
X-Google-Smtp-Source: ABdhPJz8YNLMZGQfEVyOLTQeyFpMyxl7Idv2/Z618mMeDk49sieLX+riAxxSTfWUm/GfVfR/fGPuLA==
X-Received: by 2002:a17:906:4784:b0:6ff:34ea:d824 with SMTP id cw4-20020a170906478400b006ff34ead824mr999873ejc.526.1654111404095;
        Wed, 01 Jun 2022 12:23:24 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id dc15-20020a170906c7cf00b006ff045d7c9bsm1013243ejb.173.2022.06.01.12.23.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 12:23:23 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id k16so3661982wrg.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 12:23:23 -0700 (PDT)
X-Received: by 2002:a05:6000:1605:b0:210:307a:a94a with SMTP id
 u5-20020a056000160500b00210307aa94amr744700wrb.97.1654111402828; Wed, 01 Jun
 2022 12:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whi2SzU4XT_FsdTCAuK2qtYmH+-hwi1cbSdG8zu0KXL=g@mail.gmail.com>
 <cover.1654086665.git.legion@kernel.org> <5ec6759ab3b617f9c12449a9606b6f0b5a7582d0.1654086665.git.legion@kernel.org>
 <Ype7skNJzEQ1W96v@casper.infradead.org>
In-Reply-To: <Ype7skNJzEQ1W96v@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jun 2022 12:23:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTtYMia0FR4h7_nV2RZ5pq=wR-7oMMK3o8o=EgAxMsmg@mail.gmail.com>
Message-ID: <CAHk-=wiTtYMia0FR4h7_nV2RZ5pq=wR-7oMMK3o8o=EgAxMsmg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] sysctl: API extension for handling sysctl
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexey Gladkov <legion@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux.dev>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Vasily Averin <vvs@virtuozzo.com>
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

On Wed, Jun 1, 2022 at 12:19 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> Why not pass the iocb in ->read and ->write?  We're still regretting not
> doing that with file_operations.

No, all the actual "io" is done by the caller.

There is no way in hell I want the sysctl callbacks to actually
possibly do user space accesses etc.

They get a kernel buffer that has already been set up. There is no
iocb or iovec left for them.

(That also means that they can take whatever locks they need,
including spinlocks, because there's not going to be any random user
accesses or complex pipe buffer lookups or whatever).

                Linus
