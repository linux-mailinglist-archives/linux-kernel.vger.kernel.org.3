Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68EE4B61E2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 04:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbiBOD4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 22:56:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiBOD4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 22:56:39 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2126.outbound.protection.outlook.com [40.107.93.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89997E01;
        Mon, 14 Feb 2022 19:56:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KO6CuQp8kXbSrUbFTfIq5/xT2NvbHyY6Hl4AEAKctbjBmZaGn7VJMZ9Sqpkd6MEWRnCw8TpJN2Eb9RnTP6NGQAkPwSCRdqw3CVZ45itQcpiwIVEsLygfyt/yYyEJvfyaJTSu1w8gPU+EFX7Lj9IKhzfPe0htiCBL89EzeKeoE5YhlM/wRpBYR7EEr4lpnxMXmx23i5XcX/Ua9uQ6G4EbVX79DboGjfz69Cn8m42vtin8BZLZj+lJBRR6EpieXeqhpuCPnd+F8rGLMjmLG7wD6ralf7/Ri+MahcaIVw4wm2E+uf70+iGRzABwS12Aiy7ZpRdwhAaEdGFFNeHVWydxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVInIhwsscueiXSpjbEosuxAawEoAtAVlvTLj+e1fwQ=;
 b=lliu+ImmM5h32zu7tox2pLsmlmKM90mZOElT3N1U8J6A0+d5VHMpn+ov4HvDJjhrGhetYsWQ6885FbTzf4vDLejofduHK7TZbfdVFh5NeLfdl+ezi7l4QWmM2k/4M5Ktum9zVMdYtVU+pVllvfZuQDJQR+5KlmPMLN5DS2/ajoGDDbtbSf/h5VEtM+0xU1y50HJcecA8Shftb5PsT9wg/OFVv9ONCi7i0i9ewY+Y/7xb0NvO2HpPaCr5ahSdzplT8ZuDnQtEza12isVaB/b8fO64Malvnmx5i4HgjIkVZk8GluVlzetHEiqv8pi4kqPzaDM5VyjIIluDQljhMcl3Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVInIhwsscueiXSpjbEosuxAawEoAtAVlvTLj+e1fwQ=;
 b=bEy7bysdCX6tP7Rbow/TpSDwc91av9ttmPm0kfzrQvCZQXKY7wwszNRAhfgJIlSILr8PSZlSxhLYIxva08nSfL2myekJzjawGT1pKSlqWt90wVVOvrinLirswuCJynZHKegMVf2n7S1LZFWKHX80cAssVKIJ4eAunHemk+/ut/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 CO6PR01MB7500.prod.exchangelabs.com (2603:10b6:303:147::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Tue, 15 Feb 2022 03:56:25 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::e085:6acb:773c:c3e7]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::e085:6acb:773c:c3e7%3]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 03:56:25 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, linux@armlinux.org.uk
Cc:     lenb@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        scott@os.amperecomputing.com, darren@os.amperecomputing.com,
        james.morse@arm.com
