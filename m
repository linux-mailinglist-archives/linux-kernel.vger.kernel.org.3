Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8159D4D71EA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 01:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiCMAgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 19:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiCMAgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 19:36:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D1290CE7;
        Sat, 12 Mar 2022 16:35:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57373B80A36;
        Sun, 13 Mar 2022 00:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6901CC340F3;
        Sun, 13 Mar 2022 00:35:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aQnGnKld"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1647131720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iZDuDh64wMh+4YH3/62sfGWgDoLtPFLJScGG3GV+WYo=;
        b=aQnGnKld47OhcfKCazpm3IopqJi3OUR4lhRoCGhOM/0kSQHAdou2AbfvUI1Kf568KA4eKi
        xFWk8aczYQs1cN5FBTYYaNGvq18Ssey1baKxfNz+crf9sOmdp0cWGhtyY7KfOudmfnymE4
        ZCh6Z9k/oBIXsaCBLATzLFlCiXg2p9k=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 011740c4 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 13 Mar 2022 00:35:20 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2db2add4516so130483667b3.1;
        Sat, 12 Mar 2022 16:35:19 -0800 (PST)
X-Gm-Message-State: AOAM533iDW9YenkwRu3s9WEkamlnYqFcPKjVf4Y9PQ5MDROd6Vu6ZRvM
        cHDptDsN+4cuyJPOjteJSn5ZTdIPqUj8Adr4tKg=
X-Google-Smtp-Source: ABdhPJxmJVpVD+C2TGWuiR/KBjk+ghEFNJM5yLGLqJ7HU52NImuUyNzHzvbKyqcc2da6jzU+R/meahCPd60w7596YUI=
X-Received: by 2002:a81:10c5:0:b0:2dc:4b7:d487 with SMTP id
 188-20020a8110c5000000b002dc04b7d487mr13578729ywq.396.1647131718963; Sat, 12
 Mar 2022 16:35:18 -0800 (PST)
MIME-Version: 1.0
References: <20220309152653.1244096-1-Jason@zx2c4.com> <20220309191850.1508953-1-Jason@zx2c4.com>
 <YimFHeXgw9jfevWq@sol.localdomain> <CAHmME9ohyKKX4Qg_dyGq36MxFkhBoVQYYgs8uUoCfBkJNqfX7Q@mail.gmail.com>
 <Yiz4KBqaxURu/6mZ@sol.localdomain>
In-Reply-To: <Yiz4KBqaxURu/6mZ@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 12 Mar 2022 17:35:08 -0700
X-Gmail-Original-Message-ID: <CAHmME9qWp56dBEgXGUPhpPJRBsS0Sq8rZkPHLAHVcLuks+aK8w@mail.gmail.com>
Message-ID: <CAHmME9qWp56dBEgXGUPhpPJRBsS0Sq8rZkPHLAHVcLuks+aK8w@mail.gmail.com>
Subject: Re: [PATCH v2] random: reseed more often immediately after booting
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Eric,

On Sat, Mar 12, 2022 at 12:44 PM Eric Biggers <ebiggers@kernel.org> wrote:
> I don't think it's strange.  Maybe it seems strange because of how you wrote it
> ('interval = (5U << fls(uptime / 5)) * HZ'), where the reseed interval suddenly
> jumps from X to 2*X seconds.  The version I suggested is 'interval = max(5,
> uptime / 2) * HZ', which is smoother.  It's simply saying that the reseed
> interval increases as the uptime increases, which seems to be what we want.
> (Bounded by [5*HZ, CRNG_RESEED_INTERVAL], of course.)
> What you have now is still better than the status quo, but I'm not sure it's the
> best way.

To be clear, I'm not opposed to your suggestion. I just don't
understand it... yet. I've been playing around with this python script
to try to "see" what it's doing:

```
#!/usr/bin/env python3
import sys

stride = int(sys.argv[1])

lastyes = 0

def e(x):
    return max(5, x / 2)

def f(x):
    global lastyes
    if lastyes + e(x) - x < 0:
        lastyes = x
        return True
    return False

li = 0
for i in range(0, 300, stride):
    if f(i):
        print(i, i - li)
        li = i
```

And I can sort of see that for constant calls, it doubles the
frequency as you'd expect. But I still don't see how this is related
to system uptime in some definite way. The reason for having a
heuristic like this in the first place is that we are assuming that
there's some (inverse) correlation between the need for entropy and
the system boot time, and another correlation between the availability
of entropy and the system boot time. I'm just not "getting" how your
formula correlates to that. I'm not saying it's wrong, but just that I
might be a bit slow in grasping the relation. Can you give some more
details on what's happening? I'll continue to stare at it and poke
around with my python script of course, but if you could help that'd
be appreciated.

Alternatively, I had mentioned and then dismissed the timer approach
earlier, but actually maybe that'd be not as bad as I originally
thought? Just having a timer run at 5,10,20,40,80,160 or something
like that? Do you share my original allergy to that idea, or might
that actually be an okay way forward?

Jason
