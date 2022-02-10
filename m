Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237C14B18EB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345376AbiBJW63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:58:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345076AbiBJW62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:58:28 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84655D55;
        Thu, 10 Feb 2022 14:58:28 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id y84so9453406iof.0;
        Thu, 10 Feb 2022 14:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XYy86s2wR72p6r/7wpjvLb/OKofqlzUO1lKoSKLkUaY=;
        b=GfoXmsy9OpsI0OUdTBsf8IR4ajwQp9B61y2YZqssjRjF7V9z7xqXziZfHGBkYCwCmL
         1PSWc90PT5G4wzh9ekZWXyslsjc1Y1Q7D8Ee3FLuxB6QT6k+8y1SOSs3OIDzWzKxgqpk
         ktHoLe1XdTac0DYooEO+3f3cr0hGiVyfxFjeTkTNzcVIUjWhfU/tfuf5Rnmh6KU4OC0X
         JcT+eq7/YHjTgDRfj3+c73PFTx+1egKj1wf4d5iWa8rl6pfzvFao/GP7BhzwFpqOFRYb
         5JE2/VJ86qCSIKiaLm8GcX8qbB2Vg7d4YHygBKfsOq633OCB0JpJh5yRRhQvwEJ5+Q45
         DPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XYy86s2wR72p6r/7wpjvLb/OKofqlzUO1lKoSKLkUaY=;
        b=sOYvopSbh4lLJzlifYTnejloyTo9lFe6lzvmeM4pKAvUwTrQBa2CGZXFY3qOjjWBPg
         kvx+CjS9n2SfI+ZASwF72fV9WGXNH922uF512gwze76V2lHnC3Nn8U9lh4gHBdSyp9hN
         N96Vb6sxQ2LrIG7uOwS1Scvw1tKc7uCWWG6WAlW0QLM8OtpUXNRMjdb20O1KFiG11CVC
         jYv/VVUQDqIxSbsNO1PSPMoS6ohKLEv3tFRzy7ijKHxlUE80llQmkD96pZHOClOC7ygC
         5gVt27l2U52Xd+SKZeP61OcbgBUoY90/eaO/1meQqRyNmHMFE9Ip6Y8o2MoQ5PgCV4l9
         JbCA==
X-Gm-Message-State: AOAM530Ye91i7AjMEE8pC16470LNkAUlyx5+eo3g5CAO0lE9zidY89uj
        zkwPEZKcheoMC0w2MvMDNyk=
X-Google-Smtp-Source: ABdhPJzrMeXGVC4jElCJVqUIPD6D/g/ZpwjVl5H+pjBDEX7x9b74y2u2c99GD7i+ELA1S4TT7Vmizw==
X-Received: by 2002:a6b:720f:: with SMTP id n15mr4925855ioc.158.1644533907800;
        Thu, 10 Feb 2022 14:58:27 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id r7sm5726416ilm.14.2022.02.10.14.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:58:27 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        linux-pm@vger.kernel.org
Cc:     Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH 03/49] net: mellanox: fix open-coded for_each_set_bit()
Date:   Thu, 10 Feb 2022 14:48:47 -0800
Message-Id: <20220210224933.379149-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210224933.379149-1-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mellanox driver has an open-coded for_each_set_bit(). Fix it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx4/cmd.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/cmd.c b/drivers/net/ethernet/mellanox/mlx4/cmd.c
index e10b7b04b894..c56d2194cbfc 100644
--- a/drivers/net/ethernet/mellanox/mlx4/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx4/cmd.c
@@ -1994,21 +1994,16 @@ static void mlx4_allocate_port_vpps(struct mlx4_dev *dev, int port)
 
 static int mlx4_master_activate_admin_state(struct mlx4_priv *priv, int slave)
 {
-	int port, err;
+	int p, port, err;
 	struct mlx4_vport_state *vp_admin;
 	struct mlx4_vport_oper_state *vp_oper;
 	struct mlx4_slave_state *slave_state =
 		&priv->mfunc.master.slave_state[slave];
 	struct mlx4_active_ports actv_ports = mlx4_get_active_ports(
 			&priv->dev, slave);
-	int min_port = find_first_bit(actv_ports.ports,
-				      priv->dev.caps.num_ports) + 1;
-	int max_port = min_port - 1 +
-		bitmap_weight(actv_ports.ports, priv->dev.caps.num_ports);
 
-	for (port = min_port; port <= max_port; port++) {
-		if (!test_bit(port - 1, actv_ports.ports))
-			continue;
+	for_each_set_bit(p, actv_ports.ports, priv->dev.caps.num_ports) {
+		port = p + 1;
 		priv->mfunc.master.vf_oper[slave].smi_enabled[port] =
 			priv->mfunc.master.vf_admin[slave].enable_smi[port];
 		vp_oper = &priv->mfunc.master.vf_oper[slave].vport[port];
@@ -2063,19 +2058,13 @@ static int mlx4_master_activate_admin_state(struct mlx4_priv *priv, int slave)
 
 static void mlx4_master_deactivate_admin_state(struct mlx4_priv *priv, int slave)
 {
-	int port;
+	int p, port;
 	struct mlx4_vport_oper_state *vp_oper;
 	struct mlx4_active_ports actv_ports = mlx4_get_active_ports(
 			&priv->dev, slave);
-	int min_port = find_first_bit(actv_ports.ports,
-				      priv->dev.caps.num_ports) + 1;
-	int max_port = min_port - 1 +
-		bitmap_weight(actv_ports.ports, priv->dev.caps.num_ports);
 
-
-	for (port = min_port; port <= max_port; port++) {
-		if (!test_bit(port - 1, actv_ports.ports))
-			continue;
+	for_each_set_bit(p, actv_ports.ports, priv->dev.caps.num_ports) {
+		port = p + 1;
 		priv->mfunc.master.vf_oper[slave].smi_enabled[port] =
 			MLX4_VF_SMI_DISABLED;
 		vp_oper = &priv->mfunc.master.vf_oper[slave].vport[port];
-- 
2.32.0

