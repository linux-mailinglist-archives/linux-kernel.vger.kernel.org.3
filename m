Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BD24AB8E1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343563AbiBGKjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239009AbiBGKdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:33:38 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CF5C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 02:33:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQVzYcHqKxVIuWydIrfjcUWEo9MQPbbRFpqxLXAfQBm1xvt0AVGsxQfmYGdN/oKg29/Q0PZJK7LauvGeJzNxj3Fc2wo5TwqYxMB3uCzTU1B75/rIwjbXLijm8p5xtXrpQCc+eMA0sMYrXXRrFag/CFgu9jiRIUXTBRwRsm39agthqQ/oggBcNeUzxzzmBtaJniNfjd2qDQHLLvMQfZeVBw2bN2M7CZhMo3701HtW/vvzry4IoqieRmV+JtA29nFUtiq7Dh16hyjv6LnIlKssbGPVym6EHCahfdycpj28azHsUDJ5aDLzR1hwdYK85oG0Ta5IOTK4Xmw9SJ4wIVL4Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCt18IARJsjxRsEpyB2iuZciG1Xfya7CvGExbYRcLD8=;
 b=Ht60QCAprnTd3DPsljnDFKIyRqzoiV0ygtPQ1unIs8C7vgPl7of2VsycCndUMSJcjC/xRI3bcnBoBTXtqgBWCI1mAFurnhc+TkAfWcgXJAcM8RkeQmyxM1Znk9bb8ZvhWMJitKNXNwVHKi0K63uIIFaApaLHWHX4Zr8lOyxt+v5ZdTJCX8/VAk2g6duO/Rh896RrHXKBBSYYOpLn8PPN9ecF+DFhUjBeqSA/N8jcc7H3wKxyKno7a4EsTrFH9x4iPv4XLqiAs/yT0BE18K32wBgEKVFtkxfWTIq+Qdoc4z+O6z3eh1l7LJcQFmrWa5ALJ3jfFwsXl0RW9meaDUf89Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCt18IARJsjxRsEpyB2iuZciG1Xfya7CvGExbYRcLD8=;
 b=A7zXy1PtZns1Wp8iA4a4HZvHe305QXE2GhePzP+0DHpf+7anNIfayaQDohac5b+jlMzVIkOBeTE7RGzYT4869B0oKK5rjWRoVUZ2T13Vp3y6330pIOf/kj7aypi6pr9EU7/dDBwnXvMZ1UcKqH+irBT9SoK2xIrGuIKUmbeyoj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BY3PR05MB8081.namprd05.prod.outlook.com (2603:10b6:a03:366::15)
 by DM5PR0501MB3686.namprd05.prod.outlook.com (2603:10b6:4:7d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.10; Mon, 7 Feb
 2022 10:33:33 +0000
Received: from BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::283c:d671:e4e5:31f8]) by BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::283c:d671:e4e5:31f8%7]) with mapi id 15.20.4975.010; Mon, 7 Feb 2022
 10:33:33 +0000
From:   Jorgen Hansen <jhansen@vmware.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     gregkh@linuxfoundation.org, pv-drivers@vmware.com,
        Jorgen Hansen <jhansen@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>
