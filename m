Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B007552F0D7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351732AbiETQj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345218AbiETQjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:39:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F44B15EA48
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:39:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3121FB82CAA
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BF4C385A9;
        Fri, 20 May 2022 16:39:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Z2Qj9cK/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653064789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FC3eBd2MQV5kxpOW6Kx7YGg6GTnRuwd5FDJKO5omakk=;
        b=Z2Qj9cK/EYrItQoiqbCfCr1LKoZwuw42kTLlBr8etI74J5MyKOhF1Yzqg5AheFrIca8P2m
        X8NBO76uGjg81X7OwiUHLXLwTUu7Om+R3exk3dHYljL1DLU9j1it+EKUhZj0dqLC2ecDas
        6O9EDmaHOZob+Yb5FbCt9ajaRETTA0w=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2848d647 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 16:39:49 +0000 (UTC)
Date:   Fri, 20 May 2022 18:39:47 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] random: convert to using iters, for Al Viro
Message-ID: <YofEU1ticqujwJdj@zx2c4.com>
References: <20220520094459.116240-1-Jason@zx2c4.com>
 <Yoey+FOYO69lS5qP@zx2c4.com>
 <bbdeeca7-9c99-e661-6596-f04ea783a30b@kernel.dk>
 <Yoe4HP9iTA6l/For@zeniv-ca.linux.org.uk>
 <7e78d6a7-1cc3-2408-fe91-0329f5020e77@kernel.dk>
 <Yoe+lK8RIRbK6lDZ@zeniv-ca.linux.org.uk>
 <69bd18e6-d216-dfb3-201b-f6a285deb0e7@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69bd18e6-d216-dfb3-201b-f6a285deb0e7@kernel.dk>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Fri, May 20, 2022 at 10:24:36AM -0600, Jens Axboe wrote:
> On 5/20/22 10:15 AM, Al Viro wrote:
> > IIRC, Linus' position at the time had been along the lines of
> > "splice is not so good ABI anyway, so let's do it and fix up
> > the places that do get real-world complaints once such appear".
> > So /dev/urandom is one such place...
> 
> That's what Christoph said too. Honestly that's a very odd way to
> attempt to justify breakage like this, even if it is tempting to
> facilitate the set_fs() removal. But then be honest about it and say
> it like it is, rather than some hand wavy explanation that frankly
> doesn't make any sense.
> 
> The referenced change doesn't change the splice ABI at all, hence the
> justification seems very random to me. It kept what we already have,
> except we randomly break some use cases.
 
It looks like Al is right in the sense that Linus must certainly be
aware of the breakage. He fixed tty in 9bb48c82aced ("tty: implement
write_iter").

Anyway, it seems like the iter functions are the way forward, so this v4
is queued up now (with a few minor cosmetic changes) and pushed to:
https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/log/
I'll send an early 5.19 pull for everything either tonight or Sunday.
And then next week I'll start on backports. (Though, 5.12 is a weird
kernel version; I assume this is some Meta kernel that has its own
backport team?)

Meanwhile, hopefully Al can pick up the splice.c sendfile(2) chardev
patch for 5.19, so at least there'll be some silver lining to the
performance hit.

Jason
