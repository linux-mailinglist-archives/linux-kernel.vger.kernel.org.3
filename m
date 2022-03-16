Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BBC4DB47C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357090AbiCPPLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357077AbiCPPLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:11:11 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE3168F85
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:09:20 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id s29so4203382lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:organization:content-transfer-encoding;
        bh=mgkeZq+OzQVdtsS30MEyH+ERcJSrmRmksLXcxdMjf7o=;
        b=fkiGS9qHxMimtRvEchwSzZ2jueyhtJtAtzgrkx2f2e393BLo72s0z/qODDkKBfl8pV
         a0zdL2drg0SrGKGUTxr2CeR2A6RF/usZgVO699hYu1L+sI41kZMXkXzsZuGNuXH3qniH
         eXk/OZwhs7zxmw32VcP2+gJOFfy1xlVn8vnkkIcMh7kpBWms6f6FdBFa5RE2rUj30lIj
         UaCrqS1nbP9fD37cbqUGVLTCGn+wrU4mMK/gL+tLytce2B4uwajUkdRWFmzui17xLV1C
         w9M8fErF9lqUH44BZPuPbugsD5/xZcNU2bWHlVzMeBdql2ogoX8UmDrS0nKcdVAMS/Qi
         qVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=mgkeZq+OzQVdtsS30MEyH+ERcJSrmRmksLXcxdMjf7o=;
        b=BfFR2NV6YPZ/xPgVvX2eC1FXNViGMoeoVCtgvOBzB3Y+dPjq1fpih7V1sYMuuRC93a
         CXxW78kg0wYdGm5Gj7n78X4nZoiAxN7qCllNoKPWEWXD1Q6LSRxg2rBwq86lSpA0c8oy
         WLWWHFdoYB6rjzHCvPMAzfa3/6kd6AdJaVBFUUtlvh08IhEYkS0bYQdmTs74tNjIRZFL
         /h3GfEmkj3sGUTHJBDK+Kdi1EwUT/r1yki5xme1bckr2G8J2fLuIpK4kOsuab1UE68Xa
         NN95mn3ZvljvahO7b2v3SnKea3LTe23gyel/YkJ6UwaLSWnsQtb8Owhfwkgi6gZ/2lSJ
         Sn6g==
X-Gm-Message-State: AOAM531/JRFqpDuYFWZtxtayYX+5UWPwNw9AHMxCDcbtc5RPmKjrqo8f
        orn2x10nnT55IS0U60ZLF27spw==
X-Google-Smtp-Source: ABdhPJzgHn4kNmZ5ZseCg9IJdp341pFqp8Ltk6FUvX4LMIx0gOz2T29a0OBPlfe5RGVcpbGUvWEKHA==
X-Received: by 2002:a05:6512:246:b0:448:24d4:e69f with SMTP id b6-20020a056512024600b0044824d4e69fmr108707lfo.66.1647443358362;
        Wed, 16 Mar 2022 08:09:18 -0700 (PDT)
