Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D16F4FBC11
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiDKMcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346082AbiDKMcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:32:10 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B973EB87
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:29:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmCJ8/Tgt1/47sIo1u0vvUppaSvJ3AIOd1dZCuncgibU9nbSeZcqcBi1vldlOfJLc5bn6JR1Vo+Cg/MQiH4zl92ruq10ZTL3S6+eC3FgP3M98zqrjzP9bXKBPfgy199hlleucGUt4gNRuQTWZdFgvEbkc5cyExqSIFFPnkWOX0RSMDuxl/5Ua4cjy2sN0sSt/1k651CUy00qEjQqQ7+Y7eoghzdXnJAQ01RUbrnG8XiwvoAiwx+k7feOixNA+3oXzp+yu8X03TU7EQKvn8w/JiPxg3AsBTUDPLve2VgzWohi/XHHDMLZDweXY1AEMwN0ymSRiaySaNp0tkv7t89+/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGuLIm+loU0x1dF3vSX4n6soaraFgug8ZlzTBtx/vOs=;
 b=Xu3la68HS8b6OJqRazauAH5UhVC+a50HSov6I60yqZaYE5Gtz41KbgJ8jPkUeHB43Bfco799RF+5NGz+mLKRq66G+7LwdNYOFLENG+/NNDufV7xn8jFUKoicW3ow/5eXERMLXPmqBNyDlrH2UZ72uScNuxjML69vjxCiAi6REx0w+841ApQTqLy7loUehOrr1UAy9haposslT6mUgubsYk7Z+JfcJSd954wXq5Mnh/GY81qbHP6O8q7NFWdMDfmduoTPxnqDlZBgbC+ZbDS8aG8KlnumT6zJ1EbHFqYqbCnq/VOXyXFBpFT4cSKo2jQXg2LwSeHPgkjs7cJlBxtmSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGuLIm+loU0x1dF3vSX4n6soaraFgug8ZlzTBtx/vOs=;
 b=ntA+eBYikPWwFzmBUIzD6QgldbB8dJgWlpSL4VNuUKXS+0xcfpqK3vWlolQFd7MJbPHbV5lg1Z9V6x/E3bkJNYMDgoIUJzXOFuLWFVQVF0dViFz+v1s/WuQxGE2euZ7Yp9juIT1h+2F8g8xUYw5xNsGxtpf2KZ/Xu6qrTEYiWO/LuVliCitDwej4boG2qvV2h/78Kj46MQNBCDXh1v8+uRq+VV0fakDP5URu5K9dzpF9L8aW2IJlgZ/vN+muG7xA6OYoNv+P9GO9kImezB3NoepV8tR9evdbgG9NToSfzSd564p9kcq1NWgCyfq3boeeMkFHTWxoVCWRYY5oUrERFg==
Received: from MW2PR16CA0071.namprd16.prod.outlook.com (2603:10b6:907:1::48)
 by CH0PR12MB5235.namprd12.prod.outlook.com (2603:10b6:610:d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 12:29:54 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::23) by MW2PR16CA0071.outlook.office365.com
 (2603:10b6:907:1::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 12:29:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 12:29:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 11 Apr
 2022 12:29:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 11 Apr
 2022 05:29:52 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Mon, 11 Apr
 2022 05:29:51 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH 3/3] vdpa/mlx5: Add RX MAC VLAN filter support
