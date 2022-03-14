Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC104D7F2B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238253AbiCNJyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238170AbiCNJyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:54:19 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2E417E18
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 02:53:07 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s25so20997330lji.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 02:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:organization:content-transfer-encoding;
        bh=O8maULfjhyJR+IE8gj0IaXrGz2EfvemPnJwdNZ90D7o=;
        b=28vfELY4sLfx291r+KHjYUMVh4slEJAFpwd7s/KlUQxFnVAmbFaSwtOm3OKf3C1eSn
         sReh7nzukVteaRSK8ERsMSUREpQNso80rGWQCwHQjx5XE7WqK0iMrxCOp5WSMJXNoz/w
         IYJ8Lj5rU5uzdffqWkqyVd/lQeBWL9JLDoRcNwQ/htlc7YRU0IrrtTkxU8FZqVwZejyb
         YOJ/lbaq0fRsm6cnLC7UuOkZx/OgPbXrPJuXqE/SqEBCqpJlAcSy5BudQ2NA4oZIvxLJ
         NydZNST5RP+7rV9CSaZ/FjrrnwluUv0oJpeQn0sTmc0GpU35RTWjogDI/xw+pVp6iXNh
         NVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=O8maULfjhyJR+IE8gj0IaXrGz2EfvemPnJwdNZ90D7o=;
        b=TJjl5HRafszdome1a2UtJOuIQtXm0Uej7iPZDply4a3F5p2yznjgkO9N1xrffGO52C
         FQsXjRhDEsxZlCFHnHHZVKi1wNyAxgojjEA57D5kod4iOrVKaaDyyIdjFKTLO6DCjgC2
         OtHn57NmelJq42Q5nPM/1+6TmwuPGs3Iwq/WXLZ2/P0OPXNWe9oXJO4SK9c1hgW7/3g+
         Y5/+xKdr0Z1mWnJeQqLs4Lhgij7r+VHY17+asG+IknzUO31Ba4XatS4+8jNmALSD8tLa
         MgVz87pk94+/aKsIBi20/pRet/tMHvU/oDybgsojhkV1qAoHldgSg94pqPWIcnuU5dKV
         5qlQ==
X-Gm-Message-State: AOAM530YI4MKlf8HOT7abyNS6LZvV31RLQskVJE1aUZaZPsW0hIHkgPE
        A3LPOf7soQiBBDznsKvU5qAWzw==
X-Google-Smtp-Source: ABdhPJxYupU6c8PZ/GgL2NJ3edWebJC3iRJvPMPbhZyHLmF3r7fiPzJCP94eJb6WrsSxGUeNyid6Eg==
X-Received: by 2002:a05:651c:1503:b0:244:c075:2103 with SMTP id e3-20020a05651c150300b00244c0752103mr13520132ljf.442.1647251584949;
        Mon, 14 Mar 2022 02:53:04 -0700 (PDT)
Received: from veiron.westermo.com (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id b3-20020a056512304300b004488e49f2fasm984870lfb.129.2022.03.14.02.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 02:53:04 -0700 (PDT)
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
Subject: [PATCH v3 net-next 07/14] net: bridge: mst: Add helper to map an MSTI to a VID set
Date:   Mon, 14 Mar 2022 10:52:24 +0100
Message-Id: <20220314095231.3486931-8-tobias@waldekranz.com>
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

br_mst_get_info answers the question: "On this bridge, which VIDs are
mapped to the given MSTI?"

This is useful in switchdev drivers, which might have to fan-out
operations, relating to an MSTI, per VLAN.

An example: When a port's MST state changes from forwarding to
blocking, a driver may choose to flush the dynamic FDB entries on that
port to get faster reconvergence of the network, but this should only
be done in the VLANs that are managed by the MSTI in question.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/linux/if_bridge.h |  6 ++++++
 net/bridge/br_mst.c       | 26 ++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 3aae023a9353..46e6327fef06 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -119,6 +119,7 @@ int br_vlan_get_info(const struct net_device *dev, u16 vid,
 		     struct bridge_vlan_info *p_vinfo);
 int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
 			 struct bridge_vlan_info *p_vinfo);
+int br_mst_get_info(struct net_device *dev, u16 msti, unsigned long *vids);
 #else
 static inline bool br_vlan_enabled(const struct net_device *dev)
 {
@@ -151,6 +152,11 @@ static inline int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
 {
 	return -EINVAL;
 }
+static inline int br_mst_get_info(struct net_device *dev, u16 msti,
+				  unsigned long *vids)
+{
+	return -EINVAL;
+}
 #endif
 
 #if IS_ENABLED(CONFIG_BRIDGE)
diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 7d16926a3a31..eb18dbd5838f 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -13,6 +13,32 @@
 
 DEFINE_STATIC_KEY_FALSE(br_mst_used);
 
+int br_mst_get_info(struct net_device *dev, u16 msti, unsigned long *vids)
+{
+	struct net_bridge_vlan_group *vg;
+	struct net_bridge_vlan *v;
+	struct net_bridge *br;
+
+	ASSERT_RTNL();
+
+	if (!netif_is_bridge_master(dev))
+		return -EINVAL;
+
+	br = netdev_priv(dev);
+	if (!br_opt_get(br, BROPT_MST_ENABLED))
+		return -EINVAL;
+
+	vg = br_vlan_group(br);
+
+	list_for_each_entry(v, &vg->vlan_list, vlist) {
+		if (v->msti == msti)
+			set_bit(v->vid, vids);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(br_mst_get_info);
+
 static void br_mst_vlan_set_state(struct net_bridge_port *p, struct net_bridge_vlan *v,
 				  u8 state)
 {
-- 
2.25.1

