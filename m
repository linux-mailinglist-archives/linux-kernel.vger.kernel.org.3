Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9975926DE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 00:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiHNWsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 18:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiHNWsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 18:48:04 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A83B120B4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 15:48:03 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kb8so10899692ejc.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 15:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=I7PRMXdgMGKWzb1ApTcF0EzOQI/ZmdBK6FD13T4zlKw=;
        b=FAlT5IPj6nwZsO73VeoUL869lJZM1AoVzWSRmsam9w7KLpbgzdrQZRIDD9MYhz4XJE
         wjcdfb6rGXzHQNypzVVeWqZkFZB1EJyn4fdNZ+steFjtG3Mg6h/0oMn1Ox5PAn8CEDuE
         E9UIQ7KcYjY8u0WlqJa1F4EovMUaN+VdQKX9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=I7PRMXdgMGKWzb1ApTcF0EzOQI/ZmdBK6FD13T4zlKw=;
        b=qBeSnQiOk3y6tLaNJlSmVsJN///T1z0hRnzwHoxZ2wu6cdCM8BiCteqE0S21JNT0Ab
         X9tKSxXabHjpSS9i5bPb1OHybZxRkksV56bu5OwBR6M5NB4Vr4MP5uXqoguNj7qo4VTm
         g3bwlt0s039dT7s8dd/VB3EEyRFUCNv92c3sH4b7PljhdYrIH0mQMWjbz9mFmbEnJqZm
         R8QfooGogNjz/I16gYHAuYk/fcj5qHbRPHmpVpVeXxUCz456QITxtVggmzK+M5NP2HKt
         dmW/N+URL8VRfV26Qyv398s7lbFg0/XzD9lV0Fm75ktyX2c0ic2iOQN7hDhmtnLKTq4z
         cAvg==
X-Gm-Message-State: ACgBeo14aq/IfU8/A9rLCtiSaa/adWh9o3XsMvUoij7HgBL8zsyoWXv1
        INe0lEwaoQuFAOZ/dDxdATnLoKkgox81yLVV
X-Google-Smtp-Source: AA6agR58eYEpBEZO8zTaXYw14t6ZaC1drYGTNygW5ZeSzdP2MeD3tLkRObAW7IUzqtLuY04Xit2bpA==
X-Received: by 2002:a17:906:8474:b0:730:7f7f:e49 with SMTP id hx20-20020a170906847400b007307f7f0e49mr8566764ejc.164.1660517281523;
        Sun, 14 Aug 2022 15:48:01 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id r9-20020a17090609c900b00731803d4d04sm3418429eje.82.2022.08.14.15.48.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Aug 2022 15:48:00 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id s23so3148438wmj.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 15:48:00 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed0:b0:3a3:3ef3:c8d1 with SMTP id
 g16-20020a05600c4ed000b003a33ef3c8d1mr14698313wmq.154.1660517280316; Sun, 14
 Aug 2022 15:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220814212610.GA3690074@roeck-us.net> <CAHk-=wgf2EfLHui6A5NbWoaVBB2f8t-XBUiOMkyjN2NU41t6eA@mail.gmail.com>
 <20220814223743.26ebsbnrvrjien4f@awork3.anarazel.de>
In-Reply-To: <20220814223743.26ebsbnrvrjien4f@awork3.anarazel.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Aug 2022 15:47:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi6raoJE-1cyRU0YxJ+9ReO1eXmOAq0FwKAyZS7nhvk9w@mail.gmail.com>
Message-ID: <CAHk-=wi6raoJE-1cyRU0YxJ+9ReO1eXmOAq0FwKAyZS7nhvk9w@mail.gmail.com>
Subject: Re: upstream kernel crashes
To:     Andres Freund <andres@anarazel.de>, Jens Axboe <axboe@kernel.dk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
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

On Sun, Aug 14, 2022 at 3:37 PM Andres Freund <andres@anarazel.de> wrote:
>
> That range had different symptoms, I think (networking not working, but not
> oopsing). I hit similar issues when tried to reproduce the issue
> interactively, to produce more details, and unwisely did git pull instead of
> checking out the precise revision, ending up with aea23e7c464b. That's when
> symptoms look similar to the above.  So it'd be 69dac8e431af..aea23e7c464b
> that I'd be more suspicious off in the context of this thread.

Ok.

> Which would make me look at the following first:
> e140f731f980 Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> abe7a481aac9 Merge tag 'block-6.0-2022-08-12' of git://git.kernel.dk/linux-block
> 1da8cf961bb1 Merge tag 'io_uring-6.0-2022-08-13' of git://git.kernel.dk/linux-block

All right, that maks sense.The reported oopses seem to be about block
requests. Some of them were scsi in particular.

Let's bring in Jens and the SCSI people. Maybe that host reference
counting? There's quite a lot of "move freeing around" in that late
scsi pull, even if it was touted as "mostly small bug fixes and
trivial updates".

Here's the two threads:

  https://lore.kernel.org/all/20220814212610.GA3690074@roeck-us.net/
  https://lore.kernel.org/all/20220814043906.xkmhmnp23bqjzz4s@awork3.anarazel.de/

but I guess I'll do an -rc1 regardless of this, because I need to
close the merge window.

                    Linus
