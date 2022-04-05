Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A310C4F2C1B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 13:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345484AbiDEKl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 06:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240959AbiDEIcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECFC91560;
        Tue,  5 Apr 2022 01:25:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D0341210E1;
        Tue,  5 Apr 2022 08:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649147130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p7Y05L7uOkIJquMnEg+eO/WF4r7xbv9mlE1hTt5HzHs=;
        b=QTCcWeRSxmtaPQcnjhcxGV6y8zrYNXXfKZvW0smRC1Z4E8alqJxsnm3t1m5cIiLud6rBDX
        CCFz18ZHmdnp4m1SaZg8qRC2zmNdtPamt4TTGfryllKc9mlcJP70meU4aXUD8kkrnkFVj7
        CObTXQscO+vhCwIc9MT78jVoyqsxd64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649147130;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p7Y05L7uOkIJquMnEg+eO/WF4r7xbv9mlE1hTt5HzHs=;
        b=z850LmrTnqtL0PP3wyuPWV69JsNFpCW527wlNSNd9XqpJvWPDk+MS08t5MJQwvGBVhuaES
        /OqRCZbvuc6hY8Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B795D13A04;
        Tue,  5 Apr 2022 08:25:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mKOcLPr8S2JwEQAAMHmgww
        (envelope-from <iivanov@suse.de>); Tue, 05 Apr 2022 08:25:30 +0000
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Ivan T. Ivanov" <iivanov@suse.de>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH v2 2/2] clk: bcm: rpi: Handle pixel clock in firmware
Date:   Tue,  5 Apr 2022 11:25:03 +0300
Message-Id: <20220405082503.61041-3-iivanov@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220405082503.61041-1-iivanov@suse.de>
References: <20220405082503.61041-1-iivanov@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clk-bcm2835 handling of the pixel clock does not function
correctly when the HDMI power domain is disabled.

The firmware supports it correctly, so add it to the
firmware clock driver.

Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
---
 drivers/clk/bcm/clk-raspberrypi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 2e2491d85835..530820d13104 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -129,6 +129,9 @@ raspberrypi_clk_variants[RPI_FIRMWARE_NUM_CLK_ID] = {
 	[RPI_FIRMWARE_V3D_CLK_ID] = {
 		.export = true,
 	},
+	[RPI_FIRMWARE_PIXEL_CLK_ID] = {
+		.export = true,
+	},
 	[RPI_FIRMWARE_HEVC_CLK_ID] = {
 		.export = true,
 	},
-- 
2.26.2

