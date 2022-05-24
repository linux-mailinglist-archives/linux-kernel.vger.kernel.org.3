Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8096F531F98
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 02:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiEXALi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 20:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiEXALc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 20:11:32 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509EB40E73
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 17:11:31 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eg11so21031790edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 17:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=887/AtOOEOy4hdannnUAPSxRRvVEpBOXoWWcIcNFEig=;
        b=LCKHw1SRAXq0+4j95+yp5/cEPn6eGn+sMOZYPX5M8L2wlQ6gP0hIuItmpUW7I/zJn9
         iBM8cVkG1L8or0or2odW8yhIjb8hzAWXDEdL8bK/erzE5IdCrvkIuVEEI4cClm9gCqSC
         gkmz4Yf9LDMjGbAAnag4QmVI5NoS/YLpdtOoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=887/AtOOEOy4hdannnUAPSxRRvVEpBOXoWWcIcNFEig=;
        b=ZZ264udJyUVtkTvi2OUhsfqOt/f4RkUwVsefRMbc79Wd/bzDExiQNjbMCfJo+BfLNH
         LpA09u0sJVm3E8XlKHwUWxIBxmEUadkXGMjG/BJplZutkf2i+3e4RmVkoGjcHKRBSzcd
         LeSNfZWjsFamR3v2Yeu9Ne8eJrH5AAZ1x1AF9RqmUyOvS574D4/VUq7T60C8DTIYfCXx
         Z0HkoUCT2ciWzTWdDBdfd5AA0Yrrba/eylFBNp+McHYTvhZw8XIzOryX4b7ss+Nc6yNL
         APY9rRmKJeCXLZeSMcy5rMFjAoOW1BtyRCLnzCWcOP38iataVqoa/nwBkh8oyKNROTGb
         1xFA==
X-Gm-Message-State: AOAM532Abu+ylS3SPXXwdjqZZEWRQ1TcIkYyMkHgq3k4n+QQ+GrVJzTG
        Iq19nSH2SG7UbTPKln6MzPxddLNHwWkyUNE1Vyw=
X-Google-Smtp-Source: ABdhPJxBRa4EOteUepn3uwrfJ48x1d1laiwal7XPgCqPLCyNEA7iaWchyk8oC0NqDEyZLLIs8CyP0Q==
X-Received: by 2002:a05:6402:2911:b0:42a:b141:b221 with SMTP id ee17-20020a056402291100b0042ab141b221mr25949115edb.138.1653351089647;
        Mon, 23 May 2022 17:11:29 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id k24-20020a05640212d800b0042aaecf8707sm8710002edx.70.2022.05.23.17.11.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 17:11:29 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso473611wmn.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 17:11:28 -0700 (PDT)
X-Received: by 2002:a05:600c:4f06:b0:394:836b:1552 with SMTP id
 l6-20020a05600c4f0600b00394836b1552mr1243280wmq.145.1653351088369; Mon, 23
 May 2022 17:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <165329267741.3801280.534077656528571075.tglx@xen13> <165329268338.3801280.15015388773053623832.tglx@xen13>
In-Reply-To: <165329268338.3801280.15015388773053623832.tglx@xen13>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 May 2022 17:11:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0q-c95_OaHf9Eq16C7kURDNugdqBrE1wwXJf+yfX4Yw@mail.gmail.com>
Message-ID: <CAHk-=wi0q-c95_OaHf9Eq16C7kURDNugdqBrE1wwXJf+yfX4Yw@mail.gmail.com>
Subject: Re: [GIT pull] timers/core for 5.19-rc1
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
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

On Mon, May 23, 2022 at 1:02 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2022-05-23

Hmm. My diffstat didn't match yours, and I couldn't figure out why,
until I noticed that:

> Anna-Maria Behnsen (3):
>       timers: Fix warning condition in __run_timers()

You had already sent this one to me as part of the timer fixes pull
back in mid-April, so it was already in my tree. Apparently you hadn't
updated upstream before doing the git request-pull script.

                   Linus
