Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F2857B64F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbiGTM10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbiGTM1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:27:20 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2056.outbound.protection.outlook.com [40.92.99.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985606112E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:27:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0/dOCJknMob3tf34Gd8oTH9vO7VvbLu1SN2lXG3PUNW8uiH9kVQvSd/qCX6DfLTAh5RNg2Mnz9bMhtF3RUAGLkwjO0Z4lS32nWLvHp2bYhgJlcYbASxHSEmVGXbLpvI4Dzftj4Ky4Lf3lWfV3JoRho7K5R5nL+7dhFpDx8I3VGP/SSWSWBCFL67U28QWC0W9FNA0ozxyukr3mOOB3KzSks0JLmdPFohPB9VmFLkRlrWjHJg/01qZnuf3Po9rx/od3vAe4DAShIY1YF+tkutJE2xyptPxEo5w11TOjPBp1vsXa6Z1yflwTQyv90kJWJo2+/oP2XnCEbvx1+bSRGAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zvc4oN4BJBsuapqiwdYnMUdaf4KhCHNMYoJrbsoLYLg=;
 b=EpNnwtR6zRfVzgVGVdj/p9OU6wR6hgJ03EFyb7aJdt+iK8uwlRw9cGOwKmNvBegAcu7kX+q+b5RFmvG8q12Xy4Yo/xzHyJqBcOopMvZiN+G6lOaJFtrPbDWFhC4kXZDxfT9uvg3liwAsncoQsidAt++ljza4gKx1EA2miIrpv1Gssgv2XQQNjbl3Iq2Xhh93ARy4g4LEeFvSy/QBPoITk9bKEaYoLOnVrm98d61owvg+jtdWAuNANqn+anlqT3jLfu+g7/SYFzDXiuV9+ks9DvPoEbI4e3V/GF2ZQSG6zS0FrUaEfYOYBH1blTnpE+bLZwgjfiuYnf/w0hUUhzasWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zvc4oN4BJBsuapqiwdYnMUdaf4KhCHNMYoJrbsoLYLg=;
 b=uBgULhBozxmum2vayeAC6PckzyQR69QpOGfqXnV3j0rWCy/3V1gJk14/lExbpAH0wJS9apmPc/UBJnM2DKrbDHGeCSUD6P5BWRlA8J9pGFMFYshHcAXGsJVf8QB1QdcpzbUOtLcj8481OsMNeiCZeXnRxq+4xh4/FyRlSKwK+Gu+KDBRXdREMzehwEvN8m9YMmnJwlmUvTbsYBp1dSrYdaLBFxniEdnTbbNExrqVz+ZqWUjeFvTExxegKQrFCOTYvcZZLvCwo73CI9Z98SObPOunT05GGUqzBUQJomnQcvSPFGA9BHZju9SBNJDYMKDG0c5JwIAOrHzJOeslm8UD/Q==
Received: from TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:ff::9) by
 TY3P286MB2818.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:253::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.15; Wed, 20 Jul 2022 12:27:17 +0000
Received: from TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2143:ec0d:667b:2175]) by TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2143:ec0d:667b:2175%7]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 12:27:17 +0000
From:   pngliu@hotmail.com
To:     jan.kiszka@siemens.com, kbingham@kernel.org
Cc:     linux-kernel@vger.kernel.org, Peng Liu <liupeng17@lenovo.com>
Subject: [PATCH 1/3] scripts/gdb: fix lx-timerlist for struct timequeue_head change
Date:   Wed, 20 Jul 2022 20:27:09 +0800
Message-ID: <TYYP286MB17634911E6C6951ACD128342C68E9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [2lg6QRRE4At4iNuTA12O0q0SH1PW+n9GQtpbO6v16ngcyu12GuuEkhL/vUNUXKuu]
X-ClientProxiedBy: SG2PR02CA0126.apcprd02.prod.outlook.com
 (2603:1096:4:188::11) To TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:ff::9)
