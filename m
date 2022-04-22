Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233A950BC84
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357819AbiDVQFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiDVQFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:05:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2087.outbound.protection.outlook.com [40.92.21.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71275DE76;
        Fri, 22 Apr 2022 09:02:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0+Yp8Ny9YVpxVnasjO3MgUG/f/ZJMhmQPNYp9o9YLbbK46qQ3wna6xhoH+A3QHbLSuxEIkcyfpTUeVkIaC3W9iwaEZbQ4D15M4yRTMn/9NgDJf4+E7fwA5rma4LH0yPkunXbxoos1dq3WzrV3tWEDYuR+NAuaUa0w3aGigYjSzYOk+0+FBS3BiGbnupIbKB9eaIRx0mcA3kLGksA5LR+K+91djy/ygOl24gdO2h2L6ytQ8eZMrc962YVTW0GOkG4QJgdq3QNt+y0msP2Pl/NZNOJBgcClXBSkbi9RvhvkYDJaM4QYjBuS3aMWkjwtjaLj8kxl6A3xCev56HzeFA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lHADMAL0NkfusQGDXcw7p3Nxi7opqnAU8qpxK++s+M=;
 b=JrxvymA52Q/y/y9juqDLKgzqYRVdn/KRCDoTqaXr/toIvrRFu3iLQf5GsdwOqlfdFlSDzjAMkVymo8YDsxTYbgZaU3EnhV1kzLZcjr+Nc27PwWrH7R7jM8NuSaRgiFt4/+RccBjRbKhQE9qpo31e86WTUpuXHjO6d9eLpFY28BIzf307nWpGx21k8seNN3ab+YZu0YWOf2y0gf8U+CwpaglKEsuEqLRognlPF/pnthgsSGrUAfnmrxyP5k4QVzPU/uRzOOtqa97G2VkeWxPoM9OzJ7SNWvGmsRsDfVM7pwBflZsi0hz6OJ10jsWpdtr1nRj7a82bxFdhZdWUrZ6+8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lHADMAL0NkfusQGDXcw7p3Nxi7opqnAU8qpxK++s+M=;
 b=j+NdJsEk4JcPP+Ftc+mlSx1gyQ4Jmv6PCvqiN1nKNpkk+GhfwJinGRHRlAarI7X853UPfSyXYBQBWZ/kOARGDw7LdNjezbZa3Ph9H6R7O5WagjMLcD16gOwhEIA8q6HTV1zlc7bZFuZ1tHiMrdCGXAN6wW9o3lOax4YedqEMQGRZfpjsFnJMSGCD2rNWOdVaJFZlKBbGN/TN0Ls5/N0+AkNTaYmw4AODDOkzteW7WEaTFWbKkiUiDMb1fcNi9i5kuQeLG+Zmhu8k8PbBSxLi1gx4iVHoihor8TAlFUd9VqPNO6vHmeQmSgSmA3O5AeafXxel8XC5E0/J9+Efwhf5TA==
Received: from BYAPR20MB2472.namprd20.prod.outlook.com (2603:10b6:a03:155::16)
 by CY4PR2001MB1685.namprd20.prod.outlook.com (2603:10b6:910:68::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 16:02:44 +0000
Received: from BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3]) by BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 16:02:44 +0000
From:   icenowy@outlook.com
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 0/3] btrtl: try to use OF machine compatible as config postfix
Date:   Sat, 23 Apr 2022 00:02:28 +0800
Message-ID: <BYAPR20MB2472590CD7F6385C0E002763BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [S9Mp5eyF3vDnUHmlK9ml8yArgbO9NKlj]
X-ClientProxiedBy: HK2PR04CA0070.apcprd04.prod.outlook.com
 (2603:1096:202:15::14) To BYAPR20MB2472.namprd20.prod.outlook.com
 (2603:10b6:a03:155::16)