Subject: [PATCH v3 3/8] VMCI: dma dg: detect DMA datagram capability
Date:   Mon,  7 Feb 2022 02:27:20 -0800
Message-Id: <20220207102725.2742-4-jhansen@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: b34b91ff-7051-4917-20fe-08d9ea254a5c
X-MS-TrafficTypeDiagnostic: DM5PR0501MB3686:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <DM5PR0501MB3686635E07A19373274E6989DA2C9@DM5PR0501MB3686.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VOFkBkOQoiNh9aepUrGEldd5jvb624ZLQLG2PGvgOo7O/TPmuOX1K8ufXs5oxxjdrrD0MreggIRAJhTrypmROgdLYVU3ep5PqrLroQUuHlP2YO0VlOFhKwFgD8SE34K2jLAfnMzXuWEohgvTVvvNTJATXXVb11xQtri1VmWdmaJYr5kQw2EuCLT70AdPesPF239arTS6wKMCA6K/orq5plucLgqKfiB4jVJNFTULai0oWcJucO3JWJLRhdBFfmNQ4iVuy1v8ZBan4IyYz5SAJyKaGfaZKHSG42Ss6XPND2P1qOaUawTipE08WyHvfvIZm1HLYyB0a5xoNQmaQ8wgjbFltW3Sjxa2KBG5Ni7HajGaQg3biJ78s+Fyld4ZjukGZ5a4YE3oaqCqkBGaBXTd1UgMh5O1l0tudqJxB5gwVS0+qjjE7AYOi0IIxPGli11WIKcc+g5aC6s3otmDUgRF4cjyRbX6rKxy1eoNl3jjQYfLYvnaIVZReczPAOz5OKYjcywic9Xh0slWT7HttzzyVKY581mDHsELsRXdWVFixUSa8MqP7SCybJl5QBMzNsbpMtTEuwkYmufe1fGEv1SY28T2gIrsvkVm9ABy/aE4LbAoRFq+4sTDPxQD4zMy8imLQcB1FdkjHbIb+8+hY6VJutereccKoMagbSv/KfGJq2yV/jCRyhtEzv52LwzlkoBoDkDF/cDY7bOvlb2MKIj8sgij4dcWQgiPY6ludxsxpFWm3EbrauTMLh9WIxdKqohA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8081.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(508600001)(6486002)(38100700002)(107886003)(52116002)(1076003)(8936002)(6512007)(36756003)(186003)(316002)(5660300002)(54906003)(6506007)(2616005)(2906002)(26005)(66556008)(66476007)(8676002)(4326008)(83380400001)(66946007)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uXAbvCh3pmeQexh6hQV8XtsRtmbb0GY58EoVTuzFbjgINu75DY1drq7Vm8/6?=
 =?us-ascii?Q?J7BEIo1U19MRsp/Q/WfxpwLFA2iMeOSsOfy37aqAJJFLmP2GrOrhLfIzmUOw?=
 =?us-ascii?Q?nuR/O0oWbf1/8DVPb37yM9g+rhTURYjx4FTG1WituJePtPdlzbG6u2oSr100?=
 =?us-ascii?Q?IZctw90CefxOWgrtokoILSPbSRmE30bRm08nZQiYQYt7K7fWB/3B8YwV7W7H?=
 =?us-ascii?Q?Ab0ehu9k/fF382BVk2RMvtStbn73cmf19dimgLUgd4EQDXc3leF1fzTfS3bu?=
 =?us-ascii?Q?7luXWvOF5PPReDIZdC0fptOfa5kEEr/zb5UUwxGTJxt4/XUbnTrPMJ4rhoED?=
 =?us-ascii?Q?UWDneE0WWH7zXs8HVs3DKHLrexOaEcTHZkpzvXN8BeUB3tpv6CoVET2incAw?=
 =?us-ascii?Q?trcPMYabovr5bx3Wtd1K8mKjBk9gvIL3/06/EpoPFGAhWxgpBPXwqH++d+LJ?=
 =?us-ascii?Q?4KEbNL1Vj4vYd5TC+Qy2JyzUsqIkwtXOcUWkxGH8d+rRA6rAPbqzu0gJb5dE?=
 =?us-ascii?Q?K/3qFowXuM7pmu2h9OhB+fNjvcbxygVPF7PnK4VKw+oGXaUSoU2qtyFSTFWJ?=
 =?us-ascii?Q?2x+S/XCerKI5OoE874YxeRZ6bkyK3XThVEYU/vOXCVJlkC2dYBeAMyGF31Hh?=
 =?us-ascii?Q?qUXex9yO9R9qv1YIGMxIfo2WyRAycmKlfkRNbxTgasO71pIdM3UIg+M/2VGU?=
 =?us-ascii?Q?kfPgCDXnKLIJZtRnCVziv86CdXR5PwQYBHF2T2IZdNWkuWGpHrcxoWnIlDNn?=
 =?us-ascii?Q?xrbeI7As4iUFXWXr8s9aQBr/3IzkuL7q5anRf19qekZi5YvCc+uCxPSgFsHc?=
 =?us-ascii?Q?gmqbZX3EF+dcez5Xe7h/FA5UHAtHcz/mm1wjv9hUrlWfjxrp/hag9c0R9+Ig?=
 =?us-ascii?Q?wdndPpQVxcjnWo6KbraPza7VKccwShANBxv1vGLZl1PekaF67h/Xjmfqfek9?=
 =?us-ascii?Q?oGlxY/bVjEDL8zK0MeyUghxv6ak1/rKc5eTWdno1syPPtGFvlUS/YqmU42um?=
 =?us-ascii?Q?HrRzFfwUrb39P2uTzvzrcRyhAw62hshRvxlKPW2R/hjLXAsHb298P3cMUHXp?=
 =?us-ascii?Q?Fjup7gL1jDumH1s6GgquBhEA+76jqRC0mkJxL8thqfYE+pUQ7xvC2els5JUD?=
 =?us-ascii?Q?6+p7mvOz4s1RdW52s71m0NlDxL4YiNPRMV1L/h1Gg/FAE48IjtmFOk7QDNl9?=
 =?us-ascii?Q?NtLQGYzi63WMtwl1en6jhwjTHTH17qD+Vb4qPdD9z1wEvqh8zgJgxpn0piNw?=
 =?us-ascii?Q?qqr4RBrcZXF3ZHDpDRASp9AXzzIOiizDkZu30dOUDYLWY2c1BUbFEOEmCNRP?=
 =?us-ascii?Q?iyugjYdmipjuz2GK8wTvG0SwEK/xd68Dgkr1lytdc2lCw3rdVjJiG58qpyBt?=
 =?us-ascii?Q?8fYYpprW9602Q/ypfoDMSKIM4r/e2aqTUSIv7jqy7q1amajTYyLQvSqIcB9R?=
 =?us-ascii?Q?WlTeYNeAdv3aKhI0LGxD10w6sjIBSKmaggBxSmmt32N1shscGYvWv6bH8jTd?=
 =?us-ascii?Q?6F2zp2uL3eSp9OirfHw4oEBfopgwKXeb3mzDiXE3LH5zWbzj+aZfJD3cTR46?=
 =?us-ascii?Q?COnfYpPVUN8i4t2OigL2kyi7XYF9TtHmdM1obkpZ64UTYo3ts98YC86Z5/BA?=
 =?us-ascii?Q?RmNtzMhGvaowzw26yxiTZXs=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34b91ff-7051-4917-20fe-08d9ea254a5c
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 10:33:33.4532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nzpLhdG5gy7Gd9x3Cqi3fkqT8AW3Yf8TMgJbVy067UE58pZ6WOp5oagrjPu54ri5BUll83tjpL6Ixr0hFF4UA==
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

