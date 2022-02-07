Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D224AB8EC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343499AbiBGKi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238077AbiBGKdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:33:36 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD08C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 02:33:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTNNRzNH8V01BqmGgX+JwFtALVOVjDcbt5DV0aJ+bLeYa9QY7wtKMpaUMuXftV8e5fLQqTPVm2UxUJsRHz32H87upUNir+wRo5SQFaRp048AMR2I/KJh4AXZpWlPILzdEP/l634QY1upScxG4DE7PeHDr6PbRmkR+6mNX036o7AavN9nbDpRQf24m/WtlGdGbO5S+r+WlXsEMePuyVfQMot1YD5wzcF9yTQgXPV/9V9IpBtpUGaSYbA9PEnfTYJXg8KwoUyIkIde8TwcyJV2FNyB/T8E7Zz+prMS14Na6JfisbAE2xp/reWtKIL44f98TUBwgm2TpnvJTMDRrw//XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7W8TrdRp9GTsb3nOerdsmaGgiZw0iRhnUQ5vSw5s6Lw=;
 b=ax6zvAAVq5deEZtGas2QdFdp0Yb51HEkoQNtaCBpjrHjQQtHqS36SukubZYfLZ4IRkdnJcw79/MAJVvV2EhumvEH4PRte4KHT/Kx/0Jf31RwGXezQduka+dhI6bmU38xZhrzuLbl0aS+FKV+eNbk2Yq+z6A2C7GR4/n/kG3DP4r0XrHR/pf4vQvWfrTfz2+3rb6vHlKaINDDjH4BkcyLYaV1NFYNWU36UHIWS/453/aiGVlouy2EfNLf2aSKM41KR9lXCRWHPgBNG8vXi+gltOPXwJicZg/cPwMkZsBuK+KDKN5AL3dcRIT/pNM/NGy4KhJF8/o+HjaGdNQ/aKSJTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7W8TrdRp9GTsb3nOerdsmaGgiZw0iRhnUQ5vSw5s6Lw=;
 b=at33ys9vu+nHjp2ZZ5tJCvJX5bLlZq12NlX2MbtmpcYOijM1B6eyhyy3egcM/VY95L6Z87iz/XUOMfjwVUhwSp4oakv9qRUqg8ns8F2G+4StEfQbiMlOZ+zJRUKo188kruU9Ynwc+Prc6QQMZJCDcfS1o4xIXXEpWOFqi13GjZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BY3PR05MB8081.namprd05.prod.outlook.com (2603:10b6:a03:366::15)
 by DM5PR0501MB3686.namprd05.prod.outlook.com (2603:10b6:4:7d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.10; Mon, 7 Feb
 2022 10:33:32 +0000
Received: from BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::283c:d671:e4e5:31f8]) by BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::283c:d671:e4e5:31f8%7]) with mapi id 15.20.4975.010; Mon, 7 Feb 2022
 10:33:32 +0000
From:   Jorgen Hansen <jhansen@vmware.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     gregkh@linuxfoundation.org, pv-drivers@vmware.com,
        Jorgen Hansen <jhansen@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>
