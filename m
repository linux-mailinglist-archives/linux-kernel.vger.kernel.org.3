Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78E54C9E41
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 08:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239857AbiCBHKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 02:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbiCBHKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 02:10:06 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2132.outbound.protection.outlook.com [40.107.255.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C94B54CB;
        Tue,  1 Mar 2022 23:09:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUhRQEAkjXGJDzo3y1YmnJIVDX3Wa7TBpxPp612NxQADly8bSyaHz2NmUzu6KXfQVEnwbr2kiRzCifq8E2yLN1H2hBfBr8CItaLr1umDwmUI3mOj+uN8Fll2WKLNcBLjEhA3KkxqBaSGlMr4y+7SeXC3V5fVmhDGyWRwSgXCVhf3uIeuVgYHlwWTL99edYSraJ340ZWjSjgRBqxLI0D2x08Pqv7ijtEP0weGFbhC224J4K6gtkkQOUoDviRmXUsPAe5hP5yUFKF/1pqmAAGqT05W1Mi76zptgRfh56Bx7jxDXRDeh4SxCEzPbvZmpOaXIixDYRKPjH/1BEbpi5wR5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUkAD8ddIEt/b361xSe0B4lDQ3sUQZMAWxVH4IPDvbw=;
 b=loM0Wwx7pIjFMAjTMcYISOCKdQKaxCsE3uRlgRZ5AOhrxiGuEQg8IL+Zi559baWI40j9DjZRPyxsmiIu8NP8e+3V3bnHEGx3ILZGEo1zkZGSJTp32fVzDaPJNREzLWOND8wrV2beh3R/2tse2gapZxBu1YDM5URGgguPw6IffvMs0dUkWCVsWMVXYHGGIE3bhcVTy2FqD4+QlUYeT4xoWq1xl16kWOeszy/I9Pals9wV33bnicb4WGFhP+2EC/tzy/aah6muTTucnX62nML9rMRrc4MFpBDTuD6YwhaF2NZumLFsIi5MnxmGJRijGeVg/sXsFqa78ImAghrksEv+Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUkAD8ddIEt/b361xSe0B4lDQ3sUQZMAWxVH4IPDvbw=;
 b=sLZq1S7j6ST6IuLVUnZV/ZRy8VyNx+aPt+phu+jeBjlzs4F7xKiiVnuq3aWgmALI8BPXP6bKylMRKLaRFirnlISefmliseuTQ+uS99f/ZOgTQDdtIqOQCqifPQvuGhbe3ZsIXFY7EXw9WVzrqK5Y51r/dnh7xdEi8MIH7m1evXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by PSAPR04MB4488.apcprd04.prod.outlook.com (2603:1096:301:93::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 07:09:20 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab%3]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 07:09:20 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v5 1/2] hwmon: (adm1275) Allow setting sample averaging
Date:   Wed,  2 Mar 2022 15:08:30 +0800
Message-Id: <20220302070831.23822-2-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220302070831.23822-1-potin.lai@quantatw.com>
References: <20220302070831.23822-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0139.apcprd02.prod.outlook.com
 (2603:1096:202:16::23) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fdf0050-9907-4dfd-90fa-08d9fc1b928c
