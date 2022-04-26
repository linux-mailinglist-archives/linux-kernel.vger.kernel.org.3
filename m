Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCA4510444
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242512AbiDZQvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353296AbiDZQtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:49:11 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C6E3BBFD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:45:22 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id i14-20020a17090639ce00b006dabe6a112fso9272160eje.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A4BOD5bYYCwqT6UysGwaTqw9NZkJge0TWQm9U6+WrG0=;
        b=khSFQmZPrfoPgxGEUABi/FVW8V9rw4+gcS76epQACJKqyg7hkcjwrrNZSEPqT8cKN9
         ONCpTChsOEZ0awUUpbA5x5xayPRdehOMzeg0fmzK8U1O+otCttBP994AhBNpWeRijLhC
         uA0BFEVHSShFszO60gnvZ/g8XEEAvlCsHxSsQtTYtMUoAiTqbiLeIdThYaket6Dbkru7
         YLDTtMsAFMm7WODYFRUO4LbdZSTFrmTAN4yb5OHT1IcBSYVtVTBthQ8DYmMN9xjdT8Y5
         P4oaK9oxiUba69g6lk7NgMT+HmLDsQRoGLtP+vFJRnamxCbKjs/0LNdi6KunA8g68VkO
         EfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A4BOD5bYYCwqT6UysGwaTqw9NZkJge0TWQm9U6+WrG0=;
        b=o/6EEklGNHs3UoKQ5NpmvZiPHUr3KEVMdjsBbah/HagI+mN2RFrszMCasuVfcWxcW2
         Ery03/Lu80GXuRqVxpIwLfS2y8lgnoTxsIwXMkan9sDCIHlSnyZ+PVljZHNmSImmej3l
         4Ph1YcO5If15uAKnbRcO7bTbfJDajrebAii/yz1rzM2jFt1oVMJhqONhUX1RxvVL7lbe
         FipAiEScCQbzFOojAjAqIsDKmTruabtl85Q5vBhCcZQHHzmGLdZlw+4Tf0K059300iE9
         12gl8SUuo3EsTQUjVwdXw6I/Sdjw8qLktahq2a1qgZIvGOmiPI6vr66ixC62UqU5QGjD
         eIJw==
X-Gm-Message-State: AOAM533inHhX1GuZ5PodpRXlwmJZVu9+0Plit4YJa5+pxFlOsz66pYp3
        wOMCvkZb/v0/gd/siYoNqC3p/m9NXbE=
X-Google-Smtp-Source: ABdhPJxAop9pzi2nkfiGiO4x6mNOPP93/Bjni9kA40EEqg0TirQbaSSuyCXI2m0QfvecUipohdkmvzvyeto=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a05:6402:254e:b0:424:244:faf with SMTP id
 l14-20020a056402254e00b0042402440fafmr25661420edb.260.1650991520418; Tue, 26
 Apr 2022 09:45:20 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:42:52 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-24-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 23/46] Input: libps2: mark data received in __ps2_command()
 as initialized
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN does not know that the device initializes certain bytes in
ps2dev->cmdbuf. Call kmsan_unpoison_memory() to explicitly mark them as
initialized.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I2d26f6baa45271d37320d3f4a528c39cb7e545f0
---
 drivers/input/serio/libps2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index 250e213cc80c6..3e19344eda93c 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/input.h>
+#include <linux/kmsan-checks.h>
 #include <linux/serio.h>
 #include <linux/i8042.h>
 #include <linux/libps2.h>
@@ -294,9 +295,11 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
 
 	serio_pause_rx(ps2dev->serio);
 
-	if (param)
+	if (param) {
 		for (i = 0; i < receive; i++)
 			param[i] = ps2dev->cmdbuf[(receive - 1) - i];
+		kmsan_unpoison_memory(param, receive);
+	}
 
 	if (ps2dev->cmdcnt &&
 	    (command != PS2_CMD_RESET_BAT || ps2dev->cmdcnt != 1)) {
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

