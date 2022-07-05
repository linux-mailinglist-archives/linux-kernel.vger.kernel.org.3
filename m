Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DB55663FA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiGEHXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiGEHW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:22:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C48310FEE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657005774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=N/ASHfBlGwx6CPom7xa9MrPgEDXvopeeCGbYV8xojNw=;
        b=OTNLcNcmGbXXiF0FG7/UsiDa/zHmmtTYNzoQuB/eYZ11GAm+Lq6yhVKB3R6lNUounll/Xj
        Z2gTivcLvq8DKJA+kHmLDE4RO1PQCwC6lggTW7jhk78jh3BLiq8gE3x1zPbwGt1/SaRt11
        Q4duFIDAkmZrX2SdOdH7e4FihyMBJZA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-NMpAFHpKOp-IzoNehv0Zgw-1; Tue, 05 Jul 2022 03:22:53 -0400
X-MC-Unique: NMpAFHpKOp-IzoNehv0Zgw-1
Received: by mail-wm1-f72.google.com with SMTP id c126-20020a1c3584000000b003a02fa133ceso697552wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N/ASHfBlGwx6CPom7xa9MrPgEDXvopeeCGbYV8xojNw=;
        b=bTnklVKI1Xi9fDEQAxKPj7bwvl4dzM7pi6ZEAzQInZT2e5Epuq6EOtUNGUFeMM71tN
         ovyTW/CaC3OmkP8QeFGZtUPvAoY35tUoWRw07EfHxXweGQVGK0xYihyf2F6ku3z1km9V
         Y44STL443bm+z6KAfcREDueOgqvB2+TCbjq15GPNJdgbNlTo0MsHvGoQNlQ8ON+4zs4E
         RP1DPHTpm5ShngTq99VRRw3+SAzaargRfqQYXQopBVxlne743bdjmIhsa1DgErgEkxov
         QfN4a8nYasdJxKf+3Qn98u5+ifU7omhn0NxT1RIynWrSsXIBvLv0lTNNc6EGBN3siSEX
         tl8Q==
X-Gm-Message-State: AJIora+8INBwGCV0RnxId97WiqZdBrPdb81t/2ULR1r9qRBSZkOAbHiQ
        qFbbIZsOM+iBzO1WjdQ2hfDsNQieRNKUqu+AU8ugyTDq7ieMBJ+2VfytNRyzr/S1Bp2W9h27fbu
        9umYBrWkTyfgyYWd6B3yXGmBf
X-Received: by 2002:a05:6000:1883:b0:205:c0cb:33c6 with SMTP id a3-20020a056000188300b00205c0cb33c6mr31999797wri.39.1657005771730;
        Tue, 05 Jul 2022 00:22:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tOyPW1aqWsF8F4WjCUcs8p1xoNBXMowttVXO1mb/z/gmUozhUvn0wR3gSD7sNBb/OBsGi+sQ==
X-Received: by 2002:a05:6000:1883:b0:205:c0cb:33c6 with SMTP id a3-20020a056000188300b00205c0cb33c6mr31999786wri.39.1657005771526;
        Tue, 05 Jul 2022 00:22:51 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-206.retail.telecomitalia.it. [79.46.200.206])
        by smtp.gmail.com with ESMTPSA id p12-20020a5d638c000000b0021d6dad334bsm3551528wru.4.2022.07.05.00.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:22:50 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] tools/virtio: fix build
Date:   Tue,  5 Jul 2022 09:22:49 +0200
Message-Id: <20220705072249.7867-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the build caused by the following changes:
- phys_addr_t is now defined in tools/include/linux/types.h
- dev_warn_once() is used in drivers/virtio/virtio_ring.c
- linux/uio.h included by vringh.h use INT_MAX defined in limits.h

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/virtio/linux/kernel.h | 2 +-
 tools/virtio/linux/vringh.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index 0b493542e61a..21593bf97755 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -29,7 +29,6 @@
 #define READ                    0
 #define WRITE                   1
 
-typedef unsigned long long phys_addr_t;
 typedef unsigned long long dma_addr_t;
 typedef size_t __kernel_size_t;
 typedef unsigned int __wsum;
@@ -136,6 +135,7 @@ static inline void *krealloc_array(void *p, size_t new_n, size_t new_size, gfp_t
 #endif
 #define dev_err(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
 #define dev_warn(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
+#define dev_warn_once(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
 
 #define min(x, y) ({				\
 	typeof(x) _min1 = (x);			\
diff --git a/tools/virtio/linux/vringh.h b/tools/virtio/linux/vringh.h
index 9348957be56e..e11c6aece734 100644
--- a/tools/virtio/linux/vringh.h
+++ b/tools/virtio/linux/vringh.h
@@ -1 +1,2 @@
+#include <limits.h>
 #include "../../../include/linux/vringh.h"
-- 
2.36.1

