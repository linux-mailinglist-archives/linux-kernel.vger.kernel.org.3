Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2384B5141ED
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 07:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354238AbiD2FwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 01:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354218AbiD2FwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 01:52:07 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846B1B18B0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 22:48:49 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id z126so5201676qkb.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 22:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VRas45N/HJjKkopTpxGekJncxjNBlwm6mL3yMYGLlOo=;
        b=bc+WNUXF3c5mK3q/tzF4v4JoBy26gajoLNbPDLWyfH0Lj6WYdJCxKSXW7DRkKEfxgf
         eSEzGQdfD/gk0CK8kbNcBllob6euxIALNnI86XDvGYieK8qr6dgKhAr4DPTyuIki6NMd
         s7c+4cyP9+Q0UgielsvHPBfJh9ZV40Cfgxmh1e0ER1mRiE0QdJwHJMD4rD/GH7huQooE
         jhQu3o4gi7C6/IirN9RyFP1WgfX8UC1XCs2p8f+dEwDsdTn1WFODIQ4ZkA+O5mH7iFZh
         znNNYvUVBQBlraSHDLPriOhQZGoLQ5WSWZctA46uRE02fbX20QJAD2G3X1XrEZguVEXo
         vRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VRas45N/HJjKkopTpxGekJncxjNBlwm6mL3yMYGLlOo=;
        b=66bkVtd+Ls6zhR8CmqeXB3BHJbF7k38GGkkZV7BFWAKGOeOaapV6NpjumG3pl/voLR
         0nyeklGssBzn27Yrcuwwwy5QxZp40SBgPDh/OMZVb7QGwC9ZP/owd8lK93DEDuCpkKx3
         Vjf5D9ABuLxOpBZafBdKM+Blv9NR/haZDeQfKt+uiIq7FNlFy2I6g67E6Oz5D7zvYrCl
         cxQnVhgWuBHCt87e5eB3PihnziRyHbBq2kBzteE+lKx5WGd+y5euC/cwQYGwvY0PMY93
         sI2dEX8WNrOf5h/UOPd+eCTC68psUshlRV7TEiopgReDMiuk9Vt5jOJxmqL5B+/X0syX
         reCA==
X-Gm-Message-State: AOAM531OIUKsyvVJzc35QgiPS01dNthTrc7OPO9sNivwWm1YNA7lTYqK
        GVKCOTkiyJuITbICDXegC84=
X-Google-Smtp-Source: ABdhPJynkP2gD+cmS0OSm3ZZXXts2/yMMSLbyMogjKxpLWkfcaqVfWGHjqXfHnAWLyGQEmJ9Yc/AzQ==
X-Received: by 2002:a05:620a:1981:b0:507:4a52:f310 with SMTP id bm1-20020a05620a198100b005074a52f310mr22121345qkb.611.1651211328690;
        Thu, 28 Apr 2022 22:48:48 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y18-20020ac85f52000000b002ed08a7dc8dsm1234094qta.13.2022.04.28.22.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 22:48:48 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/amdgpu: simplify the return expression of iceland_ih_hw_init
Date:   Fri, 29 Apr 2022 05:48:41 +0000
Message-Id: <20220429054841.3851915-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Simplify the return expression.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
index ddfe4eaeea05..aecad530b10a 100644
--- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
@@ -308,14 +308,9 @@ static int iceland_ih_sw_fini(void *handle)
 
 static int iceland_ih_hw_init(void *handle)
 {
-	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	r = iceland_ih_irq_init(adev);
-	if (r)
-		return r;
-
-	return 0;
+	return iceland_ih_irq_init(adev);
 }
 
 static int iceland_ih_hw_fini(void *handle)
-- 
2.25.1


