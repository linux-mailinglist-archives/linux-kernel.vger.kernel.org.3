Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5775A27D8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 14:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344291AbiHZM2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 08:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344221AbiHZM2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:28:10 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82194DAA03;
        Fri, 26 Aug 2022 05:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1661516887; x=1693052887;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eLeDdSONETMaqU/jW74M8t2Idasv+uGCn74gKdTLZcg=;
  b=UI4edFmIsZHHQCA2qqxvk8JjLGx6fT5h9+JWf4VQXokMT+0swLRqGnX4
   Z35kQSK4gfACjV5RIGW73NKPW8h4oM0tbU8MpTGRxUcPVvHsprL5WdF27
   +G6t50jBqh8zjqA+uuCRj+GH5nXxsjixWtPZ0SAOpd4Hde7AYww03M03/
   M19aYMf4oXAryo59OqvGKQyGFqxvhfvyaIQbZCg09HduBUSxjrekxY3J6
   GOUdRncr6yZo3tqsRLlZhBLRz2IWruM/ZKYX3UwTBi2208xITiXLmJHtt
   gBIy8WGBOdBJ0hoG2dl4UomnEtYDtUjlzW6DkmgGoEA7uI8zNHLP1Fmlh
   A==;
X-IronPort-AV: E=Sophos;i="5.93,265,1654552800"; 
   d="scan'208";a="25828589"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 26 Aug 2022 14:28:04 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 26 Aug 2022 14:28:04 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 26 Aug 2022 14:28:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1661516884; x=1693052884;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject;
  bh=eLeDdSONETMaqU/jW74M8t2Idasv+uGCn74gKdTLZcg=;
  b=KNPEaBGizS3uMLMplbcB0mKjke/2j2/Of6deDFO1tr6GuZ1tOh0ccim2
   0z1C1WGl1asXNt5QGZlb+Y4r60sTshWNGTF3qY/W/NVqQmBG7nWOakW7b
   z02latcg0jFUIjMYf3qjJN/qKpWJUSssj8POP+vEB8OAgPTTrYu2UF3QY
   t7FP8zqQwrGmWdOMkXyGCulGaZIRARbOoMyGhhH8d31pGlg3mEl6BdGvr
   u5Gd8MFkH7lUZwlM7mXUsJprPkM86IzfqH/y8O7c3ubTcSg1FTvVnguvz
   IAGX0wWACs6tB2TnSATMJAMMD3IVkDpCniNaTmRePnvFzOROzRZR86Ngd
   g==;
X-IronPort-AV: E=Sophos;i="5.93,265,1654552800"; 
   d="scan'208";a="25828588"
