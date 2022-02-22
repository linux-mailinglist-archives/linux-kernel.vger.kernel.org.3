Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420794BFF9E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbiBVREz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbiBVREx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:04:53 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229745371C;
        Tue, 22 Feb 2022 09:04:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 93169CE12F5;
        Tue, 22 Feb 2022 17:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B9CC340EF;
        Tue, 22 Feb 2022 17:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645549465;
        bh=wz+LWOXacQNPLZPyY3we+EsUmSYHwPj/L7JyjecnO68=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MtlPcA8/6Edr3qQ+NuR+SIssCd2rMepHAN3Z9qKgfS07Vx8p9PfRCvJumzmSppjC4
         75AI+gVoD1M/smCQeA9PdNb5ywz8xq+NxrkIJRJRW9y7MkK5SwMo5LE+h9v+QleemW
         iZYaDHwK/SD6PWiKVffcSqpnxaRZRaoDBbUmQ+V4SF0AVDEANyQrQc86jxNN+YqDvc
         uRvuHQ+38WpW6Rprqss4+jav+yMjbeChdT5JoAlSemXQ05ABQmLHYwZF0VFsMFdEXI
         7a/dIIAynxX3+JBaiJY9tXypmk6S5A16FOM3s67EwkAdEe+Sfe31DGqmbJnjH/RBCi
         4OYb4WLCIzaxA==
Received: by mail-wm1-f50.google.com with SMTP id y6-20020a7bc186000000b0037bdc5a531eso1406035wmi.0;
        Tue, 22 Feb 2022 09:04:24 -0800 (PST)
X-Gm-Message-State: AOAM533gAk/NfuVkL0uc3N/SzOY0jfzNoyTZV7MHYFdUqI3DCxzH8bar
        dSAOpmjy9AWBFpKGYpVK1pGdxmQkrU8EUw8mQMA=
X-Google-Smtp-Source: ABdhPJxz+00FMFoayOcqRkTwt6HYuZcPncxkNIP080IUOV3uYtLrG6sv8G5BytWv5ZyocQkfoH2XHbeyflMgGsohlzs=
X-Received: by 2002:a05:600c:48a:b0:380:3f3a:e08e with SMTP id
 d10-20020a05600c048a00b003803f3ae08emr4088571wme.1.1645549463325; Tue, 22 Feb
 2022 09:04:23 -0800 (PST)
MIME-Version: 1.0
References: <20220222155345.138861-1-tsbogend@alpha.franken.de>
In-Reply-To: <20220222155345.138861-1-tsbogend@alpha.franken.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 22 Feb 2022 18:04:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0QV7y_gFv=VHGKVWjXyYmFFZRrXj3m52d21Fyydib4NQ@mail.gmail.com>
Message-ID: <CAK8P3a0QV7y_gFv=VHGKVWjXyYmFFZRrXj3m52d21Fyydib4NQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Handle address errors for accesses above CPU max
 virtual user address
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 4:53 PM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> Address errors have always been treated as unaliged accesses and handled
> as such. But address errors are also issued for illegal accesses like
> user to kernel space or accesses outside of implemented spaces. This
> change implements Linux exception handling for accesses to the illegal
> space above the CPU implemented maximum virtual user address and the
> MIPS 64bit architecture maximum. With this we can now use a fixed value
> for the maximum task size on every MIPS CPU and get a more optimized
> access_ok().
>
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thank you for addressing this. Should I add this patch to my series
ahead of "mips: use simpler access_ok()"? That way I can keep it all
in my asm-generic tree as a series for 5.18.

>  arch/mips/kernel/unaligned.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
> index df4b708c04a9..7b5aba5df02e 100644
> --- a/arch/mips/kernel/unaligned.c
> +++ b/arch/mips/kernel/unaligned.c
> @@ -1480,6 +1480,23 @@ asmlinkage void do_ade(struct pt_regs *regs)
>         prev_state = exception_enter();
>         perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS,
>                         1, regs, regs->cp0_badvaddr);
> +
> +#ifdef CONFIG_64BIT
> +       /*
> +        * check, if we are hitting space between CPU implemented maximum
> +        * virtual user address and 64bit maximum virtual user address
> +        * and do exception handling to get EFAULTs for get_user/put_user
> +        */
> +       if ((regs->cp0_badvaddr >= (1UL << cpu_vmbits)) &&
> +           (regs->cp0_badvaddr < XKSSEG)) {

It might be clearer to use TASK_SIZE_MAX here instead of XKSSEG,
to match the check in access_ok(). If you like, I can change that while
applying.

        Arnd
