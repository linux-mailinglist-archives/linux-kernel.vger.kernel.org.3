Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CA85AD2B2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbiIEMaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbiIEM2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:28:43 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D54B5F9B6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 05:26:02 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id c14-20020a05640227ce00b0043e5df12e2cso5752088ede.15
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 05:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=lOWe2UvDp+lzLw75WkGUXRoANIiWBb139LkOr44Ytus=;
        b=tTKCC8E0FZGTE1PqKz29JX/2nPiAROSv7nBNIKGtZQqtA/Jc/wKg23z16zcRSICf9V
         5+VK18dSOsEVzrLNZfg05+QTe4rJOMf7PLWu12nixFzQPGlMmrK4kNV0MVAmB1xFyDUp
         fh0O1ZosEFKdO8Yi1waDmf6eNfefrG1y1wRvC1MLpl4b6ewma9AVT6z20HaDp07JZcPW
         CWv8wkRFGfuGADjLPH0jWxPW3H7vBuGBn9m0/FJ/z7BJvQsM8Oym+Hget4IsHr+AP45B
         CZ7Yk/Iz2QhGWTNmmH28t0KetSXuqpaeillrdIThwRnrJbAybPbz8cbVsFZy5erwsmUi
         wLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=lOWe2UvDp+lzLw75WkGUXRoANIiWBb139LkOr44Ytus=;
        b=6KrpRzMNRPYUl51KntemE0xZyu/JJw8qRAsfmsDYcfi5Rb4dqheeB1EqEC9FF1KC1S
         d60WfxJKwINpO4CetZd6bgXIqvA0VnAPh4C1n72Qn1QRXBYQJkkgBguHPPdr1qCqnBer
         NOyYWejSeIqlGBbFca373VBwPOzbY0ApcCv1fqL3RZ5aqcS8J49bkniorLVxmxhLkOoB
         d9P8fg1cISQw9jkim1GdMmk+Iy1+CGKQJnlO4+j2pU66zVO1G4M/wYwGFeoV6rhtBkA2
         AxRl+Mqz1Jhp9wvCVF37hrKbmXvZlja5TCBkE2R2hmg42CNewyAwwbaS/aemOG6nIGt2
         ro3A==
X-Gm-Message-State: ACgBeo3cItPtugm230w5WtJGCYg6s8AqVQ1bgrvBQiwBujqExgdIHQap
        OSx3xNsgjX/Ws3eC5RqHEQF/sg5zZGg=
X-Google-Smtp-Source: AA6agR7FNmpKjolLE1by3INbujX31rVBl6iJG78jz8dfceM2y9tc86KJyobPC7mva0DftsLWsbXlYG7fcOg=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b808:8d07:ab4a:554c])
 (user=glider job=sendgmr) by 2002:a05:6402:320d:b0:448:7cc8:7901 with SMTP id
 g13-20020a056402320d00b004487cc87901mr30728374eda.423.1662380760517; Mon, 05
 Sep 2022 05:26:00 -0700 (PDT)
Date:   Mon,  5 Sep 2022 14:24:31 +0200
In-Reply-To: <20220905122452.2258262-1-glider@google.com>
Mime-Version: 1.0
References: <20220905122452.2258262-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220905122452.2258262-24-glider@google.com>
Subject: [PATCH v6 23/44] virtio: kmsan: check/unpoison scatterlist in vring_map_one_sg()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If vring doesn't use the DMA API, KMSAN is unable to tell whether the
memory is initialized by hardware. Explicitly call kmsan_handle_dma()
from vring_map_one_sg() in this case to prevent false positives.

Signed-off-by: Alexander Potapenko <glider@google.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>

---
v4:
 -- swap virtio: and kmsan: in the subject

v6:
 -- use <linux/kmsan.h> instead of <linux/kmsan-checks.h>

Link: https://linux-review.googlesource.com/id/I211533ecb86a66624e151551f83ddd749536b3af
---
 drivers/virtio/virtio_ring.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 4620e9d79dde8..8974c34b40fda 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/hrtimer.h>
 #include <linux/dma-mapping.h>
+#include <linux/kmsan.h>
 #include <linux/spinlock.h>
 #include <xen/xen.h>
 
@@ -352,8 +353,15 @@ static dma_addr_t vring_map_one_sg(const struct vring_virtqueue *vq,
 				   struct scatterlist *sg,
 				   enum dma_data_direction direction)
 {
-	if (!vq->use_dma_api)
+	if (!vq->use_dma_api) {
+		/*
+		 * If DMA is not used, KMSAN doesn't know that the scatterlist
+		 * is initialized by the hardware. Explicitly check/unpoison it
+		 * depending on the direction.
+		 */
+		kmsan_handle_dma(sg_page(sg), sg->offset, sg->length, direction);
 		return (dma_addr_t)sg_phys(sg);
+	}
 
 	/*
 	 * We can't use dma_map_sg, because we don't use scatterlists in
-- 
2.37.2.789.g6183377224-goog