Subject: Re: [PATCH RESEND v2 1/2] clk: core: Honor CLK_OPS_PARENT_ENABLE for clk
 gate ops
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 26 Aug 2022 14:28:04 +0200
Received: from steina-w.localnet (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 9A582280056;
        Fri, 26 Aug 2022 14:28:04 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?ISO-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 26 Aug 2022 14:28:04 +0200
Message-ID: <12115951.O9o76ZdvQC@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220822081424.1310926-2-wenst@chromium.org>
References: <20220822081424.1310926-1-wenst@chromium.org> <20220822081424.1310926-2-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

Am Montag, 22. August 2022, 10:14:23 CEST schrieb Chen-Yu Tsai:
> In the previous commits that added CLK_OPS_PARENT_ENABLE, support for
> this flag was only added to rate change operations (rate setting and
> reparent) and disabling unused subtree. It was not added to the
> clock gate related operations. Any hardware driver that needs it for
> these operations will either see bogus results, or worse, hang.
>=20
> This has been seen on MT8192 and MT8195, where the imp_ii2_* clk
> drivers set this, but dumping debugfs clk_summary would cause it
> to hang.
>=20
> Fixes: fc8726a2c021 ("clk: core: support clocks which requires parents
> enable (part 2)") Fixes: a4b3518d146f ("clk: core: support clocks which
> requires parents enable (part 1)") Signed-off-by: Chen-Yu Tsai
> <wenst@chromium.org>
> Reviewed-by: N=EDcolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: N=EDcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  drivers/clk/clk.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 7fc191c15507..9b365cd6d14b 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -196,6 +196,9 @@ static bool clk_core_rate_is_protected(struct clk_core
> *core) return core->protect_count;
>  }
>=20
> +static int clk_core_prepare_enable(struct clk_core *core);
> +static void clk_core_disable_unprepare(struct clk_core *core);
> +
>  static bool clk_core_is_prepared(struct clk_core *core)
>  {
>  	bool ret =3D false;
> @@ -208,7 +211,11 @@ static bool clk_core_is_prepared(struct clk_core *co=
re)
> return core->prepare_count;
>=20
>  	if (!clk_pm_runtime_get(core)) {
> +		if (core->flags & CLK_OPS_PARENT_ENABLE)
> +			clk_core_prepare_enable(core->parent);
>  		ret =3D core->ops->is_prepared(core->hw);
> +		if (core->flags & CLK_OPS_PARENT_ENABLE)
> +			clk_core_disable_unprepare(core->parent);
>  		clk_pm_runtime_put(core);
>  	}
>=20
> @@ -244,7 +251,13 @@ static bool clk_core_is_enabled(struct clk_core *cor=
e)
>  		}
>  	}
>=20
> +	if (core->flags & CLK_OPS_PARENT_ENABLE)
> +		clk_core_prepare_enable(core->parent);
> +
>  	ret =3D core->ops->is_enabled(core->hw);
> +
> +	if (core->flags & CLK_OPS_PARENT_ENABLE)
> +		clk_core_disable_unprepare(core->parent);
>  done:
>  	if (core->rpm_enabled)
>  		pm_runtime_put(core->dev);
> @@ -812,6 +825,9 @@ int clk_rate_exclusive_get(struct clk *clk)
>  }
>  EXPORT_SYMBOL_GPL(clk_rate_exclusive_get);
>=20
> +static int clk_core_enable_lock(struct clk_core *core);
> +static void clk_core_disable_lock(struct clk_core *core);
> +
>  static void clk_core_unprepare(struct clk_core *core)
>  {
>  	lockdep_assert_held(&prepare_lock);
> @@ -835,6 +851,9 @@ static void clk_core_unprepare(struct clk_core *core)
>=20
>  	WARN(core->enable_count > 0, "Unpreparing enabled %s\n", core-
>name);
>=20
> +	if (core->flags & CLK_OPS_PARENT_ENABLE)
> +		clk_core_enable_lock(core->parent);
> +
>  	trace_clk_unprepare(core);
>=20
>  	if (core->ops->unprepare)
> @@ -843,6 +862,9 @@ static void clk_core_unprepare(struct clk_core *core)
>  	clk_pm_runtime_put(core);
>=20
>  	trace_clk_unprepare_complete(core);
> +
> +	if (core->flags & CLK_OPS_PARENT_ENABLE)
> +		clk_core_disable_lock(core->parent);
>  	clk_core_unprepare(core->parent);
>  }
>=20
> @@ -891,6 +913,9 @@ static int clk_core_prepare(struct clk_core *core)
>  		if (ret)
>  			goto runtime_put;
>=20
> +		if (core->flags & CLK_OPS_PARENT_ENABLE)
> +			clk_core_enable_lock(core->parent);
> +
>  		trace_clk_prepare(core);
>=20
>  		if (core->ops->prepare)
> @@ -898,6 +923,9 @@ static int clk_core_prepare(struct clk_core *core)
>=20
>  		trace_clk_prepare_complete(core);
>=20
> +		if (core->flags & CLK_OPS_PARENT_ENABLE)
> +			clk_core_disable_lock(core->parent);
> +
>  		if (ret)
>  			goto unprepare;
>  	}


Unfortunately this completely locks up my i.MX8M Plus based board during ea=
rly=20
boot.
I'm currently running on next-20220826 using arch/arm64/boot/dts/freescale/
imx8mp-tqma8mpql-mba8mpxl.dts
Reverting this patch gets my board booting again. dmesg until hard lockup=20
below.

Best regards,
Alexander

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]     =
                                                         =20
[    0.000000] Linux version 6.0.0-rc2-next-20220826 (steina@steina-w)=20
(aarch64-v8a-linux-gnu-gcc (OSELAS.Toolchain-2020.08.0 10-2020
0822) 10.2.1 20200822, GNU ld (GNU Binutils) 2.35) #603 SMP PREEMPT Fri Aug=
 26=20
