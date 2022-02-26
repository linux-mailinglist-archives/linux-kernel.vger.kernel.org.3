Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F294C5608
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 14:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiBZNGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 08:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiBZNG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 08:06:28 -0500
X-Greylist: delayed 387 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 26 Feb 2022 05:05:54 PST
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CFF28C9F2;
        Sat, 26 Feb 2022 05:05:54 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id F33B03200B23;
        Sat, 26 Feb 2022 07:59:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 26 Feb 2022 07:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=24fXDkeGUQyzyrMr8LDRzf6/k+e8KqfMNtNUHH
        53hTk=; b=UskEd8CKuqShsWO2xuk3i+VOFsjg7pIm1JRD8U3uPlg393NqrNUF3I
        GfhK5TxYJnKkZifBNbDvxwRn6VJRQVGNFABJfzASJOoJgNkrjyz38Rgn+RO0KlW3
        Q1dh/bot3oBCc6uQY9fNeoYRMnnGya2QuV66R6SXonCrv27FcNjaWFWuqLsQ1jua
        4bvvKotYSJ9HjnFqcjLvucHCbM5vbxHVjJlRHVrMJ9z6xdZh/IuQgputmPPS8+2o
        DYlyBiXHRMs5sicOzPlwvm6815aF3tR5ntA1VEQDVEEW2l29VcJEdV6OH3Vw1wef
        0/J07rSHBPUdOXTtLiT2nvEFKhuPABTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=24fXDkeGUQyzyrMr8LDRzf6/k+e8K
        qfMNtNUHH53hTk=; b=W9FpTaMphsavn3/8ndGiuutvKDc54GGOLzjxHGEhcVmc3
        8fUu9iPa2ZVrSA2CzeyXEU0bj78A4cQf2H8bWs3e6dPybEU6Un7CMXXsMwqcQZ/b
        ZjmEM6CnVTOwPHKxqeeDPbpyFK4NDT+kGnKPoicmxDgvkQcRzfNpv0AsujVZovud
        msiyC/1ZVMCaSqVyLwEpps4q0YdBSr3AnyK+Fllx88AZBNkJ4ETyQo1ZkFEAie2e
        +6ZuxDfh8MwYmH79mNeqx/Ftn1mOof4OXoWduMv8wkOtEjzvGxBwnt7Ix98SrR4y
        UH0rfPL0wMZFtKvLf1yzghQLvpj9dZn2iInFvRMCw==
X-ME-Sender: <xms:KyQaYkI1P--HgEw406hQ3zgQE6wjGkufVMk-35C_G1TxO3yIzRSkLw>
    <xme:KyQaYkIVkUTDxwS1bE50XHw4n3eZ8_qjX5xq97bOH3r4hqN8UQHzHppsvf8jtClBW
    ufyVDi0StzRqR-fkfY>
X-ME-Received: <xmr:KyQaYkuxF1ftGNn8VQbGO0kVWstdsfVJVEN_1ig62BW-jLEs_qwJuo6fUb-GzKVewG7UzHQwNGTkaepFPFV5VI8-svU1E_HfeTd_id2qky5eQGuoNg3ZwB1enh_ZZMU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrleeigdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhvvghnucfrvght
    vghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    eugfelkedvtdejffefjeehveelfeevkefgudduhfeghfefgedtheevjeefffffgfenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhessh
    hvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:KyQaYhZLZx5AwBB2Yl64I65F4Vgb5Ca8dkaLIPyexB9BQ3ojjnsLbw>
    <xmx:KyQaYraA_EfLzhIh4I9lEe7OjLOyYVvALk1_H3vzy-yq-m_kVR5ezg>
    <xmx:KyQaYtDt1H6iZNI1TrxLIfoAvY8FvVhKgN1NRU7hsyHTea5GuILJZQ>
    <xmx:LCQaYgNvzMqkVN7aoy5Q5ActaAdRL48avKL_ho2dY9EW1ILCGfPp3g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Feb 2022 07:59:21 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: tipd: Forward plug orientation to typec subsystem
Date:   Sat, 26 Feb 2022 13:59:12 +0100
Message-Id: <20220226125912.59828-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to bring up the USB3 PHY on the Apple M1 we need to know the
orientation of the Type-C cable. Extract it from the status register and
forward it to the typec subsystem.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/usb/typec/tipd/core.c     | 5 +++++
 drivers/usb/typec/tipd/tps6598x.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 7ffcda94d323..16b4560216ba 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -256,6 +256,10 @@ static int tps6598x_connect(struct tps6598x *tps, u32 status)
 	typec_set_pwr_opmode(tps->port, mode);
 	typec_set_pwr_role(tps->port, TPS_STATUS_TO_TYPEC_PORTROLE(status));
 	typec_set_vconn_role(tps->port, TPS_STATUS_TO_TYPEC_VCONN(status));
+	if (TPS_STATUS_TO_UPSIDE_DOWN(status))
+		typec_set_orientation(tps->port, TYPEC_ORIENTATION_REVERSE);
+	else
+		typec_set_orientation(tps->port, TYPEC_ORIENTATION_NORMAL);
 	tps6598x_set_data_role(tps, TPS_STATUS_TO_TYPEC_DATAROLE(status), true);
 
 	tps->partner = typec_register_partner(tps->port, &desc);
@@ -278,6 +282,7 @@ static void tps6598x_disconnect(struct tps6598x *tps, u32 status)
 	typec_set_pwr_opmode(tps->port, TYPEC_PWR_MODE_USB);
 	typec_set_pwr_role(tps->port, TPS_STATUS_TO_TYPEC_PORTROLE(status));
 	typec_set_vconn_role(tps->port, TPS_STATUS_TO_TYPEC_VCONN(status));
+	typec_set_orientation(tps->port, TYPEC_ORIENTATION_NONE);
 	tps6598x_set_data_role(tps, TPS_STATUS_TO_TYPEC_DATAROLE(status), false);
 
 	power_supply_changed(tps->psy);
diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
index 3dae84c524fb..527857549d69 100644
--- a/drivers/usb/typec/tipd/tps6598x.h
+++ b/drivers/usb/typec/tipd/tps6598x.h
@@ -17,6 +17,7 @@
 /* TPS_REG_STATUS bits */
 #define TPS_STATUS_PLUG_PRESENT		BIT(0)
 #define TPS_STATUS_PLUG_UPSIDE_DOWN	BIT(4)
+#define TPS_STATUS_TO_UPSIDE_DOWN(s)	(!!((s) & TPS_STATUS_PLUG_UPSIDE_DOWN))
 #define TPS_STATUS_PORTROLE		BIT(5)
 #define TPS_STATUS_TO_TYPEC_PORTROLE(s) (!!((s) & TPS_STATUS_PORTROLE))
 #define TPS_STATUS_DATAROLE		BIT(6)
-- 
2.25.1

