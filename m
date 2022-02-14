Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700DD4B40BA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 05:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240224AbiBNE0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 23:26:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiBNE0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 23:26:09 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300132.outbound.protection.outlook.com [40.107.130.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4763E4F449;
        Sun, 13 Feb 2022 20:26:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqMm85GZXRUYSxvvvOeBxrfwTfKR7tWsaVs61tPC6ESTy43SPgPU83fTuRZqAzPKYwnJRJllSomn4nEXrAqoVxz4ItCqbm+2hZ4xKQVuuug4UGtovnhVR2fDEugpVSFl/QvCGpAk0WhS1n/F9TXzYE32RxCQ63AkiQ4VB4MW6xX/MKrrxg1+lfbZuwW77J8g5jZh6Icp5U/NvmHjna3mD8B11lNIb6U0Sox9XoSjo6kUR4CV4ZghjLG9hpj6f+47Io0hN76pUFizN89pH3mOA2n8dG4wrHD7Iy8a4iEzuoTGVYEv7QCFldBJ7cYtiQEbRmlwiArYbdxVC8Yqk0Z+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwPThxUa4lppSG4WcB365RJn7VMCO8VtnfeYQFpgnHk=;
 b=T/dbIj0AD/qnlMdAdICYv2DMloRBen/8tTAt8Mn2/6DxQeroLrzV3QYNrDvEOrKu4BhCjr6MK9rgISwLx9H+Dn3ig3wc8PgQWt/1RrA9zNl6srCwcvwMl5NqoWsJ6eTT4e6mgfgn/qpdyofYc7bcG0SboL3UnI0cm/73BFWhkwy1cJCUxVqTBVM40iF8ECO79NpfrgKfKrQFKR1vySrX5NOND3IoQ6trxgUDf2hpVF8rHDab986DtiDAFurmldENi6B91zi0LFEr0lsBQwnVCt6kfhc1VpqblHMOiYoaaUUZiUUBdnTad6k08W3+2WYfW3ZSNZO7RhpNsK5bYltxMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwPThxUa4lppSG4WcB365RJn7VMCO8VtnfeYQFpgnHk=;
 b=Qao834F0UO7bAM241PuZPgoPbnBpb4bjONFOQM4tKfwksHAVEXOj9e9d+sGfvt5JtgekGAZf3JwhGUJDtS5MMZZzPobtBTYOt7HtQ+Fpl9ALdtAoE76K2d9kqC3fNitXk267eab55QIpUVhLv/GyQ8Qok7TfzpZaFFHFC4MNtbA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by HK0PR04MB2579.apcprd04.prod.outlook.com (2603:1096:203:64::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Mon, 14 Feb
 2022 04:25:57 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4975.018; Mon, 14 Feb 2022
 04:25:56 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v2 00/10] update Facebook Bletchley BMC
Date:   Mon, 14 Feb 2022 12:25:28 +0800
Message-Id: <20220214042538.12132-1-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:202:16::11) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7878a3d4-c6bd-4054-40b2-08d9ef72180c
X-MS-TrafficTypeDiagnostic: HK0PR04MB2579:EE_
X-Microsoft-Antispam-PRVS: <HK0PR04MB257941989200E041B938E48A8E339@HK0PR04MB2579.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2L5Cn7Mq1fUXe4nVY+YwzDJWjNdxYLPOwsDffNmVt3/smVN2nSv7O3u/zUxj0MTVDn1Ux/5DzyqHmkpwLUltE9seXBKG2vdg9q91GYvxWuPBxgNrzVMRZ7DoofR1uT8RiVjcSyqJrU3rcWvkbZrfuqT8BYQSCpV1LXslf1BH0mN4YV8k9o20nSsdX256LK/bKKzJv+taurGc5lUor8QT2opos20+EQfzUnyA+CQC8/U30QftGV3ZNLGJtxH7JkLmlb5hZeg6KGxxohVhNFimK7QKjlBbvqInkXD0VeXD+55gygYI9Yhpb7TOtX1CM7a9nRrRefynZb4uQKBq5ZBTKQKriaofawlyXkr+lmLc2O6Mh692FrqwHu9B6m1kTJB/yh+wTNspCyxYq/BH5tTomJAVol0s5TPlGijtuaX2WjZ/RND9g8l0I5b+jamrTbXtxiL6oe5pCL9fMtghThqATXtMDM/IuO3k/xf9hW4nvl7dmgUa79syGYEJfvT/MGmn/66YsIdq1vV6mzeQL9MGVE+V1Kjk6XeGYHVr1r5+7enBaTP+pyTbiNjmu+t0xkT4INlDGKCGmTSdJ1C4Tl4l6FairXxbAVFBiX0Yeo/1k4qMDRGWbKiQ8SmGbbH2n5V/NjO/2s5XqOSr6hP+a15PQ0jc8k88DssyX02exZBoR8ZHXf1d1n++KaQ3sCU5mh3dTGT05Oq6PeqSDyE7TrYchIXz5NtL/+mmW1DjraRBggeBYf+5amrSaHFHwxVuoECST6Z/MLfNm3fjPU5FVLU2MV+MnUPD0dqjysx2ye0NhQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(47680400002)(66946007)(6666004)(83380400001)(4326008)(44832011)(107886003)(86362001)(36756003)(2906002)(5660300002)(66556008)(66476007)(8936002)(15650500001)(8676002)(52116002)(38350700002)(110136005)(38100700002)(966005)(54906003)(6512007)(6506007)(6486002)(1076003)(186003)(2616005)(26005)(508600001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6P8puICVX2FPDZhzOioiFvEHEgNO8eOHMcQtZ5SboiC96KoMixl+1hBuWJ/o?=
 =?us-ascii?Q?WBL3olWom0CKUe63BuoI02bHXqEYEFeIs097CUUr0ilRdCYScAj1Q3ofPd1m?=
 =?us-ascii?Q?off1qFOhOXP4aP4jSWpdVx0DcOntsPvaZ9MMoHQ1CY8mGslPWTdaECN0E/aT?=
 =?us-ascii?Q?OvOpTdmlSiLfnY3y6OkYuT7K6bRSK/TjGEQC7ev7Ldw9rJcNOzlxNVWnIBWK?=
 =?us-ascii?Q?qrpsQxRVaxISLXuHSjPUDNXO32XKqROEPxFK44nDcJWJxKSSiAOiHHLhwqsf?=
 =?us-ascii?Q?wOIQjxzyjjiWwKNmV98dmDRrYDo+QEUH5/2FnzSbXaxGp+JUgCokRdwQMwid?=
 =?us-ascii?Q?eH02WN+55YEqUOMelYW88/R6Nm5iKo+FMITvZs9M8qp64OCdLFwycO+/l+OB?=
 =?us-ascii?Q?EVBU/erlnmj6cPfeonwDNN4WnY6CJL5SSIE8c9aF5UhXfROagELEl07mW2gl?=
 =?us-ascii?Q?losNruWHg1qdiCViHDNOT0WQMPPSP/caDD6mjU8bn2+PDdwcwWRU8VTsv6xH?=
 =?us-ascii?Q?IOo99fCaxz6EsOqweFinf4pHslM8Uu8zsNafodhlZlgtEKRmj7R7B0KbVzKV?=
 =?us-ascii?Q?E+R2MuXWxig44yI7FR6tklBju11Rc1wid0KuvpNy4SUMVYq0+v/7bsXtYzLw?=
 =?us-ascii?Q?kh5fbHG6CL9/E10TDfT35ibtT/54xVRtw+eTmFKSQuLbOKheL5vqIoYPsYty?=
 =?us-ascii?Q?emVQDCAY6BjNdO0Vhqpo2e0DoJn1R+ZmVx6n7GcK2iB/YaUlsnpJygVDqI1T?=
 =?us-ascii?Q?lEcSTMGtJ8HOVx0Mz2cxw9+CsJKK9FkYI6cp+pd20IQKZIKg7iNXbvDjAG8r?=
 =?us-ascii?Q?4DQcT9awAcv597W/fyGSDZzyIMMGFlOstjWYIsjNfTDFll+bffgjWW7UJiB2?=
 =?us-ascii?Q?eLeMbidZA4wuiuwSeBO56F4HQspwKdM7xECZ+9RLfZ0lrq2lMR+nWzTcRRK5?=
 =?us-ascii?Q?dK3JCDvlu84rUwi9bpwxU6TWl0Ae2o8Yw/w02AhukA+ciSPVTvi8cN9hvy+z?=
 =?us-ascii?Q?2iiO1MhOON2Yg717S4L7rT185qferVJcrQpoGtTLt7pNRzDso3sovbLjchW9?=
 =?us-ascii?Q?wmiJZCykNLmdtnIak7qYwDZWwdsBlCDuqGYA2mAYSsHePualK0pix4uBrEIM?=
 =?us-ascii?Q?jVFdq8vrHSdSXY4UHz+IEXLergz3EMKiAOBw1erlJluKhYPF8furiY/Av8mn?=
 =?us-ascii?Q?TE2r5amUc+00Gi7NeMN3iwTpl2JcVltCPKaRVVX30L26gu0Eq3nz+qouanQA?=
 =?us-ascii?Q?NLhnH1MrA7/4z2r4jaFvjVFKHxn96WJPRScMwnygKBKAymza3WMb8d0trwyG?=
 =?us-ascii?Q?RO3p5o8gZ4rGUeKWKPTwwt2QFcEn1t5BhKPucOJ8p6R/XYmukbIa7H+rwTv3?=
 =?us-ascii?Q?rlnGgMeywMbdmxFBpLo0PP4j4t/KM35rAksoGl4A+/ignt8f0BISXZdDYo6+?=
 =?us-ascii?Q?u5zPpGH8bhKVuWkU6Ai6cbyp4mDYRHcJ7hPZK9lSVHthqodQWOehO4W3ShyX?=
 =?us-ascii?Q?tFcWoy5XnTWQ7eEQ8ks56M9dH48lAE9TP6UO62i51x8zu3KtMhQHAXACOWcR?=
 =?us-ascii?Q?2jSSMgSS/uMSIUo19pvLlXZXLox2mZNi86XyNZTQ3BA6FFzirPS+myMgHZ88?=
 =?us-ascii?Q?bFmvovTrTo+erMxIa6mudv8=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7878a3d4-c6bd-4054-40b2-08d9ef72180c
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 04:25:56.2620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rO5xpxdK1Yj2XbIcm9zcE7MXHPeCZ66EFtGQB35MZmVfIrcyRxefN9PZg4TzYzgMJVBMXuePUCPCGx2ymnPxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2579
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series update Facebook Bletchley BMC devicetree base on EVT HW
schematioc design, and rebase SLED numbering to 1-based for OpenBMC
multi-host.

- GPIO:
  - adding more gpio line names
  - include interrupt line in io expander for gpio interrupt monitoring

- SPI flash:
  - adding dual flash BSM module support
  - switch to spi2-gpio on spi2 due to unstable signal issue

- Hwmon Sensors:
  - adding INA230 sensors for monitoring
  - fix ADM1278 shunt-resistor

- MDIO Bus: enable mido3 bus

- RTC: switch to external battery-backed rtc

- OpenBMC: 1-based SLED numbering


LINK: [v1] https://lore.kernel.org/all/20220211014347.24841-1-potin.lai@quantatw.com/


Changes v1 --> v2:
- update the details of new added gpio line names in commit message
- add battery-backed rtc information in comment and commit message

Potin Lai (10):
  arch: arm: dts: bletchley: switch sled numbering to 1-based
  arch: arm: dts: bletchley: separate leds into multiple groups
  arch: arm: dts: bletchley: update gpio-line-names
  arch: arm: dts: bletchley: update fmc configurations
  arch: arm: dts: bletchley: switch to spi-gpio for spi2
  arch: arm: dts: bletchley: add interrupt support for sled io expander
  arch: arm: dts: bletchley: add shunt-resistor for ADM1278
  arch: arm: dts: bletchley: add INA230 sensor on each sled
  arch: arm: dts: bletchley: enable mdio3 bus
  arch: arm: dts: bletchley: cleanup redundant nodes

 .../dts/aspeed-bmc-facebook-bletchley.dts     | 303 +++++++++++-------
 1 file changed, 194 insertions(+), 109 deletions(-)

-- 
2.17.1

