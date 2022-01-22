Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA5E4969A2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 04:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbiAVDqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 22:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiAVDqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 22:46:04 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7692DC06173D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 19:46:04 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id o80so33206831yba.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 19:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GK+DRe45zgKVXKFo8gPG6uGiKgyXp2cTD0RJLmCvZSY=;
        b=QGr+ig/1NkNSQ/DVpGfdNvXcytkEpcUB2Z3Lt1CjofEcwFvFzBHGWU/x6bjfbD+BJM
         28sNmiu9uZQkQfT183g4IwINmBs6qBDPjmUX9tPWIkCpWWqqVLq8KPBLi/4G28cYL2Qc
         XGeEdtOfShkYp+2YRobhPxXvQANlnoodCC1rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GK+DRe45zgKVXKFo8gPG6uGiKgyXp2cTD0RJLmCvZSY=;
        b=Gz6/qoo4IGscTKcWeVzy1awheirQa/8gTtG0KNoyawlENmFw8UMqd5k2PiHYkqTWjZ
         Hn7wgE1kjrXTzbm3zwPnIci0nrLv592ZF5l6n694vLxzHzXV3iUyK75cXFsmy++vmz2Z
         KaVNDG3/1dlRNZIXRIE/mzXRNVsSp//WBtn0Q5N92hlBVPFXqRzP4SefIzA/q+hLjIOw
         jPqYBuW7VdpkmoDig6O4Ml/Kzra3I7Be9xH8BaYo4twjkaq++UieDU6mzFy/MZ3RVgUo
         4hDp/18wvZ7whQsJTmZ7RJpNLslLy1VS//sFdPtLLJEtEqxZX5CMzBbf7k1ZDHP9UT6N
         Uf3g==
X-Gm-Message-State: AOAM531Kryw32LpWOzQVK3Rb9Ognuwy+valoR+JaUITWoIqCeukkesbB
        bK3F0JTIEBREiiAAay/m2YSWMZSriPBoxYJcGUVQ
X-Google-Smtp-Source: ABdhPJxqUxGbofs9AyGZqKNuQHUzAvH8Oar5nZINBL0NQkR2tr89y472EbgCFBjmW5/Z2aBrOhhnBxjAZN3ITVL7G/c=
X-Received: by 2002:a25:b852:: with SMTP id b18mr10998199ybm.651.1642823163252;
 Fri, 21 Jan 2022 19:46:03 -0800 (PST)
MIME-Version: 1.0
References: <20220121163618.351934-1-heiko@sntech.de> <20220121163618.351934-2-heiko@sntech.de>
In-Reply-To: <20220121163618.351934-2-heiko@sntech.de>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 21 Jan 2022 19:45:52 -0800
Message-ID: <CAOnJCU+NR_hOrvS_+B+OKXeg4s+uh37gYWGVTs_kDd3LQDVEkQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/14] riscv: only use IPIs to handle cache-flushes on
 remote cpus
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Wei Fu <wefu@redhat.com>,
        liush <liush@allwinnertech.com>, Guo Ren <guoren@kernel.org>,
        Anup Patel <anup@brainfault.org>,
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

On Fri, Jan 21, 2022 at 8:37 AM Heiko Stuebner <heiko@sntech.de> wrote:
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
> through SBI/M-mode,

Yes. Once Anup's ACLINT drivers are merged, that should be the
preferred approach.

https://github.com/avpatel/linux/commit/416c667fd77d6f1fc310cbf727ec127aaf96cae2

>so IMHO we should only be using
> on_each_cpu_mask(ipi_remote_fence_i) on flush_icache_all()/
> flush_icache_mm() and remove any explicit calls to sbi_remote_fence_i(),

That's a bit confusing because we will be using SBI calls for all other fences
while using IPIs for fence.i

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

IMHO, this series should only fix the null-ptr dereference issue.
The IPI based fence (for all) should only be disabled along with the
ACLINT driver
that actually enables S-mode IPIs.

> Suggested-by: Nick Kossifidis <mick@ics.forth.gr>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
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
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
