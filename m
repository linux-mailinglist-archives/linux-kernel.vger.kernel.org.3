Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41DD4C8977
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbiCAKkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbiCAKkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:40:23 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2104.outbound.protection.outlook.com [40.107.215.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99B25A58E;
        Tue,  1 Mar 2022 02:39:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLnVAAtpOOl9vl/tHqDA5BdU2zvOXflDDE/GFxI/IDG4mOkEbaWgBhspf7L4unBxz8W4sYrTdI6B+V200nPZN4gOUNRslrm2ASuDwEXscqyF2kJFr8GDrWOWTegKvz2YrKajQlQdjbs2lJHlJMz+4RIunooMBbfKeQMCA1dDMcK1ruM37gAnfVmgbZvSdyT0qbUPP3PoSoENPdzr1c5WRFJ+QBAZ21NVaEoMcxRo1Haxq5NA1HdJXflAWKiMC85hV6gQYN39T5DrNrHkC3LK6g81yobussNN+Nw6SlFQGvCShhGSlKuAvhTz5yp3IRnRdOi+4Brjs2bnLldURmld1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFFPH7MHY++pNopuUTMEa+XgZQkJ++FDzaxqO9t6h9o=;
 b=bMj2z0uxgmYuF/edon/rOGI0KGJpMRCOHIWkcr0DQX65JsQ60OmBJsgeFzHV49ybQSGebG5uYpBsqrJX+VsNHOR7r1tIIYxHgKgiGKnRLPJLU+7iEis3iJL5QGPfGOKJBFAE3t8+HkXWBAp/l4UPtdAcvjT6vMpVjWlM5wKxo2TlzFb/0IiRqEGDqmqgAuMdGS9xDkrd9SpsVBArp7QC9TGzeeREIwhF5+KVjMQaoR0guO1Jpqh/4Ye/E2Swrpja8NfDfiVZDxxNeN/UMkJ9lenK65qI8SmF5Jx0Oxm4Yr7yaAiax8XubAE7FMUwHm8BlxaAj7EWYTlZDxzlayJ5JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFFPH7MHY++pNopuUTMEa+XgZQkJ++FDzaxqO9t6h9o=;
 b=czgi5wtaM6KGWEJEC+u1FiVAIRcwVPgYL1zd5Ki6eBQH1jHRguljY4Pht1aIfIUM8QhAE3viw5WwDjEN4tYPQuQuJY+jnSv3nCbA6lKvKXxYJIRBAEojTZwuTJwY21NCuNCjmG7Xcib5dWuDbWCh9iMD6jPUagDEIW4QZvTNz1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by TYZPR04MB4925.apcprd04.prod.outlook.com (2603:1096:400:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 10:39:32 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab%3]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 10:39:32 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v4 1/2] hwmon: (adm1275) Allow setting sample averaging
