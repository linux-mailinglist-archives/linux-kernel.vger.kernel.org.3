Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029694AEF79
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 11:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiBIKm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 05:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiBIKmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 05:42:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347EAE09EA5C;
        Wed,  9 Feb 2022 02:28:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63497B81878;
        Wed,  9 Feb 2022 10:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24C2C340E7;
        Wed,  9 Feb 2022 10:27:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="K4XKSBwt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644402478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k3NnMzVYILfu4qmxKBnwiknhBgeg952L7E+Eso3InzA=;
        b=K4XKSBwtgS5Zc+l/F1X6ytfrRQi4Rm9kMu2unN4SZ9HRzsdNON5tfVU1T6YC5OyiFHtpec
        Pv6232JC+okTYNsY+/PQjVGgSsmwH/YkvjF6zruey3aiOBK5pWQBBJFPyoqqA3TBjHLZZ9
        OubW7uLvMC4bj5D+BhMtKkPei2tftpg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 83310290 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 9 Feb 2022 10:27:58 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id m6so4466875ybc.9;
        Wed, 09 Feb 2022 02:27:58 -0800 (PST)
X-Gm-Message-State: AOAM531bx6nG4slIEGHCU3/whwDg7lSvlwxs1azEiEvC9n92yXz7DSB/
        755ej+RVbdINtYmLN57HBv+rSUmRsHVX7U1gKoE=
X-Google-Smtp-Source: ABdhPJy6leqE3RrEOZ6Ff6kOA1CA9LjcupmA3FH/19S9uFOcOfyI/JUGPBKMalPf0oHEcxZfhk3ZbnPVge06OLGwiH4=
X-Received: by 2002:a25:c006:: with SMTP id c6mr1325215ybf.457.1644402477501;
 Wed, 09 Feb 2022 02:27:57 -0800 (PST)
MIME-Version: 1.0
References: <20220209011919.493762-1-Jason@zx2c4.com> <20220209011919.493762-4-Jason@zx2c4.com>
 <YgN5z/XqkYV/gxOv@owl.dominikbrodowski.net>
In-Reply-To: <YgN5z/XqkYV/gxOv@owl.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 9 Feb 2022 11:27:46 +0100
X-Gmail-Original-Message-ID: <CAHmME9o-xG7-o=eqO-Yy4c+1=Vx5XCf9nfZE+dT4mo49D+O59A@mail.gmail.com>
Message-ID: <CAHmME9o-xG7-o=eqO-Yy4c+1=Vx5XCf9nfZE+dT4mo49D+O59A@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] random: inline leaves of rand_initialize()
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
>
> Am Wed, Feb 09, 2022 at 02:19:13AM +0100 schrieb Jason A. Donenfeld:
> > This is a preparatory commit for the following one. We simply inline the
> > various functions that rand_initialize() calls that have no other
> > callers. The compiler was doing this anyway before. Doing this will
> > allow us to reorganize this after.
>
> You also move some other code around (parse_trust_cpu() etc.), so please
> mention that in the commit message or leave these parts where they are.
> Other than that, feel free to add my

Will do.
