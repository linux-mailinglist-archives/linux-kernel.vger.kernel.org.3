Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C125601C2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbiF2NzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiF2NzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:55:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7881AD8A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 06:55:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNB7muVPw4I0UuNhIjfixU2nwGkS2VxOESxYBDlx8tmehJyI624PccMeucC/K7yI+UDaW7QGyXYF657IRfJBVNFQ9TTT/SO33qitDI/ylKX4rebu2/jfMKTygb4UXpCV+aciLcg72mVmHn4AsT2VbKXVyNdMBo2RsZ4oCo3F+IeF96NBqYb2bcjgMIIrYgclLbszEd53p+qV4KYgzdwZErkJmjukHSC72J9gqpmNwqKYFLj8Q4hoIHV/uU/bAD9/ejkmrXrTNUWZLQ4uZiNazdzCnVFT6iz3I2HoWsfgxzxOZZ2ovA4hMU5Gyyd/s3Fm6GCz2u3n3iD9UnTq3dLLcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afaMTYxn6b7zYOA9v6tKgtU/gh+nPo8T+O5aupbQKxE=;
 b=A6iAe/Eycw+WpKB0f7t3aDDg4aoiurQaMc9Dx/rl4M101PeOq2YK2UNdZkUeh8XFK+kFCsbU40EGUf8pPtNkwFT93UTYMF/sr3ZPSZa4F6vT/Rd50IKZUUMnByDmT7WzbFzDzBKoKyXAQIBkKrP5m1K89qZ7Qs5Ob+i9wgw/8+97JPOm1SlZvCmezYUeDawsueqzwjM1c5MUHKrjTmQEXN4GT3xo+jnzSs1VqtBWEeAjXbQCxxN5LXaQ35SaGBQXt4PwHEUCbQD0D66b0j5bDpUHLBiFE4b0WC07dkqP3ULL/zT9J4gAZjyGfK0BSq9FeqJs+hm5runkhfWH5xc1pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nec.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afaMTYxn6b7zYOA9v6tKgtU/gh+nPo8T+O5aupbQKxE=;
 b=xFjXM0h9f56SkxsXr3hHLkN63isaDjSbHAxxmhsIdkPGXAdaahgKjiQo4tby9lKGKOg85cvbZcuA8WiXVgvp4uxUH0M5X39ZpL/oZgt2OHn33SnKE6kNiASXkhWEz3ptZ7f5eHE9wMG+I07LIuLBTAkzs9L/od3AUvPkMH4uLh0=
