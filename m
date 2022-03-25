Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C784E755A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 15:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359401AbiCYOss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 10:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359387AbiCYOsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 10:48:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D7BD95D9;
        Fri, 25 Mar 2022 07:47:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75F15B82865;
        Fri, 25 Mar 2022 14:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F74C340F1;
        Fri, 25 Mar 2022 14:47:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="e29jYBt5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1648219627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r7mADfdfaorIen+c2NdaURScY/0cf8Ufs1ore6VUMAw=;
        b=e29jYBt5BMK3Id1OJdZkzAo7GD2xNLM/W6AOpHe0d0p7U5r9wO5XiwmBt9PT6xVnjmUhGt
        /nLqcSz6/zGQMP9PZmbcRY7p36vzpq9H8U8SBDeiAFUB4uPlUs5yhdIFVJf6ZfPY3R0ZtO
        mrB9trfnO4jXdq15YgKwAFCnrZwZD/8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 173d7ea9 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 25 Mar 2022 14:47:07 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2d07ae0b1c0so85596277b3.2;
        Fri, 25 Mar 2022 07:47:07 -0700 (PDT)
X-Gm-Message-State: AOAM532/Z2xVNCAxAnyKFaVOs1km3+PKtSBpkuCHv8HJ+tIOBE3VmpFL
        xT6sBX4zl2L1BBbLZoaSRtWgqNDtm4Tev5BZHK0=
X-Google-Smtp-Source: ABdhPJwxj9mfYcs4dcAt6tUFCKskMVxa7zReVBf5dKvFgxuwo4mx3BQh2NSD0QwY1Q9wAsGrGDsW9qSQpByR3DVcx7s=
X-Received: by 2002:a81:5250:0:b0:2e6:af4d:22b1 with SMTP id
 g77-20020a815250000000b002e6af4d22b1mr11078817ywb.396.1648219626122; Fri, 25
 Mar 2022 07:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUXYH4xfWtR=P8jXQfks7=zh0Os45yDFOiHNtM_KNWrfiw@mail.gmail.com>
In-Reply-To: <CA+icZUXYH4xfWtR=P8jXQfks7=zh0Os45yDFOiHNtM_KNWrfiw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 25 Mar 2022 08:46:55 -0600
X-Gmail-Original-Message-ID: <CAHmME9rPYOAZ2V660SbgbTvZgD7MDpn9r7ZzDEHzOPjjm8sFVA@mail.gmail.com>
Message-ID: <CAHmME9rPYOAZ2V660SbgbTvZgD7MDpn9r7ZzDEHzOPjjm8sFVA@mail.gmail.com>
Subject: Re: random: treat bootloader trust toggle the same way as cpu trust toggle
To:     sedat.dilek@gmail.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Graham Christensen <graham@grahamc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Hi Sedat,

On Fri, Mar 25, 2022 at 5:46 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> I am not a security expert but following the exciting changes to
> random/crng changes in upcoming v5.18 and using it on top of Linux
> v5.17.
>
> Just saw this typo in [0]:

Thanks. Will fix a the bug.

Jason
