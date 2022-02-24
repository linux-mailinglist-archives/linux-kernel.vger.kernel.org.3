Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D818F4C3033
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbiBXPoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbiBXPoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:44:20 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20713.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::713])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69F322EDD3;
        Thu, 24 Feb 2022 07:43:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tf63DyX1M9RFUS93w2oEm7A4EZOeJklKwRyjEbD/yD6tT1IPJpj5qGo44JBuDkff3kprNomJ9Jy7vXFfXmIEwkN6/6owzscJByjkrCSmupK47HPix8YqvSYH46eZeAKeWMlUXoO16wsXVHlqZYSlOE+nzEnozBw7f0AbmSyX89KNwr/2T6uoNAfoEWEYx0MjpZg+6pUcPN+L5mZsrorv2zaMlyTWZLVLwKl6Wex0of8nCs17xrhiD/Ya9jzlhkldcjT9JCCJWYi959bDMRz+G7Wi7yobymOL/nDoNoscUXndmNtEeB438zT6Xim5vHYDbOqLJ0O410QLZqIrjfdpSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dlqYWpvBUxdAvAl6mNfaGDNe9RFLHI8v0KyIcr03sE=;
 b=P2SoPQ+dFwJ9Dd3zM7qpGCWYyLZ+hLbRDbMiXS6IZNl0yhEvMX17gSSnvNmAgAiHf+5Z4BThSJne6/iG1D8R+tpmuBMCKQn7g2oNlopQOfTUN7EYIo3tEI0uswBgcONT0W5GTPwdSkrbCUibFxlPPKTsjB1FjJcDdAmSQexUBZ5twYctr0Tjl/T/9qYSNyHBj1zqc5V0IgCcHyE2bxQu/ffvX7M0gU0bHxOUBG71avTD4oqe8iCyeey9xaaaLTo+acuJNHCSqWQ0YLXdHo5w15hmbAXrHGT0QTAwL0s3hLiVzKolbdTU60EmxmEH2GZfJTt7lHlK2CakrELSVFBPgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dlqYWpvBUxdAvAl6mNfaGDNe9RFLHI8v0KyIcr03sE=;
 b=suaI+aRrSz0pis+r3wzBSILNI72FCdg9KES3sdEoUrp1zrSxd3EkzQL2HdSno9oAEsQwbuOZUXA4kU8Z9mVnmOmK+AdZZSjX/IS386xNbjqJYp4i7P/J+XhivTWjPtfTTS7vdqCEzS125goOqGT5X5A6o1Vemnk2ZVDorGV6iwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SEYPR04MB5858.apcprd04.prod.outlook.com (2603:1096:101:6b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 15:43:44 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 15:43:44 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v2 1/2] hwmon: (adm1275) Allow setting sample averaging
Date:   Thu, 24 Feb 2022 23:43:28 +0800
Message-Id: <20220224154329.9755-2-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220224154329.9755-1-potin.lai@quantatw.com>
References: <20220224154329.9755-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0148.apcprd02.prod.outlook.com
 (2603:1096:202:16::32) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5a39488-6312-482b-d2cf-08d9f7ac7035
