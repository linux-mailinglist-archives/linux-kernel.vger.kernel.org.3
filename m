Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C5F4AACE1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 23:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380838AbiBEWi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 17:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380757AbiBEWi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 17:38:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18D0C061355;
        Sat,  5 Feb 2022 14:38:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62E30B80D43;
        Sat,  5 Feb 2022 22:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39BBC36AE2;
        Sat,  5 Feb 2022 22:38:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="i5LLWrqO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644100700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bzY8Nwc/+2V+ULsyIZcCyprC3FbpDgujoAEhHHckf3Q=;
        b=i5LLWrqOpjPfQ1upFuLJqnqL8jZw+8/aUlLu+/XQJvW8SgDXG4QJqoaIVqD+oWqFw/r1O7
        tuO976KSR8bucDHfpQDXpRxnrBq2OK7L8uLbIECag2yvzPiYjVU35xfi6ngRD6u/mb9D0L
        w81CQgxboB92V4AOBuSK0SwLB0HVoPM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f17e16fc (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 5 Feb 2022 22:38:19 +0000 (UTC)
Received: by mail-yb1-f182.google.com with SMTP id g14so29485667ybs.8;
        Sat, 05 Feb 2022 14:38:19 -0800 (PST)
X-Gm-Message-State: AOAM531ZM5yefPWvVq6IfCqZelq/HZTYX/2LqjhxOO6b0UjlboJK1jh9
        HOSzQFZJvjhDQ5ixkC0FQvjZGsBiQHGX4CeK+1c=
X-Google-Smtp-Source: ABdhPJzAsbjDxImKWzG3dS8Yzfuhard6qYC9z+kyENMCiea3oS6nifoP1lHARrTw6CWVsXuhTJ7svZUS1KhXouTqdBI=
X-Received: by 2002:a25:5c3:: with SMTP id 186mr90138ybf.255.1644100698170;
 Sat, 05 Feb 2022 14:38:18 -0800 (PST)
MIME-Version: 1.0
References: <20220205160118.252698-1-Jason@zx2c4.com> <20220205160118.252698-5-Jason@zx2c4.com>
In-Reply-To: <20220205160118.252698-5-Jason@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 5 Feb 2022 23:38:07 +0100
X-Gmail-Original-Message-ID: <CAHmME9rNtcZfj5CmRarX3-MKBYVG0tTzu80Jmm=2peWp0zy2UA@mail.gmail.com>
Message-ID: <CAHmME9rNtcZfj5CmRarX3-MKBYVG0tTzu80Jmm=2peWp0zy2UA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] random: always wake up entropy writers after extraction
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
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

A small correction in this:

On Sat, Feb 5, 2022 at 5:02 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> -               .mode           = 0644,
> +               .mode           = 0444,

We actually need to keep this at 644, so as not to break things that
rely on it. It will still do nothing, which is the same choice made
with "urandom_min_reseed_secs" - it's there but doesn't control
anything. So the above snippet is gone.
