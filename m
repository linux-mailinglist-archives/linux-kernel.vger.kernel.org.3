Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CFB4C9E40
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 08:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239487AbiCBHKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 02:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiCBHKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 02:10:06 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2132.outbound.protection.outlook.com [40.107.255.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1B7A94F3;
        Tue,  1 Mar 2022 23:09:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZHIia7Ug9xTvFMBgSySkEKNDYbvH+3C3kHW/l5lP5zH1nRBZ+XFWf5teCixbj8UrIupkdOsSns782+ZGXml1a0bgjC3Luv0z5K8gQcEQ2ifE+HDkfEjOeR3DmQCBqxJeAnpCirhyMcBVVAgGS7jAuIPJ12hQsiSt9Oh46hDHDrcQn4uOsxCRKJRak1aZX8v3v33MfcgLpyCs5PXa7wEkZaqVwhq72J6hPuTFwH2of3xgi1JqSVhH44eMoosIjj8QxAFjIq76TJdNI8qvrhmco95EBv/bPlAFc/hpvILuXPo9aZ9vIOu9ZzAglNJG0eAmLfmLmTVCoNGY1RBTH/DjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCssm2equ+YXa4DJ5rJCwLUM9S+Pok6YPSXDbr+0FrU=;
 b=VLnFTUb1N0tFLBG1XgoC5qOAvFcE6yQvz1m/7yNWTZxceAL8tbOXcR9ENT2h8GSJgCGX5zqbMj+bZ90U7nN/yCW3kAGmwJZqbSkTspEj1JErgaklqMrxfo9PwycQ6NZto+18yu8wWwSZHpO0qx2AcHhWVDmO2NAIDSryU55OncdW7WtdAdFKY5UniEKwCytSRpfpurwIbF5sGWwb11xFNR5vyUOtD6wol3p03kJ7GyZBQ7uqyzfRQ8hHRqEy9otQVtAijdniwMoR8b4JEZuqyR8DTgn8TAtpX2Qx/skae0zwDDmGjSe7tpmWsNpGxKwYv4v3S873jhZPTyXq42NjxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCssm2equ+YXa4DJ5rJCwLUM9S+Pok6YPSXDbr+0FrU=;
 b=VSj6YkQf2HIO4GUOtRWS1Z2zykqLXAZS5ZQVbDlJiBgtS/wu2Vls10PuP9tfZ41bMCDJOBK+xogTX270M9HHSUZMOYjLiRGlfTO8AUZ19cE71H24xMKIXW9rImipitT9n48HA4nwRrBtlfb98gQSAZXJwSMt8HY70nCG8zxCQVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by PSAPR04MB4488.apcprd04.prod.outlook.com (2603:1096:301:93::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 07:09:19 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab%3]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 07:09:19 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v5 0/2] hwmon: (adm1275) Add sample averaging binding support
Date:   Wed,  2 Mar 2022 15:08:29 +0800
Message-Id: <20220302070831.23822-1-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0139.apcprd02.prod.outlook.com
 (2603:1096:202:16::23) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f27cecbd-f5d9-4aef-5b63-08d9fc1b9234
