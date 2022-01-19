Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5DC49410D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357132AbiASTl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 14:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357135AbiASTlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:41:24 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF95C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 11:41:24 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id n16-20020a17090a091000b001b46196d572so3584206pjn.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 11:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=Be7Cm0n+n8HNt/Mpjjw9TGmfe8Nlv6EQrvqvRZvGl/M=;
        b=YOgdwtUIAM/u3XgauPcto57FqA5Ps1loGCHL9DWKvMtl1qLekv6LLc4Ll1hC1G5V4c
         5WWQ4MsceyJDP+BgQ3ZT9BTSCm9r/RKzIcHdWHg80sVKr2ShsrtbAvvRFBRt+j8xZSBQ
         omqDvTR17qcsP0j8CIGtaKCWPYgNbuOH6okihcr8dJFD/lGj5BwhwsWdIKb05YVkQwsJ
         fLayXsdVUTOlIFob9eLVF0vFSqMm9lANoZ+VmM9u4eiF26OQyDVr8zzbmdpNaEn4OaaM
         YhS7Lkz4P6RfUIJyHCmoSR1fwqn7d0ZCFLuxyfbE+E/ce8XZX/c2KyWgsEp3uYdja2zW
         FM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=Be7Cm0n+n8HNt/Mpjjw9TGmfe8Nlv6EQrvqvRZvGl/M=;
        b=kUmyZfsjM49vJV9fT7dW8KBK6h5ws12R8R2eGl8S6mkb48PTBX9FEl//W49jcF3wef
         t5zo7iC1+2bI2XJj2itx/sXFJ8XqAzZu1GYml5WY1oF2grkGAV8z9VCtlYKzy0bfqlGE
         /qbjXrwIVJfWyTuS9yc3wCvfTfcbJ8TDBr5y3qbR+BXE5b4ADDDNS3baFFMb6DhquDmA
         KJSHrNXjlQs+Y72WNuwRcDackZ7lBvGEL6KYElo3VXfq1H/LX80+Bkjk2GSJzK63xlFw
         xMlUt9KSDf4AJqFR19LIDPnhFjV2Z3z6Vyhf8xuwsLCAO3EWu2ElcvsokRR47RvrvjPC
         DjMw==
X-Gm-Message-State: AOAM532botKK+opF+K6srGogbUVYxPve3UE0jv4mM81QuzvAFJ5s4CUn
        9uaLqHqc64Wa38CmznUMoLG8bA==
X-Google-Smtp-Source: ABdhPJyi+LG876A4ka/vDXnkG2CKCQWt3/k45qvbs3eidfCuhbzkuKD24R0jMcsVRWaEdZcYxH3Qnw==
X-Received: by 2002:a17:902:e851:b0:14a:6763:b580 with SMTP id t17-20020a170902e85100b0014a6763b580mr33822833plg.171.1642621284321;
        Wed, 19 Jan 2022 11:41:24 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id s23sm440737pfg.144.2022.01.19.11.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 11:41:23 -0800 (PST)
Subject: [PATCH] perf_events: sysctl: Avoid unused one_thousand definition
Date:   Wed, 19 Jan 2022 11:40:19 -0800
Message-Id: <20220119194019.27703-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     mcgrof@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     keescook@chromium.org, yzaikin@google.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

The variable "one_thousand" is only used under CONFIG_PERF_EVENTS=y, but
is unconditionally defined.  This can fire a warning.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

---

I went with an #ifdef instead of a __maybe_unused because that's what
the other code is using, and I left the one_thousand in order despite
that requiring another #ifdef.
---
 kernel/sysctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ef77be575d87..81a6f2d47f77 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -122,7 +122,9 @@ static unsigned long one_ul = 1;
 static unsigned long long_max = LONG_MAX;
 static int one_hundred = 100;
 static int two_hundred = 200;
+#ifdef CONFIG_PERF_EVENTS
 static int one_thousand = 1000;
+#endif
 static int three_thousand = 3000;
 #ifdef CONFIG_PRINTK
 static int ten_thousand = 10000;
-- 
2.32.0

