Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D8F52804E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242617AbiEPI5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242379AbiEPI4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:56:11 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2100.outbound.protection.outlook.com [40.107.255.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BA2186DC;
        Mon, 16 May 2022 01:55:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mwqy5IIZDxyBhhg4rmzNpSIksntylzAtNuksxXeJgz6hFNAXaIXmrwAt13uNUevvFHlty6/koXqM7k8lMOe2rH4Z7cE0ViWDfQEw6KquqleB/2axErB+rZ6TivP7WFQi/fN+fkDj0J6sOv9ay5leTQAR0aafKj4ZnZfco7JkAuKzd79wVFAoxWSF9WudtBG5YNBTKueyprj2YpFj1nId4dTlRIfGjpVTEySVKnrVuzUDfrsgW6zuoWXeh89NggzdgIibysttFB4maUK/h2xGm0o/+dPiWwT06d3DWn4Jz7Z2upEO1Z4Asz73gh33h1JVgiq/9usbFftZU9YHGOYlaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cWt3Mgn3euvC4BErJddvMQusPjOT/gBLkGrFXleijQ=;
 b=ORwSyjPddYOQ2AKe9Ul5mVrMnAPdApEvAcSn/wlkHXmu2rWKEywPan/7Wh+/kNusxbpVDhiH6IRssKW8TyiHIatm5ew9rIQMAL8PMIRQDxdnO9VMCDNJdcArJYPuF8WTCc+SxG7FQveX4dgRmDXRhL9kQEmPsbpNKAnPoo73/0z6YwKWXkBKBsQnNfUDgeNifQ1kINCZFNfsiES+Fk0J7Sf5LOBCE1YShLJusLHnqMLpakAhAUcmGw7THz8U3Idox/q4ydq7UqKa4jMHT0PyzGY/n5WSxqJ01xof1GV4CC218CKu5ymLV8Zu6++yLXsngi3EopBvx17xnFRUj385aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cWt3Mgn3euvC4BErJddvMQusPjOT/gBLkGrFXleijQ=;
 b=Zyp3xD/LFmNtdEg4m08LTNMJyc181RpEw9yTx66X8CZQh77oQVESSBydINmNPo3/rb7tnJaJMQEis649ZIFUhI/N860MD5k+XHU6ixuFhaiZYzA1zvnbAAdk/IzK53x9Csco1nezNi5/3V+gNLI98TvMwnPRB0zvkoemEZv1hqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 TYZPR06MB4480.apcprd06.prod.outlook.com (2603:1096:400:72::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Mon, 16 May 2022 08:55:25 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ccb7:f612:80b2:64d5]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ccb7:f612:80b2:64d5%4]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 08:55:25 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wan Jiabing <wanjiabing@vivo.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: Remove unneeded NULL check before clk_disable_unprepare
Date:   Mon, 16 May 2022 16:55:09 +0800
Message-Id: <20220516085511.10679-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0064.apcprd03.prod.outlook.com
 (2603:1096:202:17::34) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3803665-50bf-43d0-002b-08da3719d181
