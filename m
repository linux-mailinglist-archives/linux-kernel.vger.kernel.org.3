Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A6B4D9691
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245406AbiCOIp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346113AbiCOIpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:45:09 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E404D25D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:43:56 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u10so27808024wra.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ET+xzNuDp+rklrBcyzEb7KUpoGOfUFW9oXFXIwsaP18=;
        b=M4XtYpV5xFKZ4/LNkeOtZBubF/ujdqqBVP0ZGQl7RSTLeL/aG/4xHxy64MpcOIxKAh
         dMQwxjhM3apB124dNFN06+tNT9zquawoM8m9gwZ6l+PCOVmZzzQJla23s8YlW8EF+JZw
         /TlkHlulcN597e9nqXWbaly8yS94+YUtf4W/KiKddaJLfjq23stIpdQl/XR2vQUPRtor
         REwQUbG+PsRShQDmSoZ3jz4d1w+KZZuTVZcVBA3La5bGcFfxZ0MyW0Lu4BIkVGx5w0x0
         La1EvHQFx4BsPxB/CBCAyO7qwSjcy4+t/biXrck/wCMBKLzyIR0hYgtAV7Y75TCYAxqP
         t/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ET+xzNuDp+rklrBcyzEb7KUpoGOfUFW9oXFXIwsaP18=;
        b=67T98FfGq9kBJT/WS/JHVsLF7Q+8SVbkr6jb6Pm1EwGicnSqrgnU0CO4c3nLUNS1NQ
         k8HxSpz8xcjLcQstB3VYNlzqt5Fy1gdL5Yw19ok7/NekZuMavcNMRAGl9OwdGI+Seiv6
         UKA5njR4dBxUchmDIzoRRd0Oi5P0Jq62pnyuSckoDonHqY6n7Iujd7bmX8shZBdnXckn
         x5js5bQ/M+LoDojgUaSbbiozxmD4asmqIINOSnC/8ZNGAjiz4kjPrm9fOeYDLAoEqBoG
         8r//s03GtAbCCE8fV5iGqx+5dcNz+4NfCGp4U8g0SFoKv9m+QRS3ae7cNftgWDfH7lk+
         7Lfw==
X-Gm-Message-State: AOAM531WDLIsA5+1iBamPtpUoz7QgfXvt+8j5j6XDZV42buQIlPbshby
        XXUHAXOaAtz6MvCY8IMOgOKHD2mAgzU=
X-Google-Smtp-Source: ABdhPJybolAvSP49vOrZeZ9n8J8ok1utvPDcT4CrohBtOagn/YDIxN1Mm9qdhawUQQ4rXQoQUJWBew==
X-Received: by 2002:a5d:4dca:0:b0:1f0:2543:e10e with SMTP id f10-20020a5d4dca000000b001f02543e10emr19388697wru.60.1647333835073;
        Tue, 15 Mar 2022 01:43:55 -0700 (PDT)
Received: from kepler.. (0526F1FC.dsl.pool.telekom.hu. [5.38.241.252])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5006000000b0020374784350sm15078503wrt.64.2022.03.15.01.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 01:43:54 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 06/15] sched/headers: Fix comment typo in kernel/sched/cpudeadline.c
Date:   Tue, 15 Mar 2022 09:42:38 +0100
Message-Id: <20220315084247.40783-7-mingo@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220315084247.40783-1-mingo@kernel.org>
References: <20220315084247.40783-1-mingo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File name changed.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/cpudeadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index ceb03d76c0cc..0e196f0de492 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *  kernel/sched/cpudl.c
+ *  kernel/sched/cpudeadline.c
  *
  *  Global CPU deadline management
  *
-- 
2.32.0

