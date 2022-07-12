Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816F3571E96
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbiGLPNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiGLPM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:12:59 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A505724A;
        Tue, 12 Jul 2022 08:06:07 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v12so10453581edc.10;
        Tue, 12 Jul 2022 08:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AQeDqtEy+5DeVKw7Jgay8OdRWZJPmVJw29fco3ng5Eo=;
        b=IEI9Zm7s2CF0UBCPAMZdmwo2DxHXG1xTdG8l77U6rvJbaII4BwZ2YhijiKh0/7faeZ
         1Nx1B6RztXIkZzyoxs2l/x6X4yJw01mtCASL5fWNEr0SGAT/uStCDMaLXG7vU5+3a5Ke
         qjCVgJwlAUcK6nOjebNpatDCyOSdHUV2MH7gzinVl4pDb26/50U2pk/VxlJbJXq5Xa6w
         MNucBl6793fcsDEvujhrBeg/NpEJn4MDKwRdgRANgMy8jdQq1WEU5SA40VzV4DNPCWNr
         718GgYeYzdNVRXdKonnoZZ4LcbCWn2nSu9FoILNtMTBUDsgxZvclrZZ1QSSePWiyaMvS
         4Jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AQeDqtEy+5DeVKw7Jgay8OdRWZJPmVJw29fco3ng5Eo=;
        b=ArufEd8s9OmFLJe43N5LLObzvgbggCaH78ppJp/hdQDS6s8ihS5vGckMgr/Naw5Xyr
         H4HjMSoAS/34FNTZQbOCagt8Dv8DrBymH7lYeNpHl/w4Swfzl/HJuayAnmznRHgGchzR
         hRIH4NfZ/xKlkOf+dV6PsgGx5x3dmLHjpgR5w3CCwInIb5SSUT7ZIe8okYR8SsQ6oyXw
         LjoGA5+uC9/54i5ebwShnEkACOgmxGP1Wj6USMUsy+HxxC6hRbUgToWQMNmfTJrulYem
         YAIAHT1xqeGdKb6E5wgVafcXjZLg6gF7rEX8O4dLl9RNTkr4K3Zr8ewGty9cNvIHB8dp
         4EYw==
X-Gm-Message-State: AJIora9D85t7ZZIVj1ELkYw63OdtCCPvN1wUCdG57c6KyfbsnSh1jUm6
        LlXmN/dcVTre6PvpMZKa3cFhIdodEXE=
X-Google-Smtp-Source: AGRyM1tPg3ti9n/Alp6ozRsYdrrOoGpObaCjqCjLnKehEqvtl7qmulcz2RilyhkrW1qIOaHOCrlqmA==
X-Received: by 2002:aa7:d053:0:b0:43a:a164:2c3 with SMTP id n19-20020aa7d053000000b0043aa16402c3mr32608721edo.333.1657638363399;
        Tue, 12 Jul 2022 08:06:03 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id i8-20020a170906a28800b0072b13fa5e4csm3926753ejz.58.2022.07.12.08.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:06:02 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] block/rq_qos: Use atomic_try_cmpxchg in atomic_inc_below
Date:   Tue, 12 Jul 2022 17:05:47 +0200
Message-Id: <20220712150547.5786-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.3
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

Use atomic_try_cmpxchg instead of atomic_cmpxchg (*ptr, old, new) == old in
atomic_inc_below. x86 CMPXCHG instruction returns success in ZF flag,
so this change saves a compare after cmpxchg (and related move instruction
in front of cmpxchg).

Also, atomic_try_cmpxchg implicitly assigns old *ptr value to "old" when
cmpxchg fails, enabling further code simplifications.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
v2: Split patch from the original big patch
---
 block/blk-rq-qos.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index d3a75693adbf..88f0fe7dcf54 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -10,16 +10,10 @@ static bool atomic_inc_below(atomic_t *v, unsigned int below)
 {
 	unsigned int cur = atomic_read(v);
 
-	for (;;) {
-		unsigned int old;
-
+	do {
 		if (cur >= below)
 			return false;
-		old = atomic_cmpxchg(v, cur, cur + 1);
-		if (old == cur)
-			break;
-		cur = old;
-	}
+	} while (!atomic_try_cmpxchg(v, &cur, cur + 1));
 
 	return true;
 }
-- 
2.35.3

