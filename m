Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679694E4579
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239886AbiCVRux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbiCVRuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:50:51 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2117.outbound.protection.outlook.com [40.107.21.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9929850E18
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:49:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H01Dai/375MeHwz1GcuH757FNMsYXiAbMf5PXmE5Az4joWtQ8ZeeZucjacl/CsAHUCyt/dUyX5lBKITFUZMF1V9HwNS9w/irdLSELV1GPQYqMOGhY4ZKp0L/roMQBZMmZXwxoPd/mCLTbrPDvMNOcBhsHJsBc/y2lZbBbfwoX9tYN3+/lJF6G79QNrwcecmj8SjcjJjVzXnMSjQ1hhLKmiS0Cu/c8rSkcRbi8paARpUEN/7K6dO+CaKCE6LMOEujnGzadzjLwb1kHpFHHEPsnLILo/MpZ5BIEM7sZ46C/sXaBy6WQlMjrLyPU7OrpjzGoW2vEaoq49TYv5yyVDh+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lz1WgASHEPA0X44O4lXZ8izyH3gOZX9SdR+3QGWNn/g=;
 b=ePsqtPEj0jV4K9PlHHZBnU5vtk3dJFXzbt3MEnV+U4KvYufOapAduNquMYDLgieP0T+2UIPwt5eXYtTkXrEaO9b8rDaX3hNjJgyXhfMhVklsB3/gZ57bB0fHAdmXd6y/We3dwRW5gF1JPF/79TaMSH3sxpcRmYwlts9ngCAn8R3d+ilrvjtoDBYruNqDJMC12JcePTzt4nRvOk49ovLmgwFTPM9kuqk80nM0iQz7wncF/9DofohYKTsS+azwsFsXy9xUyseFW2NYYatX9JkTlkF66TwS2k2oSuEBsGc0fMAKqREJwnN4qCuD4srs9q5CRmkBV7i7acfGhXahp8Ww+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lz1WgASHEPA0X44O4lXZ8izyH3gOZX9SdR+3QGWNn/g=;
 b=aQqgkh1rtfRqNsKWPJRkGoyerFcRZhvDZD7H1eZWX15HkCM7r101bbUzinaIM100D7amQ/0UAjW2sAFWggCSSGPOnc1RYNiny6kGdj+jS88OBKbbe6HvjRPXgYFfovw9zO7CPW8v1DEqWtkOV6I3cb+pCFP0bq6WrlXztvnOGyw=
Received: from SV0P279CA0031.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:12::18)
 by VI1PR0702MB3582.eurprd07.prod.outlook.com (2603:10a6:803:4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.7; Tue, 22 Mar
 2022 17:49:19 +0000
Received: from HE1EUR02FT060.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:f10:12:cafe::44) by SV0P279CA0031.outlook.office365.com
 (2603:10a6:f10:12::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16 via Frontend
 Transport; Tue, 22 Mar 2022 17:49:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 HE1EUR02FT060.mail.protection.outlook.com (10.152.11.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Tue, 22 Mar 2022 17:49:18 +0000
Received: from localhost.localdomain (192.168.54.188) by mta.arri.de
 (10.10.18.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 22 Mar
 2022 18:49:18 +0100
From:   Christian Eggers <ceggers@arri.de>
To:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: CONFIG_THUMB2_KERNEL=y boot failure after Spectre BHB fixes
Date:   Tue, 22 Mar 2022 18:49:17 +0100
Message-ID: <2109354.irdbgypaU6@localhost.localdomain>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <YipOoAaBIHjeCKOq@dev-arch.thelio-3990X>
References: <YipOoAaBIHjeCKOq@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.188]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: daec52f3-af3a-47b1-b7a5-08da0c2c4a2b
X-MS-TrafficTypeDiagnostic: VI1PR0702MB3582:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0702MB3582572F510EE637C6DE4E7EBF179@VI1PR0702MB3582.eurprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: djoN/lAQ7IKvvVQZzrv7VMurB7NwZ5W/O3XfHylI5QYc4goxoyryrVC9HiszNn8BbHl9NP+pjaL1B8WCPUXvzXgG9P/z+uX5xJAoOTcrg/x+WHsIkOpzt91lfcOKzn0/eXf1yJl43MNN9yJCG2o+F/XNhoXwLDwnRpD87fZqjVKsGZzCCPK6PAF4u6dtBFtLsoWUWdykYfa2W8tA6oBGSVdROaiVWkx5ZZ0SxdyxfKjd9JoZGTLBGSFs+Yjtb/Q4o4Ylvip3gN4Cj0hT2IUaPyz0+z2yB5WNFNhYJqblwDI5V7UbWLR4yAIgYtFqMa5FEOaBl1MxIDfPmhVNtCGvGBzWAfNpA8HsrE41BGKB71DlXNX/Xhw/xHiz+mTqtaafcJ/n23cPZyyF4wuvs30JzjT1vGo6Y2/fYnIbIOetDUw2dnd7V7KMBNljPL5fpiG625jPROAdEJASxwdyWkDXXPhn3YOTJsMZN4EQnRqUAOnY9MPBv4R/KybUGW6AcRHJJNzFiaoUesKZ6TPoXz7RjQDXjziGf23QJPEZankWF7zOTKF/+dhDTMaDF96LOgjA8B5GpNHn0g0wujQKBtZN3V4ACCaEeU6UnnPel3MONyvU8F6D/Kvc37BUHLnbsDG27qs9Lfgw5f5nC70Xxw6a11guAy1hNC8W9Y0DYlGGswuwMXe+DeQ15HMfN1NAMOZd2jaGYmJaOzEhfXUuNkl2qRjMh2Tbkx0qtRGHyAFDfo5ByU0eq8UFyu4M8MxYv81aIA3lzubiRwiMWjbgy5wFCsgnPTnzB9vmxC14W8yIqXFojpBdnigtltxuG9fBZgtSLDhvauH23m27DEAwR/hUCJ1j6ihe5180CH+BCLnHY28BWuaVwCFsE4x7DHwcABXg
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(110136005)(54906003)(8676002)(4326008)(508600001)(70206006)(70586007)(316002)(81166007)(2906002)(356005)(186003)(82310400004)(9686003)(16526019)(966005)(26005)(83380400001)(47076005)(40460700003)(5660300002)(8936002)(86362001)(36860700001)(7696005)(36916002)(426003)(336012)(55016003)(39026012)(36900700001)(2101003);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 17:49:18.8096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daec52f3-af3a-47b1-b7a5-08da0c2c4a2b
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT060.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0702MB3582
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan, hi Russel,

I stumbled today over the same problem (no output on serial console
with v5.15.28-rt36). During `git bisect`, I had also some commits
where a few lines of output were visible.

At commit 8d9d651ff227 ("ARM: use LOADADDR() to get load address of
sections"), the system boots up to here:

start_kernel()
+--setup_arch()
   +--paging_init()
      +--devicemaps_init()
         +--eary_trap_init(vectors_base = 0xC7FFE000)
            +--copy_from_lma(vectors_base = 0xC7FFE000, __vectors_start=0x0, __vectors_end=0x20)
               +--__memcpy()

               copy_template.S:113 
               ldr8w   r1, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
               r1 = 0
              

With the final v5.15.28-rt36 I found out that the system boots fine
after disabling CONFIG_HARDEN_BRANCH_HISTORY.

Is there anything else I could analyze? My SoC system is a NXP i.MX6LL
with a ARMv7 core. I have access to a JTAG debugger.

regards
Christian


On Thursday, 10 March 2022, 20:16:48 CET, Nathan Chancellor wrote:
> Hi Russell,
> 
> Apologies if this has already been reported, I did not see anything when
> sifting through lore.kernel.org and I can still reproduce this with
> current mainline (1db333d9a51f).
> 
> I noticed a QEMU boot failure with multi_v7_defconfig with
> CONFIG_THUMB2_KERNEL=y in our continuous integration [1]. It does not
> appear to be compiler specific, as it reproduces with a bunch of
> different clang versions and GCC 11.2.0 (I didn't try other GCC
> versions).
> 
> At commit 04e91b732476 ("ARM: early traps initialisation"), everything
> boots fine.
> 
> At commit 8d9d651ff227 ("ARM: use LOADADDR() to get load address of
> sections"), there is no output from QEMU at all.
> 
> At commit b9baf5c8c5c3 ("ARM: Spectre-BHB workaround"), there is some
> output but the boot still hangs before init. I have included a log of
> the output of QEMU at this revision along with the command line I am
> using, which comes from [2]. If I disable CONFIG_HARDEN_BRANCH_HISTORY,
> the kernel boots.
> 
> If there is any further information I can provide or patches I can try,
> I am happy to do so.
> 
> [1]: https://github.com/ClangBuiltLinux/continuous-integration2/runs/5496036256?check_suite_focus=true
> [2]: https://github.com/ClangBuiltLinux/boot-utils
> 
> Cheers,
> Nathan
> 




