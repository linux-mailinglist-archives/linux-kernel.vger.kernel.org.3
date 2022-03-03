Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1224CC9F6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 00:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbiCCXU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 18:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbiCCXUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 18:20:25 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13743BA6E;
        Thu,  3 Mar 2022 15:19:39 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id t5so6061009pfg.4;
        Thu, 03 Mar 2022 15:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zjuVnCbRWCkKZzG24Qbc3K9Rg+v9KCs6GJmxooo6ImU=;
        b=JunhUSYXT7H21ToQtYdrAhv32jLNwVVvUnOISnZrFUQSwXYeT9Xm+o7gyZhuoJZhVZ
         5drHBIwbv04hR5IxcQgmbACgWc2rTxAlWFNhGCxsAxWS4RCXqtCzc2Tuga0fV5bX1HBH
         y9Ngkvncl45cm9GapGWCtROcqfy9zGviZFNrybf55pyhToiq7KtM/ZKHO0eEM3GetPkc
         p794iolP2OC1gc48ZH8tYdmfmb0QhiqGr0bAqBmYR8RQFieF+qvVFzy6aJfdQLTQkjYR
         X0siBzdYBauPfOsPsZOSdyHuoPE6k13NwytrFqMpKKe8TKJnoG2b+7usdhT1rqimN9Mi
         I+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zjuVnCbRWCkKZzG24Qbc3K9Rg+v9KCs6GJmxooo6ImU=;
        b=WVQRvbzJ4D5ItG7JEoPFQb3LEsXVoEpEDWqTzb47DCEM5J1QZjOZu3DYx0ykWf3Ucf
         nXWvi/3jUMwpeA2ONsI4QxqAoHuP7lAGiQTgEYkhGegnmd6XRaOQMoeb1b/J032OlGMU
         SWNzGHWP8tJ1ZR7BsPOPSGG+szJ2cc2kEEkOf1xtn8uWUO+5IyzLyEmzwInxCCN0dYYu
         dNl8LmLTDbURDNClmg+Tpanu8UtCPihbycJPvkhPhF1nhz8MJsDRro+5RAX8mBfT5xCq
         7NK8dFMT88WETbkpYn8ps6xowV8G62EY/PxNXxf3G9ZhNV0FZzvmrczEzuycMrQohch6
         k7cw==
X-Gm-Message-State: AOAM533TJSO0RRuzf21rFIFxYbTK5epQOdnWrtSG3WpLKvjFUSF0jPAS
        KYCMY2SUMr5vsTgcxAAqlO8=
X-Google-Smtp-Source: ABdhPJwDJODFk3S4d4ZDXWIYNC1lVTWKiEgRPAaVdcs+sRcG0Dlwm4CCVfmIShdQqnYrEx6HVt372A==
X-Received: by 2002:a05:6a00:a1d:b0:4f6:5051:6183 with SMTP id p29-20020a056a000a1d00b004f650516183mr10703840pfh.42.1646349579082;
        Thu, 03 Mar 2022 15:19:39 -0800 (PST)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:5388:c313:5e37:a261])
        by smtp.gmail.com with ESMTPSA id e14-20020a056a001a8e00b004e136d54a15sm3626149pfv.105.2022.03.03.15.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 15:19:38 -0800 (PST)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-raid@vger.kernel.org
Subject: [PATCH] md: use msleep() in md_notify_reboot()
Date:   Thu,  3 Mar 2022 15:19:33 -0800
Message-Id: <20220303231933.1313075-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
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

From: Eric Dumazet <edumazet@google.com>

Calling mdelay(1000) from process context, even while a reboot
is in progress, does not make sense.

Using msleep() allows other threads to make progress.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: linux-raid@vger.kernel.org
---
 drivers/md/md.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 4d38bd7dadd604acdc9832d62c81c913abddc07d..330c53e212b82dd58670962fc9204cf4eec484f4 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9583,7 +9583,7 @@ static int md_notify_reboot(struct notifier_block *this,
 	 * driver, we do want to have a safe RAID driver ...
 	 */
 	if (need_delay)
-		mdelay(1000*1);
+		msleep(1000);
 
 	return NOTIFY_DONE;
 }
-- 
2.35.1.616.g0bdcbb4464-goog

