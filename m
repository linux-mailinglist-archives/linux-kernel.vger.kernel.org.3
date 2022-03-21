Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CA94E21E4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244022AbiCUIRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345173AbiCUIRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:17:05 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2135.outbound.protection.outlook.com [40.107.243.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810D811CF5E;
        Mon, 21 Mar 2022 01:15:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFvGLHWRpVVqF9OeGVC3oKWIjg3BevRr9GlLtE2yMahKlBr6HF20T1arIT75cxv1LpAFUJqn7munxeEuLDe6Aewth6dZq58ulluocB9Om+BgF3dGafRe3Jzg9coC+oOpqvd5NNvM53QFKXG95evNrrzCsva+CEqwdCTpciihwYTnJiuH40wtSkRI4kjjj6Q5avwRaSYVdfvbQrWD04eYkEdW9tXyF/rR5vtgnn9GSL21GfgJ/lccsYuSAIvwl1aC1gBYMuUcQ+2OMWIDlBlTmS1V/ooRThd93q+xTxinqM8QgNNooiAuSFy85a3G27oqicjh2/DbTpGaiCn+lNQtNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csaRjnDj6HboMRHyCeYJrUPteA+rHFghsIsEsIE11C0=;
 b=QKst31H/J30ldXEcHxMJ1ZbNW1kkAEBovJQg9uqbKTUA/CIbzLoPX1W6EX+owgxjmV+wd+p/JbGct/7kr8ngKyjnOBd0gTHG3959z/ITnxim2tFT23+UtaT4fuHGXnck/xCJg6t4FVT//u0F9eFMYxf5MBVPFeyImyC1J4ccjvR9hAd0s9Hzys5KruMmulLbIUPw0JYhI11yS+UtLPu0OQrpZJw11bJZtd81vbDViLgJQu0DFQerjGh4TvUhX7ihb7k9r51qwsDQMBS/1ouaCbLH8i8C1AwCM4o8dA+ll7PNRYWDH95zANXM9Oc9QBfRZUEo5lgC2XiCmbeHiv/Zkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csaRjnDj6HboMRHyCeYJrUPteA+rHFghsIsEsIE11C0=;
 b=l9qdEpSzLvu5BlsWjlwBJq9enPA8/4MprIajr1/VaG3Am02pzhxjbF/jv7vnqIckghiWITZ9cMLKDiUlhJrjlD05l/rONPKqqUYTi2qFLU/bguBql6vwlDT26BREqo9k2jD1ZZqLcHv6mdKw/uZrDmnqo8WrR5sMxhKscjqUVG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB7282.prod.exchangelabs.com (2603:10b6:a03:3f2::24) by
 SN6PR01MB4112.prod.exchangelabs.com (2603:10b6:805:a6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.21; Mon, 21 Mar 2022 08:15:05 +0000
Received: from SJ0PR01MB7282.prod.exchangelabs.com
 ([fe80::cd24:39ed:7042:46d6]) by SJ0PR01MB7282.prod.exchangelabs.com
 ([fe80::cd24:39ed:7042:46d6%8]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 08:15:05 +0000
From:   Quan Nguyen <quan@os.amperecomputing.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        Thu Nguyen <thu@os.amperecomputing.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        linux-kernel@vger.kernel.org (open list),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Cc:     Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Subject: [PATCH v7 6/9] docs: misc-devices: (smpro-misc) Add documentation
Date:   Mon, 21 Mar 2022 15:13:52 +0700
Message-Id: <20220321081355.6802-7-quan@os.amperecomputing.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321081355.6802-1-quan@os.amperecomputing.com>
References: <20220321081355.6802-1-quan@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To SJ0PR01MB7282.prod.exchangelabs.com (2603:10b6:a03:3f2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e515fd9-fddf-497f-2cd5-08da0b12e7be
X-MS-TrafficTypeDiagnostic: SN6PR01MB4112:EE_
X-Microsoft-Antispam-PRVS: <SN6PR01MB41129F34C80ACDD77902C0EDF2169@SN6PR01MB4112.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2tjtr7eA7oIeUb45iFzP4QuztMwgGf4eDvl8vQJ0pPz8TOEbI9pa+ag0Q5/xXnv1Bc4JpAI0zlqgFKzcigE7Rup+SHiJs+8hO/GQ/pCpm3g1+N8AISZGBG0wW/xlc41lakcvJi0/lIy0QGeTWsjB52c53bFDqN3fUqryUY3/CQzJi41T3M+34RySmf7sqW1se8B4vtuIXlNPmhM8vEQ6MMKGHn/ctmnP0O5OxS1gcKg+3sd8hjiKUP8v5HlqgnLDiSoP09o6qEnoUcE8M9KuL0Gv8WrnYW0coghS/TmP4X5ZMCV1wrUiEDcMMPkp8IkW1SSnPHHWnDuCHb2aHKXfgDPdXXLhieWW4j2smTLO6+eWncC//z3X14Ikl6vbU52gmWbA2SifR60u/LQOTroV5DntO/dzm8HzDiD0rli7iWsXEeVuCeiieqURifdyzjWXNQEEyURuH1L0YvomPmC6wLv1AiqbJajO1RxkezRIRWkcf7jgL5Zqn7ZUJnET77N2QX7Ub/wnJMBbjmIC33MQYA2KUhbO5OeAgxGePdU4b/ZFG8zie7KdjaqY/O/8Bt9D5lKBLOPg/OtX0XBn+NVkCwrrQOlrkuFrAmEDciZqwfZT1vTxm0YqjV23axTBdxKkg4alRnuJ4hDhyjbrZVpW+38jM/E2QBl4068caBx41X1W0+ebWgd/QmfFbq7c9q6OvPKmtnimqk+GHmhakrwVcXsgkH0a2bW8iEF9EJ8K4S0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB7282.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(508600001)(2616005)(26005)(107886003)(86362001)(8936002)(186003)(2906002)(1076003)(52116002)(7416002)(6666004)(6512007)(6506007)(921005)(38350700002)(38100700002)(110136005)(83380400001)(8676002)(66946007)(316002)(4326008)(66556008)(66476007)(6486002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Dlsd4/rdhfSNzuNDFRkgOxAL0Ng25G+WN+5/RBKvC3BN0ONPdaXZrcadMDC?=
 =?us-ascii?Q?JccFC1h1dHxTVdE4vgYdKVsF95yJJabqZsJB5RapAvVWKqvtMMHrJhP2FNC7?=
 =?us-ascii?Q?4gcf1gTw6X6Ou4DoPmBtXyfhe0P6eEYvs091P+MnRlgKDzT9ncWHyUErqEpH?=
 =?us-ascii?Q?KQC23knseFr03Ln7f8npe0VVpOP0qBy6piZtz2DCZZmSOPuxt91iqCTOTIoU?=
 =?us-ascii?Q?0xywQu6Xg4cjWUhhxx0CIHNB/SNqEllOsiklGDVtHw/CeaWbIaeT6APllS0p?=
 =?us-ascii?Q?Pw+JnP7/X/BbZeeUwNaOq7yYlWU8vejhmKc7t6tSiMoyTrOLNxrqkHywYteD?=
 =?us-ascii?Q?oI7Tw+NpXoceFh2y1+YuuYM3/TQpjGnwQQ1c6d6B4daxLNsuwg0TLIP89Ik+?=
 =?us-ascii?Q?CysP0l1gm5IK/PsIS8eDI1lMmkQNpcyNo2JTSuPq/cy0kXnav27a6+YD0hLj?=
 =?us-ascii?Q?I1RiM0+lkJS+vAPG0MWVTop0EGvqtJyr+vZKysQIv/P9BO5XRRogGCqblCw9?=
 =?us-ascii?Q?gnuW/h4PEO0I7cw5+QPBovP7Sd+sUk27zCJpn6kjY4tlsXh+ANjjSkqcHxS/?=
 =?us-ascii?Q?ML0L0SLO4yn2UV1mbkTLxyAJIyuP5jnfaQTAUUH13Jw3HuKHzg2RRRha0hIi?=
 =?us-ascii?Q?NsPgHgnFSre5n/DZJW+eAO2C4AaA4lJOVuCvYr6QIW6umrTAqqfHh+U7DDla?=
 =?us-ascii?Q?Dg/ZTHs+3DUsAzeeGRY4fwp1+m/xZhxhWQoqLRMS8iCyqX7vsNR+UlcyY8PM?=
 =?us-ascii?Q?mYxJEOMXaIuk840dZiNNDF0glFepim53kPx4aYcwW5GrM/tj+wrLZB9sWIp7?=
 =?us-ascii?Q?zMnvwfWPZqKsu43YrCNOghh+sXpHk4YbkzU2CSC98M15ba8PBLwC43gbYsIa?=
 =?us-ascii?Q?2THuxTVsVkyvhRggEaWkqM6zk6uw9JEhc6fo1pLkoiiWA5zA3Kf737/gdT6p?=
 =?us-ascii?Q?1aLBFNiNfu7LWPOdtkC9u0F0qGykhGVK9OJ54Om0e5uIZCMjPQVHFQjdkITj?=
 =?us-ascii?Q?uflIClcxV75okq3smSXn8YdxjRkz6sWFpTo6nHlee0BhkDMElz2ZYjbsb0rQ?=
 =?us-ascii?Q?5nj1QOP2+WbBMdotjt/aO2kvUQ5P9tmMN4Wo3lfoaKGNjSL4DuphBR+VY9ER?=
 =?us-ascii?Q?noNFX38j3qFHBu9z3cMGvblQu0VOpEWjfpt3dS+jsWO+WZuwQoGH9GY5Nz+q?=
 =?us-ascii?Q?1fcl8JuoNtF1fpRciMisQlkm1/YtOAOgqfM5DsNmgDCUvtrpkDDOzdsoTpdy?=
 =?us-ascii?Q?1BRQxSWXETZ1141bGzrWugZ682lO45Jv86Fz9OoiOMutBVm4MxMIcaifNM3V?=
 =?us-ascii?Q?VK4IgDLmiuyLogDuGDy0BrAOvichp37qP0SzfmMKNt8qChxe7G9pfTBJ/S81?=
 =?us-ascii?Q?qmlHLOL8a2EE5F5AZK7Eu8jvv5BdAQbsr9n1IxezzMRipmjG/9COk9tM6Pmk?=
 =?us-ascii?Q?XIe6+WWLgdUY1ozOWPg0IreSo7ap2aDmQZtPoU6Z86jFgajrRLPetCrYxwab?=
 =?us-ascii?Q?axiCLDIkez5tHeU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e515fd9-fddf-497f-2cd5-08da0b12e7be
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB7282.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 08:15:05.6037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hv6+V7VKB37fFKW4twudarI5E6tReI45W+d8E6vToyvGXPIu1aZz4gatq3seLbsKAaXV+QSGXB/Bq59O6UziaKWhbX0ZpLhUh2LupKzvD04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds documentation for the Ampere(R)'s Altra(R) SMpro misc driver.

Signed-off-by: Thu Nguyen <thu@os.amperecomputing.com>
Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
---
Changes in v7:
  + None

Changes in v6:
  + First introduced in v6 [Quan]

 Documentation/misc-devices/index.rst      |  1 +
 Documentation/misc-devices/smpro-misc.rst | 82 +++++++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 Documentation/misc-devices/smpro-misc.rst

diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index 7a6a6263cbab..284568eca747 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -27,6 +27,7 @@ fit into other categories.
    max6875
    pci-endpoint-test
    smpro-errmon
+   smpro-misc
    spear-pcie-gadget
    uacce
    xilinx_sdfec
diff --git a/Documentation/misc-devices/smpro-misc.rst b/Documentation/misc-devices/smpro-misc.rst
new file mode 100644
index 000000000000..7c856eb1a7f3
--- /dev/null
+++ b/Documentation/misc-devices/smpro-misc.rst
@@ -0,0 +1,82 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver Ampere(R) Altra(R) SMpro miscellaneous
+====================================================
+
+Supported chips:
+
+  * Ampere(R) Altra(R)
+
+    Prefix: 'smpro'
+
+    Reference: Altra SoC BMC Interface Specification
+
+Author: Thu Nguyen <thu@os.amperecomputing.com>
+
+Description
+-----------
+
+This driver support the monitoring and configuration of various miscellaneous
+data provided by Ampere(R) Altra(R) SMpro processor.
+At this time, these include:
+
+  * Reading Boot Progress information
+  * Configuring SoC Power Limit
+
+Sysfs entries
+-------------
+
+1) Boot progress
+
+SMpro misc driver creates the sysfs files ``boot_progress``.
+The format of ``boot_progress`` file is as below::
+
+<boot stage> <boot status> <boot progress>
+
+Where:
+
+* Boot stage::
+
+    0: SMpro firmware booting.
+    1: PMpro firmware booting.
+    2: ATF BL1 firmware booting.
+    3: DDR initialization.
+    4: DDR training report status.
+    5: ATF BL2 firmware booting.
+    6: ATF BL31 firmware booting.
+    7: ATF BL32 firmware booting.
+    8: UEFI firmware booting.
+    9: OS booting.
+
+* Boot status::
+
+    0: Not started.
+    1: Started.
+    2: Complete without error.
+    3: Failure.
+
+* boot progress: 32 bits boot progress code
+
+The sysfs ``boot_progress`` only reports the boot state when the host is booting.
+If the host is already booted, it returns latest state.
+
+Example::
+
+    #cat boot_progress
+    0x01 0x02 0x808454A8
+
+2) SoC Power Limit
+
+SMpro misc driver creates the sysfs file ``soc_power_limit`` to get/set the SoC Power Limit.
+
+Reading this sysfs return the current setting of SoC Power Limit (W) in decimal string.
+Writing the desired value in decimal string to set the SoC Power Limit in Watt (W).
+The range of SoC Power Limit is 90-500(W) and will be ignored if out of range.
+
+Example::
+
+    #cat soc_power_limit
+    90
+    #echo 95 > soc_power_limit
+    #cat soc_power_limit
+    95
-- 
2.35.1