Subject: [PATCH v5 0/2] ACPI: Arm Generic Diagnostic Dump and Reset device
Date:   Mon, 14 Feb 2022 19:55:51 -0800
Message-Id: <20220215035553.102315-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:610:38::38) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69dc72d0-9d60-443c-a3d0-08d9f0372319
X-MS-TrafficTypeDiagnostic: CO6PR01MB7500:EE_
X-Microsoft-Antispam-PRVS: <CO6PR01MB75006941C6C2411D688DD7079D349@CO6PR01MB7500.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aO1Cp3X7ZVP5G5g/UgtrjlDG3iRKgqn1r5tRONrjzgRkULmFNyVrgDiJ3lolCwPJVVcu5FDn03UXJmMzGV2R1yIjSZOoRYxi/TEhKgJBXvkxLdMg5iEiVzPIQJRQna5mgxWKLBgacdETr5XHwvDnjfEe6FubizFC/MUcsbHNkyR0BHu/lp0iVBxHRGkzVZtZOjnuYj0jPLwYvqsECitn5eOUNa/y8PedzAchSaglUut4zzLNlzQGFzd8Q7tLevD0wC2eDO79sCYiEh5LKue5//jARYT6HIqd+5JLq6LJ5dh2GABk/XSoRs8AAc5dgjS3IzHuhyqUPuusl4DLo64JpvTmeZQSFLvQRS1Rz43+ka/DiM09rQo4rMQCrKZGZWPZxhX1MqSBLOQpc9M1nkrqpj0NA4nmLtLVghT0KAKWq9MfszAzN7XXzZz6YUSqICV0xjnch0lo36E69PmFJi/1bYOA6Gep/ZAGGKpu5krOBbna+6ynChV/woZZ/jmTURYNR7dh7pJ3PkLrnIswvK1vdRZqxF/AGvXtTG0Lt2BNJRbejNk9ED/1/sVLWQc+Yb5B48/bQ8Up3fVidTlSLh9/UxEzY3gfY2Z+SIhBNSNaisUVB9wqg78ZDhVHd8gq9U5Kb+y6khr4gmKLZDpjHR+51SVW2sR9JJYFZg1SIS5U/CoWHD9kNaLPzwzJg7M/xuHkPkxKyWUr82FCDZ6lMcWYlcP9bbpAO4VwhDQdDrVH+njv4XmNA7NPvoj2GF1E+cJ/0b9n/oEA5RgIoTpjEbxyYuxOn/b8vs7RHd1dt6D1GdH/WrUJRpA4lLByy2FFoe8S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(8676002)(66946007)(4326008)(66556008)(66476007)(2616005)(316002)(1076003)(2906002)(38350700002)(38100700002)(86362001)(6512007)(5660300002)(7416002)(83380400001)(8936002)(6666004)(6486002)(508600001)(6506007)(966005)(186003)(52116002)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?11/rG5jueeYdPwa1XXPoHY3tRT0PbpXNlAhE4uaLJyeYghGPddCV3zPbc+yC?=
 =?us-ascii?Q?ZNR/lehg9BcKgkRJKHTgHAZVRiEHbv9aRdp1EC/bA2PYukgjo7L8Xgjxsutb?=
 =?us-ascii?Q?3NJtohnPGe/IG8rB0LQGSfVfRIPfy9w9IEXADIP16eo2PgMP7QNEGqofhos+?=
 =?us-ascii?Q?457WdxHvHAXNRKBaPthgI1qwbRpudvA5cFWVOAdR+PiyxK0c0GHsNueY47Oa?=
 =?us-ascii?Q?bZBPHgSOqoB0EbqF5SL7UNIL/sLxKZZA5MukWXeZFa947nNsnx2NwEZFe2W1?=
 =?us-ascii?Q?UFnppQMvPawkfoA89RFxFhLHKZYiTu/codB2L6BrXUa1YYrzRihpBhs/KSs3?=
 =?us-ascii?Q?12Ch3H3KGJ6MQn5MBhk2irCTfMrk8wBXfx/knnlgIUcl6GdthL4lp4sG9d5Q?=
 =?us-ascii?Q?+XtdN7g2BAGjb+dZLm8EzQVq2+KI2gC2Ezld5Nh+GShQyQRV5xUM3Ns3bAio?=
 =?us-ascii?Q?bTM9DaJF7/XAz82AZ9vxKUoLY7x1BX4DDpBjaibMv7oOIK8+yRMG3EfPZZCL?=
 =?us-ascii?Q?ulhwKJuS4iiV6jGz24t7YaL1f4Gm34m48CkxkiSGK9LK0UrDQxmRTOd1iVFt?=
 =?us-ascii?Q?xq4PLw4K9W9HVognpV0Vno3rdDw+BruDiMpaY2cmW/3b0jGMs9vez781t4OP?=
 =?us-ascii?Q?vOXUkB6JxhkKAf75S9Dotis7V/VMOhf32ftErUbI1GmiYuFwDO6IGMeS5S0i?=
 =?us-ascii?Q?B8xMxw00JZ9Mpo5cYvts6xqjG8Qy6JSv/TIS9OuAGi1LB6g5iE5R1O40VRC3?=
 =?us-ascii?Q?4Zr9MIy+RABZOD3zzNN+xlnqb43uBCGbmba1kLqj8Ci43p9XnBNRScwLVeBb?=
 =?us-ascii?Q?ZZYoQRm8TEyy97H7PDLhGAvQUKV8CxsUSfWS/2++jWTCXqrijFXXAxGedE80?=
 =?us-ascii?Q?Uz/r/4XqGT7120JCeMLLCo+OyqkRA/7d4Kzk8gVd5ONiEllMvqJu3PYVRCPw?=
 =?us-ascii?Q?aYVS46GvPUslRXXHdpXWhcN9Jwd2tYkRCkQZZmeIlWcfwmo8Lk8gj2/7n3E0?=
 =?us-ascii?Q?XjyAivA5oS1CRDvBlmyXKZxk7rhON+3maMP2j8LHPZct8gpzmFvTGEf18Uy0?=
 =?us-ascii?Q?OLwe1ND03ZaVLDDL5mibkMdxyNNzHGfO2oEr39ubV/csvNQFJIKTZoPt2KmL?=
 =?us-ascii?Q?l9N1iMucR1tMw0STot8AlS4NbbgJAU9oq1imjwtcHutme11WYg64q6bpBRNK?=
 =?us-ascii?Q?G8Y1wZLTtlBap9kcTD+Qpg8Y8u7uiyqMnXPpxrl0LEq7DkNxn8liYP6g5Sie?=
 =?us-ascii?Q?HwRiSlagRlTl/dpXWfFj5wqRnchTxNTHBi/LHd4isGyjw0JNdSWx7oKB6bbT?=
 =?us-ascii?Q?HoXt8W6NqwgGeeAja+1oG/I8YLC+xNzKNnQN1XiynrLbbWhxFn8nzeEs13HM?=
 =?us-ascii?Q?7RMm4nRHsef8ciK13kSJRG3Mpr/L/+7tuKuX+bXuXeuZUBqg8MTOgczvOAAK?=
 =?us-ascii?Q?XyKaF6P2Byr3sy79mTZR5tCaKTJWH0b7sZPsB3JC5GcqNHomGK4kI47SNsa8?=
 =?us-ascii?Q?FvZMX1ekJOMgBX8kgKejNEPMdppX40tJl+3sQcqlO4iv2u8sQGkO5YrNnMJ8?=
 =?us-ascii?Q?Dy3ugGzCzh16JlKKTYJ6NM7w2uFH3oPsw06zK/6N52c3zfjtKCbMC5PYREiU?=
 =?us-ascii?Q?YCkMKTiU3Bq55Ha7JFcoagHU/WAdntGm9d+qJc1d4qkizWNKET8RJaGVJDbw?=
 =?us-ascii?Q?C9qS9BPJkMKWftbUVtBzTdC7Apxf7aC6YvzxPrUxXztRUnb+BZgaU3EDhemH?=
 =?us-ascii?Q?HcaG6vFheg=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69dc72d0-9d60-443c-a3d0-08d9f0372319
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 03:56:25.7385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBl/VcvG0hzP7iS/+nufRhAPyLPmkRJPnW4s8/VYg5qlrKOGR1tcSPllgdTF42nSee0fXW2eET+OU7vvL7M6BltWQ0gfg/YKyncFS5fvLIlu0E1PQDzeWwNEq8Z4ttVq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR01MB7500
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm bleeding-edge (9db71e8e3027)


