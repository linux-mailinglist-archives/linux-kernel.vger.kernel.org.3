Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FFE4B7063
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241605AbiBOQcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:32:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiBOQcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:32:21 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2100.outbound.protection.outlook.com [40.107.255.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88BF8A307;
        Tue, 15 Feb 2022 08:32:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNc0BTDyRVpktsP3r2JpSp+FViD4N9TrSW69MIys0QXxxocU1h3Ay4XAxob5A/jwN8b9QgQM6PhbFOIVWNGZPjWYMasor801yslfu5KA6EvPva6FIru5qRM7kKhBRouyHPlvxRtDjjKZoDIIjT8cG9GpVVNtnaqwHvgZ8d0RJHiiTHk2MZZnRpjWjDIWEekofV7tK2a6JJO9USDIdkVuKjgGUpVZykkkLyZ9OiOsv5fnLMHRRRmWSDqmJbkYlIOO6Fvoxrz6srQ2Oedm10L3YJbBv/J/JQfmrzuHGEuQnhs6iEg6hzSyOBOD74Xgin4KB0uPGJvxaT0KIyL1P1kQBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwKcBCPTwr13rV/sJrALBr9/Rm5pKUqJUBrmoaz8+7M=;
 b=n0z48ANTAXdpPbPntWKlIJgdIgYu0sYlsn4AtlMLgtkESiVR2F5rL9kU2W8qe608O+fVjGJq70xI1SogFT/og6Am5aZR+X14vudvBydGNfCBnf2KnThbKioB33IxBJ7cemb6xjt517v/syj6DdFCITEC1V+S4HmpEU2XfW2k4lxf6rsnrRM1ShN2wvWSsjGuUbJdtx9kbkhZudnL5YDm+EV8QrHNGuDwrIHn4IbxXnL13mYP314tIDJg0wp3pNAcKVzObbjSuRYeN+fozFMuyVbPZlylAnf0dFTuNCkQD3wl+zU8xMrkbzyjos7KeWgq4HIYoizCug5AUJZhNj7xgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwKcBCPTwr13rV/sJrALBr9/Rm5pKUqJUBrmoaz8+7M=;
 b=ET1c1lHELVBs/MOp45hcm2pJoevEtQdgvUxeIBWhnJWes2PNJHNH7jISuM9amCUxOUVSrD0QseNGxzW2beR+ypH49MvoRKXNUZduDkE2A/EjvKQ0aaSdDf/TFa9d2Ibc4q3gOc1Fyi5FmnssERD1B9bWsPy6bm38Ja+4rXG/bfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SI2PR04MB4602.apcprd04.prod.outlook.com (2603:1096:4:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 16:32:05 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 16:32:05 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v3 00/10] update Facebook Bletchley BMC
Date:   Wed, 16 Feb 2022 00:31:41 +0800
Message-Id: <20220215163151.32252-1-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0141.apcprd02.prod.outlook.com
 (2603:1096:202:16::25) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0765292-18f4-452e-73e4-08d9f0a0b3b5
X-MS-TrafficTypeDiagnostic: SI2PR04MB4602:EE_
X-Microsoft-Antispam-PRVS: <SI2PR04MB4602EFA14F34F1AFCB464EA88E349@SI2PR04MB4602.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0y2yLUo576pLADk3Nza/tS6qlmdH/Ru7Os5e4P2GFfY91s/gAqtHC09h5lpInbM/cT0aSvX+lzf+W6mKACi781voYVjFRjWss5uLRQDK/c1XipQVm0Szr7vvZySgmsGcWuwpwd2U/owzgAmhz00PX5yWGo38Nm7XJMSsIqsXcKoOYjUg71sKNyTUCrsL5gX8EiDrb2ANak9ZovCija5gPPqzOLnUxx1nu/bSWPn+5GvmO+ROnqacawwOK6vPD8snX/33iJTHt8sbmd4PQ2k1uDnwBpsRUxj7AyBIfxphA440ibvcVLEZCNylt0OWKMPjIsMkNUVkKekwAvvAHMktZ9Tw8AHmF65Su+Ii/sKJtC1DzDS4gESQb6Qsoj+IjkqUqlQKJyMAYKdyGyEGbzk2KEiPdTpWJ+UzBo9PoQS3+jEvdv+lcIkZr34dMD55XY2lYYIIzwb/tb+/DQ8SDbhQX1bxPPX49aYSewcW/uI29xmNEg9e7dQzxGFRZNXn7uffhHc/b89R1fiXqxBFIGMEQObv8N/cHVqamDfcL/P0Z2+IXTAgMQ2zUyxTZs8sGxE/hrWbMxGojey4gI8ZVCL0na0tSwhmx0dmctjNb+xHXLiUxVAT9mjpmJHEpZ1oIPvi5MMGdonAWYBuVsQSfEHu98Kx6j9Kp8Ei+diJK0P/oNpx9Kt2RE0A1F8Fhfp4XoX31/xlwcCUe82wbiFK6kBCGWjsCIQVqmQfG3Y9rIjk7b8xv/cnzis6S1BOMh543Tl3x00qpGkXA9b44ONuhp/Udi3tHCsVPNM3g35gwSHEBQTOgAdqJGDZfqN1Ak3XDniP7197s15Smt2Wjs6mqa06UA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(47680400002)(1076003)(26005)(186003)(2616005)(36756003)(107886003)(6666004)(6506007)(52116002)(6512007)(83380400001)(508600001)(5660300002)(54906003)(110136005)(8936002)(38100700002)(8676002)(44832011)(966005)(6486002)(86362001)(15650500001)(66946007)(4326008)(66476007)(66556008)(316002)(2906002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hVHWmP39Th9aMX+3Ip6wfBfYbRaWNjpMqnJZfX0tYFErL/ayEotVL024MgP2?=
 =?us-ascii?Q?AuGetFfjvOnuEy+UJHw9KjmfUc11BC+Vbt8S4lqiWAugDAThnQWB7ugVZWKX?=
 =?us-ascii?Q?+7wBNpS4HDoYFEP6I3oE3XeUSw5xIleFy+AdWnI/n0Ozkvf9IsxdV0y+prHh?=
 =?us-ascii?Q?zGbet0zELvcJxdT++kGUd3EF8ohMuqlXd8KEUCFz1Rl84FWuWASPJnyssBxE?=
 =?us-ascii?Q?jwJVlocp7xoUi79LsQtjfcT4aGUB8vfcTHH9fH1oWp94pQ8TjWeYp4TBMO0G?=
 =?us-ascii?Q?Kr8X7wo7SxPbAJ6AeuOLK0uduMEmg6L4AEqssqwfuO/58taLvN/7eQY1WijW?=
 =?us-ascii?Q?fJeHIGYkLbymqSRVEFN8DOziw49qznF4lPXyh3dRAj9Vmm+dVvEngHJgSaWW?=
 =?us-ascii?Q?qyBay5XJFsdUWLgajIWxFPLRvUX7++Vn7LZ0+YRpb6OHRVnJWOpAGx2FQlKZ?=
 =?us-ascii?Q?zkqIA38H0z5GCzImr6IYEjVSiC5iKNRPjC9nAff+yuKAodP6TBgME77Fy0/m?=
 =?us-ascii?Q?AMGNTjj4D1k3aj/RROJyh0Rk5M1bJcvTwliLinQ/QD7rcYraFJDzLt6fZoBM?=
 =?us-ascii?Q?T/IvpjFBhwCjRk/Gvo7YNX1VcXhBAOJXN8X/qpdGZEIu1qHacVfD4oHI2u2w?=
 =?us-ascii?Q?rx1wnBIDFUWDWDHgCqLxdieoJdc/I0qIvTlH7pqoe0FARp+XBgoY5u5J/v2V?=
 =?us-ascii?Q?+kChyE9ZUGlsY0Vev738lvqmEBy9o89t5ENFABxISnIQMrR2lkuwpMMTG9qa?=
 =?us-ascii?Q?z62+VCkXRQqIF0WLLOIMruF2nOxZpsmZ42bjWH8DcWBIWCzRlK3L2XfXv8D0?=
 =?us-ascii?Q?vgkSwYEb6WY4/Ol20jKCOwQ+rZHjzdlkMsXApBXd774jWcGXSEIej4pevk1B?=
 =?us-ascii?Q?i7vTdc5OjVzDd4p6y7Zj/kiLckcqm2G1JZ2JSOWG4tASiyOQrQYMqcYQg4F+?=
 =?us-ascii?Q?8bIUPxzhcHk4+soZG25ZOrQs/54UIvAz2zD6DJ7c3gPrxGl4wk5GHFAwe6ct?=
 =?us-ascii?Q?18D2qGubw3jYnAYMCMV8cxAWh/OWvMQY4icq0+r36UCP4MuZ7POm6SiBDVSe?=
 =?us-ascii?Q?WffKdEbnGd+g9D4T3Lv9Bs9pDZj8m5odBQh8kFzo+bkBT1sfIjZH1PWS2bSp?=
 =?us-ascii?Q?GbUs4k2iREf19WimmQslI1ArNDDOJt1SBf6dj60aP34AA6qP2tDsuYcPy/Ip?=
 =?us-ascii?Q?cbwgdKle1KfODFMxGLdDsy1bBq5CPuDeuV/fcr24dVQwwoQSlo5bRO/j4fBD?=
 =?us-ascii?Q?b/t7iCGTlzokgfOOfrgHlF0h4KLnHHGbSgIoUY8ErGAdmBMwpgqt7JW18n0q?=
 =?us-ascii?Q?DDnsp09BqP05xt2TxCNLNCZD5AqczYEsDej047LZmKoYUn29DLtMOoPbjrPP?=
 =?us-ascii?Q?x+6mfsKDLx6Hpikf1nrq/sH/4wmZrAncNZnBe9EVeHWKx2dVv84urV3wrz6y?=
 =?us-ascii?Q?T38w09UNZcO4fg7KGoSPjAiQI/1diBvdJXWAsjvcP1wyPtosqvxlnFimyYAE?=
 =?us-ascii?Q?khW4SfyjwCTA+eRSSY5QTXXWGjQHkciSXaVrLI7thlHwms7bX6dXmgWzutC/?=
 =?us-ascii?Q?R52yTsy4nB9Oz/oyfQBMplTVRuTR/C092yVoD+yfvMFS7vsCmotE7/2efXcN?=
 =?us-ascii?Q?XCT1/pccCMMZpGivmMPs2rU=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0765292-18f4-452e-73e4-08d9f0a0b3b5
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 16:32:05.1645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6QNC6XaF9QZ/iLXD1NMJbHOHW5G4Ics9y60OlmNy/lZWQb8T99eAna1znNsahSaBwOZJu9sXlqmlJy7Br/Ozg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB4602
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


LINK: [v2] https://lore.kernel.org/all/20220214042538.12132-1-potin.lai@quantatw.com/
LINK: [v1] https://lore.kernel.org/all/20220211014347.24841-1-potin.lai@quantatw.com/


Changes v2 --> v3:
- update patch name prefix
- Disable spi2, and create a new node call spi2_gpio

Changes v1 --> v2:
- update the details of new added gpio line names in commit message
- add battery-backed rtc information in comment and commit message


Potin Lai (10):
  ARM: dts: aspeed: bletchley: switch sled numbering to 1-based
  ARM: dts: aspeed: bletchley: separate leds into multiple groups
  ARM: dts: aspeed: bletchley: update gpio-line-names
  ARM: dts: aspeed: bletchley: update fmc configurations
  ARM: dts: aspeed: bletchley: switch to spi-gpio for spi2
  ARM: dts: aspeed: bletchley: add interrupt support for sled io
    expander
  ARM: dts: aspeed: bletchley: add shunt-resistor for ADM1278
  ARM: dts: aspeed: bletchley: add INA230 sensor on each sled
  ARM: dts: aspeed: bletchley: enable mdio3 bus
  ARM: dts: aspeed: bletchley: cleanup redundant nodes

 .../dts/aspeed-bmc-facebook-bletchley.dts     | 320 +++++++++++-------
 1 file changed, 202 insertions(+), 118 deletions(-)

-- 
2.17.1

