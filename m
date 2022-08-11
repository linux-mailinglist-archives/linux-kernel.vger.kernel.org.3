Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FB958FA27
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 11:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbiHKJgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 05:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiHKJgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 05:36:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DADB90802
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 02:36:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VG8O9U0B+6ZUu1j2YViJiHsQwXUHoiXNYxNqEHvdclh0WR3HhhRiSiQZXA8AW0dStwd8tpec4vbIdLI4Hhunrn5YXl9h6JnwK8EBilb3XgcpyUnsI3+wfrtbYeA268irHJimk2n5jOIZfvgptJDFcaOiZIr0f1e4UidyD08mkleJaw+Jn3ftiyEuwWsMmQj1pivjWELjVBf9YCEQV7Qkc8CjuOxNkHQrkhmZWdxfIQpNVMgR+z+OWiRtAuPLBnrmW7FZ9D8rJ35R9GJMJbU5U7GIWt0TZXwSLo9KxYuCj1uFMNIs1odITSug+PpRkGarMoB8r0RzFin05BvYLP7C1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qs5XV1wRmUqRW6qd+b5WCtKsNM0wJvDOjCbPV4AiNb8=;
 b=MoZP4kwzwG2KdbWrz7xBC4rLVen79ujwWWaI1EWCXjpEJriU9DxdA5haRufccryi3vFPqmUr3MN01zfosz9mSgvIzoYnZcrK6z7KBNmAV5FsBFWcgMG9n2QN9IqYst/oWsx8BCfAxqLKwPloosMRLGC6Rd6g6npJILVGtaQDtK2hEyBlNRjVaAVDYphpP6Otf1v935n03Hre1uFi5yo9/CTmgKyeVN8IPiz9bhblLGyn153Iz3+37eCpz7MjFxnGRVRQggDWea0i0qtaDBE1qPOwexrklycGrb4hgf2Crvn2ir7Es+mv+Ct0da2bEKsAz06FdRFZ4gNo3lxyDmh6gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xilinx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qs5XV1wRmUqRW6qd+b5WCtKsNM0wJvDOjCbPV4AiNb8=;
 b=w/6HIl0wG1reHoa9rE/4uxWgqeitLbNOpcKrFjZYX7sAixC2p5Da/XmAvjkuyUdkGjKljqchMpDp0nQZKLRDZFr/Uxo88Tq0S+gDCbFDP3/6jDBC0RFztPNIfw1e/asBzMsK3bOI5BandjmAtw580dtaRIsFiXxaEKry5tts1iw=
