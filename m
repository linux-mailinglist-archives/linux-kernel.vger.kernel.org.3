Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBFD518D57
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242026AbiECTqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240258AbiECTp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:45:57 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2110.outbound.protection.outlook.com [40.107.113.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAF722B22;
        Tue,  3 May 2022 12:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/w5v3cR/brmWC7JJKJsv2bBJ6tiW4F1U38vh+2r+RSUkCL4mpAkSye3FcPn1Aa7YorNW8OmN/FNqauo97dhMhzg/N3xOLFzXg0VzvK3su0v1SUyltgc6IPRtuwfk9D28KTNkTu5n7x6ZDh9llJfZJyPQYDf4IQjiT2BR39Jr3aHx2MEUXiQ9mfqY+jTh3KZ1wt78+DP/rn79DUbvUL4YxpC/M+5wwnrHLmQ27m8l4urwga7YXezZ1sdIHHOKoZ4vBb3e/+hrr3Yc3DU5bRT+4f1ykgD7mTfjVBZ2j00NJTLe0ZccKWpWIFAVelEKeDveR4geknOd0tkYXWrmWw6Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsoIgtx3dUDOKFyexVc5asUh0EBP7LBeZ9J4ePnmzTw=;
 b=fF30d22lQ+IU9UHWYdrPzm92uCqa5Pi3qt7SSe2wbAhrCyU4bs8q6CFOZmdcwfHXjKqjYJExMQ29dVJHLcfYNWofOZyqY+lsdut16kCFyvpeI0fpsKNCaQUW0ekTOI1bVSzmeNxETGobqI+RAf2pqFVu1jsq88IJHPnn8msWv8IczhZ8OLuvmarT7/lPlPCxvH2fAy+P9E3fNpkhZHqY/E0W8f1LrTpE4/FRSJTEhIch94bdfO+gtLst6xXSraf0p0Xn0qLRkWZP1UL1bsrfv/ZiskQj+BnzTCWs6T/suhwGe9hzpxNJNgE8WJweEuGpVwzoC7tu3t/wB9Gn6+1rqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsoIgtx3dUDOKFyexVc5asUh0EBP7LBeZ9J4ePnmzTw=;
 b=A+PZPiMGORddeZN62gHUKQXZ6y5Mqb2wCgKW7d++sQDD0tl4IMNcHWyBhnJa6rLsdHdOUBYjjax9ASz1agtKfiYiX0FBOHQvd7cZtS32Pb3zHbKAYACsS0CtRvE66MGABgCikIBvpJNjGdKPmgveTpUOwa/8/tt+QZOLBy7o5MM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com (2603:1096:604:5b::23)
 by OS3PR01MB8115.jpnprd01.prod.outlook.com (2603:1096:604:171::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 19:42:21 +0000
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::fdcb:b853:c0a7:8d58]) by OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::fdcb:b853:c0a7:8d58%4]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 19:42:20 +0000
From:   Alex Helms <alexander.helms.jy@renesas.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        alexander.helms.jy@renesas.com, michal.simek@xilinx.com
Subject: [PATCH 0/2] Renesas Versaclock7 Bindings and Clock Driver
Date:   Tue,  3 May 2022 12:41:59 -0700
Message-Id: <20220503194201.25714-1-alexander.helms.jy@renesas.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0374.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::19) To OSAPR01MB3892.jpnprd01.prod.outlook.com
 (2603:1096:604:5b::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af5e766f-4404-45cf-0f6d-08da2d3d0996
X-MS-TrafficTypeDiagnostic: OS3PR01MB8115:EE_
X-Microsoft-Antispam-PRVS: <OS3PR01MB8115B5363BDF127CC70E9F46C8C09@OS3PR01MB8115.jpnprd01.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Td2E62pB6UMjiE/29XRr+ukjxiF3ttt0fycxz7BULwkF4D7KN+pylTE7UhbXeQid2js6v0UyKEXKqhb/UWoVE6tQaI+hDnp+prLudwj8lD3nawr3AYV0WBgKC2h0mOnzQHnFhB8jD5iWohuxFGLz8wtspsWJ3LBgjm3Q4IsNZtNvTgv1vnrz98dzl46h9bpD/n+WkBqX0F0M39CRM0X24V1dd9kSQtHd5o0ORhsq2oMKl7yvtl8r1Kizo3tGrZtPT/2sCJmicI+5az/zbV7afaRxHaTkTinLH+c5wCV8z23OxjfC3pnCFKl+UGHKzDwvdc7wY77NyMLfn203aggjU3OBP/Dxwe5cuMai6sMAWv6NMvJKW/gnT1C8yej8TybYmh8D7OE6yA5gBvarh9YS9OWoJiefRvMl+vmi69syeU8mSlvKuqdODh3fPdRdUhzlYcfxAPYOtjM2D0DiBqvnvZ82X9qUyTWabHJuFh934fZ7LXBDmIILCDsLrdL3ymI0veqyBqlFMv/csmuVH4VkdBXMY3dSABqMXf6TFf6QSmuiCHQYPYxJJ4cm0eF1W/jDSy+qFJtTBk7OdzGveM7yS56ROFkAwRd2alwWTe2DI0ZeO70n5HY/cn97WTyW2cSWn+coxB7XFuOIkaRlvKyVKhN4CoOcAIO2mm05cjsAZBCL2rUkxfxtoW21i2iOkmx+59qyzdTasEA+kbTCt3idoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB3892.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(36756003)(2906002)(316002)(4744005)(6506007)(6666004)(1076003)(86362001)(52116002)(38100700002)(38350700002)(8936002)(103116003)(83380400001)(508600001)(5660300002)(66946007)(66556008)(66476007)(8676002)(2616005)(4326008)(6486002)(6512007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EUh62HJoGYgUOM1c2Q8HRsWKTbxlBGoyG5eVwCYiav/gsyLg5dQ9aiiYq1km?=
 =?us-ascii?Q?yxq+HmFKQFkDK0ZffSamYC/sTF4KMk52GFfPTSZ4XoQFO2adBTELpyjrbhVA?=
 =?us-ascii?Q?u21eyR+cvsTVNNRN/bBThzGsnjPB1+CZqrju6qA96U8o56adbTDvT5rrFLI3?=
 =?us-ascii?Q?yU59MKx2X3KCGDTILCv1766WI4/5UOT9C7gXTLjhtrb010b/d6ZUYKXbHT6E?=
 =?us-ascii?Q?8f+5+Q9wAFVTmsmchS6ENT6ndZfVB0ThS/VWv+kwRtkiVBXF46awnJclZhEQ?=
 =?us-ascii?Q?KAy8tiacjqe7yu5ZKP4huM0684qDCrxRqAuW4MmtCDP/oTpbu3zQxtkIVsJd?=
 =?us-ascii?Q?h2hcfWmgCk+99yrsxDX8NHyUYNNgnN867ML9MFpG3ufQG4h4sXQNZ88vU6eW?=
 =?us-ascii?Q?8jn2NCsPvbo3YA/fPl7sKlzxCs3LuxMS8H8fNSD/+HlBnAFgLJi6cTLXxRY3?=
 =?us-ascii?Q?hkmvofI7bY6I+uXA3uhOjHxS9yM6aY3cKMKOpgU+wY1Vj0Ky8LtSueyoDpru?=
 =?us-ascii?Q?4Mc58kcZYbcFfxI4iIbob9HKzJNu6Sm788bSYQtoAlqstBy0f+8zXd+HCqFE?=
 =?us-ascii?Q?tyy4iHRNTvEfoHwGqHIKujHjh36Ex4hHYM/jqs0V1bMNJqDhwiPf2ZGGNyXe?=
 =?us-ascii?Q?cKv1GhKQohu0cpPGA87L+mWzEXp+fkOQ6zwHD8+uJvgl01mmv3NeGxn4wDRd?=
 =?us-ascii?Q?CKldqZ+7L1gq2MfnvbV+pDB2cxa1xQRKo3EKhF72ABUA1V5tHLEH6y33tamS?=
 =?us-ascii?Q?JdpjY4SqDUpYDB0cuUnCxiEKbLNc5ENCMcFPbBrLm7+dcBfkz+qrPcIPsMIf?=
 =?us-ascii?Q?x7fCIsR2OPelu4C176RJkAhDTR6AetwwqKAdSF3lYPf4H0nOkqfWJ//vXUJC?=
 =?us-ascii?Q?oP68Pz1UUl6cgn8Qmqi9C1FltFoenb3m+3BZjrswjmOyKvxXIDLMssuOwXRf?=
 =?us-ascii?Q?xeNn2ngc6k48V1I6Kg4c3BOyUX9vUXuHOCvPgDjz1i5HeesQUsV4ooX9NRnX?=
 =?us-ascii?Q?7pdTgC3LYSIfBWLdJC0Domo5++BRh4rzXIoLWs5M2Z9HPMWAj4Ehq0tjsAMk?=
 =?us-ascii?Q?Ux3YMAqN+38ac+CMMk4t6j5J2hIJoUYuh8FBJBESLftJd3RROgzD0nvm+Q2m?=
 =?us-ascii?Q?trPNr3G6LTK7p9/0fLCbzgckPcR5uRhxzaibfLGk4ODDd0HWXQ+/L2x7BFx3?=
 =?us-ascii?Q?eGvFHJVaQaKkz9TB08cbVMeQzYq9m9QrCAWLhpp7MsJ3T90EmFA/uAEUCSEH?=
 =?us-ascii?Q?qDhZ8kpnkHjNpgbuqlgX/EbDrmDCTbjArJPHz136q8/BKrzlEBt5w+ijiA3D?=
 =?us-ascii?Q?KvQBTmKl51Nbb6mqGB0mMBGfSKZSIrPo/4bucaK5duBqK5Al2Rf1pgzL9Dg7?=
 =?us-ascii?Q?p8MzHia9h6NT2oTRzv8WDB2a8QXU5CKh+cDFiZz5nxgt2MGGV2ZNQWxeJate?=
 =?us-ascii?Q?2ImUjoPgC94/FKylZFqeqOgxHwrcLcZV8VNKYRBuAH7bsEje8F/p5Qf7qzrN?=
 =?us-ascii?Q?RPwM3uIyjfDvhlC26aLsm9nthX1oJ0EpSQZmgqjSAnAPJmIQ0FdlA3aaV1B6?=
 =?us-ascii?Q?oSMWJcn3wBhcJbu4J65TBSNt7wDm4XdjymhDoAEd5fi2J1ZTSAeC5yWXKR6H?=
 =?us-ascii?Q?lZwm1NCnboO6X11gRueikzzuOgK+LbFd7UfsPxZrCyH+2sMOc0aDwExrPXEc?=
 =?us-ascii?Q?eS6t1P/6z4dEZaYsbs4p9MfgkxOBtvOB1NjJmiFqDU84PAjJhfEuYsjUdbgp?=
 =?us-ascii?Q?dcZqGYwvGDKjymfYvPRg43fnebVbX537fXnlUZ9zlYdoYGKmKKSR?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5e766f-4404-45cf-0f6d-08da2d3d0996
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB3892.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 19:42:20.6243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNdb1DVRoZBB8X2z6eT727qKc88M/FYHnxKkLJewUwWklUUuNgR1ToDEJ5/aqXevOnSiJe+mswGMukWkX7znSP/+7NVsjUjw5wXIitTj6rY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8115
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree bindings and a common clock framework device driver
for the Renesas VersaClock7 clock generator family.

Alex Helms (2):
  dt-bindings: Renesas versaclock7 device tree bindings
  clk: Renesas versaclock7 ccf device driver

 .../bindings/clock/renesas,versaclock7.yaml   |   64 +
 MAINTAINERS                                   |    6 +
 drivers/clk/Kconfig                           |    9 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/clk-versaclock7.c                 | 1273 +++++++++++++++++
 5 files changed, 1353 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,versaclock7.yaml
 create mode 100644 drivers/clk/clk-versaclock7.c


base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.30.2

