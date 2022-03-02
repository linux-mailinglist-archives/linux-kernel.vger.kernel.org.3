Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904EC4CA4FC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241831AbiCBMmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbiCBMmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:42:10 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2123.outbound.protection.outlook.com [40.107.255.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C976FA1A;
        Wed,  2 Mar 2022 04:41:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQznTGpuGhz+Q4yUz//PttpvQdpqV2xPBBrkPziUytH/7Ctbk0/miDOH5jxYPsqlmFFjMeLMulE+osJP8/pUGysvmDxw+2gfMB+N3DDcp1N/12i0IPBkFjVrzRqfwf45zhJp8RIQScwmfbhODLN+H7W9U96nGR0NfpWTRwc9xsbtMZr2tgj1XuTeIFQMnrlrFT6A8jwZ2X4oDZQ57A1yp0la43ga1q3so+tn8KliS0E/XX8+J5GYwTZmtEnBetLyI66qUQcRjfJ8MIwOgX+SfGiXsDGQIupCJgQ2oMT1Avo0l5NaoS/GATGYJbYaBnnh/602Zp3yNd45hH6E2XoNdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCIKWgRCBDViKQfCQs4txzxtTDFI+UnXh8pfI8M08sg=;
 b=S+9HwPpDare994gj5RETqAdW52tVcaf9c+86CnQnnot7nrET3rl0l0DNjxC0Xg3NN0QkCDTspe01aLVi36rgHE/qSYPTj1dfTRDK46lQlWy7rX1BQKk6ju49V1QCiHNOQBXybUSs8/KwntzCrsm+bkXRRrqx14TUWoIfv4W1Tiw7CuOhZh1HhkfLkRiJc73Lp9firxMXNco74azoBBJkoQ5GBebOARm4rM7yexZJ8Ul9nuRbZcV9eFptC3uwyUCarZ3S+Yrvwq4IYHkeKzvJGMzjXxz+fwyoiaXhQfCwdqpm9O/Q5asiuwZPxAWwvWWQZPXbG3WnPR6CzS8FcFGaVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCIKWgRCBDViKQfCQs4txzxtTDFI+UnXh8pfI8M08sg=;
 b=NA6b9Up8v+xaYLhLmTzZUZWRL2owJuHJ9Tjzwi7FK1lqGIFdkzmbyAQF0GaIqJhe/lK98VaMl5wTTE9v+3354PQxIrDsPCaREuLmboqWcwQEIgaxfk0jqvwsXZwrGXZxWy/ITK6MV6w5XzOnsOUQOySSsG7ncSzNAHbrI9hg2k4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by HK0PR04MB2689.apcprd04.prod.outlook.com (2603:1096:203:60::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Wed, 2 Mar
 2022 12:41:22 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab%3]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 12:41:22 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v6 0/2] hwmon: (adm1275) Add sample averaging binding support
Date:   Wed,  2 Mar 2022 20:38:15 +0800
Message-Id: <20220302123817.27025-1-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0146.apcprd02.prod.outlook.com
 (2603:1096:202:16::30) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30fbf095-ce05-45d5-501e-08d9fc49f4f1