X-MS-TrafficTypeDiagnostic: SEYPR04MB5858:EE_
X-Microsoft-Antispam-PRVS: <SEYPR04MB5858AF9CA1631505767E44D08E3D9@SEYPR04MB5858.apcprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eo8Iv/csmBr1hjDFtcObi7VrgEaxJTgoYIOlG/3rTqFESiSnSlIYI3RxaWtlStTKYhdJ3c1jhDc43SC5z0Ao4SogSk/I+FSI/5Q6a/IyPgqJirksUpAteCfN1XwUxlun8bBrhCjZUJv+QH6VbHTsSx7SCm9zX12zKD1k3jyHkQOUQ9A495QmYi6WcP1vWOphkTMuaz1pc90ZpQz5rzEllDI6R7X5QNYzHO5FJvsoKoHMcLQy1vwz5ro2ErjwmpfJreBeVZU3XUTnSapXR0v3e5Dcxg994Hbf9IHhmR9cOOqlYxDPyW+b/FNmTvlZAzDclhth1VpmXS8AEE5j5C4m6k4/jn+O3YanzARn3Ra5F2v0aextsNv91jC6z+q1NG2NnQchFNv8gt8ZJ+gh4Bu0J+txDbZKJuuMHKO3hDhD/HeEmvGW4R8gl7tliKm6qkcw7VS5x6r0EkiDHC7a3u/DDCIb2hhqkQWlTRegkmQl/m0lT/aPKk5swAIGkr2El0BcSmt/JqLBPopD9Y5n1FcvRuqQr7MWEv7GN7DzfXxBequMyzeRgsZPep10e1STlsSFLprIFBXqz3uPv6zE1INXz1Yg4uQokuQqojUvd7WcJTwZpvyWByQfZoUv9Dwewyh1d8IpereuR5Ueb+YVkLzuopTHsIUH4WVymqOdQTyVF3R9iLygptRmfSInt9GpkUdOOPFToCz3pQi+LEO+eeg1xA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(316002)(110136005)(6506007)(66556008)(66476007)(6666004)(6512007)(66946007)(52116002)(38100700002)(38350700002)(86362001)(4326008)(2616005)(107886003)(508600001)(8676002)(8936002)(1076003)(5660300002)(6486002)(26005)(186003)(44832011)(36756003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F6t6GXljeM7lJJ+owvCVXQNVHJu2z6YCE8iNZoB3oAoRvXOyDC87YzqVf4XB?=
 =?us-ascii?Q?uTyKRxZ5hEODCLY6RH0QdfhBvTLapYDD4B7Wk/GwtFmWpsPPFxTEz7oQUOQN?=
 =?us-ascii?Q?eT8GQO572ckRBoduQyzpZjpyDPIKFghe6Wk8VW7RMrzz3nK28oT9ZjGAFAGb?=
 =?us-ascii?Q?VSY47ul94wojaml0CkczOPdsM4QhTH0JmTGuDwrCcpf466aAhvrrTCc4U8C9?=
 =?us-ascii?Q?K9cFgISPF5/B2LVfDmPr2iXvDXmSXCtSOXQwEb16v7FpCPZkIqkuZVhhcZZq?=
 =?us-ascii?Q?6wk8EihfSrR5H+Ebu3sQQmtGnklwwaumOANVVc3DhTMaOPZAAwcpHnTODZzK?=
 =?us-ascii?Q?4iF6OlulKp37pn2zlh9SwnYw3FKc+vhXE/lTSfKiP21gkxoyX4B3sFGxVBfo?=
 =?us-ascii?Q?U/MoyKjiApqFqfrDjnZXhFNwq2WlPRyFZMub/69IAEoyEZUMPTm+mGLEvO/s?=
 =?us-ascii?Q?VYxtdeSohfTqnprOPlvE0bPUk4BzKmu3D6Jrm3HFnYpgR6q5ZtmVzOHIfTjA?=
 =?us-ascii?Q?bdlqGjCQbtSD1c3+pl3oo9sDrGStwE/717dQ5nreXoMfIA844kB6KW8Qs648?=
 =?us-ascii?Q?x17drKKXM8rpyqLawQZCl9+Fbc2B+u+v7Bl/ZE2yOLeojoFXjzNKwo1GXD/Z?=
 =?us-ascii?Q?jZNSRXmTzGB6h2RuYoaaL31EPU5jtO5c8ma5BVbZA+q1mU9BNL/G8BjS4Cb8?=
 =?us-ascii?Q?oArGVRHjoc1yt0bKwhxxSX2xC1UcbcEBJxKteGjNVY7Q2cJL1QMPKYY0aCro?=
 =?us-ascii?Q?V1hIeAHLBoIq8ouobs0ESA+fpe9VF2ZSrEXvHy1KRk+OBrGyTv+BoKKa/T6K?=
 =?us-ascii?Q?9pt+psrgN29lXz9GhDE83gkAk2Ul+Gv6HxblbF+JDpM6bL+u/D11sL1+WG/C?=
 =?us-ascii?Q?GJ26cSzEjKDuYGYobZqDPtf4MDpmnDNPIm1aw3pI7p85qthuhCXIrmxeGMkz?=
 =?us-ascii?Q?4w8RxHr5YLKjAga1Oq++uVT0t9dm5+yes9GdV2v5J/VUKTL3NnRhgUmg5nHn?=
 =?us-ascii?Q?1lw+WuCvB7ttzz73ZdYl53Pc9YuqM0/jG0nQ/CSlb09P4es55OZHGScYk/KD?=
 =?us-ascii?Q?zO9uw6UgrVOmaq6l2NO+hWU+HtqYLCto5meC95zC/f5pME6wSQ4fHoPtPVgZ?=
 =?us-ascii?Q?kLDDluKlJvoLQM8cJ9kfjxRNuDVK/3R0jPcNm4ct0OKtRzrARJdwUOYxRZ+I?=
 =?us-ascii?Q?SSARGsV96Vwu1ETgc+7Li5xlSlYldTfnEjDwW8TWeY9st6y9B4xy4R3lA3Yf?=
 =?us-ascii?Q?Ac5VYz/CcPWQLxf09hxPQg+vRSC4FMgqvEGJ1nfZqRU16oRPrXc3jQAHNc/E?=
 =?us-ascii?Q?ch3/li6AWufNQZCc+BkPZjFHL3RDRk+NyR4Qq3C3wgH1/Z0Ou62w0CDqBsuY?=
 =?us-ascii?Q?bYZhJzJJ7d3kSBpbSNSK4fDTSqbCMC16U+N57meAYU+k+O34C5s8OwiFWJkT?=
 =?us-ascii?Q?i3Tz6h7hF1P3fJwGgivOiIAulICnmA00xRcZ5LVfNR8GyfrvpYrSQHEnLiOD?=
 =?us-ascii?Q?52zqbl2ecazKWOBIkreNn1UhqRZdf7ppd96mnfK3dTcV/XHizKUs5bWvDrDZ?=
 =?us-ascii?Q?OjjIoLTcaENeIMDfCfgmaxykENcy5QJ4pAGfLIegTlL1LVR5vuHYgaP+oYhM?=
 =?us-ascii?Q?LVEsp4YM6yn7RS7K8dEkDa0=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a39488-6312-482b-d2cf-08d9f7ac7035
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 15:43:43.9584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLy+1Brqftm9qvM9/ffBzWbAe920zBaXukAGtiWL4GWeEh3300iFlE+4309fvsMA2bFnibyYp/iVFYy1hrNOIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB5858
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current driver assume PWR_AVG and VI_AVG as 1 by default, and user needs to
set sample averaging via sysfs manually.

This patch parses the properties below from device tree, and setting
sample averaging during probe.

- adi,power-sample-average
- adi,volt-curr-sample-average

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 drivers/hwmon/pmbus/adm1275.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index d311e0557401..4fc1421b7540 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -83,6 +83,8 @@ enum chips { adm1075, adm1272, adm1275, adm1276, adm1278, adm1293, adm1294 };
 #define ADM1278_VI_AVG_MASK		GENMASK(ADM1278_VI_AVG_SHIFT + 2, \
 						ADM1278_VI_AVG_SHIFT)
 
