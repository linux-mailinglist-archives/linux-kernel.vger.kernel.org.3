Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D015533CFA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241195AbiEYMug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243835AbiEYMuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:50:13 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4558D683
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:50:11 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AD88E3F85D
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653483009;
        bh=JjPYFp0Y5P0kqOt5/YfvygZR29ohaRBF0SSsFFczurE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=QFiEdqXqzKNHcxpaDZ100zfK5wB+NejO9wifPOCl0tTbIP4A9rxH5+aU2WHCuu+Qz
         iXv6IUNodPWPBMaBnuQg1kRBYooz0DSlJDt7qbEN0nHG7A4+Lli8sXo9MYaONToO+x
         f8k3Ih5zAfuBbA1jKm3LtoAZakgyj6xdf0jYfLl4FGBSelzku1iuu1eMFQxAlW8ljm
         7yJ3JtwJWHcuXNCwFCFnoptXsZPwbHDObDIa3322BfWyIDFoZmVDS54ZKYBLjNctIz
         9iorLH04+5hMKWtYEpOoVNJ+W/0d+I+kYIIrlpdGhpDfQpgneQR2zla9C39gaoFjkH
         3hJB/OcR2FMjA==
Received: by mail-ej1-f71.google.com with SMTP id i7-20020a170906850700b006fec53a78c3so4721742ejx.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JjPYFp0Y5P0kqOt5/YfvygZR29ohaRBF0SSsFFczurE=;
        b=mCI3TNAicqFuyp9vu8Y17iyrGp8B+o+0aQ/5EGR7xdOArU76Qzu1ltQhGTiwApDVwE
         GzHn4VYIsfqE3+RS63vNgq2PTMf09tzknX22nLKfejoSp8cB/IctXkAXRX4DAg05qe/l
         /lzkAMlwerlUkMqUVkyK+fkl/EWCLauP9v2OdnYn43IFTFLHILDvi0f7lyQv49lXjbSF
         GSr1koZ0nNHQNfOJBx1uMOixS5CPVfUk0THkCRO1/z+LiuwBJ3CDbp2fsecnhhgnpw7i
         2mHGw8BA5BkeZDtaC8BPlaiMcjmEZL9pNStx7ldt8HHWEpO3rJ/zADcmpCYA7DytGNuX
         EAAg==
X-Gm-Message-State: AOAM531apRj4jO6nN/tqWmMdSsUUdRvDOXijqsR1O7Osu6dGQzDJkAhb
        TJgQP78UBSiTX0yFMNC0ErNgy9A/1UfWRpQrK1bNFImCJ5+yWRyfEGJze/dpdKBI8wt0bLU2JyN
        Rx7wLV90jNdii5LLoY7n5HX2HD2r/HaVn08PUg5WjKA==
X-Received: by 2002:a05:6402:b8e:b0:42a:c086:11cd with SMTP id cf14-20020a0564020b8e00b0042ac08611cdmr34201410edb.166.1653483009481;
        Wed, 25 May 2022 05:50:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwH8To2QSJUSYjOgQq8nLZowBtXUg655vtEM067/1KFh0SCoJIXC/b6DslpmqdLzU/Db0v7A==
X-Received: by 2002:a05:6402:b8e:b0:42a:c086:11cd with SMTP id cf14-20020a0564020b8e00b0042ac08611cdmr34201383edb.166.1653483009232;
        Wed, 25 May 2022 05:50:09 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id l8-20020a1709060e0800b006f3ef214e62sm2860566eji.200.2022.05.25.05.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 05:50:08 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net, linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 2/2] um/drivers: Kconfig: Fix indentation
Date:   Wed, 25 May 2022 14:50:01 +0200
Message-Id: <20220525125001.47009-3-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220525125001.47009-1-juerg.haefliger@canonical.com>
References: <20220525125001.47009-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 arch/um/drivers/Kconfig | 54 ++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index f145842c40b9..27e09e421d50 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -236,37 +236,37 @@ config UML_NET_VECTOR
 	depends on UML_NET
 	select MAY_HAVE_RUNTIME_DEPS
 	help
-	This User-Mode Linux network driver uses multi-message send
-	and receive functions. The host running the UML guest must have
-	a linux kernel version above 3.0 and a libc version > 2.13.
-	This driver provides tap, raw, gre and l2tpv3 network transports
-	with up to 4 times higher network throughput than the UML network
-	drivers.
+	  This User-Mode Linux network driver uses multi-message send
+	  and receive functions. The host running the UML guest must have
+	  a linux kernel version above 3.0 and a libc version > 2.13.
+	  This driver provides tap, raw, gre and l2tpv3 network transports
+	  with up to 4 times higher network throughput than the UML network
+	  drivers.
 
 config UML_NET_VDE
 	bool "VDE transport (obsolete)"
 	depends on UML_NET
 	select MAY_HAVE_RUNTIME_DEPS
 	help
-	This User-Mode Linux network transport allows one or more running
-	UMLs on a single host to communicate with each other and also
-	with the rest of the world using Virtual Distributed Ethernet,
-	an improved fork of uml_switch.
+	  This User-Mode Linux network transport allows one or more running
+	  UMLs on a single host to communicate with each other and also
+	  with the rest of the world using Virtual Distributed Ethernet,
+	  an improved fork of uml_switch.
 
-	You must have libvdeplug installed in order to build the vde
-	transport into UML.
+	  You must have libvdeplug installed in order to build the vde
+	  transport into UML.
 
-	To use this form of networking, you will need to run vde_switch
-	on the host.
+	  To use this form of networking, you will need to run vde_switch
+	  on the host.
 
-	For more information, see <http://wiki.virtualsquare.org/>
-	That site has a good overview of what VDE is and also examples
-	of the UML command line to use to enable VDE networking.
+	  For more information, see <http://wiki.virtualsquare.org/>
+	  That site has a good overview of what VDE is and also examples
+	  of the UML command line to use to enable VDE networking.
 
-	NOTE: THIS TRANSPORT IS DEPRECATED AND WILL BE REMOVED SOON!!! Please
-	migrate to UML_NET_VECTOR.
+	  NOTE: THIS TRANSPORT IS DEPRECATED AND WILL BE REMOVED SOON!!! Please
+	  migrate to UML_NET_VECTOR.
 
-	If unsure, say N.
+	  If unsure, say N.
 
 config UML_NET_MCAST
 	bool "Multicast transport (obsolete)"
@@ -296,19 +296,19 @@ config UML_NET_PCAP
 	depends on UML_NET
 	select MAY_HAVE_RUNTIME_DEPS
 	help
-	The pcap transport makes a pcap packet stream on the host look
-	like an ethernet device inside UML.  This is useful for making
-	UML act as a network monitor for the host.  You must have libcap
-	installed in order to build the pcap transport into UML.
+	  The pcap transport makes a pcap packet stream on the host look
+	  like an ethernet device inside UML.  This is useful for making
+	  UML act as a network monitor for the host.  You must have libcap
+	  installed in order to build the pcap transport into UML.
 
 	  For more information, see
 	  <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
 	  has examples of the UML command line to use to enable this option.
 
-	NOTE: THIS TRANSPORT IS DEPRECATED AND WILL BE REMOVED SOON!!! Please
-	migrate to UML_NET_VECTOR.
+	  NOTE: THIS TRANSPORT IS DEPRECATED AND WILL BE REMOVED SOON!!! Please
+	  migrate to UML_NET_VECTOR.
 
-	If unsure, say N.
+	  If unsure, say N.
 
 config UML_NET_SLIRP
 	bool "SLiRP transport (obsolete)"
-- 
2.32.0

