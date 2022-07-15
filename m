Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AFC575E17
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiGOIug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiGOIuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:50:32 -0400
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51C3820FB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 01:50:30 -0700 (PDT)
Received: by mail-pj1-f66.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso10976773pjc.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 01:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UKbfSg7TrsohuBtUBfw/4JYHhjgKNHMy0QyToUGRqo4=;
        b=MVe3bzT9P970JDITY89GgaUVVChs35oUDcUlSR2XBfTIU7gdzkntmEkKHmiSgGbChG
         XJk8C+twd3ahEw7nNgp8g7wPrygjiqr1sGPT4jnoR22P5fHmONfy+4Sl+wcRluIGzLUT
         okPbnRglK+qFLfcCxUqsuI6MdY3hmZPcmC8PhQ4499IYY+483gU8jeD0aUAn1nmUiO1f
         +EJ1k0B2i/zERkv2UeBIr2kGEQO+6Y++8afmkX9owDUt4Q9ntAIzUS+KHfU1Q/2/WvMA
         gT20r/Dhl0VgnonUk2JMRqOHu+IJsGLUGpK4rtsk41pnNQloOV28GsyFRDBWpuIMEtVL
         ulwg==
X-Gm-Message-State: AJIora8oJYuTIp7s2XIMGeB+QM824pP/U5JYiSiqvlLuF+RZD7IuUgT3
        b3YLMtZqxIJKJ+hRQLD57A==
X-Google-Smtp-Source: AGRyM1sVKKvlZlyVUtJgYEChzMynl/kOSor1qJE2p4LSUK5/y28sNLLG4lYcfa6bl8Ir1+jbRFoMYw==
X-Received: by 2002:a17:902:e74a:b0:16c:3bdf:26bd with SMTP id p10-20020a170902e74a00b0016c3bdf26bdmr13125985plf.116.1657875030231;
        Fri, 15 Jul 2022 01:50:30 -0700 (PDT)
Received: from localhost.localdomain ([156.146.53.107])
        by smtp.gmail.com with ESMTPSA id h29-20020aa796dd000000b0052a198c2046sm3237477pfq.203.2022.07.15.01.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 01:50:29 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     rostedt@goodmis.org, mhiramat@kernel.org, beaub@linux.microsoft.com
Cc:     linux-kernel@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH] user_events: make data_file and status_file static
Date:   Fri, 15 Jul 2022 16:50:15 +0800
Message-Id: <20220715085015.248932-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variables data_file and status_file are not used outside of example.c,
so marks them static.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 samples/user_events/example.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/user_events/example.c b/samples/user_events/example.c
index 4f5778e441c0..13b514bc03e9 100644
--- a/samples/user_events/example.c
+++ b/samples/user_events/example.c
@@ -15,8 +15,8 @@
 #include <linux/user_events.h>
 
 /* Assumes debugfs is mounted */
-const char *data_file = "/sys/kernel/debug/tracing/user_events_data";
-const char *status_file = "/sys/kernel/debug/tracing/user_events_status";
+static const char *data_file = "/sys/kernel/debug/tracing/user_events_data";
+static const char *status_file = "/sys/kernel/debug/tracing/user_events_status";
 
 static int event_status(char **status)
 {
-- 
2.25.1

