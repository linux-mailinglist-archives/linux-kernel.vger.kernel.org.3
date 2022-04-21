Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817C750A9A4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392157AbiDUUEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351747AbiDUUER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:04:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092714A3C7;
        Thu, 21 Apr 2022 13:01:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95DE361D12;
        Thu, 21 Apr 2022 20:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E617C385AC;
        Thu, 21 Apr 2022 20:01:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HCRfyF38"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650571280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IVI0f+ocmJtlhFxk/uZrvdqDTyR8lckMkgJ5ub79Rvw=;
        b=HCRfyF38mnLQXcOTFSXKgBg9DKBh8IA5Rgq8rSFB+k1BPBeTgxZhNvZmvFXon1TUCMr+uv
        Ll6vBU7HHeLXwOL1T4mq+aYx4eosLji/rSUeWOVSUHoFzGcA1zeLQzs79spezy0RJTANQ0
        ylbV10iHMlVme2K3/QDQc+1wyz7F+PM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f3e58514 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 21 Apr 2022 20:01:20 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2f4e375daaeso8742177b3.3;
        Thu, 21 Apr 2022 13:01:19 -0700 (PDT)
X-Gm-Message-State: AOAM531cUAAF/UUSjZ3bIO9Hi6TOp7AIfYy7LO5cZebvRnv2UcXn274M
        C3HBDu1m3K0e3Juq/o0hrzl0V1iot/Lfe770j9k=
X-Google-Smtp-Source: ABdhPJw1yKUuvp2WFU2NDFEJJ0fy26Ib6CtYqZu+dI6yF4MSf/3YsV3ORuUj8k41EwOAXPlE3IINgUUtio0oQHxF65c=
X-Received: by 2002:a81:1a49:0:b0:2eb:f4cd:b3f1 with SMTP id
 a70-20020a811a49000000b002ebf4cdb3f1mr1435082ywa.231.1650571274982; Thu, 21
 Apr 2022 13:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220419111650.1582274-1-Jason@zx2c4.com> <20220419111650.1582274-5-Jason@zx2c4.com>
 <alpine.DEB.2.21.2204212018540.9383@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2204212018540.9383@angie.orcam.me.uk>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 21 Apr 2022 22:01:03 +0200
X-Gmail-Original-Message-ID: <CAHmME9o5D93M3P_xcewOBfPisbC2d-x3HYvJPFGUoC6oG_RkgA@mail.gmail.com>
Message-ID: <CAHmME9o5D93M3P_xcewOBfPisbC2d-x3HYvJPFGUoC6oG_RkgA@mail.gmail.com>
Subject: Re: [PATCH v5 04/11] mips: use fallback for random_get_entropy()
 instead of just c0 random
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-um@lists.infradead.org, X86 ML <x86@kernel.org>,
        linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

On Thu, Apr 21, 2022 at 9:25 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> On Tue, 19 Apr 2022, Jason A. Donenfeld wrote:
>
> > For situations in which we don't have a c0 counter register available,
> > we've been falling back to reading the c0 "random" register, which is
> > usually bounded by the amount of TLB entries and changes every other
> > cycle or so. This means it wraps extremely often. We can do better by
> > combining this fast-changing counter with a potentially slower-changing
> > counter from random_get_entropy_fallback() in the more significant bits.
> > This commit combines the two, taking into account that the changing bits
> > are in a different bit position depending on the CPU model. In addition,
> > we previously were falling back to 0 for ancient CPUs that Linux does
> > not support anyway; remove that dead path entirely.
>
> Tested-by: Maciej W. Rozycki <macro@orcam.me.uk>
>
>  I've pushed the algorithm through testing with a number of suitable
> systems:
>
> - an R2000A and an R3000A with no timer of any kind, only jiffies,
>
> - an R3400 with a chipset timer only,
>
> - an R4400SC with a usable buggy CP0 counter and a chipset timer,
>
> - a 5Kc with a good CP0 counter only,
>
> with no obvious issues spotted.  Thank you for working on this!

Thanks for all the testing!

ThomasB - I think maybe you can re-"Acked-by" this now if you're on
board with the strategy here?

Jason
