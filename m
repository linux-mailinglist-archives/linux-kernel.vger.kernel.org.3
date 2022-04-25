Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CF050E07C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiDYMkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbiDYMkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:40:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10A17523A;
        Mon, 25 Apr 2022 05:37:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650890231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QYgqWlbZPuGUmSJJNxerWK8Fs+cI9fIYPauFk75HEaY=;
        b=RCo1CGMF/HFPBLHcu9SqOQ+J24t70eVpI5ofvHzUOHEadDBifyNwC/cXMJ9O70I/d1ztC9
        3rOrIh8MoWXIfB1I7h2Z27IWtjz32Pq8KXeIjFEmoMbM2twuoYlvS5FQMo+embBdmSvPBx
        3P+Hl11mBYmXerj0HKcaNQ8PlqKKaE/MLiTB8B7N+Q37lh3nYVe9/Y6+BUI92pKbk7w5AI
        MCHlP/4ZA3jeeW5JgRkX+gN6MRX+ntUcmZzKn1MYZGmZZ56EvZF6gcfKI9auJjk6/9RqiZ
        Ot6fzIwWRAdRM8zGmHpgP7BcN1qp8nNHDDJR2lSgZI7vff4dNQbspR/GhBoaxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650890231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QYgqWlbZPuGUmSJJNxerWK8Fs+cI9fIYPauFk75HEaY=;
        b=q1uvaAwrVuP2bFdfV5+Ha6fEi/PMSWgMi5t7At1tYytGo/6N9M6+0nBAF5rPMBitEpoRee
        mVwl31xVp0KhwjDw==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        arnd@arndb.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v6 06/17] timekeeping: add raw clock fallback for
 random_get_entropy()
In-Reply-To: <20220423212623.1957011-7-Jason@zx2c4.com>
References: <20220423212623.1957011-1-Jason@zx2c4.com>
 <20220423212623.1957011-7-Jason@zx2c4.com>
Date:   Mon, 25 Apr 2022 14:37:11 +0200
Message-ID: <87y1zt1gqw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23 2022 at 23:26, Jason A. Donenfeld wrote:
> The addition of random_get_entropy_fallback() provides access to
> whichever time source has the highest frequency, which is useful for
> gathering entropy on platforms without available cycle counters. It's
> not necessarily as good as being able to quickly access a cycle counter
> that the CPU has, but it's still something, even when it falls back to
> being jiffies-based.
>
> In the event that a given arch does not define get_cycles(), falling
> back to the get_cycles() default implementation that returns 0 is really
> not the best we can do. Instead, at least calling
> random_get_entropy_fallback() would be preferable, because that always
> needs to return _something_, even falling back to jiffies eventually.
> It's not as though random_get_entropy_fallback() is super high precision
> or guaranteed to be entropic, but basically anything that's not zero all
> the time is better than returning zero all the time.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Not that I care much, but in general taking over authorship w/o
attribution via Suggested-by or such is frowned upon.

Thanks,

        tglx
