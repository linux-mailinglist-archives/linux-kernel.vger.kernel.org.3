Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FD0577F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbiGRKD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbiGRKDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:03:50 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70053.outbound.protection.outlook.com [40.107.7.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ACD1AF23
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:03:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKFhig2xISkddlYEyQnIyTPIZT87GeafO2EE/iAbUZ57kodriJGr4TpX5ONRo9HhfHY0VK70NW4VhT12V0iN2RiHYikSjMZhs09GD8H3YZ84amriVGd0e8RchIekbbk3cB0YaNOPIilPv10OIkfAHUB4j8vDf2xgML8mGvJ+agVCSN+5vjwunP/dYEZwU1+l85ztf1Quo1z7uo335Pru3cAqpLMngSM9Qoqf31Vc6CH0QlxOtW+2oRCYnuE8Y9Xb7XZ02b996DtWsJ7uVQy5Ghfbk961hUMAxbOfVvFY/eMmRJTKanbvZhAW5XO7spkiYICo6ieoFpBIL/xBwO+v/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvVIgoGVzvlchpMYy66g+s06AhlgGhxG0LX/Ik526tE=;
 b=OEU980AL7HXgCy5yS2knvS9UMQECRTWSG8+8sKGG8TWXOuXboIYZB0iIO2UUSjXCO51XD1nHoNaXvWtLhiAR1BypdMkfgU0McrvTC4PrGSs0SL8AIZH1dNFrWbtg3QN2ck5J80eabiVPnarTvoNqfvQwqaIIyO6f3QOIKWHjd/rO2Jd61kDxQY3c3dgTT+A3PLuE7t0WKN8iI6vhgYNO2TxhMgsyAewfa5HlK+IwU4zQCVfUGVMLCkwY+Je7XNBtQGHRFIsXFGg2yutKZZMmVwgzK0opEctWzVoGeIgEwpU3VnaqBf3/l+kzEAFvLWbGFaEFGz2M4FJLuET99WIFqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvVIgoGVzvlchpMYy66g+s06AhlgGhxG0LX/Ik526tE=;
 b=UfiAHOxwNkOTOdTIgffRLPlNbamX7WIJI70510xz3wKvXpbq/QCF1h8rZ6TyV1nsyJJLg0KP1U0adlRprP/jwM0waXifNCyRkH3zrpqBx4Y1Lu4cfGrufIu9/NnjX+9roT21A+HlzWBKqWstFHKaWILcj5AvFTAM7P/6kgBK+byQu4Tw550V3atJFd58qfE1BfZUG3qt0lT79nIjnQo4SI7cd3OgzaYi1hVSDpoyPZJoQ0zIvVGqpDr979CtfrH10iQCl4s0N+yeI8NGEv2UpzjiXMFj4b0tPEZwRMk483LDgLD+kWGT+7pOWAIUv4Bm3BENUD3dyOcsQSr+YIgmEA==
Received: from DU2PR04CA0286.eurprd04.prod.outlook.com (2603:10a6:10:28c::21)
 by PAXPR10MB4914.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:1dd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Mon, 18 Jul
 2022 10:03:41 +0000
Received: from DB5EUR01FT009.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:28c:cafe::8a) by DU2PR04CA0286.outlook.office365.com
 (2603:10a6:10:28c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Mon, 18 Jul 2022 10:03:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.70) by
 DB5EUR01FT009.mail.protection.outlook.com (10.152.4.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.12 via Frontend Transport; Mon, 18 Jul 2022 10:03:41 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 18 Jul 2022 12:03:40 +0200
Received: from [139.21.19.101] (139.21.19.101) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 18 Jul 2022 12:03:40 +0200
Message-ID: <0b603833-91f0-5639-e5c7-23520816946e@siemens.com>
Date:   Mon, 18 Jul 2022 12:03:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: [5.19 regression?] refcount warning around am33xx_dt_clk_init
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.19.101]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.020800-8.000000
X-TMASE-MatchedRID: 0kLV3aAHAuyey/wE78gqlwpC30jpvcN7dG85O8jOm1QnEamhyVW/p2pg
        zIYzEnZ5IlxOowKJvsU2a+Gsjn5GktTU7rx0lPTWA/YE0wOW9A9Mi6dAAjypotDKIRviENrHWuF
        m7TqL4eEQjsHZD9zVXvgchX6FL+O18qcX36bX9F+k/RBGrIypaZFu/pS/kmAgsjFnB5RHQ18s9I
        m7mOi/ZoTGTpzirPHyKKqyc9Qq8XpV0LFyqn+Hh/XNFuYNy+Xh4FxFcSgJ5i3lvSeYSYEULGDm3
        C/FJwHxpCBLOCbP1J1VofWkWPhrtSL8ziykyhQriITDjXtQ2clKpIM6MfwkGkfhraIl1Xgx/OuU
        JVcMZhsJeMOJX8c9nEu9e4S/+fL24K9FmervsqWLTvzABOMGqina+PB+11hbJmbrB1j4XwpMVCc
        j56k8hgWqvFWg3Xg6o4isov7KdCTk5YFVuaXpqrqkUgJVwCOCJnvICBJx119uXgIqq6mQynfl7t
        b/uq3UmyiLZetSf8nJ4y0wP1A6ADVmQqp4ykTAVymkLM+r7VSQZS2ujCtcuA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.020800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 48C89321BBA38AEA82F9761A2B058F171B74C61704A334B4234123A3B5C089792000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e945bb7-b916-43ec-2932-08da68a4cae6
