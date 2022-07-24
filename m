Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA6657F6C1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 21:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiGXT7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 15:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiGXT7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 15:59:16 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3820CDFD9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 12:59:15 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z22so11634781edd.6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 12:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rnfLZsTFzFa0wqaySCmIaHsg/ndbi17KUWIR0LUjjyQ=;
        b=JRxmHxqa/8WyYdLNsPP/DYXO/hthdlrx/29N3AFRHH1fHMKLHHyRKqJCTersUcrlxR
         NiQDS0i29vQ9gwen5RX8XpxUpAJkbFL93fsb0NUWINl5o046HwRW5ffoYKn4/qL6mTwz
         Tdx55KkzwGPTfsDXFU6cNRJacMJUe/NQve4r4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rnfLZsTFzFa0wqaySCmIaHsg/ndbi17KUWIR0LUjjyQ=;
        b=ktJIL3vmFvDARj/vgZ2LnyMsi+OkIQAbyD0waYpCeFmyUCq+gZNJ9LLTLdSwejNTFY
         UO6kaGakWe9OIE2cNwhBi7+2B/4kbFxvQEggo7Ef2ncLtDmRiHk7iVgyWTtTeS9AtpuZ
         eq55jGANEB5Gc1Uhe6H+HJqNv3TFxcpTwOrJgUR5UePLa456l5WTAw3fZi74RGKDLCnE
         YNaNsc2b2lc1sX6xgiJonTXUwoVF22HbADqD2gnlrCfp9r7ZO5mLdnPhmjQOi27/rTAP
         by1H8aunBLRRv2ubWY1BNAVaSzKku76rtTOUfJBotuToJG9TT1zKG27KczbHv0m111f2
         tQYw==
X-Gm-Message-State: AJIora9VEi4YT2V4jLjxWD+8z5XlJc2D87jQZu/xNoiZl8HmSOYFap3e
        Fc6uj6LzQ/L5ccVzeqyiCy34aFlFSqju0P/d
X-Google-Smtp-Source: AGRyM1sdy4sMSCN5GMsA0FqQR7NCXp4RbGWChrHJuZHdGhlZgo/3dBHfX/OmRGZpT5rRQJn6EhOuDA==
X-Received: by 2002:a05:6402:331c:b0:43b:c62e:24dd with SMTP id e28-20020a056402331c00b0043bc62e24ddmr9864713eda.325.1658692753126;
        Sun, 24 Jul 2022 12:59:13 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906301100b00722e50e259asm4508458ejz.102.2022.07.24.12.59.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jul 2022 12:59:12 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id b26so13341740wrc.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 12:59:12 -0700 (PDT)
X-Received: by 2002:a05:6000:1a88:b0:21d:aa97:cb16 with SMTP id
 f8-20020a0560001a8800b0021daa97cb16mr5948645wry.97.1658692752059; Sun, 24 Jul
 2022 12:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <165869171256.283493.2326902986633030609@leemhuis.info>
In-Reply-To: <165869171256.283493.2326902986633030609@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Jul 2022 12:58:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZ8snqJmoyhHjZCYVP5bMmNWzQMkDZ6LtNr1YKEg4A9w@mail.gmail.com>
Message-ID: <CAHk-=wjZ8snqJmoyhHjZCYVP5bMmNWzQMkDZ6LtNr1YKEg4A9w@mail.gmail.com>
Subject: Re: Linux regressions report for mainline [2022-07-24]
To:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 12:48 PM Regzbot (on behalf of Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> * The following patch fixing a build bug reported three times now, that
> didn't get any reaction from the maintainer since it was posted six days
> ago:
> https://lore.kernel.org/lkml/20220717231105.33005-1-kilobyte@angband.pl/

Ok. DavidH is on vacation, so I just picked that up directly.

> * The virtio regression is kinda fixed by c346dae4f3fb already, but
> there is a patch in the branch Michael usually uses to sent patches to
> you that he for one reason or another hasn't sent your way yet:
> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=vhost&idj9720576cd00d30722c5f755bd17d4cfa9df636
> I asked what's up here a few days ago, but sadly got no reply.

I'll let this be for now. It's more of a "don't do that then" thing,

> [ *NEW* ] fs: recent changes to copy_file_range behavior breakage

This seems to be a "damned if you do, damned if you don't", in that
different versions of libtorrent seem to expect different behaviors.

I think we're leaving it be, so that there's just one behavior going
forward, rather than vacillate between two and making things just
worse and oscillate depending on which one people use.

Not good, but there doesn't seem to be a good case.

               Linus
