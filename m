Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CEF4F9DDA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 21:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbiDHT6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 15:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiDHT6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 15:58:03 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456AC25719B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 12:55:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PB5dQV3LHW8frhAHrmw4LLkmujlfQO3LhjtJztvkrlx3vTx/AVmwiGW7KJTf2uU1jMl3YkrSEjP241B1bKdAFF+ztDZG75PzAmC2ZxxmSNL/ks3m8TVep3Oj01N7GqI0LoyCIz1npvfamgEIhkty2djbOvuTxp6YW/ISlS+xtStq0NrEOrYKbn97+pZtI999FV1RxtcJInxH+WVxaHReJ8d4cHwPqHFJoNWXNVWT6vFrjsniF5tCqJv9KxxnfwrqqQhxaxLU5tbldwG0agB+A2eJAtCMDriQ29dvUMGpIgxLrPcDyIIqiQPKmDP/1PZwEUnZ1NV6HjOM/aWppzYflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rF7R6Rm2xIKug/wl/A28Hchuk3NR9FTSd69Kb6EZJV4=;
 b=LTHSoxiHo3XpWqJY1igr5ryXuCB2pSfVLp5+JIlnByFWAyZbdAsnrAB8ue+REqXqikQ2+UfeU3OS2yE0vgBj1kpYlPuDY0f6+RI6grn78s2Av/uCTUzyvj4Q5bCxxlWiQtzhYNlGaqGe3hBZ/RgwIonSeEQc8tXR8aFd5WN+wKk8/i6KhnFM+jmu0UesyX22xmf6su8RAD1A7Pd/S/YbAMoWWfJU7g7bWCOyTaCBQkqwKOfFWG/XTyGLpjVy57IHF5HFCv1Ehk/s/aCpsK1HOlPT77Z/BLVwTK42wB1Rfv+XGAVU7X/vCl40V5yB0eMehRaXVQnlpIOQLRUAgvf1mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rF7R6Rm2xIKug/wl/A28Hchuk3NR9FTSd69Kb6EZJV4=;
 b=bVZGFYczPONic9l3z1WaTh77CWOt0vLbP44sFGxaS507deJjZ5+ky5D+S3b0MHL8sIlNbYAX8Z0tUXDLs73b8Of3Y7skzCVIqEkAojZlkeG1NxH9MUd1vHtXJw0kxwE6o04jiNHxhaMRtq39cCAp4ISKNty0oUYFyUB2k0Dh5mc=
Received: from BN6PR11CA0016.namprd11.prod.outlook.com (2603:10b6:405:2::26)
 by BN8PR12MB3539.namprd12.prod.outlook.com (2603:10b6:408:9d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 19:55:53 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::80) by BN6PR11CA0016.outlook.office365.com
 (2603:10b6:405:2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.25 via Frontend
 Transport; Fri, 8 Apr 2022 19:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 19:55:53 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 14:55:51 -0500
From:   John Allen <john.allen@amd.com>
To:     <jwboyer@kernel.org>, <linux-firmware@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <suravee.suthikulpanit@amd.com>,
        "John Allen" <john.allen@amd.com>
Subject: [PATCH v2] linux-firmware: Update AMD cpu microcode
Date:   Fri, 8 Apr 2022 19:55:39 +0000
Message-ID: <20220408195539.168011-1-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1486d6a-ece8-4355-11a5-08da1999c9b1
X-MS-TrafficTypeDiagnostic: BN8PR12MB3539:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3539043A139B358AD97E7C2E9AE99@BN8PR12MB3539.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bcty1QJHoRgcCa2rpUi9pI0rkbDUXJVaa7BtC41WVINu0ahz00tMu5IQQR4GwvZwAh5W5vGINqqt2d+58hscChaw6ZSDaL+0oXKtBXnhr9WpfiXDOja7Ph0O5cP9Hu7Pc5JSl1NZS77YV5X7OZWAe1t+k6A4yeuUBEkwwPwFPAmAPN8wZAgZNjPZHmGZoZESDAJlSN6boUztBb5TXSxtlQTi0RyK+Ll7nNdLyWLzb8mDc3JtAJGqvYUbSQO7PmTMq83VdtvoTeDser8Vxftw4wAA+Ds5RzGqntvovjVlQ1dvM9EW2XLJPsPKXMJi9+f9TnTK6GhZabHbHSVGsfmImMmFB91s9k8MVIe7tVsjKK6kzP2J57AwO20NRxISsHkLmScCkXDrynKNtIWOTDiDIKv1+pcK5N4oKLDpZF0mUnaSjHd111PY0mnV6nuewjXQ8j244ZaQWoJVdCI44U91oDMKwv+ICECnkFZwNAHVj3lZEjj0gzj18jPt9/7I9TO3C6uQQVt/ncqk8IcABzhoV19+qCUC/K24qoz3WX/d9iayz/qf/e1aGFwhfLe0gFVG7w5YOcarttJuSLX1gnA4JijAEPSD4unDYVJbtywDuKUHQ3Ewelqfe0Zw3NXxJRUcrJB4q78HFGFcXv4RzVw4qcInDPcEDvKPq5fbxGclROMVfbA8aTwiceEALH+gJ/qxK2Qc2RUYyR2E/D7xybKgAD/9J4m9fLBDQAl4UvMEr84g3BHUgvtXwtGHN8rjKGt3
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36756003)(19627235002)(30864003)(40460700003)(2616005)(86362001)(26005)(336012)(54906003)(83380400001)(508600001)(4326008)(1076003)(426003)(81166007)(110136005)(6666004)(316002)(5660300002)(15650500001)(47076005)(7696005)(8936002)(4001150100001)(36860700001)(70206006)(70586007)(16526019)(186003)(44832011)(356005)(2906002)(82310400005)(8676002)(475224005)(36900700001)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 19:55:53.0237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1486d6a-ece8-4355-11a5-08da1999c9b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3539
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Update AMD cpu microcode for processor family 17h
* Update AMD cpu microcode for processor family 19h

