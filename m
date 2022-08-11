Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC74758F52D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 02:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbiHKARq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 20:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbiHKARk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 20:17:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964948FD5B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 17:17:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D21CB81EA8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 00:17:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A21C433D6;
        Thu, 11 Aug 2022 00:17:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cLNzgMBX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1660177054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xcdqPF+acOQR/oCrj/UIqVdUoCocIhPZs+3zfhhaqo4=;
        b=cLNzgMBXL+BAsa/YoJXOUJ/DObagUBcZeCzI4ztbmUoi81ngK0YYq3v5+v+WQpjXf2Kof4
        jWZU5qUgKv5U3jec+wfw22k3t3RsbpSgXxK8oBHFEqDQa2vpIgI9my1zxTeGAxknwWrNVF
        gYftuYLMZWAHOFWA4oESdazEvXDZ00k=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bf13bbc0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 11 Aug 2022 00:17:34 +0000 (UTC)
Date:   Thu, 11 Aug 2022 02:17:31 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: use raw spinlocks for use on RT
Message-ID: <YvRKm/IpbUID18FK@zx2c4.com>
References: <20220801142530.133007-1-Jason@zx2c4.com>
 <YufkZU9kGkHHUhAK@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YufkZU9kGkHHUhAK@linutronix.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Sebastian,

On Mon, Aug 01, 2022 at 04:34:13PM +0200, Sebastian Andrzej Siewior wrote:
> On 2022-08-01 16:25:31 [+0200], Jason A. Donenfeld wrote:
> > After handling several bug reports using various creative solutions,
> > it's becoming clear that random bytes are actually a useful thing to
> > happen from any ordinary context, including when interruptsare off.
> > Actually, that's been long recognized, which is why the RNG uses
> > spinlocks rather than mutexes. But on RT, those spinlocks are getting
> > converted back into sleeping locks.
> > 
> > This clearly is causing more problems than it might hypothetically
> > solve. Additionally, the locks in random.c are generally for fixed
> > durations doing CPU-bound operations -- no waiting for hardware or I/O
> > or the like. So this shouldn't result in a real harm to latency.
> > 
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> > Sebastian - I won't move forward with this without your Ack, obviously.
> > What do you think of this general approach? -Jason
> 
> I would need to do worst-case measurements and I've been looking at this
> just before writting the other email and there was a local_lock_t
> somewhere which needs also change…

Did you ever come up some measurements here? It sure would be nice if I
could apply this, but obviously that's contingent on you saying it's
okay latency-wise on RT.

Jason
