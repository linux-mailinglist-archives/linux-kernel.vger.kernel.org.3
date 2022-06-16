Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDFA54E5BF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377877AbiFPPLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377712AbiFPPLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:11:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDAD40A1D;
        Thu, 16 Jun 2022 08:11:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A50F661DE2;
        Thu, 16 Jun 2022 15:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC28C3411A;
        Thu, 16 Jun 2022 15:11:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jXF2QEYd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655392277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d2DN+YoilJcfNhQF3J8D+7tBnhEoZyvKc0fHsQfwhas=;
        b=jXF2QEYdM5lgiSYc+P/0hThSxSSBQzvJcN0PIckvy2xibqgRXzsRZyvHi5PqPLQ22MmKaP
        SSPAtPgnmo8GYjEKnSehqrt3GfT4H2eySeEL+t/bP282RDRUhHw/d/ZweAuIxweF3+jsww
        AGObg8VJw3tvpzLOTGH9Fcn1Ks2+Dfo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 710a274d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 16 Jun 2022 15:11:17 +0000 (UTC)
Date:   Thu, 16 Jun 2022 17:11:13 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Uladzislau Rezki <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] usercopy: use unsigned long instead of uintptr_t
Message-ID: <YqtIEeX8Jx5rBHif@zx2c4.com>
References: <20220616143617.449094-1-Jason@zx2c4.com>
 <YqtAShjjo1zC6EgO@casper.infradead.org>
 <YqtDXPWdFQ/fqgDo@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqtDXPWdFQ/fqgDo@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 04:51:08PM +0200, Jason A. Donenfeld wrote:
> If that's a "dinosaur approach" that "has to stop", it'd certainly be
> news to me (and I'm guessing others on the list too). I've never really
> seen anybody question the kernel's `unsigned long` usage before.
> 
> So hopefully some outcome of this discussion will make it clear, and
> then either this patch will go in, or I'll get to work on carefully
> adjusting my code that uses `unsigned long` at the moment.

Searching through list archives, there's not much, but I did find [1]
from Linus:

    PPS. And btw, the warning is unacceptable too. Cast the thing to
    "unsigned long" (or uintptr_t, but quite frankly, in the kernel I'd
    suggest "unsigned long" rather than the more obscure standard types)
    after you've fixed the macro argument problem.
 
 [1] https://lore.kernel.org/lkml/AANLkTineDxntR0ZTXdgXrc6qx6pATTORgOwFR5+w5MLN@mail.gmail.com/