Date:   Mon, 11 Apr 2022 15:29:42 +0300
Message-ID: <20220411122942.225717-4-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411122942.225717-1-elic@nvidia.com>
References: <20220411122942.225717-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6331136-15e9-4b51-b6b2-08da1bb6fb26
X-MS-TrafficTypeDiagnostic: CH0PR12MB5235:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5235983735D9FBC4209376ACABEA9@CH0PR12MB5235.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CHUCTnccEFXNkWT8PjpGRn75PTyxQL5pjtUsPRBjSmeQAF+19PzNQGkzChHqeVkSBC1TP3eMgT6Ky81f4nu4QWRQnSDLu41cbKgakQZcEw7h/HrS00UOA5MiYOLWhgdHbZF0l30VbsOsbRUi0uzo/z/MmuKGqWXG8u9iOy/TzAWBb0Q3UYl/rk0C/O745qp1AnQEIqwIuqOECGz47rxn4U0qwJGmBuN98kPQWyRfs9juERaFhIWPlk3B4ziZuyI4QcgQhHznHS81FBTYwEkNK55t1bONgiFMXRp9oRjxx9Ur2fcexmXEL1eiZVe9ntKXSXw0xzrs4Twc4aEc+6R/NmhzHzzjHAsMTUBKxSB1MBIxo8NjeFmsrHSENOC1XZwFr/uhmRk+E4vsZIZI2eHwqVcbvOKidwnlSPWvfxwO8ElRNZWfQrR0zoWE8IqKAqaWwZegrm5vD8Bn24fJG21gEAjM4dFEfs/+fgXU+7CLJ7rBdvBfC+Htv1336Wxmkikl5VM8+5GWiKxZ5CQrjSyii3u4Tjn5gb/7E2/HMm2PgIRmOYKRSp0M75bJN2dXJNyXOIp4VeFiMAhwQ9QOZc1FuifNiFpvZCxLe8kGroxje+JHQ66Zu+cZbfN0CpQvxaJOLI4iyppopE9yiqKTFaYgqUwWJNzsWQVhz7TGFMNu1tN7hSwVF42TYXJI+1IYY8xV
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(186003)(336012)(83380400001)(47076005)(86362001)(26005)(107886003)(1076003)(2906002)(2616005)(8936002)(36756003)(6666004)(7696005)(316002)(40460700003)(82310400005)(5660300002)(356005)(70586007)(4326008)(30864003)(426003)(70206006)(54906003)(110136005)(81166007)(8676002)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 12:29:53.6712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6331136-15e9-4b51-b6b2-08da1bb6fb26
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5235
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support HW offloaded filtering of MAC/VLAN packets.
To allow that, we add a handler to handle VLAN configurations coming
through the control VQ. Two operations are supported.

1. Adding VLAN - in this case, an entry will be added to the RX flow
   table that will allow the combination of the MAC/VLAN to be
   forwarded to the TIR.
2. Removing VLAN - will remove the entry from the flow table,
   effectively blocking such packets from going through.

Currently the control VQ does not propagate changes to the MAC of the
VLAN device so we always use the MAC of the parent device.

Examples:
1. Create vlan device:
$ ip link add link ens1 name ens1.8 type vlan id 8

Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 274 +++++++++++++++++++++++-------
 1 file changed, 216 insertions(+), 58 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 5aa6220c7129..f81f9a213ed2 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -48,6 +48,8 @@ MODULE_LICENSE("Dual BSD/GPL");
 
 #define MLX5_FEATURE(_mvdev, _feature) (!!((_mvdev)->actual_features & BIT_ULL(_feature)))
 
+#define MLX5V_UNTAGGED 0x1000
+
 struct mlx5_vdpa_net_resources {
 	u32 tisn;
 	u32 tdn;
@@ -143,6 +145,8 @@ static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
 	return idx <= mvdev->max_idx;
 }
 
+#define MLX5V_MACVLAN_SIZE 256
+
 struct mlx5_vdpa_net {
 	struct mlx5_vdpa_dev mvdev;
 	struct mlx5_vdpa_net_resources res;
@@ -156,14 +160,20 @@ struct mlx5_vdpa_net {
 	 */
 	struct mutex reslock;
 	struct mlx5_flow_table *rxft;
-	struct mlx5_flow_handle *rx_rule_ucast;
-	struct mlx5_flow_handle *rx_rule_mcast;
 	bool setup;
 	u32 cur_num_vqs;
 	u32 rqt_size;
 	struct notifier_block nb;
 	struct vdpa_callback config_cb;
 	struct mlx5_vdpa_wq_ent cvq_ent;
+	struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
+};
+
+struct macvlan_node {
+	struct hlist_node hlist;
+	struct mlx5_flow_handle *ucast_rule;
+	struct mlx5_flow_handle *mcast_rule;
+	u64 macvlan;
 };
 
 static void free_resources(struct mlx5_vdpa_net *ndev);
@@ -1346,12 +1356,17 @@ static void destroy_tir(struct mlx5_vdpa_net *ndev)
 	mlx5_vdpa_destroy_tir(&ndev->mvdev, ndev->res.tirn);
 }
 
