Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB284EA761
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiC2Fs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbiC2Frq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:47:46 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2064.outbound.protection.outlook.com [40.107.96.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA9324B5C0;
        Mon, 28 Mar 2022 22:45:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDjOo1Di3oZlEpGBVBhCwfXIV6q0cpHGNk3vvwdDcjYIxyrBlG1wjg8X8/loFlowF5IsNukiWr6hCT1Go02bg1U8ckNtd1pcxRfoNrTsOkLyAlNYpfASZyu0nbjBkZvUket746PzQjpz9dtndJBJQZ/iP5hQY6lUW900JByigHHFk5o8FaaEkvlNY1D0Obk4uOwTOvPDAd6roCFaVa468QVq+4EihtGohrkGRiC3YcvOyc9trdBYvCwcGVW/RIsuKHtYw17ecKxvoDFzKWrzuwPh7o/Cr0QoX7jgQ6LeMz1Gf3q29xGhXKWZGEKtyD9VdOnqY9YbMI4WjZPxefTFzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHeKDgjcLqj6veWOtH9P4lFLw2uZ+3UnWxnDjB2Ph9E=;
 b=f9EeLEHOkJIT1CQ6Gxxw7tQZvZldaP8Prb4HoCDieVJAy6ge8xOZViqJj82LB4C/rdzNeRwK2oxeH9qgcrKR4AqnHVuU+vnoRJ9PH0QpqCPf+Qm4CCelYy6ixClwmi02z1C2Uk1azyczvT2gj6K7qZDGSntlzn46SsoVu5zJZ9NwfeIRy1nDmW+h3F5bmXhssnItQn3XPSMY82gFhZHv4EnV4I6gWABHiAZ3c2NTHnkK5xR9durPtPCELZHOmOnCGVRsWPZZuHmmmXUkJv51nC9oNVm6GLpx6TqETusRH27I+Uor4QuRPw64qCHzk+YXo9o1Ux7v75zer1t3ffhd/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHeKDgjcLqj6veWOtH9P4lFLw2uZ+3UnWxnDjB2Ph9E=;
 b=B3P8uTIt4r9BhUhExoH9mPOC9D+e7avJf1ah7bXLsjYiQUBp0OtbhDAQKj70bDxrm45Fi49pkrjgSvnW9nFkGbI5MKJqcMnt02Y32dWlBml7XTLXJvaNmPNeaj/DlOUr2crcxGgqjS6ZGTKibLLE0sPyKYrW7Sw6Nx1AU0s7bXHFynF/aZ3UqNLeHAPGs/Jq6fP1BkEToajQ9cTu594E8Toi2uMxV7MORIfBYfi85AOxE4bX13kz8lDDPHDQ88+vt17wg7zcQBxiUNzxpyciLKhL3KMUP3h+j7gbc6DqoRAXCedzTXTwO+jpu+xJ725oDZ6S9s8q07jrnWlFfLRqWw==
Received: from MW4PR03CA0175.namprd03.prod.outlook.com (2603:10b6:303:8d::30)
 by DM4PR12MB5264.namprd12.prod.outlook.com (2603:10b6:5:39c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 29 Mar
 2022 05:45:43 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::20) by MW4PR03CA0175.outlook.office365.com
 (2603:10b6:303:8d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Tue, 29 Mar 2022 05:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 05:45:42 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 29 Mar
 2022 05:45:42 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 28 Mar
 2022 22:45:41 -0700
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 28 Mar 2022 22:45:41 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <smangipudi@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v5 11/11] MAINTAINERS: Added HTE Subsystem
Date:   Mon, 28 Mar 2022 22:45:21 -0700
Message-ID: <20220329054521.14420-12-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220329054521.14420-1-dipenp@nvidia.com>
References: <20220329054521.14420-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5bfacec-3eab-4979-a138-08da11475d2a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5264:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5264956AAF0574751E611F0BAE1E9@DM4PR12MB5264.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IwsKo+fe09Rb69jrv7wV8S2Ww4UsyZcWjqr3akn/vXIpuI7QiejbCMC20Ue8+lio9iKQ3BfVuOToKkxUIVqqB6qo/dXigxlIPmcrWRFouQkvrdFRBgabAU2xFZ4/9y5EUYEO64olNKNbDLr5MmffKkj6r7ZIE/gracsNjdnqJFY8Jqmeznm8BvgzkxovDbiuozmoPv4mVhRSxm3hvQvMioBQz5GCD/4F7CzYHQKNL1RQsTfK0rIVKdbblOL49kumB2rLUeSB7qg2v2GoL+H1iViVMos7GwKgERfOSZxrr7dwGF9Od/3YJci0+QKEBEPNdAHc494nd2AIOrrCYeEzOCl1J9vI9TaGRuFkPN0avBk/RmBNsw/3ZmkzRcvD+8xcn3QfL3woyBGATDPTjIBuQXMlHcn25HbY5QOx2br7UKpn2EDmtPA06GycluYCNeHuUZpzSEfQlJyGmOSR5CJr5gvW1smnbvDUL/4ap73u2IEh28yn3xLD3v1P6beHWJ2vucP5rcXolZpR0x86CqGFxOYX/7VfdPLBqCcgiHhkvAgAiWZkSd1kHPJZJzlHdvBVUFpl/s+ClKWoAp9sheAY48DF7KaWj67q7XJeTHwfTL5JqF70la6Ytd+0tLa19uoa6I2Y+yCmS9VAhHI5rrYvw6HOBzB8ZHEky/3myHnNxLdKb3BmrnK20/lEJrjzReUa/6fDEBa1zcbLepP6DqNOshmtFCIzau1tJsbbiB4tjL6bQ3xhsyPcHnXDsCWg9+HVwERkiNorx5Hegqx2LQqvAQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(86362001)(2906002)(5660300002)(40460700003)(4744005)(36756003)(7416002)(70206006)(70586007)(356005)(81166007)(921005)(8936002)(8676002)(4326008)(47076005)(110136005)(2616005)(82310400004)(36860700001)(316002)(107886003)(336012)(1076003)(6666004)(26005)(186003)(7696005)(426003)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 05:45:42.8677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5bfacec-3eab-4979-a138-08da11475d2a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5264
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added myself as a maintainer for this new Hardware Timestamping Engine
(HTE) subsystem.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
Changes in v3:
- Followed guidelines for the "M" field.
- Removed "*" in "F" field.

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c85a82557f50..4210a1c1deb1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8987,6 +8987,14 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/input/touchscreen/htcpen.c
 
+HTE SUBSYSTEM
+M:	Dipen Patel <dipenp@nvidia.com>
+S:	Maintained
+F:	drivers/hte/
+F:	include/linux/hte.h
+F:	Documentation/hte/
+F:	Documentation/devicetree/bindings/hte/
+
 HTS221 TEMPERATURE-HUMIDITY IIO DRIVER
 M:	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
 L:	linux-iio@vger.kernel.org
-- 
2.17.1

