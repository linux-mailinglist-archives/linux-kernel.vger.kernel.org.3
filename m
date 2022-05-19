Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C132D52DD2B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244200AbiESSw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244126AbiESSv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:51:58 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2111.outbound.protection.outlook.com [40.107.22.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA585E76D;
        Thu, 19 May 2022 11:51:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2lhAyh1gKZRulKZ+07LW85Fgl9+KxsLaWt2/l08PIzCp5wtVGTIPekt7cKdydwk8Ea4oBmbZ02TN/dmg7Ft3GCznXpWQWlqASuODJw0xen1PyvQb7Sq9SxxjwMRDwAQ4+vWzbpRJDklaxlaqYcNX2/DGccos5zAVMLamlQpl+05rRslN4y5LRrkj8TuRCn2hKE36PB+2sXwFzf9DhiFk55gCha2qTeG/lRRIzbXqdd23b6vYW/4xCotreGDwgGRlc8pmE/J2Ct20N44O+hLKhgjP3fJMvbQ8PX6x1BRCPn2YwacKInpmERYPp9ZpnYPHF8xldbcilEta3aQzt7sIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uv2pYJVnQP4MhtNzkeBH6lfqgjw43baCXJ3Djm3cSlQ=;
 b=Vr04rnz10RrLF5eokqJrBf2cb/oYMIwzGxJ/9HRXxcbrrrcb1rN5eYGvl8AeKRQEFs4UkhnLmKsMWuzWtHCufmG+BWcyYSRQqa4H6HoN2Q673QnY240hfAqHQW3qTVTc1lhprW2wYZtSmFpzrLpUL/fLJhfLMMIuNOLzeQnoBCZo+M5YufHkxp3RZdravRY2Ky0kcvJSHNRhfF63iku5+iYQgkLr+BPCu7pjJM0Q91KYt1zZroC9ETUx0dy4ex1qStOaSw2MurZmX/C2qtTwjIOgKjdHmgbSJYB74UUHluosQ31JPFqxR/p1NiJwKafOA3yQ6goaD9ySw8a8/604ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uv2pYJVnQP4MhtNzkeBH6lfqgjw43baCXJ3Djm3cSlQ=;
 b=nAFI+QkJGqI57fBeEvFNPBTDKaoar4N6lerWrKLIGlZqw+F8NSQsjM2nPm5XN3MimCCop7tQjHXntosEuomq1rDHuB86pbm5NISZ69D1lnSQVKAEwbZGkYNBG5OsNYj0cSS1RW/G/8a/XYlljaeSb6WsBsYAQL2/oAMG70SW97w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com (2603:10a6:803:51::25)
 by AM5PR0301MB2546.eurprd03.prod.outlook.com (2603:10a6:203:a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Thu, 19 May
 2022 18:51:48 +0000
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::b513:6272:f3c5:c709]) by VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::b513:6272:f3c5:c709%7]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 18:51:48 +0000
From:   Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Paul Burton <paulburton@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chao-ying Fu <cfu@wavecomp.com>
Subject: [PATCH 08/12] clocksource: mips-gic-timer: Enable counter when CPUs start
Date:   Thu, 19 May 2022 20:51:21 +0200
Message-Id: <20220519185125.11686-9-Dragan.Mladjenovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com>
References: <20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0602CA0016.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::26) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3661252d-f3c6-48f5-1bc6-08da39c8a018
X-MS-TrafficTypeDiagnostic: AM5PR0301MB2546:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0301MB2546F6B33B93DA45C00E10B1EFD09@AM5PR0301MB2546.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lhjgoD53Gv4X81dBPLl9Kq7mZz2huQCyi/X38C6BsE48e95DDC0FRpdY+Fp1YfKJlPd/ip0hhNV72NzkD1lbdgHA+a825Glq2lY2YywBwr9iHtXVyrpyEChDYMTT2QduM0WMLi7NPsVoRgqn9sLhc9DyiT21Ovs+S0xhRkgQBa0Z3QoR3X7KaR+Pak/0qQ/YEj6/U45NjSzPGb7jxKXxyjkpsz3rLrOSTr6ow7Wpo4rS/w9n5qM9YwepdRhVmxor1ecdP84VjClXJDZNL+T9MM12A5n9O76Ij7Up9QbXTa6vuiZFshuBxLRCnSeGsB7QGZmRMIyI4phu4r6zbUAQjn/On3OqYOa93HclmZcli3liGbWfrDi/2EGYXjosLz3wI0zS/M12fSCNkrZY1td7RTA3RJ7b5Y6vDZnSKf3PMNU6XhsEygL8rkGMIp1B5P7hE9LTQPwHAwWi7hY58zmwJyux+UefNJfbqBwcT8J+sSTfmtzux+dUTQ92paH6wBQPajmrLxwJ4pT3dqfM/iuSBeJ13tRNYTryF8UuPbxO4XFclT8+QA6DnBAMplMsB9Ct6QICPwJ+DRlpwE29Xw57nfaLDyjsfk4+iYVp8N6v+yBmaY70y63zAL2oPtrnQvpVlPwYTSkeeyi1xLCbsL7Fx9aOk1p4SXW4GUNTpaFxOx2Zw28IdlBqXm+XqCZvkxCvjE3Ou0kWbdv1qTITC+4wxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(346002)(366004)(39840400004)(396003)(136003)(5660300002)(66476007)(66556008)(38100700002)(8676002)(38350700002)(4326008)(8936002)(66946007)(83380400001)(6512007)(26005)(86362001)(36756003)(52116002)(316002)(6666004)(41300700001)(2906002)(6916009)(54906003)(6506007)(6486002)(1076003)(2616005)(186003)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lZBmzsKD2DjSq5vhtk3x4Sj9uuv6z6SA12/xkKRBrFeaiRHHIHvjjnsk/nY6?=
 =?us-ascii?Q?AgCGoo/EA7m/HjvZk2f7dnJfORNqt9VgFXJ7Fucd65fG5j2CXwJ2m566WsVD?=
 =?us-ascii?Q?r7MNljMk5lgLl1P8bsvWyhZB0SDBJMJeSn5fpIHoddAXNwrwtmsUgF0DxLgG?=
 =?us-ascii?Q?mJOIz4+it4cb6os3wcYSARquTuriEYfwVTrokTHdYrrAg2xhG8pFSXxalqJW?=
 =?us-ascii?Q?jIScPKrDHA0YXxvGxVViHSQp3+C5sIxVmQQdtGacbXD0zBi8MMLBgstXd7BZ?=
 =?us-ascii?Q?BzGrFBgrOT0lIOimSGc+raMTnCec0mtiM8nsEiTL0UqgKeLrzjdpaHiM8QNp?=
 =?us-ascii?Q?Iw7NsfAmkCe4WRRneAJ3dC9nGVoM29hLAU3fSxqi0hV1fMl0Wwjesk7ejMoi?=
 =?us-ascii?Q?loVQl0sgKHBuVNssM+7OCmYE8NoYUEv2o9StYzRWs+88U6bIj5Njvj6FFP7J?=
 =?us-ascii?Q?nD+zXkwiWtxcubSAmUsAadOQWFF9eFejIpL7qgl6SaScJhKmyTSMHG3W65ce?=
 =?us-ascii?Q?ZSmfMEqJ1SIiw3w/Q0sCYRGP/BHqW2lXGvq7m9qeqHTFk8VRLXCo4qnQzTxa?=
 =?us-ascii?Q?EyBQXMtY04L5+5IS/XsH5b81uWau9F1+khe/9jvOz/v0/o8/FFRCmZ1p4Yml?=
 =?us-ascii?Q?1INT86GJHbER/JLbfU1We2v+aKaPedaD/8XCXZKksbL/KUnyBO3HT92k520M?=
 =?us-ascii?Q?hwfwuQo0TA2qlQVb/iaG0QXehxx0BtyTMihj75mmGWSrSTYJHPhA12/KAVAz?=
 =?us-ascii?Q?f1Qow+5C7mqeHKoNQwP5eIhhT9AnZTLyyjODrDpLZznt4JQkNjFkxwhXbFJf?=
 =?us-ascii?Q?4WYJQssEAQofY7pzPp7iOC0B3rNBGGfCXxIgo3/f0KBKdE3hr4N1ZDpYBDA3?=
 =?us-ascii?Q?xrpbO0QqsEbqc4nRf3NT3NVglEgjltqNTvulwCHTvkcB1PEkXrmad+gmYaaL?=
 =?us-ascii?Q?vWsGkmwVlF939K1ntVOQ25uRxQfWNpG4/ASYIYmpNS1/Dhy2U7zWvJGPri2E?=
 =?us-ascii?Q?OQalTyYrNhhnR214/RDuhEUz5x3fgHhwSjUP/mjG4FY6I1/5TQobPSC27gZg?=
 =?us-ascii?Q?10cvhr1m4ai7TYg58O3GkiT9Ons9vfsI+3XnlwzQLfxiYfd0sEBla1o9GjHb?=
 =?us-ascii?Q?FrMrYJFU2+0lfk0/vK8pZ4yWf4430iolkPjRw8lTfIPvUtqdtP6VXn73o2e6?=
 =?us-ascii?Q?H7Jg+SEcFqmaKpzZTZAxJJVkueYaKkxgw4Hkm0layVUGP/yKApMTHLl40iVG?=
 =?us-ascii?Q?Krqa6nrjneCqMiKHg9ostjF8CYktwmuUXNqkjGFmw5D8tSAuEJR3WPahZZRI?=
 =?us-ascii?Q?oVchDTTsQ1GEFrSTsHQF2MPzMmMpJELRVGgu70rUK7/rxTCDsDs1BOBCvg1X?=
 =?us-ascii?Q?nvOnt4gpKHt91lsryxI5NKr3k7QjwWQndK2AicZwmdxeXCaHhWqsr4b4y8oW?=
 =?us-ascii?Q?B/OrP+R3CLEu9y2xW42OLC2TaRiG/WexCCYx/p7LPHEcQ5j4MS+e446dKAEI?=
 =?us-ascii?Q?LSYSz5WgrYox/w+W7grin02oM179pcHFgRYwCkf4mp7Pmke3kO/Ta7hIjOnA?=
 =?us-ascii?Q?gfXotg35F7R+kd4y04tDKHgd2D1XQGH7VyJrQcmt+Zgoi1ChkX6FmF4ce8x8?=
 =?us-ascii?Q?anBmiKKCKFEX4kL96mJaXAl2GJo28qDW+/455AXRuog+sujpZKN3MkXwQNGs?=
 =?us-ascii?Q?sYUP99YrBzCeDf1pI1XOPUaUSI1T0t0mPDTJlQFBI/QefUz7f6gChAHDs7EZ?=
 =?us-ascii?Q?RwfN0dCsSbEmOWZVfxe/0xK6wQlZiuc=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3661252d-f3c6-48f5-1bc6-08da39c8a018
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 18:51:46.9773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NF4zaHWBryPKXSigaLzvjJspb3AVreDMDOUpdYuUgKqGZ9/WtkdgJJzXgjm8uDUGEtIyiWgR/SH1rEdageP3jpWZxqbqMInLIOUIJNa/4jI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0301MB2546
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paulburton@kernel.org>

