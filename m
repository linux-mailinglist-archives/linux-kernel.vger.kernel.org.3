Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A624F57B651
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbiGTM1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236175AbiGTM1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:27:35 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2098.outbound.protection.outlook.com [40.92.99.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A56864E03
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:27:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=It0STRUZJlcsM1VBc9vg9q8J6jc38qwVK4MVFInl0VJGN/benoxxSXKDdPAvwM2oX/Lo8be5TT0J+hL5TpWs75r5nwb+JgwyIfn+2jWRFTOy47BynPE924aghBkyMUyBHexoClAW77M+pgNInPaI//hIFIa/d/I693r5b+JqLM6yl/6EKfu9Ff+2v+V91ISghNETzzewQI9Mlm7eoXVe+9qzJgOW6PnXBEyv8jqWApa/xppdu/Zfib5IDU+ps4nSCnyCG1Yd3z4f30gtyZAZCORrqzSwPIFh7rHWqNuabhCTM2rOTNYd/2z7bMLlckjDDRTDTz44XpGDkIFdoivfmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Mv7Zf6ypSVimOoStCXP/zJn5vM7OC5ap10+PrT3Ib4=;
 b=gkHavO+BtQfW23frSaBLpv+BSOs2/GYXJ8WXSqsxna2yF22pRqUTm7dtNOu5DlMHlN8a5EYYaP6VN4ryCcGI3dcjb9iXl3tcZOZQTuY8eBfwf+o10iy2hxo2VHUZS5FG/UdOFWcdvtjdbhopYGf8btkevKoZPdeuRNTiNTM9Gzc3gaptFnPpJM4E8tcdo6aJin2HEcBDNl1M/3f7Aqo1m1oKqptEqylrJR/peCoCkgTVsO2jXolBJg7CpVr//qS7XY62K+DgrK8Yl1BScG5eOTEBlcjFDc3/6aTpT7E+BvpFwVO2jUtsFFrp5j5WEScR5NdXT9sgXOTOkSmJs0G7/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Mv7Zf6ypSVimOoStCXP/zJn5vM7OC5ap10+PrT3Ib4=;
 b=MQO4NoLKtKSQ96qMS1YQJTvrqjP8YKH05ii3ph69a2oUgfHvPLa2IO3lQuZfZDZ1oRkNHhKI9zP0QURo0H8xI5xBTwyuUF5rLY7wKIovjjxU5uA1YAu44L70C38iYEq4QwcuL+YwhmD35uKMW4qp7j9rBrAY1ZxMxG0SVuoG5fpSjYroidkT/gIJApQmtSMwBDOJu5+LX9x3RKxXCZZuyv0maGmcLTbco2anR3Jvcd639ZVmXtxOZ3+2rUwFdKVehcF5uirESPv+RgAQQapV5TQmE8YG4pK8+Z8eqX60xbX4XjQbsWUS2rK863RXdNRZ1hhB/VSYCu+6ZrMBRpo+3Q==
Received: from TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:ff::9) by
 TY3P286MB2818.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:253::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.15; Wed, 20 Jul 2022 12:27:25 +0000
