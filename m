Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249A84ED7B2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 12:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbiCaKUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 06:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiCaKUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 06:20:43 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4614ADA0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 03:18:54 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h23so33055610wrb.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 03:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3njw3DxCJMK/qaimqo+JqUFpsDvCToqYT0qLJezFT7Y=;
        b=lrHRCCq6CmPr1waA9nNdRhHP/C3MSiSrMwO9Kz1WUD0himOpEGemhN7eODcBs80FJg
         18Z0cvz0zsNOJVJGlN7gaeGMblsVl0/QvqxUt0nfpgxMg8QO6+rs8grhU0FNLDed853I
         TXXVgTjH5KUEgeRYlpuVZ8a93weTgxF+ksHAKNxxREsvKdDtTHx1AFWbQVY1GasDXA4W
         SeUahsj61KGflwqDyi+lhQLfoI0mc8YLYhl5XXxuLvuwWGPagFtKJ67MNQra46kLko2i
         2siYBD7mKypQiCvkzKjjnaOYz11YcWAMaRWiLx+aEj2QfLRMkwlGxVfmE6n7t7bWGLWM
         +btQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3njw3DxCJMK/qaimqo+JqUFpsDvCToqYT0qLJezFT7Y=;
        b=1Wybp0MWAd27DXc1IP9qlmJe/Z9isVchfQTJQVGnx6Cfid6/YMnTbBzNDn7glCwTpr
         U+3kb8OonZMNaHnBEVJ4z9VTAh+yl8nev5POM1whuo4JBx4azGM1EVCyaEVUtdUectUE
         014j097ODIo9eIl1XiweC7xxVkv+bU9k32iV4iiCxXIwj4kKD7bwDDVeBMN2RNUM7kqX
         ChLLyziTEPI5yBOWQF4RTZsC5UCJeBZNSl6gZkAIRa+pbbMpTvIM/RDyFPUkl9Ys/Zqi
         QCkQ/JuoeX10G5vbSXjCyecOgL8KvJEUcsITFimH217HUQDt9mnqKfhps+ASrG7AQ3tZ
         2+1Q==
X-Gm-Message-State: AOAM531Dwhu+IOBfSq6+bP/EcrHeech+cyTm9Zn8lbzF5sy9yQeB+rSd
        Wg+2F8QlXwH6opYpg4I0xGE=
X-Google-Smtp-Source: ABdhPJwa3P6kCNuNRFst5jYLMm/9v2WOB5lOwPTpEWLX8v7cZefkN3P0qPBEtsqm+RvuRANfCZK24g==
X-Received: by 2002:adf:ebc1:0:b0:1e6:1109:5a1c with SMTP id v1-20020adfebc1000000b001e611095a1cmr3545977wrn.228.1648721933165;
        Thu, 31 Mar 2022 03:18:53 -0700 (PDT)
Received: from alaa-emad ([41.37.132.115])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c4f5400b0038b5162260csm10336271wmq.23.2022.03.31.03.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 03:18:52 -0700 (PDT)
From:   Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, eng.alaamohamedsoliman.am@gmail.com
Subject: [PATCH] staging: gdm724x: Fix Duplication of Side Effects
Date:   Thu, 31 Mar 2022 12:18:49 +0200
Message-Id: <20220331101849.71046-1-eng.alaamohamedsoliman.am@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Fix Duplication of Side Effects for GDM_TTY_READY(gdm) macro
reported by checkpatch
"CHECK: Macro argument reuse 'gdm' - possible side-effects?"

Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
---
 drivers/staging/gdm724x/gdm_tty.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 04df6f9f5403..6f0274470e69 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -27,7 +27,9 @@
 
 #define MUX_TX_MAX_SIZE 2048
 
-#define GDM_TTY_READY(gdm) (gdm && gdm->tty_dev && gdm->port.count)
+#define GDM_TTY_READY(_gdm) \
+	({ typeof(_gdm) (gdm) = (_gdm); \
+	(gdm && gdm->tty_dev && gdm->port.count); })
 
 static struct tty_driver *gdm_driver[TTY_MAX_COUNT];
 static struct gdm *gdm_table[TTY_MAX_COUNT][GDM_TTY_MINOR];
-- 
2.35.1