From v1:
     * Moved pdata to the stack and dropped unnecessary kzalloc() in agdi_init()
     * Changed the ACPICA patch upstreaming order comment in the paragraph above

From v2:
     * The first patch was split. The most of it was merged to ACPICA project
       at first and later ported to linux-acpi
       (fd919e37cb15914c6fe13e13d530a4f732407c6d). The rest are in the first
       patch.

From v3:
     Fixed:
	* Moved header files in alphabetical order and removed unnecessary ones

From v4:
	* Platform device/driver stuff removed
	* acpi_agdi_init() call moved from device_initcall to acpi_init() 
	* Slightly modified Kconfig text to keep checkpatch happy

Ilkka Koskinen (2):
  ACPI: tables: Add AGDI to the list of known table signatures
  ACPI: AGDI: Add support for Arm Generic Diagnostic Dump and Reset
    device

 drivers/acpi/arm64/Kconfig  | 10 +++++++
 drivers/acpi/arm64/Makefile |  1 +
 drivers/acpi/arm64/agdi.c   | 52 +++++++++++++++++++++++++++++++++++++
 drivers/acpi/bus.c          |  2 ++
 drivers/acpi/tables.c       |  2 +-
 include/linux/acpi_agdi.h   | 13 ++++++++++
 6 files changed, 79 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/arm64/agdi.c
 create mode 100644 include/linux/acpi_agdi.h

-- 
2.17.1

