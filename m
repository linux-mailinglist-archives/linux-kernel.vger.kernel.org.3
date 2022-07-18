Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79DD5779C0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 05:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiGRDbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 23:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGRDbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 23:31:36 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4E6DF02
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 20:31:36 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so11397823pjf.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 20:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gxsRO0ngre/s5qV9cZCyz4/oIa9KN/kzIjt87eVjDT8=;
        b=ZW2DJH6LJWwLfU3otFDA+R2+hJcTXzjEzanWBQi3SNf9OtgclKQ9Lcskr3TimMn40y
         ZyG5waqlQGyEgk+rL4vsc/Hf2pJIUY/ArpHusipj0RsrJKiMFgqzGtcVBgQ0dA628jKU
         4gwIIEuemwc49jIIwkL8iviDR1aVcDgJVJo+X8/OP2mXSf8FB4M1OvzctcrbZunWKnsx
         hDy1TQtXjFkpQbpiSM1teTveXC+LPjMlSgBw5dxrLSusFUhR5D1DBmskWBAmugUhYXln
         BUYBMey9FpPhE4bVxosD7yR1oxrPHJRnmqx/+84pEsXpFHO1leG2eH18Mw2jzHTV5656
         2eOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gxsRO0ngre/s5qV9cZCyz4/oIa9KN/kzIjt87eVjDT8=;
        b=omqYEHCULzdWW6pxD4VpPcPKo1V4eCRb9CR1e8+iP+iJkKrPWvmkqVKvADZxC+UIZw
         WwrwuWDP52SsglK2d/uwr6h8PQxHdWXolP66zgZ5jHKFwlL1rdyLQrpgJBgNyuXn87RR
         YBWX/oHhswtUBnngY7+8OdgEGrLTBS4Rq3WU378M6xwA0kecD+BvLIGdyd41JyeHaeQO
         5iU+lMhexU7cktbsNSp6yUQdYVTzccRrfiLNQRriaomDS2DWMfJt2AzScLGKMdn1Uahw
         qsdJFbCljbYfG0TBkK/zSUPpl8qbeR25mpwIVxCwpzmhTULpyyIsyzIJ04jzugpG0UAE
         9imA==
X-Gm-Message-State: AJIora+cGISSyB2OK81JBO7wX87sRDMD27Zs3tBy5oHNjcHgUnjBxd8I
        ERhqIjNf2F8BN/j6k0nA92I=
X-Google-Smtp-Source: AGRyM1ue50DGSdWhrau5aIcTUlkVONKZFxG4AkbLeM4hjyBkYC79TiJBBzqEqDDzUxS1arlNZd7n6Q==
X-Received: by 2002:a17:903:4094:b0:16b:df0e:6312 with SMTP id z20-20020a170903409400b0016bdf0e6312mr27548746plc.61.1658115095731;
        Sun, 17 Jul 2022 20:31:35 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.252])
        by smtp.gmail.com with ESMTPSA id g19-20020a170902d1d300b0016c57657977sm7999221plb.41.2022.07.17.20.31.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jul 2022 20:31:35 -0700 (PDT)
From:   qixiaoyu1 <qxy65535@gmail.com>
X-Google-Original-From: qixiaoyu1 <qixiaoyu1@xiaomi.com>
To:     chao@kernel.org, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, qixiaoyu1 <qixiaoyu1@xiaomi.com>
Subject: [PATCH] f2fs: don't bother wait_ms by foreground gc
Date:   Mon, 18 Jul 2022 11:28:40 +0800
Message-Id: <20220718032840.9653-1-qixiaoyu1@xiaomi.com>
X-Mailer: git-send-email 2.36.1
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
 fs/f2fs/gc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index d5fb426e0747..cb8ca992d986 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -150,8 +150,12 @@ static int gc_thread_func(void *data)
 		gc_control.nr_free_secs = foreground ? 1 : 0;
 
 		/* if return value is not zero, no victim was selected */
-		if (f2fs_gc(sbi, &gc_control))
-			wait_ms = gc_th->no_gc_sleep_time;
+		if (f2fs_gc(sbi, &gc_control)) {
+			/* don't bother wait_ms by foreground gc */
+			if (!foreground) {
+				wait_ms = gc_th->no_gc_sleep_time;
+			}
+		}
 
 		if (foreground)
 			wake_up_all(&gc_th->fggc_wq);
-- 
2.36.1

