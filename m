Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749E7470CFF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 23:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344681AbhLJWWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 17:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbhLJWWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:22:08 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891EFC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 14:18:32 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id v1so34605843edx.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 14:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cg9eQLIFJh+c6PyNxKtwuoKrLTzGB9EH7kdUWu2F1Zk=;
        b=fjIKNDYtImPkvWhc4Gzi5Y6kMJ6cnfwQ/RiqfRI3cJHc25v1vy7IG2bDsPj2nuZIGT
         51kR6CzBU9d3pc//4CNDX/22b5STyxSY/wCTyZFr3DIT4TWnZdcmUvdF0IU0AIQesRdy
         hdx1nxWmkamQyMD1PEbF6tpMVytL5ULQW17oA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cg9eQLIFJh+c6PyNxKtwuoKrLTzGB9EH7kdUWu2F1Zk=;
        b=2i0Z5vd2e+ttOn+UkaGPcSrIhaulRqr5uD/qpg+DrFaNyjhn4jW+I90Cf80WAWKzpp
         TDnNSFwOGz+m0FxWNOhbwuYDvf6CzcnXxXuOvrJBVa8bo8Zt46+kXKsWy6+RxDn2mu3V
         +hotC3l7lCoYOvm03X4H5rWE0F3c1E86l6Ifl9Q27y3p4jaIRe92jICGSA2umWFZBKi1
         74hdIy+bHDgS/KSs7/mqnMYZSacGV2+57Tw9kjbYmgEKE4mdkzYLUUvYA33f5yDqhn3A
         t1dSLdpwJNnpmIbVg02m0H32ZMZxWkhFz2E1aaoqm2ASgKeB/uV3PCRc+CWN3H+UqPBg
         6/oA==
X-Gm-Message-State: AOAM531H30gXu6DYMpUBsblfTyWDD830gPoqrDtlCEL9nBQVDkiwS13V
        ksK8cBKPPsYkG8s72GRlSnIPdRGk5SoOffW62bM=
X-Google-Smtp-Source: ABdhPJxeLeUD8sIuIbfIFA/5sNT9kdBBbZCApCdDmgRPoEd/98ma4wfSye69pd/NHktdw2KmMuxA/A==
X-Received: by 2002:a17:906:349a:: with SMTP id g26mr26471348ejb.395.1639174710985;
        Fri, 10 Dec 2021 14:18:30 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id w18sm2047642edx.55.2021.12.10.14.18.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 14:18:29 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id a18so17281091wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 14:18:29 -0800 (PST)
X-Received: by 2002:adf:8b0e:: with SMTP id n14mr15756314wra.281.1639174708611;
 Fri, 10 Dec 2021 14:18:28 -0800 (PST)
MIME-Version: 1.0
References: <YbOdV8CPbyPAF234@sol.localdomain>
In-Reply-To: <YbOdV8CPbyPAF234@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Dec 2021 14:18:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh5X0iQ7dDY1joBj0eoZ65rbMb4-v0ewirN1teY8VD=8A@mail.gmail.com>
Message-ID: <CAHk-=wh5X0iQ7dDY1joBj0eoZ65rbMb4-v0ewirN1teY8VD=8A@mail.gmail.com>
Subject: Re: [GIT PULL] aio poll fixes for 5.16-rc5
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>, linux-aio@kvack.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ramji Jiyani <ramjiyani@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 10:33 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> This has been tested with the libaio test suite, as well as with test
> programs I wrote that reproduce the first two bugs.  I am sending this
> pull request myself as no one seems to be maintaining this code.

Pulled.

The "nobody really maintains or cares about epoll/aio" makes me wonder
if we should just remove the "if EXPERT" from the config options we
have on them, and start encouraging people to perhaps not even build
that code any more?

Because I'm sure we have users of it, but maybe they are few enough
that saying "don't enable this feature unless you need it" is the
right thing to do...

               Linus