Detect the VMCI DMA datagram capability, and if present, ack it
to the device.

Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_guest.c | 11 +++++++++++
 include/linux/vmw_vmci_defs.h      |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index d30d66258e52..b93afe7f7119 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -562,6 +562,17 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 		}
 	}
 
+	if (mmio_base != NULL) {
+		if (capabilities & VMCI_CAPS_DMA_DATAGRAM) {
+			caps_in_use |= VMCI_CAPS_DMA_DATAGRAM;
+		} else {
+			dev_err(&pdev->dev,
+				"Missing capability: VMCI_CAPS_DMA_DATAGRAM\n");
+			error = -ENXIO;
+			goto err_free_data_buffer;
+		}
+	}
+
 	dev_info(&pdev->dev, "Using capabilities 0x%x\n", caps_in_use);
 
 	/* Let the host know which capabilities we intend to use. */
diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
index 8fc00e2685cf..1ce2cffdc3ae 100644
--- a/include/linux/vmw_vmci_defs.h
+++ b/include/linux/vmw_vmci_defs.h
@@ -39,6 +39,7 @@
 #define VMCI_CAPS_DATAGRAM      BIT(2)
 #define VMCI_CAPS_NOTIFICATIONS BIT(3)
 #define VMCI_CAPS_PPN64         BIT(4)
+#define VMCI_CAPS_DMA_DATAGRAM  BIT(5)
 
 /* Interrupt Cause register bits. */
 #define VMCI_ICR_DATAGRAM      BIT(0)
-- 
2.25.1

