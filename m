Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79695520BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 05:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbiEJDGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 23:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiEJDGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 23:06:38 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8477142801
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 20:02:40 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id bo5so13818562pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 20:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ordBIaEUDLbti7M0xUa/AbdDrMXvFisQMIa5b0nyI3I=;
        b=DuWbjHWH3zDh8VikdxPnwiPGg6TwxdZyLCFrVU3bCWShI/vVWoH3t/IKHDdGl3QsDi
         +WTAP/Q7WX3/v0sne4CbgMbz1TZiaKRfDFVKVOFyJ5pELCuNkEHE03Yhjjt5NfDbI/J2
         5maIHgMsZKu4TaiI4mJnT2hIiPC3t9w/tW/fuM/4ctbNJt6/gYSm7xci0rBXsK6fhvRs
         GbBgmTKrKr5+h52ibuSVdHoORJ+hKEddLKWDmfUc4CKxdi1gDDHxxkIHyN4dV4QzCPg0
         AxVdXJGlPabyvMji2fSL1LuIq17dYgrmcvKA5v0b3kTlXQonJbdJJoD/8CgBkxLMaIQG
         TWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ordBIaEUDLbti7M0xUa/AbdDrMXvFisQMIa5b0nyI3I=;
        b=gWpcOMgTW+dKCyVoP3S7OVJIIlyYbqZSwF4vO40MKdiZWeX4dgO3RbUaOnf+Ls1yzM
         Ak4KaXu/flV5UbH8+QL67cDDZGAr9HfdysC04i7SfFBWJzvoJHEBuZ5CWStU+6N61VhM
         hMShJagbEaSXuRCDq82QHohFw3kb/D7R4ta9X6sWOJ95OJSm9Awd1ZYCD29hu+9j/osy
         3roFGVGgxxCJjBdZApuz8NYT1PpyXcyZAaBx9OKaJZOfekhup7zB4a5OAkB6kJQIQzCi
         dPYmLsJEOlaHKoNnnHV3TWNpUF+9Quon/0pcjYLiDJAsuUWNjvvL4qm2nuHs0k8buCWn
         yyyg==
X-Gm-Message-State: AOAM531V+qfeUZHeVQzW8ibOHjg0v3t6v/5/eAE6jnHFW9UUYVcc4j17
        0wJHhA/QSs1lt7LRuRRNDv4=
X-Google-Smtp-Source: ABdhPJxv5QBHUc16y6nkqTIz5HpFvRimP/3zk5T67xIEr3orr6iUbtHCEzOLwvvTxydhqRXilQxejw==
X-Received: by 2002:a63:1a5c:0:b0:3c1:9a7c:3739 with SMTP id a28-20020a631a5c000000b003c19a7c3739mr15432124pgm.272.1652151759652;
        Mon, 09 May 2022 20:02:39 -0700 (PDT)
Received: from lxb-server.lan ([2403:18c0:2:4f4:216:3cff:feba:eec])
        by smtp.gmail.com with ESMTPSA id l6-20020a170903120600b0015e8d4eb291sm617622plh.219.2022.05.09.20.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 20:02:39 -0700 (PDT)
From:   Yunhao Tian <t123yh.xyz@gmail.com>
To:     =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Yunhao Tian <t123yh.xyz@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Lechner <david@lechnology.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/mipi-dbi: align max_chunk to 2 in spi_transfer
Date:   Tue, 10 May 2022 11:02:19 +0800
Message-Id: <20220510030219.2486687-1-t123yh.xyz@gmail.com>
X-Mailer: git-send-email 2.25.1
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

In __spi_validate, there's a validation that no partial transfers
are accepted (xfer->len % w_size must be zero). When
max_chunk is not a multiple of bpw (e.g. max_chunk = 65535,
bpw = 16), the transfer will be rejected.

This patch aligns max_chunk to 2 bytes (the maximum value of bpw is 16),
so that no partial transfer will occur.

Fixes: d23d4d4dac01 ("drm/tinydrm: Move tinydrm_spi_transfer()")

Signed-off-by: Yunhao Tian <t123yh.xyz@gmail.com>
---
 drivers/gpu/drm/drm_mipi_dbi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index 71b646c4131f..00d470ff071d 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -1183,6 +1183,13 @@ int mipi_dbi_spi_transfer(struct spi_device *spi, u32 speed_hz,
 	size_t chunk;
 	int ret;
 
+	/* In __spi_validate, there's a validation that no partial transfers
+	 * are accepted (xfer->len % w_size must be zero).
+	 * Here we align max_chunk to multiple of 2 (16bits),
+	 * to prevent transfers from being rejected.
+	 */
+	max_chunk = ALIGN_DOWN(max_chunk, 2);
+
 	spi_message_init_with_transfers(&m, &tr, 1);
 
 	while (len) {
-- 
2.25.1

