Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D042B4821DC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 04:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242622AbhLaDhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 22:37:50 -0500
Received: from mail-bn8nam11on2131.outbound.protection.outlook.com ([40.107.236.131]:9953
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242612AbhLaDhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 22:37:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/o358OS1Bp1u7mdZD+htFEjLLQBKBXSU+WgwZh4NclUhYxSwc6uw8mgQvbULaNroTb5Gjb7Pvo8K5iN/juOYWnDNqIP47Y5Tz9Cj8mAwGV5GcznsImAAL3Gll8L1lB7Lt6Mbfy1OU2DKqn7X4tc+iP/qFNzYJ26aoKe5vF8CbYxc/7Zk6W5RSEkP7VKR2ElJ3VQYxC1gO1TyDWnQAQUOpbdZAHmH2wNUXRZRHyywLFDe9ptHSirh/fYQOC1XGksHxbSpO9y9b6OersoQ/SG48vtHUl467ZdIC9tdYyt4GvhHNny3bCoOSFIma+VDjuLdRT3bG8k99ylbdJQRnIgjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J33MtyHE1iQ/41qO0PNNzT0SlW861OU54rjcLB17rVg=;
 b=BFJpfGzZ5e06dx0Rl6ZPBhBYGB2z5ciQlkWTWwynk6rY1CTq3JnZVXyHa1TDcmXyt29BBLIlcAmRYmcmcumYJNyhIVtcfzyXi8xttq9WTYYBSs7/6847v7Z6P13FuxC6QwzIolpc6exB6BfE6UHTHGeUI9+9wocsT64aCTe7yuBwVOAX9W2iajRc8+qebsz1o6ycoB+7VGu4HvuQBqWPmsV/K+KGnGzuRGxAEiV2stbhkVLA2tS60yzci5NgaZWobGtsKBY2UrhithCHkhp7j5RFfnbIAHvGTV4UIxPb2V6qknmx2MMqGC0LDFtakQ3PNaitXdcT4/iXGHIAwAkdmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J33MtyHE1iQ/41qO0PNNzT0SlW861OU54rjcLB17rVg=;
 b=soXf0gMRjXVr/XeciTYMDwDA0mfOiRz4eHsq4B0OWEdXgjADyD+IKquvuWsqR86vJghzc9YVLzIaoPBTyRnE/PlgzHGqYfhncykhOsSqUf3qTzzB3p/4qpFNAk+UKtxbE9zwY51b6LFy7bPleaLcwrHqIdsHwp+hty1g6T93qzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DM6PR01MB4172.prod.exchangelabs.com (2603:10b6:5:2a::18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.23; Fri, 31 Dec 2021 03:37:46 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::38b6:2855:7c14:274b]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::38b6:2855:7c14:274b%3]) with mapi id 15.20.4823.023; Fri, 31 Dec 2021
 03:37:46 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, linux@armlinux.org.uk
Cc:     lenb@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        scott@os.amperecomputing.com, darren@os.amperecomputing.com
Subject: [PATCH v3 0/2] ACPI: Arm Generic Diagnostic Dump and Reset device
Date:   Thu, 30 Dec 2021 19:37:23 -0800
Message-Id: <20211231033725.21109-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CH2PR18CA0049.namprd18.prod.outlook.com
 (2603:10b6:610:55::29) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d1e96d2-36b4-4ef9-27aa-08d9cc0ee8a2