Received: from veiron.westermo.com (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id d2-20020a194f02000000b00448b915e2d3sm176048lfb.99.2022.03.16.08.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 08:09:17 -0700 (PDT)
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
        Ido Schimmel <idosch@nvidia.com>,
        Matt Johnston <matt@codeconstruct.com.au>,
        Cooper Lees <me@cooperlees.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Subject: [PATCH v5 net-next 12/15] net: dsa: Handle MST state changes
Date:   Wed, 16 Mar 2022 16:08:54 +0100
Message-Id: <20220316150857.2442916-13-tobias@waldekranz.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316150857.2442916-1-tobias@waldekranz.com>
References: <20220316150857.2442916-1-tobias@waldekranz.com>
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

Add the usual trampoline functionality from the generic DSA layer down
to the drivers for MST state changes.

When a state changes to disabled/blocking/listening, make sure to fast
age any dynamic entries in the affected VLANs (those controlled by the
MSTI in question).

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/dsa.h  |  3 ++
 net/dsa/dsa_priv.h |  3 ++
 net/dsa/port.c     | 85 +++++++++++++++++++++++++++++++++++++++++-----
 net/dsa/slave.c    |  6 ++++
 4 files changed, 89 insertions(+), 8 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 644fda2293a2..06cdefd3b9dd 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -957,7 +957,10 @@ struct dsa_switch_ops {
 				     struct dsa_bridge bridge);
 	void	(*port_stp_state_set)(struct dsa_switch *ds, int port,
 				      u8 state);
+	int	(*port_mst_state_set)(struct dsa_switch *ds, int port,
+				      const struct switchdev_mst_state *state);
 	void	(*port_fast_age)(struct dsa_switch *ds, int port);
+	int	(*port_vlan_fast_age)(struct dsa_switch *ds, int port, u16 vid);
 	int	(*port_pre_bridge_flags)(struct dsa_switch *ds, int port,
 					 struct switchdev_brport_flags flags,
 					 struct netlink_ext_ack *extack);
diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index d90b4cf0c9d2..5d3f4a67dce1 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -215,6 +215,9 @@ static inline struct net_device *dsa_master_find_slave(struct net_device *dev,
 void dsa_port_set_tag_protocol(struct dsa_port *cpu_dp,
 			       const struct dsa_device_ops *tag_ops);
 int dsa_port_set_state(struct dsa_port *dp, u8 state, bool do_fast_age);
+int dsa_port_set_mst_state(struct dsa_port *dp,
+			   const struct switchdev_mst_state *state,
+			   struct netlink_ext_ack *extack);
 int dsa_port_enable_rt(struct dsa_port *dp, struct phy_device *phy);
 int dsa_port_enable(struct dsa_port *dp, struct phy_device *phy);
 void dsa_port_disable_rt(struct dsa_port *dp);
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 3ac114f6fc22..32d472a82241 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -30,12 +30,11 @@ static int dsa_port_notify(const struct dsa_port *dp, unsigned long e, void *v)
 	return dsa_tree_notify(dp->ds->dst, e, v);
 }
 
-static void dsa_port_notify_bridge_fdb_flush(const struct dsa_port *dp)
+static void dsa_port_notify_bridge_fdb_flush(const struct dsa_port *dp, u16 vid)
 {
 	struct net_device *brport_dev = dsa_port_to_bridge_port(dp);
 	struct switchdev_notifier_fdb_info info = {
-		/* flush all VLANs */
-		.vid = 0,
+		.vid = vid,
 	};
 
 	/* When the port becomes standalone it has already left the bridge.
@@ -57,7 +56,42 @@ static void dsa_port_fast_age(const struct dsa_port *dp)
 
 	ds->ops->port_fast_age(ds, dp->index);
 
-	dsa_port_notify_bridge_fdb_flush(dp);
+	/* flush all VLANs */
+	dsa_port_notify_bridge_fdb_flush(dp, 0);
+}
+
+static int dsa_port_vlan_fast_age(const struct dsa_port *dp, u16 vid)
+{
+	struct dsa_switch *ds = dp->ds;
+	int err;
+
+	if (!ds->ops->port_vlan_fast_age)
+		return -EOPNOTSUPP;
+
+	err = ds->ops->port_vlan_fast_age(ds, dp->index, vid);
+
+	if (!err)
+		dsa_port_notify_bridge_fdb_flush(dp, vid);
+
+	return err;
+}
+
+static int dsa_port_msti_fast_age(const struct dsa_port *dp, u16 msti)
+{
+	DECLARE_BITMAP(vids, VLAN_N_VID) = { 0 };
+	int err, vid;
+
+	err = br_mst_get_info(dsa_port_bridge_dev_get(dp), msti, vids);
+	if (err)
+		return err;
+
+	for_each_set_bit(vid, vids, VLAN_N_VID) {
+		err = dsa_port_vlan_fast_age(dp, vid);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
 
 static bool dsa_port_can_configure_learning(struct dsa_port *dp)
@@ -118,6 +152,42 @@ static void dsa_port_set_state_now(struct dsa_port *dp, u8 state,
 		pr_err("DSA: failed to set STP state %u (%d)\n", state, err);
 }
 
+int dsa_port_set_mst_state(struct dsa_port *dp,
+			   const struct switchdev_mst_state *state,
+			   struct netlink_ext_ack *extack)
+{
+	struct dsa_switch *ds = dp->ds;
+	u8 prev_state;
+	int err;
+
+	if (!ds->ops->port_mst_state_set)
+		return -EOPNOTSUPP;
+
+	err = br_mst_get_state(dsa_port_to_bridge_port(dp), state->msti,
+			       &prev_state);
+	if (err)
+		return err;
+
+	err = ds->ops->port_mst_state_set(ds, dp->index, state);
+	if (err)
+		return err;
+
+	if (!(dp->learning &&
+	      (prev_state == BR_STATE_LEARNING ||
+	       prev_state == BR_STATE_FORWARDING) &&
+	      (state->state == BR_STATE_DISABLED ||
+	       state->state == BR_STATE_BLOCKING ||
+	       state->state == BR_STATE_LISTENING)))
+		return 0;
+
+	err = dsa_port_msti_fast_age(dp, state->msti);
+	if (err)
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Unable to flush associated VLANs");
+
+	return 0;
+}
+
 int dsa_port_enable_rt(struct dsa_port *dp, struct phy_device *phy)
 {
 	struct dsa_switch *ds = dp->ds;
@@ -326,6 +396,8 @@ static bool dsa_port_supports_mst(struct dsa_port *dp)
 	struct dsa_switch *ds = dp->ds;
 
 	return ds->ops->vlan_msti_set &&
+		ds->ops->port_mst_state_set &&
+		ds->ops->port_vlan_fast_age &&
 		dsa_port_can_configure_learning(dp);
 }
 
@@ -749,10 +821,7 @@ int dsa_port_ageing_time(struct dsa_port *dp, clock_t ageing_clock)
 int dsa_port_mst_enable(struct dsa_port *dp, bool on,
 			struct netlink_ext_ack *extack)
 {
-	if (!on)
-		return 0;
-
-	if (!dsa_port_supports_mst(dp)) {
+	if (on && !dsa_port_supports_mst(dp)) {
 		NL_SET_ERR_MSG_MOD(extack, "Hardware does not support MST");
 		return -EINVAL;
 	}
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 1b3e792d0327..17615b706359 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -451,6 +451,12 @@ static int dsa_slave_port_attr_set(struct net_device *dev, const void *ctx,
 
 		ret = dsa_port_set_state(dp, attr->u.stp_state, true);
 		break;
+	case SWITCHDEV_ATTR_ID_PORT_MST_STATE:
+		if (!dsa_port_offloads_bridge_port(dp, attr->orig_dev))
+			return -EOPNOTSUPP;
+
+		ret = dsa_port_set_mst_state(dp, &attr->u.mst_state, extack);
+		break;
 	case SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING:
 		if (!dsa_port_offloads_bridge_dev(dp, attr->orig_dev))
 			return -EOPNOTSUPP;
-- 
2.25.1