In multi-cluster MIPS I6500 systems we have a GIC in each cluster, each
with its own counter. When a cluster powers up the counter will be
stopped, with the COUNTSTOP bit set in the GIC_CONFIG register.

In single cluster systems it has been fine for us to clear COUNTSTOP
once in gic_clocksource_of_init() in order to start the counter, since
with only one cluster we know that we won't be resetting that cluster's
GIC at any point (ignoring suspend/resume cycles which would need to
handle clearing COUNTSTOP in the resume path). Once we support
multi-cluster systems this will only have started the counter in the
boot cluster, and any CPUs in other clusters will find their counter
stopped which will break the GIC clock_event_device.

Resolve this by having CPUs clear the COUNTSTOP bit when they come
online, using the existing gic_starting_cpu() CPU hotplug callback. This
will allow CPUs in secondary clusters to ensure that the cluster's GIC
counter is running as expected.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 6632d314a2c0..90a736a13115 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -119,6 +119,9 @@ static void gic_update_frequency(void *data)
 
 static int gic_starting_cpu(unsigned int cpu)
 {
+	/* Ensure the GIC counter is running */
+	clear_gic_config(GIC_CONFIG_COUNTSTOP);
+
 	gic_clockevent_cpu_init(cpu, this_cpu_ptr(&gic_clockevent_device));
 	return 0;
 }
@@ -289,9 +292,6 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 			pr_warn("Unable to register clock notifier\n");
 	}
 
-	/* And finally start the counter */
-	clear_gic_config(GIC_CONFIG_COUNTSTOP);
-
 	/*
 	 * It's safe to use the MIPS GIC timer as a sched clock source only if
 	 * its ticks are stable, which is true on either the platforms with
-- 
2.17.1

