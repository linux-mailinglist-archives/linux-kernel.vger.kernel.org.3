Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5412C4AFE73
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiBIU2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:28:08 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiBIU2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:28:04 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5F5E01566C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 12:28:07 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id u3so3694745oiv.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 12:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tZ+ICUNOD4a/G9GF8NueyOkz08WKOuBo2WdTV0ZJvsw=;
        b=aah8c1tqXvTU7RJNnPoeLLlrumzoU6ses4qrrQNE17jPo4ZKyEO5kPpRVtsM/JW+w9
         18R31HlYz6R+M+IjhxZTPUf6FliUYCzWAlIs12ZsUbX1Mr6wNGMK875QeFTPoWcTBEt5
         uYS1ZvQWmR3W/K5OjJp9heAOdxBWKv5vAsuWX/5tJhmCu1KQgkVUwg+vP98hwWvxAgag
         8kJKhnAtCdgM9+bWjymOme938eoVKP3AlNJf76MKVIAJQZpuZZQEDxCHEQI1Rh6p0SCG
         bI0iRQxZfIjPK3lLwusRQVP+aRwXUr4OYFF99yIm8HL7rlMLRxy7teVpna2n9ELqM6Fp
         waNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tZ+ICUNOD4a/G9GF8NueyOkz08WKOuBo2WdTV0ZJvsw=;
        b=ghMJkuh1s0rQ/B8cULoEOcAILsy0AY82Wsod2WSM94YNxUPZjFKSo9qZYt4DiMuNeB
         2ihmkO01AX1NPU6/NUcfFMVmB1KEvNID/iE27vjqLNywHf5Q0R+ZQ9+VcufT7wPqW36r
         aAIEXQ44JSPGvInrT8I0f/ozKnQCu8rH9iT3DgYD9DpE8z6oSt9ncqWmOSGERQ/ZF7ug
         w7xwxuw9ZpGjGj2NybHyhJB7mG0DqhHdg2Q9UaAT0DI6E6QLUSjeDqwrX+q/eqZrdK8M
         gLWIuW/qi8YW05UVX25sMQ8DaeL4Du/oI80M1cTiqD92pZl92YpDhN6vWsG3F8cSVcKt
         n9JQ==
X-Gm-Message-State: AOAM5305l9U4uj0wrqVOjl1EvhZBkbgI7TbQdbZkpGIzFFbVCCx0FiTx
        3/dJHh8LpreE0Yoq7qBi3v24K854vPsF9Q==
X-Google-Smtp-Source: ABdhPJy23WynfntBST1K1YK1LrOTCsePRqf4FOzpYNlOSn4/zQDoXbrUEiH+fwQBfmxxydu2gEVJwQ==
X-Received: by 2002:a05:6808:1690:: with SMTP id bb16mr2182292oib.88.1644438486519;
        Wed, 09 Feb 2022 12:28:06 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4cd8:12bf:758b:9a0d:6e95:934f])
        by smtp.gmail.com with ESMTPSA id d21sm6948035otq.68.2022.02.09.12.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 12:28:06 -0800 (PST)
From:   Leonardo Araujo <leonardo.aa88@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Leonardo Araujo <leonardo.aa88@gmail.com>
Subject: [PATCH] Staging: r8188eu: core: Comparisons should place the constant on the right side of the test
Date:   Wed,  9 Feb 2022 17:27:58 -0300
Message-Id: <20220209202758.2940-1-leonardo.aa88@gmail.com>
X-Mailer: git-send-email 2.29.0
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

This patch fixes the following checkpatch.pl warning:

WARNING: Comparisons should place the constant on the right side of the test

Signed-off-by: Leonardo Araujo <leonardo.aa88@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index a9a5453aa1cc..e236316188c1 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -618,7 +618,7 @@ u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueu
 		res = rtw_enqueue_cmd(cmdpriv, cmdobj);
 	} else {
 		/* no need to enqueue, do the cmd hdl directly and free cmd parameter */
-		if (H2C_SUCCESS != disconnect_hdl(padapter, (u8 *)param))
+		if (disconnect_hdl(padapter, (u8 *)param) != H2C_SUCCESS)
 			res = _FAIL;
 		kfree(param);
 	}
-- 
2.29.0

