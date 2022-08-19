Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BE45996D1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347515AbiHSINh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347510AbiHSINe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:13:34 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FF86443
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:13:25 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r22so3176224pgm.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=fPToMqh2PC6q+/4RIT1aoL+kuNjLhCRDON7srvELrKg=;
        b=JAQfTa8JoL9dHU/otH5ilK5CNbtwAUBUVZnqifirl/oFxX+aJ3lbvlpOonxvWyTljG
         R/Mxs5BJhiSJjKPgBlsqKxJVqZq7M9fAV/5YGjJjyEwwyXeukDaYg0+YU0CujSOc2rvK
         htSgKUO9rQDZ52j4L/aQPOSJ23Xmo0dII1uf9UHCddbOsn+2H2kUoOoWj3blUT8+Tq0+
         iyAN7zTCQyAEAISlzsHFRz7SV1Keu4heGzi/cIrobz6txwUmuBZ7pASw57ZtkmYNEnma
         hmanuqQj0PCkQed8Bg6zDhkyYQJL/tHYDOjIq/mlmOWc63EhBalM2sCNcK5za3Yhgn1e
         wJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=fPToMqh2PC6q+/4RIT1aoL+kuNjLhCRDON7srvELrKg=;
        b=XTZmLr0ryu3v07RJs7JRrf29WSZkRD8f3l8/ALNE+Pm6Wtv30Ck0ZsV+8aS+JgvIr5
         VhX+0SRkl/5olOYh/8O/w17lc0sLmFWUGXpvgIBP1nfyQOIX58ie0szE23huas7U7vUB
         U/F7TjgjXCYCzCeypub+0fNqz3Nv0Qi268+UegcjQ7gvSdlEkj/yJtoQJN/NgUXJv2B4
         MymY/HwhqV1C0uU0B9qy7511KfSZOFNvueT9jJpeNSmxvWx/0wcA/KgHauMbnqCTkz0A
         qLwx86p0iSnbfdVDaEhO8I7OTB6x5Nr3kqGYHO7NqXJjzKIquPJHD7/EAwcQwNBz47+v
         XqsQ==
X-Gm-Message-State: ACgBeo2J7OHnoURyEBHOxxxq07j7o1wgzeMe4cBFP2x/Xrepc9vhPWpm
        OAtGPP4PSZnI2pdBQU1xz94=
X-Google-Smtp-Source: AA6agR4rOijAF6u/5vKoz7j27rJTBdPaQyfEdTqSTOUHSxycI4sV9jQZhrD40MtDcHIzYISBJLF0QQ==
X-Received: by 2002:a63:2a90:0:b0:41d:95d7:9851 with SMTP id q138-20020a632a90000000b0041d95d79851mr5351659pgq.564.1660896805266;
        Fri, 19 Aug 2022 01:13:25 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id jj9-20020a170903048900b0016d785ef6d2sm2580203plb.223.2022.08.19.01.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:13:24 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     hch@infradead.org
Cc:     linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] sysv: delete unnecessary checks before brelse()
Date:   Fri, 19 Aug 2022 08:13:20 +0000
Message-Id: <20220819081320.96141-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

The brelse() function tests whether its argument is NULL
and then returns immediately.
Thus remove the tests which are not needed around the shown calls.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 fs/sysv/balloc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/sysv/balloc.c b/fs/sysv/balloc.c
index 0e69dbdf7277..dd7fdc728ba7 100644
--- a/fs/sysv/balloc.c
+++ b/fs/sysv/balloc.c
@@ -195,8 +195,7 @@ unsigned long sysv_count_free_blocks(struct super_block * sb)
 			break;
 
 		block = fs32_to_cpu(sbi, zone);
-		if (bh)
-			brelse(bh);
+		brelse(bh);
 
 		if (block < sbi->s_firstdatazone || block >= sbi->s_nzones)
 			goto Einval;
@@ -207,8 +206,7 @@ unsigned long sysv_count_free_blocks(struct super_block * sb)
 		n = fs16_to_cpu(sbi, *(__fs16*)bh->b_data);
 		blocks = get_chunk(sb, bh);
 	}
-	if (bh)
-		brelse(bh);
+	brelse(bh);
 	if (count != sb_count)
 		goto Ecount;
 done:
@@ -224,8 +222,7 @@ unsigned long sysv_count_free_blocks(struct super_block * sb)
 	goto trust_sb;
 E2big:
 	printk("sysv_count_free_blocks: >flc_size entries in free-list block\n");
-	if (bh)
-		brelse(bh);
+	brelse(bh);
 trust_sb:
 	count = sb_count;
 	goto done;
-- 
2.25.1
