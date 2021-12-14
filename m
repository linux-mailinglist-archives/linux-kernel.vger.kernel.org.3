Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1C74747CB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbhLNQXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbhLNQXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:23:15 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F86C061759
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:23:06 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id a11-20020adffb8b000000b001a0b0f4afe9so2062173wrr.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RCylrb6G91/E/2vtsmKFgkT1r5eRWWtCKOMrnaR3rS0=;
        b=SC1C+6vpXr8HhRaNadHiQrHplXa2kTitGVDtEEVvo/VrrTc0GKtS90GfxGyyjv/uIU
         Gl/r4wNi4cjwD4k7LpB8i9yt1uiBCrmAnLNIaiGGNAa5OoTgjezb10lfEPoQ/GaeQqmf
         5qUDDqWGueIOP/FgPPX7tknIguxeVvNUN++V/9a+2dDpTxqjWw4PQpyEc8noRfwFoXyv
         xy6PPtcuiudOOiEZccKacAw0PDC4zXCg+pdnGBrwgtN8FZ+qpJpxq26TBTjQXuIXJ0Mi
         1/jfDPSYbAYAUEVRomUDfFdagkdwem60SUAf9u9FUETpXnhkyTL+cqPlolp9b8UvxxVm
         y5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RCylrb6G91/E/2vtsmKFgkT1r5eRWWtCKOMrnaR3rS0=;
        b=Ha1y16dk99vN+yApKclEGBafUzDSwIcbDMLZ9O4pfgs879zevK5/D5oNvA8mOw4MDQ
         vsFXFJci6IgzMntAftXME2wevxUdEFGa+3eDIdr3HEtee0+2dcuLyJBke2f4tXkiScym
         5gCMXTKudsKRK6SFkv3gcnkrnGcn/CDjEy0mOV1iyiK5k/cfp+f26nSqz86KR1u5TFft
         jMszqn9auNNf30eBoK5X2lvlUfFpnvbDZaP0XsdRQUMBCaTO9WhnXt/xj0w0OJdN8jU3
         lo2KUF/9r+Im4Zy/wePdu3HyLcoNy6IJwEDldkPBzMFd/1JPE1dO5XZSoPn5dNO9dTHP
         E34g==
X-Gm-Message-State: AOAM532mDjnrKNjF26kNPIxfMnwUzkestf2YxJlhRySiDYgV0ewTgJK9
        gJRgTB64lxGQ6Lfr9FCPgeCJTCaDats=
X-Google-Smtp-Source: ABdhPJw9UBXdJlo13EpvnyI9qmtetaMmbSMsl/SrkoqoZXzI79hK6SLrS6tAUR/JTk3AKx81zpcHzTtcriI=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:adf:f088:: with SMTP id n8mr6603937wro.411.1639498984734;
 Tue, 14 Dec 2021 08:23:04 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:33 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-27-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 26/43] kmsan: virtio: check/unpoison scatterlist in vring_map_one_sg()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If vring doesn't use the DMA API, KMSAN is unable to tell whether the
memory is initialized by hardware. Explicitly call kmsan_handle_dma()
from vring_map_one_sg() in this case to prevent false positives.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I211533ecb86a66624e151551f83ddd749536b3af
---
 drivers/virtio/virtio_ring.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 6d2614e34470f..bf4d5b331e99d 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/hrtimer.h>
 #include <linux/dma-mapping.h>
+#include <linux/kmsan-checks.h>
 #include <linux/spinlock.h>
 #include <xen/xen.h>
 
@@ -331,8 +332,15 @@ static dma_addr_t vring_map_one_sg(const struct vring_virtqueue *vq,
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
2.34.1.173.g76aa8bc2d0-goog

