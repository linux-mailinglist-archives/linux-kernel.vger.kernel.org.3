Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA1C4D6895
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 19:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344292AbiCKSmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 13:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236217AbiCKSmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 13:42:32 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDAAE2350
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:41:28 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id z26so13194727lji.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=grwJQHpTejzQ9PPbrhyRjQ3f2c8M8MaXreOB3JRCzH4=;
        b=XHp3iURq9OeJVvf+OfCRzT7E/cMt2KAuZNAwrYLyP/pzLenBGQ8uLEBnp3WmTUS8nh
         xRLufqDVNmGWux/1S1hgA4vH49obaGQ9jwyXIaQ1y0Zy8eIP792BUl2Cewf+liru22iE
         i3hJ3p85HmBfcmjySUXC47mkMZJ5BchuXf6Xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=grwJQHpTejzQ9PPbrhyRjQ3f2c8M8MaXreOB3JRCzH4=;
        b=tdVebKnAo3eyBxoared6Us/czQHwI+fvt7NxCaFyiadO0/c/MwzcUSRa+fHiViq5RF
         hXjMPrZ7C725XxD3TC4HL1CACCMwjrWuuwTYNZdpvdLoQlrAPNQSu++RR4+ZkDChdDv8
         Z6GjJQgg9rdQM7zDdpD4KfY9VdBRuPo9vFXPUZD+vyn9hfD/GiB/bWtuBhBy28EbxtEW
         iL3NfrAH7wXkGJYfZHAjzHopDPTcllz5VV9F//O1pb6cEV50mDNZJUBJxoDIyzhIYsi8
         9btjP3gTuraJ8f8MYHXK4EpuibMg9aH65bbSAY4hFv9X/SQpHBgKgLibqBxLrZqHzcuw
         nxvQ==
X-Gm-Message-State: AOAM530tCDjnCfI63+a5aqKUqxOKxCA1bNKs3uJphsNS0O8Rs81MGHeQ
        DW6pOQKCCQ+BvD7je7DXwH44ldyG8I4blkGaZM0=
X-Google-Smtp-Source: ABdhPJzN3G0ZmTn3eXpTlv7ZGpNhmCtzCqWUzvOST9YAAw7Z5hKCTqtU17B889lCpxk3E3BYgvM8nQ==
X-Received: by 2002:a05:651c:11ca:b0:247:f32e:10ba with SMTP id z10-20020a05651c11ca00b00247f32e10bamr6937694ljo.208.1647024086467;
        Fri, 11 Mar 2022 10:41:26 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id h6-20020ac25d66000000b0044315401373sm1746550lft.29.2022.03.11.10.41.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 10:41:23 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id bu29so16655343lfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:41:23 -0800 (PST)
X-Received: by 2002:a05:6512:3a83:b0:447:da72:43f1 with SMTP id
 q3-20020a0565123a8300b00447da7243f1mr6931391lfu.542.1647024082921; Fri, 11
 Mar 2022 10:41:22 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=whJX52b1jNsmzXeVr6Z898R=9rBcSYx2oLt69XKDbqhOg@mail.gmail.com>
 <20220304025109.15501-1-xiam0nd.tong@gmail.com> <CAHk-=wjesxw9U6JvTw34FREFAsayEE196Fi=VHtJXL8_9wgi=A@mail.gmail.com>
 <CAHk-=wiacQM76xec=Hr7cLchVZ8Mo9VDHmXRJzJ_EX4sOsApEA@mail.gmail.com> <20220311142754.a3jnnjqxpok75qgp@maple.lan>
In-Reply-To: <20220311142754.a3jnnjqxpok75qgp@maple.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Mar 2022 10:41:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi58pvQhMX2sRt7nKqwHAFAmn27MrJg3XbeJgio6ONgdA@mail.gmail.com>
Message-ID: <CAHk-=wi58pvQhMX2sRt7nKqwHAFAmn27MrJg3XbeJgio6ONgdA@mail.gmail.com>
Subject: Re: [PATCH 2/6] list: add new MACROs to make iterator invisiable
 outside the loop
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Xiaomeng Tong <xiam0nd.tong@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 6:27 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> It is possible simply to use spelling to help uncover errors in
> list_traverse()?

I'd love to, and thought that would be a lovely idea, but in another
thread ("") Barnab=C3=A1s P=C5=91cze pointed out that we actually have a fa=
ir
number of cases where the list member entries are embedded in internal
structures and have a '.' in them:

  https://lore.kernel.org/all/wKlkWvCGvBrBjshT6gHT23JY9kWImhFPmTKfZWtN5Bkv_=
OtIFHTy7thr5SAEL6sYDthMDth-rvFETX-gCZPPCb9t2bO1zilj0Q-OTTSbe00=3D@protonmai=
l.com/

which means that you can't actually append the target_member name
except in the simplest cases, because it wouldn't result in one single
identifier.

Otherwise it would be a lovely idea.

> For architectures without HAVE_LD_DEAD_CODE_DATA_ELIMINATION then the
> "obvious" extension of list_traversal_head() ends up occupying bss
> space. Even replacing the pointer with a zero length array is still
> provoking gcc-11 (arm64) to allocate a byte from bss (often with a lot
> of padding added).

I think compilers give objects at least one byte of space, so that two
different objects get different addresses, and don't compare equal.

That said, I'm not seeing your issue. list_traversal_head() is a
union, and always has that 'struct list_head' in it, and that's the
biggest part of the union.

IOW, the other parts are (a) never used for anything but their type
and (b) will not take up any new space that isn't already used by the
list_head itself.

                  Linus
