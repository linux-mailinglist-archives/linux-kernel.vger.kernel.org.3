Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3309536919
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 01:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiE0XFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 19:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiE0XFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 19:05:00 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6311312E33F
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 16:04:58 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v15so4636102edl.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 16:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6BGoFFgW/Mo0Xp2ZeLbW4T3GKY+VDGTAwfQ7W1wk09o=;
        b=M1D1Ve7N12RMFQKKTXgwWaa5btEqkDX8TyQBKk1K0II7CkANOnLW1EP4aKbEIGi4sh
         WwVXtLLKsqhEKaUNouMKfO1QpWYqIxXEWh9U/Dm4Zj/0lsXbf6hCi19sld0JuIE3f3WS
         QTj+V3awjOgu4xhQTxweoGzYrNbyWekMAmzIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6BGoFFgW/Mo0Xp2ZeLbW4T3GKY+VDGTAwfQ7W1wk09o=;
        b=wqI0uZIYs0Jve7HEjE+5Dp+sF2BLpZY503dMjpgfJaGTh/mTPc6MYXuxcmhw6Ja3qp
         YwJjKwyy9UtuL7QzQ9wsSWgZDWhLzPzirTuw6cMyOvnZSd27v1DzmsWz4BvAHQzLjSD5
         uKC8vAS1ohz0rOIEJJufsRGGsYIcpk4yBDDSOkUBO+rXPh68pTGVJNIgPdCDu0sByvGL
         Hn6QkE4ndixnRemqAo3TuYDJoJBKH7qbw6pRKKwvclP6AUTf1xabpDhQl5Q9OYMT8iG8
         G4kvX8AD/zIQjAuZGj69WyemLQ2I6sSKdlN3RzPxeQxdGdCdSY68lx2OzxDDNvdsMEzI
         aAWw==
X-Gm-Message-State: AOAM5320RKCM/Ac2jo9cOUVq8hyMnULwO9WVdjMHIYIBC+on0dyqn17P
        2nbgca1uyJxUDOXAnAVMrdq1oAoHGQD8665d
X-Google-Smtp-Source: ABdhPJznQb9mW8lh0X0k4Oa+fUA5c0qauc1wsIyLA75QsjFzlvp9cYJrs64eRXjdCNxqP74gSlUbWw==
X-Received: by 2002:a05:6402:270a:b0:42b:3721:4e76 with SMTP id y10-20020a056402270a00b0042b37214e76mr37665296edd.51.1653692696696;
        Fri, 27 May 2022 16:04:56 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id mu31-20020a1709068a9f00b006feb875503fsm1855001ejc.78.2022.05.27.16.04.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 16:04:56 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id e2so7675469wrc.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 16:04:56 -0700 (PDT)
X-Received: by 2002:a05:6000:16c4:b0:20f:cd5d:4797 with SMTP id
 h4-20020a05600016c400b0020fcd5d4797mr25777297wrf.193.1653692695718; Fri, 27
 May 2022 16:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <4dc223ba-b0d1-e183-1d83-a03a03c1df97@oracle.com>
In-Reply-To: <4dc223ba-b0d1-e183-1d83-a03a03c1df97@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 May 2022 16:04:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=whL6vtgSgFqu3t29DsfU84M7RaZHC9aJz5WN6bNOY563w@mail.gmail.com>
Message-ID: <CAHk-=whL6vtgSgFqu3t29DsfU84M7RaZHC9aJz5WN6bNOY563w@mail.gmail.com>
Subject: Re: [GIT PULL] jfs updates for v5.19
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, May 27, 2022 at 8:10 AM Dave Kleikamp <dave.kleikamp@oracle.com> wrote:
>
> JFS: One bug fix and some code cleanup

Oh, ok...

>   10 files changed, 3 insertions(+), 1652 deletions(-)

.. whee.

Usually when people say "some cleanup" they are talking about fixing
some nasty code patterns, not removing 1600 lines of 20-year old dead
code.

Thanks,

              Linus
