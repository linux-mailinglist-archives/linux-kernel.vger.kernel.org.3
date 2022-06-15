Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9011454D075
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355730AbiFORzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbiFORzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:55:47 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670FD44766
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:55:46 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id r24so1956763ljn.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7N8FxBu6DA6O7mEvFYXStFEfAYN9n61bDy3OwBXjJ0o=;
        b=JHdk1N03ADEWzySRt7KcxOBPuZaGFXA/8Xyn6d2SSlY9ihVTM6DTBbu1drTtrmQ+M1
         8RPbl/vwMUwgaM0Na3DeW4R1DvZyVGTsvcipdrdnr6LbuwHnx+DPjFA6rx07XSw0xDHv
         KK/3LfmRBtp3+hX2z93IpwI50ZnSgl482NCGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7N8FxBu6DA6O7mEvFYXStFEfAYN9n61bDy3OwBXjJ0o=;
        b=fqigjnnn1LqGWasd6PRLzgbO+MoZfEJJye76RODrmSDe76ftkWXYBKDnGqoxeSQwvc
         p0T1hRWPbyjo3Cw24ZGqXvT77zWCkRcKtwQ64gnU6NaAObp9aOp7v1DBa0BI1kcvPqXI
         ee9fV+yozhbY5CRG/5uX8ed0jtCKgJE4HRP50hyOtCxXzjxnSL7lw+ExgcpCyFC0ItjV
         N6bh4o9rX8tVsBSwE29tv8ciO8bzdmG3xCcBKTJX0Fu7jSXkNZdBnN9S0AOHgDn9GpCU
         JQDas4mh7xcvRyTJggAi/qdEVsbnsvcPCxE6jMxkcJzE9wvFFlKD9Bo9Z7WxN1jeWO5T
         54Fg==
X-Gm-Message-State: AJIora9Vi4otNgLJpbALmtuvDVH2Q7g2Cuy1OIS7FKQsEyaS4HP5vtr4
        ofdEOJcYLKHqqIPxURkZvakPvOT48Ubx2R7v46c=
X-Google-Smtp-Source: AGRyM1usq6rOnpKVnohX3RfJzcFbjacxYyo1QSxQi8IxyaWhI3JVOuBe+zfnFh1b5GZqxodmV+BC1w==
X-Received: by 2002:a2e:9a8b:0:b0:255:5c14:a90 with SMTP id p11-20020a2e9a8b000000b002555c140a90mr512828lji.137.1655315744482;
        Wed, 15 Jun 2022 10:55:44 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id u24-20020ac25198000000b00477cab33759sm1880398lfi.256.2022.06.15.10.55.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 10:55:44 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id c30so14118935ljr.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:55:44 -0700 (PDT)
X-Received: by 2002:a5d:414d:0:b0:213:be00:a35 with SMTP id
 c13-20020a5d414d000000b00213be000a35mr875787wrq.97.1655315251112; Wed, 15 Jun
 2022 10:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220615162805.27962-1-pmladek@suse.com> <20220615162805.27962-2-pmladek@suse.com>
In-Reply-To: <20220615162805.27962-2-pmladek@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Jun 2022 10:47:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com>
Message-ID: <CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] printk: Block console kthreads when direct printing
 will be required
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>, zhouzhouyi@gmail.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        rcu <rcu@vger.kernel.org>, linux-rockchip@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Jun 15, 2022 at 9:28 AM Petr Mladek <pmladek@suse.com> wrote:
>
> BugLink: https://lore.kernel.org/r/20220610205038.GA3050413@paulmck-ThinkPad-P17-Gen-1
> BugLink: https://lore.kernel.org/r/CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com

Other thread discussion about this exact thing:

   https://lore.kernel.org/all/CAHk-=wgzRUT1fBpuz3xcN+YdsX0SxqOzHWRtj0ReHpUBb5TKbA@mail.gmail.com/

please stop making up random tags that make no sense.

Just use "Link:"

Look at that first one (I didn't even bother following the second
one). The "bug" part is not even the most important part.

The reason to follow that link is all the discussion, the test-patch,
and the confirmation from Paul that "yup, that patch solves the
problem for me".

It's extra context to the commit, in case somebody wants to know the
history. The "bug" part is (and always should be) already explained in
the commit message, there's absolutely no point in adding soem extra
noise to the "Link:" tag.

And if the only reason for "BugLink:" to exist is to show "look, this
tag actually contains relevant and interesting information", then the
solution to THAT problem is to not have the links that are useless and
pointless in the first place.

Put another way: if you want to distinguish useless links from useful
ones, just do it by not including the useless ones.

Ok?

                   Linus