X-MS-TrafficTypeDiagnostic: PAXPR10MB4914:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: encvugytV5MbbkAwYb+MZWyukKcvswB2+qSZfw+Oe6irOi1RnJTNAfb4YeKEd8HCcyjKA0i+TdXUhPV2BGNqIG4+umegsRQFpXBncjwKC8oEOnvwrf51hd2MslpWiEe4g800frwzhOn8AJUDu208K1E/+B0xtD1FLIouR4GcbCXExOHTVoG3aqM1j+GWyjn+Oi1NKOY+DGPBSynJ+hOJYCN7SbIRGsydV2UtkKqyihOG1seRAYoVoZ0NO87vz5fKk19ykuCCZcWEqYkinbOt6/vXbKh6A1ZK4bfOrsfiPsvZMJgsvwcaJXVT5vQZNpMcHaG2iiqWqpDKhVJ6iygVK6GY1X8TnK3JW2ldrG8sj2Ph9LnQtYdeU8pLY6hM8ohMzPrCdHPAyO0qYW1ief5/PEHD5gOXfjYLaAnua1ypXP+8cmdnoTWBw/kGM1KAxsP1g0SdS7exeVdE34ml3rZYOiOdmHxFMOTAdROOgPZ/mGnphwC2luw7sT3E0J3Cn4foen55muKld7Rf57ASpbazC3ep1H8QyVPI8p7g2wTFIjucshVjzIaA6691WgHLjbvN6Y4jW9amFvy4wF7yx53VjqVHz2D/5m8XfkXqJU6qijpihmdYDdRwSFCvGZqCll7s6KMjao6NdMSDyhbMEtOPteor7JQJuTsXDr4G85GDZAOdk9QXxd6gUGuXym3VEoMv9MKwHbhuVbqR1b5YAbpCCxDoEuR9w63xWK/1aySxZOrs9sk39+TYEmb3Nssd3bP/Hwu6rxZ5SyG6JR2Hu4iP/7gf9clEMAtbE2q1KTE+kVw1JALgbMaxmIWINAMwrnHCg0Etz5wT+lrC3GfE40wXqdutwBnpl6+UG6PYvZyWSd2tPYKu3+xaSK+pVhfuqQih
X-Forefront-Antispam-Report: CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(346002)(396003)(40470700004)(36840700001)(46966006)(5660300002)(44832011)(8936002)(70586007)(8676002)(70206006)(40460700003)(4326008)(82310400005)(40480700001)(956004)(36860700001)(2906002)(356005)(316002)(82960400001)(7596003)(36756003)(7636003)(82740400003)(31696002)(31686004)(86362001)(478600001)(16576012)(41300700001)(6916009)(6706004)(45080400002)(47076005)(83380400001)(336012)(26005)(186003)(16526019)(2616005)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 10:03:41.3644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e945bb7-b916-43ec-2932-08da68a4cae6
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT009.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4914
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

