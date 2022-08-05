Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D2658B102
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240927AbiHEVN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240663AbiHEVNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:13:24 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B058659242
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 14:13:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTM5m389Oq1huyKLYWEUWTBUYz0lnmC4paW4UjWMfr4zfcJOxdxRmHPKy4ha4OsXy8YMUUSJ4h+68p6dpzVs5PIFbR1psPAz+B4fRit5YNIyghP0miyVW6ZSqlLNxdhYHugWZvQQ/lxBte1mJ0FW9Fg+tun5H/G/EORRdqm3m851BU5YfPIsp+I+47Q6xjjQUrxvNM97ItDufuO39wstQdomgS0eUZIsWPwCYFNvFWE/wWE2+TfMYDb9+f5SLl4DbdP8v0k3Cq1uKkwzHrsUqdbsp7UjFBvh6+QqvGhJKnUX1mPgXGEiicwq3BjFUBPf3U4PW38AykApZD6dBkiDRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7NBT2kuC6NI1KC/ha2MEPlmndNE3immfWXCeILsGGk=;
 b=Qp8GX13Cvm9IP6oLSvh/kqKO7YBgtQ9HSLyA54NbcceXQnS2if4tSz5Dht8yYcgB37qklqXJCUqEHvIiWsISDB7/uI8I9HVlhnJRffuR8dU41xMOLDAlheVMvN+kQQlqL+J11Nq20+3hnzacRERGP/D4BrWidsaAQ0kZYvN8JlVMqaePX5+ZMkCSQpznHGfiUY4F/VZ+MfYnJRCHjU5oMZe/++zWMLDYdb9T9B4MpCTEQRjuaYLei93JaciQ9qLwZrMrl0wLG9by9qagpbPSBOfFSVOY/hmFNISfLzhJBRhORU5orW28KTXEV+ZQp/Na6Kj1Ul3dTipjPEybkzArBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7NBT2kuC6NI1KC/ha2MEPlmndNE3immfWXCeILsGGk=;
 b=lgH7m/X0SBxExz+Tfy7iWOKu0iIZZTRi8O00UFj3EKQBiTDaEzBfk00RrDpQmnjj35m0Syz7TYSkY30GqTU7CvEAdLV2Iah+ABxuiqfBlTtsrqP1BapFHTzSKEq/NPBJ6VHGLJiZandhfGcbTrxToqkr3EMZ03Q1CKWKg6kVhnU=
Received: from DS7PR03CA0032.namprd03.prod.outlook.com (2603:10b6:5:3b5::7) by
 PH8PR12MB6868.namprd12.prod.outlook.com (2603:10b6:510:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Fri, 5 Aug
 2022 21:13:21 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::be) by DS7PR03CA0032.outlook.office365.com
 (2603:10b6:5:3b5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Fri, 5 Aug 2022 21:13:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 21:13:20 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 16:13:17 -0500
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Harry Wentland <harry.wentland@amd.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        <hersenxs.wu@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Claudio Suarez <cssk@net-c.es>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Roman Li <Roman.Li@amd.com>, Ian Chen <ian.chen@amd.com>,
        Colin Ian King <colin.king@intel.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@intel.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Imre Deak <imre.deak@intel.com>,
        David Zhang <dingchen.zhang@amd.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH v2 1/3] drm/dp_mst: add passthrough_aux to struct drm_dp_mst_port
