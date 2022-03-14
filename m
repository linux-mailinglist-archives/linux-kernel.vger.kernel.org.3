Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42BF4D7F2D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbiCNJy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbiCNJyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:54:19 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EAE34B9E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 02:53:08 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id r22so20985701ljd.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 02:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:organization:content-transfer-encoding;
        bh=7lHeWPXEXWrCYgRFwcHwT0FA/DPhlUmoROl0FMGvSmk=;
        b=odLD55IR7r4dldGhulofhapMI5jrMDOi5q3CTbdcs8RDrs6wRN+BGPhnHaUKb6e22F
         5T/KPRXcIqll0h+XN7kOP7NTJ+FcAu2741kVFIUHFc/MI/XMqGo2HWPLlIzALElpDQ1F
         Mm02O7POmyISL2X167BSom71A92PoigsuxFKBoZbi/rGd6xnJHDeiZvSsFKufA2Is8Jd
         edmH4YijZ+M6MsQPcX/RJeW0yjJB1KUThuEF34pbsNfLHBPuo6NB+yBLgL9zri/CR5jz
         zwtw9yb0Sd56tBr9EtRjMM99jeKPUvlHsEpM0/k4NlpP8yJFCLmfsSPyOhRSBV0YIN/S
         Ieww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=7lHeWPXEXWrCYgRFwcHwT0FA/DPhlUmoROl0FMGvSmk=;
        b=6+EQVhISmzHD/p5MEm42+izNHyJxrpIf3sHSoOhmgkbn3qSxb/DQ2Gfd4nGtGOu0xY
         5ojlkT8CoFEiY/lP6NSq1/QY8lygc7y6VGRcyiYy0Hl9mlMs4cz0urYu6GHGMmJ8br4o
         ONWIx9Ym8d259cXhbkLsqBsdEvYvXG+Nu1qv+IhQu8kS1Y0Ff7Ee8jzseUzusF9GGg77
         pB6FTC4JLvbzAPVSu/kaUEDzJe2oQOulQIlm36a0wx2lGhA/8Lg2oqIaU/A3w12Ogkxa
         Cy+Q1MPL5BmMiqP6D7251/+X5WmbAk1TvROgO8qotioN7V1g2Ek0i9ce5V7WgaaBDvAT
         kQ4w==
X-Gm-Message-State: AOAM531HQyfe2PKJGOxY1WFFkdJkDB3H6Z0aCNTrzPqDTFGGGLdAHmH2
        tMWoz08LfBX5pQWpsskcbVJzvg==
X-Google-Smtp-Source: ABdhPJz1zlZc0EJq0fH1zUvvHQpnL1KiaYGOHaxUVmjz61r/PA6V4A+s1LKf2GzSFRNmZ3zS4kqUpA==
X-Received: by 2002:a05:651c:2dc:b0:247:e451:48ae with SMTP id f28-20020a05651c02dc00b00247e45148aemr13813200ljo.248.1647251586691;
        Mon, 14 Mar 2022 02:53:06 -0700 (PDT)
Received: from veiron.westermo.com (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id b3-20020a056512304300b004488e49f2fasm984870lfb.129.2022.03.14.02.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 02:53:06 -0700 (PDT)
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
Subject: [PATCH v3 net-next 08/14] net: bridge: mst: Add helper to check if MST is enabled
Date:   Mon, 14 Mar 2022 10:52:25 +0100
Message-Id: <20220314095231.3486931-9-tobias@waldekranz.com>
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

This is useful for switchdev drivers that might want to refuse to join
a bridge where MST is enabled, if the hardware can't support it.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/linux/if_bridge.h | 5 +++++
 net/bridge/br_mst.c       | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 46e6327fef06..5dbab0a280a6 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -119,6 +119,7 @@ int br_vlan_get_info(const struct net_device *dev, u16 vid,
 		     struct bridge_vlan_info *p_vinfo);
 int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
 			 struct bridge_vlan_info *p_vinfo);
+bool br_mst_enabled(struct net_device *dev);
 int br_mst_get_info(struct net_device *dev, u16 msti, unsigned long *vids);
 #else
 static inline bool br_vlan_enabled(const struct net_device *dev)
@@ -152,6 +153,10 @@ static inline int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
 {
 	return -EINVAL;
 }
+static inline bool br_mst_enabled(struct net_device *dev)
+{
+	return false;
+}
 static inline int br_mst_get_info(struct net_device *dev, u16 msti,
 				  unsigned long *vids)
 {
diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index eb18dbd5838f..e5ab2ce451c2 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -13,6 +13,15 @@
 
 DEFINE_STATIC_KEY_FALSE(br_mst_used);
 
+bool br_mst_enabled(struct net_device *dev)
+{
+	if (!netif_is_bridge_master(dev))
+		return false;
+
+	return br_opt_get(netdev_priv(dev), BROPT_MST_ENABLED);
+}
+EXPORT_SYMBOL(br_mst_enabled);
+
 int br_mst_get_info(struct net_device *dev, u16 msti, unsigned long *vids)
 {
 	struct net_bridge_vlan_group *vg;
-- 
2.25.1

