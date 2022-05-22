Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2990C53013A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 08:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbiEVGSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 02:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiEVGSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 02:18:35 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2003BBE3
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 23:18:33 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id v11so11041859pff.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 23:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2QVXkV0/Gu3+EZ1h7waZSTlenUDji+OovnP2hZNQeP8=;
        b=Tg6R7aem1l9dBFhfM+H83zHnr575D+IFv6s5mqEAfHkTSikCrOmWwoGsm7CUINrwVS
         bi3r/rWat9+gh3CTLF5mYjy+yDUKC4bJefJJO1+njuW9Pwr6hssczHliq1v4KD5TjOPs
         W8+ud0CnsUcjyC32jjSGnyiZpH5yAuaEj3qzIoM9L7V3JHDDWsH/zXIiVUj2O77087zx
         b/dPYfkaaIZ98Qxe9JJONcH8ZRC2/z6O7n8DVMBHhCLc3nKpGKqYV54a4ma4JaK+3Bt4
         fScUtqJ1uHCZu08KpK9xMW3K2flB0vUvHLfeebIUv+XI5OAA3QjW21jJw4d7TerqS5HX
         QADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2QVXkV0/Gu3+EZ1h7waZSTlenUDji+OovnP2hZNQeP8=;
        b=LEmrE/4eADV5AXnLo1v5YA2asxYcRQM7EK6zveP8J+K7N0+2ZAWqoL1zOw6o1gnUT0
         teFDnTUOYJC2njSVwY6h6q/wXEsOUIzs4HoZbwh+ExPm6kCSy7o3VICviKjRwJ/R2WFW
         a0XDOAwjfTNgu3d1P3T+hWi/q4BVw+hdp7vCh71C9x/ZieyME3Vk4u+Bxono2UqvoS7u
         luH4Ox5q51A1Zf2cigU3XX/aEEJMOg8sXzsiFTlmUhm3mFWg2wS8BDrEg0WdQs2KAeI3
         bbopt85J7COOtgMNCkOkSJSt5JliLf7D1t4C5/igi2PdZbTz664fWPF7W8bQ03K6Z1Z2
         c8iw==
X-Gm-Message-State: AOAM531Ws+YHu205E4p63uRzbnF7eoVqlFuO+JLd4mDwnNdp3y+XOMdI
        /6hDRJgeY4miz9aHZ6VF8H4=
X-Google-Smtp-Source: ABdhPJxl6wxOtTW6L9H85PHaGLlXkdI7IgyrnfDK/V4b8ff+doCUBQfWUJ7tkZkOixLifQUJ7okpCQ==
X-Received: by 2002:a05:6a00:88f:b0:510:7a49:b72f with SMTP id q15-20020a056a00088f00b005107a49b72fmr17956402pfj.21.1653200312891;
        Sat, 21 May 2022 23:18:32 -0700 (PDT)
Received: from ubuntu.localdomain ([103.230.148.185])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902eccf00b0016170bb6528sm2543923plh.113.2022.05.21.23.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 23:18:32 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     Gautam Menghani <gautammenghani201@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH] kernel/trace: Initialize integer variable to prevent garbage return value
Date:   Sat, 21 May 2022 23:18:26 -0700
Message-Id: <20220522061826.1751-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the integer variable to 0 to fix the clang scan warning:
Undefined or garbage value returned to caller 
[core.uninitialized.UndefReturn]
        return ret;

Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
 kernel/trace/trace_boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 0580287d7a0d..778200dd8ede 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -300,7 +300,7 @@ trace_boot_hist_add_handlers(struct xbc_node *hnode, char **bufp,
 {
 	struct xbc_node *node;
 	const char *p, *handler;
-	int ret;
+	int ret = 0;
 
 	handler = xbc_node_get_data(hnode);
 
-- 
2.25.1

