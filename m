Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBC34AFF4E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 22:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbiBIVje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 16:39:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiBIVjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:39:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF04C1DF8C4;
        Wed,  9 Feb 2022 13:39:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F145EB823A2;
        Wed,  9 Feb 2022 21:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEDDC340ED;
        Wed,  9 Feb 2022 21:39:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Rw6D/06l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644442769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0CxAPMeO8W1EkYiDAD5FkzwJpGqwBR1FprYjOgnHVSw=;
        b=Rw6D/06ln51zysFIPtzLutX8VWm88MsyTzJqYyt7eYokCyqBq4IvqfnT6F+YW5675xbtGN
        eNvvToTNo43xE9Kzot2mqOa4gTBzxiAEByCPy2L+TRk9WVknLq6QS9vowxGKblZgy7/Rye
        77fczXXVpYkufwy2jNnhqSK09rnhzDo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 29ea8eec (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 9 Feb 2022 21:39:29 +0000 (UTC)
Received: by mail-yb1-f181.google.com with SMTP id v186so9970038ybg.1;
        Wed, 09 Feb 2022 13:39:29 -0800 (PST)
X-Gm-Message-State: AOAM530ZDgznSTmVXVBsrXL01rFCXJD8neK2dM75y3S7bFpCUQYa9iXt
        eQNjk44b4F7+5b8o/Vvk4zXGY6SOee07hyrc2+g=
X-Google-Smtp-Source: ABdhPJzRRM3/Zy6xFhij8dwCbMpngnwC8y8pqIcCoQwKtGCP/JAWgwp/jsQLCFTsY+/FmEQR2nyuA3DPklkKtQ7KLu8=
X-Received: by 2002:a81:1b54:: with SMTP id b81mr4535363ywb.404.1644442768567;
 Wed, 09 Feb 2022 13:39:28 -0800 (PST)
MIME-Version: 1.0
References: <YgQOgqWr0nwqZCh6@owl.dominikbrodowski.net>
In-Reply-To: <YgQOgqWr0nwqZCh6@owl.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 9 Feb 2022 22:39:17 +0100
X-Gmail-Original-Message-ID: <CAHmME9pZB1fWf2nZNwTHw07hrnxZYYymA0_Dy=jauDt9TbF69A@mail.gmail.com>
Message-ID: <CAHmME9pZB1fWf2nZNwTHw07hrnxZYYymA0_Dy=jauDt9TbF69A@mail.gmail.com>
Subject: Re: [PATCH] random: fix locking for crng_init in crng_reseed()
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
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

Hi Dominik,

Thanks, applied. I changed complete_init to finalize_init, to match
our naming scheme from earlier, and I moved
invalidate_batched_entropy() to outside the lock and after
crng_init=2, since now it uses atomics, and it should probably be
ordered after crng_init = 2, so the new batch gets the new entropy.

Actually, though, come to think of it: shouldn't we always call
invalidate_batched_entropy() after reseeding? More generally, we can
instead probably tie the entropy generation counter to the base_crng
counter, and have this all done automatically. That might be something
interesting to do in the future.

Jason
