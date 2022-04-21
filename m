Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7879C509D41
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388177AbiDUKOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388111AbiDUKNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:13:48 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585E1F6B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:10:59 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q1so3227156plx.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B7FHzMluexVIsqE1V6kW5pfW6b+ReTL+xQGzEDyIhFU=;
        b=kjChlxe8VgxE69b7ApaQ9rh9eBMJrVErU/WvoNjea/mBJgU00BBPN84LnSuKDz6tV2
         cfBdsrBP1RSkgl0uOoTOX5kdSp99GZN60D1zCdqE38rT7q/DHSjgYD6S4PTnKIiiw9mF
         mIc/+nhe/SYvf2LSYs2f8ea8h2pmoyX5g8g21KtUgcRTwE+UIS/xTr+DBgOuuxj3OigW
         cmrDVt5aPS4pRvphKSwnYdOqbE9ZzY+dvyeurA0+iYqKOb1JjOth3DHYyCLJvwqCFVkR
         ZuE/o/MGJEYlzxBWt0mlxypekFk5w2yXD/oulg4/Ea1dLZ+87PiWKYsWD76/oANz97gP
         t2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B7FHzMluexVIsqE1V6kW5pfW6b+ReTL+xQGzEDyIhFU=;
        b=fdHeTzQNPZRZzlE5Hu3/0RFQu3rAR8uMLAPgUEgArkmCzNmxspviN9gIFOzfqQAroA
         y/DYErkl1U5x6btzoFLO7SKFsIXv2jMqZAVll7uR478GCh1L5RYXS/ohWdLvmhSrFqAT
         BxuUDlS0ui2mS8gP+uaVkPWRx4uaQzLF6FkDRnhjrEZC+RYnyfnd2jrib3B8L52Gfv3v
         RHE3YJfuEaX54/pVDzFwTvnExTudHUlVsI8+QgGguELcmnjCb5iUp88JyKBjRzbtHolb
         ADDkBs0Twc7Hmst2O4PWtSxkehsJrsCyR8J1pcMuKkmuJ3/8pCOqxrDtJo9lnf4Ec4aG
         L2zw==
X-Gm-Message-State: AOAM531zwIISC8oymXplOUPkpgELmDTwgAEZfwu/apqtAI/7ZwzTLZDh
        uWjLEUcSQjbqYLuETWA+q9s=
X-Google-Smtp-Source: ABdhPJxb94NYpExDFY4CbV2v7r3MsQKhZOz394WqSve1CnQS1Vqb1f6BadHKuN58Ai+KR2vqO6Cl4w==
X-Received: by 2002:a17:902:6ac7:b0:150:24d6:b2ee with SMTP id i7-20020a1709026ac700b0015024d6b2eemr24843852plt.168.1650535858700;
        Thu, 21 Apr 2022 03:10:58 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:df13:3d47:8c92:6576])
        by smtp.gmail.com with ESMTPSA id w196-20020a6282cd000000b0050ada022940sm2407806pfd.183.2022.04.21.03.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 03:10:58 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 03/10] xtensa: clean up declarations in coprocessor.h
Date:   Thu, 21 Apr 2022 03:10:26 -0700
Message-Id: <20220421101033.216394-4-jcmvbkbc@gmail.com>
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

Drop 'extern' from all function declarations. Add parameter names in
declarations.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/coprocessor.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/xtensa/include/asm/coprocessor.h b/arch/xtensa/include/asm/coprocessor.h
index 0fbe2a740b8d..a360efced7e7 100644
--- a/arch/xtensa/include/asm/coprocessor.h
+++ b/arch/xtensa/include/asm/coprocessor.h
@@ -143,10 +143,9 @@ typedef struct { XCHAL_CP7_SA_LIST(2) } xtregs_cp7_t
 	__attribute__ ((aligned (XCHAL_CP7_SA_ALIGN)));
 
 extern struct thread_info* coprocessor_owner[XCHAL_CP_MAX];
-extern void coprocessor_flush(struct thread_info*, int);
-
-extern void coprocessor_release_all(struct thread_info*);
-extern void coprocessor_flush_all(struct thread_info*);
+void coprocessor_flush(struct thread_info *ti, int cp_index);
+void coprocessor_release_all(struct thread_info *ti);
+void coprocessor_flush_all(struct thread_info *ti);
 
 #endif	/* XTENSA_HAVE_COPROCESSORS */
 
-- 
2.30.2

