Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489F0567CC1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 05:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiGFDsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 23:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiGFDsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:48:24 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150071.outbound.protection.outlook.com [40.107.15.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D82622292;
        Tue,  5 Jul 2022 20:46:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aP8e+Sz/yk4oxxN31QL4pLZPH7uaJMPK/97Za7ssz0+YBrmgpM3ZOecAigOwn1k9IzZPkLwrW019j3Y6YUn0Q8ctu36YJl8gcgQEIV2SX6yMSIAkm8eywzEV7s8yl8QayYq4VePi36/fRzCt1MprRPTftAZsvMjtYL34BUuxCYRrkLYiNwksDxUUt7bBa4rEulW+OIkVX/0OOJEM4s8nRjbKU7G3FB7PCX2SBWaogFyb5yUSTm1EGIPH0vaaSceTbHm0TFOYngn6LSR6ta+SbF4YX+cGel/CYhCKmKwnE7hDJfa5CH/lHXb2ykyML/XKxy79vSvziI9a8S0LV6TtAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFXfUmnGm5gmvqpJzrn/u5SkYgStRNlRnoPR0OAjFd4=;
 b=kkPcQYsohcChZyDxFa8w4GqHQ5FPN+nviTdPEeRGjWlD/wufvHEe2NBR5f27HZvsroWNHXbLedAUav6TqLicyX39WTGX4V9J2QQaX+8dQJVXK+Y91JQVNr9wGhPBCmOp8+N80HDxF98XudYYgkHH1ZQdsd4DIN/2OloxgTRQu2PyiwbBhPxV7djnlBjEIHkxykothjuzNuFWiDDjkyLI3JfewQeirzf+hS3yDf3sYc8z3Oyd4ucciH9S3PVgV2Q91ebs70gdigZnYKFntJmgbjcdFIfVA1Y2HDZ1Y/f9gzO4tL1vO2ghxYxoqSe1iF9/1I1xDFry0FDPu0S/SNsruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFXfUmnGm5gmvqpJzrn/u5SkYgStRNlRnoPR0OAjFd4=;
 b=EyBE6mKCN8MeSepbSpAUYFYYaQh0Y6lXugUDs5cKt6XXdJEvz/zQj1gMwtDHnCizTE42eqYJRDGkRtJx1xTiYfLM/eeMJMyVDGG7IcCVGW/8Vawc1xprMDVvIP5wB7JaldMYCBZmb4uuGj5owOVJhbsWeLUUUhuqFsGNl8r8+2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VE1PR04MB6463.eurprd04.prod.outlook.com (2603:10a6:803:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Wed, 6 Jul
 2022 03:46:33 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::416e:6e99:bac6:d3a9]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::416e:6e99:bac6:d3a9%5]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 03:46:33 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, krzysztof.kozlowski@linaro.org
