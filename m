Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F88E55F27D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 02:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiF2Al5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 20:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiF2Alz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 20:41:55 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E51011A08
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 17:41:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjHDsG5vcICla9teerGvSd5WKZqoEHEp2ucS759MomIpNbnscZ3gYU+Vna40FAxsPaT7ktJF+QDn+P6Sjz9DsZxiWFBJzYizvD0kLBJ7JiZETjhCAMj5xg1EoZo2q8df+xKvB75FeST7Nn7y95brP9/H/7PMMvC9DJGXYkumXW198+ij8tDWPBzlWhWxSxh+pHA25mCIPwoqMmdsN1+RwF3o604Rh/orod8+ijouBq//pBLIH7tIaGLVAp5wQH75Mlex9stuulG65Bp4yplLjloFsDXD95amJ0HOEJUgA+ZpGYD7VBrb6t/cbUOWxj37pP8Dus7HW18Pr5AaN2kYAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ers2LVk3wz1senN/B4+iSiOuRIrQd9RQl1G1QvQf4iA=;
 b=O+sfnzAvBeVCWRRNNwk8JwwYWghO8JddxGWC5APbOV8JBkegRoOUwmX2y8dVj2CoRISRqJNs9W4jYiuxL+m+Hr0ZEhCHMToDVTm9QjfexPmJftCkuXAxhEGePzCUPefK04PrRoPH+PqPG9yITyjCBtr//QfS5fPxJG5CfyI1OKKLPMHQpUXr5mG77/Uuj5ODFf5zHM6DqrxGQ9MmGunRIuhqBfyhdBjxNDwZmNRM8BX65j9Jx2yLQ2zlQH/bxIq8YWRWkUz0b5c/dz6BpYRy2947SpocU0NOILGLbdog7vR4Gkno1v+PoWt4g8RO4B2l7DjFeitOYDHqSrgFe/JQlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nec.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ers2LVk3wz1senN/B4+iSiOuRIrQd9RQl1G1QvQf4iA=;
 b=A4U3uZVWHirPkFsjvbPGVq0lpvOF4qokLmklzzzwMXoD933w7o9TihNifDpNJ747X7VkyO/yiKS1OerVM8ycURyegEuqtVN9sEsmsc14kb0/AQBCRUXTB1PVNrTOqV8CtFyovsudJLrYHVF50U1ct4niqCXYuO4p0AWN0LeaJQc=
