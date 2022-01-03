Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A9D4837D9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbiACT6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:58:49 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:37365 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230228AbiACT6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:58:47 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 8B67C3200C14;
        Mon,  3 Jan 2022 14:58:46 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute5.internal (MEProxy); Mon, 03 Jan 2022 14:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm1; bh=gvgPv
        1yG5EQYgZkYxMgOW+6+O+OmDk4fEPVfpu6yuIQ=; b=M4bsaYto/3wCLoO1zzRll
        fH5SVoq3ie7OyCHmEeduFyYBDT2s7ZoXe99QYQoLHCOwtE87ZxhbAwI7+Oz7sE1s
        Tv1qVviQNg1y30wxZF3aiHvQM2Mgso10JlbTFdki4OUP8Erq21W9IhZGYptVt1o/
        as+eRqgxndLub5q3PsDJnbUOxVlsibY/5vdu2loySdmQbM5R/sz6VeQV0JQ24n7d
        H69QikP/9eu0I9eeOKR29ZkFzYRdlyKYCIo6CQhVUZvaRI7A5BNzWK7LcaBgoLpo
        tt6uAWuV00hlxWFYs9QxF9y9J8mHqcSKBcRhVO+/EGTZazrsRSt7nq61lV3CNUkO
        w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=gvgPv1yG5EQYgZkYxMgOW+6+O+OmDk4fEPVfpu6yu
        IQ=; b=WlyW14BG9PM16i0Z8ywr4FG0wd2NgHR1xinTzVAwUi/nWpFywwUemsLiP
        6drVmO1YqOwUbF9UVIDY+rrtTVY5f2N+aT+qMwT9PPO+hAEXy7KvHrqqV54jNjlB
        S9YjfU97Gm8OyByVipRLgp1Jy+5InHFGbwWcsIPaM625IJXELFFty5qYzERYvF/i
        dsFle0/Bw4hHiy4OACVyPnarlgVYuGpyNo0ZanTHlNwve1T7R66QplmoxJOk7NBZ
        aAPhwgDT+cMPVwztEtUazlU8o1JK4ou9fWflt+FRknuU7/nR/Zu73F7QZeyI4CLz
        KrF6bkJGr1g5nRUmrFf+IEpCrD7qQ==
X-ME-Sender: <xms:dVXTYT0W3l8xIDXWIMs9XuCREcrihqVe49HPma8unnTY8filtXv3Kw>
    <xme:dVXTYSFivAfa3d_kXMmRLT7fRpoJuuTKZLlKg5YzE52YWwu7gU0d2T7RjYpp8GGUQ
    f5QAU2sKoQDJr4GDAo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefuddgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeefteegkeevfeethffgudehgedvueduvdeifedvvdel
    hfefheekteefueektdefjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:dVXTYT7GK5cFN0QkNOGRKcxupbGaUZJlDgOyrlAqcplB20UIHrr1_g>
    <xmx:dVXTYY2Iynu1px52OMAGyPz2dLL1wt5ih_9iQdT7WIBGhzt_JybUtw>
    <xmx:dVXTYWGWKhDO7uLkRtjWqz_zcMsWzR5KqvJmICxKdRVtp8I0mcSx-w>
    <xmx:dlXTYSAkZjDTetsBEDg52Q9awJsMVYzgajyAVjYl_0LKVc6D_cW6QA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 772C2FA0AA6; Mon,  3 Jan 2022 14:58:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4525-g8883000b21-fm-20211221.001-g8883000b
