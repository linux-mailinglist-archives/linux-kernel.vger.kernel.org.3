Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF635AC1B3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 01:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiICXKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 19:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiICXKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 19:10:51 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14CA4BA5A;
        Sat,  3 Sep 2022 16:10:49 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id b144so555704pfb.7;
        Sat, 03 Sep 2022 16:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=MTRyQeNwNmtbjly6m0NqygvjI275gpJb7kZzL+rHJ2w=;
        b=EMCanUpSg48ofcHvYZZ62AUtfn3jLg9Ld74CDzZ6h3O5ErCHFO9JkPi3I4re9fj7J7
         DsdhthaD2uz1iuZxz14zaFQQIUb5+pMyZrePU7gU1wvTrknnmvEG1VjZ2gidt8p95nna
         IYyCdMjMgoYinVgnLybtZaMbTLWOpGU1lfqYb2hlZ42/VyixOgOnk17eQhHPT5SkGn+A
         2Rm9lx20CsgVdenw3Snqbvv+X/Z94FZs90FU0Lncuo+bY5J4vUrTa2Gt6NbX0XPEXO75
         zktj3I11VeSP1HXRZyf8UDtf3vztuwoswpPNmVRrkk2RvpRkBRDHbxSJzcQH+a1+JhzO
         b29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=MTRyQeNwNmtbjly6m0NqygvjI275gpJb7kZzL+rHJ2w=;
        b=2objGE4+Vdx5K7LzipMSKxKTW9w5rCQGl3lHkuGQHo1a8EUGk098l87HFBD3PzMR2v
         5MPSPGAR9ZgXX8GlvrxYeZFpJGMcmmeYMMinmKA/70jXpVLMV1HNiROfWJHUwv0A3w1L
         0n9Qw5eqixm/72la+atux1UnszpbkjCnSCVzjAlKeKj3d/HWC67tjuxU339MU1EKvtPk
         8k7iqcysCypsp6yPh0Szw9UUq2yBg4n6fTuil+crSJd0xUSfg6BZPRzhehHwPIk56fCf
         wSfJF8rDcgu3uVbdY0NNMSg4SGCHrdMFSQqqD1swWotntoVvLSK44QHiUKOuDoNF7gXg
         BT0g==
X-Gm-Message-State: ACgBeo3BdhTt9bricV7Lwk2REFhFjApEkZylhe9nf+RfRubik1yKvF8z
        q9ZVIyFeTfyI8xofUX2lZ84LJeFpH+S7sQ==
X-Google-Smtp-Source: AA6agR45+pXNZR02/7Cfkl6KEYX/PdbuySpk+wI7mEklSiLX0ZR7hqbJmHg/4RP9mo6g3U0/QhYx2w==
X-Received: by 2002:a05:6a00:ac6:b0:530:3197:48b6 with SMTP id c6-20020a056a000ac600b00530319748b6mr43260583pfl.80.1662246649085;
        Sat, 03 Sep 2022 16:10:49 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id 26-20020a630d5a000000b00434272fe870sm934390pgn.88.2022.09.03.16.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 16:10:48 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc:     damien.lemoal@opensource.wdc.com,
        Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v2] ata: libata-core: Check errors in sata_print_link_status()
Date:   Sat,  3 Sep 2022 16:10:39 -0700
Message-Id: <20220903231039.2278817-1-floridsleeves@gmail.com>
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

sata_scr_read() could return negative error code on failure. Check the
return value when reading the control register.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 drivers/ata/libata-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 826d41f341e4..ae08c7d35cb0 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3021,7 +3021,8 @@ static void sata_print_link_status(struct ata_link *link)
 
 	if (sata_scr_read(link, SCR_STATUS, &sstatus))
 		return;
-	sata_scr_read(link, SCR_CONTROL, &scontrol);
+	if (sata_scr_read(link, SCR_CONTROL, &scontrol))
+		return;
 
 	if (ata_phys_link_online(link)) {
 		tmp = (sstatus >> 4) & 0xf;
-- 
2.25.1

