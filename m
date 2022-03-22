Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B1E4E44F4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239536AbiCVRYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239525AbiCVRYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:24:40 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9302697
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:23:11 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id h7so13500881lfl.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UI6IdkHO1Ce++v4SaLpwOnJOwU7d+FJPmUdI5pUTRyE=;
        b=ODOcxjgtnTokJhq+iwqHbWCzeAZBV5BHLUnl+SfPcnQbCPUA32VYdzSgQPu+R0V5Oc
         LOX36yzr/Ok6oTqeCrrsPc9enhp/AEQ4fLBbhY9IM+kEdjwZ0kheWb9v+kvXcu2eaHu4
         49yhuMftUCepZufEyK9CKXp+4gagEX4g0EloY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UI6IdkHO1Ce++v4SaLpwOnJOwU7d+FJPmUdI5pUTRyE=;
        b=13TKir04ncyzAFiB/5JH8x7JrVxnXlnBJKEq/Eee+TobXz5hjKPy1uXQHMBGC64N/R
         v2N7w9+gXW6WJNlsAijoHJBEt26MvYD7Qga2Fv9GMKxlpIn77k8aCb9Rrj3xvaNv8uOZ
         faJz/pLCk9+FsfNIhvqeV+9pgP7UKvOM83wSFQKzHiAtQZq/m8zPkWffl93GmWft4t7d
         A5Z0MZj0MagBZjU+9u2T61+XIxhxniqddbQGl3eExOVsnuUAhwzWa8kFHzydEuHVxiFB
         nSeR9KTcgf0nB5IN8xQ/7VwcUckZdCEx5inASSXZqxzmtM8k7Yake4Xi3vupac5txjla
         1oEA==
X-Gm-Message-State: AOAM533Iq9gpIJLRAJo/UxTUTQubiLN1biKE0iMiNXJNclgaVpYGnwsN
        Foe3OFPEOHTwVbMhcwP/61XED+9cD2ecjoEAOQQ=
X-Google-Smtp-Source: ABdhPJyfPdnQcs25C0axXJ91+8HJ5kK5FxxhFnErxXwz19m+pvfeIeiKO473IJFUlJttHa+SpSYESA==
X-Received: by 2002:a05:6512:3c96:b0:44a:3c85:ddb0 with SMTP id h22-20020a0565123c9600b0044a3c85ddb0mr2584996lfv.457.1647969788350;
        Tue, 22 Mar 2022 10:23:08 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 11-20020a2e154b000000b0024967cd674esm2117503ljv.35.2022.03.22.10.23.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 10:23:07 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id h11so24915698ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:23:07 -0700 (PDT)
X-Received: by 2002:a2e:9b10:0:b0:247:f28c:ffd3 with SMTP id
 u16-20020a2e9b10000000b00247f28cffd3mr19288283lji.152.1647969787311; Tue, 22
 Mar 2022 10:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <YjjihIZuvZpUjaSs@google.com>
In-Reply-To: <YjjihIZuvZpUjaSs@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Mar 2022 10:22:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgsmvoJFKFWxQ2orEVUOWH1agk9iUNZ=-DFh5OXZL=Ldw@mail.gmail.com>
Message-ID: <CAHk-=wgsmvoJFKFWxQ2orEVUOWH1agk9iUNZ=-DFh5OXZL=Ldw@mail.gmail.com>
Subject: Re: [GIT PULL] f2fs for 5.18
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Waiman Long <longman@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Mon, Mar 21, 2022 at 1:39 PM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> In this cycle, f2fs has some performance improvements for Android workloads such
> as using read-unfair rwsems [...]

I've pulled this, but that read-unfair rwsem code looks incredibly
dodgy. Doing your own locking is always a bad sign, and it ahs
traditionally come back to bite us pretty much every time. At least it
uses real lock primitives, just in a really odd way.

The whole notion of making an rwsem unfair to readers sounds really
really odd.  I mean, the whole and only _point_ of an rwsem is to
allow concurrent readers, and traditionally if it's unfair it's unfair
to _writers_ because that tends to be better for throughput (but
unfairness can cause horrible latency).

So it smells like there's something bad going on in f2fs.

That said, I'm adding Waiman to the cc here in case he would have
ideas at least for a cleaner interface. Our rw_semaphores are
explicitly trying to be fair, because unfairness (the other way) was
such a big problem.

I'm wondering it the optimistic read lock stealing is bothering f2fs?

               Linus
