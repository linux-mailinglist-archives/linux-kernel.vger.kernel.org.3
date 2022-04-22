Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FF550BBDB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240949AbiDVPoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbiDVPoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:44:16 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2068.outbound.protection.outlook.com [40.107.96.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFD95838E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:41:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+hwy8fKi5f8xEfeL2SK9691xhMN9hDJ2+jKXQ9EVxU8Vyt4bEZ1rNYaUCGhHvzMYFdi73ba0jwBnMIBS0+yKM0O3iJfruU89m0sC3pkxnBWb3aQ3P0XFv0KDd3UD4cGt+kCkIisHn+bFwiH5QeNC9Xs0Mxw68iYCYvCRxvSlekW9QbZlSHU0Yyoam9lCvZxNCiI7ceTn0KQ5hGtSuWsrWSyk7ZNcrtMHqD5IXBM1TfACtyRCaeaMqAqaIek7DZAGLiHk9oayyXrGmZOixlatSDTb4IDpbaR/D+r/0Fvq1YbrWItjR4BCfceqZCV03IDW66mtwYvfVeiQ07aoOpqEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLaw3vOW06UTks1A0QrJD//0lusk4+8zc41vhyVRq4Y=;
 b=guFYGlnuJ9siJIgjq3ogH3/ICft6j87CED66JCHu4sZ531qL9/CiDGSynefuyIOswFG4aBdxAu3qSBQSFzs3R74X27WNwg34w6p+ACR0ICi3Jks488z2qME+ffeFetbnwy03J++ZskEmxduImfeBW6x5hTcqBW+c2tpN5Nzr/GN7+Lu7qfftB8rJuOthx/CVrudGj4/uJ4DsCsMQVFsrdd6XHaSiDA2F9ZP7WdDuTjUy7UvxyjDgo7Gji8DndRZRrJ/Tkjtt7w4++zFlhfeHf6dqiRK298N0YnAyxF15E0YZDPqlFPltnH2Oqe4vB3evSzW3eMiCgl9zOVCdAjP3oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLaw3vOW06UTks1A0QrJD//0lusk4+8zc41vhyVRq4Y=;
 b=N02Z+Rv1TVtjcJzLcjSVKWH5AI7Rj5bjBBdIWjWeoG8UkOpjfT4LGTzOlJ3mhf7N8ztN/55tRGiQv+xVWvbiTodRHhypdc3+Z6WpTqVHlaZf8NVeM00X06lOyTBoC1SE6DAuRftEGvZHLy0vJZ7L/DAZsIMQ/E4OFKwgbeltTXA=
Received: from DS7PR03CA0201.namprd03.prod.outlook.com (2603:10b6:5:3b6::26)
 by MWHPR12MB1421.namprd12.prod.outlook.com (2603:10b6:300:12::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 15:41:18 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::6c) by DS7PR03CA0201.outlook.office365.com
 (2603:10b6:5:3b6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Fri, 22 Apr 2022 15:41:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 15:41:18 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 10:41:17 -0500
Date:   Fri, 22 Apr 2022 10:40:56 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
CC:     <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Joerg Roedel <jroedel@suse.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH v3 2/2] x86/sev: Get the AP jump table address from
 secrets page
Message-ID: <20220422154056.lhzmii34he6blvwv@amd.com>
References: <20220422135624.114172-1-michael.roth@amd.com>
 <20220422135624.114172-3-michael.roth@amd.com>
 <c3baaf5d-db99-f432-125f-9884b57b40ef@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c3baaf5d-db99-f432-125f-9884b57b40ef@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8dacfca-4a51-4fb8-1428-08da24768ae2
X-MS-TrafficTypeDiagnostic: MWHPR12MB1421:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB14219C39C15B8FC9397BE03E95F79@MWHPR12MB1421.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KlwFZFDnq4em0iRWFH0q879H3fk4gwTAtlppxqS75bIAaK047vFYK5OCSR69nOur5FEwzGieRCXZg/BQegEEiHTQtjdmybbiPBc3XNK8wNE5Hz6K/3AqiT/f9bUejfn+vi2Dfr+GT83eiCjGwcVsM8ez0h/DNxCHRc5kH8AbmYmppYCl7a4XJujT6Nm2UJK8go6vnaUfNvk1oE3Imx+tv56qCS6KpOY7IAl0HFiQF6CF3JT1aW8IgK6G/uGt58Zz/6qtmZQJ3m0PH953Xsf/aJkMI4e2nKwL8ITLSLGrxyErhxqPUgyvU5DJme5rUNn/B3wXXfPXMNI9nF36NPddD+JTSGP5EWgqCUtu2JuXZjQk6Xi6/13d9F2WkoMukCZ4PY3vBBggoesbeai3/JbE1j4RDCbiHWFXtqi095sob9JGwnmcHLFoCsPAIjIahqFgZ9swigvwg700n9rAgchiTUjeqUKyf5p66SxNLXRE6NfViE4UPeYUlQ5i8IakyYf6IFIkqiNrpDe78TTvFFzN6yTiG108Rlkjtfv9wMjjZ0W8OYivaEpfdItzKKyCMec6BMNqJBhOOJl5J1opScwRnAdLAWjIs4C5psBhbA1lEESQN0aS0cxmmgXiwljoWZirhhdem6AE2unqUWI/QOso1YD5Y4XJDD2MnKZbmPpn2q7r9c74/q5lpZpOVhCA8UiLPkr9sueCvabuaMtVldHGQ53uEFjVijUr6+Je+4hyqtY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(6862004)(8676002)(81166007)(70586007)(26005)(70206006)(44832011)(8936002)(336012)(7416002)(5660300002)(36860700001)(356005)(83380400001)(2616005)(16526019)(53546011)(316002)(6636002)(47076005)(1076003)(186003)(426003)(36756003)(37006003)(54906003)(508600001)(2906002)(40460700003)(86362001)(82310400005)(6666004)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 15:41:18.0222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8dacfca-4a51-4fb8-1428-08da24768ae2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1421
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 10:15:08AM -0500, Tom Lendacky wrote:
> On 4/22/22 08:56, Michael Roth wrote:
> > From: Brijesh Singh <brijesh.singh@amd.com>
> > 
> > The GHCB specification section 2.7 states that when SEV-SNP is enabled,
> > a hypervisor must provide the AP jump table physical address through
> 
> I missed this on the first version. It's not the hypervisor, but the guest
> BIOS that directly provides the AP jump table physical address, in our case
> OVMF sets the address in the SNP secrets page. This allows communication
> between UEFI/BIOS and OS without hypervisor involvement.

How about this wording for the commit message?

  The GHCB specification section 2.7 states that when SEV-SNP is enabled,
  a guest should not rely on the hypervisor to provide the address of the
  AP jump table. Instead, if a guest BIOS wants provide an AP jump table,
  it should record the address in the SNP secrets page so the guest
  operating system can obtain it directly from there.

  Fix this on the guest kernel side by having SNP guests use the AP jump
  table address published in the secrets page rather than issuing a GHCB
  request to get it.

> 
> > the SNP secrets pages.
> > 
> > Fixes: 0afb6b660a6b ("x86/sev: Use SEV-SNP AP creation to start secondary CPUs")
> > Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> > [ mroth: improve error handling when ioremap()/memremap() return NULL ]
> > [ mroth: don't mix function calls with declarations ]
> > [ mroth: add missing __init ]
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> 
> With the commit message change:
> 
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
