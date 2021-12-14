Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA88473C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 05:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhLNElK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 23:41:10 -0500
Received: from mail-mw2nam12on2092.outbound.protection.outlook.com ([40.107.244.92]:30816
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229477AbhLNElA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 23:41:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxzsQhV8qi8aK3m9JHs62muzEbNm/Dv9fL9Q8w2yuL3qF32Q0kqfq7q8cJ+BZyHL42dAKHSU0z/YKSOZ0E8yKuXd8czCx4deWaeFJEUa7VrMZUSF3d3lL9kyrssnSgw4Vx0bEJ8ln5hj0ouvcJ+KRuD+PdyW4tbq5bZ2wR0gbMohudGuoznJQCFVrO3NgEgR1ltNBtElhVCH2UlWzvjcpflujyat6O2Z7AZwETOCJ5lGBb4UDvhpNOCrDGzZ1tQ7zj7NEDE6cd2U38ZXvgnQPHgPDo1Z+E3FiCN7yspanwC6NCA/PGILVMFAUOFnifwSYuaXPdRDhATV9eeMbx+gzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcs+w7TDYoeziTSR9MVk297dLxHWSNCreHdbz/t3U5U=;
 b=mkXePeMROMg5KYTBX2/mYoFgX6JpQnS74eTNDc0DwsEFbClSFm5Bq2Dbn37qjpCKf/2GxKCDJhszhFpzQZv5LAgQhNHaoxlMnJ7Q7YvMzVx53ovTKpPfdbErLNWJODeypOvy8MgNlGw4oN/nF+oxseheLISfnJMg2/7Nk16l9eR4D3EAIxU+8osO+tunZMOJvhtn0W+gJPQt2oEu1/bKmcxLKNJnDoo9kVbYRP6RDwyWkaqrldQGgRHj5Hz2bNZkZnjN2pcbvDs3uifNAt/2DjyqqRYyVlzWhk+OW3XKReL8yDuntE9N9LYbzZlg2F5BlnrAkCQutHFJFbCA6cDYHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcs+w7TDYoeziTSR9MVk297dLxHWSNCreHdbz/t3U5U=;
 b=ExpgEieQeL8siuunBzv0p7t1itWVmOPFY+xr0FTLi3ZBCFgs9YM3KmH3Jj+ZNFQDn4zte3jgNIRXJe3tM7eqhTMF/On2dcIx25jNHNnT/7PT734vQAaLgjbTV83zhIvRY7hUud9ecULfxIBHQ+cSMZf6Oofv1Ze4vOod957vwvg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DM6PR01MB4153.prod.exchangelabs.com (2603:10b6:5:22::19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Tue, 14 Dec 2021 04:40:57 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::38e1:cab:501d:6b96]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::38e1:cab:501d:6b96%4]) with mapi id 15.20.4778.017; Tue, 14 Dec 2021
 04:40:57 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, linux@armlinux.org.uk
Cc:     rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devel@acpica.org,
        patches@amperecomputing.com, scott@os.amperecomputing.com,
        darren@os.amperecomputing.com
