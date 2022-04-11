Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204D84FB1EC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 04:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241757AbiDKCiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 22:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbiDKCit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 22:38:49 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2132.outbound.protection.outlook.com [40.107.117.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AE41FCD4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 19:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdxEwl+bYzb/5jMKhisqtNPAHrbOOPcdX31jGWtDhcinSjRS1UShI0RA+l8Lod91WW/sBTGuhG7ahaqKdCJVDvVaVuSanqodb5pvaxN+iybtWfvjE6pbPkhOZXazxbB+yr6TYtJr1vRF1o9Ri2TPjtgc5uOSdOclDV+RThVs9SSwqxnr6afTk7gKC8u82ZXGjUFlf6up6cllRv5mk6dvIXG4hRT9YMcUhanEwtMcPpgcOtSOf5q5JN4njnYuq8BMS5bgNGtDI6FMElF0UQq/MWlS7Zf1IkAbakgFwV2YFVGQjbTjMCHNe6t2yHxuonUfPzloplfqiTYhuX/n8jLjjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5psfVh8WyLeIpHXpvPTNCnXU0hPdANgAhA6YsqHn3U=;
 b=MjvIWrl6at3QmUDeeRa1BR9pi4sIQN0Vga5CztJtPvq6BQZuC3h5/QUiNsQf+gVht7grXZ3PG65ql/wFIqorHhzubUfF4HUuStkeneYEubWdMTsBS6L2tGDMVYOl0It/XzwsQloNB5vtxpj6VidpWvUd/EfvlKlFVoofm49L3qyW0UQHYz3C67W0jpTAp0jgf4zTSURVm0TpBsq0qhp5hoRIuAZ46KvCYTkzST2FvgadCGHRSaMhn7UT+6U/lyWPtJM8qD8LPv1//EWBOY2Zlo1qk/PhpdTNwdg1Ort7YUCHfQeITkSge3Y8PzT7C0ddrWGb1beLqDN0JoYU18nOrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5psfVh8WyLeIpHXpvPTNCnXU0hPdANgAhA6YsqHn3U=;
 b=i0dMLOoi/BwA4otk0CNWvAmszgPOgVv1jRN8WkRWUQay6Rs9c1dMJtvodoiQ7b34U5wPteEGvTEAdoXeo7PrVRSmrMvZhFRN592ZU4BVYsRpeqsff/P5UM1LPHGz3Qk9IGRxug/42765RBefTmAt6hv6fajtossC366vkxTSkH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SI2PR06MB4028.apcprd06.prod.outlook.com (2603:1096:4:f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 02:36:31 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5144.028; Mon, 11 Apr 2022
 02:36:30 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] arch_topology: Do not set llc_sibling if llc_id is invalid
Date:   Sun, 10 Apr 2022 19:36:19 -0700
Message-Id: <1649644580-54626-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:203:b0::32) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab5c9352-4bea-4825-8a0b-08da1b6415ba
X-MS-TrafficTypeDiagnostic: SI2PR06MB4028:EE_
X-Microsoft-Antispam-PRVS: <SI2PR06MB40288EEAAF0506AD16A963C6BDEA9@SI2PR06MB4028.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAZN3As7oAfYKQBOqdmITRC+ApTNmRFtVIdjHjIlVMhHS7rw4fe/TAo3Gd1BM4hY4eLT0hkg1nzDy21yFqhaeV0tspLoIeu9c7K/byqAhnNnbaK1WsjN8NzaWZ2jN5w4leXVo8UKG4hdUMZp5X40Pefcz7ndnBubjHOQKiPoC1YmtGUj9m6CCdNpTLNOBBlu8uew01oEQ9HgS6CAGot00o/eV/Sn5bdZEmUbQ6bsmovM2D7EQdOfVWPCcRlPtNrrpUmPxn24fm/oPfwenC57LcTHPIn1tVxA2SlpNAh0S9lbafUGpQl64X6+uToCd33sihUbdvlyCTohSulvMYHiBa3h5/P9efIvbl9fkm/YLQvC1+rXsv2ivU9hDFy2rhtXBXyW+KTIXReXk52O+oe7bqatzcmTEkW47E2JyS4LR9cZqanTf0lUajSu6zJdaA442KJ8hFXR0ZKfk49PJOXPVCRS+ae5qYbwWRJRxJZAnjv9l/cOb3NwV2RK2MKHJ7uNkwxJW6ovtXcJV1CN0qjUOZ8253O/9soz10ojaH95y16P0M+Le24H8pXVaudgqfHZTe+6kdM7iYxVZUfE79EPSP0t/HHQRVSMK1BLvWvY1pfreNc76FtbJak6+dR8WAedKz2ubyBJ8jwlPs/baRt5NgypGT982sycHf4ROSmQaHxWm9/6ckQ7eOk2aRwjxrfAQ2oMh+6Kacs4dZ9/+OdNwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(6486002)(5660300002)(110136005)(66476007)(66556008)(508600001)(2906002)(4326008)(4744005)(66946007)(38100700002)(38350700002)(316002)(2616005)(83380400001)(186003)(107886003)(26005)(86362001)(52116002)(6512007)(6506007)(6666004)(36756003)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h+BtS/Ntdcu3+8ggEZlAAjEHt+v2bhZ5n0bx0XgrV+T1ChbR1nYxpC0OncV8?=
 =?us-ascii?Q?WGH6H+TcLqB4jQWHuSLl7lA6OwWP18TJC8uC6ZdgwYZWXBaiU1Ca4ZxRFPwX?=
 =?us-ascii?Q?quXxHn1+WalxVuwINFq4aoQRlR2ggXwyjzP502UH9PmEybM78ligdA6GJPAF?=
 =?us-ascii?Q?EpZYrUVsrxvSahosrVhZy54+WV1cRe071C+sAmFJs/yZYdj/pFxXFLJzSNad?=
 =?us-ascii?Q?S2WQnHeeBDj6YXA+v1FusfjHOv35lhGXYayIQrrp6dYmnt8CX9Uw5lWYwbdu?=
 =?us-ascii?Q?e1qx9JOVhr3rm1JwFcbwj6i/ewfPLc6CAv3nuerntl3JiUtP/2xiVkQAq6wK?=
 =?us-ascii?Q?oqadxCCvowz3cJmO1Md9XkCUUziOCOOY2L3ouLqMWwuEoSCqADHNOODOUx0M?=
 =?us-ascii?Q?MPNCqMBXR2+9JN4CQYhUcXoe3Nl/jRqsuke0omboMX70froSH3KX/iJl1Yvl?=
 =?us-ascii?Q?I0RczmBZYmt8+uNzsVIlhzNDg0WykKA18r/seowK7mCMCqaeLhQakRg8fW7D?=
 =?us-ascii?Q?C3K5KI4BPM9QIjVDY50btsTg6HGTL+ecmO9ukTiaO9z9jy7yJkt7K6BNICD9?=
 =?us-ascii?Q?IqcrvnHh391ZywEUoLCUcxwIzzHeT3yaxGVsrftkuZvNDVKuS4KSFer/pzaf?=
 =?us-ascii?Q?A5UpHipJHc3JyZSyUNBobFGn0SK0Cn3zDwgGV2PARFfHrwKjrEJoc15X0vOV?=
 =?us-ascii?Q?SvQPt7qYWwy4Q87fn37vB2/5TMEiQv82hI5FphKiI/fK6zAtrWdAg7mpHXNN?=
 =?us-ascii?Q?UDKex3MMRhT7iUry/2hUixqx7Jc1LbhBLWQ4LGGYBuDNBaOJBFzEcYVtbIFo?=
 =?us-ascii?Q?+6M3PVlg6AS0zQ4LlMWHFs2pgxJm+D3UFcqgzYwYefYF0FHVFRPhTuOVyTP2?=
 =?us-ascii?Q?ogS5s+O3CpxxmB24ZM6d513CG5aZilfa1sm+q0M/Fh1BJqAzZG4c0cbtbVO/?=
 =?us-ascii?Q?C3oFr+g1wceGDwPyJRpO5QyTGumU7y7zRO/ajcXT6KlPbp9H/6SS/gGfNHv0?=
 =?us-ascii?Q?szBtcPOeiSC1H7n+C5N3ph/hU9fUp1MBoCO30TtYMY64J//PE2Q0YdabWIZp?=
 =?us-ascii?Q?fy5YFFW/bKnvI+1aZbgsPTHBJfwkSf3W1CCzYTyde7vw+ZUrEBd4GhctEyNq?=
 =?us-ascii?Q?j4dUDBFwezm0Megx8uavfidHEyem/qXqZuDWBVP7weQuWzwXb0p6OhauHUTZ?=
 =?us-ascii?Q?ATyKFmqB2qwGmrjqLM8Tpsv8liHWVeyG1/J+gD+RdGYpQlTveMuJk0gtLBKk?=
 =?us-ascii?Q?+EsYT7B9gWJOxNDeo0gKdk3SZ4FMynAX8ZzJZccybJpuBV6B/Q8Cex/NZOxc?=
 =?us-ascii?Q?2tiTDQGWfdOYMpTx5YRCVa13s15Y34OJdqj+9v5PkNnKMjHNv7G2ThTlySKR?=
 =?us-ascii?Q?rGqBeTrGwEfcBc+yDwzVonfLAqa6G9itVEOnNV8UARTCuSbFlJVhBirj2dyr?=
 =?us-ascii?Q?+gJpEVPiOpT5/3R9VYieKHN5uyUXC+O1kX9Tm4XHHx+kctMHxFvF+7mWO6Xx?=
 =?us-ascii?Q?zrj+Xp4SPJOv/SLI23yX40fz70SeSmbo52futQlO6e7PV35+YVOpjlrlJ6rg?=
 =?us-ascii?Q?fS1wc0ucdZM+s/dP9YHXGeczjnk1cQfwKqeAryFFrsdXVhdzp3fOW70YA1m3?=
 =?us-ascii?Q?6NiOmjfuJ4z2Npnv9rS3tbN7iLZapjp2moo0dh5ScHrvYzW75VB1Kji6wYxJ?=
 =?us-ascii?Q?IyvSrfDD+Lr8LqpsBk9MLCfUFZZzqrKrXKjRaezV0jgBTebMeHe80Pw3csN7?=
 =?us-ascii?Q?tiO5AP3Cdw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5c9352-4bea-4825-8a0b-08da1b6415ba
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 02:36:30.4853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9eXq9CIDOtQTTVmLLrMTYBs3B+y+ZCWnJyP2TDFLbQQwiP1A/mfK9BQ+wd77xtb02gqTtLiHT9A7UQtKk1ZC9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4028
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

When ACPI is not enabled, cpuid_topo->llc_id = cpu_topo->llc_id = -1, which
will set llc_sibling 0xff(...), this is misleading.

Don't set llc_sibling(default 0) if we don't know the cache topology.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/base/arch_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1d6636e..5c3a642
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -684,7 +684,7 @@ void update_siblings_masks(unsigned int cpuid)
 	for_each_online_cpu(cpu) {
 		cpu_topo = &cpu_topology[cpu];
 
-		if (cpuid_topo->llc_id == cpu_topo->llc_id) {
+		if (cpu_topo->llc_id != -1 && cpuid_topo->llc_id == cpu_topo->llc_id) {
 			cpumask_set_cpu(cpu, &cpuid_topo->llc_sibling);
 			cpumask_set_cpu(cpuid, &cpu_topo->llc_sibling);
 		}
-- 
2.7.4