Subject: [PATCH v3 1/8] VMCI: dma dg: whitespace formatting change for vmci register defines
Date:   Mon,  7 Feb 2022 02:27:18 -0800
Message-Id: <20220207102725.2742-2-jhansen@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207102725.2742-1-jhansen@vmware.com>
References: <20220207102725.2742-1-jhansen@vmware.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0062.namprd11.prod.outlook.com
 (2603:10b6:a03:80::39) To BY3PR05MB8081.namprd05.prod.outlook.com
 (2603:10b6:a03:366::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ec6861e-4c22-46a3-9b5d-08d9ea2549be
X-MS-TrafficTypeDiagnostic: DM5PR0501MB3686:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <DM5PR0501MB368662A11236F3A591F4B219DA2C9@DM5PR0501MB3686.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NTInf8VkwCkkdEyzUZGMQx5eGyowI8eESHIljas7SFfjPf11gwsqr+a3Ii9efB9h+y7UX1vXhQOP0VVg/CDNBKTc3gXqJImsNAK3tnbzgdDO6hTPCUOragfxqgkaehJ3AJQiAMvzubUee/nYp/1M1/hoLxeJIjst09GypUMJVs0oZINx7cvSrjt1BmKo8AkEFIWtCcezPfGuXU3SeSLn0WL/dK2YN259BdYrJ6s0rxrjhXDK0XCc2keNffeGw7jxr8mri4eF62CcpIz6z0e9hsRvkbrL0XZR/M1Yb/2IJF3TWWeE03ywOg8quFvEsGyxPvvOmRvIL2MXMjKbCrk74/F6N6Wlc81884+pKNGja1fyTM0eSLivD/yKXFlijQ3u37hMZ+c3Bs7ZrFHs3jVqV2IYOyj2nuEUl/zeRimpGyoRiHJobBg8xe32OOYCKykZjB+gVqiWOv2PeMOhFX0TCVy7XtvM2fz6tTB6T7NJ0vvPpUIfXapEyaKaIsAoUwQmtQbEnwSL+Y39hu4ajNfxBv4pQBFsXaRu6/PnuVEQBTZEGOJgYM8zLqUy1lVPF8s7yPHwZMgEz9+M23+mkwbPUFLpCGmzyUWXMGXXv0a5hcfOH/XfPuDRIs4j7RKvUUrYa6EgU1Acl2HJWWgRGlZd8fPSysL6MHYOhdOHls9+UaynIY2gmQLhQQMJGQSiuGWfJ1aYZeMqT+3Eiyjv9khbkPzhzgXd2Wp4GW8ytkN2MrU7fjuBDF9ULa8OGS4i1Bzx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8081.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(508600001)(6486002)(38100700002)(107886003)(52116002)(1076003)(8936002)(6512007)(36756003)(186003)(316002)(5660300002)(54906003)(6506007)(2616005)(2906002)(26005)(66556008)(66476007)(8676002)(4326008)(83380400001)(66946007)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Cf3WQoPq4qFC4pD9mnZZTsOD8MBrkG9gsIB93Jq7hifgpnnP675ZMYmqkcs?=
 =?us-ascii?Q?CdWy1W8byIUgMLpG8M5TU3sq9WYZYUbq7YpUzAVT3olgy8rOd3YrTcrMNKym?=
 =?us-ascii?Q?tOrxMqCJHYgre2nTGXwNf3KW5rSYWGLIU88E+Nj3wFxXc+sII6YXQA5dx+yh?=
 =?us-ascii?Q?epLVSBUGtCc+9F4D865hBg5M72OMB9v0GcM/sU0BJQUnKs8i5fw/I96nsEgQ?=
 =?us-ascii?Q?mZ/tvnGiH1O2xaWJMatMNCXXbZ5tL0/Hp/ePdeC65wUYa3LFpEmf0ypnAHJF?=
 =?us-ascii?Q?ziHdnUwtd+XEUu+ZCYa85XC5245pOYFTOiMf2mHPIRMum9LMX7cwMP/+IAj6?=
 =?us-ascii?Q?3fnV1lTLO1Zb6FVDtty/jqggbH8v+vRNwB66uwcZTdlhuZvZZQhBvnLABQYE?=
 =?us-ascii?Q?HpNh6zjvoi1qMI3QZCi4VJW+MvSP9AbIgk+PBc9zxMLaOLt+0uJCZpEmZ71m?=
 =?us-ascii?Q?bj8VApm6XmBLT7wdt/eipxmW6J0AS519pb7ciA+lEQT8nKxpRqybra+ncaki?=
 =?us-ascii?Q?diXnku54NUW+oQgEtoUXuF74g6e1nsJm9bXqhZfRy557jvpIDuXPgoUU9zeh?=
 =?us-ascii?Q?a5U3GNmfwW9F1NMNEJEQyyGEmsb9ggS5dyusQ39CZcnHdCQfFdeE60V0ZHVo?=
 =?us-ascii?Q?PuosPRv9fIM5o0wzeRHl4Msd2S+Wmj121AjuMYsO+P05hesTMI7mgK28AcRZ?=
 =?us-ascii?Q?pcA2GZf6aeonPgZ2/uft/856X4icvHX88XK6mAaFo3CyBqsXdx6XXDmyew6w?=
 =?us-ascii?Q?SA6XzLMf5A3MarRxtVwqlgNwad9v9YXYIEkXnwtUpjrS2nJL5LnR9oZf30NZ?=
 =?us-ascii?Q?CI53aMnctZlL2C1omJmOusu/AuWAP0KT+wXtSQ5iBrBQexDJBJHP2nyeAZJl?=
 =?us-ascii?Q?Hi4mum7igTiQZ8Z1Kil6Zfgw+HF5L+BTDWHIKmXIqgPCy8R10nBS5TPNZOnG?=
 =?us-ascii?Q?oLbd/FDKrqWSaqXmL0nl3oSLq7hKanJ9YDc2R/QO3r1h9Pjzz6hiGQtMtbxc?=
 =?us-ascii?Q?/drLpSOJ6q7GL9HOUiWp6msq0ZDFDpyhYusLwj+YbfuFox3tbvwmLRZtJJWj?=
 =?us-ascii?Q?H6YJyMoDfP2oqvBkmOMf1SHW9ay44gCIO899YQu1ZRk9TNU4QjW9EfbDNpi+?=
 =?us-ascii?Q?F4d+3OLvw4NFP7+cBCryh4bPr4NWeBvv72u3NJLj2ze4/jBsxwkOLylU30Zx?=
 =?us-ascii?Q?S5tFhZ/kKTdchKG9EBHpxICyxq1KBs60MOs8krmXqeR0ExxooD7i0OFe1uvs?=
 =?us-ascii?Q?fZ+KF6SXkcEFYOfB80L5VeOm/N4iRWcbY10fU8dPZkDyp8oZ31jWEd7rLJod?=
 =?us-ascii?Q?RNvanpDZNFz/Fy4y5RrHkqJo88Tla/XMaDAEW+8e776nwEhzynwNJnO9EzYg?=
 =?us-ascii?Q?31yRCSk6xs2LUSUZXFgZQmMXRRbCQ6V11roSTdZAR6pSKahmb/Kz8eJHl2Ym?=
 =?us-ascii?Q?I3tN/Nfctu1tIE7cgGgAjkVsWj3Nt9LZGwDDzvAjP1bGzzb+CiUFcaKEPAlg?=
 =?us-ascii?Q?VIft4x3C9quaLYVqDnsjIh4FJKiim4auilP2OgmYUH1iRNs3KmtbVXDyD1aZ?=
 =?us-ascii?Q?w/9SAzWWqtntzhkV4Riylqz91hjPEisXrXLs3rxAfmm9x43Mb2+nirrvZDdk?=
 =?us-ascii?Q?RgZ5iKHmsVK4o57z6+E1FQs=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec6861e-4c22-46a3-9b5d-08d9ea2549be
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 10:33:32.5615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RYosy+IdTlKtajOfl0cz12a6Im4ISRnYVfY1wv/8v/+OFiqqld4li83YFBSfvbmr1ZSly8w2On0R1tx35D9ZsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0501MB3686
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update formatting of existing register defines in preparation for
adding additional register definitions for the VMCI device.

Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 include/linux/vmw_vmci_defs.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
index e36cb114c188..9911ecfc18ba 100644
--- a/include/linux/vmw_vmci_defs.h
+++ b/include/linux/vmw_vmci_defs.h
@@ -12,15 +12,15 @@
 #include <linux/bits.h>
 
 /* Register offsets. */
-#define VMCI_STATUS_ADDR      0x00
-#define VMCI_CONTROL_ADDR     0x04
-#define VMCI_ICR_ADDR	      0x08
-#define VMCI_IMR_ADDR         0x0c
-#define VMCI_DATA_OUT_ADDR    0x10
-#define VMCI_DATA_IN_ADDR     0x14
-#define VMCI_CAPS_ADDR        0x18
-#define VMCI_RESULT_LOW_ADDR  0x1c
-#define VMCI_RESULT_HIGH_ADDR 0x20
+#define VMCI_STATUS_ADDR        0x00
+#define VMCI_CONTROL_ADDR       0x04
+#define VMCI_ICR_ADDR           0x08
+#define VMCI_IMR_ADDR           0x0c
+#define VMCI_DATA_OUT_ADDR      0x10
+#define VMCI_DATA_IN_ADDR       0x14
+#define VMCI_CAPS_ADDR          0x18
+#define VMCI_RESULT_LOW_ADDR    0x1c
+#define VMCI_RESULT_HIGH_ADDR   0x20
 
 /* Max number of devices. */
 #define VMCI_MAX_DEVICES 1
-- 
2.25.1

