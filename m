Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F1E564B8C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 04:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiGDCQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 22:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGDCQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 22:16:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8104E64FB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 19:16:09 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lbq8072rXzTgSt;
        Mon,  4 Jul 2022 10:12:32 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Jul
 2022 10:16:06 +0800
From:   Xu Qiang <xuqiang36@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <elic@nvidia.com>,
        <si-wei.liu@oracle.com>, <parav@nvidia.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <xuqiang36@huawei.com>,
        <rui.xiang@huawei.com>
Subject: [PATCH -next] vdpa/mlx5: Use eth_broadcast_addr() to assign broadcast address
Date:   Mon, 4 Jul 2022 02:14:05 +0000
Message-ID: <20220704021405.64545-1-xuqiang36@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using eth_broadcast_addr() to assign broadcast address instead
of memset().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index f738c78ef446..3b2929d4a819 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1440,7 +1440,7 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
 	headers_v = MLX5_ADDR_OF(fte_match_param, spec->match_value, outer_headers);
 	dmac_c = MLX5_ADDR_OF(fte_match_param, headers_c, outer_headers.dmac_47_16);
 	dmac_v = MLX5_ADDR_OF(fte_match_param, headers_v, outer_headers.dmac_47_16);
-	memset(dmac_c, 0xff, ETH_ALEN);
+	eth_broadcast_addr(dmac_c);
 	ether_addr_copy(dmac_v, mac);
 	MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
 	if (tagged) {
-- 
2.17.1