Subject: [PATCH v2 1/2] ACPI: AGDI: Add AGDI tables to drivers/acpi
Date:   Mon, 13 Dec 2021 20:40:35 -0800
Message-Id: <20211214044036.48245-2-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211214044036.48245-1-ilkka@os.amperecomputing.com>
References: <20211214044036.48245-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:610:cc::8) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 477d4d2f-ccda-4706-a078-08d9bebbeba9
X-MS-TrafficTypeDiagnostic: DM6PR01MB4153:EE_
X-Microsoft-Antispam-PRVS: <DM6PR01MB41539D3F3C912E91C215240E9D759@DM6PR01MB4153.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C1gW1K8oiFCFPXSsrqJ5TzpdybT/Mt+G/OC05MsP6OGWum2khNf+8dtEo6y+6UWyFNa/xoAU+gHZNzcVL1MboAaDfoQL/Hkxa5aP20a5VoVEu5EzVOZs0y3GyTTxhKT3X1v4gYcuRWEw2PtWlOvuaCQMJI1BF2zS+gV0g3wtLSCBKWbgoHByfBiLYcOTUF2gcnTHOBw3stftkXr6Y+6cOel7E4arYud4VPMVAipxNKPd3XZUR0NEjWWo+sjAvMFP/euuUynw0YGvrBtfsVoxgt/JpgTMFdtAwuLrZBNkSUEXmR5oeDluar+t1lz4J9hiD/IhE4Vr+EBPPiGVAeBvZ7RPkbr4+v14cWprk1ga78bMqWBobCRu/grYkYmRBeHDcCyj0qj5uDBSUU4WJOK5HfapwFF3WHucYPwGENCTiIxpmR15Vf6lxkTmvmuxHubMlvIlZAD/LdahKyT6gtJNuIzkqEozvqvrpr4cs+oDUqyDRx7M2wn3oZHx0asFriviPH0Jg+W7VK5GP8jpU/OwUPuqOXDUy4Qn4xbA55pmTIN0BnuJTf2mxFifR2dCBcYlkAjRzt8PyUIs8u3fmR6zW1dMBlnAV3Sd/A8u0rCfXV4o52gTZiXHxd1NnHQPlDEyaXabmyyR3VxaYlrR+7MV8DFqVIzPlz65bQsADng+RyyNHQ0v/RekXZ8y5DJYaTwHGh9mWot6496odIqNEHwJgR+WWY8+IeTfNzehRPf5WrzW41krtaxa+qWaNEg7GTtpF9XetOlGmPwRsJenwzGvBeVf7s8cp+26J8zeL9nTKgo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(966005)(316002)(6512007)(66476007)(66556008)(66946007)(52116002)(7416002)(5660300002)(1076003)(508600001)(6506007)(107886003)(2616005)(8676002)(4326008)(6666004)(186003)(86362001)(83380400001)(26005)(6486002)(38100700002)(38350700002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n8YSk0FUu4ZjOkbu4fUFoBs+n21uwOCTwzoS6j/cXlwfmb33prM5xIA2Sptr?=
 =?us-ascii?Q?iUxUC1opzhshj4QjquVOCm1gScY2a8FqdyhePwIapDmiI+rvosSOBueo35Ai?=
 =?us-ascii?Q?JXl6A6FCoqNvGde8vRGwILs9ImRKmAJl156aMvEz8PJCI03w/0LhGxhwBzgh?=
 =?us-ascii?Q?BuuZx/bjx7n3itC6CE5krDZ2+I12UzXo9NgN8+Hnw4r9oT5uSjM8WJS4bLe2?=
 =?us-ascii?Q?Ht5oaFX6tlQcFwyBaOJfgiWPxHAGcUG9BrRmOaHc6aLKmIulsGnxbLkZFrNa?=
 =?us-ascii?Q?jwI5nGOQo/UMz9WAKLSOxgIA5IZ+edLuBuDQZJbaL5IW64yQuybtsd7izuJe?=
 =?us-ascii?Q?kapao91p0GBsXfJoagaDlnEPlS1vmm7UmH7kBZiYnpza7kbUarhZl9IW+XZn?=
 =?us-ascii?Q?JjM+q0goTIDlUXE/48oJdOk+25JKlF2KF+QbKbVI+dZKUuXDxIVa8j1CFsyt?=
 =?us-ascii?Q?BT93IyN4qibs9FvIA+Mllc/Smr+BJYfZlqFas7BJlWfYVbnEot7S31kleRNj?=
 =?us-ascii?Q?jaAd8w6cAVjQQluTqv/dGhhGZ+3xjUhJ6tEW18OsY+eYWlXXCgO9IGcKcUJZ?=
 =?us-ascii?Q?JVEm6H1vYF+0kp7dmk9k1v4XXsZDhziU1Y9ALtV+bhJOflARQHVojT/xZ+Ee?=
 =?us-ascii?Q?qPM7eCVjWYuLooD/MAthplUKQ0wFHusblYgY5UiRWA0UP88zBQW9usgqCtkz?=
 =?us-ascii?Q?3ac3MMN4vfFn61ne4ycMAmU/zXOu55Ks8vgBU6TWwvxAfJXwxpWEaSIe9uh8?=
 =?us-ascii?Q?IMx9Gh5eXRPyPSszd5mxh/sp5/fLDRXyERcJovnbqG/2d31En6ans6kCyVNx?=
 =?us-ascii?Q?9fLCNDuADdjjd/MawLBGPOU5SRYD0XKf/uNh7olbLbF/K9PEthk2n90qn6mr?=
 =?us-ascii?Q?hWlhasEboql0YlelKotDmGGmO+fPcO1E3h4tx/zz7gmyWVLVz6rpHXC8bBsG?=
 =?us-ascii?Q?Ir05kpLNZIyAr20XDgfKeodtMj12joIDcMCqa26LYlm5UNr6uvNuCyCyP+q5?=
 =?us-ascii?Q?LnNxIjDwUr8LH256pSXPDZ5JhRF5syc21R+jYn0rIieqdwP9c9Xy8o0hD2hD?=
 =?us-ascii?Q?yACddraKTEqYG/ErqC7RvDpqG0unKVdpo1+QcemcaHK7RJ1OBuh0cUWzgA3N?=
 =?us-ascii?Q?l0SEGqKoF3mMQ0CsEcjpIak3+2pV//wY7NoIO2iMS2uFbjp1Gwr485wlr4Jc?=
 =?us-ascii?Q?TiwMgbn9HrL/vj1idOYJBnKcIWJ4ajYqiXTSETuBjKJ6awNms8eqOVnBvHkX?=
 =?us-ascii?Q?TfFWtQatDFi76uFDXFW5bkUbD+CX/1Nhlz4TH6Rw97kbJ82IaNYdyyV+2EBg?=
 =?us-ascii?Q?JqdMX0WMip+yZaFKtFDrVFEJpLt4GVdB0fnjyy8ZBr4+hVnBC/jRvs0Bbbst?=
 =?us-ascii?Q?KVThMBTeotf/UXcCUMWi/VnpMhS4GjLvIcUtUoCCYtrrKJwTnU9nb/uZBXA0?=
 =?us-ascii?Q?ieTA+srOEUbXDOwDrV2Jwqn1MSpuU2ipk+rg0Sbi20QAJ7qKJ3vJE+HXHszV?=
 =?us-ascii?Q?N2x91wpvn39L7opeM3+7fJqOKU2Gnh61R4JZKQXqrG/g9EoaBt20d0YHSpgg?=
 =?us-ascii?Q?w/CPwSeg1xnf03AlaUzD8rqHtv32FLQEeNBPKBkHYl2xyI12B+13yVafzH/7?=
 =?us-ascii?Q?Vnr178Uelof/vA1RoaSsY6iUqHnILzMGZPFbumy/D/wxkPp58O8Kdq7RAD3u?=
 =?us-ascii?Q?nHzzriyMhXnsIIdAZjyqQ4G2ufGziqLuKBK8VoRJu472ppE7Co3eKx1siKWj?=
 =?us-ascii?Q?T5N/6XhfVw=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 477d4d2f-ccda-4706-a078-08d9bebbeba9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 04:40:57.4372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTofUIvkHs1YIIjbskCvn4Jmq+N/FzAYEOGgdH1M/IKoC0NukoJ9aVP/RCGbXjxgdwzAnKNc3U3AuOI3+uWlNt5pwiAxqTwhHXo+v9A7pkS+tVOfQxzM7ZlLxExq+11y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4153
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI for Arm Components 1.1 Platform Design Document v1.1 [0] specifices
Arm Generic Diagnostic Device Interface (AGDI). It allows an admin to
issue diagnostic dump and reset via an SDEI event or an interrupt. This
patch adds support to ACPI/AGDI tables.

[0] https://developer.arm.com/documentation/den0093/latest/

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/acpi/tables.c |  2 +-
 include/acpi/actbl2.h | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 71419eb16e09..5e3169bcb9fb 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -500,7 +500,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
 	ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
 	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
 	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
-	ACPI_SIG_NHLT };
+	ACPI_SIG_NHLT, ACPI_SIG_AGDI };
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 71ca090fd61b..66ca85b9f5fe 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -24,6 +24,7 @@
  * file. Useful because they make it more difficult to inadvertently type in
  * the wrong signature.
  */
