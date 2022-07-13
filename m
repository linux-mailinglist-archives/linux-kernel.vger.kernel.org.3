Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4CE573904
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbiGMOk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiGMOk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:40:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34A12559D;
        Wed, 13 Jul 2022 07:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E255B82016;
        Wed, 13 Jul 2022 14:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC54C34114;
        Wed, 13 Jul 2022 14:40:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oZ/LNv0P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657723219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YxTAAH7gZI6F5IexhHjLMhmu4cD2YRAj0Q8vg43R224=;
        b=oZ/LNv0Prn85axWsJ3S2iwsDWLYpDmW//tkj0mFtBGNKxmN9+ARDQuNypi3gSDUvzBpt9b
        Hto1ifRVlVZ3GNgcgToGUVh969/Aq+XlVnMDdhPCi4ad13gYSd/jssuc4Qv1ld1xjzwbx+
        7uuaqv3YW8a4RZVISeein34VkvGDjFM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ac70b275 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 13 Jul 2022 14:40:19 +0000 (UTC)
Date:   Wed, 13 Jul 2022 16:40:17 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] random: vary jitter iterations based on cycle counter
 speed
Message-ID: <Ys7ZURKkoHw8Bp+q@zx2c4.com>
References: <20220422132027.1267060-1-Jason@zx2c4.com>
 <eb74e1b8-af7e-21e8-658f-af6c7975264e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb74e1b8-af7e-21e8-658f-af6c7975264e@arm.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

On Wed, Jul 13, 2022 at 03:31:05PM +0100, Vladimir Murzin wrote:
> I've just seen on the platform with slow(ish) timer that it is now considered
> as a source of entropy with samples_per_bit set to 27 (5.19-rc6 has MAX_SAMPLES_PER_BIT
> set to 32). Because of that I see significant delays and I'm trying to understand what
> could be wrong with my setup.
> 
> I observe one credit_init_bits(1) call (via entropy_timer()) per ~970 schedule() calls.
> Is that somewhat expected? Does it make sense at all?

How slow are we talking? Seconds? Minutes? Is it too slow? It's possible
that MAX_SAMPLES_PER_BIT=32 is a bit high as a threshold and I should
reduce that a bit.

Also, out of curiosity, why is your timer so slow?

Jason
