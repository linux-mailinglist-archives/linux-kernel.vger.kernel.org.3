Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B686659366F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 21:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245567AbiHOTTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 15:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344528AbiHOTQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 15:16:53 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B912753D1A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:38:14 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s11so10617754edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=KlWxbeNY88H7/04YoN4IUdjUlk7sZYn5STlHYYrpuXg=;
        b=KKZH+BQv+dCW91HDyt6CSYiqA3Q/eJRjQue5eXCTjkrWZ0nPFTUbmLnkmiW9/xGron
         rntinkzfp2SP7n/QcWMdzjEIYOGq0gcrCSDkUoxc438MS18pCyXM9GuKjEqfM4fklI8/
         l2G938q7hoRCDCvFNbig34GpCc7cY2xPS1UZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=KlWxbeNY88H7/04YoN4IUdjUlk7sZYn5STlHYYrpuXg=;
        b=PGqfzxH5mPvHdEogkHHtu+ERKCXxdrZPOXqZ6z7T01pEe65kQ7LxtRrsiaXRndt6j1
         dWgdJQxCsfrlZZU1kh1ybFHVQdWgRYfRfgYYTNMRQDZ0vjVsaw/l+5He1q6dSp2/gQUy
         T5suKrsbZLueG3pzvqwWXha9fGnjYsXyMKsKqCQTv53kgi5OkTP981+kaQIXAtWH8c8M
         Tsp1Y0XYWT9g3TyR6qPis5NQNHEtJkR8rwurpw2NXL/wPidFgvHARTYOMHb4IO0MUfUi
         /cQ66FdrLqiWI5zmiGK3QuJFyOeWSzsdvd4n0gUPCd59Wr939C85XUUR69RnkmQUyEZR
         w1Ng==
X-Gm-Message-State: ACgBeo0RXlqI6jCKFSEYIMc+wh8CxTdGtVMLM+VN5hN3W5sh8VApVdue
        XNk1liGFYxXrqvav6ULoIrP3TBWKhsZpOUko
X-Google-Smtp-Source: AA6agR4TEmYyvUgS0eUc4R5/DzPWq89GUa+iApKyOLpD3lXOyKLYCED1ii0CTdcALF1retnNXxl1HQ==
X-Received: by 2002:a05:6402:1777:b0:43d:85da:2fac with SMTP id da23-20020a056402177700b0043d85da2facmr15826326edb.32.1660588692205;
        Mon, 15 Aug 2022 11:38:12 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id z13-20020a170906714d00b0073180489522sm4290252ejj.118.2022.08.15.11.38.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 11:38:11 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id b4so6904563wrn.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:38:11 -0700 (PDT)
X-Received: by 2002:a5d:56cf:0:b0:21e:ce64:afe7 with SMTP id
 m15-20020a5d56cf000000b0021ece64afe7mr9360551wrw.281.1660588691209; Mon, 15
 Aug 2022 11:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220814212610.GA3690074@roeck-us.net> <20220815054117-mutt-send-email-mst@kernel.org>
 <20220815154920.GA4027315@roeck-us.net> <20220815120007-mutt-send-email-mst@kernel.org>
 <20220815182254.GA3241114@roeck-us.net>
In-Reply-To: <20220815182254.GA3241114@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Aug 2022 11:37:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjWN6Wh1t5g48=ue4Ti6ig2P7u5nXBcQjLf=oiAZibk6w@mail.gmail.com>
Message-ID: <CAHk-=wjWN6Wh1t5g48=ue4Ti6ig2P7u5nXBcQjLf=oiAZibk6w@mail.gmail.com>
Subject: Re: upstream kernel crashes
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
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

On Mon, Aug 15, 2022 at 11:22 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> I ended up publishing several of the syzkaller reports because I could
> not figure out how to test the proposed patch otherwise. Sorry for the
> noise on the mailing lists, but I just could not figure out how to
> trigger test runs without making the reports public. Various test runs
> are now queued. Hopefully we should get results soon.

I actually think that the best "test" is to just test the revert and
see if the problems go away.

You may not have found a way to reliably trigger one particular
problem, but apparently you can easily enough trigger some random
issue with enough tests.

If it's some random memory corruption, there may simply not ba a great
reproducer, with the oopses just depending on random layout and
timing.

              Linus
