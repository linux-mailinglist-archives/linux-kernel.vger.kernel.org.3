Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21A15B0BF4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiIGSA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiIGSAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:00:20 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7C98FD7F;
        Wed,  7 Sep 2022 11:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiQ2Cz+yfXYbpASfB6atodQhiBoXo/dFq+dgjDhv5zEN0dURQb/l0AlhZxIJ7kDV16uTwpbfhLirOJ+6Y2TrlvDKri6RBXuOg8IYjBNGOt60VyyDQcEMSnoFpZ//WT9ejj/uGtDYlvIidIiLnyHr2qCxswppcUcKbuXRfU1pgWFOi3QqJZ980Bu7IExhaPACbS4PUT+cuulnkHwy6jJjeoy1PDylg1qTGnBAijuMdjdBivDTmEcTnsK8GIa/5xPBDJb5P2Rc7USlXgVSF5BDZqucAL0MXJqP/lEm6GsRC1KeFGcWNgM912BQAsutMdFHsSSweFqDVpM6u4UfiIm66A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoFaaCgbXliXU5lZDOY7BTCiUSKSBWhcvmzWp0YVK/A=;
 b=ZGNyYac/sUlvb6O95rFI39xRxXlmbTgDA4rCZRkVeQC6/qGvYmvYc+/AIA4TxAXkB673uEaWxALMC7HZIYL0JFaQueHQ6BSJQiyED1FgiocK8Ov82X1Wb/CAIJ1fpe/GSIWgl7ZGwF3eBt2du/+kleuKW3XBnW2G932PfeRU8V/6cmAA8/gq6O2tsarKf6zc1hY50Tty361uctla5aHhFd1v4Ms5veDMgPDO7orGFCIvi293R6LjDVHkdg2qArJRXmXF0IpFLff9zvzL9aNsgcDUjDQAD/dsuGzkBS188/eFwuEGGEy43/T4DOa0IdlkIt9UeaJ6csNc/tse1M7acw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoFaaCgbXliXU5lZDOY7BTCiUSKSBWhcvmzWp0YVK/A=;
 b=MwNPuNUG5Et3sY8Q2mbKtE0hm6yPQEQt03qIL/MMy64SVyz3RW9ySeOxKvv8UJFEYvqT79wv/+ueoquDdZ5WIfo+WKsJEp1iA5AIZONmeidr2+nQDy6GKJWZxQsYM2W7G5XY0ntg/43zdIJEm4OLeDfQXJy8RSyRQrNfN8wNsMU=
