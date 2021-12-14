Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B3E473C11
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 05:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhLNElA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 23:41:00 -0500
Received: from mail-bn8nam12on2109.outbound.protection.outlook.com ([40.107.237.109]:63840
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229449AbhLNEk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 23:40:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=la8AGnd+qKmPtzpEUaqiHu159k7BFpSbnpGLQVu9w4tAOhSWBdx4rTwkPCi5EEsk9swPpyedTf61aUJ3UzXl1hMgHp9NNSoUZnCbOTHJZ5oib9E3aqzaknHdlEXcZ/Im4b6lxT1QiAE9W8OekYsfZP8+szd5QiJlr8lpo961sIqTrWa4KvVsHDg3vKN6xD0qWeor3e19RTbkc3mhGU3Q+7PFtkEFZScbB0h054q8gmbQF5V6FgaVkAziWDqyFDaV3Larcv/8SLWdmKhhBHBzmELENqiUE3Myf56ZXMUK1idmim0EVZCSwXUovRaqASVD4XmuzbUDyI64SKsqQnCdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFrZ1cqVmN0SdAfZRPk8FwPma9aJXj024QrJRQprzy8=;
 b=A7Sti/w3Gx8EQ288gyE2lBRri6LfKkAEdcOZ9gaggQp2atOkNV8i7iv0JQsIs0ncsvMTRSFEAEP7x6mWJ8bJvP7LKQwUJlVDV52T1YTKtQM7fmp58gTRPAjl2aonOm1RESeXRcCBem63s/Z/GhN0oa7sb4EXFTeWqd3ElIlsZNWDkhZ89Kc134xDwL/j1XNo2nMfgQYaEpxyekDI3N95nQsnrEHPMuhPru8m0N47d3IUs1QqLhIy8fTTSQZbRxIRj8ZOidD86kH95uR17SaPIxHxFL7jY3/6BSbOTLd9RDmb9/Opkj5UrGazuYgYmPIIImzPT8X36d6dS+hLJW3z3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFrZ1cqVmN0SdAfZRPk8FwPma9aJXj024QrJRQprzy8=;
 b=VCy0IsWhEXVJZKarDAJbo2vPbOECRP82wrnpMbQ/Z8M2XU8yakKnjQg4QkqnZpcInfzqaRJi2AaRhSGeEQ5Ijd1ItimMDm3juKHHbo94HMK9qSqvfe/FnZ4HRQcAaem7rZIdWyxFUJiWIfnoqeLpc74LJG7Tq4Vb2L6H6IRztYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DM6PR01MB4826.prod.exchangelabs.com (2603:10b6:5:64::17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.18; Tue, 14 Dec 2021 04:40:56 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::38e1:cab:501d:6b96]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::38e1:cab:501d:6b96%4]) with mapi id 15.20.4778.017; Tue, 14 Dec 2021
 04:40:56 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, linux@armlinux.org.uk
Cc:     rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devel@acpica.org,
        patches@amperecomputing.com, scott@os.amperecomputing.com,
        darren@os.amperecomputing.com
