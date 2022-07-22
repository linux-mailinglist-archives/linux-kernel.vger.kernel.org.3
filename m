Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BDE57D90B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 05:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiGVDj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 23:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGVDj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 23:39:57 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DC293C25
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 20:39:56 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ku18so3322514pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 20:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8yiAGQE/qJl8oC8JosxyZbmVIi6xV2flByC1cOQGIuU=;
        b=M/1VvF4Ovd3iUN9CD4ktumZWJBlRtuhjKyq7qK0unIRNyFWx3tDBXTXtae335GAtS8
         XwkhcrSYXnCF8yLLoPPT4JgaCfF5fvh6xMXo9lGikywR8Xm1kACabRtoBOYTVONilm4i
         F9BVEI+pO50C8U4ED/tLtWxWDDkt3qGLm2GzzRRXhZ31TiwuY9rg+OPCzgRYz86JhUFO
         w99TXH+xKUvAN8d5WqozvZrvsGIuX1+K0/8Wl8jCo9Y/H/e2VEHJ7afiwVSUGFTAVQOA
         OM/pnamG8KOGBkuIn2G/f7ajo7sMhc6woBc6kIin2EOYjOrWSl/F77ebceHxLGk4ylSZ
         XgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8yiAGQE/qJl8oC8JosxyZbmVIi6xV2flByC1cOQGIuU=;
        b=Dyq0nadYQ27Tp12oZBAWEpEIafLoHZ/AsdUua7KJA7VFFT7UxMmb7SX1iNCxD/XZlO
         tSaOCdUl+7yq2enqEXsajw9nHSdhGRfQKCw5IsSIGty3hdQqwWEs7zhd9e1oObEGnjTQ
         UvoSsXWNgjEqy8cPN2yKNp7zap63ILunOqLy2eqlaz9oyxSMS7a5CZv8GdJKlakfFJjF
         B1lz9L0hJT4NwOKTtwKYhepINfFBaJfYEZuQF0GaXI1LHu5a3ke4gpS5FLRCtOmUiKON
         aOsneh2+Qu9Y8uzB6+9/IAVEa86sY+iin+LRCQYbaPPO0YGnvmOdSBpw/DZLRMVat5Nz
         qJSQ==
X-Gm-Message-State: AJIora8yxBhWqkDn9c0Y+fnsHWtLX0MBkC3qUn2CtASpq4iYo3lNrWs0
        1+bFaX0QW6vk70/34EkKnDQ=
X-Google-Smtp-Source: AGRyM1sAz4kl6alB174O+R5oWH69AtL/ImQve7dAQ5sAXtF4urr2AU4MlHxt7rSxHSTLq78PnudYlw==
X-Received: by 2002:a17:902:8a94:b0:16d:400a:797 with SMTP id p20-20020a1709028a9400b0016d400a0797mr1171146plo.174.1658461195601;
        Thu, 21 Jul 2022 20:39:55 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.252])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f54400b0016be8da658fsm2508311plf.130.2022.07.21.20.39.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jul 2022 20:39:55 -0700 (PDT)
From:   qixiaoyu1 <qxy65535@gmail.com>
X-Google-Original-From: qixiaoyu1 <qixiaoyu1@xiaomi.com>
To:     jaegeuk@kernel.org
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, qixiaoyu1@xiaomi.com,
        qxy65535@gmail.com
Subject: [PATCH v2] f2fs: don't bother wait_ms by foreground gc
Date:   Fri, 22 Jul 2022 11:39:10 +0800
Message-Id: <20220722033910.25442-1-qixiaoyu1@xiaomi.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <YtoOGu/wyqKBJd1v@google.com>
References: <YtoOGu/wyqKBJd1v@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs_gc returns -EINVAL via f2fs_balance_fs when there is enough free
secs after write checkpoint, but with gc_merge enabled, it will cause
the sleep time of gc thread to be set to no_gc_sleep_time even if there
are many dirty segments can be selected.

Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
---
 fs/f2fs/gc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index d5fb426e0747..e2f8a2dae908 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -150,8 +150,11 @@ static int gc_thread_func(void *data)
 		gc_control.nr_free_secs = foreground ? 1 : 0;
 
 		/* if return value is not zero, no victim was selected */
-		if (f2fs_gc(sbi, &gc_control))
-			wait_ms = gc_th->no_gc_sleep_time;
+		if (f2fs_gc(sbi, &gc_control)) {
+			/* don't bother wait_ms by foreground gc */
+			if (!foreground)
+				wait_ms = gc_th->no_gc_sleep_time;
+		}
 
 		if (foreground)
 			wake_up_all(&gc_th->fggc_wq);
-- 
2.36.1

