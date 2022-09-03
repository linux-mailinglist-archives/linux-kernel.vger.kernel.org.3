Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFDB5AC14E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 22:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbiICUQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 16:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiICUQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 16:16:20 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FD95281A
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 13:16:17 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e13so6427650wrm.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 13:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=2R5mh9Ozb9ba399KwnKZOzn+X6wlKvntyBRFlq3SO5c=;
        b=JvRjTgMbs1qKCkRnEfHuGlI/YSfYZGAtjy1JGnr8ClfXTswk2haGiwHiKwObIAlcvV
         lqgkTjERydzk+8JBeLlPjpy3u7qwBlChdyqJpaecbzzT/oP6f5OJjjuNrc9BSQBpovIi
         Xcrp74zkZdw/qEtE1WY/Cgt6y6RBiSJuOlUzdtxdMXQytkdLzEoTVgZM6mXaSxOG4MEq
         PLs88oxO38o0sCdB9FOWvSlaBZkkiJXP/jdF+cbQnJOAr3c1eXgK2tirJ9fG31mI3nMW
         H0L0YvWjrq5uyroSl2CrLsH3TgaOkXrh4npHqCbRbc5vZ/mYccNsfA0RJ4FfRfxnXGql
         S48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2R5mh9Ozb9ba399KwnKZOzn+X6wlKvntyBRFlq3SO5c=;
        b=VKIy5tlwisoVczR6splRiKrQLljukzL+oWYiyBYoFov0ubsYIZBIDU1vepp+8NsiiF
         Tw6Kx+Z6CCEJ9RYcNDTWIo2Vw7kwpPj4vQaFxX0hxfJC+TbcdIJVU3BOulBXYddUBNsF
         2fD3/ggFQaM7tCGoUHmI2qqJY45YNwyKoN2eXbJe6K/dzxbGeGtOn9kngv6KDOHO7k4B
         SJkrXx7PN3ZZdTHM0+MVVZ6BdMWEubXDjKetZpMnGcW3jfEEY9sZBDmQyxtAtENEcxbR
         8Fnb6P6WfT6PXn6gzvR+2nMEDULWuxiiFF/e9A5yjNJbZ3II90ReeriWtODfk5htLB8j
         RxHA==
X-Gm-Message-State: ACgBeo2VHmOfCLWmMLqznjzJnhdWA9HEmkV7FWQTGdIlrPsssul0L+sm
        yqId9yod8GvFiM7iPzj75lBVD3rccFgYWn6c
X-Google-Smtp-Source: AA6agR6AsmigZ6KGU6X7Fx32yjzUCRSrAnkeu5s8/FBlY3CCdNJaTlUI8QJzTLyXXIiJzzZmbczaQg==
X-Received: by 2002:a5d:64a8:0:b0:226:f3f3:9914 with SMTP id m8-20020a5d64a8000000b00226f3f39914mr7890497wrp.343.1662236176186;
        Sat, 03 Sep 2022 13:16:16 -0700 (PDT)
Received: from smtpclient.apple (global-5-141.n-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id y22-20020a7bcd96000000b003a54f1d007csm5923534wmj.10.2022.09.03.13.16.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Sep 2022 13:16:15 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v9 1/7] RISC-V: Clear SIP bit only when using SBI IPI
 operations
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20220903161309.32848-2-apatel@ventanamicro.com>
Date:   Sat, 3 Sep 2022 21:16:14 +0100
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Bin Meng <bmeng.cn@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6ABE254E-C7DA-468B-9A6B-D10FF32E0E89@jrtc27.com>
References: <20220903161309.32848-1-apatel@ventanamicro.com>
 <20220903161309.32848-2-apatel@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

]On 3 Sept 2022, at 17:13, Anup Patel <apatel@ventanamicro.com> wrote:
>=20
> The software interrupt pending (i.e. [M|S]SIP) bit is writeable for
> S-mode but read-only for M-mode so we clear this bit only when using
> SBI IPI operations.

Uh, where is this specified? I don=E2=80=99t see that, and that would be =
odd.
The spec clearly says that if supervisor software interrupts are
implemented then the bit is writeable, with no caveats on when (beyond
the permissions required to access the CSR in general).

This patch does make sense for a different reason though: that IPIs may
not be using software interrupts at all (in the IMSIC case).

Jess

> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> ---
> arch/riscv/kernel/sbi.c | 8 +++++++-
> arch/riscv/kernel/smp.c | 2 --
> 2 files changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 775d3322b422..fc614650a2e3 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -643,8 +643,14 @@ static void sbi_send_cpumask_ipi(const struct =
cpumask *target)
> 	sbi_send_ipi(target);
> }
>=20
> +static void sbi_ipi_clear(void)
> +{
> +	csr_clear(CSR_IP, IE_SIE);
> +}
> +
> static const struct riscv_ipi_ops sbi_ipi_ops =3D {
> -	.ipi_inject =3D sbi_send_cpumask_ipi
> +	.ipi_inject =3D sbi_send_cpumask_ipi,
> +	.ipi_clear =3D sbi_ipi_clear
> };
>=20
> void __init sbi_init(void)
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index 760a64518c58..c56d67f53ea9 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -83,8 +83,6 @@ void riscv_clear_ipi(void)
> {
> 	if (ipi_ops && ipi_ops->ipi_clear)
> 		ipi_ops->ipi_clear();
> -
> -	csr_clear(CSR_IP, IE_SIE);
> }
> EXPORT_SYMBOL_GPL(riscv_clear_ipi);
>=20
> --=20
> 2.34.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

