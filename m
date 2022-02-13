Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F48B4B39E8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 08:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbiBMGvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 01:51:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbiBMGvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 01:51:40 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255795DE4B
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 22:51:35 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id i6so21854796pfc.9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 22:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8jN3bHrs2SjohtF/Og+xdp1QXzW54h0HCo7HFf5/MZw=;
        b=eGO6WKGk4GF2G1wmSF6YwpVCyUpzoU7kgAHkt2OWvZscvoVLb2sotXMmB0JArmFkdH
         GZxv240kCgeHEhPXTYzUDow84izMIzZxlfxRqdHQ6poqNxgqd3SBEdZaBIbOt2VfzCOz
         WB90oXtyxZJqjWoJkG72qtck4qMxHp+GNv+NNlHkFfVAzLOP6WpCXganJp/d3GKhz3Yp
         dDQ2IWWdYJRDLLYVl86vEf0KIoDIv6kqdWbViLcQzUP/6utM0FpBiWqZQKW5fLsjZNxa
         AqbUxPohLLEDKau9zLqZLxyzAnQdLrzEjf/iAMJb2D4TcTY3N0qUMmOdvnfMu8pjio9Y
         a0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8jN3bHrs2SjohtF/Og+xdp1QXzW54h0HCo7HFf5/MZw=;
        b=K86focrZ0ljOzY7UG5HOuN5yhyA+dSzMvZruTx1apyg2rQ/HDR5qHW5ycSeGLJtDAB
         mki8rxXAaRyVEMkK2+4TOjGCuDX5mXTd9QMzV8V+lJd6Pjtpnyrd77TFz/VMgD+pewm+
         YySpaCngsWrTyxDcMPfPNcx2U+9AlaMiYsA19MInSPGL9qTxz34AiX8jqFXerJk7Rlwj
         nk0SBo+qOo/r/rBnZA8ZWp7mQzFCui9lIoAhGv64WCo+ic0FALaCBq49zxJbZhf0ZvCY
         gTFAEUTdCwBCf7WELKIEDps2txeUZhfF0sDffDEtV1pokf/pfq7g5TONFwc6rtiPqeJC
         3Jww==
X-Gm-Message-State: AOAM531Qn/HbWi1DmlG4Tj71OQzJmQKMOib+uIRTGquZ5QFzxU0rmB5W
        WdCw/NONdaEFT/0vZssDcaE=
X-Google-Smtp-Source: ABdhPJzJFjlAe/vGkkjEE8ukKoZrPMom+3E9OHjTtQHdOrydJ0vW9rr7l+VrgOEHXNJQZysF9XqUjQ==
X-Received: by 2002:a63:d318:: with SMTP id b24mr7253607pgg.255.1644735094326;
        Sat, 12 Feb 2022 22:51:34 -0800 (PST)
Received: from ubuntu-server.local (99-105-211-126.lightspeed.sntcca.sbcglobal.net. [99.105.211.126])
        by smtp.googlemail.com with ESMTPSA id v2sm9794515pjt.55.2022.02.12.22.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 22:51:34 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc:     Tong Zhang <ztong0001@gmail.com>
Subject: [PATCH] drm/i915: fix build issue when using clang
Date:   Sat, 12 Feb 2022 22:51:06 -0800
Message-Id: <20220213065106.48062-1-ztong0001@gmail.com>
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

drm/i915 target adds some extra cflags, especially it does re-apply -Wall.
In clang this will override -Wno-format-security and cause the build to
fail when CONFIG_DRM_I915_WERROR=y. While with GCC this does not happen.
We reapply -Wno-format-security here to get around this issue.

drivers/gpu/drm/i915/gt/intel_gt.c:983:2: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
        GEM_TRACE("ERROR\n");
        ^~~~~~~~~~~~~~~~~~~~
./drivers/gpu/drm/i915/i915_gem.h:76:24: note: expanded from macro 'GEM_TRACE'
 #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
                       ^~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/kernel.h:369:3: note: expanded from macro 'trace_printk'
                do_trace_printk(fmt, ##__VA_ARGS__);    \
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/kernel.h:383:30: note: expanded from macro 'do_trace_printk'
                __trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);   \
                                           ^~~~~~~~~~~~~~~~
drivers/gpu/drm/i915/gt/intel_gt.c:983:2: note: treat the string as an argument to avoid this

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/gpu/drm/i915/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 1b62b9f65196..c04e05a3d39f 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -13,6 +13,7 @@
 # will most likely get a sudden build breakage... Hopefully we will fix
 # new warnings before CI updates!
 subdir-ccflags-y := -Wall -Wextra
+subdir-ccflags-y += -Wno-format-security
 subdir-ccflags-y += -Wno-unused-parameter
 subdir-ccflags-y += -Wno-type-limits
 subdir-ccflags-y += -Wno-missing-field-initializers
-- 
2.25.1

