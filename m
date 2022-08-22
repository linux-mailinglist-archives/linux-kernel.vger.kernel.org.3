Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9224B59C449
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbiHVQkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiHVQkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:40:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4301ADB6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:39:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEH+wOVyzpxh3hgn/zbBNWyHfbzOYI1zklD7N5rlOPiGQqG4ewtMqQvuhJP9ggJ27O7S4F99Hp6OLAByn4bbXaEFcmV0OhQy3tQBjmXLU2qJMIcfOmxjnBmIxlKNNQa7ZXVWhJCd19y6EqACVaz85gFv60NA/EUXMnpl+OIFZlG4vDlAwAfUd13edZs/YqU1Vi25QYcoRR6YZamMDw1WiXwXahWCxKKh8MaaI/0n58dB3piKj/889lIICxFxlzjopHwgRcsvMzvyF2AT/7aZAtWp+DxSZ2MXrmtE1WOOGoc/rJa0W8mdTX5J9j+xD/7W1p7nbucF9sTRnE2vKWb4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKctiWJuujmGrYK+I7pkioT3zzeG1hMGajyeGdq13W8=;
 b=VX2km5m3awbaJDaVNs2TkMLY9+0XJ+1DmOpzh+/v+0CXSbwpgXqpEHpsMuqShtoGi2EQaNiRE/A2hPqIMOemEAMC2d2i+oQ8D6sNzK9GNtqwUNpG6imzQ89gNuZAYsxSDhlE8TkePWM/M+PHuM6WwA2MuW+F2WqnLcgGlP1fRkJEhbW+zYc5v5mU+peew+IJmO/Y+mL1pSH2Fo4p5G6aoz6uS5/0WO3sYwe69bYzRrf0adZZVOMlI5v4Mdi0Phs2SXYLqxPE95DdtbOEd19UsXVHFqrJHP58irm3mLkSfsvP4G9ZgGShA6cH28g1kkcTJA36wAYgWwMuwUqI0z8lNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.microsoft.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKctiWJuujmGrYK+I7pkioT3zzeG1hMGajyeGdq13W8=;
 b=rQR80sUIwXYonh6ctrxtzSrr5vFlEC2lE1dn+yLQ6kWyBmqPwfObatrUl/z0y/oa1/LMwRpa9prORp6ssOCXDfVtfSuXMs/oSmkhq0FErG5NddDLCZ5sxWgSJ2Py6w7btJg3cGeAZKx+SqlLjoxo1ni85UnUUUXu1wCNtr1+uc8=
