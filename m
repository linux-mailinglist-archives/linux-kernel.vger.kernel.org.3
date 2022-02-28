Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7534C672B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbiB1KiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiB1KiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:38:20 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2112.outbound.protection.outlook.com [40.107.255.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B42B2E099;
        Mon, 28 Feb 2022 02:37:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cagVLRVeXMw/AhWBrPZ1GX6ic5J29yf3NM57oHM6aLlqhSh9mXZaVYl1sC510/GTNh6Bkbtr/6bXnJKSWbBu1jiznDGHmyl0jP9LpMrzSKIXo3buPOu3HDTg84KQKA8IFTII0GndCKDc6li94q6/t5CKaIzlWrEws4Sb0KBvPtSufLOEqzcnHqKBNZ1+OVyJwectxqhLEepBf8isF6xfiKqX9KZYPEfMO7VXQFqM3g/YCYBaS4H+V6ogpmG7Ygzk9l8jn0mGGVWT1FZz3uW0QR6U9kXjswr50wEjr+WoFJ3sHxthSZLEnNPLzMaUP6AH3mfYDYxRsmuYe6SxKYpULg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCZI0v9jl9jFvLfhLftBhwwkTk+cc0vuC2t38F0OEqY=;
 b=IKxuchAr3NQyxEoa7skZDgurdRnOBSEnt5eo8J1Q4jmviqFE4bDw/XVVowEKjlwnA21QZh+o+a8P3Rus0DWNSbmRxPvzzvlIB6ULhDDGFFdyXnrYXJjiBl4N9MFdzizX9Lw4GozEe+ynUH5uDjzbTX5WdJ/l08rGi/772g0VmQ9ww3HjC1G8y/9z6T9X1SlBY/taAXbTeKABVhJ5jRzLsxgg01nsxrnTheRNoUlT0ht655Ux+ujmI9UBo1vvGH4LO8XO1V7bb+SG1lg55B5cS82RkJEyWRx5EvBLkujeDya7NOJyz5npgqQEM9Bv4Zx8y4J6JeARq0nVA+rpKnJ0Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCZI0v9jl9jFvLfhLftBhwwkTk+cc0vuC2t38F0OEqY=;
 b=iF0Db9vBWrOlvc2pR+q2C8iKfCFwvQxowT/D9Dd3Dp8gfG0CxxLBEJKTHFPFSCmeJVOazjq1EcRktzTG3ITh4GDlMYT7F5VkQSFXbYKoC8DOZNVbaFi3l1TR2DJDv+evyWLPZa5mySNEdNg+BYWvLfvj5lRfwkndB2v3IFk9w2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SL2PR04MB3002.apcprd04.prod.outlook.com (2603:1096:100:3b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 10:37:36 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab%3]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 10:37:36 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v3 0/2] hwmon: (adm1275) Add sample averaging binding support
