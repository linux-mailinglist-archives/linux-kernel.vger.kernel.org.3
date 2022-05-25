Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E8B533D56
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242528AbiEYNJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243872AbiEYNIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:08:50 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70137.outbound.protection.outlook.com [40.107.7.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33210A3091;
        Wed, 25 May 2022 06:08:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cawh2N15Mzvsewy7BmA/xRwfQBJHblNxazBs79MswGBmWf5femq5SEimVgPt9lxMUfgTbJ0fxrk1bpEEOnOv+riWSLFDndp14PXduGh7j/qlCwzKkDQ+NjwcMI6elkrCRpvv807AaVF9ajQCASQEB9PbcppJJWpK6siyqxpvYHJlcsz2NKoX9vWmEktIaWsJJv5mqIEiZroovM/dbyqiteT67UrXxBd83E8l/IoYJrulIjcMSsYEoj2F3aGlm6KgRsmG2+pkmyoiJIZ48e76UVMnn4chb08e5SrStD5Kljgxyjkgx/eF3li3yrzLuX5lWf8RyhGNI7BqrIWjwyzagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgOWtc0h84OfR0/XgjFODhvBKtLJ+qAcjYntEln1lJc=;
 b=iGXlYcc8fXtmEovrHe+FRp2NvZFsEPFG2MABUcAxziY9l411b7y5uyNnQEw5vAAZSwwYNVeSd3gERsedm0hdCQuBy6qI1M+pFJ+1tDp7O/GEiJ6zLjdNqs7aJo+PIpY5WfRHLX3YqVbnAwOiUGcrICRuERqB0EGLzuWnO3+NlBpg/TNL88QjkxCa/4r/mykAK7z98HzWTmDkDx4ni+9a0iJ49I2e/Lp5rz1HBlQqDkUma7KGLvNwHcrSgduuktWLEjSKFwIFSx7s7rxY9koyu78TRTS1pQEHXYVPgjVVPh7y17utPE3nmzLn91oTXyKxgm+9IHRRmPT+VBr6hkW8VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgOWtc0h84OfR0/XgjFODhvBKtLJ+qAcjYntEln1lJc=;
 b=QCpj73FtbHOP2RM/fspaPo0eFfmwGBtWuvTnINdzM1CQ6OjCcnvr/LVd5DCFkplPM8s2tdxr4lSrEKgtD4AcpFkWRMNNG7ZJAHP4fiJ8NzpC1eTdQdymm2w5eYsuuvot4J2+2JkxPzNnk8f488FjZnECp9QwtVV9VJDlUXd2gfo=
Received: from AS9PR07CA0019.eurprd07.prod.outlook.com (2603:10a6:20b:46c::23)
 by AM6PR06MB5747.eurprd06.prod.outlook.com (2603:10a6:20b:57::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 13:08:45 +0000
Received: from HE1EUR02FT051.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:46c:cafe::52) by AS9PR07CA0019.outlook.office365.com
 (2603:10a6:20b:46c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 13:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT051.mail.protection.outlook.com (10.152.11.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 13:08:44 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Cc:     thomas.haemmerle@leica-geosystems.com
Subject: [PATCH V4 6/6] dt-bindings: iio: accel: Add bmi085 and bmi090l bindings
Date:   Wed, 25 May 2022 13:08:28 +0000
Message-Id: <20220525130828.2394919-7-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525130828.2394919-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220525130828.2394919-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 58716185-c888-424f-2865-08da3e4fb310
X-MS-TrafficTypeDiagnostic: AM6PR06MB5747:EE_
X-Microsoft-Antispam-PRVS: <AM6PR06MB5747CE7DB398E7266217FC14D7D69@AM6PR06MB5747.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FwrvwURUf5gfv72+Uq99SOeOOsr0ddMzn4FYSvqLfNAftVMazKfFTUko/CNXxW110iVNk0ShI6SYiinW5JJt4fkKR9c+xe9+cN920N3vD06jnZCgpHeotce9n6rtjAJ8W2WNB0XyscOrLCV7jO7xU2Rr2iCblugC3fdQnmU+pE6O+ZZJZmu2xvZ2Kdb7oY1rUVc8UGpsewCuo0nOIYfM3b9IJOgEnW2XsHLVD69ZInGzHQB6743wP1LD/6dIMO7M3u4qjMLBL3l+FmGOsfmqrPJVQ98ei/Z5yatt61aCeGkRUf33QAFrUcxpPWH6pj3qjNd0lEt6h1uBPnNMs8wKl9dB+0RICDGDyJnlyIbtH5LQKJ+UivxHZzzsW8dkt8xxC0gGvueSPxROebFVeizekRyLyHg1aUtXB1OMcq9SuQ0SZSWaE2KiJCvVXsUeSD2etWl2xGK2m+aYpsYzyvd4TCoGOFZ7ymRLMVH9ndGaF11O0dl6AwhY6TYbCj9oi9XolBlReVJ3ee0uRxTStE6221LbsfeuAL4o1dxjeAcq8eYPO5TNdIHP+ikZVnrLsL8DJ63/AlAtW/yPegeywUl7dPtXYDHUxen0MPotHUbx4kTAjckKB1Z7O5e02LSuSC5FNbZDrPOjDzK2p/CJ8QjiGeKol7xQ+uHYrk4JEruVz5n56vuhvEDQIzlKkrZiZkq24jnv5tch0e1kyUhJ4C2gP5mnnqIpI+2x+OV2krRsK5HCvpSpjrsBG30emPJU0YGoepPbfeDqnpi8U6w89XbaVp4/h3PZX4U59jgiZfg+JgI=
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(921005)(6506007)(6512007)(26005)(6666004)(81166007)(356005)(4744005)(83380400001)(86362001)(107886003)(1076003)(336012)(2616005)(956004)(47076005)(36860700001)(118246002)(5660300002)(186003)(316002)(36736006)(40460700003)(4326008)(70586007)(8676002)(8936002)(70206006)(508600001)(36756003)(2906002)(966005)(6486002)(82310400005);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 13:08:44.8865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58716185-c888-424f-2865-08da3e4fb310
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT051.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5747
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the device-tree bindings for the Bosch
BMI085 and BMI090L IMU, the accelerometer part.

Datasheet: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi085-ds001.pdf
Datasheet: https://media.digikey.com/pdf/Data%20Sheets/Bosch/BST-BMI090L-DS000-00.pdf
Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
index 911a1ae9c83f..272eb48eef5a 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
@@ -17,7 +17,9 @@ description: |
 properties:
   compatible:
     enum:
+      - bosch,bmi085-accel
       - bosch,bmi088-accel
+      - bosch,bmi090l-accel
 
   reg:
     maxItems: 1
-- 
2.25.1

