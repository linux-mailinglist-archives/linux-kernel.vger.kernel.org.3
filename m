Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE9558B105
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbiHEVOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240663AbiHEVN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:13:56 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0046566D
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 14:13:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KX2rFQy3n6tMQU+6xFSrX0XSb2H/GWkI6CUqWEqGBFUOumhTKaLTZUpveLip56lcphEADcCwX3M27Wup6uTRnmbVRHapIBUvB6bV9h7jOWqSMbnjhariDa4yooQTlnPfxXYU1vacA1JVAdVNzauzNoXToC3AE1JRw53q1QI5oQ6XRW9yjJR/ArYshRJ3u/HeCznFmQS6xqmfS/+rxXa+w7Z1LHSHgqkXXOYfEbUTXvUHtNLTXvIfDI64cScRuK5Ezt6wXcjwcHwJMtlE2LksM8Vbwo7BGqnCCrIci4AjsMMpTujlRvTq5TvQAyJZn4A6Smf6ORoy956vd1NUHJBPxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fUt78HE3j4RmonrO6v4QIV3PvvikW4MNAdao+ETDlY=;
 b=W4k84tI1aPXck/cE5ZvVZ3V0D4RqbuTvh1K0fQo8DaHqTXIMZsXDHBTKDzbE7k2A1VTVp6VFz4pGHp68FK8AU/JvsywkfM53UBDt7rsjyIJIEDYD2XuzpuclteaAP7RLXq0NxnFLCup/UNrfaptqytTGbuU+9famwSrr7ctrRKncJYGXOxiwaZZ8WDdLwLsoX4OBODunynAN3PDCHEmKqaikXUpE6IW7yu8RLBkjeiXVUlZCdQ09nPzVMrcUCFpeJPHLGgAcpASU6uuX3PKaDtM43uqM7mIf2SmLvPIfDGXPJmcM++NflcdgjlWv+B7HpXuTwOKIxJcloyQWI08AzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fUt78HE3j4RmonrO6v4QIV3PvvikW4MNAdao+ETDlY=;
 b=yUdZv/suywYUK4ebmFNCed21tI5lN9TY8x4l1kxt798NYxj9hsfEKWveiWNuArx5tTY6GZCU5/qD/cXnogYyBoy2kEwFlqcw6oan1miGrdH6kYS0l3ECogHXHPjA8FQG/zuBhyFbSx+0BKL+3JOl3BOhptEX3/OlLbA5Uar2gO8=
