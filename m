Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84992467022
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 03:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378145AbhLCCrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 21:47:23 -0500
Received: from mail-bn8nam11on2091.outbound.protection.outlook.com ([40.107.236.91]:13280
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234870AbhLCCrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 21:47:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zx89z0xzY8Ab1WYdqo1aMp5sVnNsp5MKh7YxaNYubciqumdD4pIhvnmkpfn71AOZDqQAaEVmmfyKEiP8whjqvkShY41C/WJc8h9waut6A9iFRsFNOaqliVn/oQ4rq9PJBsc3wyqXzhGOQx2UkdGj0a9dkTPjgKsDyDrVcrYFbrGKxVb3unparDt0N1Yu+2OnGXWKDR0MsYkAWpVi5gY+egIng/o4KA4L6xgNtjcFynY2dQaqYCs5G8W+EZATpWyHI/OOgLcITWvkow9efd8gOyIMTIs3mQtTjI5pgyn00vIQhn69brdECCS7jTr8wz/oaUqa05e7+x2CgOgH6lDxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZuZReZQN0wIE2Qekg/UR9ccyTuYjc7DYVnDFzVRe+g=;
 b=F2IAtVe4Evu9THvbBdKToYCGgqJYJN46PztwdZpHsP0hiZCoXyVS93bRb8yl8t/gVaVn/ew47l7hLdS9nq52nLP1QTeM6r6p1ory2W9x0lkAlIsIzzNq4Fro42PLvJnh4YqndzOqkm+9Yce0Gi8jT0RzqpHVWE/uajetxAvlpSIkGK0IUrFgiWXb7QQdcVFBm2scO3YGw+MB1EIs/+vqDU8eNv101N9QyF6FRaussZon8Ev11JtasyO7iApSr+5rP4DaKdxWjY3E30IguaEfQsXrfd8PnLm2i7o9JZyHy4BUB3bEEH+CboZXNNXt/PrIoREuL9gsSe1T3/B4Irw6Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZuZReZQN0wIE2Qekg/UR9ccyTuYjc7DYVnDFzVRe+g=;
 b=UxfmiWStfS8L8vqUVu6tngClDqsVQm/q0TQOkdXjcjgVBeNJh6INI3OrzU67sUqpsXSMPNMk1Aho+5oCK6WKck6DDXdp4XXTd2hTtsLJ9a5RjydVGyJ1m0WM60MhbUPlWoZoBv0rdE+uM3ozjztS6evubD8A9NKYUnpZxgtvNaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DM5PR01MB2412.prod.exchangelabs.com (2603:10b6:3:3e::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.14; Fri, 3 Dec 2021 02:43:55 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::d93b:cd3c:bb56:33a2]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::d93b:cd3c:bb56:33a2%5]) with mapi id 15.20.4734.028; Fri, 3 Dec 2021
 02:43:55 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com
Cc:     rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devel@acpica.org,
        patches@amperecomputing.com, scott@os.amperecomputing.com,
        darren@os.amperecomputing.com
Subject: [PATCH 0/2] ACPI: Arm Generic Diagnostic Dump and Reset device
Date:   Thu,  2 Dec 2021 18:43:09 -0800
Message-Id: <20211203024311.49865-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0312.namprd03.prod.outlook.com
 (2603:10b6:610:118::21) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
