Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07DC4D721C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 02:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbiCMBbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 20:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbiCMBbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 20:31:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF1F6F49B;
        Sat, 12 Mar 2022 17:30:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10398B80123;
        Sun, 13 Mar 2022 01:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E59C340F4;
        Sun, 13 Mar 2022 01:30:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iJAvLbAD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1647135006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RsI5WV4yoUcLOnxQRC2hH/3m1ZwaBNfgZyXe3xkMm5k=;
        b=iJAvLbADjGBO7kkcDqXmem3ggQdyb3djUMkBZTXNX1wWbLHUAUApoRApV9CLdzx40jkiag
        zmRJpQAX8/PGv22ho4lJRfW2IQkfiXFugYU/Anu9PpFuYodAN7cwutI6d2W5abZ8daSVPN
        vhp9wAkbYK5WwU1LGbhkDYblq0FMWVE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2dcf843e (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 13 Mar 2022 01:30:06 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id u10so24224065ybd.9;
        Sat, 12 Mar 2022 17:30:06 -0800 (PST)
X-Gm-Message-State: AOAM5313E2eSQVptcYsti9Rvt7++VYVOoiIar16mQzjj4CMdwprgOxEg
        p0HcGpCu9Nga2ohaYa0Bn6XbRWC3NUZ8iCC2eoQ=
X-Google-Smtp-Source: ABdhPJzvPh9tYgbjyl+Vuz+imf+2/QYjVtBnK+SGL3TXj2u4V7VWTEPk2FttokUDLyvYeHNH2ME61bFN4SIYpkxMyOc=
X-Received: by 2002:a25:ae12:0:b0:628:b787:b0c2 with SMTP id
 a18-20020a25ae12000000b00628b787b0c2mr13066670ybj.382.1647135005508; Sat, 12
 Mar 2022 17:30:05 -0800 (PST)
MIME-Version: 1.0
References: <20220309152653.1244096-1-Jason@zx2c4.com> <20220309191850.1508953-1-Jason@zx2c4.com>
 <YimFHeXgw9jfevWq@sol.localdomain> <CAHmME9ohyKKX4Qg_dyGq36MxFkhBoVQYYgs8uUoCfBkJNqfX7Q@mail.gmail.com>
 <Yiz4KBqaxURu/6mZ@sol.localdomain> <CAHmME9qWp56dBEgXGUPhpPJRBsS0Sq8rZkPHLAHVcLuks+aK8w@mail.gmail.com>
 <Yi1CRQ1rdQTxilCc@sol.localdomain>
In-Reply-To: <Yi1CRQ1rdQTxilCc@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 12 Mar 2022 18:29:54 -0700
X-Gmail-Original-Message-ID: <CAHmME9rkiAquqASMocBtj9VAHXJCTJCwA+_iNVc2R5DKs6eMoQ@mail.gmail.com>
Message-ID: <CAHmME9rkiAquqASMocBtj9VAHXJCTJCwA+_iNVc2R5DKs6eMoQ@mail.gmail.com>
Subject: Re: [PATCH v2] random: reseed more often immediately after booting
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
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

Hey Eric,

On Sat, Mar 12, 2022 at 6:01 PM Eric Biggers <ebiggers@kernel.org> wrote:
> It's just increasing the reseed interval linearly with the uptime, with constant
> factor 0.5.  So if the last reseed happened at uptime=t, then the next reseed
> will happen on the first request made with uptime >= 2*t.

Thanks, okay, I think I get it. The uptime of the next reseeding will
be at least double the uptime of the prior. Let's give it a try your
way. I'll send a v+1 shortly.

Jason
