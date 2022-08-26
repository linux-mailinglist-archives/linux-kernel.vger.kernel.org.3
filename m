Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFE85A2997
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 16:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344516AbiHZObp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 10:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbiHZObU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:31:20 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4C2A99CB;
        Fri, 26 Aug 2022 07:31:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=of/gqpvWv8A6YftqAd+8QXejWzCVHuztxKRErEW3L/lCmgsELsYceLUQunQsBi33rB6EElCrIjUFXVXvUoht2IpVH/yPfNRsw5Nq0fsQnFTuKhv949lIgHejkMQeYZNlMfgdIHGNDpVot3KxVdeH7VKfSNwup8a5AtoFRv+NF3bVL7889fLUdt8zNokUvLn1FL5YViIJHzR077n+BIHQ73pNTl+mkoBeSvicb9pQjxRAGijFQvu87LTZJ3krUgXJ6zSCqQKV6+Y6G+fOZ4BkNlnRTfbaimCEhajLIzG3v3/7Nzi8p0yVzgoHuciOUEEP2ohdpfA/qhQXXcmYwMogRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Grks+zfCveB+vrBBR9kTXAsZgU5fBDtiiJF4DP5R+Zs=;
 b=E/FoWx6MYB2tekHPavtGXchRMYWZy7No1/Gf/BZpX/4ZlHK42WzAbVkLOr6fuueTkDR4U6bpoYAFgSHzAXuF2f/iyPYUltyxrjOwTtVc9bxKNp0pFf7eDynS7eexIbPHh1c8/OQ/3dpekw02AVyygZACoGTOrv6uU80J4beC/pS0s9iUouxI655iOUVxb/16HN0yxw8OWJwXzlfgVhCtJyEhN4bo/hrGLz5cSEAHgIefZQtvQDGwyd/s332S3TJBjEeMu8EFFzvy8dzgtF3OK36uibT1s42WIaKxgccYMPwE0Q6U8pklyW4dkFzvG90u7NM6GHdnku66igHL5THkjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Grks+zfCveB+vrBBR9kTXAsZgU5fBDtiiJF4DP5R+Zs=;
 b=zRRb0iZ88t/KXaQzfl6FOeHrRKlFAE1AnIRBrKcTspE7Fx8wq481Vgg5GinwOvgZSm580SCja8buMN/ItYxqKDDQ7AFPvxf2dnAPbmgKizaDd5fVU7g0i9RngI4/5ca3Wzs1TY3N7/C7BsRH3tJ0MxsAfOpgAv13w7+BaURaIbQ=
Received: from BN9PR03CA0131.namprd03.prod.outlook.com (2603:10b6:408:fe::16)
 by BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 14:31:04 +0000
Received: from BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::28) by BN9PR03CA0131.outlook.office365.com
 (2603:10b6:408:fe::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16 via Frontend
 Transport; Fri, 26 Aug 2022 14:31:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT093.mail.protection.outlook.com (10.13.177.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Fri, 26 Aug 2022 14:31:04 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 09:31:03 -0500
From:   Babu Moger <babu.moger@amd.com>
To:     <reinette.chatre@intel.com>
CC:     <babu.moger@amd.com>, <bagasdotme@gmail.com>, <bp@alien8.de>,
        <corbet@lwn.net>, <dave.hansen@linux.intel.com>,
        <eranian@google.com>, <fenghua.yu@intel.com>, <hpa@zytor.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <tglx@linutronix.de>, <tony.luck@intel.com>,
        <x86@kernel.org>
Subject: [PATCH v3 06/10] x86/resctrl: Introduce mon_configurable to detect Bandwidth Monitoring Event Configuration
Date:   Fri, 26 Aug 2022 09:30:50 -0500
Message-ID: <20220826143050.6704-1-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3e6a0f42-86a3-18f3-1b6c-0e98791324e4@intel.com>
References: <3e6a0f42-86a3-18f3-1b6c-0e98791324e4@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2be31069-afc5-4678-3e55-08da876f9b71
X-MS-TrafficTypeDiagnostic: BY5PR12MB4179:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JL/fIM26iLxZ0WTA3a3w05CMr+ZOUPQhNcDZFtS2dUiAYRC6LC/6+C/ZrwH8Bg3H+4DwflpaBnDIBgFEZWwPKs4P/DvFoEyUb3rzs//Ta1UuRepQWIxyp9X6eT5e9f7Gt4knkVeDwTAgEiuMqwH0xm+HJqXYcJt65pk0w6ATPevp/tohUORJ0qvrZ52L/m/H6KSyQSWpqsImCR9XkpgkuUOesrz3aa0oq0C7HppK9NGj5kazpmn9wPRG+FU85PEJwmtqzIhpRGIahRqxc1LFcch3CMtcF03DDz9WrqZF7DoanR7fNQUkjHS5vouQwLCfC/xCS1VFBnH3HgbnTnXxPGFGREOSbF7cy8geOetagVRUWfW97XC6WhZbA9nyMA9Dy0JoyB5ehIOm/5zOIIe2zia71sGpsIBBWY21tfbJHwzhEGMAZaE0tgjyMUhov7UcIC733aKCsFNopQhXbVNI6lKanBB5Lj54WhgAuMPlRH+/K8YZyq/Ylc9CaIBEO6bPq/AGQ9ryvdoTqal2QcAKx1H4wGWh3uGlhmOjBKU6jCE/J87PFtrdmwdvarM8wAH7jnTivHiIG2DIqA3O9mapJCTDovmCzcv4zgp1u9DqOvhgMV8Zj13tdt8R8DIkEPVaIRXDPu0ZTYmZmBt8350GhUSjGjEzWc5ypZ7L+8e49wq8OqGxaK39CQeOTFDUcD6mOcgxzALeXrTgUKBemmhnIhbB3ZAWnpoEbKwo5NbOVj8GvRDAZZ6QMUWZSvWJf/Wo4SYvKlqTObE88HId2OkBMYpHFYM3kdd51hzLmH7yLUl5T8BNyxAPsF7LX5NcZC7b
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(39860400002)(136003)(36840700001)(46966006)(40470700004)(186003)(82310400005)(2616005)(1076003)(47076005)(83380400001)(5660300002)(2906002)(426003)(4326008)(44832011)(7416002)(8676002)(70206006)(70586007)(6666004)(36756003)(40480700001)(41300700001)(478600001)(16526019)(336012)(558084003)(7696005)(26005)(8936002)(356005)(81166007)(86362001)(36860700001)(40460700003)(316002)(6916009)(54906003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 14:31:04.3793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be31069-afc5-4678-3e55-08da876f9b71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4179
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,
   Some reason this thread did not land in my mailbox. Replying using git sendmail to the thread 

Yes. This should work. I will try that. Thanks

Babu
