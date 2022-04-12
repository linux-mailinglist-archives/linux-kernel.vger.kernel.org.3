Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355DC4FEA1F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 00:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiDLW3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 18:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiDLW3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 18:29:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D9A19EC62;
        Tue, 12 Apr 2022 14:15:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649797072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w642aWN42zYFGGZD2a2O5goJFKRbh1eHda8TK6sp2vE=;
        b=ladY7lhIHrXI2k9D7th0Z6+5ep54BOrI0BnbuW//bOpbOmNiY0uhc/fJhnRb6rfFB8G9mY
        Ze+v0e45IIqUQmchHM6c7WZqQJWMrwLiB6AsoMq3kdFtdXc0H1UEwbXiPHu+zOKLNlV+Rr
        kBWtTurIIXE+P0wft+z6TjNPM4Fwpx+nPAjOHNCrw2/kzz68fZCYtxlIeP27GP/ppLAWyo
        sIZ3nWfYuU1N5plsp4tFWAWj5rC4sh75NhHIe9NfkiNN9zP2OWOoPLdXFlzyqHWcUx87xH
        UeAyFlZEfxHIkB8v/DuJFxXKev9B+PXimtGyFvdnTlAM8lziorbNeXpm0yMh4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649797072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w642aWN42zYFGGZD2a2O5goJFKRbh1eHda8TK6sp2vE=;
        b=97p7ujeYtp/JNITBvGjRAaEaYf/IylcEWqaaB0wlEKegNLYjFko3yLj6d/iRtEo3osYpqD
        YjBvQAAGxYMpj8Cg==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        arnd@arndb.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
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
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, x86@kernel.org,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v3 01/10] timekeeping: add raw clock fallback for
 random_get_entropy()
In-Reply-To: <20220412172754.149498-2-Jason@zx2c4.com>
References: <20220412172754.149498-1-Jason@zx2c4.com>
 <20220412172754.149498-2-Jason@zx2c4.com>
Date:   Tue, 12 Apr 2022 22:57:52 +0200
Message-ID: <87bkx6f29b.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12 2022 at 19:27, Jason A. Donenfeld wrote:
> +/**
> + * random_get_entropy_fallback - Returns the raw clock source value,
> + * used by random.c for platforms with no valid random_get_entropy().
> + */
> +unsigned long random_get_entropy_fallback(void)
> +{
> +	return tk_clock_read(&tk_core.timekeeper.tkr_mono);
> +}
> +EXPORT_SYMBOL(random_get_entropy_fallback);

EXPORT_SYMBOL_GPL() please.

Thanks,

        tglx
