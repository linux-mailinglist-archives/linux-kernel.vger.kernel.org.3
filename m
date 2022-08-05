Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C0458B197
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241759AbiHEVz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241677AbiHEVys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:54:48 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E4E7B1D5;
        Fri,  5 Aug 2022 14:54:36 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id i84so2858888ioa.6;
        Fri, 05 Aug 2022 14:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Wy5iLP6AZumShjO+0eNESryd3jL0wHYWEmUuoQeB6Wk=;
        b=FJi9ZS8yNGWRuVXEb1kvd352nLf1hSziwSVWIreKLSVMpu8X1lYShDpLSG9DVDiQja
         82lnfmTC2tmKCrZLriqdeqfnM8e6qf48GgYX45/llrO+De/9603wtfNrO5/eA1JI0dDj
         9GaziLwHSRjV4Y5rbQp9HqPwwG/4cBnULRwRUkXoacFn1iUOiHt2LnRFGZCuTnpz+8Xe
         f6JsXNI1JUK5pPe9PVM2ltwYzcidAYcZlXtUUbQp0AlcSs1VB9kXIdc2/mR+4iNQObCx
         4ZDMAd560TWKJ3kItAwAObe++DeFtMS/nWUW9rAtgdHZM6tyOjviEK5TqVVn7A76ghSP
         J+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Wy5iLP6AZumShjO+0eNESryd3jL0wHYWEmUuoQeB6Wk=;
        b=3vtBBzzL9lO32nXE/ZpH85RumtTxleRQpZnsMVONNMXIf+J+B8HFH+GVN7ZIsegUiC
         NhJPmfA1FqdNlyndfpHcesw3k7TIDf0iOPedX4t4A0nVBuPuOhN5cOmLt0LCnsREq0Un
         7z7PckvCGga1IBZbdRmklwiXj+WQ3H3ycsYHYOwvDWPGr7bDPeN9NR5IePArzKL3rCGF
         qbU8lFk0A8sqO12uVpasf+IlGT/erDgsjPLTsl9SBlHCTuQ9pSRmpqfVWDCLCEZIJeiY
         rOz9vRHvGfintOVUzFGoZaS0v2TfIbQNmBq+bIgy2z31byoF+t5p+g/3NoNwDaL0zQGf
         TKcg==
X-Gm-Message-State: ACgBeo2+TZIjZn6cKIWKMzXnJ7MFztiH/dYZAW+YX65CGuHPq/BisHFY
        znKX9VbMVCW1OuiiCfe/zDGT86oLCE8JTw==
X-Google-Smtp-Source: AA6agR5rftNopfD1MVDtLO+pW5nBNveJnieow1ouxMckvYPN9UxAo5uwg6bO3/M4RzbjvwaptL/vLA==
X-Received: by 2002:a05:6638:1408:b0:342:86c4:52bd with SMTP id k8-20020a056638140800b0034286c452bdmr3980760jad.119.1659736474811;
        Fri, 05 Aug 2022 14:54:34 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b0067c09fd0b53sm1765532iov.21.2022.08.05.14.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:54:34 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 13/33] dyndbg: add __pr_debug_cls for testing
Date:   Fri,  5 Aug 2022 15:53:35 -0600
Message-Id: <20220805215355.3509287-14-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805215355.3509287-1-jim.cromie@gmail.com>
References: <20220805215355.3509287-1-jim.cromie@gmail.com>
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

For selftest purposes, add __pr_debug_cls(class, fmt, ...)

I didn't think we'd need to define this, since DRM effectively has it
already in drm_dbg, drm_devdbg.  But test_dynamic_debug needs it in
order to demonstrate all the moving parts.

Note the __ prefix; its not intended for general use, at least until a
need emerges.  ISTM the drm.debug model (macro wrappers inserting enum
const 1st arg) is the baseline approach.

That said, nouveau might want it for easy use in its debug macros. TBD.

NB: it does require a builtin-constant class, __pr_debug_cls(i++, ...)
is disallowed by compiler.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index b6803f7e818f..cb4696c91901 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -221,6 +221,13 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 				   KERN_DEBUG, prefix_str, prefix_type,	\
 				   rowsize, groupsize, buf, len, ascii)
 
+/* for test only, generally expect drm.debug style macro wrappers */
+#define __pr_debug_cls(cls, fmt, ...) do {			\
+	BUILD_BUG_ON_MSG(!__builtin_constant_p(cls),		\
+			 "expecting constant class int/enum");	\
+	dynamic_pr_debug_cls(cls, fmt, ##__VA_ARGS__);		\
+	} while (0)
+
 #else /* !CONFIG_DYNAMIC_DEBUG_CORE */
 
 #include <linux/string.h>
-- 
2.37.1