Date:   Tue,  1 Mar 2022 18:38:59 +0800
Message-Id: <20220301103900.12637-2-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220301103900.12637-1-potin.lai@quantatw.com>
References: <20220301103900.12637-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:202:16::13) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eac6cb64-7876-4aaf-c930-08d9fb6fc55e
X-MS-TrafficTypeDiagnostic: TYZPR04MB4925:EE_
X-Microsoft-Antispam-PRVS: <TYZPR04MB49255A92EA423F80EAECF2E28E029@TYZPR04MB4925.apcprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1OPkBLvxvhOpTcKZVvY9v7DLj6L7dmhAcDv8Z/g19q3ORJt1hQO1NZMIdJHtBdAWxggXXYIPTIQfXFp0SbyKdtITksUCm/ISquJt+0NrelK7C8ycof++Au6Agzf1McuBvL+HMUS8LxCNjpzrSlAB3xjDubuiR5Z3fKNYE93CrRHfzTjHtGIzahBomzgdXNdqtrHbBKEdsS3ucgbwFIHblGjWqpRnpQxD7GVbmgAqY69MT3zz3WABBrV2qiqppK+2r8r6x1lylBrrhyAT0Jxd+NwhJZbiRjQFTh0moFJyF051SMl/+DFk6AOJjYCe9JrbMEhM1ZgTySicenjN86zl6gUthFLdX6aNMra0jLpIyHJpQtY+wStl7sfDbIGLxxNHFK4B9ohqTRIxWNzqjobA98okyP6fBUkYPkevEck7JgQxBMEWPFYQK0uFM4zCyu3Fj9p3baOWKqpD8KBaQq8LL/xpIYsjZBxMMRm56GMjDUh5dH8l+BK1nP4ukSRGWVRbBwYI7EZNcAVfjkEnLvIbduHdU8DzpCtYnN67x2jQD2WH9ARy9RTM07uxkIOgs/RA1DSThhUp7Cb8zOsMBLIi99Y7wkTDB9d9ftMxBjpIWl0OiTgCS+hy4ZgtluOi8+T3KPz4Js+0PUfoSqdTwO5RhwJ/rbAMXCFOhxyzCroAkPHe1Fs0842Gb1lkf5Ck5eIF+OwrgHibG5DL9aoXB3M2Qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(6666004)(4326008)(8676002)(38350700002)(52116002)(36756003)(6512007)(508600001)(110136005)(54906003)(316002)(1076003)(8936002)(38100700002)(6506007)(44832011)(86362001)(2616005)(107886003)(5660300002)(2906002)(26005)(186003)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mP9Vg43K74lGCaT7YRJqqey+n/U3SX0VMRS/0W/MmeDTscB5eYGP8xMUwnPo?=
 =?us-ascii?Q?9myZCMljv+9wgPT5qT9mx8/86HlEHBMB5dasuHbKZO7QnMMMwvTCE7VAbMnd?=
 =?us-ascii?Q?JdUTGBPvFPt8C5RXql9AXzZ8an+ElU0qH5xoKs/nKX2gyEq3/rgV94ODQqqY?=
 =?us-ascii?Q?U2C1KDhuPLdWyclXhyYNt9s+5+49Gfx6V9buKbAiEQK+G3/O2BT5qJGtzz0K?=
 =?us-ascii?Q?RaTiRsJ9iK4nw4ZkNkjH39spR4M4KJGxdnHz6ghbXCTycJ6y8veqdEUAAc/N?=
 =?us-ascii?Q?Bgc9ozTHThgRBN3mpymMpzZYoi4RsOnIjCpeWi3zSuzuDYqEgxOXyII8rCLB?=
 =?us-ascii?Q?5ZUUxvBWOvR5HFzH20p9S0IUuJevTydXV/zyvWcw8+mBfP5FNjVqXD/4y9vS?=
 =?us-ascii?Q?IKMRSGqaJmTFHNV+r+kCVsnaj8yqkRD7Lezv1tPfdJbGF9sMQN4MiaxWzwML?=
 =?us-ascii?Q?a2hwx+OcuYGFWXtDU8pD1gxxih2+JGkCDdUu81HpTvnbWdakdkAtCksJf/bR?=
 =?us-ascii?Q?nBs9CHcQQEd1u/FtP1miD4NI8IGixGm/yC9QeboM3JBL51QJWmO/Z/KGy39m?=
 =?us-ascii?Q?MVscAuz9J/5/RsE2yJWePXe6oC0aNjXLoelmWdA3kNZbDO9j1ylzvJJSjjnu?=
 =?us-ascii?Q?M8infzGzbHNj5p1pd1Gwn5YQupRp7aMnZNuBDziI2xhi7rnldbzfy63vKmuB?=
 =?us-ascii?Q?Q0Zd4K7qifZhr3ELdifZ3Vf5M49IlAhypEK0CC14ovbOSKBHS/gxiB74fSj7?=
 =?us-ascii?Q?laLuZ/KQEQ4xvkd3tlT9Hf6oIE2dXJK6EPRRUH5A+F2Oskl7mwfDtf1rQDKA?=
 =?us-ascii?Q?WC01+Fr8ObLHLSbOwnfB/jdxsqhKP3z0ignFpX3q4AOe3LkI9NoWXIqgnHUP?=
 =?us-ascii?Q?9iPyyO32L5yznSzvUCjwSeEjpDmjylZiVwFt9Un733hg+/j21ynog/+gDjpY?=
 =?us-ascii?Q?6AV1kZaYoaZM5TCzFBdilD+eRaexgCH3TNI7u2Q+p2pTJzqqHpGsW/t8MRbj?=
 =?us-ascii?Q?261UBZLvYSX6EhWw29I6dXD8Xq/Fs43w3Tr741JHBxm+itcuUMXcyDCk0Q5E?=
 =?us-ascii?Q?6stUwg2RNE1xlO0uX2k/1FnHoUlXTKzGIDAudM3sD9yh0piYW2mdy6hNoIKE?=
 =?us-ascii?Q?eGgp26BjyoIODU/nka1sRS/dqTE1yl79tgnaz6VabwCNJ7mP1czpaup/kgjA?=
 =?us-ascii?Q?dRCQ49sWPctN+pzLXz28DPyP9/KIVt5S0yCYqxNJ+/pcCJ8sHG2Nv9cLSfPn?=
 =?us-ascii?Q?qEN3W6ht/k2oqSkOupbEQwYE1gyXTDes1g6nhgTaqoNpmgWQWBzcIgTJVeZF?=
 =?us-ascii?Q?bkafSxGV2G1QvOLMcBZeleoIwFltaJDuDJ5cT5gGit9bzkUVeLVZ3o2ihtP6?=
 =?us-ascii?Q?b6p3Cw8FNqJf8bMHqurt8MTfDl1ZuMyyNsi3EQjCT7ysH4paCMu4D3lNqR66?=
 =?us-ascii?Q?DItarSroqX8wSBk+vQffXQZSyR7D6zNzjc36QZYwhMfZ7swmb4D3ZdK664Qg?=
 =?us-ascii?Q?+m9slQd6+Tv/fD8D1beQnLGk/RR61zDITSkcbCUd09R0cgtocEO9ZTfMWT+f?=
 =?us-ascii?Q?kZoAE+Q9a2Y/ibwH50m2yi5pEbX5JFqey3RjrYWm4wax+djRYG6ANY56sRyZ?=
 =?us-ascii?Q?LXN1469nLrQ911uLSmhFPa8=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac6cb64-7876-4aaf-c930-08d9fb6fc55e
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 10:39:32.2775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBYddPMFKVIGNsm9qx6zBrGW1wXKl6q21Dy9rx4tK3YbYm3ywY5FR88gpQsvMVTDZqPAxcohDYh6nzqomxRZwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB4925
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current driver assume PWR_AVG and VI_AVG as 1 by default, and user needs
to set sample averaging via sysfs manually.

