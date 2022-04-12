Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24844FE6B3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358046AbiDLRTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358024AbiDLRTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:19:25 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E11517EE;
        Tue, 12 Apr 2022 10:17:06 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id o2so11713819lfu.13;
        Tue, 12 Apr 2022 10:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5V/Upaciu1rdVXXB4sSZScHsFUHEgkIrez1AIm0SE5U=;
        b=bQXkiSJWoVjKgWuXDIoPnkrXITM+lUm9P/nH8r2bVjMU6GNqD9EBTU4mY/l/Qgngaz
         xdSxV4sI+QtnyVa2HE7ehYdgyaHNK2WpcUhhDyybnxWsDT9vHmC5dbqAHnVexiHp0P1H
         5QxdnfDhJziqv0HurjgJmdufcQwhohnkL13JMC5XpP+TXHq97PrRgsDfZ1sjLtUtmReZ
         a0WBOP5tQY0XFBUoel6C54+VuQxmIp7U1IIPlfk3cHUtUeamn5+b79AYa4IBTD8+IXCW
         p5lcFfxC4+TCqUdp7PXD4sy0SdsVYpWD+wAEIj1TLrmODUof4WimxDeX/2w1MBd8eVZM
         6yXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5V/Upaciu1rdVXXB4sSZScHsFUHEgkIrez1AIm0SE5U=;
        b=ZzwGznams4St2bHBw4zarh1KxCKds50JNqSgxQqTJNvKnMybP/9aBlOyPQ5ICMUc0Q
         5BsHmouNkP5KdxHmMbxlxO1MQUOCvKv4sXRfkAx0xtdzwh7GtrN9BlEK6tOTHAF32BLN
         nsYGCjW+fFfWlgw6cdYa6+PsAtcP8tRC91Ihu1Rv1Ot53gphYaCkyxFGl/XJotNF4ZGR
         LgC+cx1qF6JzlygBCaeSTe3tERc7gH46HMCwDwTYsYrvrDt+q2XMHIYQQM31pPYB884q
         +kzKqLYT7ayd1OnVGLxiiRCFKOyGZGuapLmQCSaq8dXcQCd4nhQBNpAK6mUaNqeNt8zt
         DpUg==
X-Gm-Message-State: AOAM532ivjD4yq8S9xK9f2l8JfA/M+yigyeD90yozYQ258JCEmXaZaGe
        VfaN5HuyVuuzrn9rd+XyQ0FFT35emKYEOuNe
X-Google-Smtp-Source: ABdhPJw/GHTfiH2lFKrIuL1p4Fi7m7wi79+u1/1ElPtvKctByA85Z8OdbXwaY0arrJ+sH9dUKJWfpA==
X-Received: by 2002:a05:6512:402a:b0:45d:6b6a:a547 with SMTP id br42-20020a056512402a00b0045d6b6aa547mr26961226lfb.25.1649783825099;
        Tue, 12 Apr 2022 10:17:05 -0700 (PDT)
Received: from morzel-asus.lan (static-91-225-135-18.devs.futuro.pl. [91.225.135.18])
        by smtp.gmail.com with ESMTPSA id m2-20020a05651202e200b0046ba665cd6dsm723928lfq.141.2022.04.12.10.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 10:17:04 -0700 (PDT)
From:   Michal Orzel <michalorzel.eng@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     Michal Orzel <michalorzel.eng@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v2 1/5] block/badblocks: Remove redundant assignments
Date:   Tue, 12 Apr 2022 19:16:47 +0200
Message-Id: <20220412171651.19812-1-michalorzel.eng@gmail.com>
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

Get rid of redundant assignments to a variable sectors from functions
badblocks_check and badblocks_clear. This variable, that is a function
parameter, is being assigned a value that is never read until the end of
function.

Reported by clang-tidy [deadcode.DeadStores]

Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
---
Changes since v1:
-move the change into a separate patch
-add analysis
---
 block/badblocks.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index d39056630d9c..3afb550c0f7b 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -65,7 +65,6 @@ int badblocks_check(struct badblocks *bb, sector_t s, int sectors,
 		s >>= bb->shift;
 		target += (1<<bb->shift) - 1;
 		target >>= bb->shift;
-		sectors = target - s;
 	}
 	/* 'target' is now the first block after the bad range */
 
@@ -345,7 +344,6 @@ int badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
 		s += (1<<bb->shift) - 1;
 		s >>= bb->shift;
 		target >>= bb->shift;
-		sectors = target - s;
 	}
 
 	write_seqlock_irq(&bb->lock);
-- 
2.25.1

