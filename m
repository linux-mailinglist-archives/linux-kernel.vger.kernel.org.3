Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB5E5A9057
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbiIAHdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbiIAHcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:32:48 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E6766A53;
        Thu,  1 Sep 2022 00:30:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezQBh18rW6VeYOYghANg8pvq8QJdjvNmDbLatJnJ6AUEr6GZ+plk2f9D6kOaP3EdoQQzy4XFhG6nSLwEyvVPvq/Rd3UDsDRba7W+pYyhih6KX0p19sGByFy5CKLwbRfXVcz17AWiulH+JjaNEn6wH6QumnOyrd9cuf0CjBWv4ZgKPcEx41WNUqM3N6FscWtRa/jusVPjSaugxfrJSwENZj/3swxdNTsDKuJRqNg+ggCoxhztyLhXeiFKZ72wJJzkrgAElWg4kHwLftT+d/0AaP5h5r9zpsX3uTLCVT3yEmQAf3FzMv6m/KEcypZjoP2XVq71jOCRXimoCi30tb7ouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCeZU/3QXerhfsZ95HFIsLb3fc1xYh0CFgWSCnhs+Jg=;
 b=BqzuHaJdJqjr7R9Qo1qTEOEQQ5O8DY2R0OPPfCnDGxj07UV3SxcA1co/3wK77f2C3kvS/lvCn90woHh2xAzxJnzm4ITlkHBhpePHBPmDxAxSIuNPCFxeqU+r/ISm/aaZmPA4gVH1kW8oiR6YHnZiODWt3zUMvPpJvKX2l7kJFcQg2RLg5C6DCPfeqxea+Qo36DtUmSnKHM1VdoGyFvPd8rIvbXFyIPAEe+PqQLzpqh12O5IsUCfSUkpOjB61YvvHA7ldNPqTK+qcYKoseMj9R3IGOGXmM4SbenQsGb4zRy3WnW32UxBvZ3pj0PFxZG+uOGGF/qX85HGlnmnj9fs0nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCeZU/3QXerhfsZ95HFIsLb3fc1xYh0CFgWSCnhs+Jg=;
 b=eDw9nsGRtWOwMx+yfob7y6xLDFfLfwF5fcwJzLD4xL2/0Q6ujvVpUmrg48Jg7sagbeYohfce6LycNffogmK2NRfmF369cIQOriMd1wJeIY+LsAvJDXamXdJHziBBkKnu16lx2tPlqI7vTW+htdr0gxFC1PhKB27G65oWwBWprps=
Received: from MW4PR04CA0207.namprd04.prod.outlook.com (2603:10b6:303:86::32)
 by SA0PR12MB4445.namprd12.prod.outlook.com (2603:10b6:806:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 07:30:05 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::3a) by MW4PR04CA0207.outlook.office365.com
 (2603:10b6:303:86::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.13 via Frontend
 Transport; Thu, 1 Sep 2022 07:30:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 07:30:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 1 Sep
 2022 02:29:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 1 Sep
 2022 02:29:28 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 1 Sep 2022 02:29:24 -0500
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <saikrishna12468@gmail.com>,
        <git@amd.com>, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH v2 0/2] mtd: spi-nor: Add flash device reset support
Date:   Thu, 1 Sep 2022 12:59:12 +0530
Message-ID: <20220901072914.30205-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b843323-3255-4026-9352-08da8bebc9c2
X-MS-TrafficTypeDiagnostic: SA0PR12MB4445:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J61dxEXss499zOMGiBJ6kyezQdC9tDKFhY/STpTGMYIUQTqoRN78Yx/A1KLdtoSrL/EV4qsNtHa8EX0MB3nIdQpNM6Y0qUQ+l1D9I7wL5tr7iPHqbn6GvuofuT8X3FjATD/S+mg7KBOFOxA3kP4FFYzack1W2kVGSKQQU+bE13C+mZpwrK29IMWVTG6PZGGo2uKrYBm3ZdvaulFVXQwmpi2lOooyNtEK/gOaiFRs9ktgAeilRG5jN6By4lzCCAIST7Cl9CCWgyHbWsZA0DCALycHAK5ieKrPslfOfoUZetDvzEYHCNrexNu6CktJlCpl1kLMeqjJIhjiem2xtIq2kO6ii96p+YC3BMntuLnBT1c9khWYOxhk+PHpoJmqbNp+OltQSzJBgItHnVVyLXRq9N0gYNiAD+uUlRE+cPwSSFLseo2oc86xRJs+1mqxlPcImOahzNAGbiG/RR09aM6h7v/loD31SYnLEAsaxY915XKuPmgff1/PmpkucA5+QoT74e5gYM/+8AL43QR+Ka0alArBDyOEsejpHmw9Ps7QbeunEiMbgwyP7PWH8CvMUp+UQ9VJnV/b8RBF6w//LLuCKZM2jcgiiVaEx/qQ1HiGzyl3aVlfGbwI5S7W+ruzzkrUuH/+LMg0vUcI/eIqnrgwged14aWzyfODfkG21Flq2Z0MoMOQsc08yBqJrl27OcDtOZrtYidRNS8LdWsS9hrIRpYyl0aqQGDD+gqI/X4NyDHX6ioHk0bAWOPasQR05B4HH42xOpkRn2+gnIw1p2DGjBPlTcBYBpX5PNs7jS130fuDr7fArUFirDwXuIG695Hk
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(39860400002)(376002)(40470700004)(46966006)(36840700001)(7416002)(2906002)(4744005)(103116003)(82740400003)(40480700001)(110136005)(336012)(54906003)(41300700001)(47076005)(426003)(316002)(6666004)(83380400001)(40460700003)(81166007)(82310400005)(86362001)(1076003)(2616005)(356005)(4326008)(186003)(36860700001)(36756003)(8936002)(5660300002)(70206006)(26005)(478600001)(8676002)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 07:30:04.3019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b843323-3255-4026-9352-08da8bebc9c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4445
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update spi-nor dt-binding and spi-nor core to support flash device
reset using reset-gpios property.

changes in v2:
-> 1/2 - Updated the description of the 'reset-gpios' property.
-> 2/2 - Updated the reset sequence to match with "active low" flag in
device-tree, also removed unwanted comments.
-> 2/2 - Updated the logic to perform the flash reset unconditionally.
-> 2/2 - Updated the delay values to support more number of flash devices.

Sai Krishna Potthuri (2):
  dt-bindings: mtd: spi-nor: Add reset-gpios property
  mtd: spi-nor: Add support for flash reset

 .../bindings/mtd/jedec,spi-nor.yaml           |  6 +++++
 drivers/mtd/spi-nor/core.c                    | 25 +++++++++++++++++++
 2 files changed, 31 insertions(+)

-- 
2.17.1