+#define ADM1275_SAMPLES_AVG_MAX_INDEX	7
+
 struct adm1275_data {
 	int id;
 	bool have_oc_fault;
@@ -475,6 +477,7 @@ static int adm1275_probe(struct i2c_client *client)
 	int vindex = -1, voindex = -1, cindex = -1, pindex = -1;
 	int tindex = -1;
 	u32 shunt;
+	u8 avgindex;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_READ_BYTE_DATA
@@ -756,6 +759,34 @@ static int adm1275_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
+	if (data->have_power_sampling &&
+	    of_property_read_u8(client->dev.of_node,
+				"adi,power-sample-average", &avgindex) == 0) {
+		if (avgindex > ADM1275_SAMPLES_AVG_MAX_INDEX)
+			return -EINVAL;
+		ret = adm1275_write_pmon_config(data, client, true, avgindex);
+		if (ret < 0) {
+			dev_err(&client->dev,
+				"Setting power sample averaging failed with error %d",
+				ret);
+			return ret;
+		}
+	}
+
+	if (of_property_read_u8(client->dev.of_node,
+				"adi,volt-curr-sample-average",
+				&avgindex) == 0) {
+		if (avgindex > ADM1275_SAMPLES_AVG_MAX_INDEX)
+			return -EINVAL;
+		ret = adm1275_write_pmon_config(data, client, false, avgindex);
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

