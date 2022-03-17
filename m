Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CC84DBC87
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245678AbiCQBiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358355AbiCQBiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:38:02 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B246D219F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:36:46 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mr5-20020a17090b238500b001c67366ae93so1746573pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hLOIx+3Pmnl73GTjEYvWShoiqMdFw5kmET+4unFTHJ4=;
        b=Wu0nsARKIICs+jW7F3oFJzGJqelliQJG3GF0j3U0ZvNRO0AE1q/qzHQX9QkTC+J+ts
         k1t3Wyz9yne0IfIGAaizMCF3pjzp0+MEJ6pzGlLgIvV9ueTFJCQdEIk0ev5XLb4NAm7U
         nL79DmZ2iL1/B6Nr7VtXE+myrcqBy+xyuWFeAAjPusteIKcAhlFNSHiOLc2v8w31nnRI
         SqzWPCMgxhxpz/2hatPqF2sWkgX1NU52CRfVT2ZqFgIafuDNE3YEO0h1926a/EJS0dau
         wEVje5ho5xkuxfwnNsmM5niuP2wv2OvL+nBD9S4XAu3lTBcGNiT5Y5rdpEPSlNggNftZ
         MxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hLOIx+3Pmnl73GTjEYvWShoiqMdFw5kmET+4unFTHJ4=;
        b=ZXVi2GiHM6z4bPIQxB4oe2rfWzrIC0hVwYtqGu18WfRzu09t3/RBEp+SBQx/VAu9RL
         4TUacdiAGE4Ocw4LD5fgkxiU7if768dqhkrK2wFBG+HnbrvOGVjp9btwNn9CYMfLgbco
         +5Pc9cI9IereoycuUlz62nGCJwq64b+G9OewlZPr+YJyLpvuxeEHGuhkXAtbHKwCphaI
         dgy1vgaYxu1YMjVk3igO0QbxbMiggIKtMC/lCk57eq9aOT9DJkm+ml5Z6folFwEk2pkO
         gmSLj8jnOIG4XQrHXHkis5r/3EZZQjWbbypbquFTvZw1i8g0DxPkdV3WAs1UANNaWgjP
         orMQ==
X-Gm-Message-State: AOAM531bStzFudz/ExuhQWEkNBuIwAKEYTxOzf/ZFvSh7EbJw0/0QKHS
        Zx3samEXBc3PF7oxFLI8VWM=
X-Google-Smtp-Source: ABdhPJx3HpfjQ/SBKMITNoJ7cIjTDAlFbLmyoyo48cbvUkkjoivULVly5bln19Od9Eedj5f8PjoHng==
X-Received: by 2002:a17:902:edd5:b0:153:abee:1093 with SMTP id q21-20020a170902edd500b00153abee1093mr2677801plk.77.1647481006288;
        Wed, 16 Mar 2022 18:36:46 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p25-20020a637419000000b0037fa57520adsm3759644pgc.27.2022.03.16.18.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 18:36:45 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     mingo@redhat.com
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] sched: sched: remove duplicate include in 'core.c'
Date:   Thu, 17 Mar 2022 01:36:32 +0000
Message-Id: <20220317013632.2135160-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Changcheng Deng <deng.changcheng@zte.com.cn>

'stats.h' and 'autogroup.h' included in 'core.c' is duplicated.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 kernel/sched/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ef31751c5799..0b87a26f231c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -82,10 +82,8 @@
 #include "stats.h"
 #include "autogroup.h"
 
-#include "autogroup.h"
 #include "pelt.h"
 #include "smp.h"
-#include "stats.h"
 
 #include "../workqueue_internal.h"
 #include "../../fs/io-wq.h"
-- 
2.25.1

