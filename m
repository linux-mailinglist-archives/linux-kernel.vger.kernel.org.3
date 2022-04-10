Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DD04FB05B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 23:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242556AbiDJVlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 17:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiDJVlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 17:41:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9563B551;
        Sun, 10 Apr 2022 14:38:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 125B1B80EC8;
        Sun, 10 Apr 2022 21:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB8FC385A5;
        Sun, 10 Apr 2022 21:38:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NrFXxny0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649626721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I6zxkOx/mC7wvk4Gsn1jwFNXEhXgfgnf3fm3eSnaMTE=;
        b=NrFXxny0IyP3/c19IXFJeNYIjz9bo5HSb8TVdyJF71GUw5newhJgJE4hQONP85hku3z+3A
        D1EiTkXt9Ia/qCihahanmaYzNyMmtPHjAC4fTqzaMqO9Uc+Bn0RphKT2gO/5h2Q6aOlLOx
        9Y1pJog9We26rTE2mdLszVwcT02CsHY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9f3ca50a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 10 Apr 2022 21:38:40 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2e5e31c34bfso146567937b3.10;
        Sun, 10 Apr 2022 14:38:39 -0700 (PDT)
X-Gm-Message-State: AOAM530SacCI04STO32DNppJM6Jgz4w2Ri76AdBz4gRmvb5KDx/qMmwf
        Oj72Ldm1UJA8KGHtfFpHEDkhelmdPFXLxaa8zjk=
X-Google-Smtp-Source: ABdhPJxCzbFmXJJnJDjilSYbyEeJmRI5ZgW2uJj0owOPOVmeurf2ZjKdIlY+6WnsdQt+BKPLZm+7uOHIZCWB5lGl1tg=
X-Received: by 2002:a81:6a84:0:b0:2ec:c59:9d22 with SMTP id
 f126-20020a816a84000000b002ec0c599d22mr3204724ywc.499.1649626717509; Sun, 10
 Apr 2022 14:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220408182145.142506-1-Jason@zx2c4.com> <87wnfxhm3n.ffs@tglx>
 <YlLo8JVOS6FDmWUM@zx2c4.com> <877d7whd29.ffs@tglx>
In-Reply-To: <877d7whd29.ffs@tglx>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 10 Apr 2022 23:38:26 +0200
X-Gmail-Original-Message-ID: <CAHmME9pa+52JPuewOybZE6Q0i+RGKb6crC6_Tropc7ygff7H2g@mail.gmail.com>
Message-ID: <CAHmME9pa+52JPuewOybZE6Q0i+RGKb6crC6_Tropc7ygff7H2g@mail.gmail.com>
Subject: Re: [PATCH RFC v1 00/10] archs/random: fallback to using
 sched_clock() if no cycle counter
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
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
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org
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

Hi Thomas,

On Sun, Apr 10, 2022 at 10:57 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > Not yet having too much knowledge, I'm tentatively leaning toward the
> > safe side, of just using ktime_read_raw_clock() in the current places
> > that return zero all the time -- that is, for the purpose this patchset
> > has.
>
> That's probably a good approach and it's init/runtime discoverable.

Alright then. I'll send out a v2 and we'll see how that looks.

Jason
