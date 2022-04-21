Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65DA50A796
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391062AbiDUSAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391025AbiDUSAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:00:07 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFFC45AEE;
        Thu, 21 Apr 2022 10:57:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5nzZiXsLb21MAiA/JmCFiaDzTJ8ZePZfEY07U+9OD+kkBQqbC3bzFkzuo4HwitRmvnJgAfGDLiput2DyHescjloVlNyj68BDgO3QiDBF+ss3JKBCDCuvfmDgiak3kIECrOdQR2McXtFcDAEMWtQOPi6W2BLEHfd1pPbznXXxi6RonlnvHM00bhDYgtDkVAWvYw1FLsHINhojQK7Pz698k8+4el6cM1Ga5RTkXB0p+1uGeZ9F+s7luyVTPzB89J6/AbnZYG2VW+eROUpA0IdhFGY5H0vkCYIm9HD//R3AeB2ExFwgkLGTb4oxxHRz8qJ9JbJSQmmnrCXzwdIcg+Kwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8dAOtQlsdq4WVwLRPZWXOubavicTI4K16PvfjTUV+s=;
 b=ay2lakjymFOZqN0rKRCius6A8SIJzSBBjgL7oQBz+Jhspj9Cf3MCRfZgjMVfLPGf7g040oG8t/tKPz/5AHQo+ud/NJPF4B5nLtAwrySySTfwjz80R3Vn/gEBoqcrDgETSpMZbW7+Uy/Knoiw08anSwLJKOXfeR2Pm807GYc94qWNJqvtevIJNklBV4RqmHTlXlNY++KtP2YaJ1iOVswbvNOdzWz9F2VmM4a+Ad5YsV3qAPXVmCSy7YfmqItCu3iYKURoM60frda+xF/kQkgh3sqlpyrEz3W3fsjHsLJxkGrV6IJY4CXk+IU7UzXNxiH8gZZ56De2CT2iiEHT5YpGRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8dAOtQlsdq4WVwLRPZWXOubavicTI4K16PvfjTUV+s=;
 b=ei6De5QLtlopJycIOP/VglK5CvCnfRkosRrbGY03KcMHyOUzNuO70yDc5N1zQ58dqF3jCbaNEqx7wRrSZKBiRPFAyNROo9Uem0DodlGj8eO8fETVyaF+vBfunFS0EEsOkdHeZGIA2UI25I3Eck7ZsZ3+yk+dTh6PknVVxPkUsKkWN9vI3083F5VEO4NPGEiSXBD7+obcWSvEX6FAqRumLUZorpoKSxCfDR4ho+9o5VMTTDxHIRkWL9ZdcnPtq8DJQyO1I3xiTC/EfPRNOp9GBNzXBzEZ97iCMYvQj054RaOGA6APjX56F2XNgmYCvqjKnTmmFdgrKzb8gMul6oFY7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AS8PR03MB8101.eurprd03.prod.outlook.com (2603:10a6:20b:444::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 21 Apr
 2022 17:57:15 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 17:57:15 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 4/8] dt-bindings: nvmem: sfp: Add compatible binding for TA 2.1 SFPs