Received: from MW4PR04CA0315.namprd04.prod.outlook.com (2603:10b6:303:82::20)
 by DM6PR12MB3017.namprd12.prod.outlook.com (2603:10b6:5:3e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 11 Aug
 2022 09:36:47 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::e2) by MW4PR04CA0315.outlook.office365.com
 (2603:10b6:303:82::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Thu, 11 Aug 2022 09:36:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 09:36:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 04:36:42 -0500
Received: from xcbayankuma41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Thu, 11 Aug 2022 04:36:32 -0500
From:   Ayan Kumar Halder <ayankuma@amd.com>
To:     <stefano.stabellini@xilinx.com>, <sstabellini@kernel.org>,
        <julien@xen.org>, <bertrand.marquis@arm.com>,
        <mark.rutland@arm.com>, <maz@kernel.org>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Ayan Kumar Halder <ayankuma@amd.com>
Subject: [PATCH v1] arm: clocksource: Check if timer is enabled for timer irq
Date:   Thu, 11 Aug 2022 10:36:20 +0100
Message-ID: <20220811093620.16680-1-ayankuma@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a298114-1b51-486c-0805-08da7b7d0273
X-MS-TrafficTypeDiagnostic: DM6PR12MB3017:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GsOzRAp8tp8Lhi8FyE00b1x1db1JamiRQtAK7hBHme95eINLfLu0a4TbyIIfbJMoWkjdUSKMmU6Rn/zUrjBbld2R0NYe2K0tW8wI+XdLCnIkKkxZOHsvrZKEPKYnpEtE71pyq4e8pa7Hqm8Y+RlaMtX2vwfmEVuTX5VTI4BuWJg2r4rppdmQ7IOOA1OrBZ5Mh7gvf0c40sHVuRQJU4oY7QJEpXzqjRbnEVHB80JepfUp7hj0xd7dd6O13HQ82AT6x78Gq9l642xvRpC1OgTf7MW44Jv0JAiJTpMxah3NPitNBmjFy9R26+FkpXpwfYv6qt5ugpqHY2GSzvlIP4mUtpikSo5wwRwSFQXTg4clNqou7hC7B35LARIYIPxXFM7cPJT8vURr+47JZOnlJYuZYD7/hyF6jIyTBjNcHcVfkSRctrAwYKFhsJ58Ff/xqz2yoNtE1+OD8tN+StC0lxPTzN8pewJvDrYm/FFNXGJf5k4uOfQLi/up8X7rGp/9E1Z9asnYwGGUGox+3BiH3EbfgLyZVYsrIlWkiq1G6K+KdCZos+j2E5L78HizFbykbimtDnjgdfwyEgUByyYe9TrJHtq8EhJFd4c/UirSZ4UFgUKzSjb0hjuHSNO92ESStGMTII+01JJQa9E8Giu6csnh7uZMAMTzbaNHl/r85HJqsjc/X/2UfLBcmHlQR+2xMiTwtpH1yzOOHhAtjS4Z8taTy+kHKLfSqu6I7/rPEbGw1kfKvy96rbhUCGPPwO00VFoio8u8j3o0dj+VOa/X4RWXfOrJ9z+LM49OYfvEyA645ih+8wGvBE4grvqVSyPnJYz3gko1V6u4PHVWOYpyrrwefbliIXt+6TxLz6kq9EFMFzUO/9XJFDvhiO/qSdBzn0vNWjBfZvtnbT0QFC+judzwCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(136003)(40470700004)(46966006)(36840700001)(26005)(356005)(81166007)(82310400005)(478600001)(966005)(82740400003)(40460700003)(5660300002)(8936002)(6666004)(41300700001)(8676002)(4326008)(70586007)(2906002)(70206006)(40480700001)(83380400001)(36756003)(110136005)(1076003)(2616005)(47076005)(54906003)(186003)(426003)(336012)(36860700001)(316002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 09:36:46.6849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a298114-1b51-486c-0805-08da7b7d0273
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3017
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer ARM DDI 0487G.b, CNTP_CTL_EL0,
ISTATUS, bit [2] - When the value of the ENABLE bit is 1, ISTATUS
indicates whether the timer condition is met.

Thus, one need to check ENABLE bit along with ISTATUS, to confirm
whether the timer condition is met. Further as the doc says,
"When the value of the ENABLE bit is 0, the ISTATUS field is UNKNOWN."

Signed-off-by: Ayan Kumar Halder <ayankuma@amd.com>
---

Please refer to https://lore.kernel.org/all/6cfcd4fa-3afd-1c70-6a70-9df557ee1811@xen.org/T/
for the previous discussion on this issue on xen-devel mailing list.

 drivers/clocksource/arm_arch_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 9ab8221ee3c6..96921772814c 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -647,7 +647,7 @@ static __always_inline irqreturn_t timer_handler(const int access,
 	unsigned long ctrl;
 
 	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, evt);
-	if (ctrl & ARCH_TIMER_CTRL_IT_STAT) {
+	if ((ctrl & ARCH_TIMER_CTRL_IT_STAT) && (ctrl & ARCH_TIMER_CTRL_ENABLE)) {
 		ctrl |= ARCH_TIMER_CTRL_IT_MASK;
 		arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, evt);
 		evt->event_handler(evt);
-- 
2.17.1

