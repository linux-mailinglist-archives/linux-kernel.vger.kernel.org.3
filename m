Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2F94D3C7A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237427AbiCIWBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbiCIWBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:01:03 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D6A49900
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:00:04 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id h5so1787974plf.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ETWE4LlCM0BCZZSgmhGgtdOUBlAms7fQZsyUDLXvHw=;
        b=ItpQucT3jB1AaUEy3NOv39/EpCagm6oO4riT7Po3DEIGUFTGvCzCYo8pGHM3ikAEgu
         m7NefqG8qDXA3HbutQke5PGJ/OgPor3TZOqZ7muxG63Tlu3qqDFsfZ9/iE2AvC882OO9
         fjyCDVWALz1NkQwC/kh/L35ORnpWN98bqEGZWadIg+Sw5AQgALvbKiQInyVxGOnp/BC5
         7+QCQSF15ADOksPOqRHXVpk0ajewh6u+ll0iYFR3BjwHbMh4aprtON5PTMdK5fWLifpc
         mw1iw3WP4gpqhQMces6fx9b4Y4cnDLRTKpToYZmj6Z31KplwWeJumgnCx3K48HRI+308
         UJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ETWE4LlCM0BCZZSgmhGgtdOUBlAms7fQZsyUDLXvHw=;
        b=YkRgAucRSu+kY/dn/yvyvVEiVg2Q5Vna0efxkFj0MFv0F3+0mpmywnPgkLgMNor2Ms
         wctizhjEgojGIM2CD1PIX+5H0sqOoTFEgHUgqulhK2T1kS466uaWZRLGFFkCh2Bl0YMR
         XO8biKvV6aZoHInBqCvFyWhgdEMHCEuuLopCQxE5ZRwO1a/6S0gnt9ukQlFQDy7QMnoc
         JSdedq30jhRHcyCD2jhIEdBpxAajpfGUG+JtL5Lm5XQINuetyfJWDb+t8+Ks+sx/GBVT
         2ciIEGvzbO8z81rxoc5FxVeLzECBK0WnQOxGj/37RKpp7SGTBCfzKUj+VcT87x0ICFfI
         SxcQ==
X-Gm-Message-State: AOAM531SZxqAgakVhE39Q3mvLQiAqEs6NlxbMyJI3lX0ocSS5sGFYNRn
        Q23V0gUdHgYWXH+/w8OlyvIEjoZCUaVNlA==
X-Google-Smtp-Source: ABdhPJywJEJ41wCLjoFmQzQwW0VYUCE3fUFoF+NvfDfXPKrDtxV7FY2K8jnLVeBYIdNEpB+Bnq2FEQ==
X-Received: by 2002:a17:90b:1c86:b0:1bf:2a7e:5c75 with SMTP id oo6-20020a17090b1c8600b001bf2a7e5c75mr1657451pjb.145.1646863203865;
        Wed, 09 Mar 2022 14:00:03 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:6f34:be93:349a:f478])
        by smtp.gmail.com with ESMTPSA id y10-20020a63b50a000000b0038088a28ec0sm3317336pge.22.2022.03.09.14.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 14:00:03 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: add missing XCHAL_HAVE_WINDOWED check
Date:   Wed,  9 Mar 2022 13:59:48 -0800
Message-Id: <20220309215948.1250865-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing preprocessor conditions to secondary reset vector code.

Fixes: 09af39f649da ("xtensa: use register window specific opcodes only when present")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/mxhead.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/xtensa/kernel/mxhead.S b/arch/xtensa/kernel/mxhead.S
index 9f3843742726..b702c0908b1f 100644
--- a/arch/xtensa/kernel/mxhead.S
+++ b/arch/xtensa/kernel/mxhead.S
@@ -37,11 +37,13 @@ _SetupOCD:
 	 * xt-gdb to single step via DEBUG exceptions received directly
 	 * by ocd.
 	 */
+#if XCHAL_HAVE_WINDOWED
 	movi	a1, 1
 	movi	a0, 0
 	wsr	a1, windowstart
 	wsr	a0, windowbase
 	rsync
+#endif
 
 	movi	a1, LOCKLEVEL
 	wsr	a1, ps
-- 
2.30.2

