Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AE54BB373
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 08:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiBRHjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 02:39:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiBRHjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 02:39:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539872B2C5B;
        Thu, 17 Feb 2022 23:38:46 -0800 (PST)
Date:   Fri, 18 Feb 2022 08:38:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645169923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9vLL2m3HI9nPzA+OvepNCcas7d36InHLA2n1nT9lC6c=;
        b=X4iVsGPezN3GA0VLjne2VktzWAd+Y9TKvWtTygjQsYbUBZ9o/Idl8UjH7GBuSf+aip3U4T
        UidMqk95mzNO7E483usdprEppoODIHm5tHwaL92p1qdSgLHhUGFWuAiP9yLvVU479qTM0H
        Z32kqZbGmDB6Uf9bPZ7dj8YVR3QurTsmoKvpSpeRU5cSCjCdiin7I8+I8FZ+8YztEM0bzm
        iMuV1yteuMRratB//EFAq55ReeVcWj0STquiAjAqYmO3azZVsWTe0u/VvR1RXAxuoV9c1j
        7ZOL7s3GBAuD8kiJIQ/wOmbvN74UFJhJU9/7fD0EDMMGR1HOFJuQJlK9E2KqiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645169923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9vLL2m3HI9nPzA+OvepNCcas7d36InHLA2n1nT9lC6c=;
        b=iwCpA+mVcJaWHXdyvcB3zZQfHD9d7FOWfVgnnLWwnGFQYK7WesV8Om0P9SLFs1s1xZl/Uu
        Ls6CuDgPklGCYjAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v6] random: clear fast pool, crng, and batches in cpuhp
 bring up
Message-ID: <Yg9NAgq57ImXF/2T@linutronix.de>
References: <CAHmME9prO9dop7iBRwN54=GMtLH7amS3m_VqGUzL44G1h=R+2A@mail.gmail.com>
 <20220217180409.13151-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220217180409.13151-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-17 19:04:09 [+0100], Jason A. Donenfeld wrote:
> For the irq randomness fast pool, rather than having to use expensive
> atomics, which were visibly the most expensive thing in the entire irq
> handler, simply take care of the extreme edge case of resetting count to
> zero in the cpuhp online handler, just after workqueues have been
> reenabled. This simplifies the code a bit and lets us use vanilla
> variables rather than atomics, and performance should be improved.
> 
> As well, very early on when the CPU comes up, while interrupts are still
> disabled, we clear out the per-cpu crng and its batches, so that it
> always starts with fresh randomness.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Sultan Alsawaf <sultan@kerneltoast.com>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> v6 improves the comments around each of the cpuhp functions, as
> requested.

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Now that I noticed that the previous email had some more comments, sorry
for that. So lets get that in and worry about the other bits later on.

Sebastian