X-MS-TrafficTypeDiagnostic: HK0PR04MB2689:EE_
X-Microsoft-Antispam-PRVS: <HK0PR04MB26895EA8EA788FC412AE57248E039@HK0PR04MB2689.apcprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ySJGTyw9MrwRp8Vhmk3iQErJgH3stSVGITmjzXq46QjMDrZfYk0ruHYGjrzGZXNcInQ7+DQ+2UXV/LzOMjCS1YzyzdIQO9DLgm65pof4ZMcFQxa+8LRYPIPPfML8MFzPRGKpc/fXm1my/3UAAm9lWsJaq7xPnRqe/RIVvmabtdcF95+UEzCMW5hcPTae2J089q/xJhEuAZdQdjTsGRyf58yRg4fDqS5jFF+k9mbTErUM+6DVMi6gZoUFC5cA8vvB3t+Fd65dItABDb5RY3k8QMZX1SXyX1qA24ZElzAT8ZKHpDR8xNsi+YiISYw0gjodethIBK/hJX7b/z/JOnOKZxffNuxKjah2UYJ3TaEd2bdAUGNUConp14dek3iFuWMCEmPS4C2GxS4EZc/geicF3SLKMIx9ssRh544m/16wJV/1ysM4+jn9cxI1+/RYJPOVega9eg+XvmsfAHUP/jWvdYvCRpXQOHfqXaBbCvk7okiVpeMd5NHBmikubywX+s0n9hhJbtwCoVNiOXqc4lqOAxTV48IeV72bB35mdvIEh8OBQjZ/aRq+gzuonuF9bqFRNOzFlo46B1sjsCBCorIDjsOJI5cUqAOkHNsRini78bYtBk5/PYdUr5bIe3K8fQkOnTveVVrH38xwimaTq7FZyTsrgLsNwOkxDaLztn5v5Pvg9/9bQZdLn6DnWW7DlNR545WFUkMWGLkUzsNUwq5GqX1EqiqfIIDgz8aK3nJw4ckvlkK+LqQcSMo62JhmGt/jckLzX0pJax+nPVyw3L2guBiTsLj+nwQlUMNMxp7EvL5ZLC6OszmqqQbf8keS3VzaTxw6ki1xwfmp4yi6wP/LgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(966005)(110136005)(44832011)(36756003)(6486002)(66946007)(6512007)(186003)(2616005)(86362001)(1076003)(26005)(6506007)(66476007)(2906002)(66556008)(316002)(5660300002)(54906003)(52116002)(6666004)(38350700002)(107886003)(38100700002)(8676002)(4326008)(83380400001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wh8YtHUhNOfXomMgIoxVb60TQ/JYVvumsmJ3+SPtjC5gHAVNrF4E5w7qLUHy?=
 =?us-ascii?Q?QxrDi6n67HdQtKeAQZ39c4KmSdnoR4IcwkZ0Df8Q8Xd6vafN4BA1mORev15R?=
 =?us-ascii?Q?U4NpKbqGJt15naPDdl/9q0gTpikvt8+pjBxDyVCw1CTs7iX+KsPz7jNFqjYH?=
 =?us-ascii?Q?yigBFsCfUbIITu4tXnAZTbkUko12lSQdBhKW2Afv7NbdPIW+wLpwI+9tx9+f?=
 =?us-ascii?Q?mG/NU14IxzV2ghpupFNlJTHnVEC3fE/+2K5pGL5ZYxxtXXoDI6fgWP8wzt1c?=
 =?us-ascii?Q?vAILZIHQhjD2XzFMbl6iZMcZD2XRkn1KhKF8Zz/8lPJpZjo31VIByBvUNzsf?=
 =?us-ascii?Q?lJ8QCuliGI5csvmPOFt1lGBk7yFsUKhci0tlJsSIM0vAfO8nFUlSprt7frx5?=
 =?us-ascii?Q?FqQuB3jPalUBEjN5t9aTSSP7YjQ4GfWt2lmsh7usuwTBz/erzqglFXd6SRoF?=
 =?us-ascii?Q?d323vpDSwHzbh58nVKFX3oqlpvNRdkw89az+ZO84AJ6C4IQ6wdUPzpTmGLD1?=
 =?us-ascii?Q?Tqqagmff7fRvyzX1TXwOuoOGCT2JeSjs0GqFejBJk3nqNzYsBqTVgiNaxV2i?=
 =?us-ascii?Q?72KxbyKHTJ60gedcv01Ne5RrWzL9hk2HUi382I1KNPxva3M7W8geJigwWCee?=
 =?us-ascii?Q?ln9gBHXagFLxGTO//JPmUVdbKs060QMQfJdMxxR9dG0RbDe46jEC6OgggQBS?=
 =?us-ascii?Q?/4XSEX6/aJ8SQ+jYKF51KcmW2J+dS8hTisFXmcrUiv4g8X+LpbZScAolwpzF?=
 =?us-ascii?Q?4oDPEVSqcOLSes0EhQS9KlahgxN01Im2j+/A36/Gf995hD3VS4Iv7AHUrvah?=
 =?us-ascii?Q?qspgLQHotQy0efgBiTVRQq6FXk90M1ntFSWZEe4ewsy5NfTHuzRwvqh5Rztg?=
 =?us-ascii?Q?udCZScFYPGF+zv3Hvrhe3lmgeJnxBOpnXj3YQO0VXyJtVjpr4XelaQu7xpPl?=
 =?us-ascii?Q?q2gHTlaBc5HPMIuiviQPgv2K45HCFO3bfRo+k+qVUyL9BNhew/IxGJVC2Ljl?=
 =?us-ascii?Q?wuptfByOeue+onxRkfp592ifwOYBXsoNOTwsd8jFK/x/bmkNAPbplN8igaAe?=
 =?us-ascii?Q?wghf3tUG0sV83IcQ6z4N02u0WK1Jk448uU7m2vJk9WHtlxfCvenImFHhcREj?=
 =?us-ascii?Q?OrpPMeuYRxQ6TDLC0/8EZODAuaLdQpljIeDWis1arTJn/011XAPdOVXK8Dep?=
 =?us-ascii?Q?4W6iq3YKpEqJJJBEmOibBFuZsNoCFgQ6MPmOCZBYI7l/dtC/sZcFZO8csY4d?=
 =?us-ascii?Q?ycu/h2BnOKQZmvVU9BnnNvy1cIEYvNE+6jrEJ8LaH/WBQLNtlGprqApgjA9M?=
 =?us-ascii?Q?9tOccF491tq/Z00q9H8HPzD2P7RqBp288V3/ujgTBzuhEz9PmTC+nzFe57b8?=
 =?us-ascii?Q?+TNXlMFhI+WZ1oDcGvid8gvEb3I24GVYJVIn50TC357o51SlqORGslZVDr0t?=
 =?us-ascii?Q?AsiTBZtQXSmI9SYW8nFULRKZBycjMAEZiey51BJjheweZWZrSBevADxgRQ69?=
 =?us-ascii?Q?E7kGAKVWc/3c+qFvnxot4IAI+QnQH12sOydCbU+Lp7M4U964Q0xWhAYqi8WX?=
 =?us-ascii?Q?8hzI4VSF/H5oBTCpqnYgU8zE/reEHqBc4HC+VnP0V0wTCMQLCPwD5ua4EegL?=
 =?us-ascii?Q?qPL9iBdiN8XtVQoI98XX98U=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fbf095-ce05-45d5-501e-08d9fc49f4f1
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 12:41:22.5184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6awti+b0E1KqcP0AhofhZZ4oQ0DyDAo0/qNMzuSsQahoG+kJXSCd7I5IQvhjMkl0z2PNE5TWwnVhmJJLupQZBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2689
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series allow user config PWR_AVG and VI_AVG in PMON_CONF
register by adding properties in device tree.

Example:
	adm1278@11 {
		compatible = "adi,adm1278";
		......
		adi,volt-curr-sample-average = <128>;
		adi,power-sample-average = <128>;
	};

LINK: [v1] https://lore.kernel.org/all/20220223163817.30583-1-potin.lai@quantatw.com/
LINK: [v2] https://lore.kernel.org/all/20220224154329.9755-1-potin.lai@quantatw.com/
LINK: [v3] https://lore.kernel.org/all/20220228103716.10774-1-potin.lai@quantatw.com/
LINK: [v4] https://lore.kernel.org/all/20220301103900.12637-1-potin.lai@quantatw.com/
LINK: [v5] https://lore.kernel.org/all/20220302070831.23822-1-potin.lai@quantatw.com/

Changes v5 --> v6:
- update and fix the yaml file error reported form bt_binding_check

Changes v4 --> v5:
- remove "adi,power-sample-average-enable" property, just set number of
  sampling to 1 as disabling sample averaging, and set 2 .. 128 as 
  enabling.
- update correct default value (from datasheet) in if-block of each chip,
  and set "adi,power-sample-average" to false if not allowed.
- change adm1278 pmon_config smbus write "byte" to "word" in probe,
  adm1278 pmon_config register has 2 bytes data length.

Changes v3 --> v4:
- add "adi,power-sample-average-enable" property
- add sample number cehcking in driver, only allow listed value
- remove info logging, add error log when invalid number detected

Changes v2 --> v3:
- change property type back to u32, use logical value instead of register
  value
- fix typo in properties description
- add if-block to descript "adi,power-sample-average" not alloed if
  compatible not in the enum list

Changes v1 --> v2:
- use more descriptive property name
- change property type from u32 to u8 
- add property value check, valid range between 1 and 7

Potin Lai (2):
  hwmon: (adm1275) Allow setting sample averaging
  dt-bindings: hwmon: Add sample averaging properties for ADM1275

 .../bindings/hwmon/adi,adm1275.yaml           | 68 +++++++++++++++++++
 drivers/hwmon/pmbus/adm1275.c                 | 40 ++++++++++-
 2 files changed, 107 insertions(+), 1 deletion(-)

-- 
2.17.1

