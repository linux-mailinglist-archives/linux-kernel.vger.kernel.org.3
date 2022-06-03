Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDEA53CC36
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245452AbiFCPV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiFCPVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:21:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2127.outbound.protection.outlook.com [40.107.223.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F5D506C3;
        Fri,  3 Jun 2022 08:21:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4+cCNlC8kOYK8F/xHBQK9J5zVNRGjmZ8ShnWwjX6csRXTF89TNyFm3Pkx4qMBVsAhbMHK1kbMAqt55tnWiUXp82SNx9Ta+gqpuGvb97B5rcAXm7ELxP1Xj3LOj4b00BgnqhRSr8ilAMYvs9caRjTTTV/HIj4JQQQD1WBCntj4lXRTqn0gATY91jm9siAgD0BX/tonZvPRYZOlCXaVU5SSM+W3ZPt5XpVMMqIR1vL57RlbSf5qdEtsOjXOeYEkaBtM+cXbd2WuwUgwshUZ0wImqhSqoI1ED4s8OgqNDmr/sjdWQH/jgJOQ4pEhhH6YdbfFstKskHLBQ1to0DFZqciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvgcHcbTSl/MmZx3FmCNReIJMktR9MoYW0K+Y4RCw7I=;
 b=ZMK+/Pii+kCCIYs4mL6EPnxUUSFK6IABJVVby9r+rEIqWEBvgLdBTNlvMExrR8jqppygM+nGTqjHmwVtnUpEynwDFPB4Gea0QqYeLbvwVT07E1rDPHKsil2wx7qnawfxcqwfeGb5KvSsEygLXZKR6XMX29AxnMdp9mqokQeLuoNy8FVQ5bkkLwv/sapCaUZnmZYBUmMHCX7g4n+w+Ho2y0UB6jDv9JmPIgjR9Z5Xq3v+xYt0kI4HXznk9gQOPvUYOGkYd07aJoqbIOPiI69WNu4mYRK21b+iIv3ru3hrrvBFkkFfmDAQO2rzuM3/uXp0Xg02UM/jzW5ORXJj+AjyLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvgcHcbTSl/MmZx3FmCNReIJMktR9MoYW0K+Y4RCw7I=;
 b=qkHmZw5sJrERCrpG9zm0wtzEmQ+rh8vc6RInanIB3ce06JenqQxFC7LuoXbiDrvSmMosJ/kFuCiGB5OAvjBVy7r4imTvJu/lXdE0Lmj9FO7Qley28nnyDgTqgVwR+XCBJJV6OFmGBEVbO0YE6pOjUWYE6kswTfbTZHdcBH5Ureg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 CY4PR01MB2566.prod.exchangelabs.com (2603:10b6:903:6e::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.18; Fri, 3 Jun 2022 15:21:22 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::b8d8:b445:2b14:bed3]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::b8d8:b445:2b14:bed3%3]) with mapi id 15.20.5293.019; Fri, 3 Jun 2022
 15:21:22 +0000
From:   D Scott Phillips <scott@os.amperecomputing.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        Darren Hart <darren@os.amperecomputing.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH] hwmon: (xgene) restrict power measurements to admin by default
Date:   Fri,  3 Jun 2022 08:21:16 -0700
Message-Id: <20220603152116.2269912-1-scott@os.amperecomputing.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR18CA0047.namprd18.prod.outlook.com
 (2603:10b6:610:55::27) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8de71d1-28f8-46a1-7373-08da4574b6a7
