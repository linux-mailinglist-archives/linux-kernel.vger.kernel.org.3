Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DD54A879C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351790AbiBCPXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:23:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26155 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231181AbiBCPXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:23:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643901798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FyaICBNYXFogXQpGuOXvlvkFpwrbiEbZFhG8GrBvphk=;
        b=F07RxNi0SjZh2ANuhrls5fm7sqOcOObbOCVsHcZ95Q5jH3BBjPgA6FPl/+3s+92Qyfkhqx
        c9hDRHu6BaJxG9SoFXv7ol9CFvF6iqFAs23yl0RXRuFFiElCsUI3nX6agPAkUz9QuCErLi
        IoQaq5lEXCMNnthE8WNQMNM7Q+kwbPs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-gxxQFHh2MraLoSyhY3zw3w-1; Thu, 03 Feb 2022 10:23:17 -0500
X-MC-Unique: gxxQFHh2MraLoSyhY3zw3w-1
Received: by mail-qt1-f197.google.com with SMTP id w25-20020ac84d19000000b002d2966d66a8so2165621qtv.18
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 07:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FyaICBNYXFogXQpGuOXvlvkFpwrbiEbZFhG8GrBvphk=;
        b=zJuBpvf4nc2nSOj27pkR1FQONi4B1V9fn7JTtcMLqEoKJ28mteIpyZdKwjYyinygre
         KKlxOlSEjjiY0APPqlvMI8bb8qBKaZj8vwU7APf1fkomSkbEElxedyfoe37YE1w934Yj
         r0RCSeH9E7TY0FgK7dGy+41kRe39VwFFcMfls7ALFcx3ME+fDKB3o5c7hbwNl6rwL72m
         33PJfPs6rI4jfqoMowe6iXdcbliaSy2wcSud8dBG4DGuOr7YFzvvG6A8jkefhjyE9F9v
         Z43LLp+u+nC+uykCkcGdss+nVwkZ8Y25u5LEg5r8gXnehWV7RMlSk5BSqRniWA1vv8bl
         MTqg==
X-Gm-Message-State: AOAM532KkQ6l3UDqRSYJPyijFCubsTTF4cjjfwChu1VRn42IOrYvZ6mL
        fr/l80CyIiDrULBWquxbyImgrNir50jBgyNpQhpffrTRSb/oUasoMNu7oNz21g/TNfuDGNHfDV5
        BL2qFs2QutnpLEfEi2E6f+LXP
X-Received: by 2002:a05:6214:767:: with SMTP id f7mr31309315qvz.32.1643901797238;
        Thu, 03 Feb 2022 07:23:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKoZK62v8/DrZws5sOsM70Uxo6BwdmPV1YiNBPk723GMaQhV5IIhjTr/Mj5MVVcyOlC4yv6g==
X-Received: by 2002:a05:6214:767:: with SMTP id f7mr31309297qvz.32.1643901797012;
        Thu, 03 Feb 2022 07:23:17 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id w22sm9746568qtk.7.2022.02.03.07.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 07:23:16 -0800 (PST)
From:   trix@redhat.com
To:     airlied@redhat.com, tzimmermann@suse.de, airlied@linux.ie,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com,
        maxime@cerno.tech
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/ast: fix using freed memory
Date:   Thu,  3 Feb 2022 07:23:05 -0800
Message-Id: <20220203152305.1846862-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this problem
ast_mode.c:1235:3: warning: Use of memory after it is freed
  drm_connector_update_edid_property(&ast_connector->base, edid);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The second condition on

  if (!flags && ast_connector->i2c)

Means that the edid is not always set.  If the previous block
fails the freed edid value will be used.  So set edid to NULL
after freeing.

Fixes: 55dc449a7c60 ("drm/ast: Handle failed I2C initialization gracefully")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/ast/ast_mode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index ab52efb15670e..9131dc8a1a2fc 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -1224,10 +1224,12 @@ static int ast_get_modes(struct drm_connector *connector)
 			return -ENOMEM;
 
 		flags = ast_dp501_read_edid(connector->dev, (u8 *)edid);
-		if (flags)
+		if (flags) {
 			ast->dp501_maxclk = ast_get_dp501_max_clk(connector->dev);
-		else
+		} else {
 			kfree(edid);
+			edid = NULL;
+		}
 	}
 	if (!flags && ast_connector->i2c)
 		edid = drm_get_edid(connector, &ast_connector->i2c->adapter);
-- 
2.26.3

