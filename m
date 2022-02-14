Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591654B5BED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiBNUwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 15:52:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiBNUwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:52:49 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2046.outbound.protection.outlook.com [40.107.96.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45FCDF27
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:52:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkdBz/WYN4ZZy13FzFSKtYYnarrqh0JUqJt7kY00vqRn6IKaxzReZRWvLA0WyHcFBwFimTn+PCrelULuOkRZtG8rsX89SmRYxu8MqhyQ35FelvCTbL8CkEieAgRGrZxAAgQKwyvg4sqclgu+FM5i7Dj7MZymjMZAl9xT1wAgdGIyI4CNGhY3+8NiZgAy3NjCSGxqTTAs83F8Q0akgqpWp2JfT7NRHilb6UDnU3o0cI+eDLmCGtLlgsMqjIHAuLsEAePsXemnXJa3HB7JQwO9Ip9OPa2P2LsuFvGWI4WJKPJkKdUfgD6fezplI/huvakpqxLBufI5mW+4YUfcljverw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czMfZqTCokzBjhsu6nqqiSpbafXQeK1xJEXdz+5f11w=;
 b=mtLrk0vaqEv2YvhHHXCgWZBXfcRoZinMBo6PJSAtuNyxMxHBi5Ov/uS8tBM10K9cOwzDDImg6k12XU11yb3tseaNXlrbsS36SiLBM7nkzOw5DbQM1IAxb4h7MCL2rVU4l0VwRmqwmn/4TJcnvqK7BwXqReZGaSZY0X5ymAoVBxoh1/be5iN5CGp5yH+ca6Gv7gBuZWw+a0puJQlazb5m5aSrxYBWzmLsK++S/9aA853FbvbIJGCLf7+ZKxM5Otn5xu4DlIYM0T5AaUYnWC/1QwlKOyEo+gWJp6xuT6JzysstD3K4nPHV0hwTBuPGfN6bXt/lwhjohu2d4NfGjNDJQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czMfZqTCokzBjhsu6nqqiSpbafXQeK1xJEXdz+5f11w=;
 b=VpyxCC0hpnyrkTLB9JmlnJmltFrjoSgXIXhN6gsG299+MIumtlUDRsczmYKN8lree0oGwAqLjW0mhJ2oPWVmmB8TtIiAxMFR3rAp73IljJL4DfCFHwJIwKI6QH6INw1fkU1U3XQeOax+CjH80iAR62NG2XaW4PGpWyT4O05pe7A=
Received: from MW4PR03CA0288.namprd03.prod.outlook.com (2603:10b6:303:b5::23)
 by DM6PR12MB3948.namprd12.prod.outlook.com (2603:10b6:5:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 20:51:18 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::6d) by MW4PR03CA0288.outlook.office365.com
 (2603:10b6:303:b5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Mon, 14 Feb 2022 20:51:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 20:51:17 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 14 Feb
 2022 14:51:16 -0600
From:   John Allen <john.allen@amd.com>
To:     <jwboyer@kernel.org>, <linux-firmware@kernel.org>
CC:     <john.allen@amd.com>, <linux-kernel@vger.kernel.org>,
        <suravee.suthikulpanit@amd.com>
Subject: [PATCH] linux-firmware: Update AMD cpu microcode
Date:   Mon, 14 Feb 2022 20:50:30 +0000
Message-ID: <20220214205030.96363-1-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc101e69-6473-4b60-2799-08d9effbbf75
X-MS-TrafficTypeDiagnostic: DM6PR12MB3948:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3948BD9E88B7CC2C9CDCB66B9A339@DM6PR12MB3948.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EaT+jLN4xkTHawWUPLLeOq9nNPEhga6ueF8X67IKbQvqHtZo2AHgKjf6mkcdeLZeJSgTxEONtgZr8QZUBxB4i8QUrSDVQxICYCqoMmvDcKho9/4uDBwvnOsXMNWrnqqSCpQvCR74FA0qkB1stILkG7MpS5FaxHn39lmzFczobACclcyc/jrjx2bpb6u1kHPT96Kgz+KiFnzpeUSFqMnT7EFzP0+tKcBTbw3t/acggrZQgrbW1A1sFpQ1weWjqAYKqDlj1NHT8UGF5Mldxsq+H6CfKK7DMdp0lhafCmRsDJZu5kQmjBFC2m96Tu0UkNEq6gYQ8RAenlXhdIv5JEEpeKKgUkt0viJoXrV+qwVy+6gcdD3CpwSt55Qu4PkiZ5CkDrmmSLqLZawZ5bLbesGkZgC3lEpAsJ/NZ+zdllQlQqnoIAGhr8MEfiWQml7g/5XrpBJ+BU3Lhg3xcbmYunYrKf6eLeghrLL8EVa2WOST7L53NMRzGdPptaGpUVd/XBxtBBVs0KAcI3LwfYTT7vuDwBjeK8BO+QXh+jZUwzMGnaYkXbIc9rxl9bl7GesV34ekRNYszY/k+oLRj68uLOEU2s/Eibavd7Bja/ZQwNtHZGQxUgVeltRdzSfj4MxCmVDbSXALgQWx7CNZt2QyzSHULIfKDWOW57dP+vRQI6NU6D4o6B1DOaoPx3yUiNjMUX5tTH0Ius2xPw28U66ENvU9jni3+oSGkQ6OqniA8Gj8xJTtUbDClOIE03q8rQUyO0YT
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(4326008)(2906002)(82310400004)(356005)(47076005)(36860700001)(40460700003)(110136005)(316002)(81166007)(8676002)(70206006)(70586007)(44832011)(54906003)(15650500001)(86362001)(4001150100001)(83380400001)(6666004)(8936002)(30864003)(2616005)(426003)(336012)(5660300002)(186003)(36756003)(7696005)(26005)(16526019)(1076003)(508600001)(475224005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 20:51:17.6029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc101e69-6473-4b60-2799-08d9effbbf75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3948
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Update AMD cpu microcode for processor family 19h

Key Name        = AMD Microcode Signing Key (for signing microcode container files only)
Key ID          = F328AE73
Key Fingerprint = FC7C 6C50 5DAF CC14 7183 57CA E4BE 5339 F328 AE73

Signed-off-by: John Allen <john.allen@amd.com>
---
 WHENCE                                 |   2 +-
 amd-ucode/microcode_amd_fam19h.bin     | Bin 16804 -> 16804 bytes
 amd-ucode/microcode_amd_fam19h.bin.asc |  16 ++++++++--------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/WHENCE b/WHENCE
index 932c2f9..6fdcb2c 100644
--- a/WHENCE
+++ b/WHENCE
@@ -4067,7 +4067,7 @@ Version: 2014-10-28
 File: amd-ucode/microcode_amd_fam17h.bin
 Version: 2019-12-18
 File: amd-ucode/microcode_amd_fam19h.bin
-Version: 2021-11-15
+Version: 2022-02-14
 
 License: Redistributable. See LICENSE.amd-ucode for details
 
diff --git a/amd-ucode/microcode_amd_fam19h.bin b/amd-ucode/microcode_amd_fam19h.bin
index dd48655c4b88133131e8673a9b1ec97885b2acc3..521ef1bb0b7bc81fa85362ed47ecd39b8b23653b 100644
GIT binary patch
literal 16804
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
U9ji;aLys-Iv(-r2%OeT>Uoz4qHUIzs

literal 16804
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
F{{pju6cPXc

diff --git a/amd-ucode/microcode_amd_fam19h.bin.asc b/amd-ucode/microcode_amd_fam19h.bin.asc
index 388b2dd..3e09f9f 100644
--- a/amd-ucode/microcode_amd_fam19h.bin.asc
+++ b/amd-ucode/microcode_amd_fam19h.bin.asc
@@ -1,11 +1,11 @@
 -----BEGIN PGP SIGNATURE-----
 
-iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmGSiQEACgkQ5L5TOfMo
-rnNNqAf8Ct6gPb0w5sYBQluqsylE8MKPQ5opSLxiklGgCQ6Qw3DzC7VMsLHpt4sT
-y05AcGNgdXaj/B+95zWf5q4DkImjL02Q8aT5dy2RNzI6Qfz4muN2cdDR/LcEIMIv
-cJky5Xnu+cLilTJ4/7fk/IfAzXyqpfiHU/OOub3Yyy0ExFIdX+b7vmDEnT6prp09
-+OjHU3vZRu54q1dI7S04GNIcI93yPUqmawBiqcHFy7mztoZdvefoA5K3/+hheWZV
-5ZtZjx8ms8c5H0neyWsPf+Kh0Mvdgo/RmhIlt486TILVABJbk0aIGMBzjmL5+tAG
-aXjIb/laJSlf3jPKCp+ZlI6nItlt1w==
-=qdN2
+iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmIKuuwACgkQ5L5TOfMo
+rnPTJAf+JBd85Lh7Tk986BnkDCx/ixqnrlMtg6ZzmvoCAYq6H1f1npP1o89eNpES
+4FxxRRLU2ssIxix3ZWbCDyK/bxMEX3hPiScIgX4A4eNYGwDTkxi160EbDA3+S8mv
+Eo5bhVWjV884cnyLjaaHSSOWMk+bfQYRF0VjKDmfvbWTh2/EStgZmOQ37NoEP8+Y
+YytecT+mJIJI7qRrVSirTh1Lo1LSG5cF4I4+ZBP7D69/203cTQ/bCjplbi26LNx2
+CbjiDp6o+HR27sWIAi6NouvriQYyiumSnGrjj/Y5G1UI0/UvQ68/jHYQFBp7YN21
+E2EMnVZVhhwTGVTD9zTN5ClJhEJWwg==
+=ahzb
 -----END PGP SIGNATURE-----
-- 
2.25.1