X-MS-TrafficTypeDiagnostic: PSAPR04MB4488:EE_
X-Microsoft-Antispam-PRVS: <PSAPR04MB448880C29A620719CA9C8C4B8E039@PSAPR04MB4488.apcprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +EOSDyeREHyMl+vbBG8RpYgyaQMHvrjNPWsQ2g3oGJ2Se41TMLJxIqyIiHQAz8Kw880tAD0pnQHHn4hyJEZ5Ur6RlZP6bR4z3kJo4XhWOJL3edq9xSfmgyZ1iNmvhY6Zxy7nuiTH7Nz5cfSYxBSnbRNhh2cUPSHC/8jXjsqZJeXHN45Rsmn6o3HaBbnmz4ALlskflpT8mYhJqOheIGcG95zlak0agoqSlNQme/7lkJR6nV3BvJvNJSTD5HlS9BpUwqp/69nwQA9Ap6S6+p2N0UohkKMd8mhgLxPobsyWQ+3fJWFhNv8ivguOfKVwKvyej1xQ885YGQ4quVEduAs7yALuI+4W6qclIi7cbBLsn/WZoKOcbMnvuKqvNYObVQuo5PTb2nOHAFQY15gsgqkUSM7/GaIjcCyQU03zs/DUTbZ/W8OsBHPQrM5Dxp9IziY6Wxu9aDuOCadMHOeEZHsIJc8qIP8hY5KVgbga9MvHTtLmESP5cy0tNxTz4NI8vaqiJx4eDvOlagMfDtWOEoQTdILV3UwQgmsGBjVZeg1KkDOpXmzrnAAlbFISB5Jiap9nmAI2UpVfR4H+GwPD3KCh1BE0N0C5iJtnMy6qxL8j7pW1pjyebwHtC9ceHBBCcXQzrXXpFKvk2+vjWJ8O6s8NDleD2Z7OWS0m/nNi1Ss01XW8uClfJKNV1vuBeZvfU0Ou/0WQX1HCcFI0Zw0WRg1Syw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(2906002)(36756003)(1076003)(26005)(186003)(6512007)(6666004)(6506007)(83380400001)(4326008)(5660300002)(44832011)(8936002)(66946007)(8676002)(107886003)(86362001)(2616005)(38100700002)(38350700002)(66476007)(66556008)(508600001)(110136005)(6486002)(54906003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7quNwMyp11tQIKsGYaro2jczO2KP5Dx4RWk3gaiXnw2A9t09L0mQa/RHnFxU?=
 =?us-ascii?Q?vykynBYt92QRJ9r4t6+7AEKTaq7PYmz8UftXX/vxEDN/pIggNDRDnS0Duy8W?=
 =?us-ascii?Q?WGR5ULG/aVZGIs1Euud//oQjiwocB8UB76pNZ9iVwTTOfi8Whnzy9aIApyZT?=
 =?us-ascii?Q?mQ4toZdEi/fLweo3jHv0EXYWBNbtU5viieXr5f0RWqdvLPXCYx71MxofxXmE?=
 =?us-ascii?Q?VlCtqIEzsrSdJPNylYDKqhK7xzIqRLMDPxKA6wc/J/mtgvHFTBoxbS4WeUCh?=
 =?us-ascii?Q?YnX/uYp6milQ6Wo/h0I1VTjxsTyxaJC7fl0mmdKShb9HOTD6ZGYBbSXDeofr?=
 =?us-ascii?Q?DPS+6ULaua0qS7mAE6F5rZBAoVFWRQWBoAbC4nwuMpJvRz0jsbozP+g54Z96?=
 =?us-ascii?Q?OHkuARZ3TpC2e6I6NuNDO8LN42eCdMYkpollhCLBjEyT7chy35bRbPU+F00q?=
 =?us-ascii?Q?lFnWLm+CXI9gqw8NiE4VoaIQ54AgZIIh3dHyUAHeWYz5AnEYYdOMSSSZu3oh?=
 =?us-ascii?Q?t94oZX5HuB0jZMd3ABTrKK73Ayc4Mj50TSkmAKl0fHKa2f1/pJ4xk7a/gZlj?=
 =?us-ascii?Q?IwzvI5/royZr6lTgnul+ud/DIoXDjF7iNCnCfkNGzIpWWogAz5EMcmJScjWN?=
 =?us-ascii?Q?vHp4L9FXWfXNinFO02Es2hKfgH+4UQpq9Dgu5tarkgIlF3XapuK5W98ZQbFL?=
 =?us-ascii?Q?zYWj0uwE7CjgccvdywGOOFxtPc71EKb3z4pUBmcIg1+x+2gj3daHibec6cMW?=
 =?us-ascii?Q?UzLLuTvwPAkNS1dB6d3TiDnWOoOeXxVxJsJkQ8u5o8oR9/pGLmKEHuP81GhZ?=
 =?us-ascii?Q?6ioh6Y2pbQrzVsKMQmqw3lJaiU+s7zpPOAKrS7Rb5vkvuUSRVpEpPqNp+KYm?=
 =?us-ascii?Q?1onS2I8YI6aY4CeoMGyL2FlpkTRqxI/DUTVk06DOx266Ty/slvp/7TTRV5qf?=
 =?us-ascii?Q?wQ4afFR0ARRJp0Dnkw+rzd3MklOLuQNbjjxSTgt7tfbrjA4hZdjufo/aoVlj?=
 =?us-ascii?Q?D+DGryXe8H1oZ6C7pMBhtpjPj3XKO1+SU7JT7hDRWc7x9C+Rmbei2eJHhRXm?=
 =?us-ascii?Q?Ugyv/YkYDIfa/1x/WigsmYM67eiGyuM1AfWbaWYaSKzIBF/ITtvTAbPapJ4Q?=
 =?us-ascii?Q?dPnpHZnJfpPf6kuyZ35sBwKcpn07abum2yRvnqbk+KZ+n6iPZ0b1wflXwjFG?=
 =?us-ascii?Q?KczwO2bQuD9F2ljT/l67pz8KjEsax37LQRo08llqstvI1XDHEfj8AXntMXET?=
 =?us-ascii?Q?WOo9uzSW0obyrD9yBmbvtlCf6kFZI0hx01h3ipI7d92uLYE64aYJfEods+s7?=
 =?us-ascii?Q?m+89KmCfilTyKdCNUAzqKs4lkF9duFOC835AmJ+XlMPBZfi2RbhGOIQzvtZk?=
 =?us-ascii?Q?j5lUlvsEer2Sn8xtTV5MZ+vCwa+EEGCHPP+U09LeaKwxMAEU5rbjrk2u4FHh?=
 =?us-ascii?Q?3wtpUonzrECsiF/4sVRj73Cs67I9dysHfhAZEssUyLkQAkrUUGkgfwRy18xY?=
 =?us-ascii?Q?JYQbtnWtNBr5lzLEplCBP2WqqjWamZy9w3SbsLd2AzmW40ybGpvJTSsAWOCp?=
 =?us-ascii?Q?T2Vd36pR3TRLQmeVM5J3EzR/uql+9Vh8qn2RENP1MyWPee9njoAJVzCr6X4z?=
 =?us-ascii?Q?bHs31MDnluqNnAM4VWLxaz4=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fdf0050-9907-4dfd-90fa-08d9fc1b928c
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 07:09:20.5450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PEUypWEaxJRbbCLvzCOvhjJBb9XZItd5lF71OPu+6KF5/7QTR+CojXQ2LUA74EuzncHEzXLrZo92V8tDwcn3ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR04MB4488
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

This patch parses the properties "adi,power-sample-average" and
"adi,volt-curr-sample-average" from device tree, and setting sample
averaging during probe. Input value must be one of value in the
list [1, 2, 4, 8, 16, 32, 64, 128].

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 drivers/hwmon/pmbus/adm1275.c | 40 ++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index d311e0557401..3b07bfb43e93 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -475,6 +475,7 @@ static int adm1275_probe(struct i2c_client *client)
 	int vindex = -1, voindex = -1, cindex = -1, pindex = -1;
 	int tindex = -1;
 	u32 shunt;
+	u32 avg;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_READ_BYTE_DATA
@@ -687,7 +688,7 @@ static int adm1275_probe(struct i2c_client *client)
 		if ((config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) !=
 		    (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) {
 			config |= ADM1278_VOUT_EN | ADM1278_TEMP1_EN;
-			ret = i2c_smbus_write_byte_data(client,
+			ret = i2c_smbus_write_word_data(client,
 							ADM1275_PMON_CONFIG,
 							config);
 			if (ret < 0) {
@@ -756,6 +757,43 @@ static int adm1275_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
+	if (data->have_power_sampling &&
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
+				"Invalid number of voltage/current samples");
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

