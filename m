Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4DB50D73D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 04:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbiDYC6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 22:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbiDYC62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 22:58:28 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2112.outbound.protection.outlook.com [40.107.117.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316D1655A
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 19:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnxS7a/RvGESfbWLcDbAW8/0LvCjbekWfQ5gn6k88LsIQCRETfKRzuC4upIdgDI+xkHjlYpUzCxL/DT+0jw+E593xdig+J5pqtUkWP6PXFGvYK8O49W7V8K3yOfXNfHG7bSb2QD6Si7k7saQl4IXQmX0XEIE2PyqTkc9RyvpvBE1VWx72eEPC0SHUBf242ge7J4tahuA//d15aCKJl32l69iS/RqML58fcUi3BMFqxRhxIiS66NViJGGzY8hAsYThWj8azwufWUJbyLkOwFTr6KCc7qpYF+zTqed9SskjXwOPOgDhtK1ICu792xK2vtd7ePllM3P8feHf3DfhD5sag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lv/r4q/IBZvglTRLo7rf9TakAKw9tn0fyVWm5bBLjuw=;
 b=HN4PdX7MjU4SMYnxzytCOa9+HJl6KNccFClHe5UUgMCf6bExD79Iaq2hUuSBP/1zAmlJ38uLtUcvD8xCBZW/PM0I6Zn6EEiVqRG2g+0IZ9r72fSJ9WY7Q8V7s+5+gJxrphzS0VAzWWuMNlkAXZwh3cuSjzhwA0Z1uVH63RGAOwkkphlgtXnnqufPNaNnoMpGDUqgns8iiAmx51on9x0Z7emtE0k7TFJX5iODV/OZ6mlkRlMeov1Ll7igu7Z5lZy8kgkU4xTE1qC/os/Wi74aeVJ3pXBYeEbHh0RtByPdX28UgqKovdZlFOGiRF9avQorCw1XPgKkNXWoQYVzzh3Bvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lv/r4q/IBZvglTRLo7rf9TakAKw9tn0fyVWm5bBLjuw=;
 b=ROod6lpoIiEeWEUhglHrhJVbjYGcbhL8Bcb4GdORkVCP6jzflUudhD4EBBxttl932+9B2XYvm1usAquBBvrjifSoo+wCya5GgVlvsye+WbEHnotQAoEeLErUHmgSbM+0pKc+aSYh8Rp4s1TV/UoIEslg/74phx7lqkYvfqdmc0Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SEZPR06MB5069.apcprd06.prod.outlook.com (2603:1096:101:44::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 02:55:21 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 02:55:21 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     vincent.guittot@linaro.org, peterz@infradead.org,
        dietmar.eggemann@arm.com, Wang Qing <wangqing@vivo.com>
Subject: [PATCH V2] arm64: add SCHED_CLUSTER's dependency on ACPI
Date:   Sun, 24 Apr 2022 19:55:01 -0700
Message-Id: <1650855303-91388-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0045.apcprd03.prod.outlook.com
 (2603:1096:202:17::15) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f56b1804-4900-45cd-82b2-08da2667099b
X-MS-TrafficTypeDiagnostic: SEZPR06MB5069:EE_
X-Microsoft-Antispam-PRVS: <SEZPR06MB5069679B70E6C3E9AD987D4FBDF89@SEZPR06MB5069.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KY/JtkoLmniGaHOoJhvMSadHX2sPkXNcBZI2nx/KVdy9w+g1jWTLg8EkRwj9clv3S/jTspom+4qlpa+LvzPJ+ORBuGMaLYCUiup3rhyrYf0bpysGDz2RCED7FtuAwhe66ay05oMnzFrWzHw1zeLsBFDKWdUc5mzGiipz4F8ecatsIajuoI8tC+u6cF48UWvpZWDbqcMF37eTuF9CDg3KvXDN5XPC7CDTqxZcn1L5YmV66Fb6Oc8DzoTMTqpHPd34TuCJQRvyKXhW/gSRiDwiwUJ5J39j71lINeaWa8q82ECIyyouQ9KjP1Vc7ZYg7iyod6geR35cAtRPHn7QYr6D+n7SrNO9oJyvGcwV4J3eMVeH6ACfDoRGTdDGsxXUWWg0xTfOxR+tVYrYjc9luapURUsdqGNuJd5nXVVCWfqZ6T+gCVGeGQ8zNn11I6vs8rhzSPwi1A2jwKjPF343BCHRbIBzvpJzLJ9ZecuNH5XLeeU79lLLwGGeLbP9w90kAFXJ/H+rrtiJXjs3nrMFhugB2hdJULyD7YBOvx0QEi1u5c+5S/qfiJUX6tBYxNthjMOwn9eHlphUw3huiCbszyr1wg46ULXsBPXHdARjXFn+Uydj8mJqZjLQJXZyRGo8xyqA5V77M+vML85nH4amA3SnEm/LOGH9N+o1+pBscjIgoNlmrOKr3XbiuCVLHi3Zc/CyEJyLICzIe7nZ0UkicghWgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66476007)(6486002)(2906002)(107886003)(8676002)(5660300002)(508600001)(2616005)(52116002)(186003)(38100700002)(38350700002)(26005)(86362001)(6666004)(8936002)(4744005)(66946007)(6506007)(66556008)(110136005)(316002)(36756003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?egrvvYNqvlHS/NvArFCTFSAJ+RcjsEDU8g/y42yLd2O8mD6+K7dS2+nSCpfK?=
 =?us-ascii?Q?IGf1QIeawxuwa/mgYJOLtnA45FlWRBKY+r/kxEP+TOz/d5J3SQPHi3L2aSwG?=
 =?us-ascii?Q?Li5MIyV4X/LTHl+qC0mlydgvZnlrljYVkhkHo+2gMPT6KSJi9OhSpOqpWGFG?=
 =?us-ascii?Q?79/1jvNL/00H9G+f9LhyX9YC9Rajalg4zgce6y+Z0XP78q4h7Psz1TpHIi/+?=
 =?us-ascii?Q?KyZHPbUkTX+TnC4E9lZ7u0Km3+XgDB3cdlqkmLuxggoMXfE32vtjxnkm4OZ5?=
 =?us-ascii?Q?CZk+sFnBTPhnnEhZLFj8pYwfgyeJBC2OMNFkyYDFx3jMYDfnroAoLCXv8p/B?=
 =?us-ascii?Q?G78jOx+I3AiLZ0Z5FrQbVQQmk1ljFu7HhLYEcRG51XngJLmDey/I60ywxHDt?=
 =?us-ascii?Q?sqJl+6yPVVgJCky9GkMy7bJAVf02LpxzzauXqiG8cml2oMcyzEydZtCLPWik?=
 =?us-ascii?Q?gGUWJlAQ1YZFmW7BB4oNpSXOZycAzX+yg1d5FwC1wwynNhR+LojlivoCJJQs?=
 =?us-ascii?Q?f75RsrBwC5w1h1JmxH6Mexq7PNkRz590ZL3yjg2VYP2OgV/jMIk74xCgsRp2?=
 =?us-ascii?Q?Ey7L9sY967pygpChtwvjddivzX90o2lrvQqFRrywiqku51+b6g3mRXRTDauk?=
 =?us-ascii?Q?yRmoWecOJkUMXOoy0a0i15R68zzo+CNy0fEerJn0bN9IgrcPFTfyR6lbXLpE?=
 =?us-ascii?Q?eH8gNcLoQfFX7OKoS8tWgAG+GR/rwMRJJ6QzDnSL/EKY9/Sf4vbnbvC5nBSN?=
 =?us-ascii?Q?iU7HctOWhO4tYWeCbHsh67CyfBGHoNmLvvWmkokP96EEQiCP9M7HNSAE0SGe?=
 =?us-ascii?Q?4yEWSDHa1wLMbfWAJu7VG1Ny7Ckal/hnZCEMr87tKLvqRXQsvcwfqJ3ra0vI?=
 =?us-ascii?Q?AbCaLY8+vT4wWEvXd4D1mb9qj7aVX4ZVpFLK85A921EtuWqw9vK2tIuNTlVD?=
 =?us-ascii?Q?+7PPWVbOkQkIHYgqzXuNJCF/mL9wbQVtZIJCiyz0by34SKHrUFeDx0PCqfNa?=
 =?us-ascii?Q?EdujuH1MiYwaaYkxgmfE3deQSI6Gh2CWmkphauAgh5zY/NLWQ7zw9PYfoxVm?=
 =?us-ascii?Q?IhnS32Iwo9SXLscaltmROPy8tL+bp6v7DDoY/xggQE5+xjTIN9rmM8PN/g6e?=
 =?us-ascii?Q?ig1us6qZUaeSfA9weg7CM3VTP5oKmpSaAJYRTomMfhXs8JyAlg/ZB6SAalXr?=
 =?us-ascii?Q?jHaQPADuzRTDv+3CGgkSP3johPEKMk05A2ljAewc3Bdt9gA+24I9D7wAmyrF?=
 =?us-ascii?Q?s5J5ycQgZfBtkOe//NWYPxrQW/6xHyStLdQZxrr/6WPoP0AZMRRpC8ej7w4u?=
 =?us-ascii?Q?iYFITCBjppDCa/MhodbrS54Iz1r663GxcXyKs8apTdv4MnXHli4ENAkJxgfa?=
 =?us-ascii?Q?SGn0KEtHvRKetcuY5lypwag3H4M32AANUJYNcWEeomdhOzAcW6TaSV+Wiy4t?=
 =?us-ascii?Q?puS7Wlr08QNy/0U8Yv/HK3Jewts9rtYp7gZlLmHnvkCAw4zjd5yNwFrK7hzZ?=
 =?us-ascii?Q?9NHo+gTE2bbDuA651zJMSc1aPnDTEI/uWN9oqYncunyb7WsU9qsCihTlJV94?=
 =?us-ascii?Q?Wo3w53JtEq23TMzsWxtcsimL1Cinp26W1ThIX158HcCsaoox2Myvuiw+pn4C?=
 =?us-ascii?Q?5Oe+E52OvRuBCbIjNQQVOhEbSHUtZHweaSg5dSxdYkOh3qwcgpKr0cqokR5K?=
 =?us-ascii?Q?vhKBAOx6bJj2wccMCiAMpYp6AyRMax6RLV4Ek7XRHPJMDzjrb3teF5bVS73R?=
 =?us-ascii?Q?X/QwElbFNA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56b1804-4900-45cd-82b2-08da2667099b
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 02:55:21.3676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOzvVRFqi1ehKjJ6/Uh6htnIBHUmOhZkE+bkHG4XUNWBlXeg2hKOMhT7LayN7+MpVQJgqYcJcxy0OzZUDgEZJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5069
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

cluster sched_domain configured by cpu_topology[].cluster_sibling, 
which is set by cluster_id, cluster_id can only get from ACPI.

If the system does not enable ACPI, cluster_id is always -1, even enable
SCHED_CLUSTER is invalid, this is misleading. 

So we add SCHED_CLUSTER's dependency on ACPI here.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
v2:
- just modify commit log
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

