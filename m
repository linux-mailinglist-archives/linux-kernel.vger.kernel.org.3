Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DD74ECB3C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349634AbiC3SEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiC3SEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:04:50 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8AD39809;
        Wed, 30 Mar 2022 11:03:03 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r23so25413892edb.0;
        Wed, 30 Mar 2022 11:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I5wCqW5ZXHtB3ukWo4azcq+03QKwGlqx2VaQS5UsEKs=;
        b=NYNThXWha05atwhwjgasGoeFwWKajSGlqVm/9Fusmyx/2RmGphIaPaGBX786dUR4XF
         es+zBzRwjVQmvcJCtYT4Tph1J39eDhvYNTdBiBbOnoW8G0FO2hEww4nWn81P9xPCbj8t
         7qVwYdWiwFKP3l3WSegb3D1puGSE5Nf1F9BL4w4YFrGTiA8XHRX/nAEm9oIYxYK+m1Oa
         XXjjyIzhKkeSKvH0mr0gtegClLCmq2TbK18na5Fy959zL8bcD6x/4Uvy351+XwMWEjS+
         yayIBGQDvIbBOChoAB/CK1pB0navLNm1AJ2bJssPG6Gl1KsSZ/iqBiR7l3Q/f5dbALqw
         dV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I5wCqW5ZXHtB3ukWo4azcq+03QKwGlqx2VaQS5UsEKs=;
        b=qT+mo/dQVCraVzOlpHWDOxmvO6XpBQIWqoGHULck17JYP0XVDV+Sc8qP/c7x4qGE9r
         bqpNvJCMXhhK7h9VULJc7ExGoy2AquTF8Bm2XKJd80aCeoNbQC8kEZfCH+EeHFQTHweq
         0h+hC+cn150XbsEJ0GF/riwiSDpe8ydVTS7I2PJu4pRW1f2LDZWZdCRMAGadYp549/72
         7W4KWEsXote+mB8C7D9Ty/kHy1OHpppBhPvcaK9l9ko6Vm5WMHVSIeNXYnH5IYyHcmWQ
         X4Aof/86qvfTePMTevIKfVgb/LJEukjyWsU2E23PY+4EkmkHET5IjNEG/eg6A8/pkxay
         r2Mg==
X-Gm-Message-State: AOAM531DzYTnnmq0ucvlzLRb5gpDFJgHAay1lHfs6lFDX5tZxwQbeyIu
        YYFLLuehaVtoEbVqHphNEi4=
X-Google-Smtp-Source: ABdhPJwFGKxbomreDW+J1GbvG8BEcEiU4MEPTd4SU0phXMJGt+bS8VEO+2ibs8VsgBY3D7O/3rCL/A==
X-Received: by 2002:a05:6402:440d:b0:412:9e8a:5e51 with SMTP id y13-20020a056402440d00b004129e8a5e51mr12308694eda.362.1648663382363;
        Wed, 30 Mar 2022 11:03:02 -0700 (PDT)
Received: from Francescos-Air.fritz.box (host-79-3-210-6.business.telecomitalia.it. [79.3.210.6])
        by smtp.googlemail.com with ESMTPSA id bp8-20020a170907918800b006e0daaa63ddsm5455866ejb.60.2022.03.30.11.03.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Mar 2022 11:03:01 -0700 (PDT)
From:   FraSharp <f.duca00@gmail.com>
X-Google-Original-From: FraSharp <s23265@iisve.it>
Cc:     f.duca00@gmail.com, FraSharp <s23265@iisve.it>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: use hostname -s along uname to obtain LINUX_COMPILE_HOST
Date:   Wed, 30 Mar 2022 20:02:44 +0200
Message-Id: <20220330180244.51465-1-s23265@iisve.it>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* On some systems (e.g. macOS), using commands like 'uname -n' or
  'hostname' will print something similar to "hostname.domain"
  ("Francescos-Air.fritz.box" for example), which is very annoying.
  What works instead is 'hostname -s', which will only write hostname
  without the domain ("Francescos-Air" for example),
  but also keep 'uname -n', as some systems as Arch Linux does not have
  'hostname' as command.

* This commit is complementary to
  1e66d50ad3a1dbf0169b14d502be59a4b1213149
  ("kbuild: Use uname for LINUX_COMPILE_HOST detection")

Signed-off-by: FraSharp <s23265@iisve.it>
---
 scripts/mkcompile_h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
index ca40a5258..6054e3eee 100755
--- a/scripts/mkcompile_h
+++ b/scripts/mkcompile_h
@@ -34,7 +34,7 @@ else
 	LINUX_COMPILE_BY=$KBUILD_BUILD_USER
 fi
 if test -z "$KBUILD_BUILD_HOST"; then
-	LINUX_COMPILE_HOST=`uname -n`
+	LINUX_COMPILE_HOST=$(hostname -s || uname -n)
 else
 	LINUX_COMPILE_HOST=$KBUILD_BUILD_HOST
 fi
-- 
2.32.0 (Apple Git-132)

