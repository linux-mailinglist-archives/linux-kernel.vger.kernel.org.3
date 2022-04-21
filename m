Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C44509D46
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388231AbiDUKOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388138AbiDUKN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:13:57 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EBEF6B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:11:08 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id bo5so4573216pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hdnqgvQUKM2bZrGrKVDmt9RrjK+aAWvXbMuv7vTUtfE=;
        b=cbo5rNoZILL/PF4xvaUy1JfZC8M8NOp0uxlPNB8cgum7YnNXqEeLQMfcFU6K3fCUKz
         bI79klpOhBfZS9m6xyE/aZbbiUNtunfi4g1i1+FpRJuAIuwAgAsWgq3I7wBuRHCZeRlf
         5SdJZ9YI+dzv1DlZzHG2wJVB7Tpd5s7lYZCg0lvze3MH5cnQ+vj3+gg10MIvMDQmGajH
         hqwFRVhqUvk/eCxvg3xxZUrgy1EeMT95c7zSHVBOUeCSsglXP9yXTM/sj2xrVbV4OAan
         98c8/Q3HdNSmHQE6hC+UwmJGKRWWaE7y4yXkLImH7G97LOETjzfv7063gpRCw3GzMfCm
         RKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hdnqgvQUKM2bZrGrKVDmt9RrjK+aAWvXbMuv7vTUtfE=;
        b=6S8jrZf4CM+i27BVZ4go0ZnfXhWrm+mkxvlTcNtXQXOmmAFGoI9CA3XyEbn479wAuK
         2r/7CA3Eq5j9vtwpaBCPE8JEnEqONj+T0iZOd5aVy695rUUMYWlh9dPnhMn2p0/YybuV
         aGp6SxfI5JWqjBwa3VdiYehnOa1ylyoEH0Bkk/zxwWciCU+rgE/HItTOEIT6smB/RXZ9
         sn/hpV+KB7Rs0uDJ6hpDlYW4W2wWmeDWgOoNOMswrRFC59E+YFoabOWcPZtvRjVS7ovu
         Af/tyDohJJBgj1aQsO3wJ3ugBhi3gXpv43FRkhxFs5URkjoQ2I8KcJIlxIKkzxGs37zW
         plgg==
X-Gm-Message-State: AOAM533o41lEgqs0C7v7Ojaw/dp18nKEIvl0G7hLjCSZGZRQk4/EiAIZ
        cHOzxrRLFc+p5KBChpuQqy8=
X-Google-Smtp-Source: ABdhPJzkJD3TIf9slREdnMuLeJHCgp6CgU05+02Url1Fw+VtyLcJN6X4kVhTTd7i7Xj7SDvObNEzRw==
X-Received: by 2002:a63:f147:0:b0:399:2b1f:7aff with SMTP id o7-20020a63f147000000b003992b1f7affmr23531374pgk.341.1650535867681;
        Thu, 21 Apr 2022 03:11:07 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:df13:3d47:8c92:6576])
        by smtp.gmail.com with ESMTPSA id w196-20020a6282cd000000b0050ada022940sm2407806pfd.183.2022.04.21.03.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 03:11:06 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 09/10] xtensa: get rid of stack frame in coprocessor_flush
Date:   Thu, 21 Apr 2022 03:10:32 -0700
Message-Id: <20220421101033.216394-10-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220421101033.216394-1-jcmvbkbc@gmail.com>
References: <20220421101033.216394-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

coprocessor_flush is an ordinary function, it can use all registers.
Don't reserve stack frame for it and use a7 to preserve a0 around the
context saving call.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:

- new patch

 arch/xtensa/kernel/coprocessor.S | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/xtensa/kernel/coprocessor.S b/arch/xtensa/kernel/coprocessor.S
index af11ddaa8c5f..95412409c49e 100644
--- a/arch/xtensa/kernel/coprocessor.S
+++ b/arch/xtensa/kernel/coprocessor.S
@@ -216,10 +216,8 @@ ENDPROC(fast_coprocessor)
 
 ENTRY(coprocessor_flush)
 
-	/* reserve 4 bytes on stack to save a0 */
-	abi_entry(4)
+	abi_entry_default
 
-	s32i	a0, a1, 0
 	movi	a4, .Lcp_regs_jump_table
 	addx8	a4, a3, a4
 	addx4	a3, a3, a4
@@ -227,10 +225,11 @@ ENTRY(coprocessor_flush)
 	beqz	a4, 1f
 	l32i	a3, a3, CP_REGS_TAB_OFFSET
 	add	a2, a2, a3
+	mov	a7, a0
 	callx0	a4
-1:	l32i	a0, a1, 0
-
-	abi_ret(4)
+	mov	a0, a7
+1:
+	abi_ret_default
 
 ENDPROC(coprocessor_flush)
 
-- 
2.30.2

