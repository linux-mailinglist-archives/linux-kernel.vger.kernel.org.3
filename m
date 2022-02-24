Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A8C4C301F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbiBXPoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiBXPoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:44:21 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20713.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::713])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3F61A39F8;
        Thu, 24 Feb 2022 07:43:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JACSsNGUMnOAYrtkYW325fYjhP/vrVPMFTZHsHU6mZSxM2ZznbdNDm3eNftdeaYuf5H/SnqBMXKwmVoHD4JAQoxJxxxypiDGCpUgDldOKnWCvYJ8MwIyqjiJPNHrV3yyLklTqZ40NEikO/2DNvmzGOPlJpFiMeYZBsApZxAaaTN8yQphZNF7mo2lwSrVLYIb74Az945qGkW8VPQzEobJMT1q0C/MwnRFivfND+4ntfkeE9ukqSOppphGwUvrzseOjri9gjcn8XFBETbzThNYumOxJKBp0H75FKNhNQPuE5dZHIvxyPL+oPkGhlv+NaejHIgBKD33DWWZ+N5wjX05Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=199/fMpX/48NH78pMsCHPKkIuWzSapjfoo8hrv4FeQw=;
 b=MTInA4iQF7igblkiP3V0ICvOv6oyXwB3zLoti2HRghSsBupiWyE96XmPlJX/tm+RkV3xh9rwZFKmST8OdqadgnbZcYIoeOwVtvJDIwUJLOtMj+QgZK73yGRvoo4+mqaDjko20NPkas1d0w6s+/GCmXwLL8TmswpyI3L4WBTq1YwHgnyI5zM6sHGM5w2VbIt/0T8aLvGNVKGZfWDyLBTarW0Eui7QDe/KURRD61nUz6wSRpHMUzLaACXED6/dyYN4xAqbQyZxa7XkWTKc/iiPtndHmClpCAk2b9AgpbRmA4nuBmFaYBmYC6qOFCjwX3ITTKM/u2/kREVgJjsXUfFW9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=199/fMpX/48NH78pMsCHPKkIuWzSapjfoo8hrv4FeQw=;
 b=V21xwRh30Xf+KVHypZao4NCt2Bx4lGGLqhcwmE/vPtvFi/Cpm4GZKsjPLnVMJdK7Fds43HOoK/coqpGmu0+/5bEphEmXJKEP9L4/6qDJw/hokBqQ5biJWnleVJGMkPpji8PT/lU7QKRrKV5WgQUbGZeP/9qg2190f/u9kgl409g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SEYPR04MB5858.apcprd04.prod.outlook.com (2603:1096:101:6b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 15:43:43 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 15:43:43 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v2 0/2] wmon: (adm1275) Add sample averaging binding support
Date:   Thu, 24 Feb 2022 23:43:27 +0800
Message-Id: <20220224154329.9755-1-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0148.apcprd02.prod.outlook.com
 (2603:1096:202:16::32) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8f96bd5-5482-4a79-61d7-08d9f7ac6fe2
