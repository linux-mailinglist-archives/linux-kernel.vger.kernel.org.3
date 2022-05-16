Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12DC52822D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiEPKd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238526AbiEPKdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:33:47 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBE61C912
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:33:45 -0700 (PDT)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 181433F32D
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1652697223;
        bh=TUibuYqafZinFeGpIWxhluJu+JS1ezOTLiTJU5+HIcw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=X0r3/+eYktM99g4TBpwyQzNVctB1jyt/CTEbYjUI9NbgA9tZdj13e+geAbS0MCTh4
         M4A5pzuSSbm7eZS/QVb/squwCFttFKQGtUBUop59aFsG1Zzgj54PdfgowXlG3of5VM
         I5xxb2dXF6GsqnVmryI5rF1jNoE9sGrNp39/2JUHCDjV/xV9iZw21kypfKnrcvdd4B
         OXQFvctLP9UkCn+/+VjTmJw3aBqBGEbwtXqMLs2krn9TZHnKZyjmkp978y39d/MLm4
         SM4NGWD3frtLeIGUJCae41Bat7aGJ7qdeCap5lf10+T5w4eHqYE/R7CVAaAnii6z5p
         3JYuVhmgIU9Gg==
Received: by mail-wr1-f71.google.com with SMTP id u26-20020adfb21a000000b0020ac48a9aa4so3799960wra.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TUibuYqafZinFeGpIWxhluJu+JS1ezOTLiTJU5+HIcw=;
        b=ZzXtZBQxi40ARKjOhrKF1RC5ihix0NBPHuA9gRxArAiS89oxfnbFPLF1r4jDiO+pgk
         BzdWR+csYfumx4BpgSd02foBQD2RfNA8tHKWzLYhOM/yKsTJdm6ZQJcTmmDbihRpG0NQ
         vQ9vfSNotklAIVr0KoGr+EHm86+DF6wqNtiLomobd76GqosAFlcRyuqhkI5PrG19aJ1G
         +lAdFOQjPMTbkOfIGxU7rMzwXkMYhZkcEF5sj3CiP/ro3w/OSoNN/G/jQYaU8igqqP5p
         CbCBabipRxLVQsF4BBhcq6+/Em6wpqGq4sCNem93xFkpHBOKD97toTGfZB2fg8yHV9iE
         +cTQ==
X-Gm-Message-State: AOAM530vNyej0ncf/oouy1pm3GSC3ot4IIvJmLHqJ2eXG04JwkDZYFJM
        Wy98MfhwsAwbvs25l9lj21VFAhpZ8iDAaK/AkjjBOhj/qLdn7sFj2zTu4SsBlr99nhBHPsNOPuu
        Hndz7jnwJsMbM/3O3lG38McRNffX8vS05xhtHUBuhYQ==
X-Received: by 2002:a7b:cb86:0:b0:394:5d8c:2e7f with SMTP id m6-20020a7bcb86000000b003945d8c2e7fmr9436172wmi.12.1652697222606;
        Mon, 16 May 2022 03:33:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkcXelD3dwbQ8Cwohp0cha7dw/NgqjzbvQwTaNhAl5joQ1Ktb75rro6N/OaCwW4Q3YxhlciQ==
X-Received: by 2002:a7b:cb86:0:b0:394:5d8c:2e7f with SMTP id m6-20020a7bcb86000000b003945d8c2e7fmr9436159wmi.12.1652697222385;
        Mon, 16 May 2022 03:33:42 -0700 (PDT)
Received: from localhost ([2a01:4b00:85fd:d700:83e2:e0d8:37ed:a918])
        by smtp.gmail.com with ESMTPSA id a4-20020a05600c348400b003942a244ec4sm9810296wmq.9.2022.05.16.03.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 03:33:41 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btintel: Correctly declare all module firmware files
Date:   Mon, 16 May 2022 11:33:29 +0100
Message-Id: <20220516103329.516952-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Strictly encode patterns of supported hw_variants of firmware files
the kernel driver supports requesting. This now includes many missing
and previously undeclared module firmware files for 0x07, 0x08,
0x11-0x14 hw_variants.

This especially affects environments that only install firmware files
declared and referenced by the kernel modules. In such environments,
only the declared firmware files are copied resulting in most Intel
Bluetooth devices not working. I.e. host-only dracut-install initrds,
or Ubuntu Core kernel snaps.

BugLink: https://bugs.launchpad.net/bugs/1970819
Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---

 Changes since v1:
 - encode strict patterns of supported firmware files for each of the
   supported hw_variant generations.

 v1 submission link
  https://lore.kernel.org/linux-bluetooth/20220509163259.1513242-1-dimitri.ledkov@canonical.com/

 drivers/bluetooth/btintel.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 06514ed66022..17022758b5bd 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2654,7 +2654,22 @@ MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
-MODULE_FIRMWARE("intel/ibt-11-5.sfi");
-MODULE_FIRMWARE("intel/ibt-11-5.ddc");
-MODULE_FIRMWARE("intel/ibt-12-16.sfi");
-MODULE_FIRMWARE("intel/ibt-12-16.ddc");
+/* hw_variant 0x07 0x08 */
+MODULE_FIRMWARE("intel/ibt-hw-37.7.*-fw-*.*.*.*.*.bseq");
+MODULE_FIRMWARE("intel/ibt-hw-37.7.bseq");
+MODULE_FIRMWARE("intel/ibt-hw-37.8.*-fw-*.*.*.*.*.bseq");
+MODULE_FIRMWARE("intel/ibt-hw-37.8.bseq");
+/* hw_variant 0x0b 0x0c */
+MODULE_FIRMWARE("intel/ibt-11-*.sfi");
+MODULE_FIRMWARE("intel/ibt-12-*.sfi");
+MODULE_FIRMWARE("intel/ibt-11-*.ddc");
+MODULE_FIRMWARE("intel/ibt-12-*.ddc");
+/* hw_variant 0x11 0x12 0x13 0x14 */
+MODULE_FIRMWARE("intel/ibt-17-*-*.sfi");
+MODULE_FIRMWARE("intel/ibt-18-*-*.sfi");
+MODULE_FIRMWARE("intel/ibt-19-*-*.sfi");
+MODULE_FIRMWARE("intel/ibt-20-*-*.sfi");
+MODULE_FIRMWARE("intel/ibt-17-*-*.ddc");
+MODULE_FIRMWARE("intel/ibt-18-*-*.ddc");
+MODULE_FIRMWARE("intel/ibt-19-*-*.ddc");
+MODULE_FIRMWARE("intel/ibt-20-*-*.ddc");
-- 
2.32.0

