Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C8550BC99
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350950AbiDVQK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiDVQKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:10:53 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08olkn2047.outbound.protection.outlook.com [40.92.45.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923205DA6D;
        Fri, 22 Apr 2022 09:07:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgNRxK+DbbzLLbr421Ndn1XKyVm45BIAKMGHRRiblKaw27kFOeOo6zAgLyDitHdk0bTJgbs8z4rJePTzK6A5IIxv8yfTSsvXmazOdxFUcpV+cVL17mturRfd+vxJlZMOEUVixxsXcTaGN9L3xiVntIyxV+RYQxNE+jdDvg2RkLmr8NNIgjwVML5GphdtmEooVsv2QAIHFTT1pWriB2otZYzsjhy04cIXsW9gmIwSsOUKd3VPxYVe57hPQU7cJppSIyBPJpVJ2Yu3vTt5Jh9ulK38r/gWzRJBuujdqoh9fGtQUJNLGT8lWrxO/gwZnAwsO1D1j1FtaNa6HVNWpIpy5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V04gzQDrOXt/6W2baqwFWUh45o7LO9Qz083Itn+KvO8=;
 b=apGT70Oj63DO/P4hpDAzZCwvvDOT0yScGLucnLqLXZzpATMvrvqGLhcOjYV5N9HRDUAece5Mqq7I2fJdMxBgJt4OxO4DU8h0wknHRrR+Z1axsRhIqrcADZplEI529v3UeeRGfcYXUBBipkti3Jxjg7v9ySYWOP/vlCmtOI9ynPNybxDySEZf1OLmTCnjLPmBmdCP8/CD8lDaWJRujTkpwiVnmMyoc2JhQd0Ca4nLUA1znBuLUk02YrzjPyCux20zZyvOyW09HbUxoo/GFa3KinSUTxxxnnZGUHQAiSr31DOGwsRl952aR6kW0KWQJFDlJyEfWp6ysED4hkWLxZNSpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V04gzQDrOXt/6W2baqwFWUh45o7LO9Qz083Itn+KvO8=;
 b=T0qR77whRBm23CQ2X2VwOFHWmynSfgIoHLiRrZUhykfnRx7WfQXSmTyy4YTqZJQKU0DDSAzItslREo+dzjrnQC2DqVoSY6R7cUgI2/i7L+Rk+uAM89uNeH54jK8GslX4QWnZHfF7stvhb5oukaTRCgR3yGNoeXooC/lOWtlTCcfobjwq8J/xg8BOI7kLHAUKGCU82e+UR5YysEPIOD4o2YJPRh+GQZDZiLLUDnMDrKcUm1sBb8tgn0ZXAvza5VJmV1MxzUs5poXJ6YzaUGByztfNzUuPxrZhYHILeJQqR8D6DkUfizyJLUqCWb+395uuKfDgRWD5Bh8RHYs53iyVsw==
Received: from BYAPR20MB2472.namprd20.prod.outlook.com (2603:10b6:a03:155::16)
 by CH0PR20MB3756.namprd20.prod.outlook.com (2603:10b6:610:dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 16:07:58 +0000
Received: from BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3]) by BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 16:07:58 +0000
From:   icenowy@outlook.com
To:     Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@sipeed.com>
Subject: [PATCH 1/2] dt-bindings: input: sun4i-lradc-keys: add R329 LRADC binding
Date:   Sat, 23 Apr 2022 00:07:43 +0800
Message-ID: <BYAPR20MB2472D625C876D97E95CB6078BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [YRzp55R6WWnYnjjt6nK56KI/0nu7kwD3]
X-ClientProxiedBy: HK2PR02CA0218.apcprd02.prod.outlook.com
 (2603:1096:201:20::30) To BYAPR20MB2472.namprd20.prod.outlook.com
 (2603:10b6:a03:155::16)
