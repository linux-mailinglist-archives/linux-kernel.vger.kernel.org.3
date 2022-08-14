Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EEA591EEB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 09:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbiHNHmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 03:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiHNHmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 03:42:11 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544771F2D3;
        Sun, 14 Aug 2022 00:42:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxR6HnSa5BSkgeKnPj/nHkTFqM+z08SND9/qKALcJejdTRAAY4l3z/d5e2UbVqUrRzIJPWvKr70xzaAVb00nilSLCGPMuHtXN/ZhKrtpkuy0BTxBQHwnGpUB0ArOEUtkHWzSSalZB7MFVfRCheV3cTS45WP9o2VEhDZ3mo0BxWW15jA4fKBTozwpBVbVrL7PS7p4WRyZuZar+FsQUkPrG0/G8kdWgw1vmRyDVD9SAYgCiRi6rVkwYwR1+6o7iyIgsI6Kx871qY2H30zdJnQ+jXxQ+fa6/Z15FWSRBWQkLcm5Apk+9r2ovZnPvzH6vgdj0qagZTGAfLxhYDBAaVxiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zw8Ro1MO+og1+0voe6aIlByQLmKCl2PanpBTwEdHlXA=;
 b=eBG1H84Wz7iKB6K4V19XmGksVZNLJWE/ZSpZ395CYHKdsKbvuT0LrhK/Yo/KBK5CtGOW5rm1jbmpZxS5oEYUHBPeLgkoG0uvcoq8XPMm9XE1/rVKwuknyUu+p0kPse20KpcEv3E1bswQ5AsXdRBnmik3UOJHvZx8C0hKPFCwD22fG42FrMpzqo8SMwcdt3P+kM1GPmw4mU+d3MT9PI++QTYQSYPjLiQxeKks9m4adf0jh8OnytCv6VqiYEL/YKnDbqni8Ic9uHmw4nxPwhXWfUvrOuZBqnREyV9dxYl8W1Uucn4RAFSFPJOJB7lYtfpCDC6ljJk5eM15xVAu16ZBSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zw8Ro1MO+og1+0voe6aIlByQLmKCl2PanpBTwEdHlXA=;
 b=cwkf6+bTHvZb2TZSl9y152/VSmRdY57svBoNwdz4H7GwbEfaQc9E/qJZDF19PaxToy/JSUzi68xgC4koYTrMLBuXHdxFNpqYuOnutc+NyUCVpqQRYLg67EKuwxB0YsiM60m+t2vmDmqmuh5uF0nvBkZoeXFR0l732EdadZg5VZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VI1PR04MB4016.eurprd04.prod.outlook.com (2603:10a6:803:4a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Sun, 14 Aug
 2022 07:42:05 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%6]) with mapi id 15.20.5504.027; Sun, 14 Aug 2022
 07:42:05 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be,
        krzysztof.kozlowski@linaro.org, robh@kernel.org