Date:   Thu, 21 Apr 2022 13:56:53 -0400
Message-Id: <20220421175657.1259024-5-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220421175657.1259024-1-sean.anderson@seco.com>
References: <20220421175657.1259024-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:208:32e::10) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f30ccfd-3c6d-4164-a2cd-08da23c05e99
X-MS-TrafficTypeDiagnostic: AS8PR03MB8101:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB810105D8FC0C3B1A0984919B96F49@AS8PR03MB8101.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 15FjbG9idPCxMW2qbVK4IKa9T8aWgQjivF5ZIUvI0aNMxlxr8zAzR4Fej2JhA7MaxwtrclmIJM2kWIIgX7As46pZYijBPJ8Q46AHJQXjwLfmw8V4pb32IrHnO3riAMC+YK68WyA6ReKN7ZrePuBdv2RvW+GW2qpFigBDrzh/2Hw7vepERHQyMyu5RFkFMLnT+YB28lrGryrYD3sjdflTCcwkvyAIzsTeKDApk7P8fIJNgc0qOwd5Dv1jOpTfXWoyRiEq0SmVKQVOtIH409s0dQs5ck8d31x+PuRkD7aviw7YI2nywNMJHon6Z+F1H5dx7j6wXjf9UVhvhthbic+cDxLO8Cj+XhkeSdmPFKa9kLoiIPml/R8nu7P7KKHU1EcLD4JfU2u3xYXfQawEU18td9LsLzZSzqsHsf6tAp+kvR4ecgKppWakjBfn1PJWurQ6OZWi000k5mZrz1Ijgm/vVGYM01PU5MjrNFOs+v0WbQVWg8P1Fgr48X216IQ2uf8x7KH8nvV0Iw5D5JHh1qM9Jcd5dDuCiVCh7N3G8N/V6n3YmCFSscFz3bmuGKruwg6DuQZ6D5vdkogYKS6pwIIPsBoQEdabCTMaSm++lhyRrylSknrAtZK3jB9ivlsAydU8uvHc/eIFUOBHHR0C0tNROBlVf5KS01JOUu9Br2vGAZfpeYouE/OLzfc/kcDzuVOBdBz6lMpBXzd/8/06XjPcfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(52116002)(86362001)(6512007)(2616005)(5660300002)(44832011)(6666004)(2906002)(26005)(1076003)(107886003)(8936002)(54906003)(186003)(38100700002)(38350700002)(508600001)(36756003)(6486002)(316002)(8676002)(4326008)(66476007)(66946007)(66556008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5tvFAXJwwDyRKwFpcKy1k+u9gHjjC7v9N7hNZb52b8eoHbD8trLjshLhvfJB?=
 =?us-ascii?Q?LJ1MmIPc3GWllPZ74IaEMOL7CFCrzJsoDdsqzTTYMlyswiPb6ISz1BMX1rB0?=
 =?us-ascii?Q?4U0dfmA5QBLS0HkNetmVDxHFBWTu9Y1giZdEwomYN46onSeA9eEV3GNbxKV4?=
 =?us-ascii?Q?/dXGUzoQhE8QsWZBjrdPUzzKzpq1EtwFVvxZusUw8/O3xHcJMmu4fvLkSQwF?=
 =?us-ascii?Q?9hzYDAwIhsjFzCvcwVHoVvlK8yINk6/neOKk70eBk2+hp6RpB8DaZQixlnsY?=
 =?us-ascii?Q?pWXdOje50T7opbReBFE7RA5KmEYaKFkenLbsbjPe2AimCkX7pahOYAN6liXX?=
 =?us-ascii?Q?+Ij308q1LXOkC5nUp/g/urXtl8wuRRr8ELrEFS/+l/DZ6bf3AgxNBMvM5oTo?=
 =?us-ascii?Q?t/Sl+5OgV5gukCee3S+Eco6dr5rrWZHXZigYnBmS9OKj/3sjorhbfImFuuLG?=
 =?us-ascii?Q?ZI1WmqaWhImtMwCGn/4QQFJ8sfGkdoQpw1BLhkao0U++M5WwrWwAOKXoCho2?=
 =?us-ascii?Q?6IZ3lpgaaB3Lc81dngT7vQHwvB5ruCLOHQAfQLiPerY/UbZKlCYU9ZDdLRpj?=
 =?us-ascii?Q?0qi1VBSTVjug1Xsq0/ik6izSxlsBTXdzxq7H7RfStsuPC+xSpfP33v8CT4xw?=
 =?us-ascii?Q?jtYWOh0x3T5VsOeBc3fdpV2bZQdhBo6W+F/OmwXhgnW78eCIHZ3UXmxMW1mu?=
 =?us-ascii?Q?5Z/MNxRwheZYjjkKY3jT8zx/t/yYRlFvSuFYwLR+8ldX2QAxMzb5l5yoo60b?=
 =?us-ascii?Q?Zz/3VPhb/iwsQV2X2G593wjHa/kvcirDPFI7F5CKgcm9ll/LcvoA/CVDqILM?=
 =?us-ascii?Q?+arVthsWQCRLtZupMdaiUnZ1Hpdt93NR08BAkuy12+OzMnJWFhXGyXQW0W1g?=
 =?us-ascii?Q?ahAIRE+m5mM2h0r069oLpHSi6/Yi2hExvODBWCqp7HpROuR5eRA454sk/FKT?=
 =?us-ascii?Q?LAhAhU/bKjNCYE5OSczxGPc7zUemvVgjiLwqKy7U3PHKaC/47auSWQI1A7ji?=
 =?us-ascii?Q?Vtb5N+2QcC+rKg3BpzOSBNaoAZ3r9b2PXM/rBzFsbP2R4UcKUQbMTgPhr6Mj?=
 =?us-ascii?Q?7P8QpxwxCHAxbR/RrWMnMFcNBnpPmGHkzZvXCBRNSiX/omCWanpgmsV3pLTZ?=
 =?us-ascii?Q?gB5P7RXGGHVUXnLrXtYMuDUNxKwAfAfCCoDV5ZjLKeVP1lUZLFeerORZAWKv?=
 =?us-ascii?Q?Zz8s+pGeaG0+KYd2jRwjl+MND/jgFy16RVfc2M3aJXgQAyC+ZtEUf1tj2UVt?=
 =?us-ascii?Q?1BwT3WwUt3hKfZgZ1kmqOJQG2cfUo4TbaITfiH/y1DtZtdXoC3fuv+hCgSUg?=
 =?us-ascii?Q?mTWxmjU8OuSutojLwM8yjvBwrYK/EIpbHnc/lU+S1My1SD2LKtgojaVZy8U/?=
 =?us-ascii?Q?rhZqq/2U8MgSkpjEEjU+iaiH6M+/aEp7nhHpu7ki4BD16qJ0CQWNXV9XocGW?=
 =?us-ascii?Q?liR6pl/ZzCskwiPTgLGmF4WBEO/tu9ChVRiq3DQUJ9igKj4KR3MHxkpQ6FQt?=
 =?us-ascii?Q?+PNUknd8QeySakauBC3Ieq03mUtrXo96jYKdEAKRp2euL3/FBtN3lI2I7X95?=
 =?us-ascii?Q?o2Bs5H7/AmsE8vbMfa3WP7GyRQMHlMW0dZhqkmYUnHYFEi7ULRf8Z6ECafNR?=
 =?us-ascii?Q?DRvgz26Bi9H6THz6KP5JSTACCNSQ+haTpWrLWyp4Hy0pcCt4verxsgiBMAxO?=
 =?us-ascii?Q?ZG3NHFROLS0Ss7Ogo6cytGB6m1ZMgo2odYtarrQe0eeHz7WewM4Or6OGLqxV?=
 =?us-ascii?Q?7w7WapeZY9VFYfwEuj8KtZGXGHCS3t0=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f30ccfd-3c6d-4164-a2cd-08da23c05e99
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 17:57:15.6822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YkF6ulej7HAY3eHF+CSK8+hJt1TLSi8ApMhkcyxIXj/Ipo5yfOJ1VSpxPaCyhXxmrN+mfCL9PLALxYBJHOnZng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trust Architecture (TA) 2.1 devices include the LS1012A, LS1021A,
LS1043A, and LS1046A. The SFP device on TA 2.1 devices is very similar
to the SFP on TA 3.0 devices. The primary difference is a few fields in
the control register. Add a compatible string.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 .../devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml    | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
index e7d1232fcd41..aa277f1eee7e 100644
--- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
@@ -18,8 +18,13 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - fsl,ls1028a-sfp
+    oneOf:
+      - description: Trust architecture 2.1 SFP
+        items:
+          - const: fsl,ls1021a-sfp
+      - description: Trust architecture 3.0 SFP
+        items:
+          - const: fsl,ls1028a-sfp
 
   reg:
     maxItems: 1
-- 
2.35.1.1320.gc452695387.dirty

