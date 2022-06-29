Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DD65601C4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbiF2Nzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbiF2Nze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:55:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E001AD9F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 06:55:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNx9gs0RhqD5GJhQ8RkjLVdgWkMDHsnl/aiXOqI+2IZC/rUJLGAIBQ/9qP0eH71cYuWOeQM7E5sHZlNZi9tImLaj7QqeZLUeK0w3wpZ0p3XRgPHsKMqSg2EVAop6JxUeGIm8YRrzcnAJlIBS+JeJcZjw5gJ60k8htPXRc6FAnql9jmFHfCvk9rnGV4/MX2CDZcOIOfenPlZK+K2b8D0yWb8dtZa/6RhrQyUfGrAf3ouDeX1Enj0dos4RCoyx59jMfwYm7vMgYKHMrdFCDEtUdFjB+snyMWdEpbaDU55ce2qY/XB4XylSbaa+Vg9dhrmccdG24apI80uLwke+uSz7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4wDekqf1SSQODQ+6Uue5WCaUxVuXa/gUWARyBE4r/o=;
 b=hZdH6+ns8tmhoj8D4INUsbPiWuNhOuYJeZkHCSxiqf1yzav9T5CBAYoSDHaD2Dc4iIW8iHN4U5XKzI6zDoqnvKZX6v2qQ+3SNaKksXEzB8Bv/hNhdraHoU1SYG7SdAOmJ581x1n+HkL9KvAOjTKAaSsTZSFuOwOO+NfZZBF+2grELTi1uUcGj2gHLLd1s5NtDYzTgH2r/kzmesXSn5CpNCLtLXSfvJ0GVhWsbD07y6JeJ7LOtCgCa6cX9LC6j/pGGNIQ6QkZFbJ3S/fIeip6quWFb8epollovmBwVyEKTHD+gOTxx6t7KELDJF6htCQustQbqi9owVwI+MKY9nsiUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nec.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4wDekqf1SSQODQ+6Uue5WCaUxVuXa/gUWARyBE4r/o=;
 b=LbwKO6WkT6ZrOvVwzCHPNPiZ43WDKSFIUAdJOb36WTdlJwcOfV/BvOfPNnzK2iCYzvbfPTNlinFsytvfAPEyaCiE+ayqSic0KJDq04I7WSOzNJuWrfTfGG09P11WB+zb2lloy+8kI85wxKoKVtp8427SM7g/aQInF+4df9GjUs0=
