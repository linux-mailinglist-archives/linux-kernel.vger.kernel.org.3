Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5684AB769
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350117AbiBGJM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344636AbiBGJFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:05:40 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150103.outbound.protection.outlook.com [40.107.15.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962E0C043181;
        Mon,  7 Feb 2022 01:05:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJaZD6rXEVLhhmRz/CPdZNwaTuRJGoicGpH2jwzHwWmmHemDo1cg7SjJz4dPO/X7C9qp1+eSOYU5HMTdYRvhT+QzcSjhiIdRNkWYi9rbQm14DCABHwC4bOuISBJhmoj69mFrRNp9XePJ5gf5hFDXYrDCyBhXXV2CZiCpKTiQ/BSPhmcTjnz7qrYnwIRSxzO6mbl58Ln346x/ITbW3K/huBl8OjpKePK4+h0ohpF+Ln5w2yKpZLRMJ8XiTYYpAhXbuP9BfaiTnhtEjkrbD/87QJWDdDy9GXrdSorZ7xkDY6O3zhnMZkz9TN/UMHiOUxyKgd57XT1M5YrpziWcAhevUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEH7puZP+EKzCMA/DLKC/W77EI9MFy63BIdji2uFLRM=;
 b=czD/lgW3VFSFE0Y9cB2vOEOy2zSzICe1oWawkFre96f0iJx5AJuScpN4ZMGL5rRhBeeMy9N1XD8WLDKniXg3U/SFMvjihJYExJ8KfSVGVtSfroowkV8Y1LvuozgRIrbrKuH41G1iVG9idaWxqcQIbGPQEH51NxvnY6d+KPMiooj9Zm9MhT/rnhdfJHULbizhRq5HxijMthj+3mZCyaEj5mdWYxx6K9i4rLfqA2XMtqxr2hrbevjPRVb3kskGp/FVSNed8ojcd3HhO82PmJpUfE2u5LERjtNGDkwlz3UNNF6fKqWk6r6aZnPgSJ3QV1OcnB4ho25uZ2P88hCm6nYmrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEH7puZP+EKzCMA/DLKC/W77EI9MFy63BIdji2uFLRM=;
 b=FmyWnVwuaZYNEmkHzxRsxMj1V7UYTFozKebXvgy6JqGnAkAvpCSxZVcMAy9bC4IGzq2qI7NceHgMDm0enJXWW9dlm9ViiUPk4mYKMRZ0KICH2anOZZoCQhkwCf/gj05pEjZP8selKgL7CDvQU38UD53HxkfQ9NTRteVl4zxCd8g=
Received: from FR0P281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:15::13)
 by VI1PR0601MB2110.eurprd06.prod.outlook.com (2603:10a6:800:2f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Mon, 7 Feb
 2022 09:05:36 +0000
Received: from VE1EUR02FT039.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:d10:15:cafe::27) by FR0P281CA0008.outlook.office365.com
 (2603:10a6:d10:15::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.10 via Frontend
 Transport; Mon, 7 Feb 2022 09:05:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com;
Received: from hexagon.com (193.8.40.94) by
 VE1EUR02FT039.mail.protection.outlook.com (10.152.13.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 09:05:36 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.56]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
         Mon, 7 Feb 2022 10:05:35 +0100
From:   Massimo Toscanelli <massimo.toscanelli@leica-geosystems.com>
To:     linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, lars@metafoo.de, linus.walleij@linaro.org,
        caihuoqing@baidu.com, aardelean@deviqon.com,
        andy.shevchenko@gmail.com, hdegoede@redhat.com,
        Qing-wu.Li@leica-geosystems.com.cn, stephan@gerhold.net,
        linux-iio@vger.kernel.org,
        bsp-development.geo@leica-geosystems.com,
        Massimo Toscanelli <massimo.toscanelli@leica-geosystems.com>
Subject: [PATCH 2/2] iio: st_magn_core.c: activate always_on attribute
Date:   Mon,  7 Feb 2022 09:04:43 +0000
Message-Id: <20220207090443.3710425-3-massimo.toscanelli@leica-geosystems.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207090443.3710425-1-massimo.toscanelli@leica-geosystems.com>
References: <20220204192552.428433-1-massimo.toscanelli@leica-geosystems.com>
 <20220207090443.3710425-1-massimo.toscanelli@leica-geosystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Feb 2022 09:05:35.0884 (UTC) FILETIME=[DE607CC0:01D81C01]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 86ce2a6b-d78e-4ca9-bf33-08d9ea190104
X-MS-TrafficTypeDiagnostic: VI1PR0601MB2110:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0601MB21108576F8D219B6DC7F9690A02C9@VI1PR0601MB2110.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: seD4VPCBlaZZIeVsKzFvg43UFinOh3cjXFRh2YITIpknkS5CpTi4y+f2dK7XDT3STwUkexf9prlTw725JHdz36SGlIjR21GB9E0iv0hJuk6zZzBRBlULoIL2dWLu35qhGC5QjzDowdibQp6SMgzbatXWmCBjjVeCdNmtllLo3MWmcjMirADTcwSMCvblV7FpDmAX0yncOZyIrhRCulOiBj2ZTjmWUzrMvQUgXtrd4a5RbAvzoOYClQ/lQ/OYjGsL88UTJ/9Nv4dA/2wP48f4NEv0frZDFI3Kk4ewmdxW/8zJbF/HK6BCUhE9HgmdLwZbxkR6fIPQbn/3FXHgmNPMbwbTpYRkgie+BRrYfiCsS1OV5chbtmfOBe7/bsjHGDO+YgTva1x42OoXJTGeFcKOD71qS7pQVSOfctgjulJ8BkwRK7QDm5V8Lr0bm/T5SNr3Nh2fsv51posGNc0uoWAfMD+bXzqFQ4S/PFaM4MCoI7pw7dtavcWzhbNSl8VXRCLsQKBpN0i4fQ4uAKZEGpGhH/GEQ6w0Xrh1I5GjcA+vucJVXEiWo1/vZGIbuYY/p1NQzsRGw7f0dD35zqXkpt/OWf2jXD0WXJNcNtGMNCuQc4iP2zclU0jZEmQTj9byNMrB/iB+dVEEEiaWvuBx7La5SCC1huMpG1CE/8A9dknoWXilyHnFaYGKU1SwjoJQbjBT9c6E6OP+JUjz/uWkLqk/sA==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36756003)(26005)(186003)(83380400001)(6666004)(5660300002)(40460700003)(6916009)(316002)(36860700001)(47076005)(336012)(450100002)(82310400004)(70586007)(356005)(4326008)(44832011)(8676002)(34020700004)(70206006)(2906002)(8936002)(86362001)(508600001)(4744005)(107886003)(1076003)(2616005)(81166007);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 09:05:36.1493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ce2a6b-d78e-4ca9-bf33-08d9ea190104
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT039.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0601MB2110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Activate always_on sysfs attribute to add the always_on feature in
st magnetometers.

Signed-off-by: Massimo Toscanelli <massimo.toscanelli@leica-geosystems.com>
---
 drivers/iio/magnetometer/st_magn_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 0806a1e65ce4..2ab4c286d262 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -563,9 +563,11 @@ static int st_magn_write_raw(struct iio_dev *indio_dev,
 static ST_SENSORS_DEV_ATTR_SAMP_FREQ_AVAIL();
 static ST_SENSORS_DEV_ATTR_SCALE_AVAIL(in_magn_scale_available);
 
+static ST_SENSORS_DEV_ATTR_ALWAYS_ON();
 static struct attribute *st_magn_attributes[] = {
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_in_magn_scale_available.dev_attr.attr,
+	&iio_dev_attr_always_on.dev_attr.attr,
 	NULL,
 };
 
-- 
2.25.1

