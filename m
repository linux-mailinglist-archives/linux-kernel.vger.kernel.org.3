Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173754D7F29
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238231AbiCNJye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238156AbiCNJyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:54:16 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D0E2A72F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 02:53:04 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id z26so20967186lji.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 02:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:organization:content-transfer-encoding;
        bh=lrKfwBXTRpFqEwpXR2ITLOR2hSsnB+amSwBGJQoamgU=;
        b=yKGGUkLktagWPzrcBccI4hG2eJ6S4yP13kPRpcr0Jd/5pOHSUj5NuGuCBC/10uS2Ta
         4Lf9JoKNS2dgcvvbncN4Oimk2+UdTH0FD7DbTJvow57jPOnbTJEDzBtbUhPel9seNFtm
         3tOHLm7I/BjD8x7r2QaHMRDSvysHnVNc4B9Rl3IWJMqEPKqsQlU75Y/G/MYKT6P4w+TW
         3zaTX5JROYXm+PUywUsBdD0fYH9y+ZecOS/YBWN0yP3eECMHk/y7qJGXLG00z4LU1ndf
         7Tr8LWDTI9YaOD6tYT3VOxQQR+GXS3RFdJAmmCj9T7mkQcUuSQsNYLMynJi0+GWKGqZf
         sHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=lrKfwBXTRpFqEwpXR2ITLOR2hSsnB+amSwBGJQoamgU=;
        b=c1hUHSTw7VhRCxbWSPhEZ9Kwb21Kl7iRJH5Dr21hv/as/dvpKYq2mGUkq7Wvl4MKyO
         geasme8FmHO9XVmZAsmCwMV1ghkeiCfQKMahFQ7my2L/OBOhJlV95STLV+gTSMlM6eER
         HJVLeQN3Xm0es1itokSg1i+Wnc255XgSI0xVLHflDToj5B/J/qKL6GdQe4sVtK06lwdf
         /RN8rssKu5lqsqZ/qVmoZEMwUDDpGRKhgg8sbd0ptRvWqbYuThxwBbUkRMRH1LcsFGss
         C/EbJl+6wANhKbnU9Qr9pXVdHV2StOZM3VHuLZac5frm0QWmjBXt7bVv5XtHHeLhFuMY
         yZAQ==
X-Gm-Message-State: AOAM531VlKCfu5KWeUxFGj9tBXcgqBUM2bWp+iqW0EjYkt8V0NLg39Ra
        7ijS7eYuSZUa1fih8+LwT6vodA==
X-Google-Smtp-Source: ABdhPJyvrn1qFCc5J6uOiIUk7xq9KgyhihqE/2PsJeflX5WHytSKOUPmcmGfni0XraZoA/Gxz07Few==
X-Received: by 2002:a05:651c:1245:b0:247:e2af:3574 with SMTP id h5-20020a05651c124500b00247e2af3574mr13962129ljh.137.1647251582414;
        Mon, 14 Mar 2022 02:53:02 -0700 (PDT)
