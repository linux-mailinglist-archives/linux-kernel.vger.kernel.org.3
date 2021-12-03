Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CD3467413
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242781AbhLCJd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237826AbhLCJd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:33:26 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF00C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 01:30:03 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id b13so1709306plg.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 01:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uUViAsD6NRYfhJU+LUNpde1GdyoQcY6mfcuaaublo/c=;
        b=jwBbaKkHG7YHCKYgOsAbOeepZGdhKtgseIOn3BAxtb7fsm04ujk9kCpvKV6iduYgob
         YaZwCEWFEwq/eR4Xz/7TiS0CcRu766Se4BxbezU1XdIqsuaax9PpQgOe7M6BI8sP6sss
         /NpJvjUtxFXx1ooKR91z7mHLIhNWvoCemCTZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uUViAsD6NRYfhJU+LUNpde1GdyoQcY6mfcuaaublo/c=;
        b=mnJMdigXWXnkHx2cIGCT4Yi01cHgOJ5tiyigsdaPf7XUZTLjUkkxFpbRGT4XZo/No9
         XoreOV79amyJDTmlBMoqte8vCDUwishC6bCwHEjyO2e6CV004e7Su8D8mklFk81d1M3E
         Hfp1hBzxaW1QhJIJ7ih55hAF4OPEu936eVQuDlSly1BPkFPxq2cczATLi0fr18GGK9nA
         eyZaQoNiQjui9QDu7vRZ2pUJTODXw30Px0AfN3tMexGDQEzsT4HOx5hCpZj0p60prGKX
         cAVBB0/CFkPF6tM90IQuZTsCtr89sn8/ExxAMs8yOmQmCEB/w/0sYBayefG/RDIoWp16
         mL1A==
X-Gm-Message-State: AOAM5332djYAzzwTUF4dc5Y8yFU1F+BKAmcGOV8XHHkYjeeEqwZ/Gu1h
        HDkf37YAAUIcGCLQU9sKVfRMRw==
X-Google-Smtp-Source: ABdhPJx7Ib3/rDAq1/Hx5O/1z/J0eEazZA9IxyTe+2+tC6Oqk2t7gKRn0V5Zu6ra91DZQcc0cmDksA==
X-Received: by 2002:a17:90a:4212:: with SMTP id o18mr12672794pjg.154.1638523802697;
        Fri, 03 Dec 2021 01:30:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a1sm2860175pfv.99.2021.12.03.01.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 01:30:02 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] lib/test_ubsan: Silence compile-time array bounds warnings
Date:   Fri,  3 Dec 2021 01:30:00 -0800
Message-Id: <20211203093000.3714620-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1200; h=from:subject; bh=qCMa5JNOB+3jQdARk3lO6y4bjj6mfwNGhHZcapl1AXc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhqeOYDNFA6uNwCAp2Pt6DA+UTkyqEFhnI3TI7hmPQ l2CjTbmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYanjmAAKCRCJcvTf3G3AJmYQEA CrPQB28oEdf+Duotk6AWzNp8seuGPThvn63T/8YoAt4POrc6aLmxWXgDwpgw8uBeSZi3DhS8dbHe8R ecNal1CFHSP4l3EHyJ/tm83s1cJJidqj0y+9LH8aImNcQoc670640hfEHzqAtqPnNxV6cKQsVNlKzu NkUSjAypxMK+SzcG+033457s6GD+/JtkwnICd77j42v1w4/5oB81MCcy0ucjLRVX0nCoExiF25+nIP MR5A/S/tnkU7VCdsZmfcetLrMBzaKH6sLpxnmkPMMAx4gikRolXK3x/b6A/dcCGjtofCyhH+L38NuI /zbMwEoEb6xRpFeWlSAvhNvZA33664imhZhmyCUaS54DUAxtYFzQdFJrtLK8u9ldZjqHQlgVE6NOKN ZInaBPFI47dANAy7vMtS95YPSk5ooPxVG6X5EImMAMR6KP9P0U3QUJmg/RvfAJ4bXOl33G2O7g7pOF z+D2DO/AlInq3zKFHVBNNOChOdESzbz/PaFL7e8KCOa1FHTr+kmL89Z6D7Kwj9mgyaHW+e80YKlxpw bcakVGqtDIPqe5ZjLpbjwhaO3cvizryu+LsYqQ+/oeOqoUKPUPMpGUfV+LCRVEColZ0H+H0Bhy21/5 O5OvIh2fLMVEMxtwKGBril6XB8z6IPKxj6KGCz5cjXG9+Lhbl6TwBHK4tDRw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UBSAN tests intentionally operate beyond array bounds, so silence
the warning visible with a -Warray-bounds build:

lib/test_ubsan.c: In function 'test_ubsan_object_size_mismatch':
lib/test_ubsan.c:109:16: error: array subscript 'long long int[0]' is partly outside array bounds of 'volatile int[1]' [-Werror=array-bounds]
  109 |         val2 = *ptr;
      |                ^~~~
lib/test_ubsan.c:104:22: note: while referencing 'val'
  104 |         volatile int val __aligned(8) = 4;
      |                      ^~~

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Makefile b/lib/Makefile
index 08959b10bac9..2742a54a4275 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_KASAN_MODULE_TEST) += test_kasan_module.o
 CFLAGS_test_kasan_module.o += -fno-builtin
 obj-$(CONFIG_TEST_UBSAN) += test_ubsan.o
 CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
+CFLAGS_test_ubsan.o += $(call cc-disable-warning, array-bounds)
 UBSAN_SANITIZE_test_ubsan.o := y
 obj-$(CONFIG_TEST_KSTRTOX) += test-kstrtox.o
 obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
-- 
2.30.2