-static int add_fwd_to_tir(struct mlx5_vdpa_net *ndev)
+#define MAX_STEERING_ENT 0x8000
+#define MAX_STEERING_GROUPS 2
+
+static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
+					u16 vid, bool tagged,
+					struct mlx5_flow_handle **ucast,
+					struct mlx5_flow_handle **mcast)
 {
 	struct mlx5_flow_destination dest = {};
-	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_flow_act flow_act = {};
-	struct mlx5_flow_namespace *ns;
+	struct mlx5_flow_handle *rule;
 	struct mlx5_flow_spec *spec;
 	void *headers_c;
 	void *headers_v;
@@ -1364,74 +1379,178 @@ static int add_fwd_to_tir(struct mlx5_vdpa_net *ndev)
 		return -ENOMEM;
 
 	spec->match_criteria_enable = MLX5_MATCH_OUTER_HEADERS;
-	ft_attr.max_fte = 2;
-	ft_attr.autogroup.max_num_groups = 2;
-
-	ns = mlx5_get_flow_namespace(ndev->mvdev.mdev, MLX5_FLOW_NAMESPACE_BYPASS);
-	if (!ns) {
-		mlx5_vdpa_warn(&ndev->mvdev, "failed to get flow namespace\n");
-		err = -EOPNOTSUPP;
-		goto err_ns;
-	}
-
-	ndev->rxft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
-	if (IS_ERR(ndev->rxft)) {
-		err = PTR_ERR(ndev->rxft);
-		goto err_ns;
-	}
-
 	headers_c = MLX5_ADDR_OF(fte_match_param, spec->match_criteria, outer_headers);
-	dmac_c = MLX5_ADDR_OF(fte_match_param, headers_c, outer_headers.dmac_47_16);
-	memset(dmac_c, 0xff, ETH_ALEN);
 	headers_v = MLX5_ADDR_OF(fte_match_param, spec->match_value, outer_headers);
+	dmac_c = MLX5_ADDR_OF(fte_match_param, headers_c, outer_headers.dmac_47_16);
 	dmac_v = MLX5_ADDR_OF(fte_match_param, headers_v, outer_headers.dmac_47_16);
-	ether_addr_copy(dmac_v, ndev->config.mac);
-
+	memset(dmac_c, 0xff, ETH_ALEN);
+	ether_addr_copy(dmac_v, mac);
+	MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
+	if (tagged) {
+		MLX5_SET(fte_match_set_lyr_2_4, headers_v, cvlan_tag, 1);
+		MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c, first_vid);
+		MLX5_SET(fte_match_set_lyr_2_4, headers_c, first_vid, vid);
+	}
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
 	dest.type = MLX5_FLOW_DESTINATION_TYPE_TIR;
 	dest.tir_num = ndev->res.tirn;
-	ndev->rx_rule_ucast = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, &dest, 1);
+	rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, &dest, 1);
+	if (IS_ERR(rule))
+		return PTR_ERR(rule);
 
-	if (IS_ERR(ndev->rx_rule_ucast)) {
-		err = PTR_ERR(ndev->rx_rule_ucast);
-		ndev->rx_rule_ucast = NULL;
-		goto err_rule_ucast;
-	}
+	*ucast = rule;
 
 	memset(dmac_c, 0, ETH_ALEN);
 	memset(dmac_v, 0, ETH_ALEN);
 	dmac_c[0] = 1;
 	dmac_v[0] = 1;
-	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
-	ndev->rx_rule_mcast = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, &dest, 1);
-	if (IS_ERR(ndev->rx_rule_mcast)) {
-		err = PTR_ERR(ndev->rx_rule_mcast);
-		ndev->rx_rule_mcast = NULL;
-		goto err_rule_mcast;
+	rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, &dest, 1);
+	kvfree(spec);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		goto err_mcast;
 	}
 
-	kvfree(spec);
+	*mcast = rule;
 	return 0;
 