Subject: [PATCH v4 0/2] drivers: bus: Add Freescale i.MX8qxp pixel link MSI bus support
Date:   Sun, 14 Aug 2022 15:43:36 +0800
Message-Id: <20220814074338.453608-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0197.apcprd06.prod.outlook.com (2603:1096:4:1::29)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65a9326b-cf08-4fbe-2532-08da7dc87bac
X-MS-TrafficTypeDiagnostic: VI1PR04MB4016:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CRxulwVzXrZFDuYoh4IrrMuPIQeEv6h+nPiq9eavHb0CTS78umZrp0dnveUfCUeXJS1mo9CsSM3B5jShCkAY0G4SKSPNNVfLEMXSS+ITO3zH6rq8j/uEi337Syd85VudQs4FPo3qnSPUDWK+TCqZqxd4Ztg0/ZltB9R0VVwo8j9r+0FKQygVoAsau/v/YIvsusjSVmseIOhqIK1/9CstJpkAOEAnlsTx9m4InHDJJMBcp3dwOFrt4uaEI9JcuBlf/6I6c/koawItVZsvUb+jaR7dnItBvbX1SauZWDZJKyCifZxsNTah8VcxlFEPZSSfDsoO/eIolT87uOxBJ85IgFSFglX7t/SZzjstTzRryZ6mnE9W/z5bZlw28e1krGSbKy69EyWmhZMqOk4qqml+lGltnLZ36CGm3XViTFT50CO7dUGmmN9qlEZqXsAbTE9p7T/Db62xY2Upr2C2315dqiXLOvopmlLYmyMyX9VI67MnNj6UtGaZ5sF2NHwVKd0pv2mnKF+ujLqiM12UTiwUEqi/5/PIoimeGhuErfhfDv+JJEh25fzRrvwDgFejn7IEdVyCk1ihJYzUpVrvtQum0o/M+nLi5PMm46FS1NHtF3wXKsLyTqqFgpGeU6WZW9f1uf1Fkvw6jNdGdbEn/R9OHAlyWWQT5qPASfVt4urnfdyhCqKxT7vzWwKlTEItU5Mg5XWypnx/4RiPpJ3A42yS31Dj5jYhNEKoT7x7VyzddNnalz6Fy+QIhwAoBXEOwCNnWUqLr2WunmLsBnIam57JmuYOKwW70L2LhCqhP54LZRs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(396003)(346002)(136003)(376002)(366004)(36756003)(86362001)(26005)(6666004)(83380400001)(6506007)(6512007)(2616005)(1076003)(52116002)(186003)(6486002)(38350700002)(4326008)(41300700001)(316002)(478600001)(66946007)(5660300002)(8676002)(66556008)(8936002)(7416002)(38100700002)(66476007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EggfzHpfkX7cAp1DCXuQ508MQnX94zBqAJAWRByDNL4GtdY508Azm3uqeNkQ?=
 =?us-ascii?Q?r4V7e3u9PqkvXYeBh1WKd80DgL+d3A3PS+Iyms71s40p/LwOCdqjoTXbYjDj?=
 =?us-ascii?Q?bf/1X/pFY0Dc63vZADBna9zxYZ7TFkkM9dyc8AuAiygVdai96etuDHRuBtZg?=
 =?us-ascii?Q?hFqEc7cDZozJgnvDkQ4lPN3fEzW5x+AHaUHlsN1QTrerClGzstv5gOTdo7xV?=
 =?us-ascii?Q?YeWnXwJ/e2vTdmQsEQWtGbnnBtiQxHlKQo08ynMgFCs0qqVxpOG5WM0hY/sa?=
 =?us-ascii?Q?+PNs+mrgFG0qolJ0qteWcZ1cqCSUl/eG69q9qCqFoJm+fWMlEM3fTHNVlXC5?=
 =?us-ascii?Q?wNMJmqT3zwYAzfjU4JhubY9xqfaCVzHARGc8aDaEr/6hSUPu2pzFov8QMMj6?=
 =?us-ascii?Q?apJj8Ql6+wIgW8wOjk5BgYQnfNTg+TIq9N2tCCxzf+p3wjOgeeuobs+5mIFg?=
 =?us-ascii?Q?ZhzekC4n1cmFIGhmMR/PdaaMUDkEnJ5wtFaT0CRSjFMm7qZ+5GCYbwRgEdpg?=
 =?us-ascii?Q?Usz8q+JcpAJCte96wX51QfW5F6IEfJZB+uOx8Y0aqOpDf4t3JRhrfpF9BAxg?=
 =?us-ascii?Q?Jh77SpJQsOUI2vbLb6JpsmDQm7yaoXKQ9r2aFEIMWHm0WrPudzsoasy8l5d4?=
 =?us-ascii?Q?2/2WzBvra/IcxEZ6LdBIpoD7RY/dlsromHLAo3r++HkWj/pi/8N63Og77DD8?=
 =?us-ascii?Q?mPKzXwjvpWkgYBD3WLMwHbiWltwnLBDtM37ZI+bFEY41s49YXVJfVX2tOZpm?=
 =?us-ascii?Q?aM3xicMAmLPFbWRVpvci7q+5scKCwwcmUy67GXjpTPRNAkeqgKbkjQvchqVe?=
 =?us-ascii?Q?ZB3grWOeobaQcfar+40ZEMMBAjlj3RGcX0JvrqWFYo0U0gZ6lkR/zixhPYAi?=
 =?us-ascii?Q?tuddcO/jaQ2pqYbEwXLNc3Xh0sVxRagW5U649eIVcyVl1SW/8EeR7OuI0KZE?=
 =?us-ascii?Q?e04N2RBRNK9CiBmfgyzV0u7K/HvZkyNG+L/iztF3eJ5Tt3Oq87/2Zx0b5PX+?=
 =?us-ascii?Q?ttksT3OLRb/t5qccrUYc3q37NkJaqi2hyu3ReMfkNN1mjz9t88RF2AGMsjn7?=
 =?us-ascii?Q?ccGVUUxCfHv1UDnOI0lXJBguYDMte5tADMjNiBG8vl/S8FQB3RBibKtyB/4S?=
 =?us-ascii?Q?odIDGGTLznFjt+Gidj63kBJu7W5c/V1lg9TkYtVz0A/vqUl2ugj6mZvEORSk?=
 =?us-ascii?Q?T+qqLN7lMCiPNLa4jN4QLhUlaI7BqeNjuDFMqpISwPzCqtfmyfetAma+ai7e?=
 =?us-ascii?Q?4kaHw65dfFRGN9ESeQK8uHIk9pGLRKmvmMRavot90KlL9kbp+7u7FWLAoE0A?=
 =?us-ascii?Q?Tym1mSxsnl5igmCQ3rm/wCpCg+LJcUxP2LVINN9LJKhvLNy7R7BttxqQqNKO?=
 =?us-ascii?Q?OeHxw7BQtd/gzXDLcUyH3B8ojpT22t219+WCCNfCt8HHaRH7uCe524ayA724?=
 =?us-ascii?Q?18YIJ9l6YFPbpRRIbEpnMLoSrjBMQgXxhYjIqZLus9KqoolzpgqsZ2GSj+BH?=
 =?us-ascii?Q?3ZRPMFQ+1bopOmQQz9K56WCnpajAsKr7qnUVXqP5g+uf5PTZMSaGsC7lRbQo?=
 =?us-ascii?Q?OD43nZ9OVCOgOPekGnL3vzQYcec91C1Z/unere2/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a9326b-cf08-4fbe-2532-08da7dc87bac
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2022 07:42:05.0499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: byLQ6RBK/WBNKlAbtkVHb4q+LSxggLL07ZORapCi/aMgGd8jp9Qh9Xz/GHbLjEKZgZM0x3P9zpZNVIKwVjfJFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4016
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series aims to add Freescale i.MX8qxp pixel link MSI bus support
by using the existing simple-pm-bus driver. A power domain and two input
clocks need to be enabled before the MSI bus accesses it's child devices,
which matches what a simple power-managed bus is(See simple-pm-bus.yaml).

Patch 1 enables/disables functional clock(s) as a bulk in the
simple-pm-bus driver when the simple-pm-bus is being power managed,
since the MSI bus takes the two input clocks as functional clocks.

Patch 2 adds dt-bindings for the MSI bus.

v3->v4:
* Drop patch 1 in v3, because simple-bus/simple-mfd devices probed by the
  simple-pm-bus driver should not be child nodes of simple-pm-bus at all,
  as simple-bus/simple-mfd's child devices PM operations cannot be propagated
  to simple-pm-bus. Those simple-bus/simple-mfd devices needs dedicated drivers.
* Drop unnecessary 'bus == NULL' check from simple_pm_bus_runtime_{suspend,resume}.
  for patch 1 in v4. (Geert)
* Add Geert's R-b tag on patch 1 in v4.
* Add child nodes in the example MSI bus node of the MSI bus dt-binding. (Krzysztof)

v2->v3:
* Add a pattern property to allow child nodes in the MSI bus dt-binding. (Rob)

v1->v2:
Address Krzysztof's comments on patch 3:
* Add a select to explicitly select the MSI bus dt-binding.
* List 'simple-pm-bus' explicitly as one item of compatible strings.
* Require compatible and reg properties.
* Put reg property just after compatible property in example.


Liu Ying (2):
  drivers: bus: simple-pm-bus: Use clocks
  dt-bindings: bus: Add Freescale i.MX8qxp pixel link MSI bus binding

 .../bus/fsl,imx8qxp-pixel-link-msi-bus.yaml   | 232 ++++++++++++++++++
 drivers/bus/simple-pm-bus.c                   |  48 ++++
 2 files changed, 280 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml

-- 
2.37.1

