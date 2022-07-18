Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869E65779B3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 05:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiGRDKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 23:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGRDKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 23:10:45 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34DC10FC4;
        Sun, 17 Jul 2022 20:10:44 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c139so3209563pfc.2;
        Sun, 17 Jul 2022 20:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WIaE5p7vCRM9cDug48fSPQP1o+yx7BsuW/zADg9iL9Y=;
        b=H4VlsetGoWMJVh4Px0oF4oDgKOQpVXlMTlBAEaCy7vNhN4+TWj6X1gyqrRQSUjBuy/
         fSmRCEstccIDgf57/7GNfQAVKKCdrADBNj6Q//Vm5Vif3TYaaHGEWOwdvFqANObkbpQM
         g/xJBpgJQbdJJpP4rupDlQLbiTR+shwFwpwyEWMpDp9Q+O5YJPvYcgpYb+PsFOlC8CMk
         t8uHhJNMYdDYIUDaDzrm/l4u+ShAH1oFyEidP2HccWAuRhUOMshMT+xh4dZJ5ZJZiRLM
         mufQyMa+ZNgrvTMgMWq1m3WrA7ZrxnedjqFJNpfm9qNlYtCPF02EcYDQ3UxDiDOKIV6R
         LGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WIaE5p7vCRM9cDug48fSPQP1o+yx7BsuW/zADg9iL9Y=;
        b=PpwIumsQmsZ5ACJ8OqLWypWwIhUm9Rxf3A/SWF1SiQUSA2Dd0mepZqz9ZFoNPXQwSv
         pk0NpZceQcLfKJKLUGSEzvb349xRGPceW8/OgZ1JT1grGQlH4PzQLaQCIE5hYObGpyjG
         7zWjpqmfwTAK7NGJz0WfUn94ey3VH35a9cGO7XkLhLrAUmXHHgCMkOT5Lv5ewQtO0smy
         2AfO0/Xhhkn8LrbQTzSoiiPXJaWafnTKGP61V7p6yRvtBeN32HqQftAV0jiYQnrfmdRT
         mShNY37u70nE0qLugArBSC0KoNbXRULY/ekihDf95bRK8ch+gzUqHlEYwSXPyNQefTT0
         MyBA==
X-Gm-Message-State: AJIora89WduZsorZGKgIqU/eeoFbe1L1aJbuASB+jAwjgbrX0a5pujJP
        7oCqyFJPScLA9UEtWLMkifQoOFIkBvg=
X-Google-Smtp-Source: AGRyM1uOq/dKA8d1NkOzk7wlRIXuQQGLWgGguMrm0lT16hF4+vm14igker82UjlG/K1+WEyLMIwatw==
X-Received: by 2002:a05:6a00:1daa:b0:52a:c51d:d36a with SMTP id z42-20020a056a001daa00b0052ac51dd36amr25829909pfw.61.1658113843836;
        Sun, 17 Jul 2022 20:10:43 -0700 (PDT)
Received: from localhost.localdomain (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b0016b81679c1fsm8038889plf.216.2022.07.17.20.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 20:10:43 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        =?UTF-8?q?Alejandro=20Gonz=C3=A1lez?= 
        <alejandro.gonzalez.correo@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <markus.mayer@broadcom.com>,
        linux-pm@vger.kernel.org (open list:THERMAL)
Subject: [PATCH RESEND] tools/thermal: tmon: include pthread and time headers in tmon.h
Date:   Sun, 17 Jul 2022 20:10:39 -0700
Message-Id: <20220718031040.44714-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

Include sys/time.h and pthread.h in tmon.h, so that types
"pthread_mutex_t" and "struct timeval tv" are known when tmon.h
references them.

Without these headers, compiling tmon against musl-libc will fail with
these errors:

In file included from sysfs.c:31:0:
tmon.h:47:8: error: unknown type name 'pthread_mutex_t'
 extern pthread_mutex_t input_lock;
        ^~~~~~~~~~~~~~~
make[3]: *** [<builtin>: sysfs.o] Error 1
make[3]: *** Waiting for unfinished jobs....
In file included from tui.c:31:0:
tmon.h:54:17: error: field 'tv' has incomplete type
  struct timeval tv;
                 ^~
make[3]: *** [<builtin>: tui.o] Error 1
make[2]: *** [Makefile:83: tmon] Error 2

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Acked-by: Alejandro González <alejandro.gonzalez.correo@gmail.com>
Tested-by: Alejandro González <alejandro.gonzalez.correo@gmail.com>
---
This patch was first submitted here:

https://lore.kernel.org/all/20200617235809.6817-1-mmayer@broadcom.com/

but never applied, meanwhile the issue is still present

 tools/thermal/tmon/tmon.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/thermal/tmon/tmon.h b/tools/thermal/tmon/tmon.h
index c9066ec104dd..44d16d778f04 100644
--- a/tools/thermal/tmon/tmon.h
+++ b/tools/thermal/tmon/tmon.h
@@ -27,6 +27,9 @@
 #define NR_LINES_TZDATA 1
 #define TMON_LOG_FILE "/var/tmp/tmon.log"
 
+#include <sys/time.h>
+#include <pthread.h>
+
 extern unsigned long ticktime;
 extern double time_elapsed;
 extern unsigned long target_temp_user;
-- 
2.25.1

