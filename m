Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1724C88DF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiCAKEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbiCAKEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:04:34 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9128CD85
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 02:03:53 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id t13so13956003lfd.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 02:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:organization:content-transfer-encoding;
        bh=az/xSk1cFf+663WFNGMDSdL6ZlzUb+e0Y66c2dIgICk=;
        b=BAOoXkp2k++ip4yaBp/8jKULasDNMBKsbfUiwLa2swzc45xYddCAwlwEjXR/CkAjTQ
         wCBsk/75rf+PZDUPTGpFI7K70MMZADloPUZuf83G/riFugsxNBll2we87yL/E1xiVKEd
         5oZhYXwr5B7Xwv2XyW0x7joHVlq23hwZlvGBaETYqOle7q9uB4/OLLf5UwlkM1o/YTcY
         flkohhEtgyDl22CNGpQrGrfUZUgkFua8LIT06Tp/j+zlV/PPHoheCUg9VssBL3i4EvfX
         f1S+TnJ3VtAPRJ4wJKBvVvIJrJtmhHyqaiz+UviJeKLvutwZ8tn2KbR5633jVxCDcood
         Ac0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=az/xSk1cFf+663WFNGMDSdL6ZlzUb+e0Y66c2dIgICk=;
        b=Zu6uATdIhE5IcnbgfGUYuHhfAUSXR+p/9AupBhWrs/GLMZWVMw19OOoGOXPfUIH5hb
         xuJa5g/2c4IUZB+1rFjC3zgk9YTWoufb99sAma8RRuOP4xMK45htPn+nASaJylZrcXkQ
         cuPo7z0kTzZgaH12MAdWBIHEqZ1Mem+YoxGH0Eg+slaP5Flqozq1qcEYcQyLv9buJJrm
         EFaM/qHQRIqNjikhVnUcWP5DP+GAnDyh3kslZ80gT7AWujzaHXeNPECZRHIUpLKi+wGI
         qZJDnSzCNE3rAZ+8CXbKQ3LEiuOqDKk37ej2/JlZCK9zaUxglbF6Qgg6aOPAg+wBU8eD
         jHPA==
X-Gm-Message-State: AOAM530rjL8WPqN6s0XycL3WbLvxps1GSP+4sf/JtWzTbNPuS+H5kkt+
        W/zVNyoSl/VLT1WsOL4fE8S3xg==
X-Google-Smtp-Source: ABdhPJydVSWWFKX0WRaP+6FV4Fs0fLx4UES4/xqRCI6RbrV0UXC2SO2MHSNAUfkaPW9qLY1X843mEw==
X-Received: by 2002:a05:6512:22c4:b0:43a:13a8:7e55 with SMTP id g4-20020a05651222c400b0043a13a87e55mr15155916lfu.296.1646129031409;
        Tue, 01 Mar 2022 02:03:51 -0800 (PST)
