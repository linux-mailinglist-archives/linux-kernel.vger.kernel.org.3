Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF85158A0CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240064AbiHDSub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239742AbiHDSuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:50:24 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60045.outbound.protection.outlook.com [40.107.6.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622CE140AC;
        Thu,  4 Aug 2022 11:50:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3Eu2hY1CQmS/3W1sFQWC6tIsjjspiTjkNogdEupgji5EWEtp3GdUwdx+z5cdubPDWz+sR7PDBK8Hj0lXFSNVRR8ver/x/02EdVk/Q/D1iGMv9aMYxZ7ipQuuVgkXdSHDBg97PGAYRxPn+9XcW0wevvC/8cZNuCpqcRa2T3OJOQVpPP28AS3tVJ97hwN5Bk103kGijtpF7J2wyc0xNPAVSZOy/aX+4A/X72tvHfvPFc2bZkeSL8t++eUWmjEldYxOQrD3hg2Ra6uAZwmiC4Q93/T1d7ZztJPJ7HrscABX34HKmF2fNHZwRu+6vniR7N39FJFlsU/gNLsy4kDBruTNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8m9ahOf+UEw5rIF5UfTdjyZuRFhKVV+ngALzJ0Ou6hs=;
 b=h7Afzl5rFaIjZ4mYckEGfKoHIcJENJD4BAt13znXZa/wBH/EPDQEsxNaJFxrmz1M2OBZgtxrNTwTBeceZUw8+36dbZrpj3Catyx5Y/kgFP9M5BU4cXTGNAPgSxXUOluAd7pvTpUPcwH+71cLFZ8EbHgnW3W5VNin23otytuBT4nUNPY78n3jXnhYd5UeZBxHeCv9YGIbCmCBWJVmggyccvVvJFKy2nR6LNhgO/NqKgJbl2OF11Ce1JdKiwR9lKwamu9itpjYe8j5onJNH+KeW/ZqtsSDN42wmOdBu0I+mtQHM57aB1o6mL+/5zkA6DgNXEaTqIkPWQkQVeDeBVI0+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8m9ahOf+UEw5rIF5UfTdjyZuRFhKVV+ngALzJ0Ou6hs=;
 b=YBUB+l15njP/h4ptaMSJef2682ZhGTUi4n/zfvTchHVPEXhVkQJj+xL+Nj5b6mW4jXHYZk+w+aG2BC+M+TB8xF5eC4ClVvdr34KPxvKtqLRb+7oRtwj+/QXeI/VIrcea1P3Ll2N1eBn4LFsD2F1DjfytJlCv0OY3Pfh8XJHyk1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by AM6PR04MB3992.eurprd04.prod.outlook.com (2603:10a6:209:50::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Thu, 4 Aug
 2022 18:50:18 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5504.015; Thu, 4 Aug 2022
 18:50:17 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v1 0/3]  Add IMX8 SCU GPIO support
Date:   Thu,  4 Aug 2022 13:49:05 -0500
Message-Id: <20220804184908.470216-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:208:335::8) To AM9PR04MB8274.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2375a47-7ac8-4cbe-6fb3-08da764a2cbc
X-MS-TrafficTypeDiagnostic: AM6PR04MB3992:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QH3m0cJH0OXIjsjaJ2ftzCS4zuk/yvh2FO/VmlnyykLBLnSapD7FwyM+4W/bALh5tNKOOQGmGXPwgh1dvGbSTpoUN7WW+93hRhwio1sgJXmcc3veM9cj0PCucnvJjxAfUZD0jWiMK1MyNSfCxxJNtxsL0ilJouMaxpRom93KOsiie2/Rf5tAA5KKEWgJx9yCILNijr/0HniBwypZAnywfCCnhpR3O+xMmseb1VcC85ybNPjAD9JzTi0RmWkBrpJ2viuvM3BiaL943Ya/y5mnc27xMOGGFk2js81v9fArn2o9F+y8X3P/YFo2m/A7yfmWWhB1+wJGwGlu8BDq55tWo/EsIPWkBV6gtgJalY3tDiX7WumG+4vVLKjfMe4gfUzXI4gQ8xAugLvw9ewTPt/qSR9lF1fFyt9lTIUMU8EjN5g3CYPXiUqEHSDCwHVr+UjcQXYSFagcOWL4RxqMTN43oJ5UAgDBj0j8zcm/SR/cIbHGHJUaKki8Ybsq/mBlj310Bcu2jAwPr3rZmlyESy0eXdAT5EcRcbI1mxpU5+mREATVe+FMB/eRb3l1CiYLmGxneAl0nypWf0mcn8L+XxcS8AEn9/vS6bbh2YQgLdw+pkPBB2ZEVNKGJo7EYo1Ci80pqnSOGFNeQpYK+aAkL6tIJihmiKRmMlYpRA8D7h5cBaqu/6BU3nW+nXaEGDJ0taddbk8M3E4wA6UtkjwsYB5/JcpbSLiu2x/S0DTyiNOR6m+naOqtAf18DLB3YYxUbzNf20dUwV8SucCIfoNgUf29uzC90j3WqDYZkFZS0BgfFO4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(2906002)(6636002)(36756003)(4326008)(8676002)(66946007)(38100700002)(66556008)(8936002)(316002)(66476007)(6486002)(38350700002)(6666004)(86362001)(52116002)(478600001)(6506007)(55236004)(26005)(6512007)(41300700001)(7416002)(5660300002)(44832011)(4744005)(2616005)(186003)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JA9GHAU9Be71mZfdkZX8eT1+304+q1ZsuuMC24cdP3CcMR3UgyDQa1Li4zs6?=
 =?us-ascii?Q?xPVaatq8pULlKzGhplHKLEWzU5PSPbkjhFTBLGMM1JrJZzStMY6NYvt3QNV2?=
 =?us-ascii?Q?7UqtbZvHrTG2IaMnpG0G2r69ArKR8Uq0ND9OW1ctuBad9SWhJ5i/a4wkcmsx?=
 =?us-ascii?Q?6Mfrwa+jhR8hPZLP4msLf/fMNq6mWsu1e/dMMpgF+jxIJzeGRS18N14ua4AJ?=
 =?us-ascii?Q?A8mwrOdytpKN4XXGlMQvXCFLbR2/Au9YmSJv/oW30yWrmFSGxJslgsa5fYiw?=
 =?us-ascii?Q?SyGVzZzu8a2BLFt0yZnvDdiorDKMNCaVzg3kDOJ1hypdn5Jw99ctT1zf2HzP?=
 =?us-ascii?Q?vYaigNQCCExnv1lG22pRmRPTQNpLje9NWMhJDbbO+2XNsCH3467H4UdadhqI?=
 =?us-ascii?Q?v8wUIxSRYYR7U4nts+qNmikUok8oUT3Ea+Ii/Xj0Fk3qYscHmKAIA/QGK1d4?=
 =?us-ascii?Q?cb+LH93JKkJwUEne/xg8N3q0nQhcKM/TDWZ/iiev9L/+oPJ8g0tXt6uM5F6B?=
 =?us-ascii?Q?QcmJTpicnJxzIUMjCbm16RVDHHE9/5dtsAx2vxmbg389jUH8bcUmExDW/2Vq?=
 =?us-ascii?Q?CF4upm2IwT/Q858AX79Frz2v+Kpis3KCOA4sGt5/U8Ms4o+MHpaz+iHZCGt8?=
 =?us-ascii?Q?Z3jpB9qVMT+Uxv3p5bimjFQbaOdbHSrj2GnTuJQXmoSNfexuimrUbnk0aiVR?=
 =?us-ascii?Q?Rkqe7CRbuQsGMCW7KBZuTJuPuOo1NGt7CFtp68iNXGfKVTdPCU4DgQrCZTRL?=
 =?us-ascii?Q?ueor2yM1mJl+QDqkT3UztHidcjZIk+7rfUTTK5snvW8yOhAL8s993cmNFODW?=
 =?us-ascii?Q?MePLf9m/Zlw4g0eRFfU+uOfMou+0ZR5WwtlFgMYfZNso9t2uXe8WEdtDxStC?=
 =?us-ascii?Q?1oUzSxWN3RkB+P1JUwxJMykfCLoXV8OLfJpvgBWUaz13LMBExiClWxVuWxih?=
 =?us-ascii?Q?96MSnJ1id5rRt0l5+3g6Pjk7pGKiJ4+Aihw/bSdgHZBFNcqMcYHPDULQ1yu5?=
 =?us-ascii?Q?kpBu3SqIHKflxC3W85nvASKJmCfvvLfAxONUuTSHPlq3eX+IavFrfe41aunL?=
 =?us-ascii?Q?TJXKQjn4h+0tqBpdDary6uCWBD3VHhsoUvFBKtJsBcO8QFjPQd4Gx+oRMNho?=
 =?us-ascii?Q?IAZTYOXAq6HULS1gAXcoSkG7d2m0N+D7SigV+nNWRWo4/287o2MklHhIhzz1?=
 =?us-ascii?Q?zdxvcFJf5yMLFFYSKebNqIUHnbhQm5To6qYWZEgUg7lCvZLRvNdKfsuc1jxt?=
 =?us-ascii?Q?iZuP4Ml7fipc0rGVrRMwwYTW7EGj4Afm3PJjCmCKvVyKmWYntYSR5H87yLPa?=
 =?us-ascii?Q?5aZtwS3EH7WFX7Kpi0WzJd8OdxR7odHxZInYUgPKVmWWxzPBZ9xN2LAP8u5p?=
 =?us-ascii?Q?wsrVOVw2Fq3LHnQUDB93dYXti0YrZYDVHQnHOnfmSkAjbAQ5MN6KR07dOAQ+?=
 =?us-ascii?Q?aWwCRubBuuxr9hnTU6Ozp9PWNVBf/Mk+VGNsIbYO5BNOfnmrVoCiZd0bnNSr?=
 =?us-ascii?Q?d9WsD8ByAkEI8Pm0PxIQ37IAWEPc98dbR8+Do5eNkw7RCuYd4NIvkJ9iC1WF?=
 =?us-ascii?Q?Nqj6Ecf6Sn6Ur5A+GXtP0CLH9W9V/0Hi3NqGucTl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2375a47-7ac8-4cbe-6fb3-08da764a2cbc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 18:50:17.7956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AqP8YQKesZd1+MDcRxWVAT2DSSV8La2ekNBpUZtRzsCuU6kUTIwUxVhgcLbRi9U/o8PdFRK8kqk1earQjPBtKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB3992
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The system controller (SCU) is the central unit to manage the resources
on i.MX8 platforms. The SCU firmware provides a set of APIs to access
the GPIO PINs on the SCU domain.

This patch series implements the standard GPIO driver over the SCU
firmware APIs, so that the GPIOs on the SCU domain could be accessed
like a local GPIO PINs.

Shenwei Wang (3):
  dt-bindings: gpio: Add imx-scu gpio driver bindings
  dt-bindings: firmware: imx: Add imx-scu gpio node
  firmware: imx: add imx-scu GPIO driver

 .../devicetree/bindings/firmware/fsl,scu.yaml |   5 +
 .../bindings/gpio/fsl,imx8-scu-gpio.yaml      |  39 +++++
 drivers/firmware/imx/Kconfig                  |   6 +
 drivers/firmware/imx/Makefile                 |   1 +
 drivers/firmware/imx/imx-scu-gpio.c           | 139 ++++++++++++++++++
 5 files changed, 190 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/fsl,imx8-scu-gpio.yaml
 create mode 100644 drivers/firmware/imx/imx-scu-gpio.c

--
2.25.1

