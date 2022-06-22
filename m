Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD907554DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358463AbiFVOlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbiFVOlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:41:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F26713CFDE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655908869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CADSVRcI7GbvU5qqCrbD+90jmJ++wCpQVnWvQsnzx7o=;
        b=jK+2Rueqdw7db4tM+elAwa3/sAs9Aor/sbZDHua2/03iPHYoN13x+lgsC36nhnKWSL7SJx
        caCbQYmXkE477OxS4J7i30qgxi2/xh+u38w8W7Dc095IUjr4lDgbYdwLa34bQrHdcZiKXd
        PRRlO2SyLDeHn2HcLakKPHVmREC9YD8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-JgO1wnzJNG6qQjCT_WFGHw-1; Wed, 22 Jun 2022 10:41:08 -0400
X-MC-Unique: JgO1wnzJNG6qQjCT_WFGHw-1
Received: by mail-lj1-f198.google.com with SMTP id d8-20020a05651c088800b0025a755647baso1136691ljq.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CADSVRcI7GbvU5qqCrbD+90jmJ++wCpQVnWvQsnzx7o=;
        b=D3JEfTIYSM4rDrsD99zhu6ScCZYvumY6h6Pkb6DqmmD5EkQ4LxreiwXd/iOuT1fSyF
         bBX8g3p4UgSj15ccTfpEnlBqUUJ01bIRH4kvm7w9i5n094gcPTZ/ivUnhZfDAbm1iFRZ
         5a2CeZQQxqBOfy0+puiy56MZ/9PoXfefQmg5Eko1xWHE+n2wshIYUHbj1mZ3+bvF7Lbl
         7b3PGC3nShqunN5t0YV+BCptz5aMZN6GvrBpL/WBGBa99ATg4X3DUrp+5PcWU6tF/wWo
         aLb77/fcFFs/UxAn7y5UemXuhw+bsE+hOo1oHOn9iKaUKCWcmS/o3JYwhEwnhBFLvHXk
         pPGw==
X-Gm-Message-State: AJIora9rL0ypcV3MCQZ4ZYt3OyAM1R5/dfcJJPd/agikits49HtaS7OL
        jcgul672UdmVPxkgNkhOCZp/vweLuASHtLghz0SLyK+r3lAkIc09av0Fpl1iSFhZU8gx8Xe14Km
        93JFxAepVUvbDnmY6She1djOdZmy1rLrz/O/E2qJ3
X-Received: by 2002:a2e:9097:0:b0:25a:6e3a:8b21 with SMTP id l23-20020a2e9097000000b0025a6e3a8b21mr2188145ljg.37.1655908865241;
        Wed, 22 Jun 2022 07:41:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sigq991P+YuG8cdMlLa303xzuBmG3hBlQDR5wyIaJ4zUUYA9WWM2Zh2PSW32PMrFWuXNfxruqXBDe76FXTFKg=
X-Received: by 2002:a2e:9097:0:b0:25a:6e3a:8b21 with SMTP id
 l23-20020a2e9097000000b0025a6e3a8b21mr2188122ljg.37.1655908864789; Wed, 22
 Jun 2022 07:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <CA+QYu4qTWaDzep2GGxm-63r-xJOFf2rFCCNhWupAgZdKE7HV6w@mail.gmail.com>
 <99a207dc-93cd-1bea-2ffc-404a9f6587bf@arm.com> <CA+QYu4o0OqdwZYFCgCzm2CMHA7pM3nQ+j0_VbHtpFcdJmkMbhw@mail.gmail.com>
 <fe20591a-96bf-2ac5-c97f-442c2b36c455@arm.com> <CA+QYu4rFB0-no98R0jfzDi2z1Q-aXsEyj1+j-G7RNBi1=3SLkQ@mail.gmail.com>
 <90175f7e-0a2f-c83d-6fb5-916f885bbe81@huawei.com>
In-Reply-To: <90175f7e-0a2f-c83d-6fb5-916f885bbe81@huawei.com>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Wed, 22 Jun 2022 16:40:53 +0200
Message-ID: <CA+QYu4r9Z1X3b-PxqcQx3OkdASkon9OvPAVWJcqHLtc2uPkFtA@mail.gmail.com>
Subject: Re: [aarch64] INFO: rcu_sched detected expedited stalls on CPUs/tasks
To:     John Garry <john.garry@huawei.com>
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2022 at 16:13, John Garry <john.garry@huawei.com> wrote:
>
> >> Some pointers first:
> >> Build: https://datawarehouse.cki-project.org/kcidb/tests/3717528
> >> Job: https://gitlab.com/redhat/red-hat-ci-tools/kernel/cki-internal-pipelines/cki-trusted-contributors/-/jobs/2536244504
> >> Config file: https://gitlab.com/api/v4/projects/18194050/jobs/2536244462/artifacts/artifacts/kernel-mainline.kernel.org-clang-aarch64-d1dc87763f406d4e67caf16dbe438a5647692395.config
> >>
> >> The config file has:
> >> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=20
> >> Meaning that after 20ms (2 ticks at HZ=100), an expedited RCU stall will be
> >> declared. I think for !ANDROID, this config value should be let unset/set to 0.
> >> https://github.com/torvalds/linux/blob/1e57930e9f4083ad5854ab6eadffe790a8167fb4/kernel/rcu/Kconfig.debug#L85
> >>
> >> If unset, the value (in ms) of
> >> CONFIG_RCU_CPU_STALL_TIMEOUT=60
> >> will be used before declaring an expedited RCU stall, so 60ms (6 jiffies at
> >> 100HZ). In your log, all the expedited RCU stalls were declared at 3 or 4
> >> jiffies. So removing the CONFIG_RCU_EXP_CPU_STALL_TIMEOUT entry should make
> >> the messages disappear.
> >
> > Hello Pierre,
> >
> > Tthank you very much for finding out the root cause.
> > We've contacted the Fedora kernel maintainer to fix the config as we
> > are using the config from there.
> >
> > Regards,
> > Bruno
>
> Hi Bruno,
>
> I am wondering did you get this issue resolved?

