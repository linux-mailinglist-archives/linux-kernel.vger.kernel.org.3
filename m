Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4F553D894
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 22:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241693AbiFDU7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 16:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241736AbiFDU7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 16:59:07 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BDD2DD7D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 13:59:06 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id me5so21516185ejb.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 13:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbrEQUB+Zyw7O+8amBfM3+EQ1xFJmvp6idV/N1yDO5Q=;
        b=DR6JLQBUlW6TeFrHbPNTHjl/bNSSCqd/TvAHeTrBSGSTdjt2PGWP1jVWpZeyjx8cfd
         AkBcoT49q87tGoi2VkRcbKs4iL+cRMb0cleRuWrgkIJ+RWSaC3CouP74nuwQa9OsPW4P
         OoLeajQHAxqfI4yromeBb40f78dyRk+QlG4Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbrEQUB+Zyw7O+8amBfM3+EQ1xFJmvp6idV/N1yDO5Q=;
        b=3A7uZojVZuA9Buf/lqCexagYD8nWVwp7Y5W90muR1Yink/u80ng9XrJCXwTJlqR25M
         gbaJIGDQv5dW/6cZB59rGCwNIi13ubUP5KvUqBWZp8dmzFGFP6mqjqt5aZnW1DDQGlSz
         97gnlkoEb8aLgb1oQALXGHvzy9fUdbFFFWSdOpQpxTuAgrDmQnnazw/iD9nuAgIKNl/t
         P4BzaGtMuuu7csHdvbq42cnHmRKH9ykZGJ2kiSvOdveZZUlewyzfZzNNjx9VwoDpra2r
         8bsiIEEtv/WaHat+VxqX6d5WYgJ5SEKoOfB423u3fZqK0mxr/xjpQil1E/lq86BndZBI
         twoA==
X-Gm-Message-State: AOAM533+xXNBODtrf9thDZUISwjmK1dslmwK5Ti58gu4il8yWMbrdHAE
        rs9dfJzkgc5SadRwvNJddBzGlIcSXAMZJpEj
X-Google-Smtp-Source: ABdhPJxFBq9zGOHbeS0dc7fnfmz68PEQO+rIb0Fy/lgIZWmIPlqrjss7s6nZgk1vGhNbrXWhHOQQUQ==
X-Received: by 2002:a17:907:1b07:b0:6fe:2cbc:15c5 with SMTP id mp7-20020a1709071b0700b006fe2cbc15c5mr14492275ejc.677.1654376344135;
        Sat, 04 Jun 2022 13:59:04 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id d7-20020a056402400700b0042e15364d14sm4163757eda.8.2022.06.04.13.59.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jun 2022 13:59:03 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id u3so14727133wrg.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 13:59:03 -0700 (PDT)
X-Received: by 2002:a5d:6da6:0:b0:20f:bc8a:9400 with SMTP id
 u6-20020a5d6da6000000b0020fbc8a9400mr13992817wrs.274.1654376342801; Sat, 04
 Jun 2022 13:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <Ypt1N+GyXEMfAxR6@p100>
In-Reply-To: <Ypt1N+GyXEMfAxR6@p100>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Jun 2022 13:58:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihXTsW_gkx=OdZf38MynCrmpe1P1EBnACH9PK7ggrdBg@mail.gmail.com>
Message-ID: <CAHk-=wihXTsW_gkx=OdZf38MynCrmpe1P1EBnACH9PK7ggrdBg@mail.gmail.com>
Subject: Re: [GIT PULL] more parisc architecture fixes/updates for v5.19-rc1
To:     Helge Deller <deller@gmx.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc <linux-parisc@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Mikulas Patocka <mpatocka@redhat.com>
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

On Sat, Jun 4, 2022 at 8:07 AM Helge Deller <deller@gmx.de> wrote:
>
> Mikulas noticed that his C8000 workstation hangs at bootup with v5.18 if
> CONFIG_SCHED_MC is enabled.  His fix rearranges the topology setup and thus
> prevents the problem.
>
> The other two patches enhance the info from the STI (text) console driver and
> add the missing fb_is_primary_device() function which helps the framebuffer
> driver to detect the primary STIfb framebuffer.

Sorry I messed up - I ended up taking only your abbreviated
explanation from the tag for the merge commit message, not this
extended explanation in the pull request email.

Normally I notice and fix this up, but this time I only noticed after
I had already pushed out the end result.

So now my merge has a correct message, but not as complete as it
should have been.

            Linus