14:25:05 CEST 2022                                   =20
[    0.000000] Machine model: TQ-Systems i.MX8MPlus TQMa8MPxL on MBa8MPxL  =
                                                         =20
[    0.000000] earlycon: ec_imx6q0 at MMIO 0x0000000030a60000 (options=20
'115200')                                                    =20
[    0.000000] printk: bootconsole [ec_imx6q0] enabled                     =
                                                         =20
[    0.000000] efi: UEFI not found.                                        =
                                                         =20
[    0.000000] Reserved memory: created CMA memory pool at 0x000000005a4000=
00,=20
size 896 MiB                                         =20
[    0.000000] OF: reserved mem: initialized node linux,cma, compatible id=
=20
shared-dma-pool                                          =20
[    0.000000] NUMA: No NUMA configuration found                           =
                                                         =20
[    0.000000] NUMA: Faking a node at [mem=20
0x0000000040000000-0x00000000bfffffff]                                     =
              =20
[    0.000000] NUMA: NODE_DATA [mem 0xbfbd6b00-0xbfbd8fff]                 =
                                                         =20
[    0.000000] Zone ranges:                                                =
                                                         =20
[    0.000000]   DMA      [mem 0x0000000040000000-0x00000000bfffffff]      =
                                                         =20
[    0.000000]   DMA32    empty                                            =
                                                         =20
[    0.000000]   Normal   empty                                            =
                                                         =20
[    0.000000] Movable zone start for each node                            =
                                                         =20
[    0.000000] Early memory node ranges                                    =
                                                         =20
[    0.000000]   node   0: [mem 0x0000000040000000-0x00000000923fffff]     =
                                                         =20
[    0.000000]   node   0: [mem 0x0000000092400000-0x00000000943fffff]     =
                                                         =20
[    0.000000]   node   0: [mem 0x0000000094400000-0x00000000bfffffff]     =
                                                         =20
[    0.000000] Initmem setup node 0 [mem=20
0x0000000040000000-0x00000000bfffffff]                                     =
                =20
[    0.000000] psci: probing for conduit method from DT.                   =
                                                         =20
[    0.000000] psci: PSCIv1.1 detected in firmware.                        =
                                                         =20
[    0.000000] psci: Using standard PSCI v0.2 function IDs                 =
                                                         =20
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.                      =
                                                         =20
[    0.000000] psci: SMC Calling Convention v1.1                           =
                                                         =20
[    0.000000] percpu: Embedded 19 pages/cpu s38376 r8192 d31256 u77824    =
                                                         =20
[    0.000000] Detected VIPT I-cache on CPU0                               =
                                                         =20
[    0.000000] CPU features: detected: GIC system register CPU interface   =
                                                         =20
[    0.000000] CPU features: detected: ARM erratum 845719                  =
                                                         =20
[    0.000000] Fallback order for Node 0: 0                                =
                                                         =20
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 51609=
6                                                        =20
[    0.000000] Policy zone: DMA                                            =
                                                         =20
[    0.000000] Kernel command line: root=3D/dev/nfs rw nfsroot=3D192.168.0.=
101:/
srv/tftp/imx8_mainline,v3,tcp ip=3D192.168.0.100:192.168.0.
101::::eth0:off console=3Dttymxc3,115200 earlycon=3Dec_imx6q,0x30A60000,115=
200                                                          =20
[    0.000000] Dentry cache hash table entries: 262144 (order: 9, 2097152=20
bytes, linear)                                            =20
[    0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048576=20
bytes, linear)                                             =20
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off     =
                                                         =20
[    0.000000] Memory: 1077444K/2097152K available (14144K kernel code, 220=
6K=20
rwdata, 6596K rodata, 5376K init, 519K bss, 102204K res
erved, 917504K cma-reserved)                                               =
                                                         =20
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1                                                           =20
[    0.000000] rcu: Preemptible hierarchical RCU implementation.           =
                                                         =20
