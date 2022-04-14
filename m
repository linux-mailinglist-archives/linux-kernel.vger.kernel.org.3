Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B69500BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242557AbiDNLMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242535AbiDNLMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:12:13 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F89F1FCCF;
        Thu, 14 Apr 2022 04:09:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t1so6420085wra.4;
        Thu, 14 Apr 2022 04:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m8YxcjRVz3dnPHyYXuegZHKssZd+aJ12XNnoe2p/lBU=;
        b=QPwjbRUcBx88ygWNhP59bVfbirAHGyWx1i1uPxg6m1hHpDGaMs86y1Ne73Tj0u1lh6
         OeRnOjQRimNhxf8goiLu+sN01IRg6Z/pQnaBtDxu71IcresgOTbwx3c9aHj8oTptAP9D
         M/Qp6Ujd7rFESyQmNbGPwiOQ71SQeVmwWK5pEqhwnVkIvY9G6Uic/oUSUFjejgpA2Swh
         mHbikG+pTyZJJvUN2aoKiXwy/mk1cldVi6YnEzOAnZo5KFq7UdBNJmP6scaWqjGMy7h/
         Hqu3HJrls59CICXd+XrrI/z8WHBltIz9XDKkYKdh5cU29pRm+ZG2hecSQpQWpsbhtLS5
         ohRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m8YxcjRVz3dnPHyYXuegZHKssZd+aJ12XNnoe2p/lBU=;
        b=RWN6h14/kAXTQX//nGfUlQLwxPnkNddf8/zzBR41wxqKyhnksJjx+KPn6Jfzz7Rntr
         DTtiIWG/xbJv3XEIgXCQbhCCVkj6KjJE0yKzRMENhA9m9WE5XtE3nVUTHuGuGSRJsLEt
         xsEQ77+/j33gfquuQCtTyX2/OgzlvnL4fy2OGRM8ac4SKoIrBNxzZIhj8blLLMnorjsl
         qYKz8hG3vRjprAOhxkYsdshH5shCr9HQ1DvjuaXl0rJGxUVWO7TqGbHBQjiTXYN3vGFM
         zZmL82Kmx1WFYYos1vMg6cbrU0JfFDY4livmsfregjocfvTuCBNiUpnvRJgjJW4k+kT4
         Sjnw==
X-Gm-Message-State: AOAM532A68cB6BF3mBFffUFHRpCsHVhupCzU69Vc2gWjoa9Km6j/QhSa
        wt6fCDi00/be9tHGlC9BLm0=
X-Google-Smtp-Source: ABdhPJyCS37aNdg2XEco+WU6QFjoRABOglxLA1iZqfJ1zoLjyNWJvZY2kqrlbyAMMiqgMY/w9dzOaw==
X-Received: by 2002:adf:e90a:0:b0:209:ced9:f3ad with SMTP id f10-20020adfe90a000000b00209ced9f3admr1479725wrm.25.1649934587184;
        Thu, 14 Apr 2022 04:09:47 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d64cd000000b0020787751295sm1694504wri.35.2022.04.14.04.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 04:09:46 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.19/uclogic 1/4] HID: uclogic: Compress params format string
Date:   Thu, 14 Apr 2022 13:09:33 +0200
Message-Id: <20220414110936.146378-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414110936.146378-1-jose.exposito89@gmail.com>
References: <20220414110936.146378-1-jose.exposito89@gmail.com>
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

Shorten the format string for printing out UC-Logic interface parameters
so that it fits into a single log message.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.h | 90 ++++++++++++++++++--------------
 1 file changed, 51 insertions(+), 39 deletions(-)

