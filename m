Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C274B5C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiBNVKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:10:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiBNVKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:10:11 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3226BBE1C0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:10:03 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 13so661288oiz.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O9KHV0/N+Gfd1GRgecao8wegxCnC38XHEZ75QGyEISc=;
        b=hosVhwFvGBdDFJM59PwgE1Wy9Oe3mkF9MnrGUFJ9FoiCAhftxx37tYIU9SOTBqcsD7
         wsSPNn3E0BoWvjzNAhs6aGwTAJpIfmq3ajNXqAsN6l9CR21k7REe7ZOUYKwd1ydYLUoC
         rI1fJy9gv3Jjz+5gQMh75lP41vSXjq/5PKYCvS9PPjL7bfHFKLInVSA9KdF4baDlCGcF
         W6P6zMRghtpvPi7xln6B39B/6mywe2eEhYl9L6bUnwoy0DxEN70P9DLeKGLpmwLmQiu/
         Ji5pdoom7+afBUJqEBm0RoPL4YBYxTGYzj2lmXtkG1ptnEHTAq5yfWaxNmDLkNFb4pyX
         1Sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O9KHV0/N+Gfd1GRgecao8wegxCnC38XHEZ75QGyEISc=;
        b=4TOjLrbaitiPoyRNbl1KZDrc+khFcdJkTAVPwIL+O8FxOlnKmHBxap32Muw7iG4PMx
         S2+6IA8XhKdsJJB2QrO76lfEqGnl5uYC2J/xSW76b0Ao26QRlUcN3ZLcfOqj8k5c+Hlf
         BkFFH3BgUFdDENzqL51hOiuQz4wGZNveTJJ99amnRS8lCn8nBqYYD2+bo8b8acF9j7bG
         +yMXAFzc4SwrEfh6Rqacc+0BLJ/ROFxLJ2ykdXM2XZ/tczoHSX7akh1Y/ZybnSYbgdfw
         YToMFEhSnOXMjlqmUKhXE96dyiy6JJ0xq1LnqIkoBxftIDfgWOk2wMwzLUAJ2k7KRX2y
         V6mg==
X-Gm-Message-State: AOAM530oGTn6K92T8mQc4E4eIF83Ifwokou/l17dNIITEG2iuV4nCSHp
        t7QH7PdutML5CULGBEmcv2G/WDY/706Z/Q==
X-Google-Smtp-Source: ABdhPJzhIOI72ps9ZuG6CEVrnqdXFSMazidGQ6xcG6wA+W2GqdMXI1JFgJBqpJ/chzdS9CFqPj7wCg==
X-Received: by 2002:a17:90b:4d84:b0:1b9:4109:7118 with SMTP id oj4-20020a17090b4d8400b001b941097118mr263383pjb.119.1644868743175;
        Mon, 14 Feb 2022 11:59:03 -0800 (PST)
Received: from tong-desktop.local (99-105-211-126.lightspeed.sntcca.sbcglobal.net. [99.105.211.126])
        by smtp.googlemail.com with ESMTPSA id v2sm14663291pjt.55.2022.02.14.11.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 11:59:02 -0800 (PST)
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
Subject: [PATCH v2] drm/i915: fix build issue when using clang
Date:   Mon, 14 Feb 2022 11:58:20 -0800
Message-Id: <20220214195821.29809-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YglQW7gVNoRJ7QpQ@dev-arch.archlinux-ax161>
References: <YglQW7gVNoRJ7QpQ@dev-arch.archlinux-ax161>
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

drm/i915 adds some extra cflags, namely -Wall, which causes
instances of -Wformat-security to appear when building with clang, even
though this warning is turned off kernel-wide in the main Makefile:

> drivers/gpu/drm/i915/gt/intel_gt.c:983:2: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
>         GEM_TRACE("ERROR\n");
>         ^~~~~~~~~~~~~~~~~~~~
> ./drivers/gpu/drm/i915/i915_gem.h:76:24: note: expanded from macro 'GEM_TRACE'
>  #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
>                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/kernel.h:369:3: note: expanded from macro 'trace_printk'
>                 do_trace_printk(fmt, ##__VA_ARGS__);    \
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/kernel.h:383:30: note: expanded from macro 'do_trace_printk'
>                 __trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);   \
>                                           ^~~~~~~~~~~~~~~~
>drivers/gpu/drm/i915/gt/intel_gt.c:983:2: note: treat the string as an argument to avoid this

This does not happen with GCC because it does not enable
-Wformat-security with -Wall. Disable -Wformat-security within the i915
Makefile so that these warnings do not show up with clang.

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---

v2: revise commit message

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