Date:   Fri, 5 Aug 2022 17:13:03 -0400
Message-ID: <20220805211317.176672-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3910ee1c-cd67-4a19-9baf-08da77275335
X-MS-TrafficTypeDiagnostic: PH8PR12MB6868:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6MFM508ZVhXSCIr4flpQ1S4d6uLkVqwqAeWe30oOYRZaa+5iHmWEOovNUqf/PCq3lUvRLMMV62MTj8ZSLAHLjWAh/UGyo0zBZEnASwSNJZ5A+tIRfrhTIPEjBiMDwYSXnUN7ijWxgkueEx9NFCRNOjFm/WyhKQMQUbGB9uAsluEhuuSu9pIDQn5OABPUCXhCmmA3pf0ND5WFgZEjg+gUJ5pIKhrrzcPI2M1Gr6Cgz458E1VMAVx5OedAmWdjje+YBC2GO+J0DAVmjmlzcbZTZdzYNzWA7tsIOfqxkm+Va8nPKrPLHusNT/J3khESlI2tT6lBWuiHsetN+53MR6eSstb2q83ci2cuVEI/RwLSI0YNpJd9XooUG4evl8909U9a8spkjjKXgox2Atk3tKzs61+7zYznNBA6KUPYEwnS1AZVD+N6rH7ukctiad7xzrUkEWrvafohpRHo9prKBN6N6mBaBgYcenUc7xhq51a4UPaoevLFwq/isJObpUc1Qwonw8ERfdS3c7ky5tprddu7JSq9uVSyasVvXFHvB+FuHP5k6Mt0TLiMJqIkMfTXcQiEX8RL21+u7jSnnXGtgmPe726wo7wM7W0b06gCBB7SqcGqeceTY1pj/eowmPpuo306+IWQUkU2RQ0aSMPZq111Qy0dYsXFnRMTB8QnxrfUq/zO5H53lezTuZeJQ4uPSZs1MD3dti4x2uXz7sgQU2yfbA6cFVd9jdFojaayqCqeXAKsJNWff21bGx0ZXPfbXVUjz8oQWsityf/COX8CLyPnsSe86LO184QqdMGKMYqoAEwe/qNUuKcXHW95U0f0gPYqkiHiJ/cXTqoXP5jP3C9NWNCzgi8pRgHYcCMsriKh5C7r3JcJ6tFzQVKcJq1JRKd/
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(396003)(39860400002)(40470700004)(46966006)(36840700001)(86362001)(316002)(81166007)(54906003)(8936002)(6916009)(36756003)(356005)(40480700001)(70206006)(8676002)(4326008)(7696005)(26005)(70586007)(41300700001)(6666004)(16526019)(336012)(47076005)(426003)(2616005)(83380400001)(82740400003)(186003)(40460700003)(1076003)(478600001)(82310400005)(2906002)(36860700001)(5660300002)(44832011)(7416002)(16060500005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 21:13:20.8704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3910ee1c-cd67-4a19-9baf-08da77275335
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6868
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there is no way to identify if DSC pass-through can be
enabled and what aux DSC pass-through requests ought to be sent to. So,
add a variable to struct drm_dp_mst_port that keeps track of the
aforementioned information.

Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
v2: define DP_DSC_PASSTHROUGH_IS_SUPPORTED
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 4 +++-
 include/drm/display/drm_dp.h                  | 1 +
 include/drm/display/drm_dp_mst_helper.h       | 3 +++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 67b3b9697da7..71915afd9892 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -5921,8 +5921,10 @@ struct drm_dp_aux *drm_dp_mst_dsc_aux_for_port(struct drm_dp_mst_port *port)
 		/* Enpoint decompression with DP-to-DP peer device */
 		if ((endpoint_dsc & DP_DSC_DECOMPRESSION_IS_SUPPORTED) &&
 		    (endpoint_fec & DP_FEC_CAPABLE) &&
-		    (upstream_dsc & 0x2) /* DSC passthrough */)
+		    (upstream_dsc & DP_DSC_PASSTHROUGH_IS_SUPPORTED)) {
+			port->passthrough_aux = &immediate_upstream_port->aux;
 			return &port->aux;
+		}
 
 		/* Virtual DPCD decompression with DP-to-DP peer device */
 		return &immediate_upstream_port->aux;
diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index 9e3aff7e68bb..4d0abe4c7ea9 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -239,6 +239,7 @@
 
 #define DP_DSC_SUPPORT                      0x060   /* DP 1.4 */
 # define DP_DSC_DECOMPRESSION_IS_SUPPORTED  (1 << 0)
+# define DP_DSC_PASSTHROUGH_IS_SUPPORTED    (1 << 1)
 
 #define DP_DSC_REV                          0x061
 # define DP_DSC_MAJOR_MASK                  (0xf << 0)
diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
index 10adec068b7f..4a39c95f8afd 100644
--- a/include/drm/display/drm_dp_mst_helper.h
+++ b/include/drm/display/drm_dp_mst_helper.h
@@ -86,6 +86,8 @@ struct drm_dp_vcpi {
  * @next: link to next port on this branch device
  * @aux: i2c aux transport to talk to device connected to this port, protected
  * by &drm_dp_mst_topology_mgr.base.lock.
+ * @passthrough_aux: parent aux to which DSC pass-through requests should be
+ * sent, only set if DSC pass-through is possible.
  * @parent: branch device parent of this port
  * @vcpi: Virtual Channel Payload info for this port.
  * @connector: DRM connector this port is connected to. Protected by
@@ -140,6 +142,7 @@ struct drm_dp_mst_port {
 	 */
 	struct drm_dp_mst_branch *mstb;
 	struct drm_dp_aux aux; /* i2c bus for this port? */
+	struct drm_dp_aux *passthrough_aux;
 	struct drm_dp_mst_branch *parent;
 
 	struct drm_dp_vcpi vcpi;
-- 
2.37.1