Subject: [PATCH v4 0/3] phy: freescale: Add i.MX8qm Mixel LVDS PHY support
Date:   Wed,  6 Jul 2022 11:48:07 +0800
Message-Id: <20220706034810.2352641-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0045.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::14)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 899736fd-e570-435b-963b-08da5f021eaa
X-MS-TrafficTypeDiagnostic: VE1PR04MB6463:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ttDcFSXWsqLOSVyyPyDePTanjgzehWNNTNwGjAMjkSqt4bIqtf0OO1vvjNd/j3IE/0u13ts64zWfEKRHXhZpdEHYkIrb5LiQzc5NMLL2rmYm6v9o59nhRiDtnDUBO7jnSwT65LfQHbQG+NzB4YwxlcCGwwTU0JNCngdCXXEPnQ8bKcCdOpTjwAvaFuRThMx/sJUHoJahZh9YmbmXMNfd1RxNk5Yiul6KlkjBpDlzfZrDWYTKIxtdIf/MQ0cBPCSsav8K1zCdnSuvOig/gS5B4yl2KeQdB1+aT+CuLOzAfCdMrk/PrBUr5DeeOeftPamxv56Zxpfps47vp/d79P4Suw0tF49042/PXKjj4rGDGznv5yKwtN6ab3gWiwmreanNEtDd2QHQeaKWOlp2GOfw3fwl+SdlKMP9vriRkqK9pZ/4BuObwSXifj26LbyRWLD1JZ7lm3W8IdXShG3VAAdZFk/gyL8ZYWyPbqlGJ1HCCF2tGSN68PzWKiMWeqq66CVChRtQS05LfylRurDdtRK30cFZd7na1S5DodzLtrtbv7c+uInDdsCbqXacVVldtiJWphrAbrW6N1jAbHOJgfWWuoKXO3EPOorHJeho/N+I0O/5GmHMz1uUjtErpfX6WfLsVnSMbIi+7PHPsH+SR8IOKBqSlYqgaLqzINVbm0mbN5V6Fmk4XsK/loGgwLNAUzolI8VYRXOf2O+onhmYGe6ZuWpbyxSbw0msxmnz8d5dOztNaoanJQGFgV02P+MBJQODWAqSJZuJmcvbGgOceKq/BZP9aQH+RjfwfD5KcLevepbki/Ug5/3s593mG4uLT2m5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(1076003)(8936002)(6486002)(478600001)(86362001)(38100700002)(38350700002)(66946007)(4326008)(6512007)(8676002)(66476007)(66556008)(5660300002)(2616005)(7416002)(26005)(186003)(52116002)(36756003)(316002)(2906002)(6506007)(41300700001)(83380400001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b2lc3X4wNAxVhCtooHpCEZQQBLNjNb5/J1K9fHPPfVjYJvdXJXRMmSG7zi03?=
 =?us-ascii?Q?yD/QvQ1wOISX/ATL1HcPsPDmb2SmuF5zVs7z2ZTVE/+ajlMjWR9QjP0b/fet?=
 =?us-ascii?Q?BZCNHDCrwbXsCC549OlkShJ5xG4SZH5fjEXjBjjj/24WAD5Uov+DSAn/ZM7F?=
 =?us-ascii?Q?twBqaEpdVsZw+BiowE6YccvXSppw5Ry3DQ6Bl1sl7XiUinuSCQ6tmWfxFVsa?=
 =?us-ascii?Q?juRSqrf9bwGdbQZA+TGAay9cwGoJZGLG6qWQ6IXAj85KFC5ZgY0Or/NTDtWi?=
 =?us-ascii?Q?TOoeiAEO3rRYCoZbLPb5q9Y9xeuc9HiumkX5AjmIq9xcCh77wvTwy1t1pWLh?=
 =?us-ascii?Q?w3m30qZOZO3eFColjj2LZBwAMO7hkiK6gjxjKQwlQR7e3M9W5hzMf3U2Ae6Q?=
 =?us-ascii?Q?uYTZUBoAV381ATscQCyrVY6docJ4VyRO9YFoawU7+h3WVhoN01lXVF+Wkmzx?=
 =?us-ascii?Q?DNF7VF/Po6gd0WX1UHrKiBTwR8cqkC/YbO19OrtjchqEmHMFg9izMWUVDv/b?=
 =?us-ascii?Q?+g7/GguOfF/Z7l94bQfjgsaYnXDD3E92iNKsLN7yjBjhZMYxHiDq/iSIQBbz?=
 =?us-ascii?Q?I7UdHP8UPTr7sS9uyXi+IJJKkqxcQuAkDX0kCTVtX+DCf46TvJ8l3wdZC5PN?=
 =?us-ascii?Q?sZaRcQUDYzY40v8OLuYNbpWH3Z40mAlsvzxJhwGDsoMMwow5WZwgHPkMo+mr?=
 =?us-ascii?Q?EqiuT7u8ATCRGL4fDxzrZN9ZI7F8GDgE2NNz8a75X/gUL4lxeKiO+UH2QbYL?=
 =?us-ascii?Q?4vjW0vrlNtgtn80jODcF4sRQ0ZUYGZBClKsZl/Izqdm6zWdIQlVAlMy8j52o?=
 =?us-ascii?Q?b5CJ60ElXGbtxhVBAWASRM4gCOm/1/f0UZTzshqKC0RQnwK/RvfqqmgMeNLH?=
 =?us-ascii?Q?PVmrqR/M9aLgPuyxzIje7CB0yyDjQz6R6qoL227n0DdeBd88xEiog9yR78+c?=
 =?us-ascii?Q?8Zd3dlOaZ8ITfnw6KZ6w9FGOfRXarc3MGtA4YAT+rXEaZSlDdUZqebJOMyP9?=
 =?us-ascii?Q?rF7LMrpV5DSjW5n/WBA7h8CaBnYBhhODzrHNxbocks5GPToYv6thmlfznmJf?=
 =?us-ascii?Q?Y49bB281xEPDVWsIsmsjZ08R6N4mdVrzS3GIs8XvkeiUpXQbJOBZa47g0PoI?=
 =?us-ascii?Q?bPXt0Y5g6JAgYBTpEqwERKD/4R97Sp49II3BHqyYTLeQ5On6xbZgmBSJgh7m?=
 =?us-ascii?Q?1d2Sq1KPVcoPOGeidihL5TKnpRzXe307IRwwYe5TtYo9J+KCwWkD9Zjqcr2l?=
 =?us-ascii?Q?e+ezmeZRp8bn5fnvN5L+0nM1KVMaATymDRdEzd0sg1DeD8TR8qAxUV84p31/?=
 =?us-ascii?Q?LJIAXKjMx1vIYC4Mk3Wa0gudctzUAtcr81zx+LuIPpmS7C7fa3X+6Q42Ng3g?=
 =?us-ascii?Q?q8vicsD8k41sFur6w8sF9/S4iEI8RgDSHRgagYiX0t2qJ8rG8DkGgZrEeNK9?=
 =?us-ascii?Q?I/BbKqlkbOQW4PrzYEyvO0CbaeLXITDjJILsxZRFCJzr5tVXm1kc7C7w4zmG?=
 =?us-ascii?Q?PcmpF7/il0Sz2iU979GzywCYx25gtutQHWd7CYJAvoPRu4DedjiwrvxllpIe?=
 =?us-ascii?Q?YIuN14nwgMCPCdO5qV/T/LUuJnW8x7RpoABZVFy4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899736fd-e570-435b-963b-08da5f021eaa
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 03:46:33.6978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZYW/BRYKzTN8q2F7YolqtpDsb+UGrfuyuOoIG2ZnXUeuSefTVkyeDw/VD+W/OquYPna+MuEInv4uzJLFJaFJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6463
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

This series aims to add Freescale i.MX8qm LVDS PHY driver and dt-binding
support.

The PHY IP is from Mixel, Inc.
The PHY IP supports two LVDS PHYs, thus two LVDS channels.

Each LVDS PHY may work by itself to support a LVDS display device.

When two LVDS PHYs are enabled simultaneously, PHY configurations and reference
clock rate have to be the same since there is only one set of PHY registers.
In this case, the two LVDS PHYs are usually used to support a dual LVDS link
display device, one as master PHY and the other as slave PHY.

Patch 1/3 adds vendor prefix for the PHY IP vendor 'Mixel, Inc.'.
Patch 2/3 adds dt-binding for the PHY IP.
Patch 3/3 adds PHY driver support.

v3->v4:
* Use MEGA macro in patch 3/3. (Vinod)
* Check slave phy in ->power_off() and power off two phy synchronously
  in patch 3/3 when necessary. (Vinod)
* Use single line for error message in patch 3/3. (Vinod)
* Use pm_runtime_resume_and_get() instead of pm_runtime_get_sync()
  in patch 3/3. (Vinod)

v2->v3:
* Add Krzysztof's A-b tag on patch 1/3.
* Change compatible string from 'mixel,lvds-phy' to
  'mixel,28fdsoi-lvds-1250-8ch-tx-pll' in patch 1/3. (Krzysztof)
* Rename dt-binding file to 'fsl,imx8qm-lvds-phy.yaml'. (Krzysztof)

v1->v2:
* Document vendor prefix for the PHY IP vendor 'Mixel, Inc.'. (Krzysztof)
* Set fsl,imx8qm-lvds-phy' and 'mixel,lvds-phy' as compatible's enum. (Krzysztof)
* Skip 'clock-names' property. (Krzysztof)
* Drop 'This patch' from commit messages. (Krzysztof)
* Make dev_err_probe() function calls as one-liners. (Krzysztof)
* Drop unnecessary debug messages. (Krzysztof)


Liu Ying (3):
  dt-bindings: vendor-prefixes: Add prefix for Mixel, Inc.
  dt-bindings: phy: Add Freescale i.MX8qm Mixel LVDS PHY binding
  phy: freescale: Add i.MX8qm Mixel LVDS PHY support

 .../bindings/phy/fsl,imx8qm-lvds-phy.yaml     |  61 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/phy/freescale/Kconfig                 |   9 +
 drivers/phy/freescale/Makefile                |   1 +
 .../phy/freescale/phy-fsl-imx8qm-lvds-phy.c   | 450 ++++++++++++++++++
 5 files changed, 523 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8qm-lvds-phy.yaml
 create mode 100644 drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c

-- 
2.25.1

