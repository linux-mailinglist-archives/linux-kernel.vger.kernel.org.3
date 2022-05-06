Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D486551D262
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389605AbiEFHkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242343AbiEFHkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:40:21 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CE25DA30
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:36:39 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id k14so5508648pga.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 00:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Cnmywrnu3rViVjyjTrHy7lr2MEpFSHL0j0EcHBkWfz8=;
        b=dUA8gSxGEQ9vHr09a0i1aEK396Fru+x1xgG6lcOuLbrbdXrlXO73Deu+tXev/47/w2
         O6CAD3cpSK4puLXMs1wgSDOCrmSM5wR6UbSafgLAGP7WQfvSmUgI1Bs2Uv9VWo6yQKHK
         wNJLigIDgVTMz6bcnTxtYMIImrpes1myrc1BXR1OBlXjAyEaJp6WqIvh5uO7mk96J7wd
         79HWxOkFMPM310Nv/rhfDaWsnHYcuD9BDgr8DwJdlgDfnctp9WCPcoyR1eTjMIqcqXpn
         ZkQB++rABNTGAukfsFUwIRKqYep8OX2QP6lSO0fWNxcxdaOyrz2ExdBgIJQAEP5QTfce
         UKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Cnmywrnu3rViVjyjTrHy7lr2MEpFSHL0j0EcHBkWfz8=;
        b=7mKJCXhITTNn56i1mpFAR4tEi+xoVh3hU+PZcZTtV8ZPiGBcgBXIvUsz69ffnnkFop
         KPxOGK6YTBz4Rk5loye9GAh5KdChEC5fa5mfls1swIjqg6EPXf01K3Q+doee7t7dbEYP
         hwO+Ra//AR48Rz3CONjSCrvVl+tH3aO4saXJWWLAJl3zvEjhNZfo9KHogveL7SFz1j5k
         rx2leQFwea8G/VoOFUaiO72DUL13l8Ct0yMsR8LbpC/cUQoAfnsYv3esyYQzSuuQ95Y9
         JYDL2kHGTK5DbPCb00Tt+mCDZJ3vu8JdcwMeoiuBWguBoDUag/pBqlJvZEa0P6cYgmRw
         LJ8w==
X-Gm-Message-State: AOAM530gEe9EhiWHb12QfIpbQaRdBnvv07ikrUuo8blMxbsY9TDqnQBm
        nGdqNXVOyzj8s9MvFNnVPLk=
X-Google-Smtp-Source: ABdhPJzKccbof7mquJdxURNo95/kIYHbOJnPjjZTUdCbcUU1UFNYr7yZGbfo565XJHGU2Xp/25WWxw==
X-Received: by 2002:a05:6a00:1490:b0:50d:f304:61ea with SMTP id v16-20020a056a00149000b0050df30461eamr2023749pfu.73.1651822599127;
        Fri, 06 May 2022 00:36:39 -0700 (PDT)
Received: from localhost.localdomain ([183.14.31.73])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902e54200b0015e8d4eb236sm949190plf.128.2022.05.06.00.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 00:36:37 -0700 (PDT)
From:   Puyou Lu <puyou.lu@gmail.com>
Cc:     Puyou Lu <puyou.lu@gmail.com>, Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] lib/string_helpers: fix not adding strarray to device's resource list.
Date:   Fri,  6 May 2022 15:36:22 +0800
Message-Id: <20220506073623.2679-1-puyou.lu@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add allocated strarray to device's resource list. This is a must to
automatically release strarray when the device disappears.

Fixes: acdb89b6c87a ("lib/string_helpers: Introduce managed variant of kasprintf_strarray()")
Signed-off-by: Puyou Lu <puyou.lu@gmail.com>

---

Change since v1:
also set 'n' of strarray https://lore.kernel.org/lkml/20220506022845.26750-1-puyou.lu@gmail.com/

---
 lib/string_helpers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 4f877e9551d5..5ed3beb066e6 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -757,6 +757,9 @@ char **devm_kasprintf_strarray(struct device *dev, const char *prefix, size_t n)
 		return ERR_PTR(-ENOMEM);
 	}
 
+	ptr->n = n;
+	devres_add(dev, ptr);
+
 	return ptr->array;
 }
 EXPORT_SYMBOL_GPL(devm_kasprintf_strarray);
-- 
2.17.1