X-MS-TrafficTypeDiagnostic: CY4PR01MB2566:EE_
X-Microsoft-Antispam-PRVS: <CY4PR01MB256676B337411D5C903E81AB86A19@CY4PR01MB2566.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WZvEN63MVwzWRVEfjMkLIUHQDeHQOBk9gdf8UbqvE2OGr5wHF+QXC8fI9MfX0/B8WB2QZZDamOHigeSYhcxaKAQnQSONVujbN3gfysxSyj8DiwEItzAcQImDo+sdkn28EqSt10g2jfWWxBc2NqCx2grphJ/T3zR8fxjO+3XYKxlFmjSLBtny6m1aesWczRZIsL7qIpnmLjPx8j5yspsEFMgUMx3O/+diKPLjXoZyLakyXI6gPVSOD+hwjTfqZPUQXuYGyDdN/hiRCYCQvcU7fGeDmHzVshCFrmWSoOnzuOMF4f2N+dinEwRrvJomEbc6qEgNgPGOPJzvqGb8vmoxg4A/tnXrzVqsTg0unn39w8xNOL8gZJ/HDH7mGawERTJ8dmYHnJjAh8b1SQ4dxpKUZjclS9pFazSxU/eHA1MxzrN0HMYZ1ZMMDyqVQnRQ/HM9eqHbqFGDR/xDjlQX+G6QJFO7+1gLIXdT4m3m8uG2XyC2nKeHNkJlC5lhxxZWJSGCKwtNKgAf6aTkVx0wq0TbHlwrBTOWryjrpQOYjvh9uh/15Z6N6x+IYY9CLvpwbppQ6HqK32hN5VeH4SOHijBYCv42Wg9jBHDsOUduTQy5+OLG7tAaPa3SYlXu+lvsF6u/khL+Rop0Z1IHLDMYPxOJPY4UJL14CB1r3HDt9qcX2BZe0WaNzaW/FFD20K47FdXZawFa06xJ2HdqgwW0IZXCtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(86362001)(66476007)(66946007)(6916009)(54906003)(66556008)(186003)(6506007)(8936002)(52116002)(5660300002)(6666004)(38350700002)(6486002)(38100700002)(8676002)(107886003)(6512007)(2616005)(1076003)(4326008)(2906002)(316002)(508600001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RqdWT2qs3uy5ZQza9WoYi/Z+h7KyCu3nLNrIqBAopBZyXBT+kCP/pmcoJJjo?=
 =?us-ascii?Q?FlEc2Q2gr9/SZCKOtl8zK29hW4QG5144hStO2Mw9kor2zhk20YE6LpXky/Ej?=
 =?us-ascii?Q?KHnJ5GBkyDBYdITOukG/eA+QANTz9waqwtEGb4Hc25M12RvjvfYB3jUJ0HRV?=
 =?us-ascii?Q?HXsFf5zZMDvH+8Kxn/Rpgi3Wz7rrTpWoL4vTanttg6zC3ZnrxynlA/2o2jnk?=
 =?us-ascii?Q?uV2Ak1Tp9wlM0FIvK1Mi94K7tOgqDjVG3//RxJTIik9S1oMgdlrATujWKHyw?=
 =?us-ascii?Q?5PAMnBzqHEuhzD1H7FVtgereCSQxjXUP8rWenap9od7jUPTVGGQ1DtTAuITi?=
 =?us-ascii?Q?e7w0p6oyYhaZVP0XB21CTD5n0igKLhU3HHBbhxpwHWQ9yfJJtfi8elmkyLyR?=
 =?us-ascii?Q?1N4jcifYwgRkcaN1WOU5NPu/KUtRseFNsIe0NuKyy67cSR5emILBcKT1OYiv?=
 =?us-ascii?Q?i42tbrqiRvEhE7TpjntwTvRSawl+CkPVkXbwckwo1nwdhwNW2nTn91N0YvPc?=
 =?us-ascii?Q?U/4WvUtOaCCBZCtadGFkH2sTOt/xoKCNYdB0KgHEPD3YUU8vrQg+wJGsQCdI?=
 =?us-ascii?Q?1Jy6z4lR1BeIEOkhiY9CueIq1UVKmnzgLd6DdRsBlhyCLghACnAY1TZYbGrd?=
 =?us-ascii?Q?HexN2wwqrVtZ8D+fAD+O6mRLRN0Xq6+1EDZYIfSpGzy0XHWKFgLfvZ0cFAxI?=
 =?us-ascii?Q?2bLCeLabUUNz814dlTbpkeVwmU7khq7QipqehclafDR+w04lakzsBZDMrZZC?=
 =?us-ascii?Q?mEZmaUjd2zLdSosOjNHG6UnBfQttVjJEDMzkZhP6cZMm4FWYQEO6q90Dre64?=
 =?us-ascii?Q?mrDgvi0ZKyWMfdLSOAvllp1tGIhwIt5tFvydzBy5+4bgjtGKASl3WH1ekbho?=
 =?us-ascii?Q?9aF7bWjKKmhmbtlunIQ4+j9QhMvbwmml/VPyGb38NZLhu2Itprwqy17KgVNA?=
 =?us-ascii?Q?zmkslIeqNXARMuIkJtWy+sxJYsoJSydzQssnSJ7PvughAEgFaNdZVUV0z2la?=
 =?us-ascii?Q?kvmu7hH6NN0kQQjeMZlaVODB/Is04LJ+5VbZplQ4jzEvf0UTmxC70pjF1/Wj?=
 =?us-ascii?Q?B7dx75vnF04tLbTrXeRGj8r+zsyb7N9kilCJ4pIUybdUjoRIW7bK+xoDnXtX?=
 =?us-ascii?Q?BwVxZtoWqP6//1pYEGfrF1y90QQpzKqaWuyNZKaZBrk6ZnDWaunmD02RlITo?=
 =?us-ascii?Q?RWL3bLV4gLaxHxrRm/dvxkisYqQzAcgX1x8hR1xY2URsx/51fb/rZfO9iTYC?=
 =?us-ascii?Q?6OKtfU9ALTK9gxh+yEktHqWZg/lgrsGcLASoHlp34JHnFQ5r17KYdKOCTFKC?=
 =?us-ascii?Q?ci3BjPXQC2Y6ooXVyNVfGz/pbJ3Br6vt4yZJA9OfcyAa29XXoN4BzWfAWG8b?=
 =?us-ascii?Q?sFLGJcADrJYB/oPstHrqwh9BFqi+XEXGWLlMRfO5tAZyMWlxa6501KITWe1e?=
 =?us-ascii?Q?ScaDYK+XNvNXYjZXSAOL5zkg77k5SlS8qy4PU4PaEe/rp9N852gvNk+Q50H0?=
 =?us-ascii?Q?pAG8PEuh2fhKck2rwFu0u6N/27AxuyMrkYR1eibFIdxSK6jupMZ2SRexNYjA?=
 =?us-ascii?Q?s7+VU6Hh2eyycLtH0waEMUfusT25b2KBfjLWQ9Qcjtf4vHcnT8ztTqFYSY5n?=
 =?us-ascii?Q?3wiLOVo1Trf3HXZaFdL6bfzk20knuSnoktOnKgLod0Uhhje4yUotWGEF6N+W?=
 =?us-ascii?Q?OuV9ZJ7WNRH7ZUrcmjGQ+MUxQDdAUar+qbKCzGGdkQSaxnsKxSNdsLsFMEUY?=
 =?us-ascii?Q?Wp/grTLAVLa6HjwBjSrkhlnISzKcJZwPI2L2IKG8eTwsZOXS5jJj?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8de71d1-28f8-46a1-7373-08da4574b6a7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 15:21:22.1327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ianfho7KpNUrSJ0Uhfj3dKkYxAte1IceHo+4u/wghuCpwHPpBcYyNjPI4dY0dhi3VZQ/uQJR3GpMAwh/6usjTDZayZc0HpGck5tLlQH5j35mFUl2T5Vd5zXIlopaSrJm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR01MB2566
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Access to power information can be used to infer the instructions being run
and possibly even data being processed on a cpu[1]. Restrict access to
power information to administrator users by default. (Cf. a similar
powercap change[2].)

[1]: Lipp, Moritz, et al. "PLATYPUS: software-based power side-channel
     attacks on x86." 2021 IEEE Symposium on Security and Privacy (SP).
     IEEE, 2021.
[2]: commit 949dd0104c49 ("powercap: restrict energy meter to root access")

Fixes: ed42cfa881e1 ("hwmon: Add xgene hwmon driver")
Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
Cc: stable@vger.kernel.org
---
 drivers/hwmon/xgene-hwmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
index 5cde837bfd09..6ad1daf2d354 100644
--- a/drivers/hwmon/xgene-hwmon.c
+++ b/drivers/hwmon/xgene-hwmon.c
@@ -397,9 +397,9 @@ static DEVICE_ATTR_RO(temp1_label);
 static DEVICE_ATTR_RO(temp1_input);
 static DEVICE_ATTR_RO(temp1_critical_alarm);
 static DEVICE_ATTR_RO(power1_label);
-static DEVICE_ATTR_RO(power1_input);
+static DEVICE_ATTR_ADMIN_RO(power1_input);
 static DEVICE_ATTR_RO(power2_label);
-static DEVICE_ATTR_RO(power2_input);
+static DEVICE_ATTR_ADMIN_RO(power2_input);
 
 static struct attribute *xgene_hwmon_attrs[] = {
 	&dev_attr_temp1_label.attr,
-- 
2.35.1

