Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D8450C8E3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbiDWKDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 06:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbiDWKDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:03:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC9015CF4D;
        Sat, 23 Apr 2022 03:00:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E964960EF3;
        Sat, 23 Apr 2022 10:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09578C385A0;
        Sat, 23 Apr 2022 10:00:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BrTNBu3U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650708039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yzboIlk5vJyGJ9lIUicUoHDvMySNFYIAfwJpuAS8VE0=;
        b=BrTNBu3UPGd/snRKQaW6FCT2ETTW5AjxdyJ6d5OFslB53rAsjYQWfTknmHGingrsxLV4ix
        yB3Z33fq8ZEu9lWFNSAsBIXFWS69ptmi6XvOsvr/W2o6ZDyCsI3ruk6NWXUUVsrydwnSwy
        QbHGR2xD+RPJeLJSPg/mehva8mt8n/8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7d5a8aa6 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 23 Apr 2022 10:00:38 +0000 (UTC)
Date:   Sat, 23 Apr 2022 12:00:33 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sandy Harris <sandyinchina@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, x86@kernel.org,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v5 11/11] random: insist on random_get_entropy() existing
 in order to simplify
Message-ID: <YmPOQS9GvdiM2brX@zx2c4.com>
References: <20220419111650.1582274-1-Jason@zx2c4.com>
 <20220419111650.1582274-12-Jason@zx2c4.com>
 <CACXcFmksd3cw+xa-c2gEdd4=96PO8GCCMF6q2d6JHnJum2LjiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACXcFmksd3cw+xa-c2gEdd4=96PO8GCCMF6q2d6JHnJum2LjiA@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandy,

On Sat, Apr 23, 2022 at 10:24:07AM +0800, Sandy Harris wrote:
> On Sat, Apr 23, 2022 at 6:37 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > All platforms are now guaranteed to provide some value for
> > random_get_entropy(). In case some bug leads to this not being so, we
> > print a warning, ...
> 
> Would it make sense to test at compile time? If there is no hardware
> RNG nor a cycle counter, then the kernel should be compiled with
> the gcc latent entropy plugin. Generate a warning suggesting that,
> or even an error insisting on it.

Unfortunately, as a last ditch warning safeguard against bugs, I don't
think that's something we can determine at build time. A lot of this
machinery is dynamic. Fortunately a single check at init time brings
with it zero appreciable overhead.

Jason
