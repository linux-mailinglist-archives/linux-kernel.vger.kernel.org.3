Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934F24FBC06
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346043AbiDKMaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346029AbiDKM35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:29:57 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDADD33A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:27:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIwAONGND4BPDoeik1kdgvYalhpTlklycrqZHc7fjmJ4M2V2zAcxQ6ZpJqb2W8fkVWwca6ctZDNLRxYaeW+W8RS6Rw8/1svzF+neM03MnXeLH90vUBtyV/6uT1BF3XnNHnzw2o+lTEXAbTaD9rkPpGMiICYCIPMyYOA82ssvdrkq8cg7HdeJm2PYQqOqHHoGqVlrWjeI5q7p+n/DJIYhO1VYMIWp7dyUqA1PiNv6F9y2LLti725n0Cjp2bfAXxsKOf8ISX8QuHT4S9vK7lYjDKjc+fg+c4G8svA5+fhDuOiRwbagn3RejOprXnjMHRfTu7qTh6u04iyuwbO7rZsIdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTdod2GpetLgxohnbuxVF/lhpkd4I2cM/aNwJxy1wuE=;
 b=mcriTydwYeNmj5PfW47GHrcOHlXprHPw14b1Kk+WVyKUzxlY4mT+YAsHrxXxph/XA3W5jUTlJNF/P4DRHRnhWt+ju4McOkhw7crcx5GT7gaN+zHz+/tpa/kpIMYSkVvtv5AlL7jnyFPHzYv7ZUnUiP/4YtpMQUIjrWcwWLXfyLTN68/GZnu5T7B5EP9uIhfxSqFfKt6tjPz5t1i01LDetAqRby2lbi5kmY2fjyuwlZuGW9jvopO6t2GcVJniytPq/4Uw22mdd61OWzejJGT+422EiMD1ZdoF6W5Lmkg/kpcmS3Zp5lS5EvRDSDrjmf5FNOJh2SVZzI+odGKJcAbbcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTdod2GpetLgxohnbuxVF/lhpkd4I2cM/aNwJxy1wuE=;
 b=Wy6VJfEIRUdePTyL3gGDz+nmwLXG/lWEGaA2Yi9fSd9bIMfqkp+4mOwRVsUlkSj9nWEe1femhCGjFe8qqfKQlHa7ARK4jIJZLBA4WD+OEZCFFm4fM4gREVJK38lw2GgDPV70k041SMWqI0VD+JiAsGFCVXYFo0DN6/tYc3A//zEWt103uCSJQyAL0BV3eSIF4kow6ylGQMQfOCZthDaSCADhQLRzzsXDPmUXz7bT2D/jn3ZEkJLWQiQJXv9W5NQWG81ieLoE/lBAJEHBSbGdiSwVrXI6Gy0kCl1p18iGKYTtsOjc0GwyfLY+vkPFUmsG4zJPSNFITuqWFYYPcHIYcg==
Received: from MW4PR02CA0003.namprd02.prod.outlook.com (2603:10b6:303:16d::30)
 by BYAPR12MB2645.namprd12.prod.outlook.com (2603:10b6:a03:61::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 12:27:42 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::1f) by MW4PR02CA0003.outlook.office365.com
 (2603:10b6:303:16d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 12:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 12:27:41 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Mon, 11 Apr 2022 12:27:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 05:27:40 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 11 Apr 2022 05:27:38 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <asowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH 2/3] virtio_net: Add control VQ struct to carry vlan id
Date:   Mon, 11 Apr 2022 15:27:27 +0300
Message-ID: <20220411122728.225588-3-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411122728.225588-1-elic@nvidia.com>
References: <20220411122728.225588-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 040ebaf8-45db-4c7d-0554-08da1bb6aca7
X-MS-TrafficTypeDiagnostic: BYAPR12MB2645:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2645A49BC0EFDBED463E73ABABEA9@BYAPR12MB2645.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zczGiMpIwzfYntQrifgAjchCH4B5v/KuhBwVi92J/RepagLzR+sh6f21OZQqLawkdELYVdRYRl9uLz1ak3nYZm4ozWxeve3FFMRlsKaH6ndB6A/S3aDqhKt6rpjxzMwxn6wM8v6de9BmJsf98oHs62BbzzlFtge+t9j4vl9Q8Ashohs6FtWhG7U5953LjKnLBF0HWC8N02wCFBhkGZ1JP7qbNEuAnRp5YWruCcZbFgFNHBtqGiFUxHEhjpoLzTFKEDM8ABinUahqPw7UStBYMvJnhGcZpAuKYBNHdnaEyJi0GjE/4p8FlbAYHQ2w9uIavXGTX56MvbhNgIRU5BEA2xazyxZuwukHHjyrqXFO/GURXvENv5DEOalcCIpt6GZzlP2PDPJGHR6hcEfD9Srj5uH6ixMe7Mbc3O5mtn3/eyvk2yArPSFujggOOAa31WlJE5G4n/5BzIL3LUkwQka0YdKwCR6LiZZZ6GN/5dLlIjxypTL/iaXjCly0Zvkb7NiVvdq+PwrtnlYqn2JiGwO6kDH59r84fAhpEZwiWwp+iow6XYbU3B8bQXqR9RBk+/eTs8Kf9Xn7VbYAqXIWCjL4zgBzSJAMgGJK4Xh5GE+oTbnsLYoTBMnP5UtbgYDJYYHcAb0FAe5+4VJieCfBWMvM8J2Owtomq8SSgBoJmCDz5fdfhSUaJVvfx5uu5ncJZq0bMoh2PSGkYz4Eok4ZTJSROA==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(426003)(2906002)(7696005)(82310400005)(47076005)(6666004)(336012)(36756003)(5660300002)(4744005)(186003)(83380400001)(26005)(316002)(86362001)(8676002)(2616005)(508600001)(107886003)(70586007)(40460700003)(4326008)(1076003)(70206006)(36860700001)(54906003)(110136005)(356005)(81166007)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 12:27:41.9877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 040ebaf8-45db-4c7d-0554-08da1bb6aca7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2645
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add structure to define the payload of control VQ messages carrying the
configured vlan ID. It will be used in subsequent patches of this
series.

Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 include/uapi/linux/virtio_net.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 3f55a4215f11..b94a405fa8d2 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -270,6 +270,9 @@ struct virtio_net_ctrl_mac {
 #define VIRTIO_NET_CTRL_VLAN       2
  #define VIRTIO_NET_CTRL_VLAN_ADD             0
  #define VIRTIO_NET_CTRL_VLAN_DEL             1
+struct virtio_net_ctrl_vlan {
+	__virtio16 id;
+};
 
 /*
  * Control link announce acknowledgement
-- 
2.35.1

