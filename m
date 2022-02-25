Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734FB4C3CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 05:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237309AbiBYEPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 23:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbiBYEPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 23:15:49 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36062465FF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 20:15:17 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k10-20020a056902070a00b0062469b00335so2055530ybt.14
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 20:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=V/zZiSLYVeJ/Lg+Y6JnRNr2aJowskIQ47n0O75C17hY=;
        b=BrDEKNdiU38gSE2PJgVcClRw2uwGDamA0bA2lL/q4cGz6etiRgJAE/T9wYZTs8NbBw
         moGxQxZtTmLAbuFmUNmGd7NMqjJdEeqviwaRWlaNJC8C1cQ5uZbqQnXK+R7GG0lZprr0
         M0dp2l7RByYHyuXLJERWZ94vcXIuH7CQM06L6GPUxEliv2QsFYBLD637bDpmoaOskx/d
         xrPCsQg9Y9f4BmkEEz9BFjQg89Z8+FhIVtpBtKMyhOkkKGq6f5mudUXwMfzmX2wvJaM1
         vogVsVCg3yl3wgOY1iSyco3FxDHsiIQ817X40RXGiwR6EkNKyjdnoatobsmJStFi+/Zl
         Vagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=V/zZiSLYVeJ/Lg+Y6JnRNr2aJowskIQ47n0O75C17hY=;
        b=kXGYyQ895Gl4GEwUckDq60EXtbmXZczqoCBwPIOwqo31iOlNvTB5B7usRqcopqJYm2
         mx++qaWtSgo3xNcwYU+eiMkX4y/J8sZp0DncYNucp0FbXP0elz0F9k261VN9/dJiB4HF
         PQ7q5QCtrL3n+Wgcz2Y4N1EZeEpBjQxIVJpGHhFSCZ8KaGm6nqolRpNR0LMNb0p2dVkw
         zGsf+orQCML8smp9tXy7V8/dN/MIk4SoWG/P2SzXRskjnmZTb9HuuXXqBobAnaJtg/OS
         ObxPoMJb+WFjNTk8Utmo0feCELK3gNNn7ulsWiOaheOAVK3GJx12P4KrXKal0dg3mq/n
         hipg==
X-Gm-Message-State: AOAM530DiudX9x5j/38Cr614PyeTT4yfpMaik7fFa53XaN8CYw/HQ8D/
        P0w2B3Es89liMokjIVYJmlOzYAjlp4lonQ==
X-Google-Smtp-Source: ABdhPJy5ZPXO+4+vi4F6ZM4sJHKrvS0eX+DfLxUgxZmM4eoIQSg7gTzjw5Yg9xOnAnM5PtwqeCaxbqCnbLOowg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a0d:e254:0:b0:2d6:b453:3188 with SMTP id
 l81-20020a0de254000000b002d6b4533188mr5870078ywe.116.1645762517020; Thu, 24
 Feb 2022 20:15:17 -0800 (PST)
Date:   Fri, 25 Feb 2022 12:15:02 +0800
Message-Id: <20220225041502.1901806-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2] firmware: google: Properly state IOMEM dependency
From:   David Gow <davidgow@google.com>
To:     Julius Werner <jwerner@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Hutchings <ben@decadent.org.uk>
Cc:     David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        linux-um@lists.infradead.org,
        anton ivanov <anton.ivanov@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Google Coreboot implementation requires IOMEM functions
(memmremap, memunmap, devm_memremap), but does not specify this is its
Kconfig. This results in build errors when HAS_IOMEM is not set, such as
on some UML configurations:

/usr/bin/ld: drivers/firmware/google/coreboot_table.o: in function `coreboot_table_probe':
coreboot_table.c:(.text+0x311): undefined reference to `memremap'
/usr/bin/ld: coreboot_table.c:(.text+0x34e): undefined reference to `memunmap'
/usr/bin/ld: drivers/firmware/google/memconsole-coreboot.o: in function `memconsole_probe':
memconsole-coreboot.c:(.text+0x12d): undefined reference to `memremap'
/usr/bin/ld: memconsole-coreboot.c:(.text+0x17e): undefined reference to `devm_memremap'
/usr/bin/ld: memconsole-coreboot.c:(.text+0x191): undefined reference to `memunmap'
/usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_section_destroy.isra.0':
vpd.c:(.text+0x300): undefined reference to `memunmap'
/usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_section_init':
vpd.c:(.text+0x382): undefined reference to `memremap'
/usr/bin/ld: vpd.c:(.text+0x459): undefined reference to `memunmap'
/usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_probe':
vpd.c:(.text+0x59d): undefined reference to `memremap'
/usr/bin/ld: vpd.c:(.text+0x5d3): undefined reference to `memunmap'
collect2: error: ld returned 1 exit status

Signed-off-by: David Gow <davidgow@google.com>
Acked-By: anton ivanov <anton.ivanov@cambridgegreys.com>
Acked-By: Julius Werner <jwerner@chromium.org>
---

Changes since v1:
http://lists.infradead.org/pipermail/linux-um/2022-February/002266.html
- Fix to depend on HAS_IOMEM, not IOMEM
- Add Acked-By tags.

---
 drivers/firmware/google/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
index 931544c9f63d..983e07dc022e 100644
--- a/drivers/firmware/google/Kconfig
+++ b/drivers/firmware/google/Kconfig
@@ -21,7 +21,7 @@ config GOOGLE_SMI
 
 config GOOGLE_COREBOOT_TABLE
 	tristate "Coreboot Table Access"
-	depends on ACPI || OF
+	depends on HAS_IOMEM && (ACPI || OF)
 	help
 	  This option enables the coreboot_table module, which provides other
 	  firmware modules access to the coreboot table. The coreboot table
-- 
2.35.1.574.g5d30c73bfb-goog