This patch parses the properties below from device tree, and setting
sample averaging during probe. Input value must be one of value in the
list [1, 2, 4, 8, 16, 32, 64, 128].

Add property called "adi,power-sample-average-enable" for enabling
configuration of power sample averaging number.

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 drivers/hwmon/pmbus/adm1275.c | 40 +++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index d311e0557401..0afeaa1319cd 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -475,6 +475,7 @@ static int adm1275_probe(struct i2c_client *client)
 	int vindex = -1, voindex = -1, cindex = -1, pindex = -1;
 	int tindex = -1;
 	u32 shunt;
+	u32 avg;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_READ_BYTE_DATA
@@ -756,6 +757,45 @@ static int adm1275_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
+	if (data->have_power_sampling &&
+	    of_property_read_bool(client->dev.of_node,
+				 "adi,power-sample-average-enable") &&
+	    of_property_read_u32(client->dev.of_node,
+				 "adi,power-sample-average", &avg) == 0) {
+		if (!avg || avg > ADM1275_SAMPLES_AVG_MAX ||
+		    BIT(__fls(avg)) != avg) {
+			dev_err(&client->dev,
+				"Invalid number of power samples");
+			return -EINVAL;
+		}
+		ret = adm1275_write_pmon_config(data, client, true,
+						ilog2(avg));
+		if (ret < 0) {
+			dev_err(&client->dev,
+				"Setting power sample averaging failed with error %d",
+				ret);
+			return ret;
+		}
+	}
+
+	if (of_property_read_u32(client->dev.of_node,
+				"adi,volt-curr-sample-average", &avg) == 0) {
+		if (!avg || avg > ADM1275_SAMPLES_AVG_MAX ||
+		    BIT(__fls(avg)) != avg) {
+			dev_err(&client->dev,
+				"Invalid number of volt and curr samples");
+			return -EINVAL;
+		}
+		ret = adm1275_write_pmon_config(data, client, false,
+						ilog2(avg));
+		if (ret < 0) {
+			dev_err(&client->dev,
+				"Setting voltage and current sample averaging failed with error %d",
+				ret);
+			return ret;
+		}
+	}
+
 	if (voindex < 0)
 		voindex = vindex;
 	if (vindex >= 0) {
-- 
2.17.1

