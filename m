Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44544531267
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbiEWN62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236762AbiEWN6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:58:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FACE56FBE;
        Mon, 23 May 2022 06:58:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A4E76114D;
        Mon, 23 May 2022 13:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A97C385AA;
        Mon, 23 May 2022 13:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653314303;
        bh=bMQ76dp2HmQ3uXRMykYlpLogfkiug4VqJggIc37zUrM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Rhu8OE2IygT78Kmgi0veHK3UCRU45Wa1lKf0qRn0eRRSfxWy/znDUceR1oMSY55by
         b/Qjp4WqXMjPxggvmrJcC0RWd7ISbVc4buSL335hPdmnd2FbWEy07P0apQgYY7H11+
         NFlr8OEtHhW7GJ19ciDaIYgTWsKV1vSBJJWX4qSZ5rMgEPypBdhRc5bD8iHWcFmgwf
         if4LTn3sIyl73Q+1hgTvOuYTzaXOBuU1ZdpC5irzwKSc81r7BU7d44Qfg04P23t3Wj
         xjPCV1EQ8qgX5fLkrsY98A1lDRWt1NrDy4qNgFPCtMrf6R9Y+4BKiSHtAS13/wW86d
         X2gY2kmU5w6bQ==
Message-ID: <8e440c28-d4b9-2fc6-0294-f77544264d5c@kernel.org>
Date:   Mon, 23 May 2022 08:58:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 06/11] nios2: use fallback for random_get_entropy()
 instead of zero
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        tglx@linutronix.de, arnd@arndb.de
Cc:     Theodore Ts'o <tytso@mit.edu>,
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
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, x86@kernel.org,
        linux-xtensa@linux-xtensa.org
References: <20220413115411.21489-1-Jason@zx2c4.com>
 <20220413115411.21489-7-Jason@zx2c4.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220413115411.21489-7-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/22 06:54, Jason A. Donenfeld wrote:
> In the event that random_get_entropy() can't access a cycle counter or
> similar, falling back to returning 0 is really not the best we can do.
> Instead, at least calling random_get_entropy_fallback() would be
> preferable, because that always needs to return _something_, even
> falling back to jiffies eventually. It's not as though
> random_get_entropy_fallback() is super high precision or guaranteed to
> be entropic, but basically anything that's not zero all the time is
> better than returning zero all the time.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>   arch/nios2/include/asm/timex.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/nios2/include/asm/timex.h b/arch/nios2/include/asm/timex.h
> index a769f871b28d..d9a3f426cdda 100644
> --- a/arch/nios2/include/asm/timex.h
> +++ b/arch/nios2/include/asm/timex.h
> @@ -9,4 +9,6 @@ typedef unsigned long cycles_t;
>   
>   extern cycles_t get_cycles(void);
>   
> +#define random_get_entropy() (((unsigned long)get_cycles()) ?: random_get_entropy_fallback())
> +
>   #endif

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
