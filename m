Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518F24ECC04
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244617AbiC3S0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350185AbiC3S0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:26:12 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEFD4830F;
        Wed, 30 Mar 2022 11:23:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u3so30534615wrg.3;
        Wed, 30 Mar 2022 11:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RMOT7aYy2mupTnOfFbZePA5/uVx944n/I4VvlKi6Lsw=;
        b=piHloS7GD3Le8mJ10k+LyWzNL68x+zwpYI6oKRQCXUjqk2EzocHm9C9FcFUWtP4BhS
         j/KJWtun+svPjWuebaagI/ywruUnOfd9bK3XMXF5iCAGu8LbHxhU13xoTC0nsH6JDTfm
         vx7x+b0ltsc3wZFHzGfKS+N0gwN3OeEiE+qbtgipA6z6q0JSbcIGCyxIJzanU7NmGXcH
         NK/cjmMpSygRPw0gbbVzO/n9kNad0nfkLmVs3c1+EbItZBj6xwvBMxIvA0PT858UaYLK
         ZdgZjVTVAPyImF96l/2YPsWoiI62SIGDpF4Ch6rYohd3DKXZI0aBa0GYgCfqL2+cEGIz
         WCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RMOT7aYy2mupTnOfFbZePA5/uVx944n/I4VvlKi6Lsw=;
        b=21T90oPBv6qQxGRHAWBpB5hSskCiA0W5nSnCYNcfZbFI7bsgA16feuw4DyRKtG6QLL
         S2BKmtZ/zZYfQ+n3hI+pfBeadQaDQeYeZfbtE4Wcd1G4NlklW6s5nGfQv/qwZizGIer8
         MLqfDJbNp+Qjb3FSDzFjB8NAJjkOfFEqsGFAJF9p9uruRHR4s944J4dW7zLfibtsffYY
         KT3q0KYCnw79I8EEBXgzmiedJ7yDNHu++QEZtRULRrG3zjHqpgWh0+5GwElWGxEgYw6i
         QoMTHKHyMqBDrqRT8A98yTn7trMPvE/kuMTkeicMFu4HwLWcUG92gCIfin3VAEwB35rI
         BX9Q==
X-Gm-Message-State: AOAM530XlFxX6GbmxGAnwmSEh4hWhaq1DLDETMB+a+ZO2co3k3UjTsbx
        tqnFJSDbD46KcOvglp3/WYeSqu6mZhS16A==
X-Google-Smtp-Source: ABdhPJzNRvC2PQ8Ee8kumcS/8iR5Bsnssmxd575QnVljTaDgTB55DFoBO+sG8qV4rBVdPqt8+JdNng==
X-Received: by 2002:adf:e486:0:b0:204:ba5:adcd with SMTP id i6-20020adfe486000000b002040ba5adcdmr863091wrm.16.1648664614844;
        Wed, 30 Mar 2022 11:23:34 -0700 (PDT)
Received: from Francescos-Air.fritz.box (host-79-3-210-6.business.telecomitalia.it. [79.3.210.6])
        by smtp.googlemail.com with ESMTPSA id m4-20020a7bcb84000000b00389efb7a5b4sm5291193wmi.17.2022.03.30.11.23.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Mar 2022 11:23:34 -0700 (PDT)
From:   FraSharp <f.duca00@gmail.com>
X-Google-Original-From: FraSharp <s23265@iisve.it>
Cc:     f.duca00@gmail.com, Francesco Duca <s23265@iisve.it>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: use hostname -s along uname to obtain LINUX_COMPILE_HOST
Date:   Wed, 30 Mar 2022 20:23:29 +0200
Message-Id: <20220330182329.52310-1-s23265@iisve.it>
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

From: Francesco Duca <s23265@iisve.it>

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

Signed-off-by: Francesco Duca <s23265@iisve.it>
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

