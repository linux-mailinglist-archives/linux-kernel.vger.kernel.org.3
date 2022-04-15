Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035625025FB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 09:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350870AbiDOHHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 03:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiDOHHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 03:07:16 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2128.outbound.protection.outlook.com [40.107.215.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6B2222A1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 00:04:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWsDL4MjxzXr4tRBOuVxmoqvW77FRha5qFjN4UqpsNoj5Q2dzQ2b9wcH/2lNwUiw6rRfIr8Q8d4kET5sgCG4+rnUTjx71yFGbcdY+diUvLcyKo/R4nbv8npGKBTX/zai4TAkXwkbNQ3AyFSQwCkPPKIKEHwnceFeT959XQKu6ctX+lsgIZBqhiy3YhQKtJ6KYZxgsls8bfUVSRr8ToZ7SstDBTcyZ0hJpxjPiGdkgtHLlGNskxAvTq5Wnuv9HYwX+mHwhm+7H13hkD5FS9dODAUyrbs8jA6L/fgJnKfCA/tUhevbce7skmfHebBWOFsdOZYKQS5ZIzFFZJzGmihQmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4633MBLegw7YCpBNdZILQZuz3+SpNqJlQHkWnHzKTvU=;
 b=Z0uIuRHcYXpxlmNRN533S7Tzd51Vid0xu1iCcvY0v5s3dd3gW+wTCJ7Df4E8e16gPqMkwrcwaQNF/2dUqSetkEQrg3HRkhuLUPNqeurMkkesgKcO6ovF07ZYRbnI2R79RXKNkLc14SVwYgQMO1315P/fsYTiahQL8vjoceRdVP8P5G51SSk5GxP3W7HRb3AZK9VPl3RhT6o4NHrBK45O9nKulQXZ52pUzrGJpltyFQXqOcPNLJYJvgs2qCO7eQXx/NHKHdNmUBOtC9F4Bw5hlEDozkWQ3c3NHvvFI6xWyMOlobyV/69MxEo7y9ukEuF/g5dCXHFFpItFx0025fh/dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4633MBLegw7YCpBNdZILQZuz3+SpNqJlQHkWnHzKTvU=;
 b=ouYz3AxYK97IBnhpZHS1/lFG3+4fFYLC8fobqph4hqtxdkmTCA1YN3SOLQe7uY/QuRd0aGGfnUaiHcpXM4D/HuRdBwEeBF6m2liuCjKXJ0lenAQKdZjidRGB/ZuWe8WQeOjRGk4uXJcqD/GeFgAWzyIjLTI7ST/YnbiYcf65eYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SI2PR06MB3962.apcprd06.prod.outlook.com (2603:1096:4:f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Fri, 15 Apr
 2022 07:04:43 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 07:04:43 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     vincent.guittot@linaro.org, peterz@infradead.org,
        wangqing <11112896@bbktel.com>
Subject: [PATCH] arm64: make SCHED_CLUSTER depend on ACPI
Date:   Fri, 15 Apr 2022 00:04:28 -0700
Message-Id: <1650006268-3782-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::36) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c6c1247-63f8-4466-f46c-08da1eae3759
X-MS-TrafficTypeDiagnostic: SI2PR06MB3962:EE_
X-Microsoft-Antispam-PRVS: <SI2PR06MB3962F73BE07F5F056D7A7C77BDEE9@SI2PR06MB3962.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EN1kF7QFwbPEssUdvDfhxgRHdi6fGoRyCfx9TT5MAMphsYgNkZuW7nvJr89SR3NxuCXVn2QLxvCoKtnKtbA73GMwCxUt+p6DDkk7/JdJpgJbBYxdijiiw/pFyuil8y/KZ4KZktEBEW4jxSlV/Y1eJMCcFb2mQ5pb2IGB4f/Lnn1LZbHkmxEhkW7M3u2/wAvJANlGYpZWNN/irM6xCpwvAP1B0WvEu46p1e1zyud+cp5K18HBEATIKjEK/Zey+uxtnJE/rd1gOuPZX4ABW1L9UnCaOOiojrUQaXfRM6yZI9Xhy2QkczHAaA3F/B/ELhgDUmaxdmfBHOqI9PPr22IRbxUtjXAHsdgmiufjDlBBIe/apWcpYZAk/wV2FEh2ql+95jBCFFaZHxfgT4kO6Awf4yje4Gtp0e9+3DDCOxmlpo5jnZTXx6EdPbuIHQ0c3yLShpNpONdO9TrTqlYdi8krWLoz6Xxqib/e0p8c0EbeedK0ptwe8pYsm13Z3Q80RhtpDMgQtPE+uprZSgcLB6JS1v8SBs/x/i8PRidVTe4Ye9PtT5KWLEZ8lJVK5NTu7cqDmGVOAhrXjNUdbMa2tQky9YVaArPAhbz/uWgpYG3+2egJhJglxHQoece/BzJ/zWeZ1iOJ/I7Z6uIZg4UwpNmzMqYmskJ9SdbPgQdQSl/UQaiZYR7g20J3v5ur+LNonyIMgVAWQYmxujP37/b6R/Nh3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(110136005)(508600001)(316002)(66476007)(66556008)(4326008)(6666004)(36756003)(66946007)(38350700002)(8676002)(2906002)(4744005)(6512007)(6486002)(6506007)(52116002)(5660300002)(86362001)(26005)(186003)(2616005)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vLAvAnpPYEn1aShN+cTqkecMwUFXJzMe2lX41xFIUgiXR23xA611aW0p5brN?=
 =?us-ascii?Q?Ks96N2s9uz46wHQNdfdhbYfN+j0KLZTtAym+fPkNQqorNxQbH1FMwhGOBJwY?=
 =?us-ascii?Q?p9zs5ViNhsW23cBm9yejeT8HoahJp3+IBxwZmwr+GCzmSmkrnv6P8phhgJKF?=
 =?us-ascii?Q?e24WDZHoYB67D/2tvgPoDx+bpNAc92dhyzMQjqe8DAQ/71mPAHujIawiVmQ8?=
 =?us-ascii?Q?B7s0VHH4Fb9v6nVkzJiNhDzXffXiSjxwKwpEguqQ9f5g8fFwubsrosESEdT2?=
 =?us-ascii?Q?zl5Wh9IitYIOD8TR0R0ZASpyegdcz7byjQGsdYgvQfdsRdxD4cfIhjwfK2NR?=
 =?us-ascii?Q?FcFufKzht6XLsEiUfNbmzZo/jWjawMi1aC/h6P1Jua5i907ySnLbIoUNimnc?=
 =?us-ascii?Q?AoxIZBvtPNjGP88VnCrJl/JpHegvzGOlAyzaU/XUIDlbhgSOnfQGQvp/SGpi?=
 =?us-ascii?Q?Q+mn1D36FMjvc1SL3vvxH3mnq11f5svLOdcO6eHr1n3oxJrVVSk7SF/HRZ24?=
 =?us-ascii?Q?JqDHK08zSIEbfS5bKmA0WUlsl+s+OtSlU9K9leEqCI7Ux7k8EnsEAqaEFY2h?=
 =?us-ascii?Q?hJQjTefsMF0/jQGsAyRf1QsDB2tucHklboVcQZNZI4vDq5m6OdK8wDAPfRJQ?=
 =?us-ascii?Q?86KM0IDmttE7RTtBQLWn0YimoxEjsQF3USfHNNtNT5Ja34bp3rRLUqHV0LZi?=
 =?us-ascii?Q?USN5DHOxbeyaBvmkBVdt7SQ01Slqq/hOY9r0tMtD9Fmc2Md14u5XN/9Ht8p4?=
 =?us-ascii?Q?uHbzExhAIbSCln58aDnaJmMm6HHZ/1JyQk7lPsjaGctP2AGZXiYvrN2Rs5Ja?=
 =?us-ascii?Q?cSrmm6B3tEde1hOUHFUyjnwZLb7mQKfDt/5gHiFYM44FJNV4wyHfdFVkANBc?=
 =?us-ascii?Q?rvrUoP96e4/qKj7amKel1cWoFM99fMtmK4H5Qop5GldsB396WuAI/D4T2FpQ?=
 =?us-ascii?Q?5Lp7r9GU1J+APPcKR0UC8p1L0Ogw7FXPudKBb99TrVCKfjPtRj1iI9NoVxxq?=
 =?us-ascii?Q?zjKSGis87MlovlC0eww1dP654LvYJBRTP8AxpJFXAUFbGwHHfGP5+wPUBuUO?=
 =?us-ascii?Q?EKI0fkCjx8GrBuwdsIntE6wE6qJry8XWUsMGwwtjWcrK69i0QJH1/ck7xRiO?=
 =?us-ascii?Q?HhGDn+o4wtpqF6bK6Dmxoc/1p09BE2g3g713KLAu3sX8uOS+w6p/RyTp1YgB?=
 =?us-ascii?Q?CN9qumEAv8tc47JGm8lzYrZU+BV7NmXitag5oLs6ygvM0vOrGbxZuE+80R2r?=
 =?us-ascii?Q?1VyrqflNtWBXF/wn1Gqb3M89v3AsaIJfx6ZizJ82+cLMkfGZ9Djq1rbeMKdX?=
 =?us-ascii?Q?UJg58gLsJ+Fchul4bNyAXjJqB5LHYiHwvvGeRk3eshT3r0d8VKb/5iloCdWb?=
 =?us-ascii?Q?UUe1o/EM69Uu5eaXIuZR7G4Z3kinwW63H2aJWoGb0YhYZ8wNveHi9WhaxN1X?=
 =?us-ascii?Q?NZ8Zs7Yh9IPiQUJpUzFtZdmb73J+RZqgA+QIkBenMe/gDOzdZV7W5r6eYtXe?=
 =?us-ascii?Q?+BUbkr8xAGTr0WHTHiy2DKvdQHuEEUaLahVP9+L9J27dObp4+l2CmahjK3Pz?=
 =?us-ascii?Q?OxMlEgvzTCthNeTE3YJPRzc+O1DikqOB8D/PWRetiBrWDSncU+afqUMTAVU4?=
 =?us-ascii?Q?0jAvKY6eGJupkBpZ6MOtbfcyRo1mn8QzrPoS6YhvN2ruhfvRGyLLA0h4TT7p?=
 =?us-ascii?Q?AqYCGxlFxwHow/MfPzWpHwosPA6bcF9hZ1UBeGyPE4g6y2XQhxvYOtju5t5W?=
 =?us-ascii?Q?fdMgU2/ImA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6c1247-63f8-4466-f46c-08da1eae3759
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 07:04:43.1568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjL1Cem7fTBq1D72UaU0XDOvsg22MZDKqACHxTZAygrSXrMvbLc+xmzsMEZ3SjVZPrHN1BA0Z6tqGT2eaje7BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3962
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wangqing <11112896@bbktel.com>

cls is made up of sd through cluster_sibling, which is set by cluster_id,
cluster_id is only provided by ACPI, DT just provide package_id.

So, SCHED_CLUSTER depends on ACPI actually.

Signed-off-by: wangqing <11112896@bbktel.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 25b33feed800..edbe035cb0e3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1199,6 +1199,7 @@ config SCHED_MC
 
 config SCHED_CLUSTER
 	bool "Cluster scheduler support"
+	depends on ACPI
 	help
 	  Cluster scheduler support improves the CPU scheduler's decision
 	  making when dealing with machines that have clusters of CPUs.
-- 
2.27.0.windows.1

