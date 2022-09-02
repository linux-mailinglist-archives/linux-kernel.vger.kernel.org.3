Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB095AA92D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbiIBHzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbiIBHzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:55:04 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D62BC1E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 00:55:00 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id j5so1127432plj.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 00:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=olRYQnYmrRIOGNSywKQ9G4nuley//Yo3uY1jFefZG7o=;
        b=bhXeAh6NCcFpvJlv7XLzcG3X3zIgANLNUE4MmeQDW8WfdAahPXa8g0WRdHkW4TOqmC
         yBd9xg/SSs0xMYBtSy4N4iQXPq17adhaIpZHsj0MmiDd0oOfQgPVdqtuIB9fx4NimvDe
         ZInR8r6HJQuDDhInEdF23uSoUn5/vgxjMfJbq7dvhYAboZtF1Jo8al3BA+ZTnIEHotcQ
         uUIrEfYfV6xDv6A4JqX837duDfoYhtPgj96kVrljzZlHKsddFfJ3nUhRs7h801RNIwHj
         peX819TppTZqOAjYqpzhWZf46daEiiMfsy7swZZcJjOtYsWc2cXQCiG1cWNfUcA6n3gW
         sc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=olRYQnYmrRIOGNSywKQ9G4nuley//Yo3uY1jFefZG7o=;
        b=2vee5kbQdcLIKtudN6A7vpGitXLHd1kb7cYcnapzWv6Uodu7d4XrKCnOPkS6SjuhDG
         SXkHukHjVfO/M+z91JMlXU4IBP4SJ4TXGV/+/izF2fwV059CPpZvJay3BhirvpO6qBBZ
         gteZ3tOoliiSsrdlnlxNAuvLWY7yhiOwh2/uB7sF23VKupmlIZ42xP6/4g+PXJCJv5v5
         lLF2a97BZvKaFL+o25P5WyjW7G9rpYs5yyL6O+r3orBwrZrMk6Qw0112ZDG4+zU7ZjWw
         hVMqgGCm/BCFe/dYcwUi3ITOdcxE3/JTWZgPZDzuzf9A4Txa1PSmzD3srEZk9ZnbVQzl
         6aiQ==
X-Gm-Message-State: ACgBeo246OjW+kflw0LievARP6w0p1mXdSdAnjCp0LKVnLBV5zE3y/HP
        fvtniy/u8Qqa0cf2d8dcI1o=
X-Google-Smtp-Source: AA6agR4XOQ2iEpSSKN5Yz5XMLIr6LdDI5VoI9vYEvx9vlTdzzxag0lMZfhF1mY/cUxVhW5mba0hqjQ==
X-Received: by 2002:a17:90b:1d89:b0:1f5:a59:46b1 with SMTP id pf9-20020a17090b1d8900b001f50a5946b1mr3426825pjb.173.1662105300133;
        Fri, 02 Sep 2022 00:55:00 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u7-20020a170903124700b00170d34cf7f3sm922697plh.257.2022.09.02.00.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 00:54:59 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: zhang.songyi@zte.com.cn
To:     harry.wentland@amd.com
Cc:     sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        wenjing.liu@amd.com, Jun.Lei@amd.com, Jimmy.Kizito@amd.com,
        Jerry.Zuo@amd.com, meenakshikumar.somasundaram@amd.com,
        hanghong.ma@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhang songyi <zhang.songyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/amd/display: Remove the unneeded result variable
Date:   Fri,  2 Sep 2022 07:54:50 +0000
Message-Id: <20220902075450.319982-1-zhang.songyi@zte.com.cn>
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

From: zhang songyi <zhang.songyi@zte.com.cn>

Return the enable_link_dp() directly instead of storing it in another
redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index f9b798b7933c..4ab27e231337 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2077,11 +2077,7 @@ static enum dc_status enable_link_edp(
 		struct dc_state *state,
 		struct pipe_ctx *pipe_ctx)
 {
-	enum dc_status status;
-
-	status = enable_link_dp(state, pipe_ctx);
-
-	return status;
+	return enable_link_dp(state, pipe_ctx);
 }
 
 static enum dc_status enable_link_dp_mst(
-- 
2.25.1


