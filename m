Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF93544C36
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245125AbiFIMgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245198AbiFIMgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:36:02 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703BD22B26;
        Thu,  9 Jun 2022 05:35:55 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 791E420007;
        Thu,  9 Jun 2022 12:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654778154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p5Pd3/2SdAMaSD2h36fwZDnBYwN4Kv85DAN9dSSiNtE=;
        b=AKh3b/jwDYQnLFRUA70mDjchonEx+CSDGVT2bnziGwdBQ6BvrYDp6g1SXTdYjvvfhv3rgc
        1yjlVIlXlQZqJCxETmXBCngCfog0+bp0ZCq0/paofwCM2vgbTiZfBTuXbY29WPXBrNR1j3
        m5IfO+klCWxq8gcQHgilIPbgY71GNbr5F8/ArDACsSecJk/i6OV6kSHkiUMRpq758oSaOi
        w+8OMR1UVRMpIIf+Gd/Lfsqr02qZIN6KBKOpMrlZ2sd8fBzwd5PZj74vV2dXEhRbl4eOS+
        Q4S0/a0NnFfLL5ge05z5jFMUA0IBEVuO3Mb5rWX2RQwtef8it11pYkB9MRUrZQ==
Date:   Thu, 9 Jun 2022 14:35:51 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>, 0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org, lkp@lists.01.org,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?B?77+9ZWNraQ==?= <rafal@milecki.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [mtd]  a2af0cae87: BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20220609143551.2c75d949@xps-13>
In-Reply-To: <20220608154404.GD31193@xsang-OptiPlex-9020>
References: <20220606151417.19227-4-ansuelsmth@gmail.com>
        <20220608154404.GD31193@xsang-OptiPlex-9020>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ansuel,

oliver.sang@intel.com wrote on Wed, 8 Jun 2022 23:44:04 +0800:

