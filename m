Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0407C5AC6B9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbiIDVmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbiIDVmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:42:08 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6012C648
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:07 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id p187so5652534iod.8
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=wU3a+NtnQXjoNN7rXOqrGTxjDahMgVmGQsWn0PV1P8M=;
        b=oqkgy1Lfx8/69RwJIe3zmzWJ5fKHCCfMExZbNN1eCUrtrvQvfE+1n1ok/9I/8qxcYJ
         V2Y5ovP3OXd3K2CAgS1BbVBtTfJUEdG+6tO5gfR37M2/5p6wJ7VN6X0nrZdJxzrfPg/O
         GkZXIIfX5vDFQr6/LJp0ofI0n6FCf/1AN3tsFeNZ25fi7xHd9VYOST2OyHqYWaGYzSlw
         QAv9HoibN19LRrRCQG9pGNe24p8W2DNmEf8nLDndfGLmEJnHDeMsDoQW6Zdu2pC0wkcY
         XlK7itax1DrgPu8UOaURRS4O0KdAKHHKQZ5pij8wgvGjblMAY0dpNFeQ9Bgy/4Pt7tCN
         CpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wU3a+NtnQXjoNN7rXOqrGTxjDahMgVmGQsWn0PV1P8M=;
        b=HXci5Uj1eQui56bOj8lp+JfYxuaEF404XKpPfxq62XwDFSBfkLfLoopxz8EGMWKZJA
         QxXWXBy9RkOkpy+u3YOB5eKm3E8EKvg2YI8rUgYK7UDP2pr+06y7YIQlJrLAoYPbuI0/
         hsYp7uRjy7yS6sGmMzXqafPjwXsam0eH18hnkyF70qNIbM0VGh0/eNjLmHZfbjfBaZeI
         uOqT5KbamoVXFrsI9wN3xgwbzuja+LVxBATwxVmzwMm9dEJxYmCxGHwlapKDcdPCU5gt
         Isnka0uP/KNPgijrW4Dw/uWsEVUdIiijXMJ4pYsjmp6LV6+630yywfAaIKRJbVS4H1nJ
         hOyQ==
X-Gm-Message-State: ACgBeo3bjNgSLLQ9XJmt23GO2L7HCm73X7mNB4MmH1p6qC3NyQDQGXnp
        vpoXprICewYmCVi2JFUw4cStzLv54zk=
X-Google-Smtp-Source: AA6agR6woh73WD6o0519OJbQFrJQIwWPKVm7AZf+Fo8tuX8h74mdDupZVosU1fX68Rvv18her7b2lQ==
X-Received: by 2002:a05:6638:25ca:b0:351:1a2a:763d with SMTP id u10-20020a05663825ca00b003511a2a763dmr3305728jat.251.1662327726407;
        Sun, 04 Sep 2022 14:42:06 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:06 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>, vincent.whitchurch@axis.com
Subject: [PATCH v6 01/57] dyndbg: fix static_branch manipulation
Date:   Sun,  4 Sep 2022 15:40:38 -0600
Message-Id: <20220904214134.408619-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904214134.408619-1-jim.cromie@gmail.com>
References: <20220904214134.408619-1-jim.cromie@gmail.com>
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

In https://lore.kernel.org/lkml/20211209150910.GA23668@axis.com/

Vincent's patch commented on, and worked around, a bug toggling
static_branch's, when a 2nd PRINTK-ish flag was added.  The bug
results in a premature static_branch_disable when the 1st of 2 flags
was disabled.

The cited commit computed newflags, but then in the JUMP_LABEL block,
failed to use that result, instead using just one of the terms in it.
Using newflags instead made the code work properly.

This is Vincents test-case, reduced.  It needs the 2nd flag to
demonstrate the bug, but it's explanatory here.

pt_test() {
    echo 5 > /sys/module/dynamic_debug/verbose

    site="module tcp" # just one callsite
    echo " $site =_ " > /proc/dynamic_debug/control # clear it

    # A B ~A ~B
    for flg in +T +p "-T #broke here" -p; do
	echo " $site $flg " > /proc/dynamic_debug/control
    done;

    # A B ~B ~A
    for flg in +T +p "-p #broke here" -T; do
	echo " $site $flg " > /proc/dynamic_debug/control
    done
}
pt_test

Fixes: 84da83a6ffc0 dyndbg: combine flags & mask into a struct, simplify with it
CC: vincent.whitchurch@axis.com
Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
.drop @stable, no exposed bug.
.add jbaron ack
---
 lib/dynamic_debug.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index dd7f56af9aed..a56c1286ffa4 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -211,10 +211,11 @@ static int ddebug_change(const struct ddebug_query *query,
 				continue;
 #ifdef CONFIG_JUMP_LABEL
 			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
-				if (!(modifiers->flags & _DPRINTK_FLAGS_PRINT))
+				if (!(newflags & _DPRINTK_FLAGS_PRINT))
 					static_branch_disable(&dp->key.dd_key_true);
-			} else if (modifiers->flags & _DPRINTK_FLAGS_PRINT)
+			} else if (newflags & _DPRINTK_FLAGS_PRINT) {
 				static_branch_enable(&dp->key.dd_key_true);
+			}
 #endif
 			dp->flags = newflags;
 			v4pr_info("changed %s:%d [%s]%s =%s\n",
-- 
2.37.2

