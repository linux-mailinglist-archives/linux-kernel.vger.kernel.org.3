Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F6352BD11
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238052AbiERNic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbiERNiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:38:23 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2051.outbound.protection.outlook.com [40.107.100.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7562916F906
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:38:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ggrhutb/ukPCPMUe/fxfEfv7B4LCQullOmpTqeksltxhVfxtvSxZCC8keRBtXsxzqhlBR2lH6m/OHXsZmVsJ1AaZWvB1LwxSHxwiS9NOHRp0ePdu4I2XMjfeDdg11v31ArTL31qrIRSp4wJa+MC0j9n6yUMIoClzGybw2B9urMZKiDtWHHbNveErkVRXvd3k3R08NxZ3fsCElZb4FedVczFHPq1AGU2zpFewf1H9VbEHlVXsEeMi/mCKnINM/v0nn5Z5UW6tAvzVClCFN6nqDRdh55NlxHIbqZKXe4pq6BrSrt8srx5bN2QEdWMmmVLeEPuUrIva4lydeuA5h9xx9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ux+qO5cexDHHEU0yE7Z4TI6G48/a+atmLVsry/gvsv4=;
 b=LfAsyQ0LxVQBS1A84VggIXIdAne5wjp4MdVc3/0qUC2wZdYEnA6AUPzJRCMhhmX7N467zYybZtJY3lCk8bG33A0dlWfEWyBfpBWq7AsdYilOFjNNdNUQZEQ7/SnF2BYI9VLlRG/Al5fzaj79rI2x0N/bSD7p0DVt6tnwgohre8rotzZF70Cq4dE8AZZcfIIHNTRQlv/kdl7T4aaeG4INxL2UL+IF2rdKaYDggPUW8awqD50S1sAFHg0JW3bfYJsLzIX3Q+X9NF4AdEcv0AnrHPJj/XFE7IhhW+seMf41eGd31vRUEeZbcUx1CCqvP8O4/VZ3aVuDb3Fw5IXaPZmRTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ux+qO5cexDHHEU0yE7Z4TI6G48/a+atmLVsry/gvsv4=;
 b=jUZzzRPSlhrBbiAMrQO2eZO9dF0GNnpVRZ89bsmKVFoTjmOAg3/nM7gtiQ7iNZ++JedhWUm6IbfQr2hGHOAjhxScGp/1MwdW9irtTqxPwDM/Tq5NTCbLxjice6GBHcQeSmGK70kimMV4JYxKTCIsmLhR62zbbBeavVX0YbdV10O8RPIZyVhClwcAhSwLhmn8DPBXHrrg16fN5EG+ThaV/68gZ6z6ABuTr+7AwkFl26RvWYk+5wdSgshq4Z5NsTvm/6e053i2e30+hxUR29cj0V5IxcCrefzNLaqAhanoL1PiW8xz44xcqPVvVJpnCyviUcUY4hX/hcKexguMhfphbg==
Received: from BN9PR03CA0725.namprd03.prod.outlook.com (2603:10b6:408:110::10)
 by DM5PR1201MB0268.namprd12.prod.outlook.com (2603:10b6:4:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 13:38:18 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::69) by BN9PR03CA0725.outlook.office365.com
 (2603:10b6:408:110::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15 via Frontend
 Transport; Wed, 18 May 2022 13:38:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5273.14 via Frontend Transport; Wed, 18 May 2022 13:38:16 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 18 May
 2022 13:38:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 18 May
 2022 06:38:08 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Wed, 18 May
 2022 06:38:07 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v8 0/6] Show statistics for a vdpa device
Date:   Wed, 18 May 2022 16:37:58 +0300
Message-ID: <20220518133804.1075129-1-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a186bfd-222a-4fd2-1c0d-08da38d3aa25
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0268:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0268572BE6601D87A4CFDE7BABD19@DM5PR1201MB0268.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k+QIZaAaTO4UhvK404QiMJTzONBGRexkpjSufAxOplY8frmjmUj50YGrHailQ1mfJ3rvMEBfRSUY3MF7SRuowtx7gkJbekewJUjxZwvUSRoXkZ5ivy4Ebq2OMYjriPUXP2MYr1w8SaIXSTuP1dzUoeIvBbbqO2S+UO7nw6/K6/ysgd16D+Pa/P0uOKGCfX34NVBnhi2SXafXaWOG6yhY6kAJ6fRtftcnUXpFLaVTa1DLZZHOGCnkkyjSIL9zWpZZvhzL2V1dR6RgASseJl34SZl8xWbvDqz2webdEeQvU0g2iJwqHCJR3UYxJbiYujU5Syj4InqGd1slxVm+P5NE2ONlSFcV60boMCHPRYdbMtwzX45djsYAM2EhuZfbEvAcFRh2PjBJ7vLH7VSqyvpGlk6zDJZpEDRAY7zSHHiop/GDzpbpetKyvQ4emmxGQor2tMJAxjUo2LiNNxvL5VsyJgJmaCRmxEFtJg6EWoO41QB5qfNcp8TnpKhTA77XULHkwnBIgVUwpx+g3Xew7oGy1tbjFn8GwadS1U9EUNN9yAj8uUUaZqGwRdujj7x36i91Zd/I0QrVkhEcaeKltuSP7Ajbvx2UOSOAx+++P9X5/fvv9eadK4Z3O/Xx8HCaub+f543gfkNFKBjLx9Dvk/525TkN8AHZBRHm56zAdEZF9DfT8iCJKLIYimW/Ob+aUS39mFfj3nRV6KXaTaW1nKQkHQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36756003)(81166007)(2616005)(316002)(1076003)(82310400005)(26005)(8936002)(2906002)(356005)(7696005)(6666004)(107886003)(70206006)(5660300002)(110136005)(86362001)(83380400001)(508600001)(70586007)(186003)(426003)(47076005)(336012)(36860700001)(54906003)(8676002)(40460700003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 13:38:16.7191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a186bfd-222a-4fd2-1c0d-08da38d3aa25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0268
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following six patch series adds support to read vendor statistics
for a vdpa device.

The first patch is just a cleanup fix.
The second patch lays the ground to allow an upstream driver to provide
statistics in the form of an attribute name/attribute value pairs.

The third and fourth patches make changes to locking scheme to use
readers/writers semaphore instead if mutex.

The fifth patch implements this for mlx5_vdpa which gives received
descriptors and completed descriptors information for all the
virtqueues.

The sixth patch changes reslock mutex to readers/writers semaphore to
achieve the same goal as done in vdpa core.

v7 -> v8:
Convert cf_mutex to a rw_semaphore

Eli Cohen (6):
  vdpa: Fix error logic in vdpa_nl_cmd_dev_get_doit
  vdpa: Add support for querying vendor statistics
  net/vdpa: Use readers/writers semaphore instead of vdpa_dev_mutex
  net/vdpa: Use readers/writers semaphore instead of cf_mutex
  vdpa/mlx5: Add support for reading descriptor statistics
  vdpa/mlx5: Use readers/writers semaphore instead of mutex

 drivers/vdpa/mlx5/core/mlx5_vdpa.h |   2 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 186 ++++++++++++++++++---
 drivers/vdpa/vdpa.c                | 252 ++++++++++++++++++++++++-----
 include/linux/mlx5/mlx5_ifc.h      |   1 +
 include/linux/mlx5/mlx5_ifc_vdpa.h |  39 +++++
 include/linux/vdpa.h               |  15 +-
 include/uapi/linux/vdpa.h          |   6 +
 7 files changed, 432 insertions(+), 69 deletions(-)

-- 
2.35.1