Mime-Version: 1.0
Message-Id: <55b214dc-315d-4157-9a69-89241a846898@www.fastmail.com>
In-Reply-To: <20211126015216.26605-1-zhangqing@loongson.cn>
References: <20211126015216.26605-1-zhangqing@loongson.cn>
Date:   Mon, 03 Jan 2022 19:58:24 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Qing Zhang" <zhangqing@loongson.cn>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Cc:     devicetree@vger.kernel.org,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/3] MIPS: Loongson64: Add Loongson-2K1000 reset platform driver
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82021=E5=B9=B411=E6=9C=8826=E6=97=A5=E5=8D=81=E4=B8=80=E6=9C=88 =
=E4=B8=8A=E5=8D=881:52=EF=BC=8CQing Zhang=E5=86=99=E9=81=93=EF=BC=9A
> Add power management register operations to support reboot and powerof=
f.
>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
> v8-v9:
> No change
> ---
>  drivers/platform/mips/Kconfig      |  6 ++++
>  drivers/platform/mips/Makefile     |  1 +
>  drivers/platform/mips/ls2k-reset.c | 53 ++++++++++++++++++++++++++++++
>  3 files changed, 60 insertions(+)
>  create mode 100644 drivers/platform/mips/ls2k-reset.c
>
> diff --git a/drivers/platform/mips/Kconfig b/drivers/platform/mips/Kco=
nfig
> index 8ac149173c64b..d421e14823957 100644
> --- a/drivers/platform/mips/Kconfig
> +++ b/drivers/platform/mips/Kconfig
> @@ -30,4 +30,10 @@ config RS780E_ACPI
>  	help
>  	  Loongson RS780E PCH ACPI Controller driver.
>=20
> +config LS2K_RESET
> +	bool "Loongson-2K1000 Reset Controller"
> +	depends on MACH_LOONGSON64 || COMPILE_TEST
> +	help
> +	  Loongson-2K1000 Reset Controller driver.
> +
>  endif # MIPS_PLATFORM_DEVICES
> diff --git a/drivers/platform/mips/Makefile=20
> b/drivers/platform/mips/Makefile
> index 1781490987773..4c71444e453a6 100644
> --- a/drivers/platform/mips/Makefile
> +++ b/drivers/platform/mips/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_CPU_HWMON) +=3D cpu_hwmon.o
>  obj-$(CONFIG_RS780E_ACPI) +=3D rs780e-acpi.o
> +obj-$(CONFIG_LS2K_RESET) +=3D ls2k-reset.o
> diff --git a/drivers/platform/mips/ls2k-reset.c=20
> b/drivers/platform/mips/ls2k-reset.c
> new file mode 100644
> index 0000000000000..b70e7b8a092c2
> --- /dev/null
> +++ b/drivers/platform/mips/ls2k-reset.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Copyright (C) 2021, Qing Zhang <zhangqing@loongson.cn>
> + *  Loongson-2K1000 reset support
> + */
> +
> +#include <linux/of_address.h>
> +#include <linux/pm.h>
> +#include <asm/reboot.h>
> +
> +#define	PM1_STS		0x0c /* Power Management 1 Status Register */
> +#define	PM1_CNT		0x14 /* Power Management 1 Control Register */
> +#define	RST_CNT		0x30 /* Reset Control Register */
> +
> +static void __iomem *base;
> +
> +static void ls2k_restart(char *command)
> +{
> +	writel(0x1, base + RST_CNT);
> +}
> +
> +static void ls2k_poweroff(void)
> +{
> +	/* Clear */
> +	writel((readl(base + PM1_STS) & 0xffffffff), base + PM1_STS);
> +	/* Sleep Enable | Soft Off*/
> +	writel(GENMASK(12, 10) | BIT(13), base + PM1_CNT);
> +}
> +
> +static int ls2k_reset_init(void)
> +{
> +	struct device_node *np;
> +
> +	np =3D of_find_compatible_node(NULL, NULL, "loongson,ls2k-pm");
> +	if (!np) {
> +		pr_info("Failed to get PM node\n");
> +		return -ENODEV;

Hi Qing,

Could you please remove this print.
Otherwise we will have this suspecious log all loongson64 system, not on=
ly ls2k.

Thanks.

- Jiaxun

> +	}
> +
> +	base =3D of_iomap(np, 0);
> +	if (!base) {
> +		pr_info("Failed to map PM register base address\n");
> +		return -ENOMEM;
> +	}
> +
> +	_machine_restart =3D ls2k_restart;
> +	pm_power_off =3D ls2k_poweroff;
> +
> +	of_node_put(np);
> +	return 0;
> +}
> +
> +arch_initcall(ls2k_reset_init);
> --=20
> 2.31.0

--=20
- Jiaxun
