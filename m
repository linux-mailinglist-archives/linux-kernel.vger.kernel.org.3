Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3665652A456
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348454AbiEQOJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbiEQOJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:09:01 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363A23C4BC
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:09:00 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B13323F164
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1652796538;
        bh=GLFhrP4NfgvKwES0IYdhlf4jTzua4+FN2bOojDda/Ag=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=oaMfXNU3DMQ9wGy/+CdxGeYhG5pVAqWaufIciQwVnbXXlREmDMFihpSMsAnZIF0yA
         oPK9nNm4K5Epdg1zR6zms47OhSzrUGSMTFJlRuaFbRFdAPYVrBoayDe9NyTP0j81F4
         gwgtZhubUKup0DItHuRbCK2f4SE+v3G/BdD668oaLD98sYotUarvuSLhBiSoBbqKl0
         AShv9l2zWiDT1V76Ri3YOTV20VvGK+cUu58ulNdkNGoWYcLx5gUdVtWGTH+lBIhKBq
         CD01LXCUJho9KbNp9X9GyCLcV0gJQNT2+NLtnecOrqMvVOooRfk9sZZFsY3oyahHwj
         7ZYerTrv5X68w==
Received: by mail-ed1-f70.google.com with SMTP id w5-20020a056402128500b0042aa2647eb6so5503375edv.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GLFhrP4NfgvKwES0IYdhlf4jTzua4+FN2bOojDda/Ag=;
        b=mn8feezhNrYyVOwQwpHL5qP0W0EeRn+fk0UhmndKcDoVr1Yo8fSO9z9Kl67xM2GA0H
         lOSR9kN3kA4ZSY6OTUubQ34X2Vq8Ci8zBST7ITYmtm4nMxB2rDYTLiEApjw3lJLduzEH
         Uk/I06pbU07ysGexHhWR/4ggwQNu72vcrU6OGBKdfaZ5m9sVUXRboIQgcfuGC1Pua4B5
         NNvx6c0jkUHiM/6iuyIzr/eeHRgNxDYsAUiLWvXVnGqXvMPE+GXNBHwbm7idMouspUYK
         QBk0GBC7EiXFOkvZoq7i/ZArhxkIw19Hx0kt99R5PyXU3eHAwQqxAaxN0PZfZ3kFtth1
         v/TQ==
X-Gm-Message-State: AOAM5324m5ajtsbWRelsvi16m/chXEdOxaxnJjzRajqhYcq1pXYR4tSG
        QoeB4S56sYNzjGWqKPPAeoEEwH/6VE8nw2rClQiwkzg9GU1IAj6dB9fNhtFzw6+docU9ROUM69d
        +Q1pdqLYhgjAlwhiBqibVEcEM+gs1XBtpTyJjKS21sQ==
X-Received: by 2002:a50:ee18:0:b0:42a:b57c:2532 with SMTP id g24-20020a50ee18000000b0042ab57c2532mr9583519eds.169.1652796538457;
        Tue, 17 May 2022 07:08:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNn4Ob9niSyUEl6kjfeQsKqfZjbdlcECh6PVd4S8sy4qJjQVSdVyZXPiFAUZ+/rvXOQrv9uQ==
X-Received: by 2002:a50:ee18:0:b0:42a:b57c:2532 with SMTP id g24-20020a50ee18000000b0042ab57c2532mr9583496eds.169.1652796538250;
        Tue, 17 May 2022 07:08:58 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id w12-20020aa7da4c000000b0042ab649183asm2871263eds.35.2022.05.17.07.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 07:08:57 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH] docs: Kconfig: Fix help text indentation
Date:   Tue, 17 May 2022 16:08:37 +0200
Message-Id: <20220517140837.331298-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention for help text indentation seems to be a single tab followed
by two whitespaces. Do that.

While at it, remove a stray empty line.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 Documentation/Kconfig | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/Documentation/Kconfig b/Documentation/Kconfig
index e549a61f4d96..252bfc164dbd 100644
--- a/Documentation/Kconfig
+++ b/Documentation/Kconfig
@@ -1,23 +1,22 @@
 config WARN_MISSING_DOCUMENTS
-
 	bool "Warn if there's a missing documentation file"
 	depends on COMPILE_TEST
 	help
-	   It is not uncommon that a document gets renamed.
-	   This option makes the Kernel to check for missing dependencies,
-	   warning when something is missing. Works only if the Kernel
-	   is built from a git tree.
+	  It is not uncommon that a document gets renamed.
+	  This option makes the Kernel to check for missing dependencies,
+	  warning when something is missing. Works only if the Kernel
+	  is built from a git tree.
 
-	   If unsure, select 'N'.
+	  If unsure, select 'N'.
 
 config WARN_ABI_ERRORS
 	bool "Warn if there are errors at ABI files"
 	depends on COMPILE_TEST
 	help
-	   The files under Documentation/ABI should follow what's
-	   described at Documentation/ABI/README. Yet, as they're manually
-	   written, it would be possible that some of those files would
-	   have errors that would break them for being parsed by
-	   scripts/get_abi.pl. Add a check to verify them.
+	  The files under Documentation/ABI should follow what's
+	  described at Documentation/ABI/README. Yet, as they're manually
+	  written, it would be possible that some of those files would
+	  have errors that would break them for being parsed by
+	  scripts/get_abi.pl. Add a check to verify them.
 
-	   If unsure, select 'N'.
+	  If unsure, select 'N'.
-- 
2.32.0

