Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4451A48EF06
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243745AbiANRJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:09:56 -0500
Received: from mail-eopbgr130041.outbound.protection.outlook.com ([40.107.13.41]:64900
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243679AbiANRJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:09:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3OgfCkAlPisJXahlj4kRFxiqJwWYYdRjNf7Fz+ll8eNh5P5WMKSyDe0ECtZ6ICD9NdU1Ja1R5q0uIqXPfKBgNDakogM6KFPds6437uD0F3bMw6KC5B88o/wMfprfCtJ8yFGX5Hul/GrSX95UyvSFh/CbMvxozC3jLnLvuw0wGZNSNi21tPdY4qXdm+2COMAlVGpNEzlaYxCYqxxiqjwDnYABBBCKZ+7kf3PwlrWxXLdDuAMU/mNA2Zt1rdk9TAA3xSXiRzD5DcXtH6eVoRYzryxh9WWOA/jWQDwh4tFb5IgTmlUECf0J9PDsGHeRGN4YkUMtIl15bgPlY1qvKkKxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqGrAWTfB88k3uJAmNxmAYDqRJy8Hv3f/fj7MPp5ri8=;
 b=OEGWA0Ag5f/7ImPpInLaR5kGiwURqjN0iQ1GJvoyynKMsO1UuDDPVdL+kZ2yXJtKGFRTyNDp+o+LScomLXoelJfCN/nbBTO96myzw1ukE7ROZGJcepebl+3TAhTSrs4P0KURy7AXX2ICu7iLu7pOyfsGjgi5t650hGpBoj5lT02jtPEkUiB4x5k5uKj4ip0j1pQr4ZqEBHB9o6vAMZrGC0Twh6BtkyWISXUPFDL47Ei17bz7Lh7z7PDOq77nITcCqdzxhoAOAAx2JE/tI1fO7VNYLS35bnvB07bExKojFqCUMsL3AfLQqxyKDUJTwsXCAQH6EgEHKChQQ8NuNobGYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqGrAWTfB88k3uJAmNxmAYDqRJy8Hv3f/fj7MPp5ri8=;
 b=OySjldCowxxSIcvqXCmM653KoAkn9d5HtpDHukvMErDKenxPBujkOkIHdei7ZmQw83d/NhTfrhl8E01UQDSfftY1Wjuo6n5gcng+IAAt8YpAR4H2OKroQQ3E4kk7/xpNKdFSmahnw6sPJiZIEQhalInrcVJz00wYQAJXpXW2cfM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from AM0PR03MB4514.eurprd03.prod.outlook.com (2603:10a6:208:d0::10)
 by AM9PR03MB7742.eurprd03.prod.outlook.com (2603:10a6:20b:3dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 17:09:53 +0000
Received: from AM0PR03MB4514.eurprd03.prod.outlook.com
 ([fe80::6183:d478:82e7:bbe8]) by AM0PR03MB4514.eurprd03.prod.outlook.com
 ([fe80::6183:d478:82e7:bbe8%5]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 17:09:53 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 0/4] usb: phy: generic: Support enabling/disabling VBUS
Date:   Fri, 14 Jan 2022 12:09:37 -0500
Message-Id: <20220114170941.800068-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0072.prod.exchangelabs.com
 (2603:10b6:208:25::49) To AM0PR03MB4514.eurprd03.prod.outlook.com
 (2603:10a6:208:d0::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67518cdb-a370-42d0-d796-08d9d780ae21
X-MS-TrafficTypeDiagnostic: AM9PR03MB7742:EE_
X-Microsoft-Antispam-PRVS: <AM9PR03MB7742B92C8F7551911525195496549@AM9PR03MB7742.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oc/0ypzprGh3KmTE0wI+85dXj85nGAdTP1hytqfwpgqawQ0YnyUuVMgXjm7wUOHE/7A6fDfPD4HwK4lmtUdNr/xNT9CfLmE3v9RwRqKbyDF6Kz3npzJJM4QXkncQ42mVPxAukDlE2vHmgPV5RCZjIXGiHctRbQ8yYXW5H6uy4dMIPpVXbYg+3eXocnGszdO7qNlxorXqJIr98Z8Bd2VEMPt25s5qyVjBJeGqiZGZZft6zV77ePwxt5lrIObwSCRz5QmJQDcg93uUrv32YbuCHXSUGTFckGDzIKkvX1yu6GzCjof75oP/wz9D/7QFfJpdJbS7xXkRqhFMFtQhq49SncxorK+l+GjHthSiyDB1Ni3lEyaKPQ8w4Vjn1qEw4WPnZ2WxydUDqgL78sXhzuxogHdos4Bz2ruShBklZxNeabxXdznHNRD6LpXzTi2DdZ2CKWP5GPalYilGtBPQub2ArBX8SoRAVeA5WCOcgQ8qQStcedUN30/RcFE0ng4u0QTOfE1SCKBsrPlQ8SGJt0tdW0RmN2/PGDmXcPLrdp0QIpBoUEOiHnSwpWP1ui5k0yXROjBwHl7+ShjLPOqk3tLUn2hKqmXNZ+KFqEc2ZpX8GWZHgcV3XN9+j16YlzHl9ZIKeyn4rnE2gxyDCODaM/faCND39CMiFcX7XmV5tkPdVpyp8dRvinoIexWdrmxW2xv0ynUbzeNfdCY3tHnHtS2JoeUxAOonCZ+dCUs8/MycP0JKLRd7wL2EZjTpxIdH9MJ1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR03MB4514.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(316002)(186003)(2906002)(508600001)(26005)(5660300002)(1076003)(2616005)(38100700002)(38350700002)(4744005)(6512007)(6486002)(4326008)(36756003)(83380400001)(66556008)(66476007)(8936002)(66946007)(6506007)(52116002)(6666004)(54906003)(8676002)(44832011)(41533002)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mBIuov9Is5qnVydC3anIokH5N1+SqUndCbrfbZIVtqN7BNE9u2Sttv4XIW0x?=
 =?us-ascii?Q?rQ2HO/6uzfKDvSKdYMwgnrsvMV4bCxLIR3r6yoyvWnPk9Oa0FG8umvzcFAhQ?=
 =?us-ascii?Q?L837nQPUlUyA11vHuo2Ogc4pGxJuNAxGNGwVQChTOew3an1DVs+37JxhV2Zk?=
 =?us-ascii?Q?UMfoljj7t/7BpXMFw3dC4sZJQl7G+1ENFmSFcedE2dOBRqKyOya4JoTmWXUO?=
 =?us-ascii?Q?U1trEoJocAveZwLMskNbrbPCa5qXgMtrG20wUdc+8iPVfTk5BLzLA0EBvek+?=
 =?us-ascii?Q?Sx91msBqJ3IG5ZrhxfQJ4HO0M/vgUdkMFbp9yZNTJu3MB2PREburvWBAd9JC?=
 =?us-ascii?Q?jetZYe5pc0juYwbjP8tXifFXfnU8GKXvSBhcQONqaHNM7xgNUrBIES8HYHrl?=
 =?us-ascii?Q?AZqo4k/2OksH5AFnZHBgrNQUlAnC1gkYN+b1X5msQmHfF1xV1Iu2WzfNdUkU?=
 =?us-ascii?Q?fLjcL3w4s0CD798HTg2iry8lUsXQdaAhNs7w3FbjmMo5ffNYmYjit+LHHEHU?=
 =?us-ascii?Q?mauNUvFQgZZuKcHtOVb5CvmGqGqj4Ga16ShNMxVk6bc/jbM6iysiXOf8sPN1?=
 =?us-ascii?Q?ZqiVJ4GzYHoFW3AC2e6+k2mUhKMSPDRV7TJMlZlC9d+MY6GPoOwZVJeKti6O?=
 =?us-ascii?Q?iFmIXCRoYHjdTOGucnzXba31mVqPWJrXJmP20cR/Zi/8Xvz9GLzCgx7vkQE5?=
 =?us-ascii?Q?1WyxGVs40zwtDCa0LmeT3zrQYifRWv+HLUpuZy2O7rqQq4IRFrEMVOVWG5sO?=
 =?us-ascii?Q?fRRvT9xlGw4SDtPJyOiKYEi9cunwmsmL+anjagJLkXNQ/5wcLClL9yoFdeDH?=
 =?us-ascii?Q?PYSGVxOurADf62u4Vg/kciv3+xr+8BsBlMJhd3i099FWFi3+adOKitGEwtaJ?=
 =?us-ascii?Q?RFbRZJJFPxjDiG3gldhdxb5/65fjO2cn/cap/EAgPFI+THPROWiqWnqcx4wl?=
 =?us-ascii?Q?Rj7pX/V1H54k/MTTTjvlTz76KJw33BFtpny8eTDHnMKzgzq1iGrUZKFxRAej?=
 =?us-ascii?Q?jDdG52hh3RZMPRvk+KOUCDSgDvw4IQVlNooqJ/jkM8ff2KMqiF1u3I1TusnP?=
 =?us-ascii?Q?NMwqwJIpKLzxz9oQTLKtRGOQwYt4+MangfLyFSnGg65MgySS1ivNXKLZLYFX?=
 =?us-ascii?Q?dPwheXxtsA3QNE8ctIq+wqHgvU4j5LMfHxI7CPVyu1EvDelAd3HIScohYpIv?=
 =?us-ascii?Q?OZf7jlxYI10hXG5vzYIqsXSfCz8D3TpBSjiJj6aWKUEAHN1fdV/5A/uqa/fU?=
 =?us-ascii?Q?jV2RXoCQ2F1TYY/+T/4tpCAKyrgwNSlSiIeEwF2HgbF2+rjtNjrXWCAMLIr3?=
 =?us-ascii?Q?k0xlyPD8sg/ROXy0PEfLQr79ikZazDqvk8lF0ggnTXyGBqc9lKvjvPbthVd4?=
 =?us-ascii?Q?x9kQMi6mxgxse98Feigmr5DW71F8+DBOTak1OeE8nZPkg47/B2qphhFmnC/T?=
 =?us-ascii?Q?8ZAGAnniAI+26ATjHAcZR1w7DRqWaqpL5o6l9xNS1MomRspV/2stAuBvwB0l?=
 =?us-ascii?Q?8anKJHMEnbygLi0fZSXu4LY+w1eUDTCyWMt/6aVbihUwkrGeb18DLwrYhJ84?=
 =?us-ascii?Q?92j0lns8JveOEUyw+D3ShZvZA4FW9vcKttf3nlX4fZwoSu04iflm9MlPYRFX?=
 =?us-ascii?Q?BGt36AKuL3VU1F0BF3BHOaM=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67518cdb-a370-42d0-d796-08d9d780ae21
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB4514.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 17:09:52.9374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PAlz/in8/njYCN6nRutpqGskKTGroF5jmc3C3PRB/ZTaeSCx6p/SPha0GDoG1Pg06bXVrM14r6wtIoXsbXvFdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7742
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic USB phy has had VBUS-related code for a long time, but it
has always been broken, since the regulator was never gotten from the
device tree. However, the support itself seems not very useful, since
e.g.  usb_phy_vbus_on/off has no users and usb_phy_set_power is only
used by gadgets to make sure they don't draw too much current. Instead,
use the VBUS regulator to implement otg_set_vbus, which is called from
several drivers. This results in a change in semantics of VBUS, but
since support was always broken I don't think this will have any affect.


Sean Anderson (4):
  dt-bindings: usb: usb-nop-xceiv: Repurpose vbus-regulator
  usb: phy: generic: Get the vbus supply
  usb: phy: generic: Implement otg->set_vbus
  usb: phy: generic: Disable vbus on removal

 .../bindings/usb/usb-nop-xceiv.yaml           |  8 +--
 drivers/usb/phy/phy-generic.c                 | 55 +++++++++----------
 2 files changed, 31 insertions(+), 32 deletions(-)

-- 
2.25.1