Received: from BN9P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::34)
 by DM6PR12MB5517.namprd12.prod.outlook.com (2603:10b6:5:1be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 13:55:06 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::a5) by BN9P220CA0029.outlook.office365.com
 (2603:10b6:408:13e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 29 Jun 2022 13:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 13:55:06 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 29 Jun
 2022 08:55:01 -0500
Date:   Wed, 29 Jun 2022 08:52:54 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     NOMURA =?utf-8?B?SlVOSUNISSjph47mnZHjgIDmt7PkuIAp?= 
        <junichi.nomura@nec.com>
CC:     Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [Regression v5.19-rc1] crash kexec fails to boot the 2nd kernel
 (Re: [PATCH v12 38/46] x86/sev: Add SEV-SNP feature detection/setup)
Message-ID: <20220629135254.cicvyp5clm4s4n35@amd.com>
References: <TYCPR01MB694815CD815E98945F63C99183B49@TYCPR01MB6948.jpnprd01.prod.outlook.com>
 <20220629004114.zn5rurrmqdkiceun@amd.com>
 <OSZPR01MB6953EEF3F8E63330547E031183BB9@OSZPR01MB6953.jpnprd01.prod.outlook.com>
 <YrwLS8qRDhjmeD5Z@zn.tnic>
 <TYCPR01MB6948029FAACBC313063EE49283BB9@TYCPR01MB6948.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYCPR01MB6948029FAACBC313063EE49283BB9@TYCPR01MB6948.jpnprd01.prod.outlook.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64ae7be6-6094-4606-ce86-08da59d6f8f7
X-MS-TrafficTypeDiagnostic: DM6PR12MB5517:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jObw54JnncEg+Gjh4RYpMbQrL/xJpST3wUI7r5WLOHVS3gIRfeQaG32R3DUFrLAu5pLmSkjF16EZ3ew2ArnFxWx7ObjOgSBLmYeGhBMx9fOjJ0VJoR8Awh8RYdU5c7L70BvX9G4TDSlXZrTHAJpzgdq21NcI6pqFjC9ljs/sRhF/Z1x65Ch2aiMNn9NHgF1j9uKMYHJ9WibcZroLCelEvHD1Cd5N2Yf25xo8pCv9cOfYlNAkIeOjTu/ebIqYdV/TF7sSOy/v45uGWJcTiw28jfeyIgGjNKB17A56/0p1B8n9imNQmT035tr1xHDmVXnmEFiLCNlx7gK2dqtBEFA5hE5/ZvZXSB7q2zHrOSO1kWUnrZR1COPNVK2cf6ITgmQN6eTpUFy4z2ZAnCZ8CBqyifxMQtNu+A6LcIpCqUjuBmBDj8gKQR5os//f7JNWMU8xdMUU8sfVsaFQOPlLqjx92E+IQSbYPcgwI0p5fbJ/7Upl/09CRXJ7Bpi1UxaZVdYJDJale//QomXYnJ/6CCb808rypg+gNfFD9hm8ZfUSrrVkULSaMVxPEiPPo4DmUCWvSKxIBzuYiPvBsRaWZL70aAdslLBjCyMRLp1rOniUokYHz7MmV5KqBtPOAqtNt+6i6aHhehO+J1R16f+hYzXVUlkOke+IGL5abXHdnTNoFLH6Gqz/5jp47hqNv+Y1FLVD/eUmOSmecl5AE1z53QM79xo5U5GxaKcLL1UCAxuOyLY6f5TbkSK5Oy3+AvxiURlVZ6w/kTfKBv4m+rv+c/ilnzrByPzZyqhM2qVvSn78SnnQG2VKxC9L7L2z8rp+0qWm2ZTNk8j8/+eGzD9MbDkHXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(39860400002)(376002)(40470700004)(46966006)(36840700001)(82310400005)(186003)(47076005)(81166007)(36756003)(2906002)(8936002)(356005)(5660300002)(16526019)(83380400001)(6862004)(54906003)(316002)(336012)(2616005)(1076003)(426003)(86362001)(36860700001)(70586007)(70206006)(44832011)(8676002)(4326008)(40480700001)(82740400003)(40460700003)(6666004)(26005)(478600001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 13:55:06.0584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ae7be6-6094-4606-ce86-08da59d6f8f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 11:06:00AM +0000, NOMURA JUNICHI(野村 淳一) wrote:
> From: Borislav Petkov <bp@alien8.de>
> > I still think the proper fix is to not execute that cc blob code on
> > anything but AMD...
> 
> That will solve my case but I'm afraid there may be people with AMD who
> hits the same problem.

Yah, I'd mentioned to Boris that I was only able to reproduce it on
baremetal Intel system, but that ended up being an unrelated issue due
to having KASAN enabled in my config (which seems to break kexec for me).

But the issue you're seeing I haven't been able to reproduce, and I'm
not sure what is needed to get it to reproduce, but it might not be
Intel-only.

> 
> Isn't it possible for boot loaders to pass cc_blob_address via boot_params?
> Information included in struct cc_setup_data is just 'u32 cc_blob_address'
> and it seems struct boot_params already has a place reserved for it.

We were trying to avoid exposing cc_blob_address to boot loaders
directly, since linux boot protocol seems to prefer the setup_data entry
for new parameters.

The reason the kernel uses boot_params->cc_blob_address internally is
because boot/compressed has all the helpers for early EFI parsing, and will
have already checked for the cc blob and cached it there, so the runtime
kernel just uses that instead of trying to introduce all the early EFI
parsing code into early boot and redo'ing all the parsing that
boot/compressed has already done.

So the runtime kernel relies on boot/compressed for handling EFI, and
simply uses boot_params to pass that on to runtime kernel.

But it has its own handling for cc_blob passed via setup_data entry,
because that entry point is meant for boot loaders / VMMs that use stuff
like CONFIG_PVH to jump directly into decompressed kernel: those are the
cases where we'd expect cc blob via setup_data entry. But this is a
critical thing to support right now, and if we can't find a proper fix
we can simply disable this patch and not check for setup_data entry in
runtime kernel.

But I think we might still be able to fix this properly, I had a typo
in my early patch which would be worth try, and might avoid future
issues with other early setup_data access in the future code. I
responded there with an updated patch.

-Mike

> 
> -- 
> Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
> 


