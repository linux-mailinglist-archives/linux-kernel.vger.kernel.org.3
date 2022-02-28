Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465EE4C672D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbiB1Ki3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiB1KiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:38:21 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2112.outbound.protection.outlook.com [40.107.255.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6D43204C;
        Mon, 28 Feb 2022 02:37:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WG9qlJ+PUBegBN9JoyvJ8mkKwgBFZ52IiSBQyXrRNYaB18lOUCnPvDN4k8onP3WYSqghPJ6AOSL2n6PI3FKnlXgsS7nnFENPcAjhtFLlIEo6qLgcdaSVPvnCcSnLiFVK7JZADYNPp/w4SXEkXN9YeuztAesbehckXm4MkDXigiVUBVRxwrFuS3OmL8waFlyaMwxuRMkz+BQOxb6iBLrbvgo17PIdbfcrDsnrRsyRn6wVV4LkLEmpavovmzIZQWG75ARcwcpfRWdvghRaoDW9ErvtlrvOahWkra8nJFDfSIG5HvLXslA2keVpeanDzV6vSRUFKa4GyqHCJnmLoHcq2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcrl/2qIfxjoflsMxnOckrnTatYdM55dyzFNJE89MYw=;
 b=STX3nIIAdZx6RkekuD4RABcIj9KmMNysbS/yxrWHJ+giOd4Icww0gSfKN72FFV4VCLsB8bfXCwiaGts17fQTEBmt5sc7lPW3fgUUZNB0hmUExrrmqrmPhlpMqmFWEFDzCDyvciQt2VaFiot7FTNfCS6Q94DFk5EoBWOB5hbP/PLdP6LNHquTlUxiE0I3gDBTI9ALNMAEq0QPw3u/q3cQn5YJIcfk4rLMVNu/JAcwEAUvToxp0dazqrmDkmoqSXiW9ABnDeQc5IxNshCe7GezkPWaW8lKnK7zP0RrWNaEFWvXliBW+6cA/KWmrXh+Kwmmq+Mzeu8qQvvKL19/k+7RPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcrl/2qIfxjoflsMxnOckrnTatYdM55dyzFNJE89MYw=;
 b=m93JL6rhliu+bOmqzAlNn6ANcRaKfj+Dfil5Ap4t6eO0djNwWQ1cL12+fnHLfmXy/fKUKlHUozsWC83euG9YoyMmwERSr+WF+b3VX02ciX5dH9ez8hunnm37AxiXC3d9BvcyC5AvT9AnAhmV5O0dE9JC7b49fFYizx4+r1ZpPOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SL2PR04MB3002.apcprd04.prod.outlook.com (2603:1096:100:3b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 10:37:37 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab%3]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 10:37:37 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v3 1/2] hwmon: (adm1275) Allow setting sample averaging
