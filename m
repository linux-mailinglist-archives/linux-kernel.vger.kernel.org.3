Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B5A5443B9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 08:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238116AbiFIGUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 02:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiFIGUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 02:20:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A39C83F322
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 23:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654755615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AN0ZlkVr8w/93yFNqc3zdP6y3DNmINtMFaz1R7IlO0k=;
        b=XeGfFagyTVn3cO2JeJ5VvKyKcBTx/ty2BkgxBolDvSgBIge9+dw2RgoY5QEGZ9bwF3IfAl
        izSvQqyIu6SdamDHEcIgnlieuL1EQSE5aIJbEDz4r7lYo0jZ2lcxHPYzp7HR0YYc12a9iR
        xUu7YxBlBnscSZAi8ajwzcbdc6GJ9Xw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-exCmiKzHM92T2U5-y667sQ-1; Thu, 09 Jun 2022 02:20:12 -0400
X-MC-Unique: exCmiKzHM92T2U5-y667sQ-1
Received: by mail-lj1-f199.google.com with SMTP id g13-20020a2eb5cd000000b00255ac505e62so1646923ljn.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 23:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AN0ZlkVr8w/93yFNqc3zdP6y3DNmINtMFaz1R7IlO0k=;
        b=HYec77aHY8/l9re4kyUZmGwCnlTYBIt9leafg55RVZHMBKZgi4WxblnRYTPA8/NI5B
         XhskyxRr+nd+tAzsF8juY7z6jHAKpwBG9sqP3s2FDWU7L1IJMt88m59GilUsi9Br8T+F
         uN6rFdJBsS1YCMA08WcXOdc63UsMqWdotMiftABqv8qkhk789/BD7kK/GmS3uB31OZDo
         6V+o3HKwWf1slV/Ba1fXQmh9OGUUVkeEaWLL3gtiAwMdDSAE0NXCi/YxFGms+be9WCjj
         skrBjP4+ma98bXLOaDBaeQu25I8WE5cOrfJQ4T3ai9MIZAHSPxY733/kyGayYP7llsvT
         SbhQ==
X-Gm-Message-State: AOAM533aS3OgooqzREUvg9r29M2neIGUt3okLU9rdQFA81QYRgiXe4kt
        39crKpIq0fCXKL8SunCtiLjw+nw/vTh/En+9uXUDqTf4pQw4E4/8NQc5buQ6NR4iWu5+O8acMvJ
        G0/Ce8F9VQKNvwi0yZ+Gvg+xNa2wMMsaJ2a6WFlQu
X-Received: by 2002:a2e:3a16:0:b0:255:7811:2827 with SMTP id h22-20020a2e3a16000000b0025578112827mr18256369lja.130.1654755610722;
        Wed, 08 Jun 2022 23:20:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNUn0nZrRyp/ZEqivxifffwo3gGP0B60+11cOEld6+oGdOVqObwOR/Fa2Srf1AagAiUWnptAwZ0F6FpVqugC4=
X-Received: by 2002:a2e:3a16:0:b0:255:7811:2827 with SMTP id
 h22-20020a2e3a16000000b0025578112827mr18256360lja.130.1654755610514; Wed, 08
 Jun 2022 23:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <YqF9VEBah+vvCtoR@mit.edu>
In-Reply-To: <YqF9VEBah+vvCtoR@mit.edu>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 9 Jun 2022 14:19:59 +0800
Message-ID: <CACGkMEtn2AKtkY_dYBiimwiKrLFHrVy16h4NR_31LzUVv66W9A@mail.gmail.com>
Subject: Re: REGRESSION 5.19-rc1: virtio: harden vring IRQ
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        horsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

On Thu, Jun 9, 2022 at 12:57 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> I can no longer boot v5.19-rc1 on a Google Compute Engine VM.  This
> bisected to commit 8b4ec69d7e09 ("virtio: harden vring IRQ").  Its
> parent commit, be83f04d2529 ("virtio: allow to unbreak virtqueue")
> does successfully boot, so it appears to be caused by commit
> 8b4ec69d7e09.
>
> I've attached the console log and the config file which I used (which
> was generated by using "kvm-xfstests install-kconfig"[1] which is
> essentially a "make olddefconfig" of [2]
>
> [1] https://github.com/tytso/xfstests-bld/blob/master/kernel-build/install-kconfig
> [2] https://github.com/tytso/xfstests-bld/blob/master/kernel-build/kernel-configs/x86_64-config-5.15
>
> Unfortunately, commit 8b4ec69d7e09 doesn't revert cleanly against
> v5.19-rc1, but I can look into figure out how to do revert it if
> necessary.
>
> Is this a known issue?

This seems to be the same issue as the syzbot report recently.

Would you please test this patch to see if it works?

https://www.spinics.net/lists/kernel/msg4389357.html

Thanks

>
> Thanks,
>
>                                                 - Ted
>