X-Microsoft-Original-Message-ID: <20220422160231.1072810-1-icenowy@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b947124e-01ef-45ba-3a7d-08da2479890f
X-MS-TrafficTypeDiagnostic: CY4PR2001MB1685:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D+pswPgHCa2AdIhOON7T4/mpAuMbJmtmIvsbh70hurqiCmTKXyvxiHz07VhWSoM6ctIiYY+2JCQczsnryxe3YeqCaLrlHRL06iySXJjsf+JaMsL98QP/sHUF31bkO8dH4ZAwFTz0uw64GcuNMsJ8a+idgiCYomPvgZ9Tv5Jqo/j3mi6tVQ0DByIOxXdS9q6rg7yRUxLAFzaVMn1/YIvWf3n0OMj6GjmWxu553G//Xrf5KSjuCll9zu9MA1w5vj/lE4yntDG+x4AxdKEksrleDW/M66uLhbahD/5yzB7rxgzmLGxOPRf7bnq15TdzA1NXJB+CoFdpU1hXrKgtJUdSElv9Q7DCs6iw0Fe0/wXGRcc0VMPB4ebjc8Hk4WCmR87DI37c8kAPFX+MpXxodyhWHDfzA6Fw2KiDihTbVfpC7iWz9oZyYGkbxHY9jPNwgxHL6xkhvd87ZR6ZocmGkLZ2Ji1ybPXeSiaeswHXq8CPvIoeYaWrMuKu4Pu+X2dG+P4m8jJpuaPKWTs6QfM9y3jwmNzf+Q60pSkG5+zJQ2c+egSyaphwMFHK1MG5WmmNMzOlb8gGj1LbG1VfOf3LdsCDHw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FrsArwEygSz8sIYG2HCz4QOEbqvB/Hq9xYG09z6nuUNWMSD31E095oZDTgKt?=
 =?us-ascii?Q?WaKmBRKbn5EcHbsoV/emZHoj+44/tgQ0Q7HjYkENGP/8t0/Zo30DTVw/PtDq?=
 =?us-ascii?Q?kzYNyq/QcRt209SsK4ebnXo027D3tMQKupub6mzgn4eea7ONKgLzw0q4yLay?=
 =?us-ascii?Q?6rZuXqHTcG1WdeEfTwjNf/ndn05vZz74v5LEduLqEScKDNgP9cbtKKlUyTNT?=
 =?us-ascii?Q?DzhSQ/B/Akv7w7Ny5h+sMFTlEz1e5iubUYE9oJGL7qCg04bBC1sdcC0+hS5U?=
 =?us-ascii?Q?2Sy+DVGSBaBOHYXg48Q0ODrTvQnlni5XZp02JMC8BYEctWIASOQf1H1tmVrb?=
 =?us-ascii?Q?eB6ugKxJjZ+/UnxYvbLcM+wwSGziCGSJMc4iRIbMFzNSH2h6cHZ8TpPqNitf?=
 =?us-ascii?Q?Kgj5AhDz0IvqPmGD1gFI4v9MlGxKcDPXNd8CyTDmFE+kw5wXqAhTeabNaSfa?=
 =?us-ascii?Q?8Vcgiptr4XSmdcf7AfUcL5qyHnAz0yP2uyFbuj5EKqVwrrpY0L8hmMaoij2h?=
 =?us-ascii?Q?ycgyUjnDpgUiN8C6zOptAXeZMNFmSY2u9faKHxyyBVtJntg5BP2mT2yRWzu1?=
 =?us-ascii?Q?9Up5SmrlPk3hFdhBDbRHKf6AQJemxiLuzkseAQn3LSijXwaYQr7NBsLXHC08?=
 =?us-ascii?Q?djXLYnU9mbCPL1iK8Orrj7/dOST+/uk5o1Lb2PqzJAYLU5pLh+lNAO6zK6jk?=
 =?us-ascii?Q?WhjdhYqesPUzHP1nboxfRgvuLwXk8YSeGwocPKS+O1dQrvYurT9awTvjyKPl?=
 =?us-ascii?Q?HKJc/Dz7bFvLaRIHCT/HwU8bRqLyqTLUxT25hy92D4cAYmaiExBPcQdASCtE?=
 =?us-ascii?Q?C23JRfOLtNSEo12B+o19o5Oq4fIEdt3IU+/+twPKnKkvX3TzoD7wu0fdINIo?=
 =?us-ascii?Q?5mGe4HTLG3d9IdUFa+pFzLPkNTDEXG5ZiuX1uCAVRMB6qd9uaXOBrTwxRVFt?=
 =?us-ascii?Q?/h2YoyIdLlXyvKtZ4hX6GQZDgRTb7/2WTClujl7obgtnraCm267wlcdnjJdL?=
 =?us-ascii?Q?YZSDf1u07w+N2cEWBYuA0KTsTLAbtx5fv7i7S1J38291Zm1iqvVD6er6LIqW?=
 =?us-ascii?Q?aStqeV7SMdm8iEE4je524qqUlPioOo/RjAmTK7rFm7ODIVSshL9qHONqDHL9?=
 =?us-ascii?Q?w6j/7/2D0eZE1tBmNdAYOLgtxtXZ4l79mWe4aoROtb7XMLcBtGicUkwWuzQY?=
 =?us-ascii?Q?FNEY0qDD9okAOatbe+O6Ty9wOnVqohJkVjpdAyS0bw4vurcgtO4PaaqnSoR6?=
 =?us-ascii?Q?YCL/YUkFG5n2JDdib7ZW67EkmhIhRyI/gVZ+m7V1ymCuBsMGdgncmQeRtMxr?=
 =?us-ascii?Q?t/DiOF4SPcDCZjom+4e1/cwnq/7KXNGaQFxerEhDoTLl+B70Mj9PyJBQkVH0?=
 =?us-ascii?Q?OjWx3WgBPUTRq6LM4+eEFDtyGYViepQktzWFKgzdbg8yown3UZ9JQnHAZO+X?=
 =?us-ascii?Q?Jbaf7s1hvJ4=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b947124e-01ef-45ba-3a7d-08da2479890f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2472.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 16:02:44.2184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2001MB1685
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

Currently for OF machines there's no way to specify a machine-specific
btrtl config file.

Try to use OF machine compatible string as config postfix, in a similar
manner with brcmfmac driver (which needs machine-specific config files
too).

Icenowy Zheng (3):
  Bluetooth: btrtl: try config w/o postfix if postfixed one failed to
    load
  Bluetooth: btrtl: use board DT compatible string as config postfix
  Bluetooth: btrtl: allow longer config file name

 drivers/bluetooth/btrtl.c  |  8 +++++++-
 drivers/bluetooth/hci_h5.c | 27 +++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.35.1

