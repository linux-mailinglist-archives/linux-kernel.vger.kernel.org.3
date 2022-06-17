Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D008E54FD39
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbiFQTKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiFQTKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:10:18 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C26D5675F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:10:18 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-31772f8495fso50163217b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yhHCwOK3viBqjIKhY76qpzkBW+ZqX0Wssj/behLDtnY=;
        b=qcLNckrwocnnxou961SWlQpVChEvmk+6xfzoQgpfw0CPt37VLC7G3KBsrHDqz2tYpB
         WbJ6a/qa38nYTDbhRwsbu+M8ziEfQ525pjqLiCgTGqsOtHfHT2tDwWZ/TrQO0Ii4z5cT
         NO+cqPwwllaYvuGZoyymAQwgNVLyO7XeXqhtRc5hhaakZbB0mJJnrvXl6exaJeY5SiUT
         vayFE380Uu+tM23KO/Zmbsri8fcClAH2A3Lxrl/fdb364fQH3jvRGTSKXXGXE9eJ8tKn
         281ypcoOj0J1eBXLV6ztmKlw8pBPYtTUs+uTNweuTQIeFioR4RB45CEvGAkEoZ1u9fmU
         N0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yhHCwOK3viBqjIKhY76qpzkBW+ZqX0Wssj/behLDtnY=;
        b=zy+M/EU4KT0AfZyQW+o8lCg6Wv2HTwF90MX3OcCltM9WByOds4KcnJg/Ura0l0bqm8
         3zg1stdfJTXnK6GbHURslZnQgiBkDyD4iCKHfBTXKaPFIfgUl7KuqN9BLsFUdWdd2h8z
         Co1A/yOTeyA0NWKX1qM3amMXUuY6jgXvl2Z8eg6fV5/5GFCYeXNDbjIJYFSr1+SUE9jq
         mZqG5GdR+T/9eun5Zk47+a1GZlDOD2w5DFNhNIJN5mjAL5qHKTbaLrpNQaDc8Eaqy1bZ
         i0T+somHKrSGUPlKDmA85PXau3prtpSt+7ueiDyo0eLonWZKJCaiCtlfFcJKjpps1pSb
         01xw==
X-Gm-Message-State: AJIora8uQ5m5JEv6eaVVpcgfuzfKhgaxH+uRyOAl6QuB8fuyE1LBwtpD
        5OsmSvcghKOLf0SZTV7aDssNtFi5tl3/2H/6dEyMWw==
X-Google-Smtp-Source: AGRyM1ta6UYIw9pqkxZ7WSIN+mg9Rn/APFrwvEqFQo0xbEwgsHbDrlI87NH4g5lmbkGM5rUY1MTI5v5S0p/2URZsFIw=
X-Received: by 2002:a0d:fac6:0:b0:317:5202:b8c1 with SMTP id
 k189-20020a0dfac6000000b003175202b8c1mr12831001ywf.467.1655493017074; Fri, 17
 Jun 2022 12:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220617091039.2257083-1-eric.dumazet@gmail.com>
 <YqxufxqsnHjVfQOs@worktop.programming.kicks-ass.net> <2dd754f9-3a79-ed17-e423-6b411c3afb69@redhat.com>
 <CALvZod5ijDz=coEE8G8v_haPaKuUa5jHYzEwKvLVxHGphixsFA@mail.gmail.com>
 <2730b855-8f99-5a9e-707e-697d3bd9811d@redhat.com> <CANn89iJLWJMmNrLYQ0EU7_0Wri6c3Kn9vYMOiWu1Ds8Af2KOnw@mail.gmail.com>
 <7499dd05-30d1-669c-66b4-5cb06452b476@redhat.com> <CANn89iLxX_bqD8PvAkZXGWzKBKYxB3qaqQjxxdmoG91PfmvRnA@mail.gmail.com>
 <YqzQKER4JRoudTJE@hirez.programming.kicks-ass.net>
In-Reply-To: <YqzQKER4JRoudTJE@hirez.programming.kicks-ass.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 17 Jun 2022 21:10:05 +0200
Message-ID: <CANn89iKO1koPa5R_mvK0k2dkFaq+F0PgcbvpVt+JpzzR5xsu6g@mail.gmail.com>
Subject: Re: [PATCH] locking/rwlocks: do not starve writers
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>, Roman Penyaev <rpenyaev@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 9:04 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 17, 2022 at 07:45:14PM +0200, Eric Dumazet wrote:
>
> > Were rwlocks always unfair, and we have been lucky ?
>
> Yes.

So I wonder why we replaced eventpoll spinlock with an rwlock.

Writing a repro is probably more difficult for eventpoll though.

We definitely had production issues after commit a218cc491420