Hi John,

With the config change that does not set
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT the problem seems to be fixed for us.
The newer Fedora kernels already have the config fixed.

Bruno

> On v5.19-rc3 I just enabled some debug configs on a vanilla kernel and
> can easily reproduce a RCU stall on boot, as below.
>
> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0 for me, that being the default.
>
>   Table To iBMC Success.
> GetVariable Status : Not Found.
> [    0.000000] Booting Linux on physical CPU 0x0000010000 [0x410fd082]
> [    0.000000] Linux version 5.19.0-rc3-00001-gd8610c1c16e8
> (john@debian) (gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU
> Binutils for Debian) 2.37) #187 SMP PREEMPT Wed Jun 22 14:08:56 BST 2022
> [    0.000000] Machine model: Hisilicon PhosphorV660 Development Board
> [    0.000000] efi: EFI v2.60 by EDK II
> [    0.000000] efi: SMBIOS=0x3eff0000 SMBIOS 3.0=0x39aa0000
> ACPI=0x39b70000 ACPI 2.0=0x39b70014 MEMATTR=0x3b8d0018
> MEMRESERVE=0x3a002d18
> [    0.000000] ACPI: Early table checksum verification disabled
> [    0.000000] ACPI: RSDP 0x0000000039B70014 000024 (v02 HISI  )
> [    0.000000] ACPI: XSDT 0x0000000039B600E8 000084 (v01 HISI   HIP07
>   00000000      01000013)
> [    0.000000] ACPI: FACP 0x0000000039A20000 00010C (v05 HISI   HIP07
>   00000000 INTL 20151124)
> [    0.000000] ACPI: DSDT 0x00000000399E0000 0080C8 (v02 HISI   HIP07
>   00000000 INTL 20170728)
> [    0.000000] ACPI: MCFG 0x0000000039A80000 0000AC (v01 HISI   HIP07
>   00000000 INTL 20151124)
> [    0.000000] ACPI: SLIT 0x0000000039A70000 00003C (v01 HISI   HIP07
>   00000000 INTL 20151124)
> [    0.000000] ACPI: SPCR 0x0000000039A60000 000050 (v02 HISI   HIP07
>   00000000 INTL 20151124)
> [    0.000000] ACPI: SRAT 0x0000000039A50000 0005B0 (v03 HISI   HIP07
>   00000000 INTL 20151124)
> [    0.000000] ACPI: DBG2 0x0000000039A40000 00005A (v00 HISI   HIP07
>   00000000 INTL 20151124)
> [    0.000000] ACPI: GTDT 0x0000000039A10000 000098 (v02 HISI   HIP07
>   00000000 INTL 20151124)
> [    0.000000] ACPI: APIC 0x0000000039A00000 0013E4 (v01 HISI   HIP07
>   00000000 INTL 20151124)
> [    0.000000] ACPI: IORT 0x00000000399F0000 00080C (v00 HISI   HIP07
>   00000000 INTL 20170728)
> [    0.000000] ACPI: PPTT 0x0000000031870000 001754 (v01 HISI   HIP07
>   00000000 INTL 20151124)
> [    0.000000] ACPI: SPMI 0x0000000031860000 000041 (v05 HISI   HIP07
>   00000000 INTL 20151124)
> [    0.000000] ACPI: iBFT 0x00000000317C0000 000800 (v01 HISI   HIP07
>   00000000      00000000)
> [    0.000000] ACPI: SPCR: console: pl011,mmio32,0x602b0000,115200
> [    0.000000] earlycon: pl11 at MMIO32 0x00000000602b0000 (options
> '115200')
> [    0.000000] printk: bootconsole [pl11] enabled
> [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x3fffffff]
> [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x1000000000-0x17ffffffff]
> [    0.000000] ACPI: SRAT: Node 2 PXM 2 [mem 0x40000000000-0x4003fffffff]
> [    0.000000] ACPI: SRAT: Node 2 PXM 2 [mem 0x41000000000-0x417ffffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x17fbffdac0-0x17fbffffff]
> [    0.000000] NUMA: Initmem setup node 1 [<memory-less node>]
> [    0.000000] NUMA: NODE_DATA [mem 0x417f400aac0-0x417f400cfff]
> [    0.000000] NUMA: NODE_DATA(1) on node 2
> [    0.000000] NUMA: NODE_DATA [mem 0x417f4008580-0x417f400aabf]
> [    0.000000] NUMA: Initmem setup node 3 [<memory-less node>]
> [    0.000000] NUMA: NODE_DATA [mem 0x417f4006040-0x417f400857f]
> [    0.000000] NUMA: NODE_DATA(3) on node 2
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000000000-0x00000000ffffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   [mem 0x0000000100000000-0x00000417fbffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000000000-0x000000003188afff]
> [    0.000000]   node   0: [mem 0x000000003188b000-0x000000003188efff]
> [    0.000000]   node   0: [mem 0x000000003188f000-0x000000003992ffff]
> [    0.000000]   node   0: [mem 0x0000000039930000-0x00000000399dffff]
> [    0.000000]   node   0: [mem 0x00000000399e0000-0x0000000039a2ffff]
> [    0.000000]   node   0: [mem 0x0000000039a30000-0x0000000039a3ffff]
> [    0.000000]   node   0: [mem 0x0000000039a40000-0x0000000039a8ffff]
> [    0.000000]   node   0: [mem 0x0000000039a90000-0x0000000039b5ffff]
> [    0.000000]   node   0: [mem 0x0000000039b60000-0x0000000039b7ffff]
> [    0.000000]   node   0: [mem 0x0000000039b80000-0x0000000039ffffff]
> [    0.000000]   node   0: [mem 0x000000003a000000-0x000000003efeffff]
> [    0.000000]   node   0: [mem 0x000000003eff0000-0x000000003f01ffff]
> [    0.000000]   node   0: [mem 0x000000003f020000-0x000000003fbfffff]
> [    0.000000]   node   0: [mem 0x0000001040000000-0x00000017fbffffff]
> [    0.000000]   node   2: [mem 0x0000041000000000-0x00000417fbffffff]
> [    0.000000] Initmem setup node 0 [mem
> 0x0000000000000000-0x00000017fbffffff]
> [    0.000000] Initmem setup node 1 as memoryless
> [    0.000000] Initmem setup node 2 [mem
> 0x0000041000000000-0x00000417fbffffff]
> [    0.000000] Initmem setup node 3 as memoryless
> [    0.000000] On node 0, zone Normal: 1024 pages in unavailable ranges
> [    0.000000] On node 2, zone Normal: 16384 pages in unavailable ranges
> [    0.000000] On node 2, zone Normal: 16384 pages in unavailable ranges
> [    0.000000] cma: Reserved 32 MiB at 0x000000003ce00000
> [    0.000000] crashkernel reserved: 0x0000000002000000 -
> 0x0000000012000000 (256 MB)
> [    0.000000] kasan: KernelAddressSanitizer initialized (generic)
> [    0.000000] psci: probing for conduit method from ACPI.
> [    0.000000] psci: PSCIv1.0 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: MIGRATE_INFO_TYPE not supported.
> [    0.000000] psci: SMC Calling Convention v1.0
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10000 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10001 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10002 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10003 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10100 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10101 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10102 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10103 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10200 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10201 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10202 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10203 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10300 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10301 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10302 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10303 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30000 -> Node 1
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30001 -> Node 1
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30002 -> Node 1
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30003 -> Node 1
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30100 -> Node 1
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30101 -> Node 1
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30102 -> Node 1
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30103 -> Node 1
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30200 -> Node 1
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30201 -> Node 1
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30202 -> Node 1
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30203 -> Node 1
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30300 -> Node 1
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30301 -> Node 1
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30302 -> Node 1
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30303 -> Node 1
> [    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50000 -> Node 2
> [    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50001 -> Node 2
> [    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50002 -> Node 2
> [    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50003 -> Node 2
> [    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50100 -> Node 2
> [    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50101 -> Node 2
> [    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50102 -> Node 2
> [    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50103 -> Node 2
> [    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50200 -> Node 2
> [    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50201 -> Node 2
> [    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50202 -> Node 2
> [    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50203 -> Node 2
> [    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50300 -> Node 2
> [    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50301 -> Node 2
> [    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50302 -> Node 2
> [    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50303 -> Node 2
> [    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x70000 -> Node 3
> [    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x70001 -> Node 3
> [    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x70002 -> Node 3
> [    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x70003 -> Node 3
> [    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x70100 -> Node 3
> [    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x70101 -> Node 3
> [    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x70102 -> Node 3
> [    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x70103 -> Node 3
> [    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x70200 -> Node 3
> [    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x70201 -> Node 3
> [    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x70202 -> Node 3
> [    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x70203 -> Node 3
> [    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x70300 -> Node 3
> [    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x70301 -> Node 3
> [    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x70302 -> Node 3
> [    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x70303 -> Node 3
> [    0.000000] percpu: Embedded 21 pages/cpu s45880 r8192 d31944 u86016
> [    0.000000] Detected PIPT I-cache on CPU0
> [    0.000000] CPU features: detected: GIC system register CPU interface
> [    0.000000] CPU features: detected: Spectre-v2
> [    0.000000] CPU features: detected: Spectre-v3a
> [    0.000000] CPU features: detected: Spectre-v4
> [    0.000000] CPU features: detected: Spectre-BHB
> [    0.000000] CPU features: kernel page table isolation forced ON by KASLR
> [    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
> [    0.000000] CPU features: detected: ARM errata 1165522, 1319367, or
> 1530923
> [    0.000000] Fallback order for Node 0: 0 2
> [    0.000000] Fallback order for Node 1: 1 0 2
> [    0.000000] Fallback order for Node 2: 2 0
> [    0.000000] Fallback order for Node 3: 3 2 0
> [    0.000000] Built 4 zonelists, mobility grouping on.  Total pages:
> 16481808
> [    0.000000] Policy zone: Normal
> [    0.000000] Kernel command line: BOOT_IMAGE=/john/Image rdinit=/init
> crashkernel=256M@32M console=ttyAMA0,115200 earlycon acpi=force
> pcie_aspm=off noinitrd root=/dev/sda2 rw log_buf_len=16M user_debug=1
> iommu.strict=0 nvme.use_threaded_interrupts=1 irqchip.gicv3_pseudo_nmi=1
> [    0.000000] PCIe ASPM is disabled
> [    0.000000] Unknown kernel command line parameters
> "BOOT_IMAGE=/john/Image user_debug=1", will be passed to user space.
> [    0.000000] printk: log_buf_len: 16777216 bytes
> [    0.000000] printk: early log buf free: 120024(91%)
> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.000000] Stack Depot early init allocating hash table with
> memblock_alloc, 8388608 bytes
> [    0.000000] software IO TLB: mapped [mem
> 0x0000000035930000-0x0000000039930000] (64MB)
> [    0.000000] Memory: 56859952K/66973696K available (23744K kernel
> code, 16474K rwdata, 16940K rodata, 22528K init, 823K bss, 10080976K
> reserved, 32768K cma-reserved)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=64, Nodes=4
> [    0.000000] rcu: Preemptible hierarchical RCU implementation.
> [    0.000000] rcu:     RCU event tracing is enabled.
> [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=256 to
> nr_cpu_ids=64.
> [    0.000000]  Trampoline variant of Tasks RCU enabled.
> [    0.000000]  Tracing variant of Tasks RCU enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
> is 25 jiffies.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=64
> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
> [    0.000000] GIC: enabling workaround for GICv3: HIP07 erratum 161010803
> [    0.000000] GICv3: 988 SPIs implemented
> [    0.000000] GICv3: 0 Extended SPIs implemented
> [    0.000000] Root IRQ handler: gic_handle_irq
> [    0.000000] GICv3: GICv3 features: 16 PPIs, DirectLPI
> [    0.000000] GICv3: GICv4 features: DirectLPI
> [    0.000000] GICv3: CPU0: found redistributor 10000 region
> 0:0x000000004d100000
> [    0.000000] SRAT: PXM 0 -> ITS 0 -> Node 0
> [    0.000000] SRAT: PXM 1 -> ITS 1 -> Node 1
> [    0.000000] SRAT: PXM 0 -> ITS 2 -> Node 0
> [    0.000000] SRAT: PXM 1 -> ITS 3 -> Node 1
> [    0.000000] SRAT: PXM 2 -> ITS 4 -> Node 2
> [    0.000000] SRAT: PXM 3 -> ITS 5 -> Node 3
> [    0.000000] SRAT: PXM 2 -> ITS 6 -> Node 2
> [    0.000000] SRAT: PXM 3 -> ITS 7 -> Node 3
> [    0.000000] ITS [mem 0x4c000000-0x4c01ffff]
> [    0.000000] ITS@0x000000004c000000: Using ITS number 0
> [    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
> [    0.000000] ITS@0x000000004c000000: allocated 524288 Devices
> @1040c00000 (flat, esz 8, psz 16K, shr 1)
> [    0.000000] ITS@0x000000004c000000: allocated 65536 Virtual CPUs
> @1040980000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS@0x000000004c000000: allocated 512 Interrupt
> Collections @1040944000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS [mem 0x6c000000-0x6c01ffff]
> [    0.000000] ITS@0x000000006c000000: Using ITS number 1
> [    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
> [    0.000000] ITS@0x000000006c000000: allocated 524288 Devices
> @1041000000 (flat, esz 8, psz 16K, shr 1)
> [    0.000000] ITS@0x000000006c000000: allocated 65536 Virtual CPUs
> @1040a00000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS@0x000000006c000000: allocated 512 Interrupt
> Collections @1040948000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS [mem 0xc6000000-0xc601ffff]
> [    0.000000] ITS@0x00000000c6000000: Using ITS number 2
> [    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
> [    0.000000] ITS@0x00000000c6000000: allocated 524288 Devices
> @1041400000 (flat, esz 8, psz 16K, shr 1)
> [    0.000000] ITS@0x00000000c6000000: allocated 65536 Virtual CPUs
> @1040a80000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS@0x00000000c6000000: allocated 512 Interrupt
> Collections @104094c000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS [mem 0x8c6000000-0x8c601ffff]
> [    0.000000] ITS@0x00000008c6000000: Using ITS number 3
> [    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
> [    0.000000] ITS@0x00000008c6000000: allocated 524288 Devices
> @1041800000 (flat, esz 8, psz 16K, shr 1)
> [    0.000000] ITS@0x00000008c6000000: allocated 65536 Virtual CPUs
> @1040b80000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS@0x00000008c6000000: allocated 512 Interrupt
> Collections @1040b02000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS [mem 0x4004c000000-0x4004c01ffff]
> [    0.000000] ITS@0x000004004c000000: Using ITS number 4
> [    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
> [    0.000000] ITS@0x000004004c000000: allocated 524288 Devices
> @41000400000 (flat, esz 8, psz 16K, shr 1)
> [    0.000000] ITS@0x000004004c000000: allocated 65536 Virtual CPUs
> @41000080000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS@0x000004004c000000: allocated 512 Interrupt
> Collections @41000002000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS [mem 0x4006c000000-0x4006c01ffff]
> [    0.000000] ITS@0x000004006c000000: Using ITS number 5
> [    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
> [    0.000000] ITS@0x000004006c000000: allocated 524288 Devices
> @41000800000 (flat, esz 8, psz 16K, shr 1)
> [    0.000000] ITS@0x000004006c000000: allocated 65536 Virtual CPUs
> @41000100000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS@0x000004006c000000: allocated 512 Interrupt
> Collections @41000003000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS [mem 0x400c6000000-0x400c601ffff]
> [    0.000000] ITS@0x00000400c6000000: Using ITS number 6
> [    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
> [    0.000000] ITS@0x00000400c6000000: allocated 524288 Devices
> @41000c00000 (flat, esz 8, psz 16K, shr 1)
> [    0.000000] ITS@0x00000400c6000000: allocated 65536 Virtual CPUs
> @41000180000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS@0x00000400c6000000: allocated 512 Interrupt
> Collections @41000004000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS [mem 0x408c6000000-0x408c601ffff]
> [    0.000000] ITS@0x00000408c6000000: Using ITS number 7
> [    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
> [    0.000000] ITS@0x00000408c6000000: allocated 524288 Devices
> @41001000000 (flat, esz 8, psz 16K, shr 1)
> [    0.000000] ITS@0x00000408c6000000: allocated 65536 Virtual CPUs
> @41000200000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS@0x00000408c6000000: allocated 512 Interrupt
> Collections @41000005000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] GICv3: using LPI property table @0x0000001040b30000
> [    0.000000] ITS: Using DirectLPI for VPE invalidation
> [    0.000000] ITS: Enabling GICv4 support
> [    0.000000] GICv3: CPU0: using allocated LPI pending table
> @0x0000001040b40000
> [    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on
> contention.
> [    0.000000] arch_timer: Enabling global workaround for HiSilicon
> erratum 161010101
> [    0.000000] arch_timer: CPU0: Trapping CNTVCT access
> [    0.000000] arch_timer: cp15 timer(s) running at 50.00MHz (phys).
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
> max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
> [    0.000000] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps
> every 4398046511100ns
> [    0.008461] Console: colour dummy device 80x25
> [    0.013149] mempolicy: Enabling automatic NUMA balancing. Configure
> with numa_balancing= or the kernel.numa_balancing sysctl
> [    0.024448] ACPI: Core revision 20220331
> [    0.028589] ACPI BIOS Warning (bug): Incorrect checksum in table
> [DSDT] - 0x71, should be 0x6F (20220331/tbprint-174)
> [    0.039608] Calibrating delay loop (skipped), value calculated using
> timer frequency.. 100.00 BogoMIPS (lpj=200000)
> [    0.050111] pid_max: default: 65536 minimum: 512
> [    0.054952] LSM: Security Framework initializing
> [    0.100483] Dentry cache hash table entries: 8388608 (order: 14,
> 67108864 bytes, vmalloc)
> [    0.129259] Inode-cache hash table entries: 4194304 (order: 13,
> 33554432 bytes, vmalloc)
> [    0.138063] Mount-cache hash table entries: 131072 (order: 8, 1048576
> bytes, vmalloc)
> [    0.146500] Mountpoint-cache hash table entries: 131072 (order: 8,
> 1048576 bytes, vmalloc)
> [    0.161470] cblist_init_generic: Setting adjustable number of
> callback queues.
> [    0.168854] cblist_init_generic: Setting shift to 6 and lim to 1.
> [    0.175153] cblist_init_generic: Setting shift to 6 and lim to 1.
> [    0.181622] rcu: Hierarchical SRCU implementation.
> [    0.181705] printk: bootconsole [pl11] printing thread started
> [    0.192581] Platform MSI: ITS@0x4c000000 domain created
> [    0.192594] Platform MSI: ITS@0x6c000000 domain created
> [    0.192605] Platform MSI: ITS@0xc6000000 domain created
> [    0.192615] Platform MSI: ITS@0x8c6000000 domain created
> [    0.192626] Platform MSI: ITS@0x4004c000000 domain created
> [    0.192636] Platform MSI: ITS@0x4006c000000 domain created
> [    0.192646] Platform MSI: ITS@0x400c6000000 domain created
> [    0.192656] Platform MSI: ITS@0x408c6000000 domain created
> [    0.192694] PCI/MSI: ITS@0x4c000000 domain created
> [    0.192706] PCI/MSI: ITS@0x6c000000 domain created
> [    0.192716] PCI/MSI: ITS@0xc6000000 domain created
> [    0.192726] PCI/MSI: ITS@0x8c6000000 domain created
> [    0.192737] PCI/MSI: ITS@0x4004c000000 domain created
> [    0.192747] PCI/MSI: ITS@0x4006c000000 domain created
> [    0.192757] PCI/MSI: ITS@0x400c6000000 domain created
> [    0.192766] PCI/MSI: ITS@0x408c6000000 domain created
> [    0.192790] fsl-mc MSI: ITS@0x4c000000 domain created
> [    0.192802] fsl-mc MSI: ITS@0x6c000000 domain created
> [    0.192812] fsl-mc MSI: ITS@0xc6000000 domain created
> [    0.192823] fsl-mc MSI: ITS@0x8c6000000 domain created
> [    0.192833] fsl-mc MSI: ITS@0x4004c000000 domain created
> [    0.192843] fsl-mc MSI: ITS@0x4006c000000 domain created
> [    0.192853] fsl-mc MSI: ITS@0x400c6000000 domain created
> [    0.192870] fsl-mc MSI: ITS@0x408c6000000 domain created
> [    0.192905] Remapping and enabling EFI services.
> [    0.198810] smp: Bringing up secondary CPUs ...
> [    0.336515] Detected PIPT I-cache on CPU1
> [    0.336546] GICv3: CPU1: found redistributor 10001 region
> 1:0x000000004d140000
> [    0.336557] GICv3: CPU1: using allocated LPI pending table
> @0x0000001040b50000
> [    0.336727] arch_timer: CPU1: Trapping CNTVCT access
> [    0.336737] CPU1: Booted secondary processor 0x0000010001 [0x410fd082]
> [    0.339648] Detected PIPT I-cache on CPU2
> [    0.339668] GICv3: CPU2: found redistributor 10002 region
> 2:0x000000004d180000
> [    0.339677] GICv3: CPU2: using allocated LPI pending table
> @0x0000001040b60000
> [    0.339822] arch_timer: CPU2: Trapping CNTVCT access
> [    0.339830] CPU2: Booted secondary processor 0x0000010002 [0x410fd082]
> [    0.342714] Detected PIPT I-cache on CPU3
> [    0.342733] GICv3: CPU3: found redistributor 10003 region
> 3:0x000000004d1c0000
> [    0.342742] GICv3: CPU3: using allocated LPI pending table
> @0x0000001040b70000
> [    0.342886] arch_timer: CPU3: Trapping CNTVCT access
> [    0.342894] CPU3: Booted secondary processor 0x0000010003 [0x410fd082]
> [    0.433801] Detected PIPT I-cache on CPU4
> [    0.433823] GICv3: CPU4: found redistributor 10100 region
> 4:0x000000004d200000
> [    0.433832] GICv3: CPU4: using allocated LPI pending table
> @0x0000001041c00000
> [    0.433977] arch_timer: CPU4: Trapping CNTVCT access
> [    0.433985] CPU4: Booted secondary processor 0x0000010100 [0x410fd082]
> [    0.436878] Detected PIPT I-cache on CPU5
> [    0.436898] GICv3: CPU5: found redistributor 10101 region
> 5:0x000000004d240000
> [    0.436906] GICv3: CPU5: using allocated LPI pending table
> @0x0000001041c10000
> [    0.437049] arch_timer: CPU5: Trapping CNTVCT access
> [    0.437056] CPU5: Booted secondary processor 0x0000010101 [0x410fd082]
> [    0.439950] Detected PIPT I-cache on CPU6
> [    0.439971] GICv3: CPU6: found redistributor 10102 region
> 6:0x000000004d280000
> [    0.439979] GICv3: CPU6: using allocated LPI pending table
> @0x0000001041c20000
> [    0.440124] arch_timer: CPU6: Trapping CNTVCT access
> [    0.440131] CPU6: Booted secondary processor 0x0000010102 [0x410fd082]
> [    0.531074] Detected PIPT I-cache on CPU7
> [    0.531094] GICv3: CPU7: found redistributor 10103 region
> 7:0x000000004d2c0000
> [    0.531103] GICv3: CPU7: using allocated LPI pending table
> @0x0000001041c30000
> [    0.531246] arch_timer: CPU7: Trapping CNTVCT access
> [    0.531254] CPU7: Booted secondary processor 0x0000010103 [0x410fd082]
> [    0.534135] Detected PIPT I-cache on CPU8
> [    0.534159] GICv3: CPU8: found redistributor 10200 region
> 8:0x000000004d300000
> [    0.534169] GICv3: CPU8: using allocated LPI pending table
> @0x0000001041c40000
> [    0.534315] arch_timer: CPU8: Trapping CNTVCT access
> [    0.534323] CPU8: Booted secondary processor 0x0000010200 [0x410fd082]
> [    0.537197] Detected PIPT I-cache on CPU9
> [    0.537217] GICv3: CPU9: found redistributor 10201 region
> 9:0x000000004d340000
> [    0.537228] GICv3: CPU9: using allocated LPI pending table
> @0x0000001041c50000
> [    0.537372] arch_timer: CPU9: Trapping CNTVCT access
> [    0.537379] CPU9: Booted secondary processor 0x0000010201 [0x410fd082]
> [    0.628360] Detected PIPT I-cache on CPU10
> [    0.628382] GICv3: CPU10: found redistributor 10202 region
> 10:0x000000004d380000
> [    0.628392] GICv3: CPU10: using allocated LPI pending table
> @0x0000001041c60000
> [    0.628535] arch_timer: CPU10: Trapping CNTVCT access
> [    0.628542] CPU10: Booted secondary processor 0x0000010202 [0x410fd082]
> [    0.631423] Detected PIPT I-cache on CPU11
> [    0.631446] GICv3: CPU11: found redistributor 10203 region
> 11:0x000000004d3c0000
> [    0.631455] GICv3: CPU11: using allocated LPI pending table
> @0x0000001041c70000
> [    0.631598] arch_timer: CPU11: Trapping CNTVCT access
> [    0.631605] CPU11: Booted secondary processor 0x0000010203 [0x410fd082]
> [    0.634489] Detected PIPT I-cache on CPU12
> [    0.634515] GICv3: CPU12: found redistributor 10300 region
> 12:0x000000004d400000
> [    0.634525] GICv3: CPU12: using allocated LPI pending table
> @0x0000001041c80000
> [    0.634671] arch_timer: CPU12: Trapping CNTVCT access
> [    0.634680] CPU12: Booted secondary processor 0x0000010300 [0x410fd082]
> [    0.727239] Detected PIPT I-cache on CPU13
> [    0.727262] GICv3: CPU13: found redistributor 10301 region
> 13:0x000000004d440000
> [    0.727272] GICv3: CPU13: using allocated LPI pending table
> @0x0000001041c90000
> [    0.727415] arch_timer: CPU13: Trapping CNTVCT access
> [    0.727422] CPU13: Booted secondary processor 0x0000010301 [0x410fd082]
> [    0.730305] Detected PIPT I-cache on CPU14
> [    0.730329] GICv3: CPU14: found redistributor 10302 region
> 14:0x000000004d480000
> [    0.730338] GICv3: CPU14: using allocated LPI pending table
> @0x0000001041ca0000
> [    0.730482] arch_timer: CPU14: Trapping CNTVCT access
> [    0.730489] CPU14: Booted secondary processor 0x0000010302 [0x410fd082]
> [    0.733378] Detected PIPT I-cache on CPU15
> [    0.733402] GICv3: CPU15: found redistributor 10303 region
> 15:0x000000004d4c0000
> [    0.733412] GICv3: CPU15: using allocated LPI pending table
> @0x0000001041cb0000
> [    0.733555] arch_timer: CPU15: Trapping CNTVCT access
> [    0.733563] CPU15: Booted secondary processor 0x0000010303 [0x410fd082]
> [    0.826066] Detected PIPT I-cache on CPU16
> [    0.826097] GICv3: CPU16: found redistributor 30000 region
> 16:0x000000006d100000
> [    0.826110] GICv3: CPU16: using allocated LPI pending table
> @0x0000001041cc0000
> [    0.826305] arch_timer: CPU16: Trapping CNTVCT access
> [    0.826315] CPU16: Booted secondary processor 0x0000030000 [0x410fd082]
> [    0.829383] Detected PIPT I-cache on CPU17
> [    0.829407] GICv3: CPU17: found redistributor 30001 region
> 17:0x000000006d140000
> [    0.829419] GICv3: CPU17: using allocated LPI pending table
> @0x0000001041cd0000
> [    0.829609] arch_timer: CPU17: Trapping CNTVCT access
> [    0.829616] CPU17: Booted secondary processor 0x0000030001 [0x410fd082]
> [    0.832528] Detected PIPT I-cache on CPU18
> [    0.832553] GICv3: CPU18: found redistributor 30002 region
> 18:0x000000006d180000
> [    0.832563] GICv3: CPU18: using allocated LPI pending table
> @0x0000001041ce0000
> [    0.832751] arch_timer: CPU18: Trapping CNTVCT access
> [    0.832758] CPU18: Booted secondary processor 0x0000030002 [0x410fd082]
> [    0.924992] Detected PIPT I-cache on CPU19
> [    0.925017] GICv3: CPU19: found redistributor 30003 region
> 19:0x000000006d1c0000
> [    0.925028] GICv3: CPU19: using allocated LPI pending table
> @0x0000001041cf0000
> [    0.925217] arch_timer: CPU19: Trapping CNTVCT access
> [    0.925225] CPU19: Booted secondary processor 0x0000030003 [0x410fd082]
> [    0.928077] Detected PIPT I-cache on CPU20
> [    0.928110] GICv3: CPU20: found redistributor 30100 region
> 20:0x000000006d200000
> [    0.928123] GICv3: CPU20: using allocated LPI pending table
> @0x0000001041d00000
> [    0.928317] arch_timer: CPU20: Trapping CNTVCT access
> [    0.928327] CPU20: Booted secondary processor 0x0000030100 [0x410fd082]
> [    0.931234] Detected PIPT I-cache on CPU21
> [    0.931259] GICv3: CPU21: found redistributor 30101 region
> 21:0x000000006d240000
> [    0.931270] GICv3: CPU21: using allocated LPI pending table
> @0x0000001041d10000
> [    0.931458] arch_timer: CPU21: Trapping CNTVCT access
> [    0.931465] CPU21: Booted secondary processor 0x0000030101 [0x410fd082]
> [    1.023864] Detected PIPT I-cache on CPU22
> [    1.023891] GICv3: CPU22: found redistributor 30102 region
> 22:0x000000006d280000
> [    1.023903] GICv3: CPU22: using allocated LPI pending table
> @0x0000001041d20000
> [    1.024093] arch_timer: CPU22: Trapping CNTVCT access
> [    1.024100] CPU22: Booted secondary processor 0x0000030102 [0x410fd082]
> [    1.026994] Detected PIPT I-cache on CPU23
> [    1.027020] GICv3: CPU23: found redistributor 30103 region
> 23:0x000000006d2c0000
> [    1.027032] GICv3: CPU23: using allocated LPI pending table
> @0x0000001041d30000
> [    1.027220] arch_timer: CPU23: Trapping CNTVCT access
> [    1.027229] CPU23: Booted secondary processor 0x0000030103 [0x410fd082]
> [    1.030116] Detected PIPT I-cache on CPU24
> [    1.030150] GICv3: CPU24: found redistributor 30200 region
> 24:0x000000006d300000
> [    1.030164] GICv3: CPU24: using allocated LPI pending table
> @0x0000001041d40000
> [    1.030358] arch_timer: CPU24: Trapping CNTVCT access
> [    1.030368] CPU24: Booted secondary processor 0x0000030200 [0x410fd082]
> [    1.122763] Detected PIPT I-cache on CPU25
> [    1.122790] GICv3: CPU25: found redistributor 30201 region
> 25:0x000000006d340000
> [    1.122803] GICv3: CPU25: using allocated LPI pending table
> @0x0000001041d50000
> [    1.122994] arch_timer: CPU25: Trapping CNTVCT access
> [    1.123001] CPU25: Booted secondary processor 0x0000030201 [0x410fd082]
> [    1.125894] Detected PIPT I-cache on CPU26
> [    1.125922] GICv3: CPU26: found redistributor 30202 region
> 26:0x000000006d380000
> [    1.125934] GICv3: CPU26: using allocated LPI pending table
> @0x0000001041d60000
> [    1.126125] arch_timer: CPU26: Trapping CNTVCT access
> [    1.126133] CPU26: Booted secondary processor 0x0000030202 [0x410fd082]
> [    1.129044] Detected PIPT I-cache on CPU27
> [    1.129071] GICv3: CPU27: found redistributor 30203 region
> 27:0x000000006d3c0000
> [    1.129084] GICv3: CPU27: using allocated LPI pending table
> @0x0000001041d70000
> [    1.129274] arch_timer: CPU27: Trapping CNTVCT access
> [    1.129281] CPU27: Booted secondary processor 0x0000030203 [0x410fd082]
> [    1.221655] Detected PIPT I-cache on CPU28
> [    1.221692] GICv3: CPU28: found redistributor 30300 region
> 28:0x000000006d400000
> [    1.221706] GICv3: CPU28: using allocated LPI pending table
> @0x0000001041d80000
> [    1.221903] arch_timer: CPU28: Trapping CNTVCT access
> [    1.221912] CPU28: Booted secondary processor 0x0000030300 [0x410fd082]
> [    1.224836] Detected PIPT I-cache on CPU29
> [    1.224864] GICv3: CPU29: found redistributor 30301 region
> 29:0x000000006d440000
> [    1.224876] GICv3: CPU29: using allocated LPI pending table
> @0x0000001041d90000
> [    1.225065] arch_timer: CPU29: Trapping CNTVCT access
> [    1.225072] CPU29: Booted secondary processor 0x0000030301 [0x410fd082]
> [    1.227938] Detected PIPT I-cache on CPU30
> [    1.227967] GICv3: CPU30: found redistributor 30302 region
> 30:0x000000006d480000
> [    1.227980] GICv3: CPU30: using allocated LPI pending table
> @0x0000001041da0000
> [    1.228166] arch_timer: CPU30: Trapping CNTVCT access
> [    1.228173] CPU30: Booted secondary processor 0x0000030302 [0x410fd082]
> [    1.320553] Detected PIPT I-cache on CPU31
> [    1.320583] GICv3: CPU31: found redistributor 30303 region
> 31:0x000000006d4c0000
> [    1.320596] GICv3: CPU31: using allocated LPI pending table
> @0x0000001041db0000
> [    1.320783] arch_timer: CPU31: Trapping CNTVCT access
> [    1.320791] CPU31: Booted secondary processor 0x0000030303 [0x410fd082]
> [    1.323864] Detected PIPT I-cache on CPU32
> [    1.323952] GICv3: CPU32: found redistributor 50000 region
> 32:0x000004004d100000
> [    1.323983] GICv3: CPU32: using allocated LPI pending table
> @0x0000001041dc0000
> [    1.324186] arch_timer: CPU32: Trapping CNTVCT access
> [    1.324202] CPU32: Booted secondary processor 0x0000050000 [0x410fd082]
> [   23.606244] rcu: INFO: rcu_preempt detected expedited stalls on
> CPUs/tasks: { 31-... } 5564 jiffies s: 13 root: 0x2/.
> [   23.606266] rcu: blocking rcu_node structures (internal RCU debug):
> l=1:16-31:0x8000/.
> [   23.606278] Task dump for CPU 31:
> [   23.606284] task:swapper/31      state:R  running task     stack:
> 0 pid:    0 ppid:     1 flags:0x00000008
> [   23.606296] Call trace:
> [   23.606299]  __switch_to+0x128/0x1d0
> [   23.606324]  0xffffe082da7fc3bd
> [   87.165491] rcu: INFO: rcu_preempt detected expedited stalls on
> CPUs/tasks: { 31-... } 21436 jiffies s: 13 root: 0x2/.
> [   87.165507] rcu: blocking rcu_node structures (internal RCU debug):
> l=1:16-31:0x8000/.
> [   87.165518] Task dump for CPU 31:
> [   87.165522] task:swapper/31      state:R  running task     stack:
> 0 pid:    0 ppid:     1 flags:0x00000008
> [   87.165531] Call trace:
> [   87.165533]  __switch_to+0x128/0x1d0
> [   87.165541]  0xffffe082da7fc3bd
> [  150.728684] rcu: INFO: rcu_preempt detected expedited stalls on
> CPUs/tasks: { 31-... } 37308 jiffies s: 13 root: 0x2/.
> [  150.728700] rcu: blocking rcu_node structures (internal RCU debug):
> l=1:16-31:0x8000/.
> [  150.728710] Task dump for CPU 31:
> [  150.728713] task:swapper/31      state:R  running task     stack:
> 0 pid:    0 ppid:     1 flags:0x00000008
> [  150.728722] Call trace:
> [  150.728724]  __switch_to+0x128/0x1d0
> [  150.728732]  0xffffe082da7fc3bd
>
>
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -983,7 +983,14 @@ CONFIG_K3_DMA=y
>   CONFIG_MV_XOR=y
>   CONFIG_MV_XOR_V2=y
>   CONFIG_OWL_DMA=y
> +CONFIG_KASAN=y
> +CONFIG_DEBUG_LIST=y
> +CONFIG_DEBUG_PLIST=y
> +CONFIG_DEBUG_MUTEXES=y
> +CONFIG_DEBUG_SG=y
> +CONFIG_DEBUG_ATOMIC_SLEEP=y
>   CONFIG_PL330_DMA=y
> +CONFIG_DEBUG_SPINLOCK=y
>   CONFIG_TEGRA186_GPC_DMA=m
>
> thanks,
> John
>
> >
> >> Both timeout values can also be read/modified at runtime at:
> >> /sys/module/rcupdate/parameters/rcu_cpu_stall_timeout
> >> /sys/module/rcupdate/parameters/rcu_exp_cpu_stall_timeout
> >>
> >> Regards,
> >> Pierre
> >>
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > .
>

