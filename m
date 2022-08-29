Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162F25A5789
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiH2X0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiH2X0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:26:20 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9A73CBDC;
        Mon, 29 Aug 2022 16:26:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3I/Ti6L8vEpMQGf3nxm2b3mcFkgptlybD1e1ZwVg+COmk5TnV9QqXbbYA3ypMVuuwaHtVPipwR+w5pFB2ZijmgE211TubFP0qxVHv4vUt0hrk7xvLcKNsAd9QhtqqBS0Feh4xLtVC0bnf/NKSU+924eHtmxjhXdtfNSt2sqSG/T0aRwJskGz64rDBtHsNKmuSYhqhvxPRsY9itFNtocGM38B0bbg7fWROcE8nvB0f5aA1LufidDTCaT6e68PYzDvD+3xocChMSKQnJvya45KDo2D1pHe6PdgqPWKr6Y5ofiWVUA3WdfO8uSZDjM97WsNuCq/n1W4ozmqSgZ2VJ71g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+320tQGUf7Wl5a9siG1UEIF+iaDu0H+Ea94hlGWMVXc=;
 b=Vs0LUDFZMpeYBroVYGRZEIYA9gbGgE/DH8aOldCr7KhgBaLpQSB30FYzeTAAEAwh0x6mne61qpyCaXSoE1Ev2dods9s1CHnrTp5Gfg3X5/H5Br8OcEqNl85zlAh21rO2gER8T3YjeT6Sbug5B5OYUFwWLXYRs4/7HbpKihJ4byEhfX7wn48E17We34jxwLIsfpuTrgc14fAVVi9FMMW/qA5DI9Xlw4L6bzoFPGhE1XRxwnHrz212Ksy9Kvl35C/n15nfgop5I4zs3M+HFdQ3QpsTUGDUPPRVYREfkStvl1R6Sjut5T07PTKU1Y3IfgSN5LI25141YopeKKYzlwY2Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+320tQGUf7Wl5a9siG1UEIF+iaDu0H+Ea94hlGWMVXc=;
 b=sx6/o4pS6NdkzebbHwXO7Vc+zA/gASiHbd5lnekWiwTJDRsiddJAf5gsmPAnO5n2K892BRZbF+AYHYbSkGrvAoKTzuwBSTPxAuy+B2UA/yky5DfWqkvl6zWvLqEmqJvLag/d/Pl1VzTVtgKTjIYfQIniX8GXaSOjD+SJap6+wfI=
