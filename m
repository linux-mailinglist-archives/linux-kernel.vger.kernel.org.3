Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2E45223FD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 20:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348866AbiEJS17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 14:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbiEJS1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 14:27:34 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC7318FF29
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:23:34 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id z2so33052658ejj.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6+6daxf9DBR/wq5NboOShmKyA8J0iaTzHPVTMkgH10=;
        b=QHCsBsCmgpbSZbkfqS1Oo1MUQeuhlP1ZsLgzzMnXdAdig3V1zAvrj5IKC7nbum8dEY
         peXnK6zU/RodBxXQ4H3AQrDQdldz0aOJKB0erOEm9K95Tw69V2izzp5jd0jPewdxCHR+
         ZzsEDjnTue1e20m7A4AngmpfO54XUJd2CWRSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6+6daxf9DBR/wq5NboOShmKyA8J0iaTzHPVTMkgH10=;
        b=OuZRmwSp6F7OkozR+N0cwpYIQq8ZgwkcelFciMhs+kL6glMZHiHIbJF/FoZJ9NwASn
         NbCLJ4WRi4xTmnogALxgBcmidQTpg9nncJ2RjBoiJ1H4d3+zWjw8dTi2rMZdqlDTCeTv
         ErGSJRn7SekYP4o5k8VX8ZlPf3vAYxJGeh+X2m3osbXDJpDwQAdMXl6toGDtZXPn2eLg
         kJQknHJYzsephcoPumhl0mmokVrYeWXdvjrf1ttFhLdym3CePQ8W5kmx1ZXWokt2RvrP
         P8OWUqvhBSAkPZlgYcUmBAInUCxs2ICElKpi1fSd0CMJ9H5JtXWlCBJaKTKkT4MnxOWp
         Iy3g==
X-Gm-Message-State: AOAM532FTDfof2DuITXO6Feq+Ite+OHDjt2oFDS5vAhpIRdjDF5m1KPW
        nA15Ud+h5ys8AMWy1haY8e6uuTvRPNPfRlnIo28=
X-Google-Smtp-Source: ABdhPJyWM0z/rEYSjXOkTlsVLQN1kW8TrEYKpkeye7NuC6g96CCsiwZ1vIrZhttcyERMjA5KNJG3aQ==
X-Received: by 2002:a17:907:2da9:b0:6f8:6104:659 with SMTP id gt41-20020a1709072da900b006f861040659mr15399478ejc.556.1652207008570;
        Tue, 10 May 2022 11:23:28 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id p16-20020a170906615000b006f3ef214e5fsm7959ejl.197.2022.05.10.11.23.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 11:23:27 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id v12so24921280wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:23:27 -0700 (PDT)
X-Received: by 2002:adf:dfc8:0:b0:20a:d256:5b5c with SMTP id
 q8-20020adfdfc8000000b0020ad2565b5cmr19494972wrn.97.1652207007228; Tue, 10
 May 2022 11:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220510082351-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220510082351-mutt-send-email-mst@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 May 2022 11:23:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjPR+bj7P1O=MAQWXp0Mx2hHuNQ1acn6gS+mRo_kbo5Lg@mail.gmail.com>
Message-ID: <CAHk-=wjPR+bj7P1O=MAQWXp0Mx2hHuNQ1acn6gS+mRo_kbo5Lg@mail.gmail.com>
Subject: Re: [GIT PULL] virtio: last minute fixup
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mie@igel.co.jp
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 5:24 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> A last minute fixup of the transitional ID numbers.
> Important to get these right - if users start to depend on the
> wrong ones they are very hard to fix.

Hmm. I've pulled this, but those numbers aren't exactly "new".

They've been that way since 5.14, so what makes you think people
haven't already started depending on them?

And - once again - I want to complain about the "Link:" in that commit.

It points to a completely useless patch submission. It doesn't point
to anything useful at all.

I think it's a disease that likely comes from "b4", and people decided
that "hey, I can use the -l parameter to add that Link: field", and it
looks better that way.

And then they add it all the time, whether it makes any sense or not.

I've mainly noticed it with the -tip tree, but maybe that's just
because I've happened to look at it.

I really hate those worthless links that basically add zero actual
information to the commit.

The "Link" field is for _useful_ links. Not "let's add a link just
because we can".

                           Linus
