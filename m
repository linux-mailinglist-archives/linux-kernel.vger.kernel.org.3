Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C16C5B0C0B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiIGSCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiIGSCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:02:03 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A90BFE83;
        Wed,  7 Sep 2022 11:01:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KP2573PBa1vBrQAACs714HKnJLVptOYE7pDkEJQeW/ypVmG0p22EfrSNLw5RINvhIzywPXiM5GV5U3O6NfQvRzPrnqMfOJHVTv5dSk8F9NNFNj46u4Q2HT493x9469fA6xrfof9lgj14md1WFUj/yy/6cpcMC9gaWfpEsPkrw+MKHYdHcUdLftbmO+GglDm3vT0/YGfAndzrUaW3jHweSclMtaHjo3bu7SP21QGahyYDhYB8oRAfY0BMemVSpXv4Vz2+8SV7XebFTW1RJnJW20xzLq4oLeLUzeDdFaCn02e36rXEY+m7eJUxBrY6vgLE8vrsHtMOGX9BsFz62VYbFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/wt4Ju65zXBLyit7uwtagKuuZ3GQYMLyhnE5kaEuk0=;
 b=FvKdrS2lgO+BatKcSLnimQWvKPU+98/pex8fB6DaUAnOKryqz0AsDNJ95Tal3mGI/X3/ocbWp2BnY4gkutxu5bxkPAktYAqYhV3Uye4euG2IFsixWSC0L7+s209mPiROFYPw4B1ZqfmY74vB3GR8F1b/BHUTqcMABZUL2hbnSGHFuaV5DZ6mTgxN81j/InPsRT7adFXKvLW6M9e+MAoRPCH+8Fhc9o1STA9PMq/rLMyVyqsseB7KzZnOBjxpInyfLBWIj6OC0JjphJSgaGRSx9JP+fPKQOHtnBXQn12ksmwC4N2bTUiSMEt+m5E178AAY2M1nANyjVuTvG+5P1Gv4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/wt4Ju65zXBLyit7uwtagKuuZ3GQYMLyhnE5kaEuk0=;
 b=YEoz+t1rplZvXu1gAX3maE69vWGJrI1ENszmUIYgJxUY6O7LjPdXL+LWyw3aXQG62LaxgmWi8VhSuXOpOa52vr95uIIlrNkCW9uB3SlO+NKKMpYxhWj12RFJurgaZnP0oTNa8mzrGdvfjNhp7KKSSFJBvhS+w9zHuq7LeNHdPu8=