Subject: [PATCH v2 0/2] ACPI: Arm Generic Diagnostic Dump and Reset device
Date:   Mon, 13 Dec 2021 20:40:34 -0800
Message-Id: <20211214044036.48245-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:610:cc::8) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75d4f7aa-fcd9-4293-ade9-08d9bebbead0
X-MS-TrafficTypeDiagnostic: DM6PR01MB4826:EE_
X-Microsoft-Antispam-PRVS: <DM6PR01MB48261D40729B02BC0FCC952E9D759@DM6PR01MB4826.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dP08u0dwOD60ug3arlU0DT20fSGjR9eqpoXN3SYPOBNt/CogX+StDatnk59UCA4JeZzqKaGkoVECmxYwedE2FqYFunGvCp9XBxtuak18JBl/pIT3F9MzoPD8nkr8ynA/olqXROS9Xt5WJWmS1gVSgzp+Sn883CF30k2U1jyZBWCsdIugD5MrBIkBqblcEnhZ7xMl5qnr0zR0npYG42vVJePNhssvISAEYGK9lAvFAvRGae8QMf59BIGQ3Fcb0yIJjxbyrCmxXAcYrDZEHWOyNFPrZoQnUDhnZoe79rCfmZvJhFW9/+EjWeTGxEarBe1QJyXf3o3Lqvp0JhUrU7xVjYVSOZclzzEYhnzModmHnbOAija3tnecDLiwiQiAOfcYj8SXu4DRs43ERSNnuSa3Wm+aOi6TSo+PhnCVG4CEkPPFaf8kwoL24qVcXgYXN508RPAdveZniJXo8sHyWQS/5mQahInlYeYR+j63XcuYv+aCZ4GgI1E5zMemIkoTaZePYgGvMRUHKykFALyLka0SDWesXg+xMV33nt6Zjl+97ZOt5bcWiXMghhy7i/niwHo9NzfRIh2W8gn0Xe+lp5NQWEF//JzZaikp0XhyshbbyUvEt/FmzkDrYpXkiztRVocBEcq7eINHbsKUTcHOK5SJlQdqcYMH9CZLKMAaHQ9ZfZAvCw6MHrIjNVrzo3Nswa1yQEP96I9+hoGhbrvwXhOP0xDWor8Rbqr5sFhlZLxBl0s6EFiepTJOyn1XcqiXyALJI4GWBgCewqNzUuREl//pgLtVL+vz0LymRDQOXtIcUPEzH5DMFNiMxIAHcIAWt57Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(107886003)(2616005)(66946007)(66476007)(66556008)(186003)(26005)(1076003)(316002)(6666004)(4326008)(6506007)(86362001)(52116002)(8936002)(2906002)(7416002)(6512007)(5660300002)(38100700002)(38350700002)(6486002)(8676002)(508600001)(83380400001)(966005)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YCKyGX0pmD/nqGj7a82nP1rD+qKR9mzvE2VF+S9MijBL21Eo+XHzkQHx6efe?=
 =?us-ascii?Q?FgmkHHafyWIpqJe5PLbeHxYXEWsAkUOlVdn4AwUUJIQc1HSreGYtAE1/6okr?=
 =?us-ascii?Q?N7kxXckpb+NGHqMqsuSiodBb+7wZ6QjdGDjnWqtgJtN9re9Fq8K0gktlJJjz?=
 =?us-ascii?Q?Sg3jx5L+fhmpJln6w0TLZ+tT0377YlMRHRz6IZXes7K0lQyj3RL1GFBw8pYe?=
 =?us-ascii?Q?AxiKN3lwg2yxZ6ews6Ka3vSl4nmsrcvKDanJrWU4LCmCdZgNdwOIZUVNBnnd?=
 =?us-ascii?Q?duUasOR3c0W9TkLb0dlEY5gE7dEmhWEII7Gx/hdnCpJRuU+JsUUQY+srCB4o?=
 =?us-ascii?Q?rm7y2LWOnxZgpt+NQDEIwmvT670Zk77txK9WxS/gEKE74Ng7M7mpuOAf5b7d?=
 =?us-ascii?Q?f56s9onItwTWGRZJXlP3kMJMAiIc0990quj1KeCCggOQtmYeHj0mSrICWFRc?=
 =?us-ascii?Q?isQdHjhGEbRN/hQwVNJ8xNEZ/MavGLVP5LK1dUUDf/Y7rBtjR6/ai2TzJMa1?=
 =?us-ascii?Q?wW4faEmT3G5KDXlDjTx4nonszeGMiQD3Mi3ZX/ZZRSQvVy6/3RIoQaSoDQsq?=
 =?us-ascii?Q?TXi7btxrpujy8KMG1TI9TfWEu2XGG0PeC4QD9QiDu9VAKTmXqr/scowJwH+A?=
 =?us-ascii?Q?gWMjDX9oZiLfYpc5dSB1y2aC2AYob+GTm512cM9013n0fleEd9DJn6S1Nwws?=
 =?us-ascii?Q?/zRcKcGddm/ClxE1upXDD1wu/ZLgd/wrMXeYY96huoQuFswOcWpJ4NN0t6Qm?=
 =?us-ascii?Q?gL36hhgwSLv6LIiPFHecs6pGcp2ZJzpeN+PifcRi2pXx1yEwxxNhA243Gk/0?=
 =?us-ascii?Q?ItXisK1zp2P5GpZWLDSVO80fb2aKpAd8w1acPjtN+GP5zlnMr1PsaKsPxYbj?=
 =?us-ascii?Q?V9eB3OC5wBtAQLm8a+FKi4Tkhu3tAxuWzbOfe/eGI1Y0v3brSoQUNv4a2yq2?=
 =?us-ascii?Q?6yW6uSLVi1uu9F+ZT7jmRQz6VadAP4a7H1FjOpLYDXIGgCjv43GB3O2jwusa?=
 =?us-ascii?Q?NMFoLgIWAarGwBZDVE0qc4abAIcKW2G1CpaFhIZF3ubYCZhQPL1vkVBUNWU8?=
 =?us-ascii?Q?K/YG2BqM/AwWSDt4+Iea+xnm0BuwXy0xpM2hP+vkR4isMk0lYgm0tt85tgD4?=
 =?us-ascii?Q?FKPPwHUPgBD65tz4vKditJR6ia8n2gq7xHCmS3tpGlucgOZfJ0wpvLmj9OmV?=
 =?us-ascii?Q?O/RP9gJDwq9HXNgU79RZgy8bd25SN47QZIveXqRvOLNP8wI4iuvGVPrZNdE1?=
 =?us-ascii?Q?F7Pyg3ld4E3sxxI3TEJdVxmu6SscHJfUo/ow/tYwBvWY0/hS568kPizl5Du8?=
 =?us-ascii?Q?brwSTr6w72UzBj+blQY+CjaZlNtVxYKuXX5SgSmMWaEy+Ik/EBKgnVm7pDw1?=
 =?us-ascii?Q?Is+JFJg3WtSxJ6zU4ly8QExlZaDjvrc0VPTwrRJiI3+HTQVsM3TypjA/i7dd?=
 =?us-ascii?Q?HZnPooeDwQ1AetRgb9eHu+shF4bTtA+y3r+3wH8G87eI7oNLqGugqJByXlpO?=
 =?us-ascii?Q?LVLpuxlCb+m6l+inJ1f8/oxXpfvW/KTpSobkJ7SSuKeqNY3xBJEzow5zHVjk?=
 =?us-ascii?Q?u71j9fkMQUtwV9qbr08w9zlqu/1kqtKodKQwzgGVNPF1pnR7hxu28ax/XSzi?=
 =?us-ascii?Q?1NmnVH4YCo1XtpBC1IsuC0PTgBjk7YbfR8bSKncM+0J4/cvvQu2Wha5XB1ax?=
 =?us-ascii?Q?FyVaFv2ZG4E+t+K2VPHZeB4TJlJDZEMmlucerXlX1mNp+G3+wQtZcMe9ybUB?=
 =?us-ascii?Q?M1X9QLXOgA=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d4f7aa-fcd9-4293-ade9-08d9bebbead0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 04:40:56.0154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxhF2zO6rhLLREEhlGklo7VbfJx7gK5/bLHD1ZCqQ/oT5HGNiLMV+3IH9xykzNRADY2G02DWPRFj7T4zIejOsQXNwoSdWR5i5j//2jr9bZBzdYga9SGddnHDfjIuzjrD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4826
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


It seems that the correct order to upstream ACPICA patch first and backport
it to kernel. Thus, I'm assuming this patchset should not get merged yet.

From v1:
     * Moved pdata to the stack and dropped unnecessary kzalloc() in agdi_init()
     * Changed the ACPICA patch upstreaming order comment in the paragraph above

Ilkka Koskinen (2):
  ACPI: AGDI: Add AGDI tables to drivers/acpi
  ACPI: AGDI: Add driver for Arm Generic Diagnostic Dump and Reset
    device

 drivers/acpi/arm64/Kconfig  |   8 +++
 drivers/acpi/arm64/Makefile |   1 +
 drivers/acpi/arm64/agdi.c   | 125 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/tables.c       |   2 +-
 include/acpi/actbl2.h       |  20 ++++++
 5 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/arm64/agdi.c

-- 
2.17.1

