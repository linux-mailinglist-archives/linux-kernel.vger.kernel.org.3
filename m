Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE7C5905F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbiHKRgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbiHKRf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:35:59 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7646B15F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:35:58 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id g14so10299783ile.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=uAM2bHt8Z4xuRTvJFeLRexags7bboegRrLg3WgQNpl4=;
        b=ii4VkUoA6F32PRQBQUwOPojiHvt0PrVuYDunF42/VkxHg9+3RJfUzGcusx4Ds/F0vJ
         Fx00G6swXTCJfgfwhWLj6KtJaMMhybcLUOANyAJxp7zX1nY4B9o6NWTABl7FoLHgrUHO
         Ph/OOeHyLwLY94W6rTuDTE28HFO3GXrjXZDQAD1j1LSrV1AObbxSL5lggiHS8BA1+bpH
         QgVuW39C5gejOnmPbvKb4otziow0TA8THJBBBqRQ13wVHeCzDMO0UN6l0JwPl5wdKIR5
         47G+SyMSfb8XArc70d7VLNucqfqAHhffwK6tRKGaonHcDMqoJ6KnKNYvzPWzE1qUiTKJ
         +8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=uAM2bHt8Z4xuRTvJFeLRexags7bboegRrLg3WgQNpl4=;
        b=gvnlmBBDrQ6rbd03dw18atyLofdyYXEA2YjDkpkhii6o/20bOEaAZ90TuoudvTAs43
         iHKeq/dTvK2p9iM2vHbaVqB3POQU5wYnp+QgF+Pyk5ZW1txXYzTkLVieKhWzdkNIM8kk
         Wgp94Z84ap8h47jtUrmE4xLgg+RKsyG9aNuMPJpdCmDaO13nv3hD/bOfV6hNf1Uq0sbm
         0pr/8o5yNgYHZTZvyd81sfLj7CwIysPH8MNceb1KMZQF2Wm2Z5RvT170bG2BVThOSRDE
         7shsFR+Ak4k7GbRHUwqmb9J0d6I50F9BWG+XqvUkRycLdzvXK9G+2TgM1Gtwx8pd4Y25
         aYMw==
X-Gm-Message-State: ACgBeo0irg6o8SmsLjckSlcUhjELY0vnKqz1Q9B8RfC5/cgE+hfCUTDC
        L3ZwKdeOWGg6OUvOaT82pKWV7kPuze0=
X-Google-Smtp-Source: AA6agR773fBmmtSnCwo3EB5i9LD8tnjJz7n3ytBGEbs/AY8QwkldH4ybtX5UedgjiGxUhkZ69W9L4w==
X-Received: by 2002:a05:6e02:178d:b0:2de:9179:85e9 with SMTP id y13-20020a056e02178d00b002de917985e9mr126261ilu.308.1660239357406;
        Thu, 11 Aug 2022 10:35:57 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id n9-20020a056638110900b003435e8635bbsm27928jal.77.2022.08.11.10.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 10:35:56 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jbaron@akamai.com
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 04/11] dyndbg: reverse module walk in cat control
Date:   Thu, 11 Aug 2022 11:35:34 -0600
Message-Id: <20220811173541.2901122-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220811173541.2901122-1-jim.cromie@gmail.com>
References: <20220811173541.2901122-1-jim.cromie@gmail.com>
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

/proc/dynamic_debug/control walks the prdbg catalog in "reverse",
fix this by adding new ddebug_tables to tail of list.

This puts init/main.c entries 1st, which looks more than coincidental.

no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Acked-by: Jason Baron <jbaron@akamai.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8faf584f2f4b..7fb99492c16f 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -970,7 +970,7 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	dt->ddebugs = tab;
 
 	mutex_lock(&ddebug_lock);
-	list_add(&dt->link, &ddebug_tables);
+	list_add_tail(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
 	vpr_info("%3u debug prints in module %s\n", n, dt->mod_name);
-- 
2.37.1

