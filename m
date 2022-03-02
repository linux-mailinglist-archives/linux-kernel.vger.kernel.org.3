Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519204C9A4A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 02:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbiCBBN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 20:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiCBBN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 20:13:56 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59583427F5;
        Tue,  1 Mar 2022 17:13:13 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id f21so87574qke.13;
        Tue, 01 Mar 2022 17:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yySV6Y0CtkOIabQfeCBZ0f+k+saFzY3H5E/CYeeikUQ=;
        b=C/gR37gXglBmPEYlaEQ4wWYkAyH5frQ0bi81LjF9B9/b7mYsJepC4MsUNoBjZV90fe
         ePOewM7gta6kkPGyoPLie2lWvxGnzcepCHXm1GGoTSbFcTGdwrYEcuEGlHyFuT3BZ2xD
         jVVJ0OrcpnjRQm6w1HpVk56G4U8bo07RuAlHTi/5etoQ0peWz15ua46OXMqs83NEl3WS
         OmP1Gshwf3P/d5MX/mrF9guQaB0dwvm3HTdSsUETZJPaMpIxwbu9uf4fEzdk7E5R7QbN
         EAlQpDdvaYsocKsEfWOVzDkNgnR5L13RXCHm4XIOBgm6oAOp0rtIOSG2Bi8bwSjaMlXZ
         SGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yySV6Y0CtkOIabQfeCBZ0f+k+saFzY3H5E/CYeeikUQ=;
        b=Lcd89Po+d7Q5a/O2VqeFaLjw7Ec5QGXTloYY7k2HJVUWiUvUiZr+VF9hk4BXyX3SUY
         KWE9vYdXrSGHygVzC8pChGGcgI92GQctRnAAIiRhQ7/jY107oTsUipYWKO6pEKFvVW1h
         mLKYwliysw8KR7/V/M+8+L6aggunfiOG1qrfOcS+xAbbwAlK246mDE63z9WlRy+90mLg
         eGXoUKijbGY+AjG4wz3uRENbI3VrYcNyhRNO+7LUr5OWnuGJWVb2WGEI/pYacDloQX/E
         n+ioHGQiXjElerPQS1IiL5YHgS3dvOAhQrsupCCRxwevfV6F3Z8bq9KIvlqdg4QKdUMu
         hPqA==
X-Gm-Message-State: AOAM5317QhLyV0g/qdw/dNRC4IhHWZ+QNLIuaYwO2twec+IJfDcAYp5A
        4kB52wMrMelAepEKRqCxaqxX782O6Hk=
X-Google-Smtp-Source: ABdhPJzMduG+IJ+g5dqF77wT5B+t3scYXTMqwVA7KoB8NgXrLx0uVzNvQTW7onDn0jOuIuN3sbL77A==
X-Received: by 2002:a05:620a:122c:b0:47d:875d:fffe with SMTP id v12-20020a05620a122c00b0047d875dfffemr14694308qkj.528.1646183592526;
        Tue, 01 Mar 2022 17:13:12 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d16-20020ac85ad0000000b002d71c463d9csm10074538qtd.24.2022.03.01.17.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 17:13:12 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] module: avoid calling synchronize_rcu()
Date:   Wed,  2 Mar 2022 01:13:06 +0000
Message-Id: <20220302011306.2054550-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Lv Ruyi (CGEL ZTE) <lv.ruyi@zte.com.cn>

Kfree_rcu() usually results in even simpler code than does 
synchronize_rcu() without synchronize_rcu()'s multi-millisecond
latency, so replace synchronize_rcu() with kfree_rcu().

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi (CGEL ZTE) <lv.ruyi@zte.com.cn>
---
 kernel/module.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 6cea788fd965..767b5f9e5819 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4138,8 +4138,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
  ddebug_cleanup:
 	ftrace_release_mod(mod);
 	dynamic_debug_remove(mod, info->debug);
-	synchronize_rcu();
-	kfree(mod->args);
+	kfree_rcu(mod->args);
  free_arch_cleanup:
 	cfi_cleanup(mod);
 	module_arch_cleanup(mod);
-- 
2.25.1

