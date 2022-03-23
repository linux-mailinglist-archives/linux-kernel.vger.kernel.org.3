Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014D24E5616
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245414AbiCWQKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245325AbiCWQKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:10:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEB63BF9E;
        Wed, 23 Mar 2022 09:09:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F0F8A1F38D;
        Wed, 23 Mar 2022 16:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648051754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nFshvjQoCO4+8ksoNXu2qsNXNkIE+l4UT7PFYRU6I8k=;
        b=pESn3aJwUggyMpeigQyk2/gfy3QYJjbYBoPZ8286k9axulJLG81iapaX4CYxzUivh0DJj9
        vW9Wx1vtiapkwzSmWAv1Ns//qZX/zAlSwjDtpNXr7vl5e8WOqR09Cks8fVphSHb+lydDbl
        zEXDK0dTuW3aIdTfHNJ2NT0M6h9mZBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648051754;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nFshvjQoCO4+8ksoNXu2qsNXNkIE+l4UT7PFYRU6I8k=;
        b=QD1XqTHfZU8x8DcaHIqV9sa3Pabg1UZZoUMiQBr/tyIUCoD7crlDSNtG263qrnuE2b2wK9
        Mn1N1M6Eq8zlvMDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2D211331A;
        Wed, 23 Mar 2022 16:09:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ON8pNypGO2IgfgAAMHmgww
        (envelope-from <iivanov@suse.de>); Wed, 23 Mar 2022 16:09:14 +0000
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Dom Cobley <popcornmix@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ivan T . Ivanov" <iivanov@suse.de>
Subject: [PATCH 3/3] clk: bcm: rpi: Add the BCM283x pixel clock.
Date:   Wed, 23 Mar 2022 18:08:59 +0200
Message-Id: <20220323160859.69572-4-iivanov@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220323160859.69572-1-iivanov@suse.de>
References: <20220323160859.69572-1-iivanov@suse.de>
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

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The clk-bcm2835 handling of the pixel clock does not function
correctly when the HDMI power domain is disabled.

The firmware supports it correctly, so add it to the
firmware clock driver.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
---
 drivers/clk/bcm/clk-raspberrypi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 240128939d57..658bfcde3616 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -276,6 +276,7 @@ static int raspberrypi_discover_clocks(struct raspberrypi_clk *rpi,
 		case RPI_FIRMWARE_HEVC_CLK_ID:
 		case RPI_FIRMWARE_PIXEL_BVB_CLK_ID:
 		case RPI_FIRMWARE_VEC_CLK_ID:
+		case RPI_FIRMWARE_PIXEL_CLK_ID:
 			hw = raspberrypi_clk_register(rpi, clks->parent,
 						      clks->id);
 			if (IS_ERR(hw))
-- 
2.26.2

