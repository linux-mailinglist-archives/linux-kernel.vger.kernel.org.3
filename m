Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A0454FDE2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbiFQTss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245188AbiFQTs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:48:29 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D385321278
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:48:27 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id g25so10545095ejh.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+EKwqCsztIzjML5eTOI4DyB4igY/i9zv7rTWORQZJYU=;
        b=V+sB5rMnGZRxn8yt2BHn5Ul5zj4u67xcYI16zxGhn/AndUz5pb4jxIvTXtTtF9VSs2
         G6CGVFvL6OBJo0YqcNjRjvLqeMck9braWkKsDSqRhh4QFdy2VAq2Q+K7uWthjnQqVWIg
         kyoo5rOek/vmTzszxHJfRJQnbXvu03AOFmSaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+EKwqCsztIzjML5eTOI4DyB4igY/i9zv7rTWORQZJYU=;
        b=dxNjfySQB7QAf9PMeazkUGKQzgkjX7NqDKTF7h7ZykCmL2WOkbzG2xal1hP/iuHVFh
         Ggfy6r2Zowt/5H6t+WcWQ1rv+tC21dBfuScj9J6n15dGX1S6G1W/dh3Nh2nyBezYUUiU
         IJXaBhMQJCaWGZGMcWwXD/S/sGv8/V8T4QXfg+ztPIGhqceLfr0RfHFwVbn+To9+I5If
         N0zE4lXqdCpPMJoS0K9re1WNQBdvHBFczkATEh6Skv/cXYCmWl+Oy8zsatYM1buxh/ON
         eHY8V3Wt4UQEgPE+dKkyt5IesxyAacJGRE52pLd4/8uimF4ij9AviG5efWP9w2zT/ycc
         iaEA==
X-Gm-Message-State: AJIora8EOs6zVJ0wi2OHNWOuy+DCz0KFooz0B8FCIWK8IIWFv1jm2ehx
        zn0wrm9RglQw9sAja86xWQC1WBqyHCpSaOLm
X-Google-Smtp-Source: AGRyM1vziQFc5SgyDj00yxKjrntPVatXmBpNNcAnvHSJuFie6/zgxBVdiRGNGTjqMuA2SuzRm+rYEA==
X-Received: by 2002:a17:907:c24:b0:711:d4c6:9161 with SMTP id ga36-20020a1709070c2400b00711d4c69161mr10978709ejc.760.1655495306192;
        Fri, 17 Jun 2022 12:48:26 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id i24-20020a05640200d800b0042dcac2afc6sm4234309edu.72.2022.06.17.12.48.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 12:48:25 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id q9so6954106wrd.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:48:25 -0700 (PDT)
X-Received: by 2002:a05:6000:16c4:b0:20f:cd5d:4797 with SMTP id
 h4-20020a05600016c400b0020fcd5d4797mr10819451wrf.193.1655495305221; Fri, 17
 Jun 2022 12:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220617091039.2257083-1-eric.dumazet@gmail.com>
 <YqxufxqsnHjVfQOs@worktop.programming.kicks-ass.net> <2dd754f9-3a79-ed17-e423-6b411c3afb69@redhat.com>
 <CALvZod5ijDz=coEE8G8v_haPaKuUa5jHYzEwKvLVxHGphixsFA@mail.gmail.com>
 <2730b855-8f99-5a9e-707e-697d3bd9811d@redhat.com> <CANn89iJLWJMmNrLYQ0EU7_0Wri6c3Kn9vYMOiWu1Ds8Af2KOnw@mail.gmail.com>
 <7499dd05-30d1-669c-66b4-5cb06452b476@redhat.com> <CANn89iLxX_bqD8PvAkZXGWzKBKYxB3qaqQjxxdmoG91PfmvRnA@mail.gmail.com>
 <YqzQKER4JRoudTJE@hirez.programming.kicks-ass.net> <CANn89iKO1koPa5R_mvK0k2dkFaq+F0PgcbvpVt+JpzzR5xsu6g@mail.gmail.com>
 <CAHk-=wjLOLWV2NvBPozUj0krF6fvWv6mrC4xpCBVXc=e2+dqPQ@mail.gmail.com>
 <CANn89i+wBM+ewcP9u+ZWDqv3zQeK7ovKB+YJf9S6Om5QkqhLHA@mail.gmail.com>
 <CAHk-=wi9ut1VkB=Ja_gYtH67DZ7cc5QBG-uJCPkOpU=MZDJSUw@mail.gmail.com> <CANn89iJXeUJRV2+8reUdaeARxYPPbCoG+9atmRFfy4kv0XX00A@mail.gmail.com>
In-Reply-To: <CANn89iJXeUJRV2+8reUdaeARxYPPbCoG+9atmRFfy4kv0XX00A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Jun 2022 14:48:08 -0500
X-Gmail-Original-Message-ID: <CAHk-=wiEZmzBUFkZkBrJv3JSJkQ+qxaMZU_Sx1WTpMHs2SOAiQ@mail.gmail.com>
Message-ID: <CAHk-=wiEZmzBUFkZkBrJv3JSJkQ+qxaMZU_Sx1WTpMHs2SOAiQ@mail.gmail.com>
Subject: Re: [PATCH] locking/rwlocks: do not starve writers
To:     Eric Dumazet <edumazet@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>, Roman Penyaev <rpenyaev@suse.de>
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

On Fri, Jun 17, 2022 at 2:39 PM Eric Dumazet <edumazet@google.com> wrote:
>
> I am converting RAW sockets to RCU.

RCU is usually absolutely the best approach. Use regular spinlocks for
writers, and RCU for readers.

I'd love to see the tasklist_lock be converted to RCU too.  But that
locks predates RCU (and probably 99% of all kernel code), and it's
messy, so nobody sane has ever willingly tried to do that afaik.

               Linus