X-MS-TrafficTypeDiagnostic: SEYPR04MB5858:EE_
X-Microsoft-Antispam-PRVS: <SEYPR04MB585857F3CF2172663221494B8E3D9@SEYPR04MB5858.apcprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TFEYQzLGWsqszoUuF7ehZFh6OVocLSrKdk3ZlF/CyRtS28m7ocuKB+k/sVFchJhwXxCTiKcHl6YYzhrFnH2tu77XohnSPsoezNQ7UlnFLiDs8p6LRtaXBMb7kHtZrNmvwW4DEFZG6FRm40rsx1pJtHesqbJiz5geWE4XdwPDkEJr5rG7tSiZ5JFGAqdbElZINE1TqKmvObxuh++TXp2jaYWCmtBDwKy+K9lV4TOxxHKO0oHfwmYV9yvt3D/2F067JmQlabcXFRR+1A1b1HDzNHslkuPzceau8Bt7RjPUBuG4omNx45peHapw1PztP4Gj8s+Xnuhq7DNli1ByYILIJynBfLcUJIJhdv1NngvZOUuFK8SVvI7vzsTuI55zDzTmwX4+uqvlX1WJGXTH8sFBi0Cajj5WduvZEXzS8+/GBcSXLv6lURNTKgJE0OznZ+vcg14uWfEkfTZhEC5dq2Rl7i9S6IpvUDmE81sARuA/8EypeBpz/Nl1eeq812/lU186hQ9Yt/6Pgr76JthNatIpNmPnxfr0OKZq+aLiEevjnxu1uVZeVmGirxHJpO1/uXOeuzBXEZBufe8WlvjHPtk+/2DHZsEQqPZW67LL2RTFh29haUE3+ylUCJwxgnl9duOfMn1IBYf7/DRPBCmjq6SgagurtuDmuqiAns25HBdB9yJR1vYaV4EOuRXPDyaM42F0YUi3tRDwvKtc0pB578AncH4VpFA0sJ9wJuaZgU9euP4pqeUBEP199Cavf/g3nWYWTzva+btAlTvlsSL0rzGz4nzLvWR07mit3r47zDrGXIM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(316002)(110136005)(6506007)(66556008)(66476007)(6666004)(6512007)(66946007)(52116002)(38100700002)(38350700002)(86362001)(4326008)(2616005)(4744005)(107886003)(508600001)(8676002)(8936002)(1076003)(5660300002)(966005)(6486002)(26005)(186003)(44832011)(36756003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/jdqJDu0kBEXfxQ9Gsf9Jvl2f1WakvLt+lvLDtASHyHHWYtGZs1EjDOjkvvL?=
 =?us-ascii?Q?FnQSxNbO/a7rCAarB36E4GGB9z1rgQN0kvkeyzZEB+jpoldCv+QphCgyMLxm?=
 =?us-ascii?Q?JtH8rDsg0dlwwnSlDgzPoETheCRK+c4OnWmVmpR2AsIg6McczLkFJelK7C8F?=
 =?us-ascii?Q?ih4nDraLBasUV76COCDRSwD/EQy4AQW0+xLn1Z5ymR0mq0yeSA3GFYKFFKU4?=
 =?us-ascii?Q?cblux/eSRoLd7MXREGTtWXlp5CoX0kGgC++g4Gnk15/+lwymN0Eb8oTHNc1c?=
 =?us-ascii?Q?Re78aH/rKNP6YmPaC4gy2U+o5LDhLDQaf5J2lkOBlHr12G8HbsEZcPMN7yr+?=
 =?us-ascii?Q?90nVsg+6CcPK+88ag8oPGBr/Rkj2HpT09RWDsn+6Q5A2juytzesk4YgiiPed?=
 =?us-ascii?Q?MnxvCscbbYs7nGDLUoboNmJRGY4AfOZwlUQuKKQSacNEXiuKnrhELT36rFVA?=
 =?us-ascii?Q?jRGythBP3H8Zr3Z4BR4ass34Fq0ll0Hozqjl5Az5lUYuSGQCMUGMXpHYsZPB?=
 =?us-ascii?Q?0OsjJ1bw8WfHNl6p4DKTedPl38nH76VvTijd6qNIXpjzHZ4TRvpOkAErpLh1?=
 =?us-ascii?Q?+7oSqivpMML1Ds9OxObiksUFlQpRlRy/lC0/foyWbxZv+vWg6xD+cm5khu2Z?=
 =?us-ascii?Q?Ahk/wRQWF2XJn7zEDaP0ElcydNoTvBErz7WL/YuPvqrFFQZ3BNk0dgQGj1iN?=
 =?us-ascii?Q?kRuefvuEFRW1cZv/W319SaNVHUjAF5c3Pf929Xxlbbmg+vESFMwXxy1KfCog?=
 =?us-ascii?Q?Z9LfGqnBL3Ji5lRDu1X1doBnyRA9VGYWtOV60MPGrcehmQ51bKwHCKm/sUt0?=
 =?us-ascii?Q?/V6VP+jE5PiQVyZEB+Z0lVmKcyO2MdHphAM+OJCAMLGH/z0owfsfZsZuF3sx?=
 =?us-ascii?Q?i+rmM0EJZUt/qR+Yo70Yaq/mQcb9ppz9NyotKlCLf5G4W3SpBE+0OsIexod5?=
 =?us-ascii?Q?Wv8dZ2B4M9qUCyZRUiOhdZSjjV3klbs/xZtHi0Vpj6CbTtmpLrxNL1URJtU1?=
 =?us-ascii?Q?FSRBVTXcLWWTtmCd/Km+NPgqmQP6YD6Gnn7i2g0i/kxkKkFzPZbKKZfqS7lN?=
 =?us-ascii?Q?aFuq7hYw7ZaoB4UXC1suKjvY26pabkCFtzK3C8VusqUCtZHvl991dwTwckAp?=
 =?us-ascii?Q?L1YY5SoI6e57XLnZFE/ff7jD8PIUYJtv2lJr3ZxS2JchvzPLY0l3U+ueneSZ?=
 =?us-ascii?Q?D2VYVTUlMQM2p5tA7qUvC5q1K16F3CSRdG7DzzgtuD5mQQxg5bnrasmIzAQy?=
 =?us-ascii?Q?MaijBa3ZXeKIoIL059pfCto0FrA+t7PT60dihSoSFb8pWGf3VZ37qigb4r4I?=
 =?us-ascii?Q?9tgGfEU4EFX6HOBlJfRFIEU95ilyutajf9n1h0WTz949ZvpuatdXSkE95ZSu?=
 =?us-ascii?Q?zEENRH7h6w1Ml/jBTNNtS0q7NRSjpvIejvwK9l4mHL/kyuKZLMXcyv1YboCD?=
 =?us-ascii?Q?Te1BZFpYpLbyt+gC3JTr16wcr6W/PARfvuHao8OBSQHZ4piBKsrksqWL+5sj?=
 =?us-ascii?Q?uy/vf9VIyP2ci0dVxX+2RRRQUogZK1wkkhcwimXkH3KL+P+supCpTDn25yPT?=
 =?us-ascii?Q?y7z7WkemqkJIgyQXw3ciS8SbG7i81QJARzxyvu9cbv9fWwQdXoX8Hum/c2Ra?=
 =?us-ascii?Q?OP1FeLc8QlclZtr3xFLF3nk=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f96bd5-5482-4a79-61d7-08d9f7ac6fe2
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 15:43:43.4740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9a26dYFEmrvkAwemrZHAEpua4Zee6jpkoAnMdYnV9b31H6gHSFf1tXkKkxRBu0uMFdl6UAZzIRGPoqj3FgKFWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB5858
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
		adi,volt-curr-sample-average = /bits/ 8 <0x07>;
		adi,power-sample-average = /bits/ 8 <0x07>;
	};

LINK: [v1] https://lore.kernel.org/all/20220223163817.30583-1-potin.lai@quantatw.com/

Changes v1 --> v2:
- use more descriptive property name
- change property type from u32 to u8 
- add property value check, valid range between 1 and 7

Potin Lai (2):
  hwmon: (adm1275) Allow setting sample averaging
  dt-bindings: hwmon: Add sample averaging property for ADM1275

 .../bindings/hwmon/adi,adm1275.yaml           | 44 +++++++++++++++++++
 drivers/hwmon/pmbus/adm1275.c                 | 33 ++++++++++++++
 2 files changed, 77 insertions(+)

-- 
2.17.1