Received: from DS7PR03CA0061.namprd03.prod.outlook.com (2603:10b6:5:3bb::6) by
 SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 21:13:52 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::e7) by DS7PR03CA0061.outlook.office365.com
 (2603:10b6:5:3bb::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16 via Frontend
 Transport; Fri, 5 Aug 2022 21:13:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 21:13:51 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 16:13:49 -0500
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
        Claudio Suarez <cssk@net-c.es>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        "Roman Li" <Roman.Li@amd.com>, Ian Chen <ian.chen@amd.com>,
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
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH v2 3/3] drm/amd/display: implement DSC pass-through support
Date:   Fri, 5 Aug 2022 17:13:05 -0400
Message-ID: <20220805211317.176672-3-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805211317.176672-1-hamza.mahfooz@amd.com>
References: <20220805211317.176672-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b119af5-f0cf-4812-ae30-08da772765bf
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5611:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ojLa9NQs23QWJ3NOtuleR9PLFhF7/REeOYwfoK/sMFUsCy7nGT/2awzw/ypOCqap26O+1KW9+1FGH/x0Skg/UowcTEgmMtOxwAKYwNrObllBmRjZA2jiMFadLsAtFMjV8yD8kbbre9UMXd91DzvlLj+JKj3fl74D6Z1x7lRSY2mjqdGNR3TKEIIoWZjhGbL0LO3XqZTKUXUA7rRBndt6o8LKEi+KZHlJuGojJdDRd3DUR2dMUWxyiHsCO9+3SdiwZsjsnSZTi4Sc2FhY02xzdmKKm5HRNBnrqRpr/Gc39nVYdCCb4mJPc9W/8cF3WW8OZluSuVbRjJyR6lXldHN87W0x2R0nyUD3mneUe+x1RqhpDhj5NADdf7q/o0ZUE3WFzvsfbpvDwffMG5hQLXany3P8cKI4KpdaAPlaLOBu+87LNEUYaRybeN5sJa/sTOlTlRJz4NDak0xAsWCCcoqD88d24WlTGvklr45aQ6g/9OZEDVyYw/XWyrzx0mm1gvom3FSIh4QpArXU7TzUFdo6pQkzRWMhsNZZnZow7g/VbS6ZRrIO7D0/RgYY2NJQvhOvPTZ/3PjLgUkFlpJPzJTOUGUKsXAVBBTyCRknTzFNwyvyvzknHI500ydnovAjET2LYOG3fnkTNRmreLb9FadugZlxBgnFgybb6w4Mg9gx+xyqxIRtLEJZIk671s1eKb2tcwcogYvv2PBd7922WGUuqy9zUGMRLjsDZbnIsjaZc2gCF19axIllDvtnfVznIb879H5EQT2old8hDZuohlLT1/Tot1dB5PB3pSnbW31wENmcfvdenb6sUVh8+dJtTo6ecYkGpF8GpFB/8vk1u6rSdD6JGB8ZpLV4tMZ7jo8GqD0svC35OD3LNldTTDllf+wU
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(396003)(46966006)(36840700001)(40470700004)(5660300002)(8936002)(6916009)(54906003)(36860700001)(478600001)(82310400005)(70206006)(7416002)(44832011)(36756003)(8676002)(4326008)(316002)(426003)(26005)(7696005)(186003)(16526019)(1076003)(2616005)(70586007)(2906002)(41300700001)(6666004)(47076005)(336012)(40460700003)(40480700001)(83380400001)(82740400003)(86362001)(81166007)(356005)(16060500005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 21:13:51.9899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b119af5-f0cf-4812-ae30-08da772765bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we only attempt to setup DSC at the virtual DPCD port,
however many modern displays come with DSC support and MST hubs can now
support DSC pass-through. So, to more optimally make use of the
available bandwidth, use DSC pass-through when possible by adding DSC
pass-through enablement support into the DSC enable sequence.

Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
v2: print the correct type of port that we are writing to using dsc_aux
    in dm_helpers_dp_write_dsc_enable().
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 45 +++++++++++++++++--
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index a0154a5f7183..bd364d2cc4f7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -729,8 +729,14 @@ bool dm_helpers_dp_write_dsc_enable(
 		const struct dc_stream_state *stream,
 		bool enable)
 {
-	uint8_t enable_dsc = enable ? 1 : 0;
+	static const uint8_t DSC_DISABLE;
+	static const uint8_t DSC_DECODING = 0x01;
+	static const uint8_t DSC_PASSTHROUGH = 0x02;
+
 	struct amdgpu_dm_connector *aconnector;
+	struct drm_dp_mst_port *port;
+	uint8_t enable_dsc = enable ? DSC_DECODING : DSC_DISABLE;
+	uint8_t enable_passthrough = enable ? DSC_PASSTHROUGH : DSC_DISABLE;
 	uint8_t ret = 0;
 
 	if (!stream)
@@ -750,8 +756,39 @@ bool dm_helpers_dp_write_dsc_enable(
 				aconnector->dsc_aux, stream, enable_dsc);
 #endif
 
-		ret = drm_dp_dpcd_write(aconnector->dsc_aux, DP_DSC_ENABLE, &enable_dsc, 1);
-		DC_LOG_DC("Send DSC %s to MST RX\n", enable_dsc ? "enable" : "disable");
+		port = aconnector->port;
+
+		if (enable) {
+			if (port->passthrough_aux) {
+				ret = drm_dp_dpcd_write(port->passthrough_aux,
+							DP_DSC_ENABLE,
+							&enable_passthrough, 1);
+				DC_LOG_DC("Sent DSC pass-through enable to virtual dpcd port, ret = %u\n",
+					  ret);
+			}
+
+			ret = drm_dp_dpcd_write(aconnector->dsc_aux,
+						DP_DSC_ENABLE, &enable_dsc, 1);
+			DC_LOG_DC("Sent DSC decoding enable to %s port, ret = %u\n",
+				  (port->passthrough_aux) ? "remote RX" :
+				  "virtual dpcd",
+				  ret);
+		} else {
+			ret = drm_dp_dpcd_write(aconnector->dsc_aux,
+						DP_DSC_ENABLE, &enable_dsc, 1);
+			DC_LOG_DC("Sent DSC decoding disable to %s port, ret = %u\n",
+				  (port->passthrough_aux) ? "remote RX" :
+				  "virtual dpcd",
+				  ret);
+
+			if (port->passthrough_aux) {
+				ret = drm_dp_dpcd_write(port->passthrough_aux,
+							DP_DSC_ENABLE,
+							&enable_passthrough, 1);
+				DC_LOG_DC("Sent DSC pass-through disable to virtual dpcd port, ret = %u\n",
+					  ret);
+			}
+		}
 	}
 
 	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT || stream->signal == SIGNAL_TYPE_EDP) {
@@ -768,7 +805,7 @@ bool dm_helpers_dp_write_dsc_enable(
 #endif
 	}
 
-	return (ret > 0);
+	return ret;
 }
 
 bool dm_helpers_is_dp_sink_present(struct dc_link *link)
-- 
2.37.1