Received: from veiron.westermo.com (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id s27-20020a05651c049b00b002460fd4252asm1826822ljc.100.2022.03.01.02.03.50
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
Subject: [PATCH v2 net-next 04/10] net: bridge: mst: Notify switchdev drivers of VLAN MSTI migrations
Date:   Tue,  1 Mar 2022 11:03:15 +0100
Message-Id: <20220301100321.951175-5-tobias@waldekranz.com>
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

Whenever a VLAN moves to a new MSTI, send a switchdev notification so
that switchdevs can...

...either refuse the migration if the hardware does not support
offloading of MST...

..or track a bridge's VID to MSTI mapping when offloading is
supported.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/switchdev.h   | 10 +++++++
 net/bridge/br_mst.c       | 15 +++++++++++
 net/bridge/br_switchdev.c | 57 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 3e424d40fae3..39e57aa5005a 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -28,6 +28,7 @@ enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED,
 	SWITCHDEV_ATTR_ID_BRIDGE_MROUTER,
 	SWITCHDEV_ATTR_ID_MRP_PORT_ROLE,
+	SWITCHDEV_ATTR_ID_VLAN_MSTI,
 };
 
 struct switchdev_brport_flags {
@@ -35,6 +36,14 @@ struct switchdev_brport_flags {
 	unsigned long mask;
 };
 
+struct switchdev_vlan_attr {
+	u16 vid;
+
+	union {
+		u16 msti;
+	};
+};
+
 struct switchdev_attr {
 	struct net_device *orig_dev;
 	enum switchdev_attr_id id;
@@ -50,6 +59,7 @@ struct switchdev_attr {
 		u16 vlan_protocol;			/* BRIDGE_VLAN_PROTOCOL */
 		bool mc_disabled;			/* MC_DISABLED */
 		u8 mrp_port_role;			/* MRP_PORT_ROLE */
+		struct switchdev_vlan_attr vlan_attr;	/* VLAN_* */
 	} u;
 };
 
diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 8dea8e7257fd..aba603675165 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/kernel.h>
+#include <net/switchdev.h>
 
 #include "br_private.h"
 
@@ -65,9 +66,23 @@ static void br_mst_vlan_sync_state(struct net_bridge_vlan *pv, u16 msti)
 
 int br_mst_vlan_set_msti(struct net_bridge_vlan *mv, u16 msti)
 {
+	struct switchdev_attr attr = {
+		.id = SWITCHDEV_ATTR_ID_VLAN_MSTI,
+		.flags = SWITCHDEV_F_DEFER,
+		.orig_dev = mv->br->dev,
+		.u.vlan_attr = {
+			.vid = mv->vid,
+			.msti = msti,
+		},
+	};
 	struct net_bridge_vlan_group *vg;
 	struct net_bridge_vlan *pv;
 	struct net_bridge_port *p;
+	int err;
+
+	err = switchdev_port_attr_set(mv->br->dev, &attr, NULL);
+	if (err && err != -EOPNOTSUPP)
+		return err;
 
 	mv->msti = msti;
 
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 6f6a70121a5e..160d7659f88a 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -428,6 +428,57 @@ static int br_switchdev_vlan_replay(struct net_device *br_dev,
 	return 0;
 }
 
+static int br_switchdev_mst_replay(struct net_device *br_dev,
+				   const void *ctx, bool adding,
+				   struct notifier_block *nb,
+				   struct netlink_ext_ack *extack)
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
+	struct net_bridge_vlan *v;
+	int err;
+
+	ASSERT_RTNL();
+
+	if (!nb)
+		return 0;
+
+	if (!netif_is_bridge_master(br_dev))
+		return -EINVAL;
+
+	vg = br_vlan_group(br);
+
+	list_for_each_entry(v, &vg->vlan_list, vlist) {
+		struct switchdev_attr attr = {
+			.id = SWITCHDEV_ATTR_ID_VLAN_MSTI,
+			.flags = SWITCHDEV_F_DEFER,
+			.orig_dev = br_dev,
+			.u.vlan_attr = {
+				.vid = v->vid,
+				.msti = v->msti,
+			}
+		};
+
+		if (!v->msti)
+			continue;
+
+		attr_info.attr = &attr;
+		err = nb->notifier_call(nb, SWITCHDEV_PORT_ATTR_SET, &attr_info);
+		err = notifier_to_errno(err);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 struct br_switchdev_mdb_complete_info {
 	struct net_bridge_port *port;
@@ -695,6 +746,10 @@ static int nbp_switchdev_sync_objs(struct net_bridge_port *p, const void *ctx,
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
+	err = br_switchdev_mst_replay(br_dev, ctx, true, blocking_nb, extack);
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
 	err = br_switchdev_mdb_replay(br_dev, dev, ctx, true, blocking_nb,
 				      extack);
 	if (err && err != -EOPNOTSUPP)
@@ -719,6 +774,8 @@ static void nbp_switchdev_unsync_objs(struct net_bridge_port *p,
 
 	br_switchdev_mdb_replay(br_dev, dev, ctx, false, blocking_nb, NULL);
 
+	br_switchdev_mst_replay(br_dev, ctx, false, blocking_nb, NULL);
+
 	br_switchdev_vlan_replay(br_dev, ctx, false, blocking_nb, NULL);
 }
 
-- 
2.25.1