X-Microsoft-Original-Message-ID: <20220422160744.1074052-1-icenowy@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ea78f06-f8d2-4a9c-0964-08da247a445d
X-MS-TrafficTypeDiagnostic: CH0PR20MB3756:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QfMfpS8uQyGDmJTrVDdkOWCz20kY2iqkAO2T1uWHw+/0Wkw7qbqCAPqIaFEVbjJqyd3ioNNqMaavBSoIs+CzbTEGd5lZb4amUfzQ0rlbtZMXiswSJKym2BqjYjNdeaknoPqS+wcA9qNgIfErFu6homwILURIwPpfEmLwVay2DgpX5PywajL/2aR48VG4d2/F3ZUBWD08vAI7DcgiRCWksNsfxZZd4x/L4Kb+1h4Ugugax5V046iEFXDcixhndD288VxUCg6JnUeyJWleD0BC/iZCGw1n57WTs0NOSZBHxTRQBtZ9ZWjRwDZrhKdiD28eQ0oAF2c4KsSRT5viZX/CQAIpLWhz/pf0ji+WN9KKxgAICaxgXpyoOjS5miDpGTzWvfz8XU3YOD3dHXdvPKoWtpExFud5eqPZfFgUiudhDNQ7oVhuaJy8IfrTPq8KbDLC9aYvpgud/+4R7qbyMDv8ItBTjoL0ZpqSvCeZp/LPmWHk01TVl/hRWUCNsQkqxv/TDcg3NQawO5tC/9PwehsvbZFfdiwoPpeM9zRl4FD7iVREYrTmsxrPR6Guu9Sdv8Jto7SRoEMlHozq1fDY5oxblw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AvLawIlx0nJKpeXdoMFmt3JDqlLQMhRWZAklaM1x1jwfiC868caKljw4x3yt?=
 =?us-ascii?Q?Ih9fml54s7aHFoVHc/NjybYT/wHxRrlhYmqUEtVJSkqfNjmCQ9U9RcpX+SkQ?=
 =?us-ascii?Q?HQgDEvL0Na1EvRcG0VMdJ93qgipKGZm1Qi9bzc8uPy8AKoJmeUO8aXbHg5F4?=
 =?us-ascii?Q?wdzgP0QDcTosnQzpYqTES7h7NQyC4zQZ/ZbdOT+ROA1t70BIYHoBZe8acRWw?=
 =?us-ascii?Q?4ekFoVicXTHGmSFAPGscieqWmlmTyanCil0geBydYsia3/7aUvy2xEPQ7zR6?=
 =?us-ascii?Q?a0YAylFA/xWRB/jMlsVzWawPePQOOzkMu1BF68sBnIs/Ze2U2adrhm/iCAUL?=
 =?us-ascii?Q?XQg3WTI7jw8owiyFkh/1xwqveXFClHP2OnSFa71EM5fOp06nI8fU3Sr/E37w?=
 =?us-ascii?Q?kh2+3xN+vM8z2Ck/iRPlI0fHPhE9h9UPkP5YHeQVRqHIBMjJydi05tqdvyun?=
 =?us-ascii?Q?JMlI2tQgM2NY9P+8gDhlsQx3MPV2Uli8jB+oRIvlPxw6jFlXiuV84FpaxCVD?=
 =?us-ascii?Q?T2JtqiLhC5USujC3cSV8Xy9c5HOFZUZyxlvISxpZxMkemg8NrJVKg25naKGT?=
 =?us-ascii?Q?GlbNTp10TTRvtdcVCw2M7WAxO+YglyEzbr75rZAno7BCzZUdSUysVne0ekYA?=
 =?us-ascii?Q?buK6TIG6UIV44kiRJ5q46C3l4YQcwLFco01WyO+WG6VQ8ntmt8CbyKLCbaGW?=
 =?us-ascii?Q?Lb09i+BTQW5Nv2lyUPSLpSnww70XaTEFBPSBhohdaOLoWmLlITPpgyZOf/77?=
 =?us-ascii?Q?QCyqXToFJaCTXiBKFb6qKAzVv7RNMYzijS7/hpFNBvM/fTiB0tJQhF/39KJx?=
 =?us-ascii?Q?HQwi1glyUlYDcbe+UtPI+mUaUzpkfbCeJzEhriUKiGod4VH6SvRZqVTQrZu8?=
 =?us-ascii?Q?iRXnbvQ3fIr7HN00bnBYKEoYuKvOrh1ip04+DBbe9VNstXKhr7TaqVj/m/b8?=
 =?us-ascii?Q?n4HDm8UCZZG12rRIgxTd5E/UmbKi9egVekM+KEqzY+FQdLd7OprQYSkkQGm8?=
 =?us-ascii?Q?FBfejb6a27P6IoHWQyZguEFQ3i9so7sq6jaPxwGqZ4nHoRAgaBs+dPw+lyrE?=
 =?us-ascii?Q?yTQBEZaoRBn3D8AQW5HAVBx9e54Bt6QL57mDaapx59mplNgw0BrvtFVXLk9f?=
 =?us-ascii?Q?Z4E9rkprK7PqNN5tn9Z2Cx9hOZjPywJu3Ed5n9QU3e9g1dHkZXOa7uIY+UCE?=
 =?us-ascii?Q?XDCZZG95UjBj8/o2Dkgy5oXfjyheYSEH8cQKpN5zmeQnrTSySeHMJh8yebwK?=
 =?us-ascii?Q?w8RyvB7JgjeFbxr4wnBVBaFeFHdDQStSRuz3ByeML5cqw4W6jVVnijXPVWrl?=
 =?us-ascii?Q?1whSAc11TzqArmjnBrwjqKU9ixBOi4DHO4M4SwcoxRsvkh/msgv+wIWRXLMu?=
 =?us-ascii?Q?3G4CQKDqRp/RVqbei4s+Ciz4yV9UvcqUoga3f2ImMTnFBwKqJ4x5UFD3M5TG?=
 =?us-ascii?Q?R1N+7WrT3f0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea78f06-f8d2-4a9c-0964-08da247a445d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2472.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 16:07:58.0560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR20MB3756
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@sipeed.com>

R329 has similar LRADC with previous Allwinner SoCs, but with bus clock
and reset.

Add binding for it.

Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
---
 .../input/allwinner,sun4i-a10-lradc-keys.yaml | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml b/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
index d74f2002409e..e16f01510ea7 100644
--- a/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
+++ b/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
@@ -15,6 +15,7 @@ properties:
     oneOf:
       - const: allwinner,sun4i-a10-lradc-keys
       - const: allwinner,sun8i-a83t-r-lradc
+      - const: allwinner,sun50i-r329-lradc
       - items:
           - const: allwinner,sun50i-a64-lradc
           - const: allwinner,sun8i-a83t-r-lradc
@@ -31,6 +32,26 @@ properties:
 
   wakeup-source: true
 
+if:
+  properties:
+    compatible:
+      const: allwinner,sun50i-r329-lradc
+then:
+  properties:
+    clocks:
+      description:
+        Bus clock gate for LRADC.
+      maxItems: 1
+
+    resets:
+      description:
+        Bus reset for LRADC.
+      maxItems: 1
+
+    required:
+      - clocks
+      - resets
+
 patternProperties:
   "^button-[0-9]+$":
     type: object
-- 
2.35.1

