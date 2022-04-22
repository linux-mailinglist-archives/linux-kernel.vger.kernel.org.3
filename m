Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF43750AE19
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244917AbiDVCvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443552AbiDVCul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:50:41 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2101.outbound.protection.outlook.com [40.107.236.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF6D4CD64;
        Thu, 21 Apr 2022 19:47:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icIkpMBmjkfhWvC17H2Zur1VKAL4PKcer75X0CiiRa0x7jqiaB6D/ihh034/8XGMGfPI3RW/GbXqustHkMuDGRMxVh2oUadwM3yD63EOQDq6aBpnq0Ci/hIdL+u6QDwh/2VEiezyFC+nCIpqwjzPc4iLojYccDRJUgNAnkO2WoaQ6bWWtUkWW0xCKlnxGmOW/p/BN8lrONox0Wc9kw5Qqz4MyS0lkm+saabURMC9fBqNCqBBSE61gn/XQyJPdebfmWaKY96IwCPaEpqlrwed1oNr14shw4g52MVK9cpdmUB8OCI64ku1fSODT5QmmHa0NRNHJexYINEZRpO2Ewv7FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yt3vnavLIGqOeRC0xyxPDzQAqgQPRKlMeBB6U7bCiEg=;
 b=jSSbdIGq2MkOkldj3auxOM6CE/XW8+MnANP4FBQbejwVWN84Zg5+c2KN6rGhSW3oCLqUaiax5I3SETHkEjP/zrtxC5EFvNrOKTw1EhOrk32xJGGJ/+ILxWhSU4l7b+H97eSCocEAb1OzoFYQA5LEb14YuS+GKTkuklpsRddaZCv4x/im6GOYFJDpkuYpKMzY9VKAKjNzyMbjGYOQeeY4vsRrt8FkWEsDMPI0FY/yGiZlC2KdAzudp35zYWPoXO+OWQi+0INU+9B4nqPvscSBvxTD0r8HZSRbkTgFL3U5HnQyo0HQV8EvPa4rS+l4XlMZu/LuT6ZcDkY8R51XedZqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yt3vnavLIGqOeRC0xyxPDzQAqgQPRKlMeBB6U7bCiEg=;
 b=H5oavFUE/Lr4nK92bvJa0Ki3sWH12Mz2uL1SfDrTr7jjXuGk0nicMHCUSRDrV0S+YZ3vN5KPkgcajHgJo/4ekIPeQJcPoAKypVEn8DoizbfFOfoZjC1KDv84DnL+u7uCzfVQYC4C34BqIZxgSEikeBZ1eGM8XhQOBiW/ifVmeEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB7282.prod.exchangelabs.com (2603:10b6:a03:3f2::24) by
 SN6PR01MB4653.prod.exchangelabs.com (2603:10b6:805:cc::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Fri, 22 Apr 2022 02:47:43 +0000
Received: from SJ0PR01MB7282.prod.exchangelabs.com
 ([fe80::319b:4612:e6f4:f22c]) by SJ0PR01MB7282.prod.exchangelabs.com
 ([fe80::319b:4612:e6f4:f22c%3]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 02:47:43 +0000
From:   Quan Nguyen <quan@os.amperecomputing.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        Thu Nguyen <thu@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Cc:     Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Subject: [PATCH v8 6/9] docs: misc-devices: (smpro-misc) Add documentation
Date:   Fri, 22 Apr 2022 09:46:50 +0700
Message-Id: <20220422024653.2199489-7-quan@os.amperecomputing.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422024653.2199489-1-quan@os.amperecomputing.com>
References: <20220422024653.2199489-1-quan@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10)
 To SJ0PR01MB7282.prod.exchangelabs.com (2603:10b6:a03:3f2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f7d60c1-e2d9-4c13-1fcf-08da240a7952
X-MS-TrafficTypeDiagnostic: SN6PR01MB4653:EE_
X-Microsoft-Antispam-PRVS: <SN6PR01MB4653DADCA19B1043E9677AC2F2F79@SN6PR01MB4653.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wh53JkTzVj5mHo8D71GHLARgrA8bG9jmsucyLP1Qv4f4xG1vsxPncEy6qNlv570stZQ+rNA8OeHVddvjHwY1FEku22SIzxiXIGl696o+Sny0ZU/bqRf4ua6/6T9PilXwsEAvCa0iEDUb7gYnqjGXFJWoycxXjePYVhXIJ6tF1buPLU1JH460CFUy5JUz0sYhmDGgBpxuyg/ZqjTmd98Q5f9xkNK68Z2NM4ti00b5mM7La7HKReJ9dqRDeqhKhUSwhhkW5U/xFIzTedUJqsGVv9Z3Klgsr8XP7ZlNIvrrPTs6wF7bmY7um3MFigv7Sb7yLG9jgD8JlcSoswkLAf4NeiEKBeWb3SuATR1+184FUISVkTT8DYX5OF89k/v5Alqd/wkjEcfCAaOu2JfxfjHnSSu8Qc9OubfQfwapV+1tzEnc2MdwfULFF1ySYbaOgKk/wdy/1rHSeCoKfkVVsJ7WXKLG9xbbA3ixmDB/U7mhb3mV9ro7k9szNZzfrqs0WIsLQJeKKm0SjQZsZRUdyn4vKAYc+jAdO21U8lIWCskggcvUkhLt4wUc0UIAoC7k7L0JKq8akb6sLbZqkGZ4ePdwXHEgwGnOu8EJ8001rZNNDM50YJGruYhonSEwjvd8pj7xkseckQDTBJTv+5AALvlpqRHZ+gBLTqDP3jg/49jtIsX0RDuz8OVRYN5FAg+yeQQjzo96vXAAYa5l30FwoNBVdw4pV4bJdcvt5WZAetVQVkU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB7282.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(6506007)(6512007)(508600001)(54906003)(8936002)(7416002)(66946007)(66476007)(107886003)(8676002)(316002)(110136005)(2616005)(1076003)(6666004)(66556008)(52116002)(186003)(26005)(86362001)(2906002)(5660300002)(921005)(83380400001)(4326008)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n+R54wh9khlwXMTGjv+x/bGXFZ9/DVEPGB8vq6nBxoEFcTTonkOYp1CDP8SE?=
 =?us-ascii?Q?V17ulD9gpEAP2iY5FM7zOl/2CWHsyh+TvUYn3kXKG3LT5sJxc7x8vyscjAw5?=
 =?us-ascii?Q?avVUIumiF1rbfl2v4YFmGeXSKk5KljWJK8HHA6zjZBTOGUt5KQXhH7LGH8HC?=
 =?us-ascii?Q?FSJiRVempGfexmpWPrZhHGYuCoKo9QbqoBgMAkr2pUAdNlkj8WymGzgoETqs?=
 =?us-ascii?Q?a5P2/9TUCGRiPWDqmyFitUObwq5iKTggMMWfut26w61e9+IDl7JwynK5d/eU?=
 =?us-ascii?Q?o2uEanvz84iO/BzkAz5iUp01lMfx/sFkDDLx73e4XKc/kUuOJXGeMUsFSD7E?=
 =?us-ascii?Q?yMmlOjtsp+gUz13L31vNO1nxq8r34uwGjYSTtMFWdLBtX7evqCPxhmF8cv4y?=
 =?us-ascii?Q?aHfV45aDDcJVjcnz1PdxKI6Ve9Y2McYKbThfWnTyPxjobRV+tI9KaYmUfmCs?=
 =?us-ascii?Q?1fUPuisURU60/L5yvzKZAaDZDfbLmuYvGaOWenfPLPim2oVAOLUpzCAlyEbr?=
 =?us-ascii?Q?eEaaygeOaDJpZl9gwUdRbj30egxPLlAWfvZlZNNdyefK/AFC5vOa8WMN2IgC?=
 =?us-ascii?Q?HKI+Lwa7iMoqtRzxoCb6FKr3cJJ+qEsSUI/ibDYmx3CsXq//iMuXXYogU5PT?=
 =?us-ascii?Q?Kr3Jwl4ZHfRgjPjYp6pH3rFqK9GNvMpYHLUp9USqK+P/VtLbFmKCwExSmkYg?=
 =?us-ascii?Q?T/sr5Ky5CkIaQfR6wxv5/z27EtujgD2OHSlADMmKldgXVWT9SpcCns6LTKyj?=
 =?us-ascii?Q?Zo63rTjJuEdF55emey/QHuVOtePfD7xIw1qC2Urmqh46UWfvoG897NqaNGKh?=
 =?us-ascii?Q?4mbU6iZckYRpjgJdXT3M9LL78HF2k+UeWRRJr0ASnx3KPJg19aIEcKGeoHrV?=
 =?us-ascii?Q?u0KvOCzC4ngsNnZgqsyOTRJjZnTTUYHLc15usRkUJmEon4vdoCvU3AnNvghx?=
 =?us-ascii?Q?5r3ThvMRXAEFDZ9PLQ9dwA1GwweCFaVGffTGKVLRLVF3FWgYHGAegMmYo4W/?=
 =?us-ascii?Q?2WmKWYOyz7N7XlrUrM4uo+e/t1C2vzocfBwX4pIRFdSx2MrtvsPH4zOjtj+M?=
 =?us-ascii?Q?FBI5hLQx7TR0OiHqt7fcYwh/6LUuwV7rwl9qdVwUpzB71z4GejREFEvcdfDc?=
 =?us-ascii?Q?Ih13BrCCDRFH1VNWHdzbqVnxgHpynq4Feg3P2BQLVSmBxd+dq7/XpL0OPzIR?=
 =?us-ascii?Q?rn2uXuJSglDJ7nNCtbzodSW8SEdTE/kPJMwv48oGHIKwEo7AmSbpkVnNbhor?=
 =?us-ascii?Q?Yk3jYVCn04Pga0JsJY2J3fJP6vg5ryb/tx7JgxK2TcF/vf+9XiqXZRMic5Zo?=
 =?us-ascii?Q?Ng5Y9pYkQNyiPj7JlqewX4eXKLMvKuNAJdHljs8F5f3lCXyxHcCirw5bsCHM?=
 =?us-ascii?Q?+D0xlbwH30jrBXSzCby24iFhqV/iyzPy3zC2NbdyuG0CyPlr7qDeNKZO8LW7?=
 =?us-ascii?Q?yeLCG+eBVYARwzhKppn75u1e4/jdlYCLf8nhx9hT+iZ8NCE4qtbK50PvlplW?=
 =?us-ascii?Q?P7l8VvMiBQH2jdgS59Glb12oA1WxlWvuo9FA8XP9q5aPbb0x5WOkF7SKtgxc?=
 =?us-ascii?Q?P63PWF824DDc+bqlBleaUgxEBo5y3exxRPtJKL4jgWAyOS8hXFb6qA6MDoaK?=
 =?us-ascii?Q?KsaZt6ssAn9KI1qDR+QarVUy9DR7Daor77Rm5TczwVS0nxHxE246J5rj5gfG?=
 =?us-ascii?Q?RTMaNK6orWN4HpU+E2DCt+9CTHH8Aa1Mf6Rj29jNxyavb8g6SN7d53qgjiYu?=
 =?us-ascii?Q?IfcdWTfM1w6aD6euj3f+oEXoy++oH10zqgHM9mWRyw8QH4MrQOL9?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7d60c1-e2d9-4c13-1fcf-08da240a7952
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB7282.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 02:47:43.2544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPP7Dyuj4k3q0F5r2Dp9WWB/eHOrApmLslsQRCRMBuOUmrT08P6AjFXtrDAzIRtGHOAgyzwEWfqV8UAlh5SLlUlLFuKIO764uDyjeKh/Ncc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4653
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds documentation for the Ampere(R)'s Altra(R) SMpro misc driver.

Signed-off-by: Thu Nguyen <thu@os.amperecomputing.com>
Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
---
Changes in v8:
  + Update to reflect single value per sysfs     [Quan]

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
index 000000000000..7d4123991c5d
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
+<boot stage><boot status><boot progress>
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
+    0102808454A8
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

