Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFAB53DF78
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 03:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352044AbiFFBok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 21:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiFFBoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 21:44:38 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE9D4EF77;
        Sun,  5 Jun 2022 18:44:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id gd1so11643706pjb.2;
        Sun, 05 Jun 2022 18:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7xwpmzfKNMi656LDDOGdxoZgROWz8e8HUFBd0cY/pYI=;
        b=mZypeES6c0VJa4XMsSpXlNC7yBCeS1kuYqPYtd5pcp+8ZqKM0YXLpPtZVyH9h1seVg
         vsxLS3iBC0ADH87aAyNUekw2G5l1VragLBywL0vD9VfalCveTV0VMnZgI6qvOjoVXoGP
         ZKAAqOFAnEbl7hhzbjiDvEddDiCF/bcVOt1Bg4FwUecWMjtgw7THhiAWA06EHfLa90LA
         aruXSbEYZ2rYpM71uNwbYbznH4ch0xQGEGBq6DG1nqbw6kbXtQuwJzQjkcMP0+c3qylz
         +oaEGMpfUspZH0QhGU/FbNjPvXjg7MYV0BR0baRMRH5BmOn4135HK1Y/amYxwiwliLMV
         EPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7xwpmzfKNMi656LDDOGdxoZgROWz8e8HUFBd0cY/pYI=;
        b=IWnCF4FUN5uz0GdrtvmnHapExNmAsU7R5YyCKyhQumWd0nX/6WIwnCGsZuaLvCTPGr
         1e8E4zXDoIYJWEethhTUDyVMmV2FQEnsNNDW/yKYYBSV1GxN3qbWPFADCcp6zsy1anTS
         h+Z2QC3+eIophAl3ou9Qy/vAHfeVfjkXvVwNBFJef83EhN9WTv2GVCwCBwVd+IFIxmwS
         Wsb74aoCOCRJcue9s147UBzjy4a53NVtiPNGSPB3crKYJ0hFIL9H2F78NHoRJGdaTG98
         diCkR93M8wExM/QMltv4d/fHqqM0pYHu3R+WOrHpTkZq/Xh8g8DYa8ksSXAyBfLfFNb6
         wqsQ==
X-Gm-Message-State: AOAM531EiMjse8E+L/g4rFvbqLZWrDt7tfqMvmGuuBqmaFbDUlD3zScq
        JqMMOnlrE+gc4oGi+JJhjaA=
X-Google-Smtp-Source: ABdhPJwGgLrO6fXboCXH3FeM9syTAPsTB8j49Ok+YxvoH++9hKSCjSRRt09MVw1IIqLt81lYng6B/Q==
X-Received: by 2002:a17:902:8c93:b0:167:879d:6670 with SMTP id t19-20020a1709028c9300b00167879d6670mr241668plo.31.1654479877262;
        Sun, 05 Jun 2022 18:44:37 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902968700b001676f87473fsm1889515plp.302.2022.06.05.18.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 18:44:37 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     zzam@gentoo.org
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] [media] si2165: Remove redundant NULL check before release_firmware() call
Date:   Mon,  6 Jun 2022 01:44:33 +0000
Message-Id: <20220606014433.290667-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

release_firmware() checks for NULL pointers internally so checking
before calling it is redundant.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/media/dvb-frontends/si2165.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/dvb-frontends/si2165.c b/drivers/media/dvb-frontends/si2165.c
index ebee230afb7b..3d167ca670a4 100644
--- a/drivers/media/dvb-frontends/si2165.c
+++ b/drivers/media/dvb-frontends/si2165.c
@@ -513,10 +513,8 @@ static int si2165_upload_firmware(struct si2165_state *state)
 	ret = 0;
 	state->firmware_loaded = true;
 error:
-	if (fw) {
-		release_firmware(fw);
-		fw = NULL;
-	}
+	release_firmware(fw);
+	fw = NULL;
 
 	return ret;
 }
-- 
2.25.1


