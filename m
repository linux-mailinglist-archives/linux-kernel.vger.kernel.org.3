Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D844E5617
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245411AbiCWQK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244168AbiCWQKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:10:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF6E3DA53;
        Wed, 23 Mar 2022 09:09:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DD1951F38C;
        Wed, 23 Mar 2022 16:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648051754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5WgTQZfH98TZQycf+Gq6/ZuAAj3yqxz13mOp7E8ynqs=;
        b=O/yRH/u4lQ82iJeQFG0v1Yj8c4e1VdUWxEz+Ritk2JL1uYocxZJHbiztF+YaxGljQ7sY9N
        qKMwu89COy/IdNUUBE4Yfe0c9fFOUQq2U0qk7b6YAyUmHwVo4r+BojDM+ixLbyOdqExRF/
        cux5nXsQthgVfUfzHt4xUyzexJ18VxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648051754;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5WgTQZfH98TZQycf+Gq6/ZuAAj3yqxz13mOp7E8ynqs=;
        b=4d6F6zo5LzI/FdE0E51sTZw7/WDNtZ7wGoukT3rnutSFpyTfp8S+zpPq93OwznlBYtlNvQ
        6moEK9Pgm+9FL3CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFE731331A;
        Wed, 23 Mar 2022 16:09:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4KiiLipGO2IgfgAAMHmgww
        (envelope-from <iivanov@suse.de>); Wed, 23 Mar 2022 16:09:14 +0000
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Dom Cobley <popcornmix@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ivan T . Ivanov" <iivanov@suse.de>
Subject: [PATCH 1/3] clk-raspberrypi: Also support HEVC clock
Date:   Wed, 23 Mar 2022 18:08:57 +0200
Message-Id: <20220323160859.69572-2-iivanov@suse.de>
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

From: Dom Cobley <popcornmix@gmail.com>

Signed-off-by: Dom Cobley <popcornmix@gmail.com>
Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
---
 drivers/clk/bcm/clk-raspberrypi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index dd3b71eafabf..9f08baef39ba 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -271,6 +271,7 @@ static int raspberrypi_discover_clocks(struct raspberrypi_clk *rpi,
 		case RPI_FIRMWARE_CORE_CLK_ID:
 		case RPI_FIRMWARE_M2MC_CLK_ID:
 		case RPI_FIRMWARE_V3D_CLK_ID:
+		case RPI_FIRMWARE_HEVC_CLK_ID:
 		case RPI_FIRMWARE_PIXEL_BVB_CLK_ID:
 			hw = raspberrypi_clk_register(rpi, clks->parent,
 						      clks->id);
-- 
2.26.2