am I the only one getting this with 5.19-rc on a BeagleBoneBlack?

2022-07-18T09:32:52 [    0.000000] Booting Linux on physical CPU 0x0
2022-07-18T09:32:52 [    0.000000] Linux version 5.19.0-rc7 (builder@runner-zhxxpox-project-479-concurrent-1gm4mk) (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #1 SMP Mon Jul 18 05:54:15 UTC 2022
2022-07-18T09:32:52 [    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c5387d
2022-07-18T09:32:52 start: 2.4.4.1 login-action (timeout 00:04:12) [common]
2022-07-18T09:32:52 Setting prompt string to ['-+\\[ cut here \\]-+\\s+(.*\\s+-+\\[ end trace (\\w*) \\]-+)', '(Unhandled fault.*)\\r\\n', 'Kernel panic - (.*) end Kernel panic', 'Stack:\\s+(.*\\s+-+\\[ end trace (\\w*) \\]-+)']
2022-07-18T09:32:52 Using line separator: #'\n'#
2022-07-18T09:32:52 Waiting for the login prompt
2022-07-18T09:32:52 Parsing kernel messages
2022-07-18T09:32:52 ['-+\\[ cut here \\]-+\\s+(.*\\s+-+\\[ end trace (\\w*) \\]-+)', '(Unhandled fault.*)\\r\\n', 'Kernel panic - (.*) end Kernel panic', 'Stack:\\s+(.*\\s+-+\\[ end trace (\\w*) \\]-+)', 'root@demo:', 'demo login:', 'Login incorrect']
2022-07-18T09:32:52 [login-action] Waiting for messages, (timeout 00:04:12)
2022-07-18T09:32:52 [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
2022-07-18T09:32:52 [    0.000000] OF: fdt: Machine model: TI AM335x BeagleBone Black
2022-07-18T09:32:52 [    0.000000] Memory policy: Data cache writeback
2022-07-18T09:32:52 [    0.000000] efi: UEFI not found.
2022-07-18T09:32:52 [    0.000000] cma: Reserved 64 MiB at 0x9b800000
2022-07-18T09:32:52 [    0.000000] Zone ranges:
2022-07-18T09:32:52 [    0.000000]   DMA      [mem 0x0000000080000000-0x000000009fdfffff]
2022-07-18T09:32:52 [    0.000000]   Normal   empty
2022-07-18T09:32:52 [    0.000000]   HighMem  empty
2022-07-18T09:32:52 [    0.000000] Movable zone start for each node
2022-07-18T09:32:52 [    0.000000] Early memory node ranges
2022-07-18T09:32:52 [    0.000000]   node   0: [mem 0x0000000080000000-0x000000009fdfffff]
2022-07-18T09:32:52 [    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x000000009fdfffff]
2022-07-18T09:32:52 [    0.000000] CPU: All CPU(s) started in SVC mode.
2022-07-18T09:32:52 [    0.000000] AM335X ES2.1 (sgx neon)
2022-07-18T09:32:52 [    0.000000] percpu: Embedded 16 pages/cpu s34260 r8192 d23084 u65536
2022-07-18T09:32:52 [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 129540
2022-07-18T09:32:52 [    0.000000] Kernel command line: console=ttyO0,115200n8 root=/dev/nfs rw nfsroot=192.168.42.90:/var/lib/lava/dispatcher/tmp/4597/extract-nfsrootfs-c7i3rn5w,tcp,hard,vers=3  ip=dhcp
2022-07-18T09:32:52 [    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
2022-07-18T09:32:52 [    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes, linear)
2022-07-18T09:32:52 [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
2022-07-18T09:32:52 [    0.000000] Memory: 425336K/522240K available (14336K kernel code, 2405K rwdata, 5892K rodata, 2048K init, 426K bss, 31368K reserved, 65536K cma-reserved, 0K highmem)
2022-07-18T09:32:52 [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
2022-07-18T09:32:52 [    0.000000] trace event string verifier disabled
2022-07-18T09:32:52 [    0.000000] rcu: Hierarchical RCU implementation.
2022-07-18T09:32:52 [    0.000000] rcu: 	RCU event tracing is enabled.
2022-07-18T09:32:52 [    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=1.
2022-07-18T09:32:52 [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
2022-07-18T09:32:52 [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
2022-07-18T09:32:52 [    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
2022-07-18T09:32:52 [    0.000000] IRQ: Found an INTC at 0x(ptrval) (revision 5.0) with 128 interrupts
2022-07-18T09:32:52 [    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
2022-07-18T09:32:52 [    0.000000] ------------[ cut here ]------------
2022-07-18T09:32:52 [    0.000000] WARNING: CPU: 0 PID: 0 at lib/refcount.c:25 kobject_get+0x9c/0xa0
2022-07-18T09:32:52 [    0.000000] refcount_t: addition on 0; use-after-free.
2022-07-18T09:32:52 [    0.000000] Modules linked in:
2022-07-18T09:32:52 [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc7 #1
2022-07-18T09:32:52 [    0.000000] Hardware name: Generic AM33XX (Flattened Device Tree)
2022-07-18T09:32:52 [    0.000000]  unwind_backtrace from show_stack+0x10/0x14
2022-07-18T09:32:52 [    0.000000]  show_stack from dump_stack_lvl+0x40/0x4c
2022-07-18T09:32:52 [    0.000000]  dump_stack_lvl from __warn+0xc8/0x13c
2022-07-18T09:32:52 [    0.000000]  __warn from warn_slowpath_fmt+0x78/0xa8
2022-07-18T09:32:52 [    0.000000]  warn_slowpath_fmt from kobject_get+0x9c/0xa0
2022-07-18T09:32:52 [    0.000000]  kobject_get from of_node_get+0x14/0x1c
2022-07-18T09:32:52 [    0.000000]  of_node_get from of_fwnode_get+0x34/0x40
2022-07-18T09:32:52 [    0.000000]  of_fwnode_get from fwnode_full_name_string+0x34/0xa0
2022-07-18T09:32:52 [    0.000000]  fwnode_full_name_string from device_node_string+0x604/0x6d0
2022-07-18T09:32:52 [    0.000000]  device_node_string from pointer+0x38c/0x5b0
2022-07-18T09:32:52 [    0.000000]  pointer from vsnprintf+0x230/0x3d4
2022-07-18T09:32:52 [    0.000000]  vsnprintf from vprintk_store+0x10c/0x3f8
2022-07-18T09:32:52 [    0.000000]  vprintk_store from vprintk_emit+0x70/0x23c
2022-07-18T09:32:52 [    0.000000]  vprintk_emit from vprintk_default+0x20/0x28
2022-07-18T09:32:52 [    0.000000]  vprintk_default from _printk+0x2c/0x5c
2022-07-18T09:32:52 [    0.000000]  _printk from of_node_release+0x11c/0x124
2022-07-18T09:32:52 [    0.000000]  of_node_release from kobject_put+0x98/0x104
2022-07-18T09:32:52 [    0.000000]  kobject_put from ti_dt_clocks_register+0x278/0x328
2022-07-18T09:32:52 [    0.000000]  ti_dt_clocks_register from am33xx_dt_clk_init+0x14/0xa4
2022-07-18T09:32:52 [    0.000000]  am33xx_dt_clk_init from omap_init_time_of+0x8/0x10
2022-07-18T09:32:52 [    0.000000]  omap_init_time_of from start_kernel+0x4f8/0x6b0
2022-07-18T09:32:52 [    0.000000]  start_kernel from 0x0
2022-07-18T09:32:52 [    0.000000] ---[ end trace 0000000000000000 ]---

It's with latest 5.19-rc7, using the multi_v7_defconfig.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
