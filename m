Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95CE4BC779
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 11:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241970AbiBSKCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 05:02:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241932AbiBSKCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 05:02:37 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BE2BF50;
        Sat, 19 Feb 2022 02:02:17 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d3so2825029wrf.1;
        Sat, 19 Feb 2022 02:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4YOgpFLtWS7h5tJe+djFYqPHh8CvpUAaYaqxMZRjHoQ=;
        b=JXQv3lGd5gCfvQ3Ipc3amxkevQLot6hS2wtoQeRnnTWG/J+JF2Lws0ZZJBieLRbe5B
         KEGQHPzVx8PjvVKOh3uAXg19lS9Dt/T++chkMDMnsd+fdDIhgvrphGdOsOAcEMT75pEy
         uZyYal5Zj+UZh+HPsljXmoVUMy/31uZgh+g8AK0+IfX0z2JOmY3u42nWPjlehzZUokW9
         1kxKTsHGVo3edxav4P8Qmm/+4TRVz2DrQzvidfvLgkfsNnpuGh2FImMJGCw1Kt1vrLo5
         31L1wtULDdWwPuF6cz6kPum4eyniIZ8I2neCmxyN/NjeXCNB0BujLJKCLrHeSKbvJWvl
         dyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4YOgpFLtWS7h5tJe+djFYqPHh8CvpUAaYaqxMZRjHoQ=;
        b=ZHosmIatStuPyYrk78fq9BqD551lwFcDtmvq7DsmTzvAw0SAO+lrk8BpRkFSWODWhh
         m9ODslG0D7Hz8IvtynNK1SrD9uR0D1hKsDJjbu0PBeDJP2mtMiMoPR5cRBy6V/shQsTk
         sMQ0S5045j+KvbnHz5L6rzHxnb/9ydaEN/FPyiojOMMXIPxIeENXWARVWBJjnCDisNV0
         ru51cCAglthPFqKykCG/GpK0WXI1qov0zcXx4X/qSMdIGKZd0wB7qcLMzoBucFNjXXbQ
         YZaoCgdpk35nelnU618+TyPqYg2s9PDBTuX4+iWqKklBXpjFr3tEvO+5XSklO/gv/gOJ
         +Pdg==
X-Gm-Message-State: AOAM5308GiUG/dyXyYGygUchhTEF8sBxnXN1S0ht0gf89shhb3YRUKZO
        CXuVe1erGWGxwiI7i9/ElPUH+rdEMXo=
X-Google-Smtp-Source: ABdhPJzFURye2K74yN0XVppP/YXKSFGoWlvjNCQcsJj1LyH8Qp5sBb3lPZVOTLNdHT+Fc4NZqjDU7A==
X-Received: by 2002:adf:f312:0:b0:1e8:f4bb:5a5c with SMTP id i18-20020adff312000000b001e8f4bb5a5cmr7925179wro.668.1645264936089;
        Sat, 19 Feb 2022 02:02:16 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id az13sm24417244wrb.39.2022.02.19.02.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 02:02:15 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.18/uclogic 8/9] HID: uclogic: Define report IDs before their descriptors
Date:   Sat, 19 Feb 2022 11:01:56 +0100
Message-Id: <20220219100157.41920-9-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220219100157.41920-1-jose.exposito89@gmail.com>
References: <20220219100157.41920-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolai Kondrashov <spbnick@gmail.com>

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-rdesc.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-uclogic-rdesc.h b/drivers/hid/hid-uclogic-rdesc.h
index d1ab1f346f22..3d904c27b86a 100644
--- a/drivers/hid/hid-uclogic-rdesc.h
+++ b/drivers/hid/hid-uclogic-rdesc.h
@@ -117,20 +117,20 @@ extern const size_t uclogic_rdesc_v1_pen_template_size;
 extern const __u8 uclogic_rdesc_v2_pen_template_arr[];
 extern const size_t uclogic_rdesc_v2_pen_template_size;
 
+/* Report ID for tweaked v1 frame reports */
+#define UCLOGIC_RDESC_V1_FRAME_ID 0xf7
+
 /* Fixed report descriptor for (tweaked) v1 frame reports */
 extern const __u8 uclogic_rdesc_v1_frame_arr[];
 extern const size_t uclogic_rdesc_v1_frame_size;
 
-/* Report ID for tweaked v1 frame reports */
-#define UCLOGIC_RDESC_V1_FRAME_ID 0xf7
+/* Report ID for tweaked v2 frame reports */
+#define UCLOGIC_RDESC_V2_FRAME_ID 0xf7
 
 /* Fixed report descriptor for (tweaked) v2 frame reports */
 extern const __u8 uclogic_rdesc_v2_frame_arr[];
 extern const size_t uclogic_rdesc_v2_frame_size;
 
-/* Report ID for tweaked v2 frame reports */
-#define UCLOGIC_RDESC_V2_FRAME_ID 0xf7
-
 /* Fixed report descriptor for Ugee EX07 frame */
 extern const __u8 uclogic_rdesc_ugee_ex07_frame_arr[];
 extern const size_t uclogic_rdesc_ugee_ex07_frame_size;
-- 
2.25.1

