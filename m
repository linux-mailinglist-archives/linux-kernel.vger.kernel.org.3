Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A0948E6A7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 09:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbiANIiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 03:38:06 -0500
Received: from mail-bn7nam10on2088.outbound.protection.outlook.com ([40.107.92.88]:6497
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234295AbiANIiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 03:38:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5iwuURV/4wos0Gp4QGjMNav09hM+rK16o2Gdgmi94skWvfNOgTjs+GkU2INN2so43U6qBuUBRtGtxRyLTVzb4xeYGPk6ZLD/Z0X0o3hHcSfpJIp/58RCAeSuXa2hO6sNZUFAnv56zn2E3gMUGJomf+iY7Ii9cz8nsSI6MZbo+KA4fGrXGsXOibwJDqnial8KivzuZSVWKqseAy+6PY8kTMPAVGX13JR+P7pSN2Cs6wK1b/ZbZmdvUkD8hYhoe6FNsxKFQ+abTGijWHa8zGdv9D2oX6KC1O+twN6iZs0R/k86JBuZy3eYOgxy7/CS/9IQzSY7pNULwmnOfK6q2HK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zot0dREm19ZOCKxTPnABtSy0TCjrpXWcpjYf7xDi3/0=;
 b=d2tSUAAvlJYMMbyUILUD6ST6+VFsxy2a/ahjndsFxDb/EY0UAtAmrGe5IywYzL92lZauERxSpG7OdSGnV/8l4m/YHsI24CirK9OhgMrMMZKURLeFNmvXCaDNSbWfNkPSR+S8QowRMmLkPfrERNqAZrhi1kS44QnBG6eZ0qzdStRJWjZeHDqDIPoVvZYXDvF+cA0Pz3yDa0R1tG5Q3qE9QajvmTfrbSb1kiWD572yaFG1GIW7AYCDEbbwBDK3Gt6px2RxFCv2e8bK2YRp8BQvpheiM7Hc1LHEqPsjleH3RBWHGgmEajD2uXCJytjO9gB+XKjnj+unLmL3uTJwdyJBWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zot0dREm19ZOCKxTPnABtSy0TCjrpXWcpjYf7xDi3/0=;
 b=ulvMYrhPTsX2HusdlE0yptDy3+eXNx2AmU0W5vQnBhDbCtpLcLjNe4nxyT9NnzaoWoPZS4edBeMaL734xexsezEAHLEKruv6x4lSnnN+/VRPB2WTGCoEFXB5QYPqIZ57tCBFbmnRp/usijSQRNQLHw1lefWxiMN4qTtSelrSRM4=
Received: from DM5PR07CA0031.namprd07.prod.outlook.com (2603:10b6:3:16::17) by
 CH2PR12MB5564.namprd12.prod.outlook.com (2603:10b6:610:65::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.9; Fri, 14 Jan 2022 08:38:01 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::77) by DM5PR07CA0031.outlook.office365.com
 (2603:10b6:3:16::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Fri, 14 Jan 2022 08:38:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 08:38:00 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 14 Jan 2022 02:37:58 -0600
From:   Guchun Chen <guchun.chen@amd.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
        <longman@redhat.com>, <boqun.feng@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC:     <christian.koenig@amd.com>, Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH] locking/rwsem: drop redundant semicolon of down_write_nest_lock
Date:   Fri, 14 Jan 2022 16:37:42 +0800
Message-ID: <20220114083742.6219-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ab5082a-d53e-4968-9ec9-08d9d7392c90
X-MS-TrafficTypeDiagnostic: CH2PR12MB5564:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB55641BEE360E32D553BD31D5F1549@CH2PR12MB5564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:462;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PbQ/ma9V4qVDqdn/nhagZUqzQeLf8mtsUlawO/1rmiSUg08/4kq9Tpb8NHtf0oJp4ovi5faHeG7r8Oy1iCTH8mDM71aP79D0mBGqUxGyMs1v7bVXFgEvt39NPlS5Xt6KPG8Y/NetoLsnezdQ9qs7Nd8/uev+lOfFQnozC50UjIeB6r6N7TIFgne7XlwFDp3sNniwKYa+2ZDbGvgGROHYg/xjHbARD8aT33LSlpA33oxCn34X2+8q7wSpA77d1Vxux80h5pC66Pxfny4IUygxMcVkm4iItalJg3sBSMtzIPpCp8Gid27KH44ikMPe/dIqk8DbVvHkNoY+JdHDPf+javCXnT4SKjfSQg2F8BQ3o7WAtdQzD00XGXmfgeqQK/xPh8Ba0Ip8luC2PqRPlAsFgbRLNz06oh/5Frxd8eSyasbjuo+4KQ2TgqTiEE2THNDaaGLQOGw38dO83G3apJOx5LaLwyUSUl20Ax4ECpoVaaKzCUUodosWk1xWRRJ7rZu9yYX52S+e8PPyQuM3vzr8U/OMOQtFmfXW9HEFuG5SFWu8dxtMjsK5DO+N77L0dkGe/hLdgbO/wZ9Ip32HmXpaoJC1sLXgds47fTxvBJtPwoohOLA1tpgUlL/gaFlhVajaYb6xnhlDJlVUABef7gtlO3A/FywIxZx1p5ddc95t0SLZ4IXDZh5xXZki8eMXTZIw6kpd1umwPVmWwcBGJWeOEzSlkDyTsLKkRvWgzYY++N1ek4R9rSISSKoUXSxNdMo70OjjjsD0LgV4SR9N3lPAUewqXj5/l/kex6meGLrb9NQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(2906002)(36860700001)(4744005)(36756003)(110136005)(4326008)(8676002)(54906003)(83380400001)(8936002)(7696005)(26005)(16526019)(426003)(47076005)(1076003)(186003)(2616005)(316002)(86362001)(70586007)(336012)(70206006)(82310400004)(508600001)(356005)(6666004)(44832011)(40460700001)(5660300002)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 08:38:00.9637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab5082a-d53e-4968-9ec9-08d9d7392c90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5564
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, braces are needed when using it.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 include/linux/rwsem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index f9348769e558..efa5c324369a 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -230,7 +230,7 @@ extern void _down_write_nest_lock(struct rw_semaphore *sem, struct lockdep_map *
 do {								\
 	typecheck(struct lockdep_map *, &(nest_lock)->dep_map);	\
 	_down_write_nest_lock(sem, &(nest_lock)->dep_map);	\
-} while (0);
+} while (0)
 
 /*
  * Take/release a lock when not the owner will release it.
-- 
2.17.1

