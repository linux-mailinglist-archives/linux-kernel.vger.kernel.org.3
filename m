Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6026546B7F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 19:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350135AbiFJRJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 13:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350051AbiFJRJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 13:09:25 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F1E50B22
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:09:23 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id fu3so53163082ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7NGj/fRsB8QNhSe369jbVTtv9ZIQI4UquOcWKaIS3lw=;
        b=EDxuEBSySIkS0wX9UtgEWpdaZ5Rkk+ceY4FD2zvv24FQoI0QnCjliwtHZ5rtDY13Wa
         /Eo1coASUZ3gqT6dIuUaR+vjQAIZO4ZOodC6LYg8XqX1lajtUhNUr0Kaj+XbuAK8CkNb
         z33Wa9Cj1RwJWTC+jSvNwO5raxNOUS/Gu5Mh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7NGj/fRsB8QNhSe369jbVTtv9ZIQI4UquOcWKaIS3lw=;
        b=ymtveMjGdoXh8wo0fYYDy7IgiRGQ/49LE2ZUo7/xZZjWBEJlG1jcAJ0k8wFg33jajY
         bT5q4cUGpkFpoS4uqhOEg5hmPLuc8suzPR91w7icbWR+IH/d4l1OfWWdUC9L9L0fLbDx
         YxdNqzGUv04/klFdMJYKXrdMeoUxxW+qwz03NgcG5LjQecOJx/5yx1g4zXEvKTe4Co2z
         6CuswmPLUdJwOCRKeLiUT0lVGHNUlJeUJFni80JoLLg09/RcrCdsd5VTK9GEeRWrutoo
         jvJJDdoAGrarC4W+VwIz+k5O4SH3V+uxFOBaTRmimVI/P2i+sdvfNU7Ba4bMCG5g8XFw
         EfIg==
X-Gm-Message-State: AOAM532PuUAl9Ptite3pvhXUAywrU4Y4IwJEcF4VG2X6dBnG6tf8olhM
        +IxGgYv7hSZ6i52gI6bpcjxZ3ZFyq8Og5GClz0o=
X-Google-Smtp-Source: ABdhPJyCzccyHBa22pxqWaEIqNwMB2jlRtEfglgNBld0mb/Nc/+PSXENLoSCU3g+7osou96Nan45Zg==
X-Received: by 2002:a17:906:f996:b0:711:d208:bfb2 with SMTP id li22-20020a170906f99600b00711d208bfb2mr23148551ejb.163.1654880961932;
        Fri, 10 Jun 2022 10:09:21 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id m26-20020a50ef1a000000b0042bae6fbee2sm16545005eds.74.2022.06.10.10.09.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 10:09:21 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id m39-20020a05600c3b2700b0039c511ebbacso1440434wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:09:21 -0700 (PDT)
X-Received: by 2002:a05:600c:4ec9:b0:39c:69c7:715d with SMTP id
 g9-20020a05600c4ec900b0039c69c7715dmr738538wmq.154.1654880961101; Fri, 10 Jun
 2022 10:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220610053544.417023-1-kuba@kernel.org>
In-Reply-To: <20220610053544.417023-1-kuba@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Jun 2022 10:09:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whAx7AgD59HyZuaLor1afAk=kYCQiG4gacMR8-_GmmBLQ@mail.gmail.com>
Message-ID: <CAHk-=whAx7AgD59HyZuaLor1afAk=kYCQiG4gacMR8-_GmmBLQ@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for 5.19-rc2 (follow up)
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Jun 9, 2022 at 10:35 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Quick follow up PR, I managed to catch your tree at a point where AFS
> did not build on GCC < 12. Before I tried building it on an older distro
> I already pushed a few things. I figured cleanest if I just send a quick
> follow up and forward again. Please LMK if I should have just merged
> your tree in.

This looks fine to me, and I think preferred over backmerges.

Thanks,

                Linus
