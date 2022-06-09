Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A7E545471
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245353AbiFISv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345528AbiFISvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:51:52 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD512C2794
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 11:51:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n10so49267194ejk.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 11:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OA225JVCydt2ZrDiYNVLzEh8X39ntnv0/k7cvIBZg+8=;
        b=PFJuXK8jPvFzm5TAoqZf60kcVI64fTn9UDyRMlKCS8pPHUGyiyaAMwGdl4r393SBzg
         vepF6GRLqCJL9gQpjvnKxUH3uJhe+mPF7dDAKwsrtZcYRxcSfF4//I1E3TveVol7a7G+
         COs+qKfwhyFLcsgaQR/NaAMgapzX+cdUxVcM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OA225JVCydt2ZrDiYNVLzEh8X39ntnv0/k7cvIBZg+8=;
        b=K9RViEJ1h/OADvdL2YXbdEaQfrbhMsbEqEstUeIjrx/OgRJ/VZdxzrUcRzyNJkjjgw
         I4zN6Uszj/wL6+ntCW6SaqdsHOw19BjeQ/08ZNvMWMBZzpMqjJnyNbIlMVJZIib5rHhD
         LtnWRpMufMFjSFyooZ75eL1LkY/UNadKmpcLi6QdLXZ8gibTpJJzy4ARCHfNnqlGssIR
         iGGKTdG0oD7H6akqH4nCMXzT3pEmz7QBRcDuFJN69Mki1nDGe14IE1LqvXt2G7mElwUA
         yGNWsmFc2GR5xJdsLdPyUko4wRydrnjkTauq+1NE+Nlz0Mms1Y3S2RItvOu3rMtkuZH+
         du0g==
X-Gm-Message-State: AOAM532rg9Vv+xhCu+o19lTfKpqU5nrfgjHZk1N5N2uxtTpB/tHZaM7e
        UvhIICFcEVPHJh2NtrgK/GYtafzSnwh5qx19
X-Google-Smtp-Source: ABdhPJz69i7ecPjTmYmqv8HoWBdKQQhVibzCYIO9NbgIte8Ptag0ek5jAUP/b+qCHC03qfF7FOuL7g==
X-Received: by 2002:a17:907:761c:b0:6d6:e553:7bd1 with SMTP id jx28-20020a170907761c00b006d6e5537bd1mr36713068ejc.5.1654800707745;
        Thu, 09 Jun 2022 11:51:47 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id w20-20020a170906d21400b006fe8bf56f53sm11054657ejz.43.2022.06.09.11.51.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 11:51:47 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id j5-20020a05600c1c0500b0039c5dbbfa48so32518wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 11:51:46 -0700 (PDT)
X-Received: by 2002:a05:600c:42c6:b0:39c:4bfd:a4a9 with SMTP id
 j6-20020a05600c42c600b0039c4bfda4a9mr4798635wme.8.1654800706005; Thu, 09 Jun
 2022 11:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220422134308.1613610-1-svens@linux.ibm.com> <202204221052.85D0C427@keescook>
 <CAHk-=wjahn2fZtMxmc4D9UOUGWVws1wZ=X46jrTV=_tEpzXeoA@mail.gmail.com>
 <202206081404.F98F5FC53E@keescook> <CAHk-=wiFn-_OaWKY=nXt3YSiy=obrNoQW_u7zKO7qoArez=GUw@mail.gmail.com>
 <YqIJ1iimwIlFDa4n@dev-arch.thelio-3990X>
In-Reply-To: <YqIJ1iimwIlFDa4n@dev-arch.thelio-3990X>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Jun 2022 11:51:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7boyAACq+KN1_kd009W83FTJpXQrCRifTs_Zr=xTg+Q@mail.gmail.com>
Message-ID: <CAHk-=wj7boyAACq+KN1_kd009W83FTJpXQrCRifTs_Zr=xTg+Q@mail.gmail.com>
Subject: Re: [PATCH] s390: disable -Warray-bounds
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
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

On Thu, Jun 9, 2022 at 7:55 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> I think this should be $(CONFIG_CC_NO_ARRAY_BOUNDS)?

Thanks, fixed.

Anyway, in order to deal with the (few - the rc2 week does tend to be
small) pull requests I have pending, I have basically worked around
all the new warnings I see.

Some of the workarounds are the proper fixes, but mostly it's a pretty
harsh "just shut that warning up". That includes for things that have
proper fixes pending (ie the netfs issue), where I just did a pretty
ugly but very localized

  #pragma GCC diagnostic ignored "-Wattribute-warning"

in the affected files.

End result: I have a clean 'allmodconfig' build again, and hopefully
most of these workarounds can either be tightened up or removed
entirely at some point.

It's this in my tree now:

    507160f46c55 ("netfs: gcc-12: temporarily disable
'-Wattribute-warning' for now")
    f0be87c42cbd ("gcc-12: disable '-Warray-bounds' universally for now")
    842c3b3ddc5f ("mellanox: mlx5: avoid uninitialized variable
warning with gcc-12")
    49beadbd47c2 ("gcc-12: disable '-Wdangling-pointer' warning for now")
    7aefd8b53815 ("drm: imx: fix compiler warning with gcc-12")
    6bfb56e93bce ("cert host tools: Stop complaining about deprecated
OpenSSL functions")

in case people care.

                      Linus
