Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD054AECB4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242287AbiBIIi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:38:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240988AbiBIIiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:38:17 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2124.outbound.protection.outlook.com [40.107.215.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B627C033256;
        Wed,  9 Feb 2022 00:38:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oM2gsI+xynff08Q4ly2jLWx//T3j0nkSpztsB1Jn8/nBBXaSr+ZgSdGGJ7PloqiJzPYdaNx7UPVh4ysXjNuHGO9BjJQkrVxDnuHUwk0rkKU9OWWaD+OvqoFcK1M01YZpt5JDi4P9527+2BMZfI6qTkZX/BvJV/KTD445Wr6mmx0kMy5ijDxOKFai6eUBM/M5VsYDw0vPtStEOlF8FUAAJS3jEs3lkb+NAchz5hX81YbpQop+ZBW3W4di723bMaXaUI5m/1zHgtPmWwsXHfhaU/KTJpiPV3pmiJMXZOC7J0euSvUzOmpw+vXn7u9zIb7j8nmUgsepmwSqhpqKvYu4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hi0edqozder/jGnhuC1SxTeNbb0sNW1Gu51A+jSJiqA=;
 b=GrWWAhGifG5RvAnEMhEJql4z2DNORnCS0XXH5uVH/AyzcD+R300Na5O8vma6cj+82QYriLIhEToxDZrv5EIJgf7O+c8DcHIc4Lqc6wTVa9ifnIMOcMC21Un3F0RWy080zsXYW3gSazC9lFV2fv9XrFS4OIFkmtxJI6kBP3YNBFo0ULLuFT4tIs5hyywa+c2GA/ozV94Nzk1inTZM8IRBSh79J0I4gydU8pnBVW94Qy2tXdFS3VRCzfuJtdaiOSBNMYBsXo9PuFaKgPb0i+5P8xf0fr7yEmebd9ODfDQk+aWwDYTnWIRbz+wOzSXCw+kCNWkTKoAjxHdqmfMUDpQw9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hi0edqozder/jGnhuC1SxTeNbb0sNW1Gu51A+jSJiqA=;
 b=Ppbzj8IUO4u3KjWrkjp3js0+DKOjzBR3Oj7BpFLzPHPSUJf4P6h1mXsPZN9T727pOrV8W1Gt4ilCIlePV172djrLmzCpd6VD+cmN7G2ZddTmoYvV2yy/AWhNA9M846ljO+5KIYEiHyRSJ/tlRJ+FQmE5zkY/3LIfBzoXB4LCk1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by PS2PR06MB3559.apcprd06.prod.outlook.com (2603:1096:300:6b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 08:38:02 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 08:38:02 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Jyoti Bhayana <jbhayana@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] iio: use div64_u64() instead of do_div()
Date:   Wed,  9 Feb 2022 00:37:53 -0800
Message-Id: <1644395873-3937-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0401CA0002.apcprd04.prod.outlook.com
 (2603:1096:3:1::12) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d23d5c9c-69d3-464f-1e6c-08d9eba77bec
X-MS-TrafficTypeDiagnostic: PS2PR06MB3559:EE_
X-Microsoft-Antispam-PRVS: <PS2PR06MB355906693097420454F27323BD2E9@PS2PR06MB3559.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ozrHawCdz/ZqR8j932lO/eW04gE10AhKmAW8lELYwXBIQWxxxTnIkEV973koeW1nK3vUh2T2ac55WYBlEqyXBbAg392Zlfp3tLg13AGyhcQoAmjTEj04HPTCGxVCOchh7idZduTqPgxR9JjvbwowtYL0M3UnYXtZ98fQgT2KVCxfr6DJFC4YdIFHmjQOfx76LT8xC7ElIHLYZhe9FHN4uIB8FlT4UrgNe09HVISoIfCgnuACxoz/Gm8rZ/EkNjkKYk482uc1py5shkpd/0ZGa8Kl+uZLcp0r4P9qnJ65Z2dvy+f2OhrCli6A00dAplsosBk/FvJ0DlSZTTIEZid8bPVvv5feRSYdOUHOPN5d++txFNrotphhhxNiX89GwccuHYkrxhGpxIwc0waoNwerLZ3HkTjQnQXRQykfQoeZtrUiXBnomfQ29gveEI7zo1XEf0dafa/gquzjAEPxqxGu0p8HLij//VNa1N0+Dprrs36bXpizvmffUW6ylUboYbMfm0ccg6E3cyRYHiksrXgK0bcovKnu8UrOOTgmVqfua/8TCS0B8PPTA1Depxx7mjV1/9JIlbZHTIiojgISrx2D5fTGwDUIMu4QzGFqNZG3WcKLzmK6yLqHG74aSuu8xlR6ps52uXBVsSk5iXJVuBXPSBiPMakw/hzU67G78DMkfAGfwITtFwDu0eYlt7V/TalGYrHzRUqCG7QAb3g7ANSvfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(8676002)(4326008)(66946007)(66556008)(66476007)(186003)(26005)(6486002)(107886003)(6512007)(38350700002)(6666004)(86362001)(6506007)(38100700002)(316002)(110136005)(8936002)(52116002)(508600001)(36756003)(2906002)(83380400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eayACl/w+/lcDdjHVmqQ85v7KshYSgNqXDMMNdleLffdxDUNIuvADba7Uw5R?=
 =?us-ascii?Q?3XwTjIcf4vwCPnukUV23aPRm0Sq60X09N3z7HCKkUS76WonN3Y57Au8fzANc?=
 =?us-ascii?Q?xWK9qKvFXvMwcHrUumTzLI8tuJvO2BQYtY97ky51ew8J/xdoBrCYcbBlONyH?=
 =?us-ascii?Q?vWLv2An24XMH03RQ082rdkM4lv/2GCbIGP5jzAg5HZrW5e+W4CaeVRze4F9o?=
 =?us-ascii?Q?gAB1OOo+/zbF80hXXuiUqJiPL68quXG8NWUGTK95Wr+iw2wjAP4Xs8k0oix7?=
 =?us-ascii?Q?vZVx80gnhu0BUcQw1K17b41rf7uVgXwAvStM/N5Ta1vEdGLIH2HFFYdiet4K?=
 =?us-ascii?Q?FR77jK+fuvfBBmVNtCvFbXPfRi0S9wdzRWqbUSJBbuX7tldapHuFKLmGK4QK?=
 =?us-ascii?Q?NubEBnq4eIh5UmQiaAE3YFFotQZOFYsNVxPKmAmTVESfRxSETnis850N8IJv?=
 =?us-ascii?Q?Xy/hu+8nr2kZDXyGJcLmB66JkhTyH0ifvJ85sYaTi1qo2hsb3/l9KyiFMuY2?=
 =?us-ascii?Q?nkjBUinbe3NehM55uAGoPsNJrG3FGUljxnUCHqa7VT+E3/ff9Hdmwa2dxvPv?=
 =?us-ascii?Q?evVa0TxjiY0+nNAQKgX2xFlG3Qi/baeDehO4PgZVyTJftG9DHiNQ/gy7cU/p?=
 =?us-ascii?Q?Xy74Ppi+em4vU6M2vj4s1Q/i92yi4j9vt31om1YTqmsIDhBNHNR61gWFIMlJ?=
 =?us-ascii?Q?Rha4RHboy/rQsDWHTPZoY+P5R9QA8fL8SaeOmxxjivOLqDWlb+gyR+15V54j?=
 =?us-ascii?Q?AEUIumm5prrB54mswy2jhrDuF2oWfgg9mGk82FLOJMlLUYcm9NNuTcCrgS7S?=
 =?us-ascii?Q?FwuqPSWojCslof9b6gt8G+vDhu/isxjh1yz5Ge2lxIt374ufw+YJzPFvyxKs?=
 =?us-ascii?Q?kxVMY4xT/+3xVKX40c7NI86xHXcPQeXmFTuxoNSYYa3h8+8EgIfNNV67rKjN?=
 =?us-ascii?Q?iUmlEHyHLQ9eQ3RX9Ca92xgMVPxdsaivkUUuGnmYsGE1pa1VuxexmmVLNP5s?=
 =?us-ascii?Q?kziz9avwIyuMHF4eNzK3NPhO3UeGcnpuYlU9W14ebK5ROMPLW6wY+zbfLNJQ?=
 =?us-ascii?Q?njj1ysi8bNaIb9P2vR8GSfdYZ3r5bvRzWtZdC79XZz32mn5Up2y343PwRJGF?=
 =?us-ascii?Q?nNBTnBEXUKtz6/aAR4HJbwHFH4jXBHntijx5mwoH2OKcFKOtlspWsafgdcYv?=
 =?us-ascii?Q?imTDIuZla1wBcWc9DaAsrXHZMs7MSNJbCGexUdKWoMK2ajXHSCNWTQpJi2Mf?=
 =?us-ascii?Q?Dt0c3zxElfGI0K2Ct1d4jwxflHK0FUa4SH8kLwrgt+IETWGXvdaB+h431GJl?=
 =?us-ascii?Q?U+7ANwT1cdU6O5YBy85L2s4e6woTZZPUaZqwsT6HS7R6UDdsFY37AUS9lNWQ?=
 =?us-ascii?Q?DmZ+lZzHqTu2z6oult7TBTuOjEvpdZ4jR8wTILqadF4Zh/MByofrSW4b1iCv?=
 =?us-ascii?Q?mDzb3P60ixjMoHKLw+Zir+sjwHehCCsJ1F41hwokvAnUrxzdEVd8I7O1UOUR?=
 =?us-ascii?Q?kKv3Unx+mmTNXSBHZNw3Rni3lpB7pF9Ts0YmkoUzmp0um1b2qkWn00sYSFds?=
 =?us-ascii?Q?DZolUXlOX4hqWh56n7P9KfuqL0Du63c4cNuxHoXU+IEY6fqPgWxkVO+rvYpR?=
 =?us-ascii?Q?ZnxaF/ZyJbtGCZ7PMM4tN4c=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23d5c9c-69d3-464f-1e6c-08d9eba77bec
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 08:38:02.3742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xswR4gy65zBpi8qTnW1WxIRCPV18fIktBAaDiA2lOTCVWuXbf5nzCnfgv09jjExflZTiLSsAXCK+3cyHChxQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB3559
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

do_div() does a 64-by-32 division.
When the divisor is u64, do_div() truncates it to 32 bits, this means it
can test non-zero and be truncated to zero for division.

fix do_div.cocci warning:
do_div() does a 64-by-32 division, please consider using div64_u64 instead.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index d538bf3..d6df5da
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -160,7 +160,7 @@ static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
 	mult = scnprintf(buf, sizeof(buf), "%llu", sf) - 1;
 
 	sec = int_pow(10, mult) * UHZ_PER_HZ;
-	do_div(sec, uHz);
+	div64_u64(sec, uHz);
 	if (sec == 0) {
 		dev_err(&iio_dev->dev,
 			"Trying to set invalid sensor update value for sensor %s",
@@ -237,10 +237,10 @@ static void convert_ns_to_freq(u64 interval_ns, u64 *hz, u64 *uhz)
 	u64 rem, freq;
 
 	freq = NSEC_PER_SEC;
-	rem = do_div(freq, interval_ns);
+	rem = div64_u64(freq, interval_ns);
 	*hz = freq;
 	*uhz = rem * 1000000UL;
-	do_div(*uhz, interval_ns);
+	div64_u64(*uhz, interval_ns);
 }
 
 static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
@@ -266,7 +266,7 @@ static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
 	mult = SCMI_SENS_CFG_GET_UPDATE_EXP(sensor_config);
 	if (mult < 0) {
 		sensor_interval_mult = int_pow(10, abs(mult));
-		do_div(sensor_update_interval, sensor_interval_mult);
+		div64_u64(sensor_update_interval, sensor_interval_mult);
 	} else {
 		sensor_interval_mult = int_pow(10, mult);
 		sensor_update_interval =
@@ -500,7 +500,7 @@ static u64 scmi_iio_convert_interval_to_ns(u32 val)
 	mult = SCMI_SENS_INTVL_GET_EXP(val);
 	if (mult < 0) {
 		sensor_interval_mult = int_pow(10, abs(mult));
-		do_div(sensor_update_interval, sensor_interval_mult);
+		div64_u64(sensor_update_interval, sensor_interval_mult);
 	} else {
 		sensor_interval_mult = int_pow(10, mult);
 		sensor_update_interval =
-- 
2.7.4

