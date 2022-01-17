Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA3348FFE9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 02:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236680AbiAQBXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 20:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbiAQBXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 20:23:23 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23F7C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 17:23:22 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g7-20020a25bdc7000000b00611c616bc76so21063357ybk.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 17:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zGaYVdXkM9nXVR2aJfZ0FkDzKWqSmGNmNFUOz1dK4BY=;
        b=ldQDPwl14BUn1yS+wNp5UbaiDzPTZUwPo5iZXGKfWSVAtJ8uaOev4GiH6cVJnaJYon
         aC+ZSaTQFULZSvCF5ozqRuSj67k2gY3zZ8vDnYzugffs7LHZVBH9He0UBLIxH5Ul3P2T
         WSqVzd23hf8+j3E8lG6cjSfoDzGOtFZB4ks0LbKwfICIwkKOCNThD3/7kOniLDDKc2DX
         Xg9U0cGcNvSFqWIPBzebB6k5ueCINpUgygkNnxQjZ0d2b/bKbWx19Ga8GuW8o/0J68J0
         PwdAxW9Sxp5i1HUmZaEemKfJJAhLvjOD/EB2HI9xu6L4j8sXiRmaECRQVFKS6vHmq9x+
         tAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zGaYVdXkM9nXVR2aJfZ0FkDzKWqSmGNmNFUOz1dK4BY=;
        b=BeunAc9PyhD3giWI7f9O3saOMxsaUyL5P6j47dwAKPZZ6E13WRBWGFpq2m0wwVLg23
         569xbiZWDpibKlQMpwsnSjRi5hzvZ2ZuzzEl0VTKG42OCY9S/hk9lfO3Cr55isWjGjrX
         h7YQJHjzgIt6Iv3JcEXWKVFl/nnF2zP5kWjqDwuUN9yJAK/SRZXRJYZ0UmU69phx1Xa2
         9GQABvs9B6QlrtALZy3A174NfRKAzaisKOBJEnKR3rA3Ck2iQE1YmZtyJt07qa1VAhQt
         KxoRI1XWyfF7tANVbFzW0Lb2noaX48JsBTaTmHFLXVO/cHth/bebpWqnshJ62nFJg9K0
         +DiA==
X-Gm-Message-State: AOAM5321hTFHI7A1SUKDr/TfyQppnj3n6MyEloigEHCKKIdgWYh1/MEu
        pZh9x1zYTBX/ifGOks2tOokNJ7gZEg8=
X-Google-Smtp-Source: ABdhPJyPoKDIHPPSJ5nfJiL8DU2Iaz9WnnE3eE9ejq5NYFPHpMerXqKF3PDFdMaN8faC2LZUgz609t8D/Nw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:d5fd:2339:f71:ffa3])
 (user=surenb job=sendgmr) by 2002:a25:fd6:: with SMTP id 205mr24462734ybp.654.1642382601368;
 Sun, 16 Jan 2022 17:23:21 -0800 (PST)
Date:   Sun, 16 Jan 2022 17:23:17 -0800
Message-Id: <20220117012317.21168-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH 1/1] sysctl: Fix 'one_thousand' defined but not used warning
From:   Suren Baghdasaryan <surenb@google.com>
To:     sfr@canb.auug.org.au
Cc:     akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning issued when CONFIG_PERF_EVENTS is not
defined:

kernel/sysctl.c:125:12: warning: 'one_thousand' defined but not used [-Wunused-variable]

Fixes: 39c65a94cd96 ("mm/pagealloc: sysctl: change watermark_scale_factor max limit to 30%")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
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
2.34.1.703.g22d0c6ccf7-goog

