Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428F04DB46B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357065AbiCPPLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357033AbiCPPKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:10:49 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E637A673D9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:09:15 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bu29so4340119lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:organization:content-transfer-encoding;
        bh=TJ/ysLEqmTIrEKAi22qClFzQAMPt3L4KxozAj/kLyzE=;
        b=hWyG+mS9Kxs+/LhY6K5HDdevwY5y0klEWciUDA/sqtLTCzp0tYUn6erX4d36ClkWSI
         VucLJnX+1P9Nj2S4aDw+ehQ4mk/jBhbbC+vjiX3HlzPHnnI685RXwraSVt+RmrsQP7yN
         37VfSi3BGd/kPpMqU6yBeTLtn5xl1ZITJmwrwQPGfqxykFdQr7GTjj6CjXhxKSY2jS6H
         TgWaGAMcQWl4D/+cEXhRkozGZuXibto8+xIsb3xSiHbjumN0Y71L3/DyI2kkog2Q6WCk
         EhBt6bWXm5DxArP+Bl+oqC07OOXg15f13k7yLkIbTlCsGOvh2b6uhgRuwPa+ly6fUYE2
         z16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=TJ/ysLEqmTIrEKAi22qClFzQAMPt3L4KxozAj/kLyzE=;
        b=W1eRmf+6fV7ybKIOf2LvPFOQMody4UO5x3FaXXVxe5sR6gHQFux+xE/stHZx/QFasU
         ZrD5p992o+nj5qCOzXIic+DpGiiIzHsWHA0STNRPff9+//iKt6hm6ZcGYphVFhb1bZ+9
         ce6RIBLhBqkQ/0fd2PEitjQm+XNI7PBGUNIVuZzGb29YmBRHWddBVouof/eGQ3rn307v
         T9jpOh+fopiGqavBnA1xL6S4hABKAiwtrnVVoiwuOtfTaNd3ux6lZgjiq+9zi6xcRWUq
         z2IcsUVih5nQxojBOESe2N32FDoXPI+ObXPWq+SczVi7wOj15TdkaAY36n8EDp/0tRR8
         eZtg==
X-Gm-Message-State: AOAM533zUFWQfFtsf4KGWi8SWV3x07UJZeF9MO5y7kyf3sI5gb45QYNq
        JznuCY490uF2lFCQezTKzN8XXA==
X-Google-Smtp-Source: ABdhPJw3W+6hr7k/Qow2M2vxSYXUq9mv18Pdhd6yxNSHz8e12lhOMe1mcDcpa4gpziOw0j9E2jPupw==
X-Received: by 2002:ac2:48b5:0:b0:448:b9cf:ad2 with SMTP id u21-20020ac248b5000000b00448b9cf0ad2mr63639lfg.153.1647443353835;
        Wed, 16 Mar 2022 08:09:13 -0700 (PDT)
Received: from veiron.westermo.com (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id d2-20020a194f02000000b00448b915e2d3sm176048lfb.99.2022.03.16.08.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 08:09:13 -0700 (PDT)
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
Subject: [PATCH v5 net-next 07/15] net: bridge: mst: Add helper to map an MSTI to a VID set
Date:   Wed, 16 Mar 2022 16:08:49 +0100
Message-Id: <20220316150857.2442916-8-tobias@waldekranz.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316150857.2442916-1-tobias@waldekranz.com>
References: <20220316150857.2442916-1-tobias@waldekranz.com>
MIME-Version: 1.0
Organization: Westermo
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 include/linux/if_bridge.h |  7 +++++++
 net/bridge/br_mst.c       | 26 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 3aae023a9353..1cf0cc46d90d 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -119,6 +119,7 @@ int br_vlan_get_info(const struct net_device *dev, u16 vid,
 		     struct bridge_vlan_info *p_vinfo);
 int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
 			 struct bridge_vlan_info *p_vinfo);
+int br_mst_get_info(const struct net_device *dev, u16 msti, unsigned long *vids);
 #else
 static inline bool br_vlan_enabled(const struct net_device *dev)
 {
@@ -151,6 +152,12 @@ static inline int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
 {
 	return -EINVAL;
 }
+
+static inline int br_mst_get_info(const struct net_device *dev, u16 msti,
+				  unsigned long *vids)
+{
+	return -EINVAL;
+}
 #endif
 
 #if IS_ENABLED(CONFIG_BRIDGE)
diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 00935a19afcc..00b36e629224 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -13,6 +13,32 @@
 
 DEFINE_STATIC_KEY_FALSE(br_mst_used);
 
+int br_mst_get_info(const struct net_device *dev, u16 msti, unsigned long *vids)
+{
+	const struct net_bridge_vlan_group *vg;
+	const struct net_bridge_vlan *v;
+	const struct net_bridge *br;
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
+			__set_bit(v->vid, vids);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(br_mst_get_info);
+
 static void br_mst_vlan_set_state(struct net_bridge_port *p, struct net_bridge_vlan *v,
 				  u8 state)
 {
-- 
2.25.1

