Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCB5573A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbiGMPyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237055AbiGMPyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:54:21 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A4C2F03C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:54:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id e15so14675982edj.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wd/s1oqutSE+yMzIOn3FnRkILvpsaIaromdJtoK2E98=;
        b=E6XTr5G1xmYxjPGZl4rKWuxNI6OOpy4vfVV1k6EKTZPU5YRVQBtFuKg3Exq6PJS9px
         eqEucM1LnbydX6zfL57M+9wyL/1lH+1uUVUKIdNT5ceAKngsGibQ/GAJMtPvYraUhicj
         yJwvV6WEklOJBx6qpeUHkdJp1GzmPomaaJCBdMfbCUFpG9keiK2Tu4EsaELzIUbVdgaC
         8dX/7GVOUtRDhM05vIzf2B+SqgefLQVOhdXIKK2/dYqAg+GO6JplNYKDh/Q9kx+caHD+
         BGNqX2XfFSMEYE9ee4bgBNWCXToYCRL2DXST0Y/4bbqDCN0dcdcZGtTneLVvFtMrKx7z
         KE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wd/s1oqutSE+yMzIOn3FnRkILvpsaIaromdJtoK2E98=;
        b=1If/K+Wn0D0KyJiq8N8pC+sFui5MhrljLgVGDK0pMpDRlBeisj4nUG1qNxlSzS4b+M
         YFqMCmjeJyxmJ75XdQiPOLGBmEIJaJmzcfW5BqbriPfqWPbAZNjTS2peOw6zqDUeabgM
         8DxnvlMylvyKvM8HnqqaXvDe2pKI+m0HfbU7enVqWNgiKOyfxOP4uOWzpFJB2VSMgxPK
         e07DRUTBHyujxfmrdXhF3TSgxs5ooL/nCnFYFaLUbS4zIwJiJvnu0+oiUdNJeJPjV63b
         KiSVW7poRlx/qFkuXr2wpjyC3SmyTOcdX4fdF5uOcxSySbiEKiqgJNBzImvv9cMcXvIM
         ZWcw==
X-Gm-Message-State: AJIora9+rb8HiePBpqn13+cle8wKJ6QtIMGWFAUTuldLxRF3hTwQLAoZ
        VnIDvMfuEZVyn7tjRWgAnv4INfrUolo=
X-Google-Smtp-Source: AGRyM1uyeYkgz34pJ2GGGT1yzTp8mXQY2sp2IaEfdwo1/OV65EtoBlfbCP6SERzPh3CWMemwKj/YjA==
X-Received: by 2002:a50:c209:0:b0:435:6b37:46cb with SMTP id n9-20020a50c209000000b004356b3746cbmr5875328edf.341.1657727659296;
        Wed, 13 Jul 2022 08:54:19 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id n2-20020a17090695c200b0072b21cab5a5sm5073688ejy.133.2022.07.13.08.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 08:54:19 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 1/2] ucount: Fix atomic_long_inc_below argument type
Date:   Wed, 13 Jul 2022 17:54:04 +0200
Message-Id: <20220713155405.80663-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220713155405.80663-1-ubizjak@gmail.com>
References: <20220713155405.80663-1-ubizjak@gmail.com>
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

The type of u argument of atomic_long_inc_below should be long
to avoid unwanted truncation to int.

Fixes: f9c82a4ea89c ("Increase size of ucounts to atomic_long_t")
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ucount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 06ea04d44685..974ac1585009 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -216,7 +216,7 @@ void put_ucounts(struct ucounts *ucounts)
 	}
 }
 
-static inline bool atomic_long_inc_below(atomic_long_t *v, int u)
+static inline bool atomic_long_inc_below(atomic_long_t *v, long u)
 {
 	long c, old;
 	c = atomic_long_read(v);
-- 
2.35.3