Received: from DS7PR06CA0031.namprd06.prod.outlook.com (2603:10b6:8:54::11) by
 MN2PR12MB3856.namprd12.prod.outlook.com (2603:10b6:208:168::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 16:39:57 +0000
Received: from DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::3b) by DS7PR06CA0031.outlook.office365.com
 (2603:10b6:8:54::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19 via Frontend
 Transport; Mon, 22 Aug 2022 16:39:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT110.mail.protection.outlook.com (10.13.173.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Mon, 22 Aug 2022 16:39:56 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 11:39:55 -0500
Date:   Mon, 22 Aug 2022 11:39:33 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
CC:     NOMURA =?utf-8?B?SlVOSUNISSjph47mnZHjgIDmt7PkuIAp?= 
        <junichi.nomura@nec.com>, LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@suse.de" <bp@suse.de>
Subject: Re: [Regression v5.19-rc1] kernel fails to boot, no console output
 (Re: [PATCH v12 38/46] x86/sev: Add SEV-SNP feature detection/setup)
Message-ID: <20220822163933.b5hee76fsis376ji@amd.com>
References: <TYCPR01MB694815CD815E98945F63C99183B49@TYCPR01MB6948.jpnprd01.prod.outlook.com>
 <Yvuo2rtootBSlpfQ@jpiotrowski-Surface-Book-3>
 <20220816150637.lyfeirdebb7eetgf@amd.com>
 <YvypiOgn94y21nru@jpiotrowski-Surface-Book-3>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YvypiOgn94y21nru@jpiotrowski-Surface-Book-3>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2e522ac-c386-4c6c-a617-08da845cf28e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3856:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JhxIp707XL5QIKHK15cq3qZBzqmU/HLfElVmE9PIvgaKScDnwPIdE3f/oDO3FRf6tDrax175AxJbBpZflrVlJfGGSB2huHj/XpAD6Y7YVKdD5vLlbS0BJBUHhyZvYST8iyhMcG0AeuRpeyIRIeiPMJ0rp8vihZkr3jYv4i075seXkqr73qWtSPTUUcvUN8EtUBFsU2lAkeYIXI4dm3RwfnOou2MKJWczvEIT6r1DBuhw+M1/DSjaQJK1/RMEfN3FbuKhl7npohTvT/CKCj/2l41UoldtUeqHH71jNJ39uNX06+Zd1Lvr7qOi2DYahr9jODi5/4nbDEWQh8VJVT/HE3E8CKBQoSYe+w9pKwcISx9bc9vEFmP+lwLt+yjAoJ/ePPsJEdRcWGi9UYBljYFCyOSRs2acF/K4Xv5KkLxSlX9ZElEvHYdmEuRxNPvBh58c1Z6gxBqIVWIPamw56Jhmln9mycTiDa43VAXFXvQcGFHCkwby263oj+WB/dQChEVbVJeL5NCkQAs/XvgsKe1PpwlYkE00olLxoo+hRZbT+O510gSvPOBvDOFzSOWRHHKW1aZVYPhbesQXsAM00RAVI54Oz6iWNuIxfmBQRS71LS3iTGBHuxck/Pl5nctmUf6IuguAtYCK8gEkF8Yhvq+nm+Hy5Paj45bOMquuJ0ofQYOWm9U3plIAaOWdmpQluw9F1pwrLtR0R1oMQ7wY/d1DC3fYM/jfOI+V6ZDNyCqCzsdw0DLDt5QxzF/xSl5vgZjmrFa86kfp3lx/4Y2U2BOtSzVeelAT2x9QnJ0l12JRb3k=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(376002)(136003)(36840700001)(40470700004)(46966006)(47076005)(426003)(83380400001)(26005)(2616005)(16526019)(336012)(2906002)(1076003)(186003)(356005)(81166007)(40460700003)(86362001)(82740400003)(36860700001)(40480700001)(82310400005)(70586007)(70206006)(41300700001)(44832011)(316002)(5660300002)(6916009)(36756003)(54906003)(6666004)(8676002)(8936002)(478600001)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 16:39:56.6545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e522ac-c386-4c6c-a617-08da845cf28e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3856
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 10:40:40AM +0200, Jeremi Piotrowski wrote:
> On Tue, Aug 16, 2022 at 10:06:37AM -0500, Michael Roth wrote:
> > And if that does not avoid the issue, can you retry with the below change
> > (without the above change in place)?
> > 
> >   diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> >   index 7b668f91c9ab..0b430f98e053 100644
> >   --- a/arch/x86/kernel/sev.c
> >   +++ b/arch/x86/kernel/sev.c
> >   @@ -2073,10 +2073,12 @@ static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
> >           struct cc_blob_sev_info *cc_info;
> >   
> >           /* Boot kernel would have passed the CC blob via boot_params. */
> >   +#if 0
> >           if (bp->cc_blob_address) {
> >                   cc_info = (struct cc_blob_sev_info *)(unsigned long)bp->cc_blob_address;
> >                   goto found_cc_info;
> >           }
> >   +#endif
> >   
> >           /*
> >            * If kernel was booted directly, without the use of the
> >   @@ -2087,7 +2089,7 @@ static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
> >           if (!cc_info)
> >                   return NULL;
> >   
> >   -found_cc_info:
> >   +//found_cc_info:
> >           if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
> >                   snp_abort();
> > 
> > Trying to see if you're hitting a separate issue or not.
> 
> This version boots correctly.

Hi Jeremi,

Still haven't been able to reproduce this on my systems, but it looks like
it's either an issue dereferencing boot_params, or bp->cc_blob_address is
pointing to garbage, so the cc_info->magic check fails. The latter seems
more likely, since sme_enable() previously made use of the same boot_params
pointer without any issues.

To confirm, please give the below fix a try:


diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 52f989f6acc2..dd6cd0d7c740 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -392,6 +392,13 @@ bool snp_init(struct boot_params *bp)
        if (!bp)
                return false;

+       /*
+        * bp->cc_blob_address should only be set by boot/compressed kernel.
+        * Initialize it to 0 to ensure that uninitialized values from
+        * buggy bootloaders aren't propagated.
+        */
+       bp->cc_blob_address = 0;
+
        cc_info = find_cc_blob(bp);
        if (!cc_info)
                return false;

Thanks!

-Mike

> 
> > 
> > Thanks,
> > 
> > Mike
> > 
> > 
