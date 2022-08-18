Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D02B597ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 08:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240059AbiHRGs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 02:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbiHRGsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 02:48:25 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B8513E88
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 23:48:23 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DBD9C40AFB
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660805301;
        bh=QSepvCE+QvU8qyq2q6n9pYjju+rfRtTHn1zPijhNAtQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=MmnEediGta8ktbU2v4W4h4XPEg5+u9OlqmamFDg57wAR+s91yYxU9+63eMktL3BrW
         zk0RbZwKZJgqY60XVmGPZaAV88l8NVGK7Thw5ki173A+UMWh56yk79F7Y8PpAMA9Fr
         tDVyGWo6OpS3PJKyEpIqn6I67YmdY5QfXtiaZdzWEYHdamu9jaINDdrWbfCBoZRw3L
         lEAejPPnuz99BDSTCciZhk2sNPSmCUI5z1n2BNSoUAnMBHam6rNTJU3iK3k7QAYg7c
         69pJUN9ZbnmS87xvsN4dV1xCl+0xRTby+hqcg0QPDx1E78CXQtoC4JiUwoRrDhOLdM
         UOFr7VMh+o3RQ==
Received: by mail-ed1-f70.google.com with SMTP id l19-20020a056402255300b0043df64f9a0fso386814edb.16
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 23:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QSepvCE+QvU8qyq2q6n9pYjju+rfRtTHn1zPijhNAtQ=;
        b=tOQ4dV3p9dd0b6In7z89xuf8ehA6r6u/KjdqEODmLUr6PvVM29RtIxd6SRQM41k3EA
         /vRDzzvhFtum+Jt4a4dbE8jG9ZFBEZ1v6swuXxiRVvAA6biiDEuvI8qEEUN3nU7cuixA
         YF2txh8Nf9wGrkZLqEbwGE8wv/0e3Xq0ft5ioe826imTReZcNu9DjYHSlDyoHM8n07eS
         ojQqhKCj9U2gzofFXEoENe4v0JVTXAxDFEa2qb9XcZ9qeT8RlFECsydEfJT7NrQPOaPJ
         XZsucPysCki0Jc+H73+AsB5X/HKip+B5r6mt8jIuCkJdhek9Kn4H2t4KXaSwxYmL5Xm1
         64sA==
X-Gm-Message-State: ACgBeo28QdQ0z0yDcwfIpmMEx1lCcsEMp8svJM95FXvNFUlqBebXQgaX
        6cwdyAS4XoiRRow3WsJ+/vXp3pQ39BRPpZXd44Aw2fs6QNYQ9q6Vs9zYoeR+jQe7r1p9Mpdnypw
        sUL1YQ5YadE9JP+8yTYpbkfsH9pcuiZlb65JrR5qXqA==
X-Received: by 2002:a17:907:2c48:b0:730:cdc9:2c0b with SMTP id hf8-20020a1709072c4800b00730cdc92c0bmr1021426ejc.482.1660805299877;
        Wed, 17 Aug 2022 23:48:19 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4Dbe0SHDmhO81TnTzDYpNAjxnqwXxvYkMUgdOn4rij2A9rkDj6mEyDGejb4El1ju108l/O+A==
X-Received: by 2002:a17:907:2c48:b0:730:cdc9:2c0b with SMTP id hf8-20020a1709072c4800b00730cdc92c0bmr1021416ejc.482.1660805299753;
        Wed, 17 Aug 2022 23:48:19 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id g20-20020a170906539400b0073c14e7589esm59157ejo.161.2022.08.17.23.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 23:48:19 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     narmstrong@baylibre.com, mchehab@kernel.org,
        gregkh@linuxfoundation.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-amlogic@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH v2] media: meson: vdec: Add MODULE_FIRMWARE macro
Date:   Thu, 18 Aug 2022 08:48:10 +0200
Message-Id: <20220818064810.17856-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817140539.150013-1-juerg.haefliger@canonical.com>
References: <20220817140539.150013-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The meson-vdec module loads firmware so add MODULE_FIRMWARE macros to
provide that information via modinfo.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

---
v2:
  - Drop duplicates
  - Add Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/staging/media/meson/vdec/vdec_platform.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/staging/media/meson/vdec/vdec_platform.c b/drivers/staging/media/meson/vdec/vdec_platform.c
index 88c9d72e1c83..70c9fd7c8bc5 100644
--- a/drivers/staging/media/meson/vdec/vdec_platform.c
+++ b/drivers/staging/media/meson/vdec/vdec_platform.c
@@ -280,3 +280,12 @@ const struct vdec_platform vdec_platform_sm1 = {
 	.num_formats = ARRAY_SIZE(vdec_formats_sm1),
 	.revision = VDEC_REVISION_SM1,
 };
+
+MODULE_FIRMWARE("meson/vdec/g12a_h264.bin");
+MODULE_FIRMWARE("meson/vdec/g12a_vp9.bin");
+MODULE_FIRMWARE("meson/vdec/gxbb_h264.bin");
+MODULE_FIRMWARE("meson/vdec/gxl_h264.bin");
+MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
+MODULE_FIRMWARE("meson/vdec/gxl_vp9.bin");
+MODULE_FIRMWARE("meson/vdec/gxm_h264.bin");
+MODULE_FIRMWARE("meson/vdec/sm1_vp9_mmu.bin");
-- 
2.34.1