X-Microsoft-Original-Message-ID: <20220720122711.6174-1-pngliu@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2497d35-63f9-4516-1753-08da6a4b2eed
X-MS-TrafficTypeDiagnostic: TY3P286MB2818:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ea8as4ofjAwKmmBG+kOhpJg40/SmHvXJ3jBN50iL+xUXss03VgSUpqSS/T7IXQtqAqO/gpGxkOmPiTrSbkBERUa86oG0cuvVHNiGtXkgbohMOtPXREqVFlTDvMdMGd/xfNaPirdYwysHrvi56ng91u0kqk2pZ/jwpHZ92ZZyOYD2lE9UgIk1gYld0CPzMf2EAIp2taYFZ832K5jkM5jGj1zAGAef/vZEVOK2OdCI8+RaWuMbgKqhOJCTqZ77IEsIY1RroURx+B6c9XZQmAzDV0Q5D+itjM1R/koggz1tLo9mPXJLINAUJYpIVs8I90DvE/yLnkMBhdDOveMEgWQt/ch7PwCZM/qHAfAAYgpbcC0WUzbjuCSLPfzkFCWOvpeAkMH10vQKoC3lWMAEq4EY/qnC+wNUImBZqRGsVGT+P4e6HlAcPMKjqFkTTNbh2o7Y0VfCKxYsPH3f8oFhSN2xU79Ntt3pTHIplLnNiMtUYnVAxvypRvfoHOKURXJaSs05oBpxCz6KGRFYRORNLm9HrF9XFO5M55n892D121BSSvEa8XeVmqvHAjXJ4Df+pdFTBvT+fXsJuiR2nU8QbRz6zQCe5b3dITXmicRhMnZm8aRWjMkaXuq4WE4UOLqAFHxDXDOCEeYrvFcENQGW1Q4zQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U1TrGrvy9KDjIWE4UtM9S/ytd7vo5/6SX4WK4GkrX7R5744D7oF6AXUlLZ7S?=
 =?us-ascii?Q?xKeJtfPuzToV/STxzAraNdKxD9BTb1LotkA9LLXc4JJIAKSytKa+BF5zc1WM?=
 =?us-ascii?Q?5nSGMNPpsXovqDgadcj/n7sG/5AI+Brnb9fIBleVCAt7meeaTnf8GX/pN1+r?=
 =?us-ascii?Q?+vxXgBzXcGHmS9xI+Ogf04goIeW2Vhg6nHMQYbKADxsRRI9kCNFfusXRHBTo?=
 =?us-ascii?Q?T0MRi8IND5FlVR9sEV2+aEm+tQHnmtTBa4RWAfMkVFWQvKrgT+I8os4VmTUs?=
 =?us-ascii?Q?G52g7QWb5fk6knQzYffKv0tgOdd9JurhpquRKP4RgsMT1CO13J32ar/BAhT9?=
 =?us-ascii?Q?ggY6u9obCxF2qkqsN6OEdmvucAph7LLbD0Q8dD6GaBX6zLaDg3EcniTQrqpM?=
 =?us-ascii?Q?A1GQbtEK2zZLiwFiNaqciwONJEJVBlkJbLVU5wF6OXFqdFGiVr0Qszk9cHpr?=
 =?us-ascii?Q?ek0YM48BxdfiJoM5Uzvp+ZFCB361P22dy4pAvvxzUQWjuUiZvA721CX62SQz?=
 =?us-ascii?Q?D8+McTdUp9d3B0hYRvzmyKreKfn22zQ/208lJ/ivqGPAGaZ2YKdgJbTFTTwa?=
 =?us-ascii?Q?otv5NlttDCU+iaUIYdktWiLI/MYi2x8Jz/HOoGJSa+ySBFP3iZViJ4+6vbAc?=
 =?us-ascii?Q?BzdYbCswxg0JjzPMeYkFs3mrd3j/ukMli9szBhZHLr8TuT83q9/hHc0D2qwN?=
 =?us-ascii?Q?rqbgmjJCr2EBfhsoiK9Br5an3D1jN9D5AiEbBv8MgKOp0Erzi2CsboKKPa+m?=
 =?us-ascii?Q?CRoIzdWrFGGnKdMvpZpqVSl20eR8XJ/nQCLX19w4wGv6LE5kur/2m99eA6pE?=
 =?us-ascii?Q?bfCHWGGx5M5OI6LQ22bK42v5PSHxEFAcLygCfaB06sOdjOtQybU1scS5yJof?=
 =?us-ascii?Q?EMRy+ga+UmZPZ+i02CANPo8Dm+/AmcEv9hDwkVKzBMYIAstNylQmNg2IbxAr?=
 =?us-ascii?Q?gbLP5hyzFCMyXcC2RyDQrhA9LgAvU7ZTq18IKG/TO5ODTN32M08I4uW06bRj?=
 =?us-ascii?Q?LrsZxT/MWzsT7tagG51GkeczxOlMCr5zQwjJDxCbP4Cdzd652ZqnKjmseGDc?=
 =?us-ascii?Q?3exNrZWP9zEqDxKAIsU4/TsW2Xp9fziTbs+yJEMia0OtT6Fv5xOKdOWqAvIK?=
 =?us-ascii?Q?I64dogXXU+J08+gIimDNPYIz+Tf+J5804BSkD/WA3xna+D9jpAg4E5r3BugC?=
 =?us-ascii?Q?i9z0LASe/XrW8o8JymN0fJxStWp1dqoh+4ohOcfqi3hRA1bPeiRx6BVfN3EM?=
 =?us-ascii?Q?Z2/ECGym3PTcYUKgJzsiR8T56/1lf/y+F0mBXdTv3b34HetyQMlwT/im5lAI?=
 =?us-ascii?Q?quKciHvs3fc7qxPCD2C2P2Jhlfa97c574t24bMxu/YtK7w=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b2497d35-63f9-4516-1753-08da6a4b2eed
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 12:27:17.1736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2818
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Liu <liupeng17@lenovo.com>

commit 511885d7061e ("lib/timerqueue: Rely on rbtree semantics for next
timer") changed struct timerqueue_head, and so print_active_timers()
should be changed accordingly with its way to interpret the structure.

Signed-off-by: Peng Liu <liupeng17@lenovo.com>
---
 scripts/gdb/linux/timerlist.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
index 071d0dd5a634..44e39dc3eb64 100644
--- a/scripts/gdb/linux/timerlist.py
+++ b/scripts/gdb/linux/timerlist.py
@@ -43,8 +43,7 @@ def print_timer(rb_node, idx):
 
 
 def print_active_timers(base):
-    curr = base['active']['next']['node']
-    curr = curr.address.cast(rbtree.rb_node_type.get_type().pointer())
+    curr = base['active']['rb_root']['rb_leftmost']
     idx = 0
     while curr:
         yield print_timer(curr, idx)
-- 
2.25.1