> Greeting,
>=20
> FYI, we noticed the following commit (built with gcc-11):
>=20
> commit: a2af0cae87a0205f2f4b89da6e628229a2f8c47f ("[PATCH v5 3/3] mtd: co=
re: introduce of support for dynamic partitions")
> url: https://github.com/intel-lab-lkp/linux/commits/Ansuel-Smith/Add-nvme=
m-support-for-dynamic-partitions/20220606-232755
> base: https://git.kernel.org/cgit/linux/kernel/git/mtd/linux.git mtd/next
> patch link: https://lore.kernel.org/linux-mtd/20220606151417.19227-4-ansu=
elsmth@gmail.com
>=20
> in testcase: boot
>=20
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -=
m 16G
>=20
> caused below changes (please refer to attached dmesg/kmsg for entire log/=
backtrace):

Can you look into this?

Thanks,
Miqu=C3=A8l

>=20
>=20
> +---------------------------------------------+------------+------------+
> |                                             | 96a45c785b | a2af0cae87 |
> +---------------------------------------------+------------+------------+
> | boot_successes                              | 25         | 0          |
> | boot_failures                               | 0          | 12         |
> | BUG:kernel_NULL_pointer_dereference,address | 0          | 12         |
> | Oops:#[##]                                  | 0          | 12         |
> | EIP:add_mtd_device                          | 0          | 12         |
> | Kernel_panic-not_syncing:Fatal_exception    | 0          | 12         |
> +---------------------------------------------+------------+------------+
>=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>=20
>=20
> [    2.820056][    T1] BUG: kernel NULL pointer dereference, address: 000=
00360
> [    2.821034][    T1] #PF: supervisor read access in kernel mode
> [    2.821862][    T1] #PF: error_code(0x0000) - not-present page
> [    2.822468][    T1] *pde =3D 00000000
> [    2.822468][    T1] Oops: 0000 [#1]
> [    2.822468][    T1] CPU: 0 PID: 1 Comm: swapper Not tainted 5.18.0-rc3=
-00074-ga2af0cae87a0 #1
> [    2.822468][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> [    2.822468][    T1] EIP: add_mtd_device+0x32d/0x6a0
> [    2.822468][    T1] Code: 01 ff ff ff 8d 50 ff 85 c2 0f 84 ec fe ff ff=
 31 c0 e9 ef fe ff ff 8d b4 26 00 00 00 00 8b 83 cc 03 00 00 3d 08 ff ff ff=
 74 0e <8b> 80 60 03 00 00 85 c0 0f 85 65 01 00 00 8b 7d 84 89 f8 e8 3b 61
> [    2.822468][    T1] EAX: 00000000 EBX: c6eaa000 ECX: 00000001 EDX: 000=
00000
> [    2.822468][    T1] ESI: 00000000 EDI: c6eaa0f8 EBP: c3f0becc ESP: c3f=
0be44
> [    2.822468][    T1] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAG=
S: 00010213
> [    2.822468][    T1] CR0: 80050033 CR2: 00000360 CR3: 0345a000 CR4: 000=
406d0
> [    2.822468][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 000=
00000
> [    2.822468][    T1] DR6: fffe0ff0 DR7: 00000400
> [    2.822468][    T1] Call Trace:
> [    2.822468][    T1]  ? parse_ofoldpart_partitions+0x60/0x60
> [    2.822468][    T1]  ? mtd_part_of_parse+0x118/0x240
> [    2.822468][    T1]  ? mtd_part_of_parse+0x20e/0x240
> [    2.822468][    T1]  ? parse_mtd_partitions+0xfa/0x200
> [    2.822468][    T1]  mtd_device_parse_register+0x19f/0x2b0
> [    2.822468][    T1]  mtdram_init_device+0xb7/0x100
> [    2.822468][    T1]  init_mtdram+0x67/0xaf
> [    2.822468][    T1]  ? init_phram+0x54/0x54
> [    2.822468][    T1]  do_one_initcall+0x58/0x240
> [    2.822468][    T1]  ? rdinit_setup+0x38/0x38
> [    2.822468][    T1]  do_initcalls+0xf3/0x112
> [    2.822468][    T1]  kernel_init_freeable+0xbd/0xec
> [    2.822468][    T1]  ? rest_init+0x100/0x100
> [    2.822468][    T1]  kernel_init+0x12/0xf0
> [    2.822468][    T1]  ret_from_fork+0x1c/0x30
> [    2.822468][    T1] Modules linked in:
> [    2.822468][    T1] CR2: 0000000000000360
> [    2.822468][    T1] ---[ end trace 0000000000000000 ]---
> [    2.822468][    T1] EIP: add_mtd_device+0x32d/0x6a0
> [    2.822468][    T1] Code: 01 ff ff ff 8d 50 ff 85 c2 0f 84 ec fe ff ff=
 31 c0 e9 ef fe ff ff 8d b4 26 00 00 00 00 8b 83 cc 03 00 00 3d 08 ff ff ff=
 74 0e <8b> 80 60 03 00 00 85 c0 0f 85 65 01 00 00 8b 7d 84 89 f8 e8 3b 61
> [    2.822468][    T1] EAX: 00000000 EBX: c6eaa000 ECX: 00000001 EDX: 000=
00000
> [    2.822468][    T1] ESI: 00000000 EDI: c6eaa0f8 EBP: c3f0becc ESP: c3f=
0be44
> [    2.822468][    T1] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAG=
S: 00010213
> [    2.822468][    T1] CR0: 80050033 CR2: 00000360 CR3: 0345a000 CR4: 000=
406d0
> [    2.822468][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 000=
00000
> [    2.822468][    T1] DR6: fffe0ff0 DR7: 00000400
> [    2.822468][    T1] Kernel panic - not syncing: Fatal exception
> [    2.822468][    T1] Kernel Offset: disabled
>=20
>=20
>=20
> To reproduce:
>=20
>         # build kernel
> 	cd linux
> 	cp config-5.18.0-rc3-00074-ga2af0cae87a0 .config
> 	make HOSTCC=3Dgcc-11 CC=3Dgcc-11 ARCH=3Di386 olddefconfig prepare module=
s_prepare bzImage modules
> 	make HOSTCC=3Dgcc-11 CC=3Dgcc-11 ARCH=3Di386 INSTALL_MOD_PATH=3D<mod-ins=
tall-dir> modules_install
> 	cd <mod-install-dir>
> 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
>=20
>=20
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script =
is attached in this email
>=20
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>=20
>=20
>=20
