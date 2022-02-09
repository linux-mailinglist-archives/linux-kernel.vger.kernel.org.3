Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F7E4AF018
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiBILtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiBILtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:49:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075ADE02F561;
        Wed,  9 Feb 2022 02:40:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B92E3B81FFC;
        Wed,  9 Feb 2022 10:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CE2C340E7;
        Wed,  9 Feb 2022 10:40:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TqiZKN/E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644403224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zh5HpvjKWOfnveAnt+GML5+YDo8XUouZTQHIes+rbNs=;
        b=TqiZKN/EQoQ7X90ygxp2u7YhkBGRfTTJER1FxG8wEnjP1Du853iJEIQ2sBfuxiW21eNhzD
        9nG/wj6QbQHQ5IKbtXlRB9jYWibjFOu0al2lggrVDQ/2fwvFSlEPVA1ZQLIjSuOwE7oGsh
        eRMn5WXnE3kOuanMQ5h7lTtgUD2TdB4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0aab5556 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 9 Feb 2022 10:40:24 +0000 (UTC)
Received: by mail-yb1-f169.google.com with SMTP id m6so4543942ybc.9;
        Wed, 09 Feb 2022 02:40:23 -0800 (PST)
X-Gm-Message-State: AOAM5308qwPVKp7oR9blfDanbJ448xzQWxAj/frowEAD3uxBB3RVPBQu
        h0++nSu7TUJGe1qUi8WwfPpEu5OEDU6PDsWMmek=
X-Google-Smtp-Source: ABdhPJzGiryrzES33UPJu6XIQhFG6lg5JyIl+5a1pqI90VUc7HNl3tTdbtmDEiR+5ntmatn5L2oGOoZw90B1NDpWoRQ=
X-Received: by 2002:a25:ba49:: with SMTP id z9mr1432385ybj.32.1644403222965;
 Wed, 09 Feb 2022 02:40:22 -0800 (PST)
MIME-Version: 1.0
References: <20220209011919.493762-1-Jason@zx2c4.com> <20220209011919.493762-6-Jason@zx2c4.com>
 <YgN7OKSJRNZNxuGm@owl.dominikbrodowski.net>
In-Reply-To: <YgN7OKSJRNZNxuGm@owl.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 9 Feb 2022 11:40:12 +0100
X-Gmail-Original-Message-ID: <CAHmME9oZ2xLT-vX=7H0U8uBO4Z=pcMcu-CY-B=TpTdGWHp0pJA@mail.gmail.com>
Message-ID: <CAHmME9oZ2xLT-vX=7H0U8uBO4Z=pcMcu-CY-B=TpTdGWHp0pJA@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] random: do not xor RDRAND when writing into /dev/random
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Biggers <ebiggers@google.com>
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

On Wed, Feb 9, 2022 at 9:31 AM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> Looks good generally, just one unrelated change slipped in:
>
> >               bytes = min(count, sizeof(buf));
> > -             if (copy_from_user(&buf, p, bytes))
> > +             if (copy_from_user(buf, p, bytes))
> >                       return -EFAULT;

I'll often fix up very minor adjacent code style things. In this case,
`buf` is an array, so the code is equivalent, but I prefer the latter,
which is mostly what's used throughout the driver.

Jason