Received: from veiron.westermo.com (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id b3-20020a056512304300b004488e49f2fasm984870lfb.129.2022.03.14.02.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 02:53:01 -0700 (PDT)
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
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Cooper Lees <me@cooperlees.com>,
        Matt Johnston <matt@codeconstruct.com.au>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bridge@lists.linux-foundation.org
Subject: [PATCH v3 net-next 05/14] net: bridge: mst: Notify switchdev drivers of VLAN MSTI migrations
Date:   Mon, 14 Mar 2022 10:52:22 +0100
Message-Id: <20220314095231.3486931-6-tobias@waldekranz.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220314095231.3486931-1-tobias@waldekranz.com>
References: <20220314095231.3486931-1-tobias@waldekranz.com>
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

Whenever a VLAN moves to a new MSTI, send a switchdev notification so
that switchdevs can track a bridge's VID to MSTI mappings.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/switchdev.h   |  7 ++++++
 net/bridge/br_mst.c       | 14 ++++++++++++
 net/bridge/br_switchdev.c | 46 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 85dd004dc9ad..53dfa0f7cf5b 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -29,6 +29,7 @@ enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_BRIDGE_MROUTER,
 	SWITCHDEV_ATTR_ID_BRIDGE_MST,
 	SWITCHDEV_ATTR_ID_MRP_PORT_ROLE,
+	SWITCHDEV_ATTR_ID_VLAN_MSTI,
 };
 
 struct switchdev_brport_flags {
@@ -36,6 +37,11 @@ struct switchdev_brport_flags {
 	unsigned long mask;
 };
 
+struct switchdev_vlan_msti {
+	u16 vid;
+	u16 msti;
+};
+
 struct switchdev_attr {
 	struct net_device *orig_dev;
 	enum switchdev_attr_id id;
@@ -52,6 +58,7 @@ struct switchdev_attr {
 		bool mst;				/* BRIDGE_MST */
 		bool mc_disabled;			/* MC_DISABLED */
 		u8 mrp_port_role;			/* MRP_PORT_ROLE */
+		struct switchdev_vlan_msti vlan_msti;	/* VLAN_MSTI */
 	} u;
 };
 
diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 39057585c302..2f761d27d69e 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/kernel.h>
+#include <net/switchdev.h>
 
 #include "br_private.h"
 
@@ -65,13 +66,26 @@ static void br_mst_vlan_sync_state(struct net_bridge_vlan *pv, u16 msti)
 
 int br_mst_vlan_set_msti(struct net_bridge_vlan *mv, u16 msti)
 {
+	struct switchdev_attr attr = {
+		.id = SWITCHDEV_ATTR_ID_VLAN_MSTI,
+		.orig_dev = mv->br->dev,
+		.u.vlan_msti = {
+			.vid = mv->vid,
+			.msti = msti,
+		},
+	};
 	struct net_bridge_vlan_group *vg;
 	struct net_bridge_vlan *pv;
 	struct net_bridge_port *p;
+	int err;
 
 	if (mv->msti == msti)
 		return 0;
 
+	err = switchdev_port_attr_set(mv->br->dev, &attr, NULL);
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
 	mv->msti = msti;
 
 	list_for_each_entry(p, &mv->br->port_list, list) {
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 6f6a70121a5e..8cc44c367231 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -331,6 +331,46 @@ br_switchdev_fdb_replay(const struct net_device *br_dev, const void *ctx,
 	return err;
 }
 
+static int br_switchdev_vlan_attr_replay(struct net_device *br_dev,
+					 const void *ctx,
+					 struct notifier_block *nb,
+					 struct netlink_ext_ack *extack)
+{
+	struct switchdev_notifier_port_attr_info attr_info = {
+		.info = {
+			.dev = br_dev,
+			.extack = extack,
+			.ctx = ctx,
+		},
+	};
+	struct net_bridge *br = netdev_priv(br_dev);
+	struct net_bridge_vlan_group *vg;
+	struct switchdev_attr attr;
+	struct net_bridge_vlan *v;
+	int err;
+
+	attr_info.attr = &attr;
+	attr.orig_dev = br_dev;
+
+	vg = br_vlan_group(br);
+
+	list_for_each_entry(v, &vg->vlan_list, vlist) {
+		if (v->msti) {
+			attr.id = SWITCHDEV_ATTR_ID_VLAN_MSTI;
+			attr.u.vlan_msti.vid = v->vid;
+			attr.u.vlan_msti.msti = v->msti;
+
+			err = nb->notifier_call(nb, SWITCHDEV_PORT_ATTR_SET,
+						&attr_info);
+			err = notifier_to_errno(err);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
 static int
 br_switchdev_vlan_replay_one(struct notifier_block *nb,
 			     struct net_device *dev,
@@ -425,6 +465,12 @@ static int br_switchdev_vlan_replay(struct net_device *br_dev,
 			return err;
 	}
 
+	if (adding) {
+		err = br_switchdev_vlan_attr_replay(br_dev, ctx, nb, extack);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
-- 
2.25.1

