Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537564D3CD5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbiCIWWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiCIWWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:22:19 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2252120E8A;
        Wed,  9 Mar 2022 14:21:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XC9hQD0jzrgssBe+MXFMHmE2hWCaOXXox9Iijh6bBjp02JapMYnYCTaFs7AGAKN3MQR6eppb/Hiy2D0Sk9Go0PQBgW6whYDw5cTGNY/OpU5m8fVUzH+sIE0Uxl1bKQSTei4C3PR6EHtGT3CjmZqSuFGo/VcCzS5cfkLyKUF3vRWsqJYkRO1VxLOr5eC11mhmjXoWWTt1QL6FxHkpHhP09bfXNkqOMLw7B2zazvdgP9NR8VOHJ57kek2dduHXJqFg6TfiF04Vvv6nMdfQ1dA5wPM+/qZgU/kKl38A1kv6yMXzeg3pRp/L2g6liNjXlHn+bcWnvFVcSedXAZKDeCZ/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5vzNBko19lu2quE4GjOiE2sP9B8LtWxZfar3qx5CKg=;
 b=kYkPB5SM46NTCjWtCye+KXVvJ6xS9IWBm3DwF8QMlEQDXg5nes3QITm8mZ9qScPu1kSVKYxT/TW1mloENOQ/i83+APRGoslQ0Ltx0T6ULf0ubU1hxgCWhjZDLGNkYYThV+Pm9lYB2HhhE8ULtJkl/zTZeljplIp00aQJg+1UkICTF4ha6GZSP5hUuLZNx4SfWXKSjwmI5X+BiIRoLjSUbfwVjxsdEtrIobuw7B6zDmHhk0xMHfhomOLXsY4Sqj4NrNn2DUDboKY77KMdgPtrLIFFaTDy36lfkvMT8rR0SET+Blb5DLll5ns5ke4pTv8btCaNMhGNTyA8shFdBf2qcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5vzNBko19lu2quE4GjOiE2sP9B8LtWxZfar3qx5CKg=;
 b=fhvr3qf45aLeCTOwFzjp8RxQ2mT2JYL4uBKXQjkjE0SVifjm5hFUIhVjahQWpRieQuOL7cujj7fQ9X+eu0DmJc/0CDV6hSpCh4Vjt38E3tl3jsYw6h5oz5B5Vd41CXGyEAB+S0wOE/J0F4dybWqoOvPSLbLZ9/ujjz3YjxOHAmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB4512.eurprd04.prod.outlook.com (2603:10a6:803:69::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Wed, 9 Mar
 2022 22:21:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 22:21:15 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com
Subject: [PATCH V3 0/2] remoteproc: support self recovery
Date:   Thu, 10 Mar 2022 07:01:26 +0800
Message-Id: <20220309230128.15856-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83fbbd83-a238-47b5-deb8-08da021b200b
X-MS-TrafficTypeDiagnostic: VI1PR04MB4512:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB45122AD65EFB41D8D77DB54EC90A9@VI1PR04MB4512.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YYXDg7tMnhZb6Uz4AYbh6D8J1IrLqLVXHJB05xmz4D/mDsvfYxLQ7+jfgAcoTp4gBnJaqlbTDoy6rUU+dnMF8kOeY7HL+A7sPYJR0qiBheqhZVn3CI49F53eTDkgEFTmlneiFYowR6pus//xcQeVAEY/f9fcihG76SLSNHmn5w5jTLJFWHLaRzK1gnYTeE9HltZCsa64t1JtyFE3udsCbd4BZ38FpqoVFoBZD42j2ARyNjevcI6nccU4s61xeQ4oW+SqmGr9KVILVS0Qgy9Jno9s4fSoVq+hZny9gGen7FOJ47rx1HHS7yhEm9cI4mmjvevv4y77/FOrB0QWFQ17aDXbVKQip/ovTik1vUkJFZ9oqnVE/XupI35mi7/arp89EvxwY8LyBmHwqZKyNLxYCcX816I6b5c/xqF6kzU/fQCpv2YAMpX44JAYT9CNwgAa4XzzyKZSp2hc259ib20+yDVmxEjAHlvd4EsUQpa3RvJo/AgzR9QvY5EWjT3VuuUgQ3aBg6u3bfBGhA+rOQ3VvcbMohAKTSNUUu0QbHSqixGdWSBRjAVF1Fq51/XxQ+eL/sowKFah3kuucZbFz0daH10WxUz54fsku6mEGFpkn+gKMkxmZ9MLZgxjlNUx2gvi51fl7T9DuYMsFBGZ9UTPg5gVBIhx1nXNWWW8Nh5OylqGFHCKv10V8b8ZLtT9y/Rwj4+pca1k63KTOw5vZhnsshBL8VMG7pafoptpOUqeZwE7rBZRrD07wUaynTAtiNcaflk0FVdAj6SvOTzkSU9nPj0UPVhuq0qrOvumhVfNv4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(8936002)(2906002)(6512007)(83380400001)(2616005)(26005)(1076003)(186003)(66946007)(66556008)(966005)(508600001)(6666004)(6506007)(66476007)(6486002)(4326008)(52116002)(8676002)(86362001)(38100700002)(316002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g0VbIKf9mtxzkGspzTCoYUHuDRHmBVrHe32gBuBedRP0j1AqqqeTNAm5j9jR?=
 =?us-ascii?Q?CN1dJpG7UOxAWWn+clzEkIfDbl4saqxCLPTy3zXIADT4/QiSketGl3wOWURe?=
 =?us-ascii?Q?b6y8Piv6toE42+anSb1QGqIC1LKgaiK8Avm3DkVDP/LuhHtqn1mLLN5wfxIy?=
 =?us-ascii?Q?P2s5I+B65HP06KqAiG11eLC64ohIJlqqRRrXurcIMKkh+jcpcEDeg0hXHFBL?=
 =?us-ascii?Q?blkCkfV18nZXtmt/KeNPPZGAx/qf0HxXrNLqXrlR6y5kHQD1Uoe3tFT8lUda?=
 =?us-ascii?Q?7QuxKqXxValZWKVsAbzUtEhubtlAsciB+8BAcNCkBmaOTgl12VEplDsR0G28?=
 =?us-ascii?Q?TbXXds/5GoEvL6Y7xqj+FVEPfmK1NGwBR8W08pq15CaJLnTdOE2/j6iwiieg?=
 =?us-ascii?Q?er3GoIf6t4fILfWAr3kkFidiup5S0hClrz1a5kSQDNSEa/qOBTqqNepI9Nyg?=
 =?us-ascii?Q?JNwLhDCPulHk41bdbwAbg7SAWZIYo+FlfhuUM83eZH3GyM5+Hngugzr6sym8?=
 =?us-ascii?Q?o+aC+6pbXMR661tYRheqN4VIP1bxSAVaXB5rtvzTrG/T0h2iENalBOnqBaiD?=
 =?us-ascii?Q?pkfwHPPcfMuimEPOmHovdw0zm9K5Fj03S98EhPnx5Ssn25g0eAK/AXZeWXVo?=
 =?us-ascii?Q?8s0VvUSqkiCxWuV8hpyfiYB/ckGZ0dltVJ2ZzpT8KpUIokVJmR8JUbgwNv1/?=
 =?us-ascii?Q?a+BQmHmrS6nf0Azs31W9y6FN5+qiq3a5byamBzWQZLqjphNE+0UTcOiYJG1/?=
 =?us-ascii?Q?b+L9+PyRJS2VFRK2RFjfWUZ5q32WweUAa+SPVKgBAAJvf7Bu/ucPZYg+xgHc?=
 =?us-ascii?Q?UhNocHDgti5HR/hPmUxZV4+aWVJKIW1MsF1mZi//5UXbEz0g/H4RRkhP4p8K?=
 =?us-ascii?Q?rR5ojoNnpgri2Q1VYjpaoC93gbwh4jk9wdTDLy9lO0gy3cbE+lISOHgYsnxG?=
 =?us-ascii?Q?I5M3JL36euphgnxLUmh9swJZcnJMloqRJQRgqHgknm4jmy7sqe3V2pxFdjFm?=
 =?us-ascii?Q?vay2CsIlky4HFDU6xSR2qFuYAbhvYAeTYPD4UFyS6ObMc12ksn+jW2Bobydl?=
 =?us-ascii?Q?0PrYVaI+dukU7v4xLSQK4tJzeQubiTt/RYtdk5aMJA7tvasPN7swsRNjiY+7?=
 =?us-ascii?Q?wzQbEapWATErp688mvKrqu5V/CAGl6G2tho3lqW1NAy0+p7ChEy9Vo5e8GJs?=
 =?us-ascii?Q?qjj1D0ECrJH0tED/BVXzS8tRGhI2DVfMh2qtjNdC973wnmJrDq1/TftmxZeu?=
 =?us-ascii?Q?y/plz1F7tYN4vz/Ds6UU1wwa4os/xWNTdeoLOAVk62fhUYFatk7uLHjn2IUO?=
 =?us-ascii?Q?hRqXGVOf8LWmG/e6NxCje+pS1MdGIMGfKv/27QZnI7NmZ//D0Ev611lqn/VQ?=
 =?us-ascii?Q?1H2vwo03TdvW5eEAEaDVJkR4c+8Tp8kpJL0S8SW06wAjDY6zP20zMWOkMcDU?=
 =?us-ascii?Q?Bbv4/ooMhvNXmYsa8AGbQzeaAQPUL9+e46TUvULxBmyof0PLHm95Q1gLmJi6?=
 =?us-ascii?Q?Nl1H4lxuGss8sqktVsrnze9jBk2Ab0wHXNSLQuJg5aebyraNiZHEcJkwvEJw?=
 =?us-ascii?Q?I4l6vbEGaKQkE4CcFKERBreUPbrxq6NyPgGZHRJPv93Jo31b+2hZHGJRL7WS?=
 =?us-ascii?Q?SzNJAKDP8itIBzLzjBJEFes=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83fbbd83-a238-47b5-deb8-08da021b200b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 22:21:15.5430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3e0Gym3c17eVVvMJP1qnC88fPeX+pk3SSwequZ0Mx7AxUtYJY1R6iZWGKwjBS5EL4zN0VqwYmt9LTVkviPeYDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4512
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V3:
 Resend the wrong labeled patchset
 https://patchwork.kernel.org/project/linux-remoteproc/list/?series=621311

 Write a cover-letter
 To i.MX8QM/QXP, they have a M4 core self-recovery capability without
 Linux loading firmware. The self recovery is done by
 SCU(System Control Unit). Current remoteproc framework only support Linux
 help recovery remote processor(stop, loading firmware, start). This
 patchset is support remote processor self recovery(attach recovery).

 In order to avoid introducing a new variable(bool support_self_recovery),
 patch 1 introduce a new function, rproc_has_feature to make code easy to
 extend, cleaner, such as we could move "bool has_iommu" to
 rproc_has_feature(rproc, RPROC_FEAT_IOMMU).

 Patch 2 is introduce a new function rproc_attach_recovery for
 self recovery, the original logic move to rproc_firmware_recovery meaning
 needs linux to help recovery.

 V2-version 2:
 https://patchwork.kernel.org/project/linux-remoteproc/list/?series=621311
 Introduce rproc_has_feature

 V2-version 1:
 https://patchwork.kernel.org/project/linux-remoteproc/patch/20220126085120.3397450-1-peng.fan@oss.nxp.com/
 Nothing change in V2.
 Only move this patch out from
 https://patchwork.kernel.org/project/linux-remoteproc/list/?series=604364

Peng Fan (2):
  remoteproc: introduce rproc features
  remoteproc: support attach recovery after rproc crash

 drivers/remoteproc/remoteproc_core.c | 67 ++++++++++++++++++++--------
 include/linux/remoteproc.h           | 18 ++++++++
 2 files changed, 66 insertions(+), 19 deletions(-)

-- 
2.30.0

