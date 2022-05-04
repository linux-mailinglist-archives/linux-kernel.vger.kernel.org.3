Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B43B5192C5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 02:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244624AbiEDA2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 20:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244615AbiEDA2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 20:28:32 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A42E4339D
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 17:24:59 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id h3so10214435qtn.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 17:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BXKwANX9smJAfYSvt1T0VUO54zua3SqRupnCifAoDtA=;
        b=TqYuhMgCmiN66eY32dsXpgZIT4PLiwZGBx3dKBOmXLNCO4y184UCJ/beks6mCVrHDT
         /8LZdDRGnKX6Wh9P8rfbrtm5I7gqUzhSi2VAHJdg4d1UFmvomPPiVLI4rM07g3IHLk2K
         M+Chnnz9dMZIJEFeyiLNMw4kHf79y14fSSk9G8B0VTRAr+rpCDTUc30rFW1njJwd6+vF
         dCoFSnzxgvG28ZYNLZxBOo2QfFjvLVzRGKA+ikSwkFCKq1FIAdnwjkISZNQdHRBzFnNy
         jZyKMRcH5jJKKnJMVGIG/WTrWVzJRUorsJmJ+lw7hxIUvu+Nu+LGTDCg0DLH0Ze5oVaw
         lxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BXKwANX9smJAfYSvt1T0VUO54zua3SqRupnCifAoDtA=;
        b=Qo0myX7GCzY0o1ls4HRaP1aPmExmaRY6bQ7F9R/FpxYAJACsqNIwj1HmFRSmn79Rt+
         nqcataR0FYb015wRX0F7NsuZRqhYj3FEp2jbYwKOQ/SpWUMPObFWDoAfckt5PIDqY0gN
         KbNG+kaUPyUQH2ByMryhvQneyHN8o84dEyyJY7mxqLdWZm5QfQZjCSEEVmITLFbU0dsN
         1ZcBvDXyoAPswi3HUdBDrzBZWj9lpCCZCfPtzcz20uuGnGovHei8DpBrzp/tDnZMn2vG
         if7mG8b85l0E00rdQTTs/SMv7FYb4FIKumIQlYDdEX6+woHXTm5o0xf+1r/Sn0v4fqIZ
         SdgQ==
X-Gm-Message-State: AOAM533kEOpcAKsV7PcstBIiaW1jAsacDwZkT7LncVgw0DMJGovzE/kb
        hJ7AReLf4c3dQr/eK8HpxywL3OKeCBhByQ==
X-Google-Smtp-Source: ABdhPJyblDlpqLbyxuviA+1St8zyRhH8rLqGloGH75Eoiy3CNRsix2RXLc6kUbzeSBbN+FetBeGryQ==
X-Received: by 2002:ac8:7f8a:0:b0:2f3:a31e:810 with SMTP id z10-20020ac87f8a000000b002f3a31e0810mr12546589qtj.95.1651623898317;
        Tue, 03 May 2022 17:24:58 -0700 (PDT)
Received: from localhost.localdomain ([66.63.167.151])
        by smtp.gmail.com with ESMTPSA id e188-20020a37b5c5000000b0069fc13ce225sm5966358qkf.86.2022.05.03.17.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 17:24:55 -0700 (PDT)
From:   Forest Crossman <cyrozap@gmail.com>
To:     C.Emde@osadl.org, corbet@lwn.net
Cc:     Forest Crossman <cyrozap@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tools/edid: Only include the .data section in the raw binary output
Date:   Tue,  3 May 2022 19:24:43 -0500
Message-Id: <20220504002444.114011-1-cyrozap@gmail.com>
X-Mailer: git-send-email 2.36.0
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

I don't know at what point this changed, but with gcc 11.2.0 and
binutils 2.38, if we don't restrict what sections are output to the raw
binary, the ".note.gnu.property" section in the object file will be
written into the first 48 bytes of the EDID, rendering it unusable.

To fix this, limit the binary output to the ".data" section.

Signed-off-by: Forest Crossman <cyrozap@gmail.com>
---
 tools/edid/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/edid/Makefile b/tools/edid/Makefile
index 85a927dfab02..b62bfd925348 100644
--- a/tools/edid/Makefile
+++ b/tools/edid/Makefile
@@ -16,7 +16,7 @@ clean:
 	@cc -c $^
 
 %.bin.nocrc:	%.o
-	@objcopy -Obinary $^ $@
+	@objcopy -j.data -Obinary $^ $@
 
 %.crc:	%.bin.nocrc
 	@list=$$(for i in `seq 1 127`; do head -c$$i $^ | tail -c1 \
@@ -27,10 +27,10 @@ clean:
 	@cc -c -DCRC="$$(cat $*.crc)" -o $@ $*.S
 
 %.bin:	%.p
-	@objcopy -Obinary $^ $@
+	@objcopy -j.data -Obinary $^ $@
 
 %.bin.ihex:	%.p
-	@objcopy -Oihex $^ $@
+	@objcopy -j.data -Oihex $^ $@
 	@dos2unix $@ 2>/dev/null
 
 %.c:	%.bin
-- 
2.36.0