-err_rule_mcast:
-	mlx5_del_flow_rules(ndev->rx_rule_ucast);
-	ndev->rx_rule_ucast = NULL;
-err_rule_ucast:
-	mlx5_destroy_flow_table(ndev->rxft);
-err_ns:
-	kvfree(spec);
+err_mcast:
+	mlx5_del_flow_rules(*ucast);
+	return err;
+}
+
+static void mlx5_vdpa_del_mac_vlan_rules(struct mlx5_vdpa_net *ndev,
+					 struct mlx5_flow_handle *ucast,
+					 struct mlx5_flow_handle *mcast)
+{
+	mlx5_del_flow_rules(ucast);
+	mlx5_del_flow_rules(mcast);
+}
+
+static u64 search_val(u8 *mac, u16 vlan, bool tagged)
+{
+	u64 val;
+
+	if (!tagged)
+		vlan = MLX5V_UNTAGGED;
+
+	val = (u64)vlan << 48 |
+	      (u64)mac[0] << 40 |
+	      (u64)mac[1] << 32 |
+	      (u64)mac[2] << 24 |
+	      (u64)mac[3] << 16 |
+	      (u64)mac[4] << 8 |
+	      (u64)mac[5];
+
+	return val;
+}
+
+static struct macvlan_node *mac_vlan_lookup(struct mlx5_vdpa_net *ndev, u64 value)
+{
+	struct macvlan_node *pos;
+	u32 idx;
+
+	idx = hash_64(value, 8); // tbd 8
+	hlist_for_each_entry(pos, &ndev->macvlan_hash[idx], hlist) {
+		if (pos->macvlan == value)
+			return pos;
+	}
+	return NULL;
+}
+
+static int mac_vlan_add(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vlan, bool tagged) // vlan -> vid
+{
+	struct macvlan_node *ptr;
+	u64 val;
+	u32 idx;
+	int err;
+
+	val = search_val(mac, vlan, tagged);
+	if (mac_vlan_lookup(ndev, val))
+		return -EEXIST;
+
+	ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	err = mlx5_vdpa_add_mac_vlan_rules(ndev, ndev->config.mac, vlan, tagged,
+					   &ptr->ucast_rule, &ptr->mcast_rule);
+	if (err)
+		goto err_add;
+
+	ptr->macvlan = val;
+	idx = hash_64(val, 8);
+	hlist_add_head(&ptr->hlist, &ndev->macvlan_hash[idx]);
+	return 0;
+
+err_add:
+	kfree(ptr);
 	return err;
 }
 
-static void remove_fwd_to_tir(struct mlx5_vdpa_net *ndev)
+static void mac_vlan_del(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vlan, bool tagged)
 {
-	if (!ndev->rx_rule_ucast)
+	struct macvlan_node *ptr;
+
+	ptr = mac_vlan_lookup(ndev, search_val(mac, vlan, tagged));
+	if (!ptr)
 		return;
 
-	mlx5_del_flow_rules(ndev->rx_rule_mcast);
-	ndev->rx_rule_mcast = NULL;
-	mlx5_del_flow_rules(ndev->rx_rule_ucast);
-	ndev->rx_rule_ucast = NULL;
+	hlist_del(&ptr->hlist);
+	mlx5_vdpa_del_mac_vlan_rules(ndev, ptr->ucast_rule, ptr->mcast_rule);
+	kfree(ptr);
+}
+
+static void clear_mac_vlan_table(struct mlx5_vdpa_net *ndev)
+{
+	struct macvlan_node *pos;
+	struct hlist_node *n;
+	int i;
+
+	for (i = 0; i < MLX5V_MACVLAN_SIZE; i++) {
+		hlist_for_each_entry_safe(pos, n, &ndev->macvlan_hash[i], hlist) {
+			hlist_del(&pos->hlist);
+			mlx5_vdpa_del_mac_vlan_rules(ndev, pos->ucast_rule, pos->mcast_rule);
+			kfree(pos);
+		}
+	}
+}
+
+static int setup_steering(struct mlx5_vdpa_net *ndev)
+{
+	struct mlx5_flow_table_attr ft_attr = {};
+	struct mlx5_flow_namespace *ns;
+	int err;
+
+	ft_attr.max_fte = MAX_STEERING_ENT;
+	ft_attr.autogroup.max_num_groups = MAX_STEERING_GROUPS;
+
+	ns = mlx5_get_flow_namespace(ndev->mvdev.mdev, MLX5_FLOW_NAMESPACE_BYPASS);
+	if (!ns) {
+		mlx5_vdpa_warn(&ndev->mvdev, "failed to get flow namespace\n");
+		return -EOPNOTSUPP;
+	}
+
+	ndev->rxft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
+	if (IS_ERR(ndev->rxft)) {
+		mlx5_vdpa_warn(&ndev->mvdev, "failed to create flow table\n");
+		return PTR_ERR(ndev->rxft);
+	}
+
+	err = mac_vlan_add(ndev, ndev->config.mac, 0, false);
+	if (err)
+		goto err_add;
+
+	return 0;
+
+err_add:
+	mlx5_destroy_flow_table(ndev->rxft);
+	return err;
+}
+
+static void teardown_steering(struct mlx5_vdpa_net *ndev)
+{
+	clear_mac_vlan_table(ndev);
 	mlx5_destroy_flow_table(ndev->rxft);
 }
 
