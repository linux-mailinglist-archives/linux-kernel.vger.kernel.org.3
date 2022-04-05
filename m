Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06904F2C2C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 13:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbiDEKHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 06:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240968AbiDEIcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF3491341;
        Tue,  5 Apr 2022 01:25:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A20121F37E;
        Tue,  5 Apr 2022 08:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649147130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xzto3jOtflbOG3/cNYqAPCn/Axn/FLld8h6se3wYmZE=;
        b=ChdIPMtso4JJwBpqRzHAhGLRP30X+9pHNGNiuTgjaH1hXuobELrD9qzt5jax1ipyMJybXx
        t7mgY0Lx+URG5o+W74f2VVB0Bjc2Eapjm6JeOHHAXOZ+3pzifKaxU2OwXzsoYFUbjP6val
        RQzTZnG4rleh3yzt+76DjH5A1K+WH4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649147130;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xzto3jOtflbOG3/cNYqAPCn/Axn/FLld8h6se3wYmZE=;
        b=RrkIJBOVI265E6joX/1kUqUm8sazSgGWVoholWR1rp/jUWoIoQOs3SfxcWJXcCOHtDCz5d
        xd17nyXdeNxR+gDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 889BE13A04;
        Tue,  5 Apr 2022 08:25:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aWISIfr8S2JwEQAAMHmgww
        (envelope-from <iivanov@suse.de>); Tue, 05 Apr 2022 08:25:30 +0000
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Ivan T. Ivanov" <iivanov@suse.de>
Subject: [PATCH v2 0/2] clk: bcm: rpi: Add support for two more clocks
Date:   Tue,  5 Apr 2022 11:25:01 +0300
Message-Id: <20220405082503.61041-1-iivanov@suse.de>
X-Mailer: git-send-email 2.26.2
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

Add missing clock required by RPiVid video decoder and make HDMI
pixel clock more reliable.

Changes since v1
- Drop RPI_FIRMWARE_VEC_CLK_ID clock it doesn't seems to be used.
- Rework downstream changes on top of recent Maxime changes.

Ivan T. Ivanov (2):
  clk: bcm: rpi: Add support HEVC clock
  clk: bcm: rpi: Handle pixel clock in firmware

 drivers/clk/bcm/clk-raspberrypi.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.26.2

