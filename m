Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408214E2C90
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350476AbiCUPog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350445AbiCUPoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:44:24 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E70F05EBC6;
        Mon, 21 Mar 2022 08:42:56 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.90,198,1643641200"; 
   d="scan'208";a="114269400"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Mar 2022 00:42:56 +0900
Received: from vb.home (unknown [10.226.92.216])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id A5E004007539;
        Tue, 22 Mar 2022 00:42:52 +0900 (JST)
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/14] Add new Renesas RZ/V2M SoC and Renesas RZ/V2M EVK support
Date:   Mon, 21 Mar 2022 15:42:18 +0000
Message-Id: <20220321154232.56315-1-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

RZ/V2M has a dual-core Cortex-A53 (1.0 GHz) CPU and built-in AI
accelerator "DRP-AI" for vision, which is Renesas' original technology.
It also has a 32-bit LPDDR4 interface and video codec (H.264).

The RZ/V2M is used with ISP firmware that runs on one of the Cortex-A53
cores. The firmware is an integral part of the SoC such that the HW
User's Manual documents which of the peripheral modules are used by the
firmware.

Initial patches enables minimal peripherals on Renesas RZ/V2M EVK board
and booted via nfs. Ethernet is broadly compatible with the
etheravb-rcar-gen3 driver, but interrupts need some work so it's not
been included in this patch set.

Below blocks are enabled on Renesas RZ/V2M EVK board:
- memory
- External input clock
- CPG
- UART

Links for SoC and EVK:
[*] https://www.renesas.com/us/en/products/microcontrollers-microprocessors/rz-cortex-a-mpus/rzv2m-dual-cortex-a53-lpddr4x32bit-ai-accelerator-isp-4k-video-codec-4k-camera-input-fhd-display-output


Sorry for cross posting the patches to multiple subsystems, as these are
just the dt-binding patches included as part of initial bringup patches.

Test logs on Renesas RZ/V2M EVK:

/ # cat /proc/cpuinfo
processor       : 0
BogoMIPS        : 48.00
Features        : fp asimd evtstrm crc32 cpuid
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x0
CPU part        : 0xd03
CPU revision    : 4

/ # cat /proc/meminfo
MemTotal:        2617088 kB
MemFree:         2560788 kB
MemAvailable:    2495544 kB
Buffers:               0 kB
Cached:            24840 kB
SwapCached:            0 kB
Active:             7988 kB
Inactive:          23420 kB
Active(anon):        244 kB
Inactive(anon):    14816 kB
Active(file):       7744 kB
Inactive(file):     8604 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                 0 kB
Writeback:             0 kB
AnonPages:          6568 kB
Mapped:             9924 kB
Shmem:              8492 kB
KReclaimable:       4244 kB
Slab:              11768 kB
SReclaimable:       4244 kB
SUnreclaim:         7524 kB
KernelStack:         908 kB
PageTables:          620 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:     1308544 kB
Committed_AS:      24500 kB
VmallocTotal:   133143592960 kB
VmallocUsed:        1208 kB
VmallocChunk:          0 kB
Percpu:              124 kB
HardwareCorrupted:     0 kB
AnonHugePages:         0 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
FileHugePages:         0 kB
FilePmdMapped:         0 kB
CmaTotal:          32768 kB
CmaFree:           31208 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
Hugetlb:               0 kB
/ #
/ # cat /proc/interrupts
           CPU0
 11:       3394     GICv2  30 Level     arch_timer
 14:       4644     GICv2 283 Level     eth0:ch0:rx_be
 15:          0     GICv2 284 Level     eth0:ch1:rx_nc
 32:       6706     GICv2 301 Level     eth0:ch18:tx_be
 33:          0     GICv2 302 Level     eth0:ch19:tx_nc
 36:          0     GICv2 305 Level     eth0:ch22:multi
 38:          0     GICv2 309 Level     eth0:ch24:emac
 43:        402     GICv2 272 Level     ttyS0
IPI0:         0       Rescheduling interrupts
IPI1:         0       Function call interrupts
IPI2:         0       CPU stop interrupts
IPI3:         0       CPU stop (for crash dump) interrupts
IPI4:         0       Timer broadcast interrupts
IPI5:         0       IRQ work interrupts
IPI6:         0       CPU wake-up interrupts
Err:          0
/ #
/ # for i in machine family soc_id revision; do echo -n "$i: ";cat /sys/devices/soc0/$i; done
machine: RZ/V2M Evaluation Kit 2.0
family: RZ/V2M
soc_id: r9a09g011
revision: 1.0

Thanks
Phil