[    0.000000] rcu:     RCU event tracing is enabled.                      =
                                                         =20
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=3D256 to nr_cpu_i=
ds=3D4.                                                      =20
[    0.000000]  Trampoline variant of Tasks RCU enabled.                   =
                                                         =20
[    0.000000]  Tracing variant of Tasks RCU enabled.                      =
                                                         =20
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 2=
5=20
jiffies.                                               =20
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D4                                                         =20
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0              =
                                                         =20
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode                 =
                                                         =20
[    0.000000] GICv3: 160 SPIs implemented                                 =
                                                         =20
[    0.000000] GICv3: 0 Extended SPIs implemented                          =
                                                         =20
[    0.000000] Root IRQ handler: gic_handle_irq                            =
                                                         =20
[    0.000000] GICv3: GICv3 features: 16 PPIs                              =
                                                         =20
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x00000000388800=
00                                                       =20
[    0.000000] ITS: No ITS available, not enabling LPIs                    =
                                                         =20
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.                                                       =20
[    0.000000] arch_timer: cp15 timer(s) running at 8.00MHz (phys).        =
                                                         =20
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff=20
max_cycles: 0x1d854df40, max_idle_ns: 440795202120 ns          =20
[    0.000000] sched_clock: 56 bits at 8MHz, resolution 125ns, wraps every=
=20
2199023255500ns                                          =20
[    0.008368] Console: colour dummy device 80x25                          =
                                                         =20
[    0.012575] Calibrating delay loop (skipped), value calculated using tim=
er=20
frequency.. 16.00 BogoMIPS (lpj=3D32000)                =20
[    0.022844] pid_max: default: 32768 minimum: 301                        =
                                                         =20
[    0.027538] LSM: Security Framework initializing                        =
                                                         =20
[    0.032209] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes,=
=20
linear)                                                 =20
[    0.039560] Mountpoint-cache hash table entries: 4096 (order: 3, 32768=20
bytes, linear)                                            =20
[    0.048701] cblist_init_generic: Setting adjustable number of callback=20
queues.                                                   =20
[    0.054720] cblist_init_generic: Setting shift to 2 and lim to 1.       =
                                                         =20
[    0.060880] cblist_init_generic: Setting shift to 2 and lim to 1.       =
                                                         =20
[    0.067086] rcu: Hierarchical SRCU implementation.                      =
                                                         =20
[    0.071761] rcu:     Max phase no-delay instances is 1000.              =
                                                         =20
[    0.078123] EFI services will not be available.                         =
                                                         =20
[    0.081907] smp: Bringing up secondary CPUs ...                         =
                                                         =20
[    0.086553] Detected VIPT I-cache on CPU1                               =
                                                         =20
[    0.086639] GICv3: CPU1: found redistributor 1 region 0:0x00000000388a00=
00                                                       =20
[    0.086675] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]  =
                                                         =20
[    0.087141] Detected VIPT I-cache on CPU2                               =
                                                         =20
[    0.087209] GICv3: CPU2: found redistributor 2 region 0:0x00000000388c00=
00                                                       =20
[    0.087229] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]  =
                                                         =20
[    0.087664] Detected VIPT I-cache on CPU3                               =
                                                         =20
[    0.087735] GICv3: CPU3: found redistributor 3 region 0:0x00000000388e00=
00                                                       =20
[    0.087754] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]  =
                                                         =20
[    0.087819] smp: Brought up 1 node, 4 CPUs                              =
                                                         =20
[    0.142729] SMP: Total of 4 processors activated.                       =
                                                         =20
[    0.147444] CPU features: detected: 32-bit EL0 Support                  =
                                                         =20
[    0.152623] CPU features: detected: CRC32 instructions                  =
                                                         =20
[    0.157983] CPU: All CPU(s) started at EL2                              =
                                                         =20
[    0.161908] alternatives: patching kernel code                          =
                                                         =20
[    0.167362] devtmpfs: initialized                                       =
                                                         =20
[    0.175779] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f,=20
max_idle_ns: 7645041785100000 ns                      =20
[    0.182756] futex hash table entries: 1024 (order: 4, 65536 bytes, linea=
r)                                                       =20
[    0.213470] pinctrl core: initialized pinctrl subsystem                 =
                                                         =20
[    0.217757] DMI not present or invalid.                                 =
                                                         =20
