Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B9E4E6935
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352908AbiCXTWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352899AbiCXTWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:22:20 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021026.outbound.protection.outlook.com [52.101.62.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2A1B6E7A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:20:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=biDXGQblhTuMk5/qHh9z9LiF9e/WjDhJnPirkZFXMGiTnOgaDCPe/3ZUGK0c53eh+RofiHTH/iYpKg00/uLoMD62a36S54XST8No7P5wxj9EFoIN8Qvh+hixGolcLg4XOte3TF9nmlgk0fmTT1Vh53iQCUauPNA8OIN7EECEbIypfpYeRkAmD+diXu8fX9iVGIgm85YJzjvI/xOSYuDP2GV+N96VENqEZtcH9QAMjjdTF7v0aIIbAObnN78yw8IWkQ+ZWWi14Q7ibdHFsWkClNyCYbVv5Ycvp887aJawdC9QCtxWvIm85F/9yBm1EZsiNvdfU1F7o9wv4xxmlA111Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGjjGS+AOfRfxWSe1amqe057oB+aYKbK6tac/XW/8SI=;
 b=iOGtsyiZ/GsB5z+KgOkAgKeYPSbaLfQOfxYIoCeLjvC+Cvnom7DMnf5zeMaPX7SGb1Ra+rhYnLs/Gn20y0PS8zWJWIbo3r01asTUtS/fAP08zRu3YAzyuBXlUbbclB7NmVO+J9EFh56LHcPeq023n2oqjIN/khCa/b5wbEjVqrObInAusLa3lwTtHylvq4AtHiDOGzwHkY2Z7yxE9G2YeVQk0G3PXUjWWZuMNXCjcRkcrmwdQuvRbsEEBRqNchBcU8UiCYJxW5wLH7zMtIOju9tWH3NXYZz1JkhHf5W52MEOVLFAHWd1G2a+mPZ0LDiy7LdC+8o8GvZCWDl/odbFRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGjjGS+AOfRfxWSe1amqe057oB+aYKbK6tac/XW/8SI=;
 b=esFGHwg78PEbyz5gEOCGw12LmhJJYlct3GFtIV8D1mWkUrSXLDNQR/fe3AFHpmSLPByRKanqXXSpXBBxnz+JckoeRaZ+WcV6SMbvQxv6lZ++4TAVSNGyQt+qAPNpCDQyWvIxxaxOK5TFnun46TA/C8rUn8XWnz4OwIsZKLmSr7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by MW2PR2101MB0892.namprd21.prod.outlook.com (2603:10b6:302:10::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.8; Thu, 24 Mar
 2022 19:20:44 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::f8aa:99ff:9265:bb6b]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::f8aa:99ff:9265:bb6b%4]) with mapi id 15.20.5123.010; Thu, 24 Mar 2022
 19:20:44 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Jason@zx2c4.com, tytso@mit.edu, ardb@kernel.org,
        andy.shevchenko@gmail.com, hdegoede@redhat.com, graf@amazon.com,
        rafael@kernel.org, linux-kernel@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] virt: vmgenid: Recognize new CID added by Hyper-V
Date:   Thu, 24 Mar 2022 12:20:21 -0700
Message-Id: <1648149621-2335-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MWHPR15CA0072.namprd15.prod.outlook.com
 (2603:10b6:301:4c::34) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 722abf75-bc6d-4353-7b5c-08da0dcb6453
