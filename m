Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF97A506B22
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351931AbiDSLma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351702AbiDSLmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:42:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1046C340E9;
        Tue, 19 Apr 2022 04:37:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C292C6130F;
        Tue, 19 Apr 2022 11:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0096CC385A5;
        Tue, 19 Apr 2022 11:37:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="qHSdBNkz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650368237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ERMMrurTq4taC2ovJg+tOy4Fbtf3EbfcM62G0GQKnfo=;
        b=qHSdBNkzuhjW9XbSKRmJMDQTyTvNjn6SuAHfO+ryi5v1ui/BdqZF8oxRiSm7KhJrlVElBt
        NF9Mzm3Q3fp2gEoI4VoWkt4zduakEI2LdVRg0JsZXBGMdcVvpqAL3nwfDJh0OxpGvJIEGx
        UICzcnIUVK5UqMSa3uhJ4gILC4Ke9fA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 64e6d223 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 19 Apr 2022 11:37:17 +0000 (UTC)
Date:   Tue, 19 Apr 2022 13:37:12 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        tglx@linutronix.de, arnd@arndb.de, Theodore Ts'o <tytso@mit.edu>,
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
Subject: Re: [PATCH v5 08/11] um: use fallback for random_get_entropy()
 instead of zero
Message-ID: <Yl6e6CRezyGsQh26@zx2c4.com>
References: <20220419111650.1582274-1-Jason@zx2c4.com>
 <20220419111650.1582274-9-Jason@zx2c4.com>
 <694c2318d98973ee8995e891f81216ad267341dc.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <694c2318d98973ee8995e891f81216ad267341dc.camel@sipsolutions.net>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

On Tue, Apr 19, 2022 at 01:33:21PM +0200, Johannes Berg wrote:
> On Tue, 2022-04-19 at 13:16 +0200, Jason A. Donenfeld wrote:
> > In the event that random_get_entropy() can't access a cycle counter or
> > similar, falling back to returning 0 is really not the best we can do.
> > Instead, at least calling random_get_entropy_fallback() would be
> > preferable, because that always needs to return _something_, even
> > falling back to jiffies eventually. It's not as though
> > random_get_entropy_fallback() is super high precision or guaranteed to
> > be entropic, but basically anything that's not zero all the time is
> > better than returning zero all the time.
> > 
> > This is accomplished by just including the asm-generic code like on
> > other architectures, which means we can get rid of the empty stub
> > function here.
> 
> 
> LGTM, actually better than before, though not even sure any drivers in
> ARCH=um have interrupts that say they can be used for this.
> 
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> 
> I assume you're going to take this through the random tree?

Right, that's the plan (as mentioned in the cover letter). Changes to
random.c will depend on these patches being there.

Jason
