Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7B15A2AC3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343927AbiHZPMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343507AbiHZPLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:11:25 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5D9DEB46
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:09:12 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id w20-20020a05640234d400b00447e6ffefccso1264860edc.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=7FFI4T9ldWmH+mtJkkuNX0Iy/L7lZFULsA12RNz3xXM=;
        b=QeYGUAhX5R1EbSsJKxcsBcPRZBVW1PHkAvLdrlFwdXozptYGSnAUgNLSENVZNbs/pm
         K7DsUzuQ3O+CgsIf/IsEjZ9LO6DDEbJ/9UkwQ3NFfO5E9GyCNzZ0bQPXg5zln9YU9onl
         g042XVM8aCr5IqAR958NCkCsQWdTGI4OQtHiGm/rgicIY9qzg4V73Kb90uYceut/3UVw
         nFA6k+3xgurgpKXQPV00WyHGYNj3CUHxYWE3tNF2YhTlAM4LRfiVradwPFKvsYBl8Bzt
         CIjpkvmBr/QmH0E2CwFFacPDaEu6Y7HjWsctPdxYCvSgU8zQkP/JHmVv1mOQDs6l/MdM
         WRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=7FFI4T9ldWmH+mtJkkuNX0Iy/L7lZFULsA12RNz3xXM=;
        b=29CuGRZO3ANG9JLCmSB2BfQKHtw8ry+kkz+bKr/OEUWXL1K9Iu1aNTeJ2s1P+BZ78b
         zxbxIID+WBa9Y0CrNyv2eImr981461AqwGDMLTDibhxefPYlan7XjZmrrXPG7TpUIp/T
         PryxB2X6LOfvvR8cPkCz11iUC5zQ9hB3Kv9FovgwoSsjkGwCADH7TVBBLtnCOlDWKDqV
         UNZCKuK/huyakCiir43P2eKFPPjzd9hYS2J5MKDOWx73rY5PROUL48ymzVxuo30EYWyD
         O6m1YDPtkkRJX4W1/tlmfavBVjk+PlRsKx1iZd7RNJs9XccnyK4Bk7gcVlUJVARy9h46
         RWRg==
X-Gm-Message-State: ACgBeo0EIiNND3ELs16UktsFKQgpz8Se5Td3xK3ED9oaJYweOse0jP6y
        tJD0PI6lQJGg+uUw/wUW/aq2PaLE20Q=
X-Google-Smtp-Source: AA6agR4fgqA+dojvdGvqhLNd5rEasz16MWjupX7avc3NFMUfZTqvlMHxZx6remvRJmIFi8mix2S1kZP+8vA=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a17:907:6d9b:b0:731:1135:dc2d with SMTP id
 sb27-20020a1709076d9b00b007311135dc2dmr5939518ejc.76.1661526551609; Fri, 26
 Aug 2022 08:09:11 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:07:44 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-22-glider@google.com>
Subject: [PATCH v5 21/44] Input: libps2: mark data received in __ps2_command()
 as initialized
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
2.37.2.672.g94769d06f0-goog

