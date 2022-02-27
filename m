Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A414C5FEA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 00:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiB0X2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 18:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiB0X2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 18:28:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618F8638C;
        Sun, 27 Feb 2022 15:27:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F39C4611CF;
        Sun, 27 Feb 2022 23:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0601C340E9;
        Sun, 27 Feb 2022 23:27:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="goL89XZS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646004441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cPJiLooKbNUohnU6yXN63L1h4yYqJ923mGb0t2sRAmM=;
        b=goL89XZSsZPfaum9fcpaXArg1yGEVHqkD3gJbN6h+aFDXgFSk3FtmNY1XHGFlU+zie+ebw
        fT4UAbs+ItDDw0QJuyMeed/Dghxx9UVojWm5f0rRImhNElq0sVfCIbyDdQBVbN+4oUuSwm
        /NzJUKJdUYotOeOWxmz+2GkyXgatyeI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 011a27c7 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 27 Feb 2022 23:27:21 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id j12so17085495ybh.8;
        Sun, 27 Feb 2022 15:27:21 -0800 (PST)
X-Gm-Message-State: AOAM530u4qG1qaPgTNsEI8zmuELPSv8QaLeYFk3RqBgIWDTztXJuXTg7
        eoLNjFbuBcp3KqBgpVWc01lH4257yLyiL3NoqvA=
X-Google-Smtp-Source: ABdhPJzTL5Q+trTKPAkI1w13K2/b9LgEC7uevfTmCAsJfxl8vfz0K4RBpfa5PKF+e8kAToiRjhCjUiBMURVep4tNPNM=
X-Received: by 2002:a25:238d:0:b0:619:3e19:b06b with SMTP id
 j135-20020a25238d000000b006193e19b06bmr16106668ybj.382.1646004440064; Sun, 27
 Feb 2022 15:27:20 -0800 (PST)
MIME-Version: 1.0
References: <20220226220639.1173594-1-Jason@zx2c4.com> <20220226220639.1173594-3-Jason@zx2c4.com>
 <0c73d29e-e558-efb9-d0d7-c612b2bb7e90@amazon.com> <YhtyBHUyFysmZ9bC@zx2c4.com>
In-Reply-To: <YhtyBHUyFysmZ9bC@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 28 Feb 2022 00:27:09 +0100
X-Gmail-Original-Message-ID: <CAHmME9pocD1CoZbnF7p4k0ws7-R0Vc9H4i5TRJ_MCX-d3AZhFw@mail.gmail.com>
Message-ID: <CAHmME9pocD1CoZbnF7p4k0ws7-R0Vc9H4i5TRJ_MCX-d3AZhFw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] ACPI: allow longer device IDs
To:     Alexander Graf <graf@amazon.com>
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

Hey again,

On Sun, Feb 27, 2022 at 1:43 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Alex,
>
> On Sun, Feb 27, 2022 at 12:42:03PM +0100, Alexander Graf wrote:
> > > To allow device drivers to match identifiers that exceed the 9 byte
> > > limit, this simply ups the length to 16, just like it was before the
> > > aforementioned commit. Empirical testing indicates that this
> >
> >
> > This is only true for 64bit systems where padding automatically bloated
> > to 9 byte array to 16. I still believe the patch is fine as it is, but
> > there will be minor .rodata overhead on 32bit targets which you may want
> > to quantify in the patch description.
>
> Good point. So I just tried this out with a 32-bit i686 kernel and the
> results are the same again for the size of vmlinux. I then ran `objdump
> --headers` and looked at the size of the .rodata section, where it's
> also the same. I'm not quite sure what to make of this, as it's not what
> I was expecting, but I think I tested it right. So maybe we're lucky
> here?

I tried a little harder to get _some_ difference on 32-bit, and
managed to get one by doing i386_defconfig and then switching off
modules to make all M into Y, and then compared sizes:

vmlinux: 25590780 -> 25598972, so a 0.032% increase.
bzImage: 8698944 -> 8699424, so a 0.0055% increase.

So it does increase, ever so slightly, but a) on 32-bit, and b) a
super, super tiny amount.

In other words, I still think this patch is very much a-okay. But very
eager to hear from Rafael on the approach.

Jason
