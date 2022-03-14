Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03EB4D7F28
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238189AbiCNJy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238143AbiCNJyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:54:13 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6310F186FB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 02:53:02 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bt26so26071173lfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 02:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:organization:content-transfer-encoding;
        bh=GeXldrFeKrg0lPEJeX36xArmy/BPfNOm6qSBt2als+U=;
        b=DKul0GoktIJYgeWN/vKEMB2Tl2BU9os12gPMPighZ8mD8fFcNR87HfHHI2F/IR8ZPX
         JQRVP79pgzygTgg4KdeLJLId8VPrflVhPOsZuQcqf32sAqEkO0Ob/sfXaCjwW+qaoEs/
         jbMeNYVIJGZ3MWczoYQWqtWWtMWFR3jy48Aemgu2taAjJuW2OqgkX0B5E2nB+3+p8EvV
         /86ziW09PX4BFvj4EE8Btuy1yaIwsV4HHAXZdAbGGO3qfTNYf7DRHhvCJYgDrZRhzI1x
         gRsGiOd+YV3D9eYM0mwmHyaJMfd0oqvlHJZrlFkX0Fv73XI64p73QySRQvfInaO0b9Co
         is4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=GeXldrFeKrg0lPEJeX36xArmy/BPfNOm6qSBt2als+U=;
        b=yK+D/So+INsc2ay6aYET8Dmd1mV1bhBflOrWhR2jCysQFhIfNcgW+90g7Sboh1nr1D
         pcDhKDHrfcP3QLW0AzqUmXLrPJLmfF9LSWXBYW3y1GeNp21oMPdZX9DgvpUSYIR2Z6DE
         3HmQeoIl9gqUg9gQmaQVszku8ET+qvBY2PKv5kXNFwqZ0Nwim6vaeNsFJ7fvwl7FyCrB
         ulohnonczuPfh2rDhZzP/ef92mFRIH0cgbO7/ejr+gZMw8UR2K+weYXLhxCKOf60VoLF
         Y4SIo04cCyQhiIsHlucmcPiOFBZI8+BDb4aoTGhKVn+m6dBYhGxIONUYez046nwmt3aY
         QtMg==
X-Gm-Message-State: AOAM533bI/8S4XWLPAhh81VqiQzGizjEagsrY54lp5d1kQdGOEO/WJhn
        dMcYF6UK5Yf2KUZts4D1nrwn+A==
X-Google-Smtp-Source: ABdhPJzgMmRpX9yWlD5LazxVThYtYIG18o4vNMr2kLKI16CAak4ZvoZ+VKnDtA7CIE+h24TBxsSm2A==
X-Received: by 2002:a05:6512:1084:b0:448:42b8:f45c with SMTP id j4-20020a056512108400b0044842b8f45cmr13157008lfg.13.1647251580665;
        Mon, 14 Mar 2022 02:53:00 -0700 (PDT)
Received: from veiron.westermo.com (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id b3-20020a056512304300b004488e49f2fasm984870lfb.129.2022.03.14.02.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 02:53:00 -0700 (PDT)
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
Subject: [PATCH v3 net-next 04/14] net: bridge: mst: Notify switchdev drivers of MST mode changes
Date:   Mon, 14 Mar 2022 10:52:21 +0100
Message-Id: <20220314095231.3486931-5-tobias@waldekranz.com>
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

Trigger a switchdev event whenever the bridge's MST mode is
enabled/disabled. This allows constituent ports to either perform any
required hardware config, or refuse the change if it not supported.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/switchdev.h |  2 ++
 net/bridge/br_mst.c     | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 3e424d40fae3..85dd004dc9ad 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -27,6 +27,7 @@ enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL,
 	SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED,
 	SWITCHDEV_ATTR_ID_BRIDGE_MROUTER,
+	SWITCHDEV_ATTR_ID_BRIDGE_MST,
 	SWITCHDEV_ATTR_ID_MRP_PORT_ROLE,
 };
 
@@ -48,6 +49,7 @@ struct switchdev_attr {
 		clock_t ageing_time;			/* BRIDGE_AGEING_TIME */
 		bool vlan_filtering;			/* BRIDGE_VLAN_FILTERING */
 		u16 vlan_protocol;			/* BRIDGE_VLAN_PROTOCOL */
+		bool mst;				/* BRIDGE_MST */
 		bool mc_disabled;			/* MC_DISABLED */
 		u8 mrp_port_role;			/* MRP_PORT_ROLE */
 	} u;
diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index df65aa7701c1..39057585c302 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -99,8 +99,14 @@ void br_mst_vlan_init_state(struct net_bridge_vlan *v)
 int br_mst_set_enabled(struct net_bridge *br, bool on,
 		       struct netlink_ext_ack *extack)
 {
+	struct switchdev_attr attr = {
+		.id = SWITCHDEV_ATTR_ID_BRIDGE_MST,
+		.orig_dev = br->dev,
+		.u.mst = on,
+	};
 	struct net_bridge_vlan_group *vg;
 	struct net_bridge_port *p;
+	int err;
 
 	list_for_each_entry(p, &br->port_list, list) {
 		vg = nbp_vlan_group(p);
@@ -116,6 +122,10 @@ int br_mst_set_enabled(struct net_bridge *br, bool on,
 	if (br_opt_get(br, BROPT_MST_ENABLED) == on)
 		return 0;
 
+	err = switchdev_port_attr_set(br->dev, &attr, extack);
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
 	if (on)
 		static_branch_enable(&br_mst_used);
 	else
-- 
2.25.1