Received: from BN9PR03CA0402.namprd03.prod.outlook.com (2603:10b6:408:111::17)
 by BN6PR12MB1378.namprd12.prod.outlook.com (2603:10b6:404:1e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 13:55:30 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::8f) by BN9PR03CA0402.outlook.office365.com
 (2603:10b6:408:111::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 29 Jun 2022 13:55:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 13:55:30 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 29 Jun
 2022 08:55:29 -0500
Date:   Wed, 29 Jun 2022 08:54:41 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     NOMURA =?utf-8?B?SlVOSUNISSjph47mnZHjgIDmt7PkuIAp?= 
        <junichi.nomura@nec.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@suse.de" <bp@suse.de>
Subject: Re: [Regression v5.19-rc1] crash kexec fails to boot the 2nd kernel
 (Re: [PATCH v12 38/46] x86/sev: Add SEV-SNP feature detection/setup)
Message-ID: <20220629135441.7w4ptweifvfyw5rc@amd.com>
References: <TYCPR01MB694815CD815E98945F63C99183B49@TYCPR01MB6948.jpnprd01.prod.outlook.com>
 <20220629004114.zn5rurrmqdkiceun@amd.com>
 <OSZPR01MB6953EEF3F8E63330547E031183BB9@OSZPR01MB6953.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OSZPR01MB6953EEF3F8E63330547E031183BB9@OSZPR01MB6953.jpnprd01.prod.outlook.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faf4d4f2-5893-46d7-1bff-08da59d7079d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1378:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +BzjQC3StD3sxjat+xQIU75uqjx3Q1B/6aSBea0CzSyfnItcfCo85nvRkFIPolS7IPC2+MWBGVkz7KcsQCtR9dudu6IyeKFVPIPWmqKgYMmywV1c3IJ5sz8OwCR9ig1ZmvJqu0+dXQeM0+YDWm2nbAaZF1GUlY3xIUy98m4N4Um72XMXYEfq32XiyGw6QLqwo1n9ckhZql68NIUW5YcyUolqHe3PB09r9dKAlGL9WEM8nRsf6VmCz8jZIVhaDMwjINWFDL9THH8Hzz9IPIsF+N7WluWeC7gGhS5cfUpPBxvUwTJE6gHJcb1WhEY8/k37WQ9zSbuPWZ0DwlhiHevDijW4qC9ojonrv5sVu/WP9W4A84Ny0NorH/Bg9+vGKmtJ7Rjk/s9dkjBpxvkaJYiLubSm+c1HudAl0urA1K2Tr1+uPdo3Iv+UEMF9d6RqWs5MoDfR94arRjceYdxuwcVHoPl2fgZtRECqGnlfBC6Wdf08pWq8ZRtYGX6IkUwpdPaoos26mqxLeTlgIqK0JqRTJNA6I4c1x5HMixAm/Tbqy+l8DJJkPvr/cMXIFJ6QpholfGM8tcUZJ1e50dOQ60xwBANZ2cmF++gLLXVTv8mF2msTC5o+7emjcS/8KfAeG2R10afxcolpPYXthHDDSsH3vINugz12gjxD5SZ7VJE2m5lIEUIeLkmn+A9/Ff3vy4CYtSGrc+EhJlm57SorU3l10sOp6uYu7wJwRAN/4ycPJuuFlcOrneSYlUOg4nsAczLTnA7I3GtlX0MIXiBL3Xe82FFNXnNinY96mkEPieADXpvxHJMwV0HE7X5n7SuKEEm+61MYTRx9AEz7OqIEsII5Kg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(346002)(376002)(40470700004)(46966006)(36840700001)(44832011)(6862004)(26005)(8936002)(5660300002)(70206006)(70586007)(8676002)(54906003)(316002)(4326008)(86362001)(82740400003)(81166007)(6666004)(478600001)(356005)(16526019)(82310400005)(2616005)(40480700001)(186003)(1076003)(83380400001)(336012)(40460700003)(36756003)(36860700001)(47076005)(426003)(2906002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 13:55:30.6299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faf4d4f2-5893-46d7-1bff-08da59d7079d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1378
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 07:38:09AM +0000, NOMURA JUNICHI(野村 淳一) wrote:
> From: Michael Roth <michael.roth@amd.com>
> > Thanks for the debug info. I haven't been able to reproduce this on the
> > Milan or Cascade Lake systems I've tried, with kexec -l/-p, and well as
> > with/without -s, so there may be something hardware/environment-specific
> > going on here, so I could really use your help to test possible fixes.
> 
> Sure.  Thank you for trying to reproduce the problem.
> 
> > > Other places that parses setup_data uses early_memremap() before
> > > accessing the data (e.g. parse_setup_data()).  I wonder if the lack of
> > > remapping causes the problem but find_cc_blob is too early in the
> > > boot process for early_memremap to work.
> > 
> > I think this might be the case. Prior to early_memremap() being
> > available, we need to rely on the initialize identity map set up by the
> > decompression kernel. It has some stuff to add mappings for boot_params
> > and whatnot, but I don't see where boot_params->hdr.setup_data is
> > handled.
> > 
> > If you use kexec -s to force kexec_file_load, then the kernel sets it up
> > so that boot_params->hdr.setup_data points to some memory just after
> > boot_params, and boot/compressed uses 2M pages in its identity map, so
> > that generally ends up handling the whole range.
> > 
> > But if you use kexec's default kexec_load functionality, setup_data might
> > be allocated elsewhere, so in that case we might need explicit mapping. I
> > noticed on my systems boot_params->hdr.setup_data seems to generally end
> > up at 0x100000 for some reason, and maybe that addr just happens to
> > get mapped for other reasons so I don't end up hitting the crash.
> > 
> > Could you give it a shot with the kexec -s flag and so if that works?
> 
> Your explanation makes a lot of sense.  I could successfully boot the 2nd
> kernel if "kexec -s" is used.

Thanks for trying these, that's good to know.

> 
> > If so, can you apply the below potential fix, and retry your original
> > reproducer?
> 
> I tried your potential fix but it didn't work...  The symptom was same
> as before.

Sorry, I just noticed I had a typo in that patch which made it a no-op
effectively. Can you give this a shot?

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 44c350d627c7..b97b81d3697d 100644
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
+               kernel_add_identity_map((unsigned long)sd, (unsigned long)(sd + sizeof(*sd) + sd->len));
+               sd = (struct setup_data *)sd->next;
+       }
+
        sev_prep_identity_maps(top_level_pgt);

        /* Load the new page-table. */

> 
> -- 
> Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.