Received: from BN9PR03CA0986.namprd03.prod.outlook.com (2603:10b6:408:109::31)
 by SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 18:00:11 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::ee) by BN9PR03CA0986.outlook.office365.com
 (2603:10b6:408:109::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14 via Frontend
 Transport; Wed, 7 Sep 2022 18:00:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:00:10 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:00:09 -0500
Subject: [PATCH v4 02/13] x86/resctrl: Remove arch_has_empty_bitmaps
From:   Babu Moger <babu.moger@amd.com>
To:     <corbet@lwn.net>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>, <babu.moger@amd.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>
Date:   Wed, 7 Sep 2022 13:00:03 -0500
Message-ID: <166257360370.1043018.10126722515228365580.stgit@bmoger-ubuntu>
In-Reply-To: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT041:EE_|SJ1PR12MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd31fa0-ca86-4df5-9934-08da90faceb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8otWSYaXlAYQWEtMvnHaAwW+URFyz4ZGCJ8NcY1dSHDQ/8rRtzf53IhtlYeUbKKbyXFclyhzjLMb5hVVe93i6S8YHMe3kuIQ/BF0126XG27oeNCD6f8PFEGZalTGxv+/ep6Ry68QjXBWFY08QoXzEeCYqdRsRdHFrQHE1505XXsEORRKZaB/fkV598/MbgVEWTMriF5lUXys1yRz+ctJIi9YE8RmC0QCnRtAy3Y7+y04WQUVQRrcuf4DNJrsjeMVAFqdFofhAsTMga7s5jG6WREVWV0icBz3LCXC+5mMEoOmUHXisqsbiAhrNAGTHD5HUb9OX5xOmubeJD0JwZzaP1oYN6Bt3PCE81FEz3VcwgBFLegJVVi5hdg0eE/lrNjKzsnxoLdrLj7hIycVT50R7CmhFKyIxvIH4wN70aMdY0nUJIaGSKGEhRnRyA8dEUQBkSiORCMnzj0RwKT4Y9ojeYnaM+rv1FZda9zi6zr/H5799CMmkvshQD6LX9D8uZv//cExBpI9WW2OGVpEMkzB3b0MkJ4s9LiTQe9NJolgLuALuVrVJvUKdQQ+NKoC0JSKAylmYRtgE/D6ZEI1sif8naimUJIKLB2nsO9G0wfZ2qalEVsKxHTOj0UdCIe+NrlesC5K7NgshELXA+0C7LaGQqS5rNo3PlLsmQn1p+THIKrtL9SwvGHswccgtzle3uKUOVyQWsKMqoMRfi1FONiwoXb7T6gFY6sqlJOOzpOOtcLzgjLtldCU0SrBAQLDbDxOLDsmXk2yxXbkVJnz3TxmLSHwS5HxMNySc5MEIGG5PIJTNrfKbuq+eWlDm5dotf7vXe5PRXMXpWq0TmKwNlRgCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(7916004)(396003)(376002)(346002)(39860400002)(136003)(36840700001)(46966006)(40470700004)(81166007)(110136005)(5660300002)(478600001)(82740400003)(44832011)(8676002)(70206006)(16576012)(70586007)(316002)(54906003)(2906002)(356005)(7416002)(8936002)(4326008)(426003)(47076005)(83380400001)(36860700001)(40480700001)(103116003)(16526019)(41300700001)(33716001)(186003)(9686003)(6666004)(26005)(336012)(82310400005)(40460700003)(86362001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:00:10.9862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd31fa0-ca86-4df5-9934-08da90faceb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field arch_has_empty_bitmaps is not required anymore. The field=0A=
min_cbm_bits is enough to validate the CBM (capacity bit mask) if the=0A=
architecture can support the zero CBM or not.=0A=
=0A=
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/core.c        |    2 --=0A=
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |    3 +--=0A=
 include/linux/resctrl.h                   |    6 +++---=0A=
 3 files changed, 4 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index a5c51a14fbce..c2657754672e 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -869,7 +869,6 @@ static __init void rdt_init_res_defs_intel(void)=0A=
 		if (r->rid =3D=3D RDT_RESOURCE_L3 ||=0A=
 		    r->rid =3D=3D RDT_RESOURCE_L2) {=0A=
 			r->cache.arch_has_sparse_bitmaps =3D false;=0A=
-			r->cache.arch_has_empty_bitmaps =3D false;=0A=
 			r->cache.arch_has_per_cpu_cfg =3D false;=0A=
 			r->cache.min_cbm_bits =3D 1;=0A=
 		} else if (r->rid =3D=3D RDT_RESOURCE_MBA) {=0A=
@@ -890,7 +889,6 @@ static __init void rdt_init_res_defs_amd(void)=0A=
 		if (r->rid =3D=3D RDT_RESOURCE_L3 ||=0A=
 		    r->rid =3D=3D RDT_RESOURCE_L2) {=0A=
 			r->cache.arch_has_sparse_bitmaps =3D true;=0A=
-			r->cache.arch_has_empty_bitmaps =3D true;=0A=
 			r->cache.arch_has_per_cpu_cfg =3D true;=0A=
 			r->cache.min_cbm_bits =3D 0;=0A=
 		} else if (r->rid =3D=3D RDT_RESOURCE_MBA) {=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cp=
u/resctrl/ctrlmondata.c=0A=
index 87666275eed9..7f38c8bd8429 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c=0A=
@@ -98,8 +98,7 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt=
_resource *r)=0A=
 		return false;=0A=
 	}=0A=
 =0A=
-	if ((!r->cache.arch_has_empty_bitmaps && val =3D=3D 0) ||=0A=
-	    val > r->default_ctrl) {=0A=
+	if ((r->cache.min_cbm_bits > 0 && val =3D=3D 0) || val > r->default_ctrl)=
 {=0A=
 		rdt_last_cmd_puts("Mask out of range\n");=0A=
 		return false;=0A=
 	}=0A=
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h=0A=
index 21deb5212bbd..46ed8589857c 100644=0A=
--- a/include/linux/resctrl.h=0A=
+++ b/include/linux/resctrl.h=0A=
@@ -72,11 +72,12 @@ struct rdt_domain {=0A=
 /**=0A=
  * struct resctrl_cache - Cache allocation related data=0A=
  * @cbm_len:		Length of the cache bit mask=0A=
- * @min_cbm_bits:	Minimum number of consecutive bits to be set=0A=
+ * @min_cbm_bits:	Minimum number of consecutive bits to be set.=0A=
+ *			The value 0 means the architecture can support=0A=
+ *			zero CBM.=0A=
  * @shareable_bits:	Bitmask of shareable resource with other=0A=
  *			executing entities=0A=
  * @arch_has_sparse_bitmaps:	True if a bitmap like f00f is valid.=0A=
- * @arch_has_empty_bitmaps:	True if the '0' bitmap is valid.=0A=
  * @arch_has_per_cpu_cfg:	True if QOS_CFG register for this cache=0A=
  *				level has CPU scope.=0A=
  */=0A=
@@ -85,7 +86,6 @@ struct resctrl_cache {=0A=
 	unsigned int	min_cbm_bits;=0A=
 	unsigned int	shareable_bits;=0A=
 	bool		arch_has_sparse_bitmaps;=0A=
-	bool		arch_has_empty_bitmaps;=0A=
 	bool		arch_has_per_cpu_cfg;=0A=
 };=0A=
 =0A=
=0A=