Received: from DM5PR06CA0088.namprd06.prod.outlook.com (2603:10b6:3:4::26) by
 BN8PR12MB4979.namprd12.prod.outlook.com (2603:10b6:408:75::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.18; Wed, 29 Jun 2022 00:41:51 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::8a) by DM5PR06CA0088.outlook.office365.com
 (2603:10b6:3:4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Wed, 29 Jun 2022 00:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 00:41:50 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 19:41:49 -0500
Date:   Tue, 28 Jun 2022 19:41:14 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     NOMURA =?utf-8?B?SlVOSUNISSjph47mnZHjgIDmt7PkuIAp?= 
        <junichi.nomura@nec.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@suse.de" <bp@suse.de>
Subject: Re: [Regression v5.19-rc1] crash kexec fails to boot the 2nd kernel
 (Re: [PATCH v12 38/46] x86/sev: Add SEV-SNP feature detection/setup)
Message-ID: <20220629004114.zn5rurrmqdkiceun@amd.com>
References: <TYCPR01MB694815CD815E98945F63C99183B49@TYCPR01MB6948.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYCPR01MB694815CD815E98945F63C99183B49@TYCPR01MB6948.jpnprd01.prod.outlook.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22fe4908-ea5f-4d67-749b-08da596827f5
X-MS-TrafficTypeDiagnostic: BN8PR12MB4979:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XXA4yEvjtq5TKCHmyTa1QhAQ0sIPYlzGcwCsTqkAxWkeDlfl/ClEAXwTzhOycchXK8QpcB/Lyji/Iul7zf6ey17rM1RBAH9x/Ey4t0EoX1FZdqg9HNXpZmZwJ3NFGTNnPXjJfxK/yUBYrt3Zphuc7BZdxNX62JVX6GmRcjVQCz5zQCoB3XALRNiXijii/N0iUL5MZqK47l/zhUNBSfzuEVxrXM/mV23rC8heKwpxUGJ5LChrgrXJJY+dBsUYaUoTOhcRCXBxGfpH3/HrjcZeiI1jicZMPzbAkCQ/8OgVKSW+A7//roXedt/c8Ic7hMWUbbDTNpg4AM+BdbNVebylWwX++7PWIkK/S/3/5dYXtXWpRrutZg+wd/j+4fOBrwlo896EOVCK6KatZIC7BUGoaqSvHWRnHdtzyI6IPFYzli2EmC0gGNMmkdodg2wTCgTUCLHEn9+GFOJ4fIK0x07aWT3AiCmaEbdScefA5q0ljXJKIFxWbT2h9bsBV/wdBNDb80xXqz7Ktfu6Faz41RPnwXgSoWhEdK5JWMoYLH6Eq8RpVEvslkaPv6XRTLLAl67BpeC692suCNqORF60fiadi1iRbzAAUoUABHgOgvjfWcRBnjDvxRR9gUO9NCkxa4ceCQw+A2/xk8/b3lZYAzPnQ+yxybfy02Zim9/Vw5efYCQpzhPcdv3gE13uUVdEHXldQh3gFpRHGfQPvjpzGLz+HBR+wcT8ZzsnIJVzDRK1e/vYMGp/qtxHU5hAh3DTSdAUykoGXV7xHOmP5hBCKgKElMbUGNsbPZqoeoPdlyyWsbdmSxNHZLMMfTGPIMd0A+RWporgFMEx7vnAW9159OnLcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(136003)(346002)(40470700004)(36840700001)(46966006)(186003)(426003)(16526019)(8676002)(336012)(6666004)(6916009)(83380400001)(2616005)(36860700001)(70586007)(54906003)(1076003)(47076005)(356005)(81166007)(26005)(41300700001)(82740400003)(82310400005)(44832011)(36756003)(40480700001)(4326008)(2906002)(5660300002)(86362001)(8936002)(478600001)(40460700003)(70206006)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 00:41:50.7121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22fe4908-ea5f-4d67-749b-08da596827f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4979
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 12:44:52AM +0000, NOMURA JUNICHI(野村 淳一) wrote:
> I found crash kexec fails to boot the 2nd kernel since v5.19-rc1 and
> git bisect points to this as a bad commit:
> 
>   commit b190a043c49af4587f5e157053f909192820522a
>   Author: Michael Roth <michael.roth@amd.com>
>   Date:   Thu Feb 24 10:56:18 2022 -0600
> 
>     x86/sev: Add SEV-SNP feature detection/setup
> 
>     Initial/preliminary detection of SEV-SNP is done via the Confidential
>     Computing blob. Check for it prior to the normal SEV/SME feature
>     initialization, and add some sanity checks to confirm it agrees with
>     SEV-SNP CPUID/MSR bits.
> 
> The problem seems to occur when find_cc_blob_setup_data() walks setup_data
> chain.  If the code is modified to do nothing in find_cc_blob_setup_data(),
> the 2nd kernel boots fine.
> 
> On my system, the chain of setup_data looks like following on regular boot:
>   setup_data: type=0x3 addr=0x9e9e5018 next=0x9e9dc018
>   setup_data: type=0x3 addr=0x9e9dc018 next=0x9e9d2018
>   setup_data: type=0x3 addr=0x9e9d2018 next=0x8a27b018
>   setup_data: type=0x3 addr=0x8a27b018 next=0x8a218018
>   setup_data: type=0x3 addr=0x8a218018 next=0x9e9a0018
>   setup_data: type=0x3 addr=0x9e9a0018 next=0x8a1e6018
>   setup_data: type=0x3 addr=0x8a1e6018 next=0x8a1b4018
>   setup_data: type=0x3 addr=0x8a1b4018 next=0x8a182018
>   setup_data: type=0x3 addr=0x8a182018 next=0x8a056018
>   setup_data: type=0x3 addr=0x8a056018 next=0x8a020018
>   setup_data: type=0x3 addr=0x8a020018 next=0x89fea018
>   setup_data: type=0x3 addr=0x89fea018 next=0x0
> 
> OTOH, it looks like following on crash kexec boot:
>   setup_data: type=0x4 addr=0x2e000000 next=0x0

Hi,

Thanks for the debug info. I haven't been able to reproduce this on the
Milan or Cascade Lake systems I've tried, with kexec -l/-p, and well as
with/without -s, so there may be something hardware/environment-specific
going on here, so I could really use your help to test possible fixes.

> 
> Other places that parses setup_data uses early_memremap() before
> accessing the data (e.g. parse_setup_data()).  I wonder if the lack of
> remapping causes the problem but find_cc_blob is too early in the
> boot process for early_memremap to work.

I think this might be the case. Prior to early_memremap() being
available, we need to rely on the initialize identity map set up by the
decompression kernel. It has some stuff to add mappings for boot_params
and whatnot, but I don't see where boot_params->hdr.setup_data is
handled.

If you use kexec -s to force kexec_file_load, then the kernel sets it up
so that boot_params->hdr.setup_data points to some memory just after
boot_params, and boot/compressed uses 2M pages in its identity map, so
that generally ends up handling the whole range.

But if you use kexec's default kexec_load functionality, setup_data might
be allocated elsewhere, so in that case we might need explicit mapping. I
noticed on my systems boot_params->hdr.setup_data seems to generally end
up at 0x100000 for some reason, and maybe that addr just happens to
get mapped for other reasons so I don't end up hitting the crash.

Could you give it a shot with the kexec -s flag and so if that works?

If so, can you apply the below potential fix, and retry your original
reproducer?

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 44c350d627c7..c548950981a2 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -110,6 +110,7 @@ void kernel_add_identity_map(unsigned long start, unsigned long end)
 void initialize_identity_maps(void *rmode)
 {
        unsigned long cmdline;
+       struct setup_data *sd;

        /* Exclude the encryption mask from __PHYSICAL_MASK */
        physical_mask &= ~sme_me_mask;
@@ -163,6 +164,12 @@ void initialize_identity_maps(void *rmode)
        cmdline = get_cmd_line_ptr();
        kernel_add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);

+       sd = (struct setup_data *)boot_params->hdr.setup_data;
+       while (sd) {
+               kernel_add_identity_map((unsigned long)sd, (unsigned long)(sizeof(*sd) + sd->len));
+               sd = (struct setup_data *)sd->next;
+       }
+
        sev_prep_identity_maps(top_level_pgt);

        /* Load the new page-table. */


Thanks!

-Mike

> 
> -- 
> Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
> 


