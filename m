Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C70C4D9179
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 01:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343971AbiCOA2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 20:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343811AbiCOA1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 20:27:38 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED31E3CFF9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:26:27 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id b28so18493532lfc.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:organization:content-transfer-encoding;
        bh=7rBVX2eGe+n3oqizYlvo9XzN7F+D1diuy5KXiSK9HF4=;
        b=eQJFiDSJRJUtYgU15RHHS6PZYhEPdkB9p5XthXvF3r3SgHWaeznpebA4SknEyLD0lQ
         qhNZtxVALSWT1RvY2u53W8xyfPAy9kSuX0BOeMHGJTnq2VBKgnmxFGcecfquwttD3FAV
         JP2sCja+RK9zk8BuQ+PsIrUF/BdOCYL5NcLr+IF75tAJYpWNKMMxmQzXjLidPtBPkqCo
         i7I1/JkiWN3H6x4eTXxQ7tQ3SSl/ObmGOGTAB2whogT0ZL9ybKBd4XzR1MJFpBjJr1CN
         GPIiKrTLe6WOwx2GPLTtuSqaufdr815JE2QqZv2emjRpofXrbKGQDoL7P4AiUre1PC/O
         XmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=7rBVX2eGe+n3oqizYlvo9XzN7F+D1diuy5KXiSK9HF4=;
        b=0YFOv3+bKWAyjfQGfYjsysWAdCPQgqHtMcLfp0fmVlnz3KrtwzAUUlBSYZKt4nuE+9
         BYbc+Wr2iKrrAtfGppdJuxKG0EyhPAnaDEjKmJMkw18Kz877Em16KaoHguSur6XNTV2r
         jtOOxvdSYtiAXq6W+hfwKeN89z95Aa/SAe/X4b4o+VWU3qeltbAS1S++ROojQHg7Jlm3
         UKW/axTcsxw9OxDvBTKzMB5vQr5fcweYfDNyxv9pXhJ1ugUFdew5Mq0UlD9i/P6jIV9F
         aBeP5eElCvmaDJmq80KTXmznFMKRkxPqcmnLYeDvsDFAabeu116rCAoUlIDU0fFBGh/b
         j1JA==
X-Gm-Message-State: AOAM533IWM83AsuUmkN2cq/bIZ8zHctWkQbU0NtlfL3hubDB6JGen4uY
        4QEbGKIazIQTmyx+JGJ0VfWg2g==
X-Google-Smtp-Source: ABdhPJw7lSzRQuzL1Bu/YVmXMdrzMwnMyIpiipVlycWtdhFc1nO3cTODK8t2mr1nRASfoqbopTuM2g==
X-Received: by 2002:a05:6512:2090:b0:448:5050:9131 with SMTP id t16-20020a056512209000b0044850509131mr14526023lfr.326.1647303986310;
        Mon, 14 Mar 2022 17:26:26 -0700 (PDT)
Received: from veiron.westermo.com (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id y14-20020a2e544e000000b0024800f8286bsm4219923ljd.78.2022.03.14.17.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 17:26:25 -0700 (PDT)
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
Subject: [PATCH v4 net-next 06/15] net: bridge: mst: Notify switchdev drivers of MST state changes
Date:   Tue, 15 Mar 2022 01:25:34 +0100
Message-Id: <20220315002543.190587-7-tobias@waldekranz.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220315002543.190587-1-tobias@waldekranz.com>
References: <20220315002543.190587-1-tobias@waldekranz.com>
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
index 5d3e034b9030..b92daca86513 100644
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

