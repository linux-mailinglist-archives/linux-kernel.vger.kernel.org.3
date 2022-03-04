Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F834CD48D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiCDMza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiCDMz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:55:28 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B09CE8695
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 04:54:39 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 5so12050308lfz.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 04:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VRhT9ifLMxDJ5IabGicl6XqHaEU8Ks5ZJGYgqwJqGwA=;
        b=hDPAhA8repavaxUJtbdf4L32y02IDzMELyfpe9MaQUdmm6gBI17FLk6fxNh4iIVADX
         F6O9vVw3Iy75iGQOHdk8Hy7EAOmpEUcy9Fcx00LiTuRY5pZE6tOqbA0gk896G7ppbzDf
         w4/OsdLuMKmbsGHwUebT/OYznI7Pf5KLVnAFICpSf7p/Ecrw9qUfFCmjsZoQZqloKZmk
         eOkxQOrvPVIDnj5SKNPD91A1XlK8uQDz7oo+zKEAq81+BFKmjO7NsswAF4c4+M139NUy
         57DyjZLTMeq4V7njp1B/ijbjxkXH6d3kvW1OMiQKxhFUH43Gh6tP+P7XmP4zZmiOBYpH
         eECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VRhT9ifLMxDJ5IabGicl6XqHaEU8Ks5ZJGYgqwJqGwA=;
        b=r+o6NeUn0340la6xnBDV37zUSY+AGrA5R/ccYAJVvGuFQNEdzp5fFVSUyTMR7MlBRa
         CultT6UvRLXIRZ1tJ2lAj4fcXn8ThV85vIPskFDOKI+BOjtEEwbNTQiRZL3KwhTdGkJg
         uZ1epnd1cavnaX3G5Vy8BBDaivLX2NyeGTI8/7XrXQT5newzbYUlpIgRNWpm5cYmOqBC
         lfwELTm1/zZ7PtFvqL68Ef9EXYT3zTXNWzokrqHY9ZOcJDlOfkgV/QFHnMlYMQdhOh90
         XHNSKL6VDU3+VLXC8teIAYSClznu+QNMomp5lMxRbqCk6ABshtIn240fyvVJPhVAPfux
         xCvg==
X-Gm-Message-State: AOAM530ZdvHt0nl6o8RpRScK2vjlNs+kMK+NuJ8HlEL2KuPkslr+Agox
        Pb5+z2OU+9AXKYH1pc9ZL+jZ2QrJuPI=
X-Google-Smtp-Source: ABdhPJw3S6r+dScC0Fu+hyur/qZyKZLixrkUWXfCapeEbuhXrL+ZJTxly+pZmnsfiDT9twfTmIzdkg==
X-Received: by 2002:a05:6512:22c8:b0:447:fb92:ded3 with SMTP id g8-20020a05651222c800b00447fb92ded3mr1853833lfu.459.1646398477752;
        Fri, 04 Mar 2022 04:54:37 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-165-244.toya.net.pl. [31.183.165.244])
        by smtp.gmail.com with ESMTPSA id w27-20020ac2599b000000b004481e254f08sm95547lfn.240.2022.03.04.04.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 04:54:37 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     rppt@kernel.org, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH] memblock tests: Fix testing with 32-bit physical addresses
Date:   Fri,  4 Mar 2022 13:52:49 +0100
Message-Id: <20220304125249.253578-1-karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Building memblock simulator on x86_64 with 32BIT_PHYS_ADDR_T=1
produces "cast to pointer from integer of different size" warnings.
Fix them by building the binary in 32-bit environment when using
32-bit physical addresses.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---

This patch is on the top of memblock/for-next.

 tools/testing/memblock/scripts/Makefile.include | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/memblock/scripts/Makefile.include b/tools/testing/memblock/scripts/Makefile.include
index 699b0d6cda07..393655310324 100644
--- a/tools/testing/memblock/scripts/Makefile.include
+++ b/tools/testing/memblock/scripts/Makefile.include
@@ -11,7 +11,9 @@ ifeq ($(MOVABLE_NODE), 1)
 	CFLAGS += -D MOVABLE_NODE
 endif

-# Use 32 bit physical addresses
+# Use 32 bit physical addresses.
+# Remember to install 32-bit version of dependencies.
 ifeq ($(32BIT_PHYS_ADDR_T), 1)
-	CFLAGS += -U CONFIG_PHYS_ADDR_T_64BIT
+	CFLAGS += -m32 -U CONFIG_PHYS_ADDR_T_64BIT
+	LDFLAGS += -m32
 endif
--
2.30.2

