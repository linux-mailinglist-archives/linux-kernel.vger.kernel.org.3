Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9CD519A04
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346431AbiEDImM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbiEDImJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:42:09 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54BD1EC5E;
        Wed,  4 May 2022 01:38:31 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so4607011pju.2;
        Wed, 04 May 2022 01:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N8whqiXCDudhxPgHYW7myFUbj5FdlX84aTgM+lwpxQc=;
        b=EjMhZsAd1ZYS3pjiIcMWQts+7329LJLRtKr3sRyCRDZhEDtj1gOtrXgip2keeX+AcU
         QwOlNZCTmxkNoBHpVj6Q7CP9YQ/Kb52y7J3FChGWcAZ7R6yjV/VXAMdZSFhNxh3oRqZa
         OWI5nobcDrpTiSRawunLUc3C2OOa+y0ge6xDlK6iAqm19mGYOYADGFvZ6QAWJSud2n2E
         L29ck9I9VSVdV5TM36wt/vnpR4VWxffPuTOXtHXyFuDrwoFIhkET04EeKBMXtvUzsKAx
         k34M9+YPum5Wnjkf5CZKGjYscE4SKByrDM8aCa+s3egksgzrJ1Ytk66TztKu8iB3sIU1
         dBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N8whqiXCDudhxPgHYW7myFUbj5FdlX84aTgM+lwpxQc=;
        b=Y+2yAHZCJeBbEWTeDNoSvZM9spcavr6T5Hb6mDa4WCs/sL7+9dOGwp82NbepdT/l3U
         D28sUoJXrUcC2GkVZEP7MebG4oJKV3BMUFt4M0W2TaDyIlVzS1bZVVoW/euE0H1OUtaF
         wG0hUZHLMnoxe8J8UYJE2LFqrgPmyTm+uy6gqY6NMQMUWufSdNbDYGucx+oxKOy3QhaP
         vcHVMTiSR6guS+ZIk/C0Wvrj2NvO1lHiSIJtYU+sW0mWKi+0FKOq2ObxyM1FZ2q0nOPl
         mowuSTZvNzo4DTmtfKVA7XJblL35x/L4tewPoTpsosrN+JoRKAgaGFnkEnd2gVuF+qgK
         S/pg==
X-Gm-Message-State: AOAM532LTblam8UbKIEV1PEo+iQYooHhTnEWr5VAUzgUO7PqVaMGkviM
        mv4OxGoX9WDyxpCvsuwC9mA=
X-Google-Smtp-Source: ABdhPJxcFVjZohTgju6+Dy9Mq0QAz/vz1Hn0Yp88nR+3wQfP0tWVaB4N3OrnpG1Odvmj3pudVCCn8w==
X-Received: by 2002:a17:90a:ec02:b0:1dc:3b8d:38e5 with SMTP id l2-20020a17090aec0200b001dc3b8d38e5mr9340621pjy.134.1651653511278;
        Wed, 04 May 2022 01:38:31 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id u18-20020a170902e21200b0015e8d4eb23esm7286998plb.136.2022.05.04.01.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 01:38:30 -0700 (PDT)
Date:   Wed, 4 May 2022 17:38:28 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Snitzer <msnitzer@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Milan Broz <gmazyland@gmail.com>, Jason@zx2c4.com
Subject: Re: [PATCH v2] hex2bin: make the function hex_to_bin constant-time
Message-ID: <YnI7hE4cIfjsdKSF@antec>
References: <alpine.LRH.2.02.2204241648270.17244@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh+Z+OKH3jRttWGHbWSQq2wVMtdnA=ntDiadZu=VxAC7w@mail.gmail.com>
 <alpine.LRH.2.02.2204250723120.26714@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2204250723120.26714@file01.intranet.prod.int.rdu2.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 08:07:48AM -0400, Mikulas Patocka wrote:
 
