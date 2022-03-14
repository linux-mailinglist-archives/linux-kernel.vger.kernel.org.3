Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56164D7F2A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbiCNJyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238160AbiCNJyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:54:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9589131510
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 02:53:05 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id w12so26014256lfr.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 02:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:organization:content-transfer-encoding;
        bh=EeUCfL1HTNVPenenIH8gFWE4yOM9UF0+zCq9TTJ9Rdk=;
        b=t49cngTtGoE+LnVS21dPKUidRKWEt6BaZrK9GTPcPLHL7ZPbqyfNLTxJylt9s4ttWf
         anQIXe8JIpcQVLB2gB+qqadP4MOfh78MeIOtm3gAmZy3TUm+BMSJFIwn9hdw207ZiN/D
         3pCMdpEh+9m0ol3eNjqY9Sg9zs2oWFJuceKXTFBsLCOttH8vSlpsALstwg9R5bdBXV4X
         ziUwkoYEyUNIRo8mzmV27sQHTOWiN6VpoG+2/0f2EggzKyR3NBThipG7JEftaoTwLAmJ
         e7VNldyzsZepW+mOfQ5miKORBNFelLjcWEQFxUAw69WMl0vrsjf38Uus8EMSG+Wz29aJ
         vpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=EeUCfL1HTNVPenenIH8gFWE4yOM9UF0+zCq9TTJ9Rdk=;
        b=mgLnEPvnyJGUUHQ5RiusQUmVmtMnUDZtGpiFNqNjGsEilACdefsTqz6zexopbJc5rR
         +Femxof1VlgruUWSgbX8l2af7pSpRQe9iO/M197JRJROtmaqXPWjIUnwfBs9QqjUtbny
         BxWngmWYvqQmOKWKVQtCQ6aQKg6hF82czB8G/g+aaRlcryUqlsuvA2wR3bCMpj3tmYx4
         5Rt9xWW3jI45V7KfqPlDyq8SCp2O21qR61nmJjf/+a0SyLF6vr0WciXyj5Pd2AM5CCgr
         VQ6/SQpI9khEIsM3yKBo2EKKpY46jiHZrgjA7FUqMOtPQo5jWDqj+fRAO96wzxAtN4ta
         zzUg==
X-Gm-Message-State: AOAM530RYX4JF8xy+JO46JECdZpxlLYz6ToEexmvfQCgsMw7r+/OPDaf
        X0+ISIJ3IfJkoJ9Yq0a1xGFcVQ==
X-Google-Smtp-Source: ABdhPJw1ln9CM0a9E9yikaIvUI1LgBpKv3kPhVhHwoM7W25cFfsIB12m8B8/EGKfHErLxg1d+EPZaw==
X-Received: by 2002:ac2:4c4c:0:b0:448:a156:504b with SMTP id o12-20020ac24c4c000000b00448a156504bmr338899lfk.99.1647251583471;
        Mon, 14 Mar 2022 02:53:03 -0700 (PDT)
Received: from veiron.westermo.com (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id b3-20020a056512304300b004488e49f2fasm984870lfb.129.2022.03.14.02.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 02:53:03 -0700 (PDT)
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
Subject: [PATCH v3 net-next 06/14] net: bridge: mst: Notify switchdev drivers of MST state changes
Date:   Mon, 14 Mar 2022 10:52:23 +0100
Message-Id: <20220314095231.3486931-7-tobias@waldekranz.com>
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

Generate a switchdev notification whenever an MST state changes. This
notification is keyed by the VLANs MSTI rather than the VID, since
multiple VLANs may share the same MST instance.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/switchdev.h |  7 +++++++
 net/bridge/br_mst.c     | 20 ++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 53dfa0f7cf5b..aa0171d5786d 100644
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
@@ -32,6 +33,11 @@ enum switchdev_attr_id {
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
@@ -50,6 +56,7 @@ struct switchdev_attr {
 	void (*complete)(struct net_device *dev, int err, void *priv);
 	union {
 		u8 stp_state;				/* PORT_STP_STATE */
+		struct switchdev_mst_state mst_state;	/* PORT_MST_STATE */
 		struct switchdev_brport_flags brport_flags; /* PORT_BRIDGE_FLAGS */
 		bool mrouter;				/* PORT_MROUTER */
 		clock_t ageing_time;			/* BRIDGE_AGEING_TIME */
diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 2f761d27d69e..7d16926a3a31 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -29,8 +29,17 @@ static void br_mst_vlan_set_state(struct net_bridge_port *p, struct net_bridge_v
 
 void br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state)
 {
+	struct switchdev_attr attr = {
+		.id = SWITCHDEV_ATTR_ID_PORT_MST_STATE,
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
@@ -42,6 +51,17 @@ void br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state)
 
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