X-MS-TrafficTypeDiagnostic: DM6PR01MB4172:EE_
X-Microsoft-Antispam-PRVS: <DM6PR01MB41725629DE6EB54E63577F269D469@DM6PR01MB4172.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1g3KYaxmiMj5u6SoQ5dYSRr8+fw1AWdvdZLquqvO7iP9HDGgRizVoRn7F9t9NlYiEs9AcIMz/F6Rf2r4JbGQI/1ek3AkTO3ixRwrBWsbDR7iEp0HBvDcCY4hTzH0VhJmhU2YIQfp3O4XmRl7RYIXDx/L39lzYLJvKd21qjaxDLMzGme1fA4YFasN892fNlDtn22qMc17mGvBUY1ELYOfbZ6BHsL2t4Wz8Fk4OFvIfc6DDd5RvrZSY/otuI3Fjz5p4AKg46QjNyw0iLhw1b9+9Mc4GiTtIHtzzUhiTSza6CznLm3HpJ0M1sQYL8StALGOahSlW/8dNVY3QRsnp8S84IyHYP/FGe4YGu7Yqrun5Qj9TsOYsZIhHeNZa0BvKMvGCz/2x9e3cXVetRSayuPXumzBsEazyTesiW1QRA+vmsO1ViShZJRThcvSLPS5I7m6gqpruas2Va9grIFKQdIx2uZkyqaYqetTNQbL2wR8x9b+NfYn6DbBZlVoo3ypAqMghByiR/j/3NRh16KaVwqZN36+xNFWaG0OVHMIaEAqKxAtnmko1cUCzhxCLJrjUdm05U6EpDyRgDfPrf5YcxkyM1LKrM+7SGFz0gS/aBflcNzOsdi473FPW6smoRfFD9wpou+u4BLRGz1zEFpx2ZbTaagaHthu5LUjThxtqvl6ON3azKxvq3rgCq53ArU7kPT3otZJnJ9mde6PCuIQj4DT/YNS7zzNj8upxhnxwMvKR618AZflDMB7CNpbwI38tu5ozENyoPNc3j+C2zmmQGD9faCP7r4ZhEQih5OmOB7bUzQyBUGG0jkN9/5mSg2OW19t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(316002)(52116002)(6512007)(66556008)(2906002)(508600001)(26005)(66476007)(38350700002)(8936002)(2616005)(4326008)(107886003)(1076003)(66946007)(38100700002)(186003)(6486002)(6506007)(966005)(6666004)(5660300002)(83380400001)(86362001)(8676002)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?viwYgJD0ZW5wjVTsciyQLmC3UAdAp8BkONUw8sagSU4EcBfmlZI+xlBnw51e?=
 =?us-ascii?Q?EuO4mjr815gXQOxFvTvgYY5vxDAKYB95tZr5M9RXKMDKyjerUPa2pyCf/yV2?=
 =?us-ascii?Q?vGFTPCAgweZ34SKmh52qk6pTRF7KMh1ubxi9PKSEAXOKCma0c1db9POCGmB3?=
 =?us-ascii?Q?qMstXeztIlufZwg7hYgOTEXaR7GtnPQ6ar8BUbSpuFiSKvxWNzoBi5ydpnR6?=
 =?us-ascii?Q?s7HfwGEM+GD+rN7EaA+PPfevNuHNt4fABkb5Ny0NOoL+/fjxGQysp+xl+sy6?=
 =?us-ascii?Q?w+xCtihzsXcuqazN/jpKWXAd3heeIK614voqaMWUzZjllkzxJ48DoqTKUUBK?=
 =?us-ascii?Q?TFQPdDN1ph0hYbCCiD+c88KMYfz8LfzCWvH3G3Gghu6g7ogAR6fGSwiClzUW?=
 =?us-ascii?Q?hdYHWv0w6X4cV1+jYwaH6VOSbmux6CotMMYykNb4EJ32seTj5WCpMo+Wwypc?=
 =?us-ascii?Q?CVtEkHzJgshBJbi/SM9wDGAn+iFjX6cmjGXoxFJ/4RqgCxHweynSThTrP0wU?=
 =?us-ascii?Q?84DuAeVyUdxnyX4hxiKol6utc7bSBXGbvFuE7YYkbeXN/Mnn3GGb5eYWwvt4?=
 =?us-ascii?Q?rdvHMTWxf1mub2pU/xdFMck337+014XYBdrs+hNqp9Ys14RwmZRjmGbQizU3?=
 =?us-ascii?Q?MxTTC38Zk4S6AgJScUOiQv2IkOpWc6E9KUszn9itOQuW1pkb50oZ9CvDBmHx?=
 =?us-ascii?Q?1ieW0SAfqRrAkSNHE0Q/JJA/kM2/xkosea898PC0dnHgOY6h/cJabrK/Ieke?=
 =?us-ascii?Q?dovw4yFUdfavChu7xDrG7Dvpp4Ge1PYJnFDjojJgGYoQjmK7t3u0ZTDk6SA7?=
 =?us-ascii?Q?juhFcFg9EAXIiNQxz85OrQDzyEPaXybVhJ8wrVNfez+4nUmA9kZvS0vBudpG?=
 =?us-ascii?Q?/GKLOqO4m9k2UD6NalM9piuz3oRsPW9u/3LBtzHWYTBNE4/VzSbTZcIlsxhN?=
 =?us-ascii?Q?L1iVS1ARfeqbXLOFOpZf4Egcg0t8ZxlRY/qaQWG2Yn0hCNIG+KDA53yB1JsK?=
 =?us-ascii?Q?SeYmMuNnzycpdn8ja9nMvYw/TjWO40yBoW0j1ZrCk+HQUd63v2nwFESRNQxB?=
 =?us-ascii?Q?B4ChNEd5TZmmmE04avtPI6GxqN9An1j71hb4+SWMERctr1R9YJDsH/m2tebj?=
 =?us-ascii?Q?bESRawxkiNMJ7E9PRM36oQFryXjO6gkUKfo4yv4s0GLzgUPl+ys2HlAjHrb7?=
 =?us-ascii?Q?266Thom32gHsHFbKXceSfM7byVeF4EawJ5nR2fZET4YiyzkIuDQauQt/e41C?=
 =?us-ascii?Q?ylT2JUpIMBeXv/Rk9sYVuYKrtcUGBKx+zMwIfNs2Ws6ctvTSJjsEdEM0i/ef?=
 =?us-ascii?Q?Ghi6hFpfKoHsvxL5Fw+JgznRF8nKt5hugHMgCZHAVVxYYFgmlLCabiytCuMa?=
 =?us-ascii?Q?H3f6DPCXMprF06GR6swO/6C3KaUEBYlvsEwxrTDMkRvyWEhvjrvgbdAmP4kW?=
 =?us-ascii?Q?SFCkEDjDepPadaT2PumKB6asP2dhmLVlD6SdPxhusfXnkS/VWCefmfvGMPKq?=
 =?us-ascii?Q?hb15gX1Dki3ZGBvLYNI+3EoYN0Y3NHH6mE9hoInqfNMju/t64L8LL6BpcHjB?=
 =?us-ascii?Q?EjX9H3PXnal1ntjDmyYdbBlVoS1SeaIZGFR81iidlCu8snaFQxs39rlA5Zu9?=
 =?us-ascii?Q?FAbPj/RrBYzgC1jRX7twBFt3Gt/i82OBiLaV8NIrKapP/hm/S2Y3ANmrO6Gl?=
 =?us-ascii?Q?mKmRse76aGqDfwsv1WbqsEpFfM3jcKmoGAwS3na1bLaf7d6tqp6yjq5Rg46v?=
 =?us-ascii?Q?AVIWjAIrbA=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1e96d2-36b4-4ef9-27aa-08d9cc0ee8a2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2021 03:37:45.8716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Er0Uw0DqafMdOw79clj1rKLE41KaSVp8P24t+YPgeJUkXWzvwBeuAiiTVGZlbSskzlg2K2jZ/zPRl383Na0zg2L9gVITFGpS9axR/H5oyIJqAMh733gstfj8J6BpnSHf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4172
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm Generic Diagnostic Dump and Reset device enables a maintainer to
request OS to perform a diagnostic dump and reset a system via SDEI
event or an interrupt. This patchset adds support for the SDEI path.

I do have a patch to enable the interrupt path as well but I'm holding
it back since AGDI table is missing interrupt configuration fields
(trigger type etc.).

The recently published specification is available at
https://developer.arm.com/documentation/den0093/latest

The patchset was tested on Ampere Altra/Mt. Jade.

The patchset applies on top of
  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm bleeding-edge (642439a44411)


From v1:
     * Moved pdata to the stack and dropped unnecessary kzalloc() in agdi_init()
     * Changed the ACPICA patch upstreaming order comment in the paragraph above

From v2:
     * The first patch was split. The most of it was merged to ACPICA project
       at first and later ported to linux-acpi
       (fd919e37cb15914c6fe13e13d530a4f732407c6d). The rest are in the first patch.


Ilkka Koskinen (2):
  ACPI: tables: Add AGDI to the list of known table signatures
  ACPI: AGDI: Add driver for Arm Generic Diagnostic Dump and Reset
    device

 drivers/acpi/arm64/Kconfig  |   8 +++
 drivers/acpi/arm64/Makefile |   1 +
 drivers/acpi/arm64/agdi.c   | 125 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/tables.c       |   2 +-
 4 files changed, 135 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/arm64/agdi.c

-- 
2.17.1