X-MS-TrafficTypeDiagnostic: TYZPR06MB4480:EE_
X-Microsoft-Antispam-PRVS: <TYZPR06MB4480697C76F2DD3AC26C0867ABCF9@TYZPR06MB4480.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YkIAQ6v7E0+DzkiChAQsUEjGI8mT+5Lp//NbWW6lxWjS+Zi1WRodY270wGtsBHntOHom842VpWUtOUJqqvJB9JKj/9zYWQEV/yofK7aO4aL1gaeyre+nxsKODnqlFAfg6SqANGCb1KF9zk1D/gm71eeRkTyixLrK+P1Hm/oQcymHX+F5D4T/msNpNMYZdAgatbwPXpLHO30AaP8MrGRRR5n0BddsVhCc27ezXuB49Os7gr9QKWkkl2JwkPY8fdOVwhCPtqfnrNxQ4+LU8QFTFCanEGk4X1wgQ/GyqHfeB4DfPdg8EbO3dgDmHw6FBCShWOcMnhy4Q4wjZ+c01VIB0nxWQBSIROF5KSvvwtMQn1ZSHP1o8rg8Bit+nDLKeC9hpDEl2CXaUYInsDCaI9XqafR4GQ/cZjAqc2RCmeqDSp2z/W5FKc2GZkgBEwQYKnyH27WltsZTRchT1Zkl3Ium74bKriBBihzwyIP/Eel7I3MqpPUuYtE1BdoY3ddHnU9p2cBiQMLAHAlKnPzymWXa6P3h59S9cdngQ8yYU0wZ2KTWnUA21WoIaR4XF7SzcDqWTX5W9j2SBayWJd9bp2Gn7Ute2A7CUdxWV47MaGiJZr6I0UFPQQj25U6j3BUni5sTP2IIKhvo9YmRpCUaCxfEBE4U9rNf94krWKdn/0peTgd50bz/gn9SjuhPIM6JT3Lo0Y7Tx9sjITxUmAFdEzrFyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(86362001)(6486002)(6666004)(38100700002)(1076003)(2616005)(186003)(110136005)(83380400001)(66476007)(2906002)(52116002)(66946007)(508600001)(4744005)(38350700002)(8936002)(66556008)(26005)(8676002)(316002)(6512007)(36756003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NRLMcsxwS7rdGhpLtJsC1KTn3zfSpQAra0+esm5b2nfS4DWH+F5rkrkaZHTV?=
 =?us-ascii?Q?XXPWf+ZQYTHtBlRMt0mtryfjlhjvUd5dt6F16vNdPGZnMU0uY8qKkBjQ7OCv?=
 =?us-ascii?Q?zIL6yf4a0epCR9hV8G+kFLYZd2OwNks34kfTpFIGsn3nk7qok13uY9AZt3qQ?=
 =?us-ascii?Q?RmOSJwHsGJrxz9V6NY36pTtmLqJf18srVVm+8TG0Puy3lIz+yV5r1rCmlY83?=
 =?us-ascii?Q?ncp7jnhwn4q+Cd+sOC0608/cAyXHwUWCLZvf+1YcA1pAU+pH6vdb4QKBFD0M?=
 =?us-ascii?Q?pdsvnamzWlote7pEPE8vXEiBGchGaVUoauGdhtjZAiQ7J46PdxCIjCj//JpP?=
 =?us-ascii?Q?gWcRuvtmnXyys6emYNIy4Sn7X9uOtEtGqxfIk0m+Y6xajTgNqxqRs7u3b6jO?=
 =?us-ascii?Q?a4K3vB7x0yPoHenhLM2GDpoa1zxC7kpNGK62sMXqqaCHFvI7h6MjeXL3dsDd?=
 =?us-ascii?Q?Wz2thgAbiVNfRf8vLdrwaMOaRo3KStojGpyp6iGEtCSs7Ra3utAFkEVd+HfE?=
 =?us-ascii?Q?0IGOYYjWgrCyeqs9I9H/pSze+8I5CsOeGAo8tFv7wxiuEj5YUATo3B0pEMgS?=
 =?us-ascii?Q?RiCeYHPiy8F3mY2W4sWNuGol+ezOf+WNHevaJ/IR6T5qXEDh2iozHKBvIrFT?=
 =?us-ascii?Q?kwnPZZVRY8w/iQBFr/FHswJoYU8EvL2MqUPC6yeDq51FYxrkQMS3IRRimxB/?=
 =?us-ascii?Q?JR/0uZ3MeYOPgvZ8VRorb1ti5All/3W8UyNbFuKqICzcone9hcodFEZ3vfPJ?=
 =?us-ascii?Q?DvcjQ0ys0weYEa5zHuAHNVHmQ6Vasn49A2kyKd+H5Um0fUWxRo1cfSqN9q+I?=
 =?us-ascii?Q?djXiFyYrbrDQR+91zi7/joJOEu1Nuj9CatDsSt5lfeODBCtGPWBkyr7jgCVd?=
 =?us-ascii?Q?zvP8XKM1d3GWBTP9v3tWNAN2+ZcpX9dXosMF4zi4GfHk1iBHdoHU/H3Da/rs?=
 =?us-ascii?Q?FzbZ/6J9RQKG9FinbN8SEXroxmR895bGzz6nwwXSIhWyzxSgSIF6nLD6X08Y?=
 =?us-ascii?Q?Ptk1C8zt602TrPKz5IomjbavhaJCpCRM7ZgUjvuRX9QSoqyODed/bF1ahj/J?=
 =?us-ascii?Q?i8MMk4Y4zHp5/lxNlW8V9uqEyna9p4el/vKwyO0BSB+ljaV+GgWyNapg5V+K?=
 =?us-ascii?Q?7vRJHgufGHbSTum1rvqk005h5zNcc4pjdl1jeEark7CDBP8r7/Btk0k7jvNp?=
 =?us-ascii?Q?ljs1sjVRjvRdDo4n2vUpa/T8a1lddfItZQY9SxcKgErTTvycalGfvIgUedpN?=
 =?us-ascii?Q?bS+23DMfxCHuAtqbqgAa5yBMa5Q7x6m1+0pfg9iMY3cLfrCVGbV7kh+lazfe?=
 =?us-ascii?Q?08sbOU9JLea9iawdkSpz7ymHw7XpTn4jSJndqtry3NxlIGjW5oWWop2J5Pm9?=
 =?us-ascii?Q?6wIelTnEenOjlCWW8SZOFibBY4E636LamVemxloGZ4F1F+SystwOCdVzSBDf?=
 =?us-ascii?Q?dSDjGGuapmxkaKPf4bQ9YyiboRBtLbr1QTWLXK/Bcj0eladcaWkKK+XJx18l?=
 =?us-ascii?Q?FzWMCRPe+lFNUlPq/qafOzldFdaDaqi/NkxS2dS9MHB+onrcmuyiWB9mY69L?=
 =?us-ascii?Q?NUHdpPYL/o9AjfCTDDZTzQE5THdu8SprFhblQLVQY8PH/RAl2oSOVO5gu50H?=
 =?us-ascii?Q?+rPkrqEQKo8FX/Vm6wkCUFurdtj58Ny0mqYvqqEt6jsgrmyAhd26XL+qiNtK?=
 =?us-ascii?Q?0JoQJs4mk6xPGNt+Pv0Ol04eO+AFejS7dzci150dkf6oL61szi7emgIukv6f?=
 =?us-ascii?Q?FpNiKWBA/Q=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3803665-50bf-43d0-002b-08da3719d181
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 08:55:25.7292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GxEbDhph+6i0yqNlh1F90cHZfllXdw596E2Nfzcriju1pLz6oOYmIXJdzY4/llHb+kZ61mgYF+wa5fImiaiXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4480
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_disable_unprepare() already checks NULL by using IS_ERR_OR_NULL.
Remove unneeded NULL check for kp->clk.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/input/keyboard/bcm-keypad.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/bcm-keypad.c b/drivers/input/keyboard/bcm-keypad.c
index 2b771c3a5578..166d6023a538 100644
--- a/drivers/input/keyboard/bcm-keypad.c
+++ b/drivers/input/keyboard/bcm-keypad.c
@@ -183,8 +183,7 @@ static void bcm_kp_stop(const struct bcm_kp *kp)
 	writel(0xFFFFFFFF, kp->base + KPICR0_OFFSET);
 	writel(0xFFFFFFFF, kp->base + KPICR1_OFFSET);
 
-	if (kp->clk)
-		clk_disable_unprepare(kp->clk);
+	clk_disable_unprepare(kp->clk);
 }
 
 static int bcm_kp_open(struct input_dev *dev)
-- 
2.36.1