[    0.220335] NET: Registered PF_NETLINK/PF_ROUTE protocol family         =
                                                         =20
[    0.226544] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic=20
allocations                                                     =20
[    0.232875] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic=
=20
allocations                                             =20
[    0.240685] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atom=
ic=20
allocations                                           =20
[    0.248550] audit: initializing netlink subsys (disabled)
[    0.254096] audit: type=3D2000 audit(0.180:1): state=3Dinitialized=20
audit_enabled=3D0 res=3D1
[    0.254516] thermal_sys: Registered thermal governor 'bang_bang'
[    0.261730] thermal_sys: Registered thermal governor 'step_wise'
[    0.267761] thermal_sys: Registered thermal governor 'power_allocator'
[    0.273829] cpuidle: using governor menu
[    0.284458] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.291197] ASID allocator initialised with 65536 entries
[    0.297274] Serial: AMBA PL011 UART driver
[    0.307172] imx8mp-pinctrl 30330000.pinctrl: initialized IMX pinctrl dri=
ver
[    0.323077] KASLR disabled due to lack of seed
[    0.333413] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.337396] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.344066] HugeTLB: registered 32.0 MiB page size, pre-allocated 0 pages
[    0.350860] HugeTLB: 508 KiB vmemmap can be freed for a 32.0 MiB page
[    0.357335] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.364157] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.370546] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 pages
[    0.377372] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
[    0.384224] cryptd: max_cpu_qlen set to 1000
[    0.390062] iommu: Default domain type: Translated=20
[    0.392886] iommu: DMA domain TLB invalidation policy: strict mode=20
[    0.399407] SCSI subsystem initialized
[    0.403223] usbcore: registered new interface driver usbfs
[    0.408468] usbcore: registered new interface driver hub
[    0.413793] usbcore: registered new device driver usb
[    0.419379] mc: Linux media interface: v0.10
[    0.423158] videodev: Linux video capture interface: v2.00
[    0.428668] pps_core: LinuxPPS API ver. 1 registered
[    0.433635] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo=
=20
Giometti <giometti@linux.it>
[    0.442834] PTP clock support registered
[    0.446880] EDAC MC: Ver: 3.0.0
[    0.450601] FPGA manager framework
[    0.453404] Advanced Linux Sound Architecture Driver Initialized.
[    0.460221] vgaarb: loaded
[    0.462422] clocksource: Switched to clocksource arch_sys_counter
[    0.468465] VFS: Disk quotas dquot_6.6.0
[    0.472258] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.485904] NET: Registered PF_INET protocol family
[    0.488099] IP idents hash table entries: 32768 (order: 6, 262144 bytes,=
=20
linear)
[    0.496889] tcp_listen_portaddr_hash hash table entries: 1024 (order: 2,=
=20
16384 bytes, linear)
[    0.504019] Table-perturb hash table entries: 65536 (order: 6, 262144=20
bytes, linear)
[    0.511764] TCP established hash table entries: 16384 (order: 5, 131072=
=20
bytes, linear)
[    0.519819] TCP bind hash table entries: 16384 (order: 7, 524288 bytes,=
=20
linear)
[    0.527471] TCP: Hash tables configured (established 16384 bind 16384)
[    0.533730] UDP hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.540415] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes,=20
linear)
[    0.547696] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.553577] RPC: Registered named UNIX socket transport module.
[    0.559190] RPC: Registered udp transport module.
[    0.563903] RPC: Registered tcp transport module.
[    0.568627] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.575107] PCI: CLS 0 bytes, default 64
[    0.579612] hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7=20
counters available
[    0.588770] Initialise system trusted keyrings
[    0.591888] workingset: timestamp_bits=3D42 max_order=3D19 bucket_order=
=3D0
[    0.605043] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.608686] NFS: Registering the id_resolver key type
[    0.613155] Key type id_resolver registered
[    0.617328] Key type id_legacy registered
[    0.621432] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.628089] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver=20
Registering...
[    0.671152] Key type asymmetric registered
[    0.672397] Asymmetric key parser 'x509' registered
[    0.677336] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor=20
243)
[    0.684742] io scheduler mq-deadline registered
[    0.689290] io scheduler kyber registered



