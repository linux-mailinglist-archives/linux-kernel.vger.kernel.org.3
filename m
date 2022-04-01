Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC464EF70A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352019AbiDAPtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 11:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350639AbiDAPoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 11:44:25 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2FE5AA60;
        Fri,  1 Apr 2022 08:17:16 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y10so3332042edv.7;
        Fri, 01 Apr 2022 08:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TC/0oHyiUjWJOMmXPw1IkL3i67Jwm2UVoeCCCR45dxw=;
        b=k6zoIicqLKLt5DQRctI9KCFBFUEwPjRcOWUFjr28baaSBVCiwf0j7q7noHdQjUNBzS
         Fa8XwaTHi4VXnmf6PeICFdU2QSRF6PZXwJ8V/bg9SLNsexDLhDaiCy9tmjxQb/pcU//t
         hbAHMaQw63bycZdQ+cgRGGt3HgSFcP9UeFvJwZhLb6jZwWUU5vVNz5VJY0DWINgvDQBD
         rsKSttAIAsr4oI402bX51922owRDL3ihT2i9pfVXMtOKz9A90d9KApsfVI6+vCI7rFC9
         F/u88Zr+Pn+kDskpAJ9v5sn8yEUNqJhBpc/zgkaXiiipoo7u5U5TecSDt/tZ9R9PbS3r
         5fZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TC/0oHyiUjWJOMmXPw1IkL3i67Jwm2UVoeCCCR45dxw=;
        b=LKkv3YveaTp4/bmqEvO/evLcg4UMoRxgjHykCaSiivEiyphogTUvtri7xWeMKMdvqT
         7sr4YvlSTUl6mp74mzn+PLtcLQvVz3BFzSAS84+NaDttva2c3UYApQ2/QfGIKAnw9fCc
         DyasPcFss8usXe8I2aTtm6pa1b1EWKKV7UuiKsWv6fQyrhztgqG5KL1w4Ea/sK/HOswN
         Y93XkWTENnFWfz0CXJtTG66oLu596m5v4f8YvwWW6MkGR1wQw01tGSUStZpj/oi+INwY
         DPuothC48+YJOZQZhqWI9WXajk9aRp9++9w8i7uJtuZCJUezKvQSwKuHEsIk60mwmYM8
         PGug==
X-Gm-Message-State: AOAM5306roIKcpRcoFaDDah449v+IqPReXyLYiyuZxHjprOCvHYuh1Vc
        Mih06En7iPLPcW61z33he+Q=
X-Google-Smtp-Source: ABdhPJzCAZ4biH2c+9CF/BG7bI+G4OkImhdk+mfdkh4mHRUIklJGO8GesP48InP4rPa17dSZHx7XeQ==
X-Received: by 2002:a05:6402:5202:b0:419:2b9f:7dd3 with SMTP id s2-20020a056402520200b004192b9f7dd3mr21502195edd.224.1648826234593;
        Fri, 01 Apr 2022 08:17:14 -0700 (PDT)
Received: from Francescos-Air.fritz.box (host-79-3-210-6.business.telecomitalia.it. [79.3.210.6])
        by smtp.googlemail.com with ESMTPSA id h30-20020a056402095e00b00412b81dd96esm1264335edz.29.2022.04.01.08.17.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 01 Apr 2022 08:17:14 -0700 (PDT)
From:   FraSharp <f.duca00@gmail.com>
X-Google-Original-From: FraSharp <s23265@iisve.it>
Cc:     f.duca00@gmail.com, FraSharp <s23265@iisve.it>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] kbuild: use hostname -s along uname to obtain LINUX_COMPILE_HOST
Date:   Fri,  1 Apr 2022 17:17:06 +0200
Message-Id: <20220401151706.30697-1-s23265@iisve.it>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220330182329.52310-1-s23265@iisve.it>
References: <20220330182329.52310-1-s23265@iisve.it>
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

* On some systems (e.g. macOS, Debian, Fedora), using commands like 'uname -n' or
  'hostname' will print something similar to "hostname.domain"
  ("Francescos-Air.fritz.box" for example), which is very annoying.
  What works instead is 'hostname -s', which will only write hostname
  without the domain ("Francescos-Air" for example),
  but also keep 'uname -n', as some systems as Arch Linux does not have
  'hostname' as command.

* This commit is complementary to
  1e66d50ad3a1dbf0169b14d502be59a4b1213149
  ("kbuild: Use uname for LINUX_COMPILE_HOST detection")

Signed-off-by: Francesco Duca <s23265@iisve.it>
---
 scripts/mkcompile_h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
index ca40a5258..3eefbafe5 100755
--- a/scripts/mkcompile_h
+++ b/scripts/mkcompile_h
@@ -34,7 +34,7 @@ else
 	LINUX_COMPILE_BY=$KBUILD_BUILD_USER
 fi
 if test -z "$KBUILD_BUILD_HOST"; then
-	LINUX_COMPILE_HOST=`uname -n`
+	LINUX_COMPILE_HOST=$(hostname -s 2>/dev/null || uname -n)
 else
 	LINUX_COMPILE_HOST=$KBUILD_BUILD_HOST
 fi
-- 
2.32.0 (Apple Git-132)

