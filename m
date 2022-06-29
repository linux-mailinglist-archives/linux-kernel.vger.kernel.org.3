Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE9B5604B7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiF2Pf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiF2Pfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:35:55 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AB92FE72
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zl6fMy3A5UVUF3KMUDs88pbpkptVnVGs0ksZQR64dPq9iiW6ydZjcKzfLaw3uxvmFUdWeNgRtkO/BDulRYKlcoTKvaBV7attNzdhnF59guHfsKcJFUeXbsVGuq45Q3S8Dhd+hArYNpV1d3MLJRfBJfWhDPYcme144bKkkxEF+3caSyXYsVX/Lq7dZD7tEYsGAysckhTuoE1sU11munzVAEHbj7nEZethjGyCuf1rDbQAb9kOEsXsnzO6LUf+vIeKsZ241Ra83n8BLA2L0dOZToGNM1BxFaKdJH7+14wdTf+SYw7xFKqWWsgbaDo/WiBN/fKokW0qu58sqCrhIcKnuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+2ULGKxk0AmZZnVIJZlKexq7/p5hUhlD//9M+BvKuk=;
 b=dJi2+85CNoIbvr/+RQM9Of6pIJEMXuCfyUJvkKGFfuI+Qj4BlCfd0C9cgGqKVl+WNnYKpvIFmF19h6tXZUo+/S0rclOzJ90FOglUPRy+kFvucTA5l64c1NpQuFIHIVRTk86NEIbbxi10pQvlyHmnCvhpN+kY6XH9b7sbzZmlpx6ETBd1fzHyf/CvnV1itomfDRmdozOLo1ZmH2nxmWGEu1A5NynSx6MFDEGvLqhZoBepYKFjnbREONLWNPS/g96U2k9EoAiPm3ROW0v1NmvKtJRBNJfEyaa6uKkT9TYaqCUOOHtYslZyu2jkdW2xZkMXvt2kbSWuewKBqGVBXiAhRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nec.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+2ULGKxk0AmZZnVIJZlKexq7/p5hUhlD//9M+BvKuk=;
 b=SGAT/satKWt7Lqnw7XEX3Xqz8sapyYW0kK3Kgphhwr79+3V1LRInfAGdWTuJFjrY+jVcsh/2T8kk0HKKATlVW3qG3IBZo5RJEcfx8kM1wm/AsWD5qjO/57CFeaRq/cg7LWBSSNiBvBwpYzm8b7yQl2MmYywcjpQoPr1QQTy62pw=
Received: from BN8PR15CA0048.namprd15.prod.outlook.com (2603:10b6:408:80::25)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 15:35:52 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::45) by BN8PR15CA0048.outlook.office365.com
 (2603:10b6:408:80::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Wed, 29 Jun 2022 15:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 15:35:52 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 29 Jun
 2022 10:35:51 -0500
Date:   Wed, 29 Jun 2022 10:35:35 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     NOMURA =?utf-8?B?SlVOSUNISSjph47mnZHjgIDmt7PkuIAp?= 
        <junichi.nomura@nec.com>
CC:     Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [Regression v5.19-rc1] crash kexec fails to boot the 2nd kernel
 (Re: [PATCH v12 38/46] x86/sev: Add SEV-SNP feature detection/setup)
Message-ID: <20220629153535.ivrp2x6j74cnpsv7@amd.com>
References: <TYCPR01MB694815CD815E98945F63C99183B49@TYCPR01MB6948.jpnprd01.prod.outlook.com>
 <20220629004114.zn5rurrmqdkiceun@amd.com>
 <OSZPR01MB6953EEF3F8E63330547E031183BB9@OSZPR01MB6953.jpnprd01.prod.outlook.com>
 <YrwLS8qRDhjmeD5Z@zn.tnic>
 <TYCPR01MB6948029FAACBC313063EE49283BB9@TYCPR01MB6948.jpnprd01.prod.outlook.com>
 <20220629135254.cicvyp5clm4s4n35@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220629135254.cicvyp5clm4s4n35@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88c63ee9-b8e5-4a83-972a-08da59e50cb4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4336:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rPWgRj0Dx8dRl9zuCg61qG507HaoMM/C9VJwmRQyyzps9I1DPwJZ7ypJG36ucWEhaaMTMyut1ErPtaxhIkc8BU7qWvIfNn/ZJZOdxuPO9TYnaz476orXwEsQwa/cCjxXVGncldelkHQd7EwGly4zymmlJs18920unYFH57lFZWGUnrxn9gXl/JJH6xH9+Qy5qlkNJoY8y7Qeeqg07xMB/lqUr9xj91aIlJuNfiDgnkI+orPnJiaPOpbvldjQ0xh+OZ95htpUh9+HvCMj71OyETKNN8rKfcZzbCkU/CoaFUs4cqXkLmYT3T4Z/1EgjIqFdhIOqc841eyA+RpAXNqe5dbhkhUxI6ZGUWFZB1jrPkp+Bcv4qZdqqitpAF0yveSZzWMmugoIkWCDHw3+E9l2IAWy8zjzrQ8gI7zr1Kl2uSGRsfUwChCSMiTm6CB7pFI9ddvGKen8/wRyNEPm8vNywfSRV/aHdaR2uh0hwfIOQqQTvdSxRWwLu1U80WE0JBhhTo5I2tKdt+6kc1fUUqCUyXL97fsDsj6ET47j1F/HM/Vhgjm5d8PENeD5dlpVl4piJ9BAQIgLEx4obgBQ7FnPYIQETthp1rohGMjemA7cGHXfkyNYzjCYYYy+n1Sf60ay/e5TgyaK7miT3sKHk73VFXxdxpr2KCDlfKZ2cKrRTzC+TXYv9A00nvN7UJd7jHF5Ao5+iz9dNWXrF4fTP+Obg2Sw7vUZZLTDLC0VlEOqInJ3Bx8VwfL/2GL7VQPEWXBQIQUO1FGfaZDtMddSUhyexHuz9DLQHm/t1Qwx2/fTRFBbs8vssHwsJYiQj9csgszdx7P/Ir9UDzjrF7dIy0Ac/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(39860400002)(136003)(36840700001)(40470700004)(46966006)(81166007)(82740400003)(356005)(70206006)(316002)(70586007)(82310400005)(36860700001)(40480700001)(36756003)(4326008)(8676002)(40460700003)(5660300002)(86362001)(186003)(44832011)(16526019)(426003)(6666004)(2906002)(47076005)(336012)(478600001)(26005)(54906003)(2616005)(6862004)(8936002)(41300700001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 15:35:52.1109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c63ee9-b8e5-4a83-972a-08da59e50cb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 08:52:54AM -0500, Michael Roth wrote:
> 
> So the runtime kernel relies on boot/compressed for handling EFI, and
> simply uses boot_params to pass that on to runtime kernel.
> 
> But it has its own handling for cc_blob passed via setup_data entry,
> because that entry point is meant for boot loaders / VMMs that use stuff
> like CONFIG_PVH to jump directly into decompressed kernel: those are the
> cases where we'd expect cc blob via setup_data entry. But this is a
> critical thing to support right now, and if we can't find a proper fix
> we can simply disable this patch and not check for setup_data entry in
> runtime kernel.

Sorry for the confusing typos:

I meant to say that this (setup_data-based cc blob for decompressed kernel)
*isn't* a critical thing to support right now, and disabling that boot
path is certainly an option if that ends up being necessary.

But I do think the boot/compressed issue with how it doesn't map setup_data
entries into identity map should be fixed either way, as it seems like a
latent issue that snp_init() just happens to be the first to trigger.