> From: Mikulas Patocka <mpatocka@redhat.com>
> 
> The function hex2bin is used to load cryptographic keys into device mapper
> targets dm-crypt and dm-integrity. It should take constant time
> independent on the processed data, so that concurrently running
> unprivileged code can't infer any information about the keys via
> microarchitectural convert channels.
> 
> This patch changes the function hex_to_bin so that it contains no branches
> and no memory accesses.
> 
> Note that this shouldn't cause performance degradation because the size of
> the new function is the same as the size of the old function (on x86-64) -
> and the new function causes no branch misprediction penalties.
> 
> I compile-tested this function with gcc on aarch64 alpha arm hppa hppa64
> i386 ia64 m68k mips32 mips64 powerpc powerpc64 riscv sh4 s390x sparc32
> sparc64 x86_64 and with clang on aarch64 arm hexagon i386 mips32 mips64
> powerpc powerpc64 s390x sparc32 sparc64 x86_64 to verify that there are no
> branches in the generated code.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org
> 
> ---
>  include/linux/kernel.h |    2 +-
>  lib/hexdump.c          |   32 +++++++++++++++++++++++++-------
>  2 files changed, 26 insertions(+), 8 deletions(-)
> 
> Index: linux-2.6/lib/hexdump.c
> ===================================================================
> --- linux-2.6.orig/lib/hexdump.c	2022-04-24 18:51:20.000000000 +0200
> +++ linux-2.6/lib/hexdump.c	2022-04-25 13:15:26.000000000 +0200
> @@ -22,15 +22,33 @@ EXPORT_SYMBOL(hex_asc_upper);
>   *
>   * hex_to_bin() converts one hex digit to its actual value or -1 in case of bad
>   * input.
> + *
> + * This function is used to load cryptographic keys, so it is coded in such a
> + * way that there are no conditions or memory accesses that depend on data.
> + *
> + * Explanation of the logic:
> + * (ch - '9' - 1) is negative if ch <= '9'
> + * ('0' - 1 - ch) is negative if ch >= '0'
> + * we "and" these two values, so the result is negative if ch is in the range
> + *	'0' ... '9'
> + * we are only interested in the sign, so we do a shift ">> 8"; note that right
> + *	shift of a negative value is implementation-defined, so we cast the
> + *	value to (unsigned) before the shift --- we have 0xffffff if ch is in
> + *	the range '0' ... '9', 0 otherwise
> + * we "and" this value with (ch - '0' + 1) --- we have a value 1 ... 10 if ch is
> + *	in the range '0' ... '9', 0 otherwise
> + * we add this value to -1 --- we have a value 0 ... 9 if ch is in the range '0'
> + *	... '9', -1 otherwise
> + * the next line is similar to the previous one, but we need to decode both
> + *	uppercase and lowercase letters, so we use (ch & 0xdf), which converts
> + *	lowercase to uppercase
>   */
> -int hex_to_bin(char ch)
> +int hex_to_bin(unsigned char ch)
>  {
> -	if ((ch >= '0') && (ch <= '9'))
> -		return ch - '0';
> -	ch = tolower(ch);
> -	if ((ch >= 'a') && (ch <= 'f'))
> -		return ch - 'a' + 10;
> -	return -1;
> +	unsigned char cu = ch & 0xdf;
> +	return -1 +
> +		((ch - '0' +  1) & (unsigned)((ch - '9' - 1) & ('0' - 1 - ch)) >> 8) +
> +		((cu - 'A' + 11) & (unsigned)((cu - 'F' - 1) & ('A' - 1 - cu)) >> 8);
>  }
>  EXPORT_SYMBOL(hex_to_bin);

Hello,

Just a heads up it seems this patch is causing some instability with crypto self
tests on OpenRISC when using a PREEMPT kernel (no SMP).

This was reported by Jason A. Donenfeld as it came up in wireguard testing.

I am trying to figure out if this is an OpenRISC PREEMPT issue or something
else.

The warning I am seeing is a bit random but looks something like the
following:

    [    0.164000] Freeing initrd memory: 1696K
    [    0.188000] xor: measuring software checksum speed
    [    0.196000]    8regs           :  1343 MB/sec
    [    0.204000]    8regs_prefetch  :  1347 MB/sec
    [    0.212000]    32regs          :  1335 MB/sec
    [    0.220000]    32regs_prefetch :  1277 MB/sec
    [    0.220000] xor: using function: 8regs_prefetch (1347 MB/sec)
    [    0.252000] SARU running 25519 tests
    [    0.424000] curve25519 self-test 5: FAIL
    [    0.496000] curve25519 self-test 7: FAIL
    [    1.744000] curve25519 self-test 45: FAIL
    [    3.448000] ------------[ cut here ]------------
    [    3.448000] WARNING: CPU: 0 PID: 1 at lib/crypto/curve25519.c:19 curve25519_init+0x38/0x50
    [    3.448000] CPU: 0 PID: 1 Comm: swapper Not tainted 5.18.0-rc4+ #758
    [    3.448000] Call trace:
    [    3.448000] [<(ptrval)>] ? __warn+0xe0/0x114
    [    3.448000] [<(ptrval)>] ? curve25519_init+0x38/0x50
    [    3.448000] [<(ptrval)>] ? warn_slowpath_fmt+0x5c/0x94
    [    3.448000] [<(ptrval)>] ? curve25519_init+0x0/0x50
    [    3.452000] [<(ptrval)>] ? curve25519_init+0x38/0x50
    [    3.452000] [<(ptrval)>] ? do_one_initcall+0x98/0x328
    [    3.452000] [<(ptrval)>] ? proc_register+0x4c/0x284
    [    3.452000] [<(ptrval)>] ? ignore_unknown_bootoption+0x0/0x8
    [    3.452000] [<(ptrval)>] ? kernel_init_freeable+0x1fc/0x2a8
    [    3.452000] [<(ptrval)>] ? ignore_unknown_bootoption+0x0/0x8
    [    3.452000] [<(ptrval)>] ? kernel_init+0x0/0x164
    [    3.452000] [<(ptrval)>] ? kernel_init+0x28/0x164
    [    3.452000] [<(ptrval)>] ? schedule_tail+0x18/0xac
    [    3.452000] [<(ptrval)>] ? ret_from_fork+0x1c/0x9c
    [    3.452000] ---[ end trace 0000000000000000 ]---
    [    3.452000] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
    [    3.464000] printk: console [ttyS0] disabled
    [    3.464000] 90000000.serial: ttyS0 at MMIO 0x90000000 (irq = 2, base_baud = 1250000) is a 16550A

Example config: https://xn--4db.cc/cCRlQ1AE

The self-test iteration number that fails is always a bit different.  I am
still in progress of investigating this and will not have a lot of time new the
next few days.  If anything ring's a bell let me know.

-Stafford