+#define ACPI_SIG_AGDI           "AGDI"	/* ARM Generic Diagnostic Dump and Reset Device Interface */
 #define ACPI_SIG_BDAT           "BDAT"	/* BIOS Data ACPI Table */
 #define ACPI_SIG_IORT           "IORT"	/* IO Remapping Table */
 #define ACPI_SIG_IVRS           "IVRS"	/* I/O Virtualization Reporting Structure */
@@ -237,6 +238,25 @@ typedef struct acpi_aest_node_interrupt {
 #define ACPI_AEST_NODE_ERROR_RECOVERY       1
 #define ACPI_AEST_XRUPT_RESERVED            2	/* 2 and above are reserved */
 
+/*******************************************************************************
+ * AGDI - Generic Diagnostic Dump and Reset Device Interface
+ *
+ * Document number: ARM DEN0093
+ *
+ *******************************************************************************/
+
+struct acpi_table_agdi {
+	struct acpi_table_header header;
+	u8 flags;
+	u8 reserved[3];
+	u32 sdei_event;
+	u32 gsiv;
+};
+
+/* Masks for Flags field above for AGDI table */
+
+#define ACPI_AGDI_SIGNALING_MODE (1)
+
 /*******************************************************************************
  *
  * BDAT - BIOS Data ACPI Table
-- 
2.17.1

