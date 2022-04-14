Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC45D500C85
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242862AbiDNL7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiDNL7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:59:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7640F7DA9A;
        Thu, 14 Apr 2022 04:57:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05C88B82930;
        Thu, 14 Apr 2022 11:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C5BC385A9;
        Thu, 14 Apr 2022 11:57:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DA3FZELa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649937431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P5/ULzB2dBV6wVJcVqNwMtw/WLd6F6dq7ksMxHzz5tA=;
        b=DA3FZELaUNpOSYvN5LZg46a4BKQ2y+Ds4aokgH0c/AscA0yjtWDKAlopToI81Zx0gDnFKd
        TNnyt4pavfAonj7xLVnay1D+NQ9kmjmZtZW1ABjaB7447fL2qIhnSvM0du/CfvkvtOHUPa
        HeDydNmQb9rYBpps776+yfVJXvO7nz8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 79fb6ffd (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 14 Apr 2022 11:57:10 +0000 (UTC)
Received: by mail-yb1-f181.google.com with SMTP id p65so8921323ybp.9;
        Thu, 14 Apr 2022 04:57:08 -0700 (PDT)
X-Gm-Message-State: AOAM5317LT+TX16N/elP9Kdo68aBNXUwvo9Zzpe0CDVZOONV612AyZSh
        QGieUKMvwI2CawZk7kSAgjEbnCtrK2z2dLZcbwA=
X-Google-Smtp-Source: ABdhPJyKcg613GF5x9fgeLFiZXh8/mhAmu2M+VzMPDTSDm44Qulp172KDH/PBSl3qtPO19ZfXo8qsw8aP1vhDQLRj1E=
X-Received: by 2002:a25:fe0c:0:b0:641:2884:2c7e with SMTP id
 k12-20020a25fe0c000000b0064128842c7emr1344925ybe.382.1649937427424; Thu, 14
 Apr 2022 04:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220413115411.21489-1-Jason@zx2c4.com> <20220413115411.21489-2-Jason@zx2c4.com>
 <Ylfzi1lNWTH1wjLA@shell.armlinux.org.uk>
In-Reply-To: <Ylfzi1lNWTH1wjLA@shell.armlinux.org.uk>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 14 Apr 2022 13:56:56 +0200
X-Gmail-Original-Message-ID: <CAHmME9q8R+uHNF_VBkJezfWn78kyw0RgGf-36JJKs6t3h3wQnA@mail.gmail.com>
Message-ID: <CAHmME9q8R+uHNF_VBkJezfWn78kyw0RgGf-36JJKs6t3h3wQnA@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] timekeeping: add raw clock fallback for random_get_entropy()
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
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
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
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

Hi Russell,

On Thu, Apr 14, 2022 at 12:12 PM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
> I'm surprised this didn't trigger checkpatch to warn. From
> coding-style:
>
> 6.1) Function prototypes
> Do not use the ``extern`` keyword with function declarations as this makes
> lines longer and isn't strictly necessary.

Okay, will do for v+1.

Jason