Date:   Mon, 28 Feb 2022 18:37:15 +0800
Message-Id: <20220228103716.10774-2-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220228103716.10774-1-potin.lai@quantatw.com>
References: <20220228103716.10774-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:202:16::15) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec95fe24-6abb-48f7-5e16-08d9faa65657
X-MS-TrafficTypeDiagnostic: SL2PR04MB3002:EE_
X-Microsoft-Antispam-PRVS: <SL2PR04MB3002D46E7022BB169F19E3E28E019@SL2PR04MB3002.apcprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KfDUASpaG/zAW/1W+bYGb2sfiXC4JORqN/EdCZLJZXonDZY2y8WChWWrmZBKdYxo7RfANgtloSrpr7BPt0P+l55CNHtVddJ5LrOeAPS7CQnyW2cBtSV7BPcTd+Y57qpXjOYq9jdKwqQuG5W6yiH25MJyiV6CG39ACSumydF4QIwBpKMgjW0hdtbAxdQDNHIQ0xpOrL5jlr/y/bdtbbKvYDbCz4NQqaCB7zUgb+aeIGr5J9efe4opNzB9y+Vxen6opYLecijHatknqfsfEj0ndWBxN7niZcYWO2Dc9emB5/sI+hWMK3jH1wDSQxBv7zxWycy8ORZ1WKdF4lct+gAkjgE19m24w/ww5ocWX7DPfAfSkBWR3qtiMADV4c7PixGb+ZRqHOCCmwMJa/3z70TjCmxI8XkR/kmAqTZexSFcVWVx2N0i/B3DwOwVfFxhUWGtJp11NgmGLLpBgaINag1FJ9gitsTwkNN8ADvkYAVRGHc37KVkzLW+ZkiZ+iU4M6IhVsdX0y48F6KZFcrbJXu5JKHTHrHK1HoFv0yImh876GLUXJG8K51cUsaq2MeMmTEldweMQ1ggc4n7oARnVCDDHkBjYQL3am3xcWJIX7Gf7ZzzHrqg13GI7+95iTaZQ7sLboJVeeyqW3zNZ1AuPVOhbLq07+wHjop6Ggucz4K9g2Lp7U1Qtapq5XjAJV98YXKpIPOHZeCtivHMHuuM55p7ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(86362001)(316002)(36756003)(4326008)(54906003)(66476007)(66556008)(66946007)(110136005)(5660300002)(6512007)(6506007)(6666004)(52116002)(8936002)(508600001)(44832011)(107886003)(2906002)(26005)(186003)(1076003)(2616005)(6486002)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U9bbYv7ieMQuxpYeJnHnnZV5L9ziZEvpg8VkrAA/WGijC29o+hnKgG+tJ+Fq?=
 =?us-ascii?Q?CPjiJsqdL3LzTKD7N0Tq4s1ywPANb7D+ASk6kWX8u1/+cp/2McgSpinVr3S1?=
 =?us-ascii?Q?r146hi1H2PLRoW1PAbQ7YAZlUjtLqIJaysErO1RKE17FwotsPSuhFV5cb1Eo?=
 =?us-ascii?Q?Kgr14SriMLlhyh6fayhNALJz3vM7MSH1Eb4NoISgrLtO0/ziH4YVR4ODXaFs?=
 =?us-ascii?Q?DWOLY3jx+Hb2OQiW65RrOPq32OTNfXS7fQ32vZJDUIrGAjAC0vNt6xpnQrH6?=
 =?us-ascii?Q?bjG+FilicbC5hRNqHkpyZh9430plfN5glM8XoLfn+nlbGn/N+LEW+CRUszMe?=
 =?us-ascii?Q?eSd0Hmg/2ZjkcQr1sivpzIK1ByHxKQeJj3luFesULinJJ2iPM2C3RUD/+ag5?=
 =?us-ascii?Q?zy5FiTyZba78EC+ZF0REifp9TRnwQlU2X7FAebx0GOs0K8GWeXw4jA7SbGsb?=
 =?us-ascii?Q?baILHU5MzUVxu7FM8Rn5MV3sx90uiLXs40sqrSej+yiWkqwSHstwDOu6dyp/?=
 =?us-ascii?Q?uRq8Jg1keZNfdwvBBbHRmB9oGHnolkR+7qaQcw+v33mv7oC9wpNskqi1JNAT?=
 =?us-ascii?Q?j4QVF+fxZHxMcmgm8S1xK1IqSWwWyB6NKlkcTjdRuo28yReeAtjE6K8cKV5b?=
 =?us-ascii?Q?3iyuSd7t0ZWyrsWOFLGydZzStm4VWQhYQ5hzDhCmLGjIeG9EoVIAwTvs+MtO?=
 =?us-ascii?Q?QgUiD/oahZyYQ2P1XAtc3q5v2BMMIdJfzHTHngab5L1Vi2uyoooWe9ZWw9fP?=
 =?us-ascii?Q?99S6W6fJpFsExjmvczcahUhd8bmT1vvKwNgeyjJr6uMclfq2u9rbxTtpICys?=
 =?us-ascii?Q?2DP+NXX/RJUoMy+RDm30+z3MyTGX1yAls53OoXV7HQs6RSLq1/gPHLnvjUJF?=
 =?us-ascii?Q?tfUVFzCiL4NZSDZLaFoX9SqqUvC6j4uk2n5nyzJaP4eOVsRjPnypDzTenSKk?=
 =?us-ascii?Q?R2BgHsgj86X8//bZpCEo7atEDDtULXh50cfWQ/otCBdjN6T9WNwtFnRLA5pT?=
 =?us-ascii?Q?eJWpVba+m6CpnEol7ahTMqVZjOT2yG3zLRVB8bhyAk90U6QU9yQa5RA20m08?=
 =?us-ascii?Q?sFEFyiOuqQmZUyh0OjwQ0QvlJHp8xFfKsltl6w5QbMA6hlIKQaHRWdvq0NFo?=
 =?us-ascii?Q?fbwwJ9VG/5whQuLmXHDQMbnLeIQ8dHz+Dqwhsd3nvbUpqcbpM4hxwEHiRJEF?=
 =?us-ascii?Q?UOaCYcQUDSNp1Bjz7IFVAU5o8n7O95eGmFYoAkgUNui0ImUaKqr1KnY3bC1a?=
 =?us-ascii?Q?u2vBxWKKktYtz6NyItZMTe5JqsuLjtXDoKDTnX3mctlFWj/5y2r7uWtqiZWR?=
 =?us-ascii?Q?PIA5VJ1eHgCisrKq8k7pySN/tXQ0MyuYoDNmONvZ6JAtuRCub9G9cgpSc4Fz?=
 =?us-ascii?Q?rMHbrNyCPbFH5eRWb7DqoC1BSe9naGWWmRGvmBKG3L094rHcBBIHO+zTt586?=
 =?us-ascii?Q?6D0tsijThpIP+gJh8VkIq++6OlEyZrVdAyvUdlpsQHac0i7b9sSX4oGTbFuG?=
 =?us-ascii?Q?rH3OJoVmI6LKiWbePXxyhowaDA3/2/JBGNZ8dPnf0CtkbVkiUBlTGYRb49aE?=
 =?us-ascii?Q?lV1CfZzpZ9q72Cy/oHXdbYOhNSynyI7djS/e3b3z3wfgti2Z5omM3HYMvAbn?=
 =?us-ascii?Q?eINIKGpppmFV2d7AjTgWh9s=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec95fe24-6abb-48f7-5e16-08d9faa65657
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 10:37:37.7685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOtD+kTm2XsUcLk7mNGBK7onOHswafXIL4bSMwQsEYI/IbqB+waxq/lVhRj+SuOWpUBaMX1cX89tpwr6FjMtGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR04MB3002
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
sample averaging during probe. Allowed input value from 1 to 128. If the
inputed value is not power of 2, the sample averaging number will be
configured with the smaller and cloest power of 2.

- adi,power-sample-average
- adi,volt-curr-sample-average

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 drivers/hwmon/pmbus/adm1275.c | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index d311e0557401..212c7f3c59b0 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -475,6 +475,7 @@ static int adm1275_probe(struct i2c_client *client)
 	int vindex = -1, voindex = -1, cindex = -1, pindex = -1;
 	int tindex = -1;
 	u32 shunt;
+	u32 avg;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_READ_BYTE_DATA
@@ -756,6 +757,41 @@ static int adm1275_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
+	if (data->have_power_sampling &&
+	    of_property_read_u32(client->dev.of_node,
+				"adi,power-sample-average", &avg) == 0) {
+		if (avg > ADM1275_SAMPLES_AVG_MAX || avg < 1)
+			return -EINVAL;
+		dev_info(&client->dev,
+			"Setting power sample averaging number to %u",
+			BIT(ilog2(avg)));
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
+		if (avg > ADM1275_SAMPLES_AVG_MAX || avg < 1)
+			return -EINVAL;
+		dev_info(&client->dev,
+			"Setting voltage and current sample averaging number to %u",
+			BIT(ilog2(avg)));
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

