Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDD14DB459
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357148AbiCPPLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357064AbiCPPLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:11:03 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36637674E4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:09:19 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 25so3519611ljv.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:organization:content-transfer-encoding;
        bh=m0qRE7FDr0p4FAMweOHjVamBsXXgGeOUyAUIOvMs4w0=;
        b=Atuwy9tcTltq5UBbvNxe4gcblnFPP4JfbsRXDsBhj1+f8XDANgpL9FV4orbEoYdJ+H
         4iAX8UqK6fSxLYddviQVDOk/dS8R97RjH+QM89ja4sqYNDqaJt2rGtaEG0Mo2jB9hF6H
         fLuV5pgoO6Q3kjw4Z3FAblIrVp6qCr2w5afEtJ0LPRSgH8oVT8Wr5AJqmvAZ+NrjWq6q
         5XS3ed/j8CR5I5CBHEhaiD7sGnXgsfwCi4QEwKnxMypTj2wcdVHJ+030ixMIbMPY5CRR
         OzWRivKCzgiijYbpery7UP+3jDkhza+eAL/WFcY1cmIobIG+lr3NaN2kFYiv5Oknq5uu
         Umxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=m0qRE7FDr0p4FAMweOHjVamBsXXgGeOUyAUIOvMs4w0=;
        b=lmzNBLk3FhPNXxuNGRUli29LZmMClC/fetsXudoIkhG1zNmrGP1pBHwCHDD8HzsPsT
         lSkcAfcOqi8ICcoRDeCInVfaVRXHjC3LzBQetTsnOZpFmVwScnDjZiJIP25075u+PIqm
         +fehln63FeWsgeg5KhQcqJ67wAFtjmk++mSIzUejZZY3Rt2ugRgPR8MWvwOi2xQuh5Q+
         pgXW03G170dxuJKZQxNJF8eN0Vz7peUzQfY8LShENarNFnTrYvYaDC+BK4rcH45TuhZd
         9lwcXFOcYMCnXhz0Ihn4ey0yLxeP9Ee1pinFC5hbpSrSbTEIH834n6vKLTiz6iTLVCXF
         xVig==
X-Gm-Message-State: AOAM531gbiKikcwZ4eXu1DjMH8qsiT1ETdP4g3u+QLwlhzjQBjrRSHkq
        yDQVo1i9+BLw+bvcwn0zLD5EBA==
X-Google-Smtp-Source: ABdhPJxOXJTrHiGvBpHpG8RK4izzCuXLKUo//gU8yjE0knEcYMOx7erNqgZ5OwTgV6nJioywQahG1w==
X-Received: by 2002:a2e:b989:0:b0:248:5a5:cb64 with SMTP id p9-20020a2eb989000000b0024805a5cb64mr52784ljp.183.1647443357455;
        Wed, 16 Mar 2022 08:09:17 -0700 (PDT)
Received: from veiron.westermo.com (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id d2-20020a194f02000000b00448b915e2d3sm176048lfb.99.2022.03.16.08.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 08:09:17 -0700 (PDT)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
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
Subject: [PATCH v5 net-next 11/15] net: dsa: Pass VLAN MSTI migration notifications to driver
Date:   Wed, 16 Mar 2022 16:08:53 +0100
Message-Id: <20220316150857.2442916-12-tobias@waldekranz.com>
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
to the drivers for VLAN MSTI migrations.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
 include/net/dsa.h  |  3 +++
 net/dsa/dsa_priv.h |  2 ++
 net/dsa/port.c     | 16 +++++++++++++++-
 net/dsa/slave.c    |  6 ++++++
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 9bfe984fcdbf..644fda2293a2 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -976,6 +976,9 @@ struct dsa_switch_ops {
 				 struct netlink_ext_ack *extack);
 	int	(*port_vlan_del)(struct dsa_switch *ds, int port,
 				 const struct switchdev_obj_port_vlan *vlan);
+	int	(*vlan_msti_set)(struct dsa_switch *ds, struct dsa_bridge bridge,
+				 const struct switchdev_vlan_msti *msti);
+
 	/*
 	 * Forwarding database
 	 */
diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index 2aba420696ef..d90b4cf0c9d2 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -236,6 +236,8 @@ bool dsa_port_skip_vlan_configuration(struct dsa_port *dp);
 int dsa_port_ageing_time(struct dsa_port *dp, clock_t ageing_clock);
 int dsa_port_mst_enable(struct dsa_port *dp, bool on,
 			struct netlink_ext_ack *extack);
+int dsa_port_vlan_msti(struct dsa_port *dp,
+		       const struct switchdev_vlan_msti *msti);
 int dsa_port_mtu_change(struct dsa_port *dp, int new_mtu,
 			bool targeted_match);
 int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 02214033cec0..3ac114f6fc22 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -323,7 +323,10 @@ static void dsa_port_bridge_destroy(struct dsa_port *dp,
 
 static bool dsa_port_supports_mst(struct dsa_port *dp)
 {
-	return dsa_port_can_configure_learning(dp);
+	struct dsa_switch *ds = dp->ds;
+
+	return ds->ops->vlan_msti_set &&
+		dsa_port_can_configure_learning(dp);
 }
 
 int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
@@ -800,6 +803,17 @@ int dsa_port_bridge_flags(struct dsa_port *dp,
 	return 0;
 }
 
+int dsa_port_vlan_msti(struct dsa_port *dp,
+		       const struct switchdev_vlan_msti *msti)
+{
+	struct dsa_switch *ds = dp->ds;
+
+	if (!ds->ops->vlan_msti_set)
+		return -EOPNOTSUPP;
+
+	return ds->ops->vlan_msti_set(ds, *dp->bridge, msti);
+}
+
 int dsa_port_mtu_change(struct dsa_port *dp, int new_mtu,
 			bool targeted_match)
 {
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 2e8f62476ce9..1b3e792d0327 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -483,6 +483,12 @@ static int dsa_slave_port_attr_set(struct net_device *dev, const void *ctx,
 
 		ret = dsa_port_bridge_flags(dp, attr->u.brport_flags, extack);
 		break;
+	case SWITCHDEV_ATTR_ID_VLAN_MSTI:
+		if (!dsa_port_offloads_bridge_dev(dp, attr->orig_dev))
+			return -EOPNOTSUPP;
+
+		ret = dsa_port_vlan_msti(dp, &attr->u.vlan_msti);
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
-- 
2.25.1