@@ -1482,9 +1601,9 @@ static virtio_net_ctrl_ack handle_ctrl_mac(struct mlx5_vdpa_dev *mvdev, u8 cmd)
 
 		/* Need recreate the flow table entry, so that the packet could forward back
 		 */
-		remove_fwd_to_tir(ndev);
+		mac_vlan_del(ndev, ndev->config.mac, 0, false);
 
-		if (add_fwd_to_tir(ndev)) {
+		if (mac_vlan_add(ndev, ndev->config.mac, 0, false)) {
 			mlx5_vdpa_warn(mvdev, "failed to insert forward rules, try to restore\n");
 
 			/* Although it hardly run here, we still need double check */
@@ -1508,7 +1627,7 @@ static virtio_net_ctrl_ack handle_ctrl_mac(struct mlx5_vdpa_dev *mvdev, u8 cmd)
 
 			memcpy(ndev->config.mac, mac_back, ETH_ALEN);
 
-			if (add_fwd_to_tir(ndev))
+			if (mac_vlan_add(ndev, ndev->config.mac, 0, false))
 				mlx5_vdpa_warn(mvdev, "restore forward rules failed: insert forward rules failed\n");
 
 			break;
@@ -1610,6 +1729,42 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct mlx5_vdpa_dev *mvdev, u8 cmd)
 	return status;
 }
 
+static virtio_net_ctrl_ack handle_ctrl_vlan(struct mlx5_vdpa_dev *mvdev, u8 cmd)
+{
+	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
+	virtio_net_ctrl_ack status = VIRTIO_NET_ERR;
+	struct mlx5_control_vq *cvq = &mvdev->cvq;
+	struct virtio_net_ctrl_vlan vlan;
+	size_t read;
+	u16 id;
+
+	switch (cmd) {
+	case VIRTIO_NET_CTRL_VLAN_ADD:
+		read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->riov, (void *)&vlan, sizeof(vlan));
+		if (read != sizeof(vlan))
+			break;
+
+		id = mlx5vdpa16_to_cpu(mvdev, vlan.id);
+		if (mac_vlan_add(ndev, ndev->config.mac, id, true))
+			break;
+
+		status = VIRTIO_NET_OK;
+		break;
+	case VIRTIO_NET_CTRL_VLAN_DEL:
+		read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->riov, (void *)&vlan, sizeof(vlan));
+		if (read != sizeof(vlan))
+			break;
+
+		id = mlx5vdpa16_to_cpu(mvdev, vlan.id);
+		mac_vlan_del(ndev, ndev->config.mac, id, true);
+		break;
+	default:
+	break;
+}
+
+return status;
+}
+
 static void mlx5_cvq_kick_handler(struct work_struct *work)
 {
 	virtio_net_ctrl_ack status = VIRTIO_NET_ERR;
@@ -1654,7 +1809,9 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
 		case VIRTIO_NET_CTRL_MQ:
 			status = handle_ctrl_mq(mvdev, ctrl.cmd);
 			break;
-
+		case VIRTIO_NET_CTRL_VLAN:
+			status = handle_ctrl_vlan(mvdev, ctrl.cmd);
+			break;
 		default:
 			break;
 		}
@@ -1913,6 +2070,7 @@ static u64 get_supported_features(struct mlx5_core_dev *mdev)
 	mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_MQ);
 	mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_STATUS);
 	mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_MTU);
+	mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_CTRL_VLAN);
 
 	return mlx_vdpa_features;
 }
@@ -2198,9 +2356,9 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
 		goto err_tir;
 	}
 
-	err = add_fwd_to_tir(ndev);
+	err = setup_steering(ndev);
 	if (err) {
-		mlx5_vdpa_warn(mvdev, "add_fwd_to_tir\n");
+		mlx5_vdpa_warn(mvdev, "setup_steering\n");
 		goto err_fwd;
 	}
 	ndev->setup = true;
@@ -2226,7 +2384,7 @@ static void teardown_driver(struct mlx5_vdpa_net *ndev)
 	if (!ndev->setup)
 		return;
 
-	remove_fwd_to_tir(ndev);
+	teardown_steering(ndev);
 	destroy_tir(ndev);
 	destroy_rqt(ndev);
 	teardown_virtqueues(ndev);
-- 
2.35.1