Received: from eng01sys-r111.scc-lab.amperecomputing.com (4.28.12.214) by CH0PR03CA0312.namprd03.prod.outlook.com (2603:10b6:610:118::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Fri, 3 Dec 2021 02:43:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62783a54-9b6b-4b34-d49b-08d9b606bfc8
X-MS-TrafficTypeDiagnostic: DM5PR01MB2412:
X-Microsoft-Antispam-PRVS: <DM5PR01MB241288D6F6FC036AA9C8FB169D6A9@DM5PR01MB2412.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bg+WkY+aXrvJg5cJ3RktOAD/CNDUjn/BGrXmeMsCnbwudj9/r62sJQmXrRxIp510cndglAq0xBn9D95IIWjz1Ovno5YRbdF0Rj4WjlbckHtl/b9ylT0XQkZGkZcMoM/9OOlC8FxKRL7FrtQMEGYP8n2MlrV3R5sTYMGsxvjRfxwgMdhoez0AeFEq3Y1HjKCy5am3T/lxTQHtOuY3Vv8v/95BOhssf9cLdWg9l66q9vSMT6W5IsVRvgyZOObHJ0m5aFPxKny4BPLbKr/aVFEHAKVL8sOiihQxT5kINUBheobwmytX7JVzxjrzXokQuHcLabu0Ccewersx2uN4ExoTkeoqLz67r2BXNsg7B2Xy2qsgCNlWE/6kiVD752Zzh2Sx9w871lDVyuWR6P9bMU2kPy0OA4qrn7nl/4VIJql31zX4HeqY/Udmmkwn6wkR+7Bn0Nzc5OiBo4zZSmKYVoSZ/MEFfQ+6GLdJi2hSNAxIPilORtOPoPnk4GVGjbsvDIpAsmfDlLRDYCF5Wrk+6PnmK8DmaNdJ1iIFszM51EcROnBQsuNJAqjvZYo1V1/GrrnJgs9omSqPCRSDtVHf0/0SnVt7ZbWsAc2MixlMxPLqS5JsKLXC0AI2qfVOeLz0t5sOsRz9QpupHLRdg8DXTsu24olL+3NLKn/zjSJx9wZ1IyLVuv+x/D2TZdooaxBZPT7EnzshLVUlAZpVZftynXlG4Ypm4AeiSZnHA3j2D76FgcwSfY73yndip0DD9XCkejtD0KR1fGnq9A9so0hTsa6T4NlzcJzFZegUuVrn+dbcYATtnUKWi0ievu+2F9CLqk0P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(2616005)(966005)(6506007)(6666004)(66476007)(66946007)(6486002)(7416002)(1076003)(956004)(2906002)(8936002)(5660300002)(508600001)(26005)(66556008)(86362001)(4326008)(52116002)(186003)(38100700002)(6512007)(316002)(83380400001)(38350700002)(107886003)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IZ9fc5vdpJOH4DK8ugKEGTtJBHiYavweOzUOju6w7lVi9S07HnAc5x92WV4o?=
 =?us-ascii?Q?1nlb4Uj3v0fGYQL7370IiS495kgT//LoHIz7yad8uU7uJrd+O2qamMPpq2bv?=
 =?us-ascii?Q?mzsILFJ8aTgR2E7zcaCUmAZXq1HVCosB2FWnWgE05A6CYdaZ+ZMWVCvxwHk0?=
 =?us-ascii?Q?kQIo7OkRwAv7s4EeM0jLHuUhl01ArHQTG1CXS8dVkE1VG0bFX/lEUkKHrP3M?=
 =?us-ascii?Q?m0pOjdW1urnf8d3zy4dZf+PRhujsOyWDQxRx5vNquchw3607S0IJbXhKAvxn?=
 =?us-ascii?Q?WmmMf+BscZ3YP6Zcwf5a0UpEc9dAmPsaLWMuu9ybVJC0mxKWODLiUfI4g0Zp?=
 =?us-ascii?Q?Wwi6R6MlPwgkSKSp2CvUKk/WV9eadCOA+vyYa6C/U0sLJPxJyKViEVEMkD7P?=
 =?us-ascii?Q?kdgQXbWQ1n1P3KP/PB/TRu6g2U+yi/k7GOPlFg+5FogSjb5jINmz1yqnP6hA?=
 =?us-ascii?Q?6mZJyyW/9hxOpxijAP8hAnbA5biNAIfNIoEb6gTGLz35pNFeypwmXlxruutk?=
 =?us-ascii?Q?4sHORWgTQ1PcIMNI3h/jAqcaUz8WXZ5ZYiEpzRobyKDTJt/8H8heYuwr6hfC?=
 =?us-ascii?Q?Tg8CAjlflQJqNbal/tZSxfpECErISvdM77Z0FgJ2ajFzlZgqF9Z439bDavQv?=
 =?us-ascii?Q?XgIZKAm+iGs+i0sSbbhP686YaoIiPRm28n7IqSBqOHQ3Dqfdq6ymeMhtB+Rf?=
 =?us-ascii?Q?pdDsTqWyIcloVPMXRkr1hQVRGp2nwBb3izALJK92lwJ+xDEX6mlrwnCJpExo?=
 =?us-ascii?Q?HGVQHHweYCK8vuA68axlaMv/gOBCr90oAVoB11Iqq0sB0JidfVa8JZOhSH59?=
 =?us-ascii?Q?72Q8iGaffryuHaB9JpI7xtDSa6YeuOAZxOl62BHeqV1jxl+mkNJUrWKuLGlf?=
 =?us-ascii?Q?PYgmosTOoOvjnjs3py6O/kVAhTdktVIw33zwnRMNM/nfqanZcOO7k2z4gNDn?=
 =?us-ascii?Q?KF0AX9A2q8Y8elvsEIoW01stmIQy01PAhzZmEl/KvndVdgQnSO14XQ2aHg73?=
 =?us-ascii?Q?hHlxu5WyrtLzQbobWXiwulOK8gxpuntPKyjTPGkhK5LeWTgKWr0lIfs4/3hb?=
 =?us-ascii?Q?IRL4T07i+S6qR8WWli6XJq4fl6/yruxSFNpgRcjykRDMxG32eG1cpXwCHCIv?=
 =?us-ascii?Q?37CAYWJFPyIzCLpiB0Jl40tp3WCWqOoDRjQhlrgNm1EFSGIXiu433mAODVTq?=
 =?us-ascii?Q?MFPBcBLYvnpATsbCZCRdlXtBOLhN+WHpH+kai4V0P8A+2AGQVZXSzeYFi24/?=
 =?us-ascii?Q?pFdWji6GbZXFOBNKdg85qACpkONN1GOHZYQ+HD6hXPkRJqfMKGBRXBPZhLoo?=
 =?us-ascii?Q?ekStOfNmK+bXMtrinQ9GmxAO1kMBV4bx/GpgmV1xTPiybZfGMYPwpP+OI1T9?=
 =?us-ascii?Q?EeewIGTTCzFetz3xq9dHA0EO2GtMmy0sv3sGBm9zJ5/QkEhlSmw1AGpzirIo?=
 =?us-ascii?Q?6IZ2caTsliC0JqV2ccjV2VUQNvz5NZ5vuf6SFFOQleo1gisWHH7hTJcBAF7G?=
 =?us-ascii?Q?dAP16BQT8VLt6lRx3ZBFrC/CTohYoBgATrV4PeKB/kACmZu7Hpqe0mIEJA+a?=
 =?us-ascii?Q?gT4tyYLeSKmBTX+um21a+knsmthW1MywgZ7kcJSpxFSsYSxpwLS8cPsI6jcD?=
 =?us-ascii?Q?Hc6PfV6IVr0hGXpTE+sYNUlHkJwASsXjdK7wBQ7hhpn3D5xENKp4RbiA/1d7?=
 =?us-ascii?Q?wyy9OmzOk44p+32Q8o1eovl8pdtmarAXTZzfrq/V3pt+HAVTchrope204PgQ?=
 =?us-ascii?Q?UpU8qU/gIg=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62783a54-9b6b-4b34-d49b-08d9b606bfc8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 02:43:55.7302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZFGC/VZUv9seS6d0Mwx3k4rIEKMDSrNSbmiFhi/s8Wc83BwR8vQueLure4wk1cyZiK+tRYXwmx1RdIWHVkADViP/4Yif+cump1DldthIj6qnap8Opx7Rg1CsGjfw1eT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR01MB2412
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
  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm master
  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core


What's the process with new ACPI tables? Should I submit a patch to
ACPICA at first or is this fine?


Ilkka Koskinen (2):
  ACPI: AGDI: Add AGDI tables to drivers/acpi
  ACPI: AGDI: Add driver for Arm Generic Diagnostic Dump and Reset
    device

 drivers/acpi/arm64/Kconfig  |   8 +++
 drivers/acpi/arm64/Makefile |   1 +
 drivers/acpi/arm64/agdi.c   | 133 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/tables.c       |   2 +-
 include/acpi/actbl2.h       |  20 ++++++
 5 files changed, 163 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/arm64/agdi.c

-- 
2.17.1

