Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAC14D7F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238264AbiCNJzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238198AbiCNJyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:54:21 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682AC36316
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 02:53:10 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id w7so26061808lfd.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 02:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:organization:content-transfer-encoding;
        bh=aX/tyKTTlC2fOBLF30DbEmug8lr4QMJWtdHHEsfB8ls=;
        b=6h+9N7Unq/C54UTeMTcGlVIoOSDDtrPDrd/GLYB+4EbFvaq3keKFdDepoPvlkE6OZC
         bQUwb8H/65AybyOLa2SXoECYsX/TcJYj8H9dUUTagAHpQDrkeoUkip6c6gvG1iWuc842
         DlLAT4X+6dSQSG5O/dYp41qL/KzfQqougxmfU8SfSuX2FIluLvRdjmRoChbYXVJFLrOb
         5nmYZSve3jhbTTGpznlkwPAdoG0NtaAd9yppN+ncTbeTkB01WfSZ48dPOcwyGjCSnJeZ
         ZipHSxFvcPapWKBhrucgczZMip5jCvKkxWuHCai5SFQiIyP+GpnciyhsUSaYw6qw4VM3
         SWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=aX/tyKTTlC2fOBLF30DbEmug8lr4QMJWtdHHEsfB8ls=;
        b=kMx1A2HfaiGwT6aVSBRH+jd6Gsfpz64Aht/fSsuf2LtK4MVOC4YAprxPJPweFGMSfB
         2dVDQ+eBPqpKtD8bBi170nlF71EQ3drXuAeucv9k/JD/2sbXnDyceYK+dtzICSCHItG1
         RYjciBmNyyHBq9VyC9mWhSiuIiV4tMrej9b+Jy4Eplkyxk2/Jrn5PKPLi3LEDRdy0S/S
         90jRyTFG0ZBip56Xr18oAKKovcn000NvnIJzanap4UTllXyhukHdKdKdNJyyCr1+I/OP
         9UF0xkqU8jUaw4wTi8CDKYWzc3EwpelKfsXTJSokjxL7QWapLU/bAq/kTWuGOKUaQVGn
         lTRg==
X-Gm-Message-State: AOAM533TCs1qei7EwjlrHtVzGP6olt6icdMTZZucl6q9HEdNR/pFPGpy
        r9bvek10voVP6Xc7btlgAGdTFw==
X-Google-Smtp-Source: ABdhPJyPiLr9FUGydQZpohRHqknpYmmbfxvdUg7o3WlDFO2inSS46l+nCZzb3aCjSbHOak56mpZQ2g==
X-Received: by 2002:a05:6512:ba6:b0:448:9f0b:bc25 with SMTP id b38-20020a0565120ba600b004489f0bbc25mr898011lfv.256.1647251588383;
        Mon, 14 Mar 2022 02:53:08 -0700 (PDT)
Received: from veiron.westermo.com (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id b3-20020a056512304300b004488e49f2fasm984870lfb.129.2022.03.14.02.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 02:53:07 -0700 (PDT)
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
Subject: [PATCH v3 net-next 09/14] net: dsa: Validate hardware support for MST
Date:   Mon, 14 Mar 2022 10:52:26 +0100
Message-Id: <20220314095231.3486931-10-tobias@waldekranz.com>
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

When joining a bridge where MST is enabled, we validate that the
proper offloading support is in place, otherwise we fallback to
software bridging.

When then mode is changed on a bridge in which we are members, we
refuse the change if offloading is not supported.

At the moment we only check for configurable learning, but this will
be further restricted as we support more MST related switchdev events.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 net/dsa/dsa_priv.h |  2 ++
 net/dsa/port.c     | 20 ++++++++++++++++++++
 net/dsa/slave.c    |  6 ++++++
 3 files changed, 28 insertions(+)

diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index f20bdd8ea0a8..2aba420696ef 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -234,6 +234,8 @@ int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
 			    struct netlink_ext_ack *extack);
 bool dsa_port_skip_vlan_configuration(struct dsa_port *dp);
 int dsa_port_ageing_time(struct dsa_port *dp, clock_t ageing_clock);
+int dsa_port_mst_enable(struct dsa_port *dp, bool on,
+			struct netlink_ext_ack *extack);
 int dsa_port_mtu_change(struct dsa_port *dp, int new_mtu,
 			bool targeted_match);
 int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 58291df14cdb..1a17a0efa2fa 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -240,6 +240,10 @@ static int dsa_port_switchdev_sync_attrs(struct dsa_port *dp,
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
+	err = dsa_port_mst_enable(dp, br_mst_enabled(br), extack);
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
 	return 0;
 }
 
@@ -735,6 +739,22 @@ int dsa_port_ageing_time(struct dsa_port *dp, clock_t ageing_clock)
 	return 0;
 }
 
+int dsa_port_mst_enable(struct dsa_port *dp, bool on,
+			struct netlink_ext_ack *extack)
+{
+	struct dsa_switch *ds = dp->ds;
+
+	if (!on)
+		return 0;
+
+	if (!dsa_port_can_configure_learning(dp)) {
+		NL_SET_ERR_MSG_MOD(extack, "Hardware does not support MST");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int dsa_port_pre_bridge_flags(const struct dsa_port *dp,
 			      struct switchdev_brport_flags flags,
 			      struct netlink_ext_ack *extack)
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index a61a7c54af20..333f5702ea4f 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -463,6 +463,12 @@ static int dsa_slave_port_attr_set(struct net_device *dev, const void *ctx,
 
 		ret = dsa_port_ageing_time(dp, attr->u.ageing_time);
 		break;
+	case SWITCHDEV_ATTR_ID_BRIDGE_MST:
+		if (!dsa_port_offloads_bridge_dev(dp, attr->orig_dev))
+			return -EOPNOTSUPP;
+
+		ret = dsa_port_mst_enable(dp, attr->u.mst, extack);
+		break;
 	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
 		if (!dsa_port_offloads_bridge_port(dp, attr->orig_dev))
 			return -EOPNOTSUPP;
-- 
2.25.1