Date:   Mon, 28 Feb 2022 18:37:14 +0800
Message-Id: <20220228103716.10774-1-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:202:16::15) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97d5f75a-54aa-4701-7e31-08d9faa65591
X-MS-TrafficTypeDiagnostic: SL2PR04MB3002:EE_
X-Microsoft-Antispam-PRVS: <SL2PR04MB30023187316876B5E9E3609E8E019@SL2PR04MB3002.apcprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NoD7i9Q3YQBW20n6ko1U6ypgIOFgn3g56UASqKY3ds2iJXhl+wtXMzNUOfeUoQxO175qqG21P1aoZB9EODdnJdFfxkmaozuBT8VSkYcbmy7kZek1lKlpqm+U63HKQh0b/P2QRTyR46bFUP3fZv+LxAZqWRoeRu+O06s5KFDORLEVokULMzCO1lhJ3ruMBcj/x3ZwFTS+mGr3cHj+H7hLhzOQkfwb9bwmGaGI6GlUXWHTPBGzlLt+bYrGKuD6K4RYkuyYci6ttatkq2rBIVKPwAw4ujG5Gpb4k1RVd190iJCSlqoCA4rp6PJw8kR2PyZNjwFxG/ezaOLfEAZWNAdCu8C/B4WN7BIi3lW6TXNtrZq4ZQ5yl0umEeInpXtGT0iTV3DcvfZrkFqoOJI52leDZSqc+xC1obBQyUYKGmuY84ZTLje2MINo7zDUNPiq9iZW+KtgnlK228qOhhJ/z9vIFJgc5oQmp3WvM2X4qJSoBfazwtEfNlYGIQKBwMAQoSNQeVEi6O9Vn3j1uFNZ00bgmK2ld+UU91MTuemQdVFCTWhbF/cxiVAScINYf5YuLVBnVnuO3Cbm5wooc2PaBP55HX2QrTPE3CfuK5nawdn9ka5uWsKj+GLziyCVMBURC28E8+j69bZiV6qroEbI3txEzLlrHcT7vqZfvf4OeG9qQNrqDTg9Qt8xKXULy5gjQ/1phVDuMcRkOlk+SeTFZZy4yAEZTCGgQUTJPlj1iWtGp+ySB2nkYCHVsXtZuStilsSfxn3J980gmEhaN2YZfGcheSxWiZIb36/y1eDGZw7wN4/mqFnsXMUkbVkmHzD1GMpcRfuEJhPEcpQhm+RrDAermw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(86362001)(83380400001)(316002)(36756003)(4326008)(54906003)(66476007)(66556008)(66946007)(110136005)(5660300002)(6512007)(6506007)(6666004)(52116002)(8936002)(508600001)(44832011)(966005)(107886003)(2906002)(26005)(186003)(1076003)(2616005)(6486002)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UZ1lCh9Mls9jgAcBGTX0U6ehvKdWERgAuya+paSNrKKfPNH/M5DlHL9nuPPu?=
 =?us-ascii?Q?X2fYBC/2icOR4IauDkp9RprMB7x4KfgD0vfrIjfFAxU+dMN3LUlo3yXg0aw0?=
 =?us-ascii?Q?TpgVvEElOeoLQP8cIHmWWRxRSc4iEVuZtp7sygnlao0quMn9MaFNqkKWTsSZ?=
 =?us-ascii?Q?ndEQlarGG44fQRZg64ziwJlD1xs59TyjFkqusQwPbARg6v1wM7wEmFxBiWIg?=
 =?us-ascii?Q?p3grUwM6uR4pVajusLSIAJEYrNdUiJ9KoXakzn1ErudTyTFQiYGgvhMaTyNo?=
 =?us-ascii?Q?DEqrM+E65ZvjqknrcIf8yGCSVvWx3vRsxtWdswLRaf2icv+2z4V0ejBlYYNj?=
 =?us-ascii?Q?AadyrusFGaax0cpUrhNVeFBnLU+WIOg0MkJHAJ3D1vDo0Ku0YBEu6RORYWoy?=
 =?us-ascii?Q?uz07MOkl4PhMawZxv2Kiz7UXzCvBKXO7KrjvTCKG/w1IKoN6WblCgdsnkNve?=
 =?us-ascii?Q?ycGb7Ij9r+aa+J0Rwvq+H2u1VxJXsSyh3Kxc9KwSjCyS9l5sPSV4LobcRSCL?=
 =?us-ascii?Q?HW/04yd21bY3BZGazGpf1RQfi5n7BNS3qN4sW0vca/UFSyUzlZ7Yohu3XK2B?=
 =?us-ascii?Q?AQ8qwirK4f8kBHFlXzEWoxeoxM+Y9WROb15OsTzpAAvoEfS3uGwTEoakN6+V?=
 =?us-ascii?Q?hi4pUuA0ucKMK3hfQ5GlN6WX5ye7VHPNIAo16EiQcKLDuj1LdEbHhlU6qGRE?=
 =?us-ascii?Q?dkinMnsh4DjCh4y42+ZLZNUUtI4ptuOpiOmIflmkEMHcmekD4tRmRY7+fkTU?=
 =?us-ascii?Q?WULgOYJFtKtGWjPQjITUATAepuVvbTyy9NmgvHbR4i1tisrJoNp/WJEPxY70?=
 =?us-ascii?Q?5xZWq5pLe7vivS9lOol3rWSFftWGNkhtdVyqaSSDv463i1IZ98raMU5vhGvq?=
 =?us-ascii?Q?yEazsKL03u8HPvuj4ulhoWXIVsrFS3F3SaIsvvexmsZb3nChU5cMu3hGG3PI?=
 =?us-ascii?Q?VWQErMg+B86ayYuTJ5OiTbbsgNvJKnjrnw+vQ7dpqvyFtyB+O2mv2gmFQ2za?=
 =?us-ascii?Q?qnbMfKDVaG0CCRh9CYPG3+g4vL05zq/7OWG3RhsPbokJaIqPtYzEVQk+Uxqb?=
 =?us-ascii?Q?tavphdAjUL4gNwgnmNySEdoFvir9njbB0y4QlvnBshVkQ3ahxcaTwiJ5CRe0?=
 =?us-ascii?Q?dbpljZ02A8RoXaMvGIuNftrCcq5MNfud1BI6p0RiY/ml8pDxWfOI039QWK8K?=
 =?us-ascii?Q?ue2BhiHsfWdoDr39YlGhoX9lzrL1tRVdJzihkkkko93AbxR1UPUe8ubjxU7b?=
 =?us-ascii?Q?d//4ZETs47bgPNkTTeyq9kCCaMRTNTvWD86CAMj+ZFN+a0Bvw+SJoyPuH1eo?=
 =?us-ascii?Q?Cx5ssk9hDKGofu7vaG3UDu00tYeko0swD5FXgZfGED6uBiL/pdWk3NHLtBZu?=
 =?us-ascii?Q?eNJoaAZzcKz2HkYzGp93Bwiat3esZHa+jkCX5nS+alBgotTwSmjzsUduQ6fn?=
 =?us-ascii?Q?XEYkNnbDFHygw7NpqKm21QV0HVZAenP6GHUSgGyI/+hCuZ+niwHJEXZy4Om9?=
 =?us-ascii?Q?66hJZIXkND1aUrmCTsVGCsZvVQ2RXB4KKn6+pVDfvoOFDBOfqCDIkYxWc+x6?=
 =?us-ascii?Q?80R4vkcehI0JsxX0oevXlHLjVjXVYJQ93PPIb1fNTSuAJJFruseisp6cXfud?=
 =?us-ascii?Q?mj3J5GUPvcaoNWNHdXLhn8Y=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d5f75a-54aa-4701-7e31-08d9faa65591
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 10:37:35.9249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tK9IR5zkH+08CH76OeMvu9EHIujkw5e+IOnHebu3hOv8ZpAFrTi6sFJKOjSM0PI0D+sGSCYkte6dJLG6/unqAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR04MB3002
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

 .../bindings/hwmon/adi,adm1275.yaml           | 39 +++++++++++++++++++
 drivers/hwmon/pmbus/adm1275.c                 | 36 +++++++++++++++++
 2 files changed, 75 insertions(+)

-- 
2.17.1

