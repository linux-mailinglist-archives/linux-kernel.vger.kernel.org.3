Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804CE4C88E1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiCAKFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbiCAKEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:04:35 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA178BF1E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 02:03:53 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 29so21102046ljv.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 02:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:organization:content-transfer-encoding;
        bh=yuCZ0mCQ7kvhi5DjalgIG8uPVoVRxyzFJETY+ZZ8iS8=;
        b=KnpuOsFuuWdfSJ00n5q4w09njAQx7uXq7CpPG8PscWCUNiGj2gQQDMtf2GhNH22mq2
         9FRdqeadjDIV6pveBFo1wOtZtuCBHNQCy3XU75fZR0rVf7vypjUiebZ8bk4SGKfsOO1p
         1E+6+W2/4VRvWXagQtvFTLpvJnCbm9WOeJL3zGRQph/pfSQFHZMMylkNwbEFp5HkXUi/
         ocyVKBw8GVWsod6PiMVH3pf6bl4CaL9nkm7s5ZewI8UZnKW9DRdOaF4/u3p4rH0TrMPa
         2n9B/1kLyS5zjb/8En4MmPXVZQ9jGZN3ovow3ZTOFn4hn+l1ut3I2CpiudqjCG/yuJ8z
         V78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=yuCZ0mCQ7kvhi5DjalgIG8uPVoVRxyzFJETY+ZZ8iS8=;
        b=s3ctyRwoPL+BZ1deJeGMGiP/JsOzzPM4ppoPGisesK7vzlBUbRF6ng705DX61lNWMe
         4Av8czrXWj/LQTvk+18SevruGcC/AsJ0+CMh8e5uqkFP6DSl49cYLyFxqiYmYzYXO2yk
         rAKFtXiFT3NL2yDpGw6omObXP6NglxeFuEaXGPEiRVtgIWUOxCvNLjHoX4EG4mOipxcO
         r4fmzcs0cdBct7Oo81/oxw9cPdRxo9IZlfb1XFyryK5mWw5dro64Up1TddSErBjI3OMp
         O71Oz53nZbZvtlMaDIwYUCS5SjfFTTDX1Dm+0QVsy8/gNucwe3OM/5Kv9P7LI2KJfSVZ
         Cl+A==
X-Gm-Message-State: AOAM532SwTeIhu8b3Um+FO7KJJHVzFGXeY5BC73TGGJSBv70wS7Atd0D
        yoJxTUqX4IZQS2dOIvGcfmm1vQ==
X-Google-Smtp-Source: ABdhPJzvAuB+A+tyWYUg2p36MtoBhoJgiKxJMZXVYU1+owvHEHDxWRu2futMleOP+zx/WGNstCBbEg==
X-Received: by 2002:a2e:9ac7:0:b0:244:9022:220b with SMTP id p7-20020a2e9ac7000000b002449022220bmr16728216ljj.254.1646129032272;
        Tue, 01 Mar 2022 02:03:52 -0800 (PST)
Received: from veiron.westermo.com (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id s27-20020a05651c049b00b002460fd4252asm1826822ljc.100.2022.03.01.02.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 02:03:51 -0800 (PST)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Ivan Vecera <ivecera@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Russell King <linux@armlinux.org.uk>,
        Petr Machata <petrm@nvidia.com>,
        Cooper Lees <me@cooperlees.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Matt Johnston <matt@codeconstruct.com.au>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bridge@lists.linux-foundation.org
Subject: [PATCH v2 net-next 05/10] net: bridge: mst: Notify switchdev drivers of MST state changes
Date:   Tue,  1 Mar 2022 11:03:16 +0100
Message-Id: <20220301100321.951175-6-tobias@waldekranz.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220301100321.951175-1-tobias@waldekranz.com>
References: <20220301100321.951175-1-tobias@waldekranz.com>
MIME-Version: 1.0
Organization: Westermo
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generate a switchdev notification whenever an MST state changes. This
notification is keyed by the VLANs MSTI rather than the VID, since
multiple VLANs may share the same MST instance.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/switchdev.h |  7 +++++++
 net/bridge/br_mst.c     | 21 +++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 39e57aa5005a..441beeb2fda5 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -19,6 +19,7 @@
 enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_UNDEFINED,
 	SWITCHDEV_ATTR_ID_PORT_STP_STATE,
+	SWITCHDEV_ATTR_ID_PORT_MST_STATE,
 	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS,
 	SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS,
 	SWITCHDEV_ATTR_ID_PORT_MROUTER,
@@ -31,6 +32,11 @@ enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_VLAN_MSTI,
 };
 
+struct switchdev_mst_state {
+	u16 msti;
+	u8 state;
+};
+
 struct switchdev_brport_flags {
 	unsigned long val;
 	unsigned long mask;
@@ -52,6 +58,7 @@ struct switchdev_attr {
 	void (*complete)(struct net_device *dev, int err, void *priv);
 	union {
 		u8 stp_state;				/* PORT_STP_STATE */
+		struct switchdev_mst_state mst_state;	/* PORT_MST_STATE */
 		struct switchdev_brport_flags brport_flags; /* PORT_BRIDGE_FLAGS */
 		bool mrouter;				/* PORT_MROUTER */
 		clock_t ageing_time;			/* BRIDGE_AGEING_TIME */
diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index aba603675165..9cdd7d9e07c6 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -29,8 +29,18 @@ void br_mst_vlan_set_state(struct net_bridge_port *p, struct net_bridge_vlan *v,
 
 void br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state)
 {
+	struct switchdev_attr attr = {
+		.id = SWITCHDEV_ATTR_ID_PORT_MST_STATE,
+		.flags = SWITCHDEV_F_DEFER,
+		.orig_dev = p->dev,
+		.u.mst_state = {
+			.msti = msti,
+			.state = state,
+		},
+	};
 	struct net_bridge_vlan_group *vg;
 	struct net_bridge_vlan *v;
+	int err;
 
 	vg = nbp_vlan_group(p);
 	if (!vg)
@@ -42,6 +52,17 @@ void br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state)
 
 		br_mst_vlan_set_state(p, v, state);
 	}
+
+	if (!msti)
+		/* MSTI 0 (CST) state changes are notified via the
+		 * regular SWITCHDEV_ATTR_ID_PORT_STP_STATE.
+		 */
+		return;
+
+	err = switchdev_port_attr_set(p->dev, &attr, NULL);
+	if (err && err != -EOPNOTSUPP)
+		br_warn(p->br, "unable to offload MST state on %s in MSTI %u",
+			netdev_name(p->dev), msti);
 }
 
 static void br_mst_vlan_sync_state(struct net_bridge_vlan *pv, u16 msti)
-- 
2.25.1