Key Name        = AMD Microcode Signing Key (for signing microcode container files only)
Key ID          = F328AE73
Key Fingerprint = FC7C 6C50 5DAF CC14 7183 57CA E4BE 5339 F328 AE73

Signed-off-by: John Allen <john.allen@amd.com>
---
 WHENCE                                 |   4 ++--
 amd-ucode/microcode_amd_fam17h.bin     | Bin 6476 -> 9700 bytes
 amd-ucode/microcode_amd_fam17h.bin.asc |  16 ++++++++--------
 amd-ucode/microcode_amd_fam19h.bin     | Bin 16804 -> 16804 bytes
 amd-ucode/microcode_amd_fam19h.bin.asc |  16 ++++++++--------
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/WHENCE b/WHENCE
index 8f37cc3..6c36604 100644
--- a/WHENCE
+++ b/WHENCE
@@ -4132,9 +4132,9 @@ Version: 2018-05-24
 File: amd-ucode/microcode_amd_fam16h.bin
 Version: 2014-10-28
 File: amd-ucode/microcode_amd_fam17h.bin
-Version: 2019-12-18
+Version: 2022-04-08
 File: amd-ucode/microcode_amd_fam19h.bin
-Version: 2022-02-14
+Version: 2022-04-08
 
 License: Redistributable. See LICENSE.amd-ucode for details
 
diff --git a/amd-ucode/microcode_amd_fam17h.bin b/amd-ucode/microcode_amd_fam17h.bin
index 259560b22abaa670cd08db36f23b8cbd20f3efaf..dec3871929a36792a261578aa834e807b5bea77d 100644
GIT binary patch
delta 3442
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
E0a6>C*#H0l

