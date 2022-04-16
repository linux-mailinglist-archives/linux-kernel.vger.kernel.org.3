Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6424F503324
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiDPE3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 00:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiDPE2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 00:28:53 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C17310EDFD
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 21:26:23 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r66so9618323pgr.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 21:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Y9Xga+Vf57beXiQKhYl2BdatYUIL77DBx/0ziFkle0=;
        b=Tis1KX6EZl0CEKsRc59x2S7dPKnR1WEi934au/E3F0d/WbgTIwTiOB8mewL/VD91Xs
         NVNfuXcfxjgdV732Lu5b4Cl4SjcXXhDmgDmEfFQYnwEEITd8cRsddJLvRqQeB1nN5UfY
         1GhLBRb5baZWBJzDprbY1pFcugB/2KldCaTKCxhaYZaG80vcMypoQfzg8fuiGo9eGB7r
         yQ33Hv8IcLj2cP6UQGxKoI91xU8CBE3c1FBGN5nCn05e8F4PyMKg9z8DHT1FEG4BABJq
         P7AQC1/5enx+JxOt1ehoUlnvz+mHnSvg7RW7vJkdjXE/8EGXtyRNu0EiAkzfxqbCsYFg
         Kp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Y9Xga+Vf57beXiQKhYl2BdatYUIL77DBx/0ziFkle0=;
        b=RQqunYsz3TNA5AVuvKcQPiYosRnTG/yx0IHYg1m4PHx0LVsWUjVjliLPEjZbPcRrO3
         oEgeNQ1dCnbNDRo5loEaSeV4Ntgs3vFbzf+pXfgIJt5DCN/pfEbopx9Dk8csvNT1mYVc
         jiV1CE5UddsDJhpRejPps/ADrwMGH3U8ylHuZP8SLe08vGKsQGcrVH58/PDS8x2I11tV
         BzOQNoAt4y0RaJbRIcqlyaI0QD5Q03YbmoHvIM3DqGiP/OhEiq2LITxWp3lOSrPvnm3s
         JIb2OqVy8CfnBZRbd8GqDmiJcpB7mBinORANq+JSpGduafaB4xZqDEtvTA3k7KVLfP9v
         RSgQ==
X-Gm-Message-State: AOAM531thWV78hUMc35zgYtqZBIiRb9sJSmRNlnzWiY2d9Y0qjsOJNOY
        AAtqp2+dJLKs6ray1PwtJ9Y=
X-Google-Smtp-Source: ABdhPJzs20s1Cgi6+nhy2Ypz5w/vabzPPHK2gOCRWBPzkbrazPbW8gPzGN4vpGLDMJuD6Rhpas8fZQ==
X-Received: by 2002:a05:6a00:2391:b0:50a:3ea9:e84d with SMTP id f17-20020a056a00239100b0050a3ea9e84dmr2185640pfc.21.1650083182710;
        Fri, 15 Apr 2022 21:26:22 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:9b6:6aad:72f6:6e16])
        by smtp.gmail.com with ESMTPSA id d8-20020aa78688000000b00505793566f7sm4258513pfo.211.2022.04.15.21.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 21:26:22 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4/6] xtensa: use callx0 opcode in fast_coprocessor
Date:   Fri, 15 Apr 2022 21:25:57 -0700
Message-Id: <20220416042559.2035015-5-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220416042559.2035015-1-jcmvbkbc@gmail.com>
References: <20220416042559.2035015-1-jcmvbkbc@gmail.com>
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

Instead of emulating call0 in fast_coprocessor use that opcode directly.
Use 'ret' instead of 'jx a0'.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/coprocessor.S | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/xtensa/kernel/coprocessor.S b/arch/xtensa/kernel/coprocessor.S
index c7b9f12896f2..8bcbabbff38a 100644
--- a/arch/xtensa/kernel/coprocessor.S
+++ b/arch/xtensa/kernel/coprocessor.S
@@ -30,7 +30,7 @@
 		.align 4;						\
 	.Lsave_cp_regs_cp##x:						\
 		xchal_cp##x##_store a2 a3 a4 a5 a6;			\
-		jx	a0;						\
+		ret;							\
 	.endif
 
 #define SAVE_CP_REGS_TAB(x)						\
@@ -47,7 +47,7 @@
 		.align 4;						\
 	.Lload_cp_regs_cp##x:						\
 		xchal_cp##x##_load a2 a3 a4 a5 a6;			\
-		jx	a0;						\
+		ret;							\
 	.endif
 
 #define LOAD_CP_REGS_TAB(x)						\
@@ -163,21 +163,20 @@ ENTRY(fast_coprocessor)
 	s32i	a5, a4, THREAD_CPENABLE
 
 	/*
-	 * Get context save area and 'call' save routine. 
+	 * Get context save area and call save routine.
 	 * (a4 still holds previous owner (thread_info), a3 CP number)
 	 */
 
 	movi	a5, .Lsave_cp_regs_jump_table
-	movi	a0, 2f			# a0: 'return' address
 	addx8	a3, a3, a5		# a3: coprocessor number
 	l32i	a2, a3, 4		# a2: xtregs offset
 	l32i	a3, a3, 0		# a3: jump address
 	add	a2, a2, a4
-	jx	a3
+	callx0	a3
 
 	/* Note that only a0 and a1 were preserved. */
 
-2:	rsr	a3, exccause
+	rsr	a3, exccause
 	addi	a3, a3, -EXCCAUSE_COPROCESSOR0_DISABLED
 	movi	a0, coprocessor_owner
 	addx4	a0, a3, a0
@@ -187,19 +186,18 @@ ENTRY(fast_coprocessor)
 1:	GET_THREAD_INFO (a4, a1)
 	s32i	a4, a0, 0
 
-	/* Get context save area and 'call' load routine. */
+	/* Get context save area and call load routine. */
 
 	movi	a5, .Lload_cp_regs_jump_table
-	movi	a0, 1f
 	addx8	a3, a3, a5
 	l32i	a2, a3, 4		# a2: xtregs offset
 	l32i	a3, a3, 0		# a3: jump address
 	add	a2, a2, a4
-	jx	a3
+	callx0	a3
 
 	/* Restore all registers and return from exception handler. */
 
-1:	l32i	a6, a1, PT_AREG6
+	l32i	a6, a1, PT_AREG6
 	l32i	a5, a1, PT_AREG5
 	l32i	a4, a1, PT_AREG4
 
-- 
2.30.2

