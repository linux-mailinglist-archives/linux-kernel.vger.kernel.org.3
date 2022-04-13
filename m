Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E265001FB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 00:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238062AbiDMWnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 18:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiDMWnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 18:43:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADF2424A4;
        Wed, 13 Apr 2022 15:40:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB81661F79;
        Wed, 13 Apr 2022 22:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF43C385AB;
        Wed, 13 Apr 2022 22:40:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="X2vIIC5X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649889633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sy2u2tLdcOJ2AL1/09I7fdj8Xfid/ZIpX9etCksgmJY=;
        b=X2vIIC5X5BNTLZ5C7Wvfq18MIDx14rBDEXQJ5CNKZohjyA25cLabSRtIVUXNp/E9n0aZJF
        HbDFAQ9UULWgJQGkOOj+2Vm+BMPZl0Jilk5jrdNWW1OwylavnULQ+IFrlD/vmsU43QZq2X
        sK+i91xBixVvcioXqPZkDSglQEpU3N4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fd4406c1 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 13 Apr 2022 22:40:33 +0000 (UTC)
Received: by mail-yb1-f169.google.com with SMTP id g34so6395422ybj.1;
        Wed, 13 Apr 2022 15:40:31 -0700 (PDT)
X-Gm-Message-State: AOAM530GdCMdU6mTJpDFEDaaKGkzLrLlQdpIz88J1ROSpPo61JFji3Nk
        peJQFwoT2EbFQIrci0FOvJHHerWkmFm+XOnVUgg=
X-Google-Smtp-Source: ABdhPJx9INm5zW7sTrV4774xD6IRq7PzslZw6I75g3UsN7iIIGechqL3/0SrrUeqYX9XZja0QUvWBULi93OT13Yuj6E=
X-Received: by 2002:a5b:6cf:0:b0:61e:1371:3cda with SMTP id
 r15-20020a5b06cf000000b0061e13713cdamr955062ybq.235.1649889630599; Wed, 13
 Apr 2022 15:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220413115411.21489-1-Jason@zx2c4.com> <20220413115411.21489-4-Jason@zx2c4.com>
 <CAL_JsqJ86vZKZQO+9_Kva-EbZrRPMbcgDm+UvjJdnR=GL-qHSw@mail.gmail.com>
In-Reply-To: <CAL_JsqJ86vZKZQO+9_Kva-EbZrRPMbcgDm+UvjJdnR=GL-qHSw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 14 Apr 2022 00:40:19 +0200
X-Gmail-Original-Message-ID: <CAHmME9qGzW1+dWLvObjQ4ofGcCU1tOwTB+qJTVs2ufEmAEhbrA@mail.gmail.com>
Message-ID: <CAHmME9qGzW1+dWLvObjQ4ofGcCU1tOwTB+qJTVs2ufEmAEhbrA@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] riscv: use fallback for random_get_entropy()
 instead of zero
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, "Theodore Ts'o" <tytso@mit.edu>,
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
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-um@lists.infradead.org, X86 ML <x86@kernel.org>,
        linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, Apr 13, 2022 at 4:40 PM Rob Herring <robh@kernel.org> wrote:
> Moving this check to get_cycles() implementation would eliminate the
> RiscV implementation of random_get_entropy() if you follow my other
> suggestion.

Not an option. random_get_entropy() != get_cycles(). Sometimes these
are different functions. Returning random_get_entropy_fallback() from
get_cycles(), for example, wouldn't make any sense.

Jason
