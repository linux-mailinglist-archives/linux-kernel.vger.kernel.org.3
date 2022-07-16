Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220115770C3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 20:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiGPSdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 14:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiGPSdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 14:33:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D7F1A049;
        Sat, 16 Jul 2022 11:33:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D6D9B80CA5;
        Sat, 16 Jul 2022 18:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63630C34114;
        Sat, 16 Jul 2022 18:32:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eYHeI5GL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657996375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VH4xmdoUcNy+FlsmAYsidGOJGQNhYv5Ew2r62PvMg8Q=;
        b=eYHeI5GLymkQc+Gx+9bRrYGmxXIznXoSucD/Fo2XOr6LXP1wC/An48c6WZMCb/FYdI6YvG
        obiHVP44biVJg2y+uwFbDkTylwuhRCXuPC9mvh5H+Cw/FZB+5Zr9X+VkV7M0m2FkSjprir
        6GOGfgRS/UJfp6v5PU0bpJEmfIC5p4k=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 176c368a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 16 Jul 2022 18:32:55 +0000 (UTC)
Date:   Sat, 16 Jul 2022 20:32:55 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] crypto: lib - move crypto_simd_disabled_for_test
 into utils
Message-ID: <YtMEFyH8WyPS/vJB@zx2c4.com>
References: <20220716062920.210381-1-ebiggers@kernel.org>
 <20220716062920.210381-4-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220716062920.210381-4-ebiggers@kernel.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Fri, Jul 15, 2022 at 11:29:20PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Move the definition of crypto_simd_disabled_for_test into
> lib/crypto/utils.c so that it can be accessed by library code.
> 
> This is needed when code that is shared between a traditional crypto API
> implementation and a library implementation is built-in, but
> CRYPTO_ALGAPI=m.  The x86 blake2s previously was an example of this
> (https://lore.kernel.org/linux-crypto/20220517033630.1182-1-gaochao49@huawei.com/T/#u).
> Although that case was resolved by removing the blake2s shash support,
> this problem could easily come back in the future, so let's address it.

I'm not sure I see the reason in general for a utility library rather
than doing these piecemeal like the rest of lib functions. Why is crypto
special here? But in particular to this patch: nothing is actually using
crypto_simd_disabled_for_test in lib/crypto, right? So is this
necessary?

Jason