delta 496
zcmaFjea1-3#n+Jm1Pp*!h`#~E1OuT428JdiepAClD>=r1$q#v?>wR_hwDGFuGx2GB
z5Dq`6rEn>IUnSS3N^9T7Grp}=?s>M)teT%3_^@`9Z|;faO?7K6AC<4DuMudy`0(+@
zW4TB7w$481zNOM>oy6w{Z`}o)Bu<ND_a3_`)%t!%<kM|0KNK(7^Cn(h>HWU$5Q~Yq
zfv=vPzSrB3;+=aZXMvyxdx&rSPsZ#Z3$Z2NWOgX`rP`cxnx&TWUTMkvlh0B<{ha(T
zb>T<%;-53Jrr0?8E?@go_t#5i|BYF1w(L6e;&qaYukWLaZb?Tr34V>3#D14;N2Tuz
z$z;U|RlMp|uK7=$8%_pCaP=L0wey1C8{spXHGf?fJ$iM8aR6ugnUtTapX8j%o+!!W
z$h`RvFAI}gfDi*mSIQ9{#<UAO|MezwZY)~FDV@g0^;5lui@{;CoIu><FU$p#-w528
zY{Tj~nODet@)=eI#)p&NvZ`;MBc#AMSwTTz@(*r}$t)r{lQp;$Sf0xZF-)E!k~_JS
zQ=a*ae9&ZN(XEqxxD=S*$_q`dXA__7#m+TZMyznMqJlij-TRU(AQKqhPrl2k%=m6H
jBbWN*1~xIEBBRME;x{I5;m(;{z$G#HfW(rGAq_kLNXyG0

diff --git a/amd-ucode/microcode_amd_fam17h.bin.asc b/amd-ucode/microcode_amd_fam17h.bin.asc
index dfa782d..f5b1e4d 100644
--- a/amd-ucode/microcode_amd_fam17h.bin.asc
+++ b/amd-ucode/microcode_amd_fam17h.bin.asc
@@ -1,11 +1,11 @@
 -----BEGIN PGP SIGNATURE-----
 
-iQEzBAABCAAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAl35JHMACgkQ5L5TOfMo
-rnMUEAgAkjo5AlcQNp42b/JCJFYxVn9iaPsLrJ83yfDceMn4su30oErnlyXf8sYR
-vphA+qkowfcpT2ZUngMxxywW6mRnvErx2RfT7UM1kRjDnLcJPHWu3e4gBg/fcsxF
-D0H7FkZkSo/bRo0O04TeujNawvL7rTvwIgPHXVQ3n0IkLLRvyz8R5B4oxiybOm7D
-hW08eshMgsBPNypbgO3rtsDwrM3Md/qoIC55wnrqI7N0Qul3oe+ORNx4PdcWYcey
-yfpjAaiYEot24WIWLBzd95lzCircEuPfL12gxKE7MwwHD/8mjj8R7aB/J/oKSSyU
-o3ffWPN+V+9nqKGlJlVrbAYz/6kucA==
-=Z0EC
+iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmJQi+QACgkQ5L5TOfMo
+rnOMKAf/T14Ixwan/IPPOEZHhsB5reCrEWLM89hey7z3vn/h8RWLAfJnAQwTuv1A
+B18gOWwUQMNARsoeDQZnnDvIQBB4w/DpzAaoWBoPnUR8Ko9jdl8ou7aUwdJzYC4T
+h6+LeSmHGhQ/h7AIJWABplXJg+weYfQiDr9u/ulFsZdCvfBx+8USNp75HddVTXWr
++SunY5MrUZKmQvj147fCojByYVGzNCkWHJe3V6obd19kubTT357QwUX8A7/ZwgYO
+8DlxoVbYg9X224/7Cck6dECE9jKbmaVJkmdMg6ACVirjDH5U/HAACYNwwcO2olPn
+BOxF9sZMYY9cl14WCj2R7WS+gEjYWA==
+=pSDv
 -----END PGP SIGNATURE-----
diff --git a/amd-ucode/microcode_amd_fam19h.bin b/amd-ucode/microcode_amd_fam19h.bin
index 521ef1bb0b7bc81fa85362ed47ecd39b8b23653b..c99e86d9fe533d10a2001a6c8dc0dcf3562c17f7 100644
GIT binary patch
literal 16804
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
G?*9TO*nZ^z

literal 16804
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
U9ji;aLys-Iv(-r2%OeT>Uoz4qHUIzs

diff --git a/amd-ucode/microcode_amd_fam19h.bin.asc b/amd-ucode/microcode_amd_fam19h.bin.asc
index 3e09f9f..f455758 100644
--- a/amd-ucode/microcode_amd_fam19h.bin.asc
+++ b/amd-ucode/microcode_amd_fam19h.bin.asc
@@ -1,11 +1,11 @@
 -----BEGIN PGP SIGNATURE-----
 
-iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmIKuuwACgkQ5L5TOfMo
-rnPTJAf+JBd85Lh7Tk986BnkDCx/ixqnrlMtg6ZzmvoCAYq6H1f1npP1o89eNpES
-4FxxRRLU2ssIxix3ZWbCDyK/bxMEX3hPiScIgX4A4eNYGwDTkxi160EbDA3+S8mv
-Eo5bhVWjV884cnyLjaaHSSOWMk+bfQYRF0VjKDmfvbWTh2/EStgZmOQ37NoEP8+Y
-YytecT+mJIJI7qRrVSirTh1Lo1LSG5cF4I4+ZBP7D69/203cTQ/bCjplbi26LNx2
-CbjiDp6o+HR27sWIAi6NouvriQYyiumSnGrjj/Y5G1UI0/UvQ68/jHYQFBp7YN21
-E2EMnVZVhhwTGVTD9zTN5ClJhEJWwg==
-=ahzb
+iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmJQUh4ACgkQ5L5TOfMo
+rnNRwwf9EZ0S/qgZu4YdO4JPF1+86Y3C3aUdNk/+dyWHIc4yOQg2TvDY09nNmoKl
+p4JTzmjw70PfRDV7FnkUtv5j/D0aiKWmAoUewZV0S1gxYSYgiC8yAGEH5samFqJe
+UKuRYapPMT6ulyWcVEWQtOUx3EqDTodN0XY+TX7Rs83HOzRUlDCqwFdt1S3ZtkcZ
+f4r41IqQidYYsdFeDEjTXrLc3XHv8c15aIEjQntQWWwV6ZrOFkJskFlLPfrW8e7V
+lF8LP3RjKsnoRtrxOxCCzOBu0qgq/hZpaQkkFpm0KtLMLH64O2c8XTsZTiI3X3lu
++XTsmm6QiNmzw6RYRiE27PoJ6nbP2A==
+=Y4UB
 -----END PGP SIGNATURE-----
-- 
2.25.1