diff --git a/drivers/hid/hid-uclogic-params.h b/drivers/hid/hid-uclogic-params.h
index f2649e8f959d..ebf84b56746b 100644
--- a/drivers/hid/hid-uclogic-params.h
+++ b/drivers/hid/hid-uclogic-params.h
@@ -203,45 +203,57 @@ extern int uclogic_params_init(struct uclogic_params *params,
 
 /* Tablet interface parameters *printf format string */
 #define UCLOGIC_PARAMS_FMT_STR \
-		".invalid = %s\n"                               \
-		".desc_ptr = %p\n"                              \
-		".desc_size = %u\n"                             \
-		".pen.desc_ptr = %p\n"                          \
-		".pen.desc_size = %u\n"                         \
-		".pen.id = %u\n"                                \
-		".pen.subreport_list[0] = {0x%02hhx, %hhu}\n"   \
-		".pen.subreport_list[1] = {0x%02hhx, %hhu}\n"   \
-		".pen.subreport_list[2] = {0x%02hhx, %hhu}\n"   \
-		".pen.inrange = %s\n"                           \
-		".pen.fragmented_hires = %s\n"                  \
-		".pen.tilt_y_flipped = %s\n"                    \
-		".frame_list[0].desc_ptr = %p\n"                \
-		".frame_list[0].desc_size = %u\n"               \
-		".frame_list[0].id = %u\n"                      \
-		".frame_list[0].suffix = %s\n"                  \
-		".frame_list[0].re_lsb = %u\n"                  \
-		".frame_list[0].dev_id_byte = %u\n"             \
-		".frame_list[0].touch_ring_byte = %u\n"         \
-		".frame_list[0].touch_ring_max = %hhd\n"        \
-		".frame_list[0].touch_ring_flip_at = %hhd\n"    \
-		".frame_list[1].desc_ptr = %p\n"                \
-		".frame_list[1].desc_size = %u\n"               \
-		".frame_list[1].id = %u\n"                      \
-		".frame_list[1].suffix = %s\n"                  \
-		".frame_list[1].re_lsb = %u\n"                  \
-		".frame_list[1].dev_id_byte = %u\n"             \
-		".frame_list[1].touch_ring_byte = %u\n"         \
-		".frame_list[1].touch_ring_max = %hhd\n"        \
-		".frame_list[1].touch_ring_flip_at = %hhd\n"    \
-		".frame_list[2].desc_ptr = %p\n"                \
-		".frame_list[2].desc_size = %u\n"               \
-		".frame_list[2].id = %u\n"                      \
-		".frame_list[2].suffix = %s\n"                  \
-		".frame_list[2].re_lsb = %u\n"                  \
-		".frame_list[2].dev_id_byte = %u\n"             \
-		".frame_list[2].touch_ring_byte = %u\n"         \
-		".frame_list[2].touch_ring_max = %hhd\n"        \
-		".frame_list[2].touch_ring_flip_at = %hhd\n"
+		".invalid = %s\n"                   \
+		".desc_ptr = %p\n"                  \
+		".desc_size = %u\n"                 \
+		".pen = {\n"                        \
+		"\t.desc_ptr = %p\n"                \
+		"\t.desc_size = %u\n"               \
+		"\t.id = %u\n"                      \
+		"\t.subreport_list = {\n"           \
+		"\t\t{0x%02hhx, %hhu},\n"           \
+		"\t\t{0x%02hhx, %hhu},\n"           \
+		"\t\t{0x%02hhx, %hhu},\n"           \
+		"\t}\n"                             \
+		"\t.inrange = %s\n"                 \
+		"\t.fragmented_hires = %s\n"        \
+		"\t.tilt_y_flipped = %s\n"          \
+		"}\n"                               \
+		".frame_list = {\n"                 \
+		"\t{\n"                             \
+		"\t\t.desc_ptr = %p\n"              \
+		"\t\t.desc_size = %u\n"             \
+		"\t\t.id = %u\n"                    \
+		"\t\t.suffix = %s\n"                \
+		"\t\t.re_lsb = %u\n"                \
+		"\t\t.dev_id_byte = %u\n"           \
+		"\t\t.touch_ring_byte = %u\n"       \
+		"\t\t.touch_ring_max = %hhd\n"      \
+		"\t\t.touch_ring_flip_at = %hhd\n"  \
+		"\t},\n"                            \
+		"\t{\n"                             \
+		"\t\t.desc_ptr = %p\n"              \
+		"\t\t.desc_size = %u\n"             \
+		"\t\t.id = %u\n"                    \
+		"\t\t.suffix = %s\n"                \
+		"\t\t.re_lsb = %u\n"                \
+		"\t\t.dev_id_byte = %u\n"           \
+		"\t\t.touch_ring_byte = %u\n"       \
+		"\t\t.touch_ring_max = %hhd\n"      \
+		"\t\t.touch_ring_flip_at = %hhd\n"  \
+		"\t},\n"                            \
+		"\t{\n"                             \
+		"\t\t.desc_ptr = %p\n"              \
+		"\t\t.desc_size = %u\n"             \
+		"\t\t.id = %u\n"                    \
+		"\t\t.suffix = %s\n"                \
+		"\t\t.re_lsb = %u\n"                \
+		"\t\t.dev_id_byte = %u\n"           \
+		"\t\t.touch_ring_byte = %u\n"       \
+		"\t\t.touch_ring_max = %hhd\n"      \
+		"\t\t.touch_ring_flip_at = %hhd\n"  \
+		"\t},\n"                            \
+		"}\n"
 
 /* Tablet interface parameters *printf format arguments */
 #define UCLOGIC_PARAMS_FMT_ARGS(_params) \
-- 
2.25.1