Received: from BN0PR02CA0042.namprd02.prod.outlook.com (2603:10b6:408:e5::17)
 by BYAPR12MB4743.namprd12.prod.outlook.com (2603:10b6:a03:a5::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Mon, 29 Aug
 2022 23:26:13 +0000
Received: from BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::2d) by BN0PR02CA0042.outlook.office365.com
 (2603:10b6:408:e5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Mon, 29 Aug 2022 23:26:13 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT081.mail.protection.outlook.com (10.13.177.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 23:26:12 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 18:26:11 -0500
From:   Babu Moger <babu.moger@amd.com>
To:     <reinette.chatre@intel.com>
CC:     <babu.moger@amd.com>, <bagasdotme@gmail.com>, <bp@alien8.de>,
        <corbet@lwn.net>, <dave.hansen@linux.intel.com>,
        <eranian@google.com>, <fenghua.yu@intel.com>, <hpa@zytor.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <tglx@linutronix.de>, <tony.luck@intel.com>,
        <x86@kernel.org>
Subject: Re: [PATCH v3 02/10] x86/cpufeatures: Add Slow Memory Bandwidth Allocation feature flag
Date:   Mon, 29 Aug 2022 18:25:54 -0500
Message-ID: <20220829232554.53763-1-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <9965edff-c558-2962-4aad-3342480026bc@intel.com>
References: <9965edff-c558-2962-4aad-3342480026bc@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f35d53c-4001-4324-3ed4-08da8a15dc73
X-MS-TrafficTypeDiagnostic: BYAPR12MB4743:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +MygKWZVE3hO9Lqp9Usm8MQ0LG9ghftiqd3uldqIrTayTQt1iRB7e6dDkuOVyq6Rgv2NQzcXnVCiC4BHze2m6WBfm/L1Hiog0wz8QFYLAL+ECVg+DjbWEutZiQd3nXbngl6T7KFlukG+6ZTqBbBP1E2qeBksKfFQ+bBt+oryKjZ7JBOIwxS84hBGgp8AeWzw943wXX7W3ZLeB1B3Ti0VuDSYinfCo4rnAUK4Po1sdAWHRlCOw8N/f000xHhauISyzRPbFlse1OGwz/6qG8yptSXLULFK/m5uijhhSvkZ3mo6hnDhFhYTLdnXeiyubrziGgo40ZC9QW2tqom5BW97hParGwbzvh8Wzt5wpuMZ6WPO8UTvd6L3eHNhCOZYHlmT9AkKK99V7GnxmgtU0H+CZxqZSXCo3yvqw4aE1m+u2b8GWaAKvfERYyCJsrHtjilFZaBwQoGDmCrKyrEBa4r01aoPEM43Uihbnuofq/9jOyyCnQ3U7akfG1MZKQ0B7bkC20GRqAuH84wNTLFxqcs9/pPDHlm0JhsBmzDoQYBa5Qf/iCLdaM5If4flwNVnkE6CXNFEhuP585B+VM0WT3mLNwhVRO2nIkATa7HYcs04VuixMtXIeRXuApCgsjHeL9SyTeqr3ekOR6LRHgQ6jvL2+qroUZ2c+C6bCSWCv52r1MrxMwm4LvaYVvi8twJU/BVjP25AagLcqgcQrAy/4RXv9KmjX2pvTpKI6E31jurL5mkLi7B+q50mp1Q2Iq3xJULzaAkwPPxWFP3Fxe1icLht8ea09AXFzPgFjVgNky3QsNEnYk41TcqkreCdnNnfxH/+mXj7PpgOPLuzyfQjEffPjyeHGLCN2Brco8unMmmaTRUoKQtj84odtmvF0pjxeM58
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(40470700004)(36840700001)(46966006)(70206006)(478600001)(2906002)(82310400005)(8676002)(7416002)(70586007)(4326008)(6916009)(41300700001)(316002)(8936002)(966005)(26005)(7696005)(6666004)(54906003)(40480700001)(47076005)(16526019)(36860700001)(63370400001)(86362001)(83380400001)(63350400001)(186003)(426003)(1076003)(2616005)(356005)(336012)(5660300002)(40460700003)(36756003)(81166007)(44832011)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 23:26:12.3208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f35d53c-4001-4324-3ed4-08da8a15dc73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4743
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

>(snip modified links)

Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-quality-service-extensions
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537

>When you say "in this case", is there another case?

There is no other interface. It is only CXL memory device.

>
>Should "Slow Memory Bandwidth Allocation" thus be considered to be "CXL.mem
>Memory Bandwidth Allocation"? Why not call it "CXL(.mem?) Memory Bandwith
>Allocation"?

Checked with our team here. The currently only supported slow memory is CXL.mem
device. As for the naming, the "slow" memory landscape is still evolving.
While CXL.mem is the only known type supported right now. The specs says
"Slow Memory Bandwidth Allocation". So, we would prefer to keep it that way.

>
>I am not familiar with CXL so please correct me where I am
>wrong. From what I understand CXL.mem is a protocol and devices that implement
>it can have different memory types ... some faster than others. So, even if
>SMBA supports "CXL.mem" devices, could a system have multiple CXL.mem devices,
>some faster than others? Would all be configured the same with SMBA (they
>would all be classified as "slow" and throttled the same)?

I have not tested the multiple devices with different memory speeds here.
But checking with team here says it should just work the same way. It appears
that the throttling logic groups all the slow sources together and applies
the limit on them as a whole.

>
>
>
>I do not think these devices are invisible to the OS though (after
>reading Documentation/driver-api/cxl/memory-devices.rst and
>Documentation/ABI/testing/sysfs-class-cxl).
>
>Is there not a way to provide some more clarity to users on what
>would be throttled? 
>
>
>How does a user know which memory on the system is "slow memory"?
>
>It remains unclear to me how a user is intended to use this feature.
>
>How will a user know which devices/memory (if any) are being
>throttled by "SMBA"?
>
This is a new technology. I am still learning. 

Currently, I have tested with CXL 1.1 type of device. CXL 1.1 uses a simple
topology structure of direct attachment between host (such as a CPU or GPU)
and CXL device.

#numactl -H
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
node 0 size: 63678 MB
node 0 free: 59542 MB
node 1 cpus:             (CPU list is emply. Node 1 have CXL memory)
node 1 size: 16122 MB    (There is 16GB CXL memory) 
node 1 free: 15627 MB    
node distances:
node   0   1
  0:  10  50
  1:  50  10

The cpu-cxl node distance is greater than cpu-to-cpu distances.

We can also verify using lsmem
 
#lsmem --output RANGE,SIZE,STATE,NODE,ZONES,BLOCK
RANGE                                 SIZE  STATE NODE  ZONES BLOCK
0x0000000000000000-0x000000007fffffff   2G online    0   None     0
0x0000000080000000-0x00000000ffffffff   2G online    0  DMA32     1
0x0000000100000000-0x0000000fffffffff  60G online    0 Normal  2-31
0x0000001000000000-0x000000107fffffff   2G online    0   None    32
0x0000001080000000-0x000000147fffffff  16G online    1 Normal 33-40

Memory block size:         2G
Total online memory:      82G
Total offline memory:      0B


We can also verify using ACPI SRAT table and memory maps.

Thanks
Babu