X-MS-TrafficTypeDiagnostic: MW2PR2101MB0892:EE_
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <MW2PR2101MB0892D70D31500E08F7FBB4FED7199@MW2PR2101MB0892.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CKG3dwsJkyVX0j6EvKxrVUgY5kjKRPvLYs4IBm92VjIn9rOTZurjpcFmVBIpLTG6XR3OQ2GCsZbqymjWdZ7H7KmphfjKnvrlB3W5hpgojIKz5Q+5hVM53a4AsHCuNXlYFgjsidmMvMkdT6prFhCfLEowETMEdW0VUrFVI5g3//31iv5gm9YG5FbyIesbjTwUeYar7cotbHhLB+TjO7m1rNmdgAms7bErm0iSYHzcUb9mfmedczpNr7V+CvIlrX8+WQZ7F5j+imhDz0LpKYQBk65/x1illZqIXW712qTofHbtodJZ95NCZ8nZGGaYVIi9r++ZM2ju3o7B+olVVJaDB2IcwHfSxr927u90ZPs5FfafssiAPZlO3If7y/RbMjgQXb1hf9lItQS45t5uqML9Z7ui8PDmOXhx39CUy5c4q+4+qeozAAxzuFVPWOdLPSb4KwtLnJwYaB/VxlCPbb23UEOIH1LKsE+hR1MEFALKjPfPR5AR+jBJW3xSjPggkGxhn6Q/lMQP5b6m/eXwiv4QFjCUlXLB5dfa8Es1pZRmXBa3vFg+ns+zwHdeyPOHSDR6wnKBUYPcitolmNFvwYtHrIxRMNqMzD5Mp4lfvdWK7R0+CEN84eJpNZhukD/JoRAdniGiGizQrJH6dUUxaslFWjPLka2VJO27wRvewRQWeIjFG168GEUEbwoPubuglyql4DoRsIf9lLIxWmJC0NaBqgSvGwNhIg7HWL3cc9nsMEaQ73XmzOfgiCbOQCOYMGZr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(316002)(36756003)(82950400001)(66476007)(4744005)(5660300002)(66556008)(8676002)(4326008)(107886003)(10290500003)(508600001)(66946007)(2616005)(8936002)(6486002)(2906002)(26005)(6512007)(186003)(86362001)(38350700002)(38100700002)(82960400001)(6666004)(6506007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h5wr9XWvSDuByKvBGP4FZP1XW+5SoyZ05XXo57ukPo+cVEzV5JFCo4jMylHB?=
 =?us-ascii?Q?kxkYeEWrVbdJk8SOSdQGXF6/Nw0Lj9qIqS+u/IOuPqGGQgQ2cfyU2lhlXHGF?=
 =?us-ascii?Q?doblg6ne3b+jKtCCW32x3BWeht5UazzuwoXeMOO10ufzFC/xEF9HuYZAqnbE?=
 =?us-ascii?Q?CXy0C/Ju9LXZcV9Jvdya3nLw41b5KQ4Bvb8GB0rlLVthHd8+H+cH3OUpAot4?=
 =?us-ascii?Q?alOEtI81Sfq5zCLRnZxPKAcMaJKPbwUB69ZRtvA2rHLvnP6EtevmBoz9M7sC?=
 =?us-ascii?Q?/70NZyDW8lARed7g+/IX/dQYjl8uFTn7nvtUq840b90hxqLAWoL8C/KTliw/?=
 =?us-ascii?Q?MQmGm5UbYD+CrGp/IjhWV6dRPehOt4qo+oWciVhX72UxMB6EjN+/OB6C8AqF?=
 =?us-ascii?Q?99d4wubtL3t3gBJo+3HOZsfMUILROUXrVcIzeiHmjzzLTK1ZRF9ypflhDH5g?=
 =?us-ascii?Q?8sNGxdels5b6mY+GitMUEi5sWhdwNI9DmpIX11THkLkx08l33HUKcI2q0hQt?=
 =?us-ascii?Q?cfpHq/8oH5h2r0rnXMqYoaOQffXrXd0dEBixQI9UJGqyCIm1czXxl6B5p0CY?=
 =?us-ascii?Q?Gzy7XIIthiDbjDfdSUJWVTA8YGWnSzzbVySDZYNLdPen8lw7ez1ubdssNuT7?=
 =?us-ascii?Q?EZKU6tNhoAlKHDyH1r+j/Ad2jhyoaXKDOydP54z2gKIzr+jbOb/QQa7qO3Ev?=
 =?us-ascii?Q?qcIiJ1dXQDEO1X14QTw7LIUhaXridEjEv7IxC9sRefmnL6KQfdsq3CAJX+ad?=
 =?us-ascii?Q?sUqUEWMKFJWmfLpT9IRB2mzIejfcve2/2+JGK9HkrrYPitCYUGGddtuQVjg4?=
 =?us-ascii?Q?XGBVFDI6zEVhMZADCs+sVNmFKiT004NG8C2l/qKmsDa7TJO4905LJJk9HGo8?=
 =?us-ascii?Q?8E7IP8GrkedziiaogGtlAtKMlkD1C5//R5Uc7OCmGsBpdnQhevdTr+XUPcTe?=
 =?us-ascii?Q?ibuj8ChIZ8FV3t13cz+mFzL0HzzuPJ9y+P9pfapJpTOVAJgMopzdwEsAx0HR?=
 =?us-ascii?Q?dyORT2vRBTPHFkUIbaa5GuwfyemPF0twRGgSUb75qXi6PYXAaC3pDTnAvH2+?=
 =?us-ascii?Q?OisMUGnYDhBUc54ovVu4LqGDQlUTw7EygISnpNN2QBGQL2Sxpa0SU3ld8toL?=
 =?us-ascii?Q?1EKb/susYLb56ImXXUQvlhxsHccztvUmGMeNvC3sNyt3mHSK7EjJf1j1LryM?=
 =?us-ascii?Q?FNFyxIqOtofI5KXgMGd8/vcjm0zCCltjpA7q9Q/aIguBIT7he2F079Iz3qmO?=
 =?us-ascii?Q?HQugsGiplh0ZdSzHyTiW03fTca9gOBJrwgHlg8oQ2lRsdCqCK6nLk7WCdDBT?=
 =?us-ascii?Q?nyoI7sibdS9oTDQ2nQy58SHY1DYrNPJU8K2J/eTG3TxPg0fU8e+Pf0K46IeR?=
 =?us-ascii?Q?1hDRrXCL5leYyOH2hcNW37JK028F1av/eAYyK17biKf4J/rn0Lb1+CDF4mN9?=
 =?us-ascii?Q?YCD6MgYiasXGgFdzdpOv/5UY2mTh25Oipj0Ifx0xbi9xv3VuWYznxp5GUXqx?=
 =?us-ascii?Q?AGrbZGfC7va5cIbHixVxA/kiW3C2/uQIu0pjjh71ReZCzi2kXFUwOWOVrjSC?=
 =?us-ascii?Q?WcTAqZE8tysWJFygAcIfnPqGnt68vdeUwWqJpNq+7PfXfbcm5+Dk8NBSy90S?=
 =?us-ascii?Q?N5jBphOxmr1BVIqZZu10ld1/7XiWGF8cxrEvIOYZOP+9HgqvwiWzMkGjtJPL?=
 =?us-ascii?Q?J8x15Aycx/n0PgS14Gl2VTwYEMZtG3Tu4Iah4uNXFyiFpE58uTtHC/vR6Uki?=
 =?us-ascii?Q?ysj1Gtl198d1648ejEez8EJ4QTTGytk=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722abf75-bc6d-4353-7b5c-08da0dcb6453
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 19:20:44.0671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwE6WmAQs2pCbwOZvgA+zcgGqbrHrR/kgxgQoYVIFURZNm4UniBiRG2ffaaSDybzq4T5esE4nezqjMODdpMbXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0892
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the Windows spec for VM Generation ID, the originally
specified CID is longer than allowed by the ACPI spec.
Hyper-V has added "VMGENCTR" as a second valid CID
that is conformant, while retaining the original CID
for compatibility with Windows guests.

Add this new CID to the list recognized by the driver.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/virt/vmgenid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index 0ae1a39..a1c467a 100644
--- a/drivers/virt/vmgenid.c
+++ b/drivers/virt/vmgenid.c
@@ -78,6 +78,7 @@ static void vmgenid_notify(struct acpi_device *device, u32 event)
 }
 
 static const struct acpi_device_id vmgenid_ids[] = {
+	{ "VMGENCTR", 0 },
 	{ "VM_GEN_COUNTER", 0 },
 	{ }
 };
-- 
1.8.3.1