X-MS-TrafficTypeDiagnostic: PSAPR04MB4488:EE_
X-Microsoft-Antispam-PRVS: <PSAPR04MB4488956C83E9F6821B22032B8E039@PSAPR04MB4488.apcprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Z6K0pzl7ZaHtl0nIhgl+1BFLIrKqYElQZ9md8v3My6p/XlkqrL1o1rGf1pJWcC2tcso2sEuJMsaSnW3XLiZXfDxEMHPriy/K2Uq6uU4NqReOpPiORwXse/YZEOowHjNsGtq6+vfLiYbJbyCRiiDFX9V9fAp0ceRouRejPxJwOJFM/4q3scXnaAZ1Z8GEHJ1Tm4WML2tAGUtXAWnxtNWY15k7hZQnxL+A0PdzExzI1HKBifv1dppTwsrzs0grIHyC/M37FS22VBlqhr1/I1p2+Nvzq9Fo9ycSJOxzdBY4UHzbAjEsjdrJPi8NR+IdgROG0mtZien7xCfPzpG6zf9Xi6LRK5Mz81YM9UGExbf4Y5ur8lqN1mR7tUEb6PYnQZacBMOsgxO45rpXdWqfjruXWElHTKH7tcEWamf8RwEhi/N+YVdOhGyodLKoi1ONk2Tekh/qLac8lFYi+x49ivEcy9kiwzlgsxOZs7Afv9aY9RFKCaNKxMT+fgTE0YifxAgtlooNVgjI4V6dZNUq+JgZX8/ftFVNtLH5joEhTACVKXHsIowKGhP9PRxwjD7gffSbbgSiD+/M17Uv0v59RGVKGKVlfIET+wX+rneJFc1jjfcrqe8fdx+CY96cXCau2tNU0xbj2XyMKpHI/fXMf1z9GCZLkNWyEJ6DgAEh97lLw2xGM8ZvmwC7W24aADSaaTLIXJ0VYoHQqPs4TdT4tczf6LlTvQtN0wu7B74LGh694HTwBbP4kEkZuomDzxRmb/XEa90o2+Kedf/3fq1plI6YTsNPO5rXHqGxLAMxIlWlJLM/HL8lvb9/fVe6sMA+6125RDh9uWSLP30F9Bew4yMrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(2906002)(36756003)(1076003)(26005)(186003)(6512007)(6666004)(6506007)(83380400001)(4326008)(5660300002)(44832011)(8936002)(66946007)(8676002)(107886003)(86362001)(2616005)(38100700002)(38350700002)(66476007)(66556008)(508600001)(110136005)(966005)(6486002)(54906003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mGom3/olXq8sAR5j+bxk5wH+BZ786JwT0MxvtMJYo7fRPEGfKiSQ7t9l39LR?=
 =?us-ascii?Q?8LMHAvfIkpy18TBNt9/6Z77Q3HR9TtfSX4Q/4mPy7YVwDsJFPaPCPUV/pqOV?=
 =?us-ascii?Q?C7HfEmwwgvdd+9VfQtjCgT2gSqB+dE+jOQ4bIuXK9RrKt9G6N8yFrxBzPxWl?=
 =?us-ascii?Q?VPJ/JckuXFTCh3z5Q/k7Z1K/Vo+AofbaB6BhlbeHjtA1f73AQ2DlB6GDmETu?=
 =?us-ascii?Q?UV4eiWcYdJqqBDHCPU0eov8YGZpyCj0y994mfqvSVhWSyXCwrfCVo4R/ebRu?=
 =?us-ascii?Q?jjAebHRZSPeOzOwqewEUi37Qj6cG337peU9rRZiv5ukOYdaD5STzFmLlyzAF?=
 =?us-ascii?Q?TpDm/t4WeXWnHUtxe+NTHFhx5i+ILn4cC8i12zudHLXWsQuXuTqXn7+wcblA?=
 =?us-ascii?Q?mDOUxYqGO0mFXWF1nRhVj0GBa7biWs0qZDY8UoMUTUYAaCA0UfLLqBaVdHho?=
 =?us-ascii?Q?MWPFyozXWE7qvMvOi8BggzYYAgqLWaeERllh3GYWxK9V2rxvR+VJO9ql6MwC?=
 =?us-ascii?Q?B5eJtEWYhIdpVotYXC5DRooQwqO8E7ZLWSZXs1nNSjZ7cKQ80M3Bp2uuUrwf?=
 =?us-ascii?Q?srIaCjTr8j2NL0yTQaYRCyhTEfhnbE+e5ULgN9+6dqRroYpopqc0uZzx/Nbx?=
 =?us-ascii?Q?nDQj8tOp1FdnEvULsWswiRLgUHVBVVjBFBmWm9nZ1X0KVYASuCLUa/AA2NiW?=
 =?us-ascii?Q?DvUyQxeY4AhSGXZrPBegTro2DJv6kKqNXx3MODDCkVNHoxFgz62P26HFJFBL?=
 =?us-ascii?Q?ZpSlBE2rCr8GyVb2ogp4jIcnkrBVkYUbRNtrz7h0s1Bx33M7FC0GSpzVUrLb?=
 =?us-ascii?Q?3AGz85NcC84WNq6QA+tMqEz8I1hXSjn93d3S0M+THijUq6Pvj3VcZg3PQVrW?=
 =?us-ascii?Q?QTZuCKLEiYV7TBmpUwCmHjBHBXI+fTkCv4s0zkpIrF9WgpoeDwV6HgIBlAPi?=
 =?us-ascii?Q?5MG9prZNmG97r24wcbBc/UX8OIlWE3jGYSOg91jgAGyvXl5ZVSy3nr2fbIg0?=
 =?us-ascii?Q?k9/uq5NcFPwu7JjlV3t7+l85gxlQPQnCuDlGZf2gOZk8QUvuIZr7nYTz5lSK?=
 =?us-ascii?Q?6YHmTe0nhY/ERsWqC3l46whtmJJCcEQrqqYGSpSXhYSkQJuGMQSd/Xzy/px+?=
 =?us-ascii?Q?Ghfj2Y2cU3VLvHGY99iSbOHFfPfaYCBM0odbitDZCqvheXTNTZOvMRNIV28Y?=
 =?us-ascii?Q?Myq5WhJE7A4BENKRgL9pErUIcwDOmKnZ1FwBADGCJyla7ukp+bjjX1MfVbwX?=
 =?us-ascii?Q?CyR8b9wYAnsHZMZskm3WspAQyC8nX/+nLx+MSgdBLpIG7fM6WxwxFmIW5pAF?=
 =?us-ascii?Q?Gc+9QP25vd8mQ6a//jXTeEBs9B5ypGhja3ty5R6KUVJBj7Z1X/keAGf0ShPL?=
 =?us-ascii?Q?+z7OsJbDy10LNsTkdLK8Fiw2iWy0XadKFOdPhOjwZqMIOowsGq6+AK2ltzyM?=
 =?us-ascii?Q?zvkFkfdq7BCXr2qojEb9ImS7g4ikZweWHwRW59w4CGLCVurDknvPPmvo1VD1?=
 =?us-ascii?Q?QeiYFD9c/pcxXfljolYWmApsKzVUuHCfPHRrt98bpAkotlFxuC06glROn9dX?=
 =?us-ascii?Q?bp2Zb68iLAX4t9FzYtwZfABsBI7kFaumbFKpFq7mdPNjtCn/a2ElXagbZFlF?=
 =?us-ascii?Q?oTPpEgkssf6xUdzkcNYtqkM=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27cecbd-f5d9-4aef-5b63-08d9fc1b9234
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 07:09:19.8888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+hjR3crJHBQ4Q0sAHTRUu5D0QcnkBxgUnHPb5J7DaitS31ag7DdLQOPr70ktDh59UCbaoiNmPaEpKJntgQ1wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR04MB4488
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

 .../bindings/hwmon/adi,adm1275.yaml           | 69 +++++++++++++++++++
 drivers/hwmon/pmbus/adm1275.c                 | 40 ++++++++++-
 2 files changed, 108 insertions(+), 1 deletion(-)

-- 
2.17.1