Received: from TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2143:ec0d:667b:2175]) by TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2143:ec0d:667b:2175%7]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 12:27:25 +0000
From:   pngliu@hotmail.com
To:     jan.kiszka@siemens.com, kbingham@kernel.org
Cc:     linux-kernel@vger.kernel.org, Peng Liu <liupeng17@lenovo.com>
Subject: [PATCH 3/3] scripts/gdb: fix lx-timerlist for HRTIMER_MAX_CLOCK_BASES printing
Date:   Wed, 20 Jul 2022 20:27:11 +0800
Message-ID: <TYYP286MB17639886A7064A1E610FB2E3C68E9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220720122711.6174-1-pngliu@hotmail.com>
References: <20220720122711.6174-1-pngliu@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [XtYvLIBuaZPzJoVGBE0QhpMhtMtL89B0Vi0Wcbku7NQgJwLkCJRzz8BMXVD7iJbI]
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:ff::9)
X-Microsoft-Original-Message-ID: <20220720122711.6174-3-pngliu@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b55b0eff-b930-4a0a-740b-08da6a4b33e3
X-MS-TrafficTypeDiagnostic: TY3P286MB2818:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qtJUQ5an9yGr0zUABnU9U28zaYz2PJ9mUGGoKWZZ5AAb5+MoAdTeurQ4LH6c9bqAQg9rPBxvVoBD9syN4pwCc7yIssGbmwq1/dS6fLi+xroE/qDVETglLMK3YyfKfakaHuVym3psAPsIq18FaEG7plfK5f03cXSvLFsrMlogoIYlw7lYNndyaxo4Y/+0wT8l8sampimjvUzy29V/OgLoI9gYIiy2fNcv2C5ZYWa3Q4LrU1HxK1iSFENK6TjS/hh/NrUM/Zy/d1oAyVOxgcbQTuAM00d9+PWopgDUW3T6IbbKMwQDHmfmAQ+jtvvHzoB3TFmRZpX7tQoHI/rhE8RIdYDiH+WWAkfKWextoHT3LkiVlWaNNmiu/ds7j/p0crwiHBdFZDpIqJDYgOgTYJvA2yZnjM8s7th8EAhrOJwDVh7soNQ8QxWmSGqgDZ2e6RhY2Chv0dxHU5/mZRF0lVf5f2+cEgpPVPoUkFPw+FWGxM0KH6/Hf25QgjITx1LGC1NsXTGzcjI74g5ufbnr4yLM6BNXgDLmPbqtho+703Ssz2xGtYMBp7En78go+HYqqmMdD50qWkklkPgnHK3dRq5nYVGHsVYiVmrZ7BiSHBFjOe7hwrDUsSARUtqbrkTH8Y93tGvqQg96ymyea6E5Esq5mQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ij9l7CRCPsIILFUkHosaVVPE8MN9LfsbBPp4yB7D8uqgx9752ZKroLFjUYoY?=
 =?us-ascii?Q?sud8zhucVv0tvGGsN5O/FIZ+GKhSD5MstJwJSaMS3QOc9nQBvS5psu9+0qrw?=
 =?us-ascii?Q?Uh0L1egmiFvOb98SIpKOjCFCfUJcV+smMh8XpHc+K2tTRlauv/Re8nNOVozE?=
 =?us-ascii?Q?88eXHSsxbD/K4mEOHdaMRo15jYEHGuVVlUap/FHNax9rktfXZ78rA3/DC8yq?=
 =?us-ascii?Q?gR0iFV+Chz450sYMELSc5hJ7fKEo+/sFPIGqkmg4vomHQQeNLI6A9H3D86VZ?=
 =?us-ascii?Q?SiwADsJFSyTM8E0aDWZFq/ozX9D+bT4YaT0SfGBIKj7zTahfC3iZB2zlsqjy?=
 =?us-ascii?Q?BmF//i8Dcwo6hDWqp0h3OxrfkTPUsp/ottQJVpuIucagI61gEFZ9DTBcO9s5?=
 =?us-ascii?Q?575mVBwk/uEnvbYodfPr1GYGPh5QR1ZB5AhD97Dx8e3nRQWVhbWeS7xVuxWT?=
 =?us-ascii?Q?hWbptRcm5AxVzu8HZQGZXMld5+HuV1jeCxKmEFpVXn/Izg5FWjGazk755UV5?=
 =?us-ascii?Q?YxJZVWH/oUHTwpd44rSUOLryPbL4nrLQdM4kjixCOmL7sMJooCVsmhHYpSvB?=
 =?us-ascii?Q?T77z5SkbzZDFoxs0FG9NF/10nVX7AwQg7mqqTx7J3OXWnh89atqYAbiSYgLx?=
 =?us-ascii?Q?aABisRODK3vQbBfwnEGa+rslbd7kyus13mOULAvmJIRml7zNxqUQVUB497xO?=
 =?us-ascii?Q?hPOazogerMvXsm64PS5Vt3F2U5jn3/mBehFRog+OVmzMsxxXnyThRhcXLOEA?=
 =?us-ascii?Q?QDeB12brpXBrSznjLWqYw2miOltq2/lcIEFL3bbBGUARD3rvv6E3O4BmQiKV?=
 =?us-ascii?Q?bkHGof0e0lLpiU3gzctMBaIDV03/FeYD0HCIG4EnSaGsx7q0xIHPOITwego3?=
 =?us-ascii?Q?vlXAqUGMZkQgopp3PdflPITLcWKTU9CJwln3mQ3RATmOpY4If57UZLcukAQ8?=
 =?us-ascii?Q?dJShT+N+H0pp7kbxr/uHQuweg/IF+qilZNjsNAN57WdjQqNi4APJq59ZHiZM?=
 =?us-ascii?Q?1E9Q1tgQqU9WI4C2tCtuyMtLTGis6xMsGD0Kqr0W4dsM/2WPNsT0Xxm6L3rg?=
 =?us-ascii?Q?3Lf57/RG0eqy7FOWyDjBU6o/BQlmdyQOzS4QZ+gWkZ687gS98f8Sp82ORURZ?=
 =?us-ascii?Q?5Kv8+Mwi54VUp2Da2pHDxn47pkgn85MNCG4aiRzBLDCOi/nkrNT91b4//Q5V?=
 =?us-ascii?Q?no9U4UMbhxpun895x0BKFkcVXrsYOQ2QwVc744nCXHLGJkybclBl7koWOhDB?=
 =?us-ascii?Q?Ij9gc14Y6d0hRKsZ07xjxDOPDGLsoSS8GqMjWz0/wCRXYE56LeMMfI3ds9NG?=
 =?us-ascii?Q?BDUpXqfVl3jDMrv/d9KEkj3YZd5ihYVYiQVfseteJkfBHA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b55b0eff-b930-4a0a-740b-08da6a4b33e3
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 12:27:25.4637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2818
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Liu <liupeng17@lenovo.com>

HRTIMER_MAX_CLOCK_BASES is of enum type hrtimer_base_type. To print
it as an integer, HRTIMER_MAX_CLOCK_BASES should be converted first.

Signed-off-by: Peng Liu <liupeng17@lenovo.com>
---
 scripts/gdb/linux/timerlist.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
index 8281da068c5b..249f0e804b24 100644
--- a/scripts/gdb/linux/timerlist.py
+++ b/scripts/gdb/linux/timerlist.py
@@ -188,7 +188,8 @@ class LxTimerList(gdb.Command):
         max_clock_bases = gdb.parse_and_eval("HRTIMER_MAX_CLOCK_BASES")
 
         text = "Timer List Version: gdb scripts\n"
-        text += "HRTIMER_MAX_CLOCK_BASES: {}\n".format(max_clock_bases)
+        text += "HRTIMER_MAX_CLOCK_BASES: {}\n".format(
+            max_clock_bases.type.fields()[max_clock_bases].enumval)
         text += "now at {} nsecs\n".format(ktime_get())
 
         for cpu in cpus.each_online_cpu():
-- 
2.25.1