Received: from BN0PR04CA0059.namprd04.prod.outlook.com (2603:10b6:408:e8::34)
 by IA1PR12MB6409.namprd12.prod.outlook.com (2603:10b6:208:38b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Wed, 7 Sep
 2022 18:01:27 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::8b) by BN0PR04CA0059.outlook.office365.com
 (2603:10b6:408:e8::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 7 Sep 2022 18:01:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:01:27 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:01:23 -0500
Subject: [PATCH v4 12/13] x86/resctrl: Replace smp_call_function_many with
 on_each_cpu_mask
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
Date:   Wed, 7 Sep 2022 13:01:23 -0500
Message-ID: <166257368306.1043018.15116501631578530094.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT038:EE_|IA1PR12MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8e1706-289d-4462-fb2a-08da90fafc29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OxwVTQjhhwIU+EYvR68yv02Ch4lRt/bdEkUu5juyB7fA7U41XMmCBprHfDS9r+adgb+/7BUU6iFdClZIeiC5gzkO3Rp9uk9+SsDbKqDxzv56APw0ULacNGKBAQZqYxxt/+ZVTRZpbJWGXnls2lDe+LkAl6YrhC+TxPvoicfkOFbZiZN4fvjBQdvJA7f3hAgRzVSO0EDD/ltRTK8/4FfJdIURuWg2MX8CISTV8FmLWDUu2wKcVm8J0nYmOCfho82/sHWNuO5SOBI0kWDzWvj0EO/BS2jc09vjgf0dxSUSLPmonQJ3+TngvNIJdU3wVwNuRQxP/x3apDPD9LGsxbZZKe1Z7tnrI4ZqouQEcIiEoGaSgjF3/vim02B0kNRfU+kxz6qrfmxyvKQxtl2KsxxLfUqW0AlRATKZPg0quoLrb0ZhOl5yE0pBbiPq4vXPoy+Mlp3/AwMHzxwYBhHsGV1CDRY8hqpxpWvJixWceISXz1ZuSS5S+NHFXWjXtlgVv7SHRfN81TFD1bI6zkoEa/V9PuiGA4/JrhjgwrKIuLHVaDPMcULEU7xA1IZ4wFPo8N5SiWobhXhOhHpfz6oXl/OOTc/Pd5iruczjcEApYqFHj4HJV7p7uejOVTn9sxoTHQpTJM9qhdyWulWd8eYUJW7pX0mLD/tu/FQGrj1EYaVS1sSjNWnsBDu1PcZqANdr8rceFu01xbh9Gg0SsJqy1avKgi5dt81CUNWF9vh2qt2G+2qL6zUKcUyCgr42AAVmzxBdNRLdQzd0/itx+k+XbvVSAYQqtTTALXnmUUs4M0kQ9+f3AeQ52FqabTof2kTl3U9oElsDECxV8COpuz7Q4q+PBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(7916004)(376002)(396003)(136003)(39860400002)(346002)(36840700001)(46966006)(40470700004)(54906003)(16576012)(40480700001)(426003)(47076005)(103116003)(110136005)(5660300002)(81166007)(40460700003)(83380400001)(36860700001)(316002)(336012)(33716001)(16526019)(7416002)(82740400003)(44832011)(478600001)(356005)(2906002)(4326008)(41300700001)(70206006)(8936002)(70586007)(8676002)(86362001)(186003)(82310400005)(26005)(9686003)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:01:27.2554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8e1706-289d-4462-fb2a-08da90fafc29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6409
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call on_each_cpu_mask can run the function on each CPU specified by=0A=
cpumask, which may include the local processor. So, replace the call=0A=
smp_call_function_many with on_each_cpu_mask to simplify the code.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   29 ++++++++--------------------=
-=0A=
 1 file changed, 8 insertions(+), 21 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 59b484eb1267..fa0e1e8e29aa 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -518,12 +518,7 @@ static void update_cpu_closid_rmid(void *info)=0A=
 static void=0A=
 update_closid_rmid(const struct cpumask *cpu_mask, struct rdtgroup *r)=0A=
 {=0A=
-	int cpu =3D get_cpu();=0A=
-=0A=
-	if (cpumask_test_cpu(cpu, cpu_mask))=0A=
-		update_cpu_closid_rmid(r);=0A=
-	smp_call_function_many(cpu_mask, update_cpu_closid_rmid, r, 1);=0A=
-	put_cpu();=0A=
+	on_each_cpu_mask(cpu_mask, update_cpu_closid_rmid, r, 1);=0A=
 }=0A=
 =0A=
 static int cpus_mon_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,=
=0A=
@@ -2058,13 +2053,9 @@ static int set_cache_qos_cfg(int level, bool enable)=
=0A=
 			/* Pick one CPU from each domain instance to update MSR */=0A=
 			cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);=0A=
 	}=0A=
-	cpu =3D get_cpu();=0A=
-	/* Update QOS_CFG MSR on this cpu if it's in cpu_mask. */=0A=
-	if (cpumask_test_cpu(cpu, cpu_mask))=0A=
-		update(&enable);=0A=
-	/* Update QOS_CFG MSR on all other cpus in cpu_mask. */=0A=
-	smp_call_function_many(cpu_mask, update, &enable, 1);=0A=
-	put_cpu();=0A=
+=0A=
+	/* Update QOS_CFG MSR on all the CPUs in cpu_mask */=0A=
+	on_each_cpu_mask(cpu_mask, update, &enable, 1);=0A=
 =0A=
 	free_cpumask_var(cpu_mask);=0A=
 =0A=
@@ -2506,7 +2497,7 @@ static int reset_all_ctrls(struct rdt_resource *r)=0A=
 	struct msr_param msr_param;=0A=
 	cpumask_var_t cpu_mask;=0A=
 	struct rdt_domain *d;=0A=
-	int i, cpu;=0A=
+	int i;=0A=
 =0A=
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))=0A=
 		return -ENOMEM;=0A=
@@ -2527,13 +2518,9 @@ static int reset_all_ctrls(struct rdt_resource *r)=
=0A=
 		for (i =3D 0; i < hw_res->num_closid; i++)=0A=
 			hw_dom->ctrl_val[i] =3D r->default_ctrl;=0A=
 	}=0A=
-	cpu =3D get_cpu();=0A=
-	/* Update CBM on this cpu if it's in cpu_mask. */=0A=
-	if (cpumask_test_cpu(cpu, cpu_mask))=0A=
-		rdt_ctrl_update(&msr_param);=0A=
-	/* Update CBM on all other cpus in cpu_mask. */=0A=
-	smp_call_function_many(cpu_mask, rdt_ctrl_update, &msr_param, 1);=0A=
-	put_cpu();=0A=
+=0A=
+	/* Update CBM on all the CPUs in cpu_mask */=0A=
+	on_each_cpu_mask(cpu_mask, rdt_ctrl_update, &msr_param, 1);=0A=
 =0A=
 	free_cpumask_var(cpu_mask);=0A=
 =0A=
=0A=

