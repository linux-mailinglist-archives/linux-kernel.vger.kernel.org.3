Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8564969FC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 05:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiAVEKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 23:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiAVEKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 23:10:42 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8674C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 20:10:36 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c66so19346139wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 20:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xtBzfTtDG7oKM+x9UqD0E0Ye5bVhGGdjMoStNboz9r0=;
        b=3khVdGAzaP4cQaVtq0HqR9t2SgSWu0COjVPL79LLhIjzhULd13thKBLqgrjopbvSr3
         wlasjQ0Om1cjyWDMZ1b/u5EzP+bnoY8fp3WwM4IM5ovzXGd1ON/+JXeVcrv7DEeEEXjV
         fgwKJVGLREOR8VjIbMMr7a3iEmgBfsz4LpoAjOD7iem6oLcwrP2nS8m349y5HvnN+sfQ
         KwPaC9w0G3jRr5EcaYWDFgh6e8AltN4veUgmbzxRn1gHnI9V4o3Oo5+Buh1HCunNbe4X
         bR8b4uWXLVGoOo7gvIB6Hmgc6UL6nCHGR9/NmY7fE9owoFb6hlYTr9lBKWEdbRIDY8Gw
         njwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xtBzfTtDG7oKM+x9UqD0E0Ye5bVhGGdjMoStNboz9r0=;
        b=j58sIxUwmMVTRqKTMG6eVaQ9Fr/otuaXCU7qbQj2b3sHK4MPXgkuGT+f1bZ2CWI1mc
         2wScPDYLZnh6LdKJ6bQ5Dw+XWfjc+yPrS2TFSA+mx9t5MCaOb374Cj2PMN1tJjFI/mFu
         fhDb9oB6MK1Wg5uHIoHsza4xx8vkjjobLhIDX7UOBgGTmiJKjasDeQIflgKrm2yhvb1f
         Tkj/9oswiGGNRymQK54o1P+XLPO/mXX1xjzyAeUax7oyhz3haDhCcOdZP+x6TeGgyu9V
         hOFf2qJ9pVuNdHI65+Slpf5Yl7r9rJJ2I+5mZp5a5loE0dPjuadpgbNxJiUiUb4b0JJD
         9pXQ==
X-Gm-Message-State: AOAM531aWblDOv5HYWKLnUsnLbOw5qvCCSFRYASeo46Ys44h7lMrPhkZ
        jLPP3Mc81O5FX4L7tFElAeI56HfEFNCODHUzNlKj5w==
X-Google-Smtp-Source: ABdhPJx6sfY92HZ0xDDUQCFCf4Hlk2yHd1KucAzOdklPTxk3FJgXWdL1u5os7d9ynNFEuL/bjXv/ZFLMdP2ILtQjhfw=
X-Received: by 2002:a7b:c181:: with SMTP id y1mr3058395wmi.137.1642824635202;
 Fri, 21 Jan 2022 20:10:35 -0800 (PST)
MIME-Version: 1.0
References: <20220121163618.351934-1-heiko@sntech.de> <20220121163618.351934-2-heiko@sntech.de>
In-Reply-To: <20220121163618.351934-2-heiko@sntech.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 22 Jan 2022 09:40:23 +0530
Message-ID: <CAAhSdy0GgUOEZeVeOgRFt80AvJ9DNJJpuT=-gQT-mdX-Km+BmQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/14] riscv: only use IPIs to handle cache-flushes on
 remote cpus
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Wei Fu <wefu@redhat.com>,
        liush <liush@allwinnertech.com>, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Drew Fustini <drew@beagleboard.org>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Lustig <dlustig@nvidia.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 10:07 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Right now, the flush_icache functions always use the SBI remote-fence
> when SBI is available, leaving using IPIs as a fallback mechanism.
>
> IPIs on the other hand are more flexible, as the ipi_ops are initially
> set to go through SBI but later will be overwritten to go through the
> ACLINT/CLINT.
>
> In a discussion we had, Nick was of the opinion that "In general we
> should prefer doing IPIs on S-mode through CLINT instead of going
> through SBI/M-mode, so IMHO we should only be using
> on_each_cpu_mask(ipi_remote_fence_i) on flush_icache_all()/
> flush_icache_mm() and remove any explicit calls to sbi_remote_fence_i(),
> because this way we continue using SBI for doing remote fences even after
> CLINT/ACLINT driver is registered, instead of using direct IPIs through
> CLINT/ACLINT."
>
> So follow this suggestion and just do ipi calls to have the proper kernel
> parts do them,
>
> This also fixes the null-ptr dereference happening when flush_icache_all()
> is called before sbi_init().
>
> Suggested-by: Nick Kossifidis <mick@ics.forth.gr>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

For Guest/VM, only virtual IMSIC provides faster IPIs so in absence of
virtual IMSIC, the SBI IPI based IPIs are the best approach.

Like Atish mentioned, please base this work on the ACLINT series
because the ACLINT series adds required IPI infrastructure which helps
us select SBI IPI versus direct S-mode IPI based on hardware capability.

Regards,
Anup

> ---
>  arch/riscv/mm/cacheflush.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index 6cb7d96ad9c7..c35375cd52ec 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -17,11 +17,7 @@ static void ipi_remote_fence_i(void *info)
>  void flush_icache_all(void)
>  {
>         local_flush_icache_all();
> -
> -       if (IS_ENABLED(CONFIG_RISCV_SBI))
> -               sbi_remote_fence_i(NULL);
> -       else
> -               on_each_cpu(ipi_remote_fence_i, NULL, 1);
> +       on_each_cpu(ipi_remote_fence_i, NULL, 1);
>  }
>  EXPORT_SYMBOL(flush_icache_all);
>
> @@ -66,8 +62,6 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
>                  * with flush_icache_deferred().
>                  */
>                 smp_mb();
> -       } else if (IS_ENABLED(CONFIG_RISCV_SBI)) {
> -               sbi_remote_fence_i(&others);
>         } else {
>                 on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
>         }
> --
> 2.30.2
>
