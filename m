Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91184F20BE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 04:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiDECAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiDEB76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 21:59:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4420B23DEBA;
        Mon,  4 Apr 2022 18:16:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649119625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aV0m0c+aJi/BzLPiLyQXOexC2EcW7rGlsZ0QrykO0QQ=;
        b=wXbN1yWcRjL6xdtvVkJQUtT7RCNzbFW+da7HgBVma1tDsSplKWtoSbt+e/Chg0JxIFceGh
        QWe+d8QblE7GlXHwUSm3Zk1WJsvCHtxEx3zLcD4QFQAiPUBcNl6OcNrHciPGSvWjVWs4q9
        slH7CJusSJj8nWSnRwpWe8pJpqQLW41z9+eD3BBfsYl9T3i/r/jo1btucqFGA71IzK5vtt
        ypGXWHMN9oIYI+JlprBvAbLJ/1Aw/6Zb69io4RBVh7buKrWCqHf3QRGyWPNFoF3J9Q+3Kk
        VCUnH09H8y1QrKKdMiJfg7prFuOQUIGQ7QRVdrNyez94Mcg05JTFW124rdiGSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649119625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aV0m0c+aJi/BzLPiLyQXOexC2EcW7rGlsZ0QrykO0QQ=;
        b=PvN12likTNzhXL9Xm1SPkolIgSvAcAahJC+d5EPzfPXQm0d0tXbYPkFJZ9klQVyrWNnXfr
        c2PxWRVqcmp/lSAQ==
To:     Mike Travis <mike.travis@hpe.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 2/3] x86/platform/uv: Update TSC sync state for UV5
In-Reply-To: <20220404174111.262414-3-mike.travis@hpe.com>
References: <20220404174111.262414-1-mike.travis@hpe.com>
 <20220404174111.262414-3-mike.travis@hpe.com>
Date:   Tue, 05 Apr 2022 02:47:04 +0200
Message-ID: <87zgl02w6v.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike,

On Mon, Apr 04 2022 at 12:41, Mike Travis wrote:
> Update to not check TSC sync state for uv5+ as it is not available.
> It is assumed that TSC will always be in sync for multiple chassis and
> will pass the tests for the kernel to accept it as the clocksource.
> To disable this check use the kernel start options tsc=reliable
> clocksource=tsc.
...
> ---
> v2: Update patch description to be more explanatory.

after reading the above word salad, I have no urge to go back to V1 to
figure out how bad that changelog was. Let me walk through it:

> Update to not check TSC sync state for uv5+ as it is not available.

That's not a sentence and it does not provide any information about the
background and the why. See:

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog

for further explanation.

> It is assumed that TSC will always be in sync for multiple chassis and
> will pass the tests for the kernel to accept it as the clocksource.

"It is assumed" is a real convincing technical argument - NOT!

Either the hardware guarantees something or not. If the hardware cannot
guarantee it but does not provide a mechanism to verify it then spell it
out:

  "UV5 gave up on providing an interface which allows to query the TSC
   synchronization state. The hardware/firmware specification defines
   that TSC is synchronized accross multiple chassis, but there is
   neither a guarantee nor a validation mechanism. This leaves the
   kernel with the only option to assume that TSC is synchronized and
   TSC_ADJUST might be different between sockets due to UV5+ firmware
   synchronization."

> To disable this check use the kernel start options tsc=reliable
> clocksource=tsc.

So now it get's really confusing. Which check? The one in your 
explanatory description above:

  "Update to not check TSC sync state for uv5+ as it is not available."

or what?

I can assume what are you trying to tell me here, but that's not a
qualification for 'explanatory'

> Signed-off-by: Mike Travis <mike.travis@hpe.com>
> Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> Reviewed-by: Steve Wahl <steve.wahl@hpe.com>

Impressive list of Reviewed-by tags. Just for clarification:

  Reviewed-by tags include the changelog part.

> ---
>  arch/x86/kernel/apic/x2apic_uv_x.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
> index f5a48e66e4f5..387d6533549a 100644
> --- a/arch/x86/kernel/apic/x2apic_uv_x.c
> +++ b/arch/x86/kernel/apic/x2apic_uv_x.c
> @@ -199,10 +199,16 @@ static void __init uv_tsc_check_sync(void)
>  	int mmr_shift;
>  	char *state;
>  
> -	/* Different returns from different UV BIOS versions */
> +	/* UV5+, sync state from bios not available, assumed valid */
> +	if (!is_uv(UV2|UV3|UV4)) {
> +		pr_debug("UV: TSC sync state for UV5+ assumed valid\n");

UV advertises its version all over the place and the call here:

> +		mark_tsc_async_resets("UV5+");

emits the reason at info level. So you surely need the pr_debug() above
to figure out that your code works as expected. You just failed to add
the obviuos counterpart:

          pr_debug("After calling hello_world()!\n");
          
Seriously. Neither the changelog nor the comment above the condition
qualify for explanatory or useful. Please try again.

> +
> +	/* UV2,3,4, UV BIOS TSC sync state available */
>  	mmr = uv_early_read_mmr(UVH_TSC_SYNC_MMR);
> -	mmr_shift =
> -		is_uv2_hub() ? UVH_TSC_SYNC_SHIFT_UV2K : UVH_TSC_SYNC_SHIFT;
> +	mmr_shift = is_uv2_hub() ? UVH_TSC_SYNC_SHIFT_UV2K : UVH_TSC_SYNC_SHIFT;

How is this change related to the problem which this patch tries to
solve? Documentation/process/* applies to UV too. You definitely should
know that by now.

Thanks,

        tglx
