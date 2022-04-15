Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20186502F67
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 21:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350135AbiDOTyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 15:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349438AbiDOTyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 15:54:47 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3054B606FE;
        Fri, 15 Apr 2022 12:52:17 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-ddfa38f1c1so8844774fac.11;
        Fri, 15 Apr 2022 12:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h2cm2MOSanSaC5THCY+jxKX6TMWCJF7G2UyzKGGQSKs=;
        b=WwmwdajH7rmAtSPWosmaYAXStkl/64jZYAjbvfpvwCxMk65CoGzvyYWxG7JhR+fCVN
         S2/is+iseWMKw5HekCTf5vnymBsAOf0FYcaFcJ4A7qxMTY2uiibUEUmBjFbuit2O/0ZF
         acQ4LO4Yss6IP5GeBMOsawRZmdis0GPGDNjqmeVF57ztgoz9VQOW+xfXWyTX4PkHIldx
         ZeoZB/aXKe0L0AJY4gPu6B3mXSNa7kyTG6HWJXLkTzF6P0ceUyLNkMkq852esBL+VOI1
         jdSW0RkistXlp/RgRq0iJfopv3JnRZfyCio14v6B5ayXwc5YPudqxxKhLZngKfKkYE6P
         fqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h2cm2MOSanSaC5THCY+jxKX6TMWCJF7G2UyzKGGQSKs=;
        b=QfXB0maCYrfQjYLkC0cWTtLYSr3XPCeGopHMevk7pc1qB28/5Q0KqCf2CpCMozal5h
         iKk30Or0QxtpMqz5inwXGYU3tP6fZeW/bSO3t371uOrqM6lWB5MLIR0e/ctvauQ/kYUh
         65elUg4uefbC9kCWK1VLMxnQGf1exJsL2QpmmGAvQ4OdLuAj9850X6Kc2k5ht+LYnBAe
         NpWpQtvcWWWw/6eQ0oc8TwjN2CnH0hXNHnq4RTLJ7xCtzsjuC8iK5prqcL6HcO5wU1mc
         lMOK9VSeZGNvjQ6a76ReJL2i6HhsKCWrKcCUGxl7GZKTJcaiTisUFtiWNgPUnA5jCn9l
         73wg==
X-Gm-Message-State: AOAM530BNufXCJ/0s7dXP5RXGyoihzLjg15RAw6QhJBIu9emwZ/nXN2F
        jWRDwwXyD+Ej2Z6Ph6b3UX1LZgg5VatOHW5F
X-Google-Smtp-Source: ABdhPJxc8hCohn7Hi89V96Nkrg4BGBjU+19UhktljNUWu96rQH/UKyqwQtNGlYFgtKC/A1aqTpzTMA==
X-Received: by 2002:a05:6870:c6a3:b0:e5:9a53:28d2 with SMTP id cv35-20020a056870c6a300b000e59a5328d2mr1468998oab.96.1650052334944;
        Fri, 15 Apr 2022 12:52:14 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8a9b:dcc3:45ee:2581:b4cb])
        by smtp.gmail.com with ESMTPSA id c20-20020a4a2854000000b00329d3f076aasm1436532oof.24.2022.04.15.12.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 12:52:14 -0700 (PDT)
From:   Tales Lelo da Aparecida <tales.aparecida@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrealmeid@riseup.net
Cc:     Tales Lelo da Aparecida <tales.aparecida@gmail.com>
Subject: [PATCH 2/2] MAINTAINERS: add docs entry to AMDGPU
Date:   Fri, 15 Apr 2022 16:50:27 -0300
Message-Id: <20220415195027.305019-3-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415195027.305019-1-tales.aparecida@gmail.com>
References: <20220415195027.305019-1-tales.aparecida@gmail.com>
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

To make sure maintainers of amdgpu drivers are aware of any changes
 in their documentation, add its entry to MAINTAINERS.

Signed-off-by: Tales Lelo da Aparecida <tales.aparecida@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d54b9f15ffce..b3594b2a09de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16449,6 +16449,7 @@ S:	Supported
 T:	git https://gitlab.freedesktop.org/agd5f/linux.git
 B:	https://gitlab.freedesktop.org/drm/amd/-/issues
 C:	irc://irc.oftc.net/radeon
+F:	Documentation/gpu/amdgpu/
 F:	drivers/gpu/drm/amd/
 F:	drivers/gpu/drm/radeon/
 F:	include/uapi/drm/amdgpu_drm.h
-- 
2.35.1

