Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1F857C7A8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiGUJbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbiGUJbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:31:36 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA9780529
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:31:34 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id bf13so1128842pgb.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tUsFz55Px30MpiSri6WdI5V/eCo3oYtyYbcL/dhllTg=;
        b=RizJHC7o1k4pQRka7FRZfSJPs4tv6Qg73Nq3aKK5LkEDO8o7QZfFDVaS8w3CHInqHs
         OAkR7I0284R2CM7i+GLuE6ddqMvFr69gE7fIIsVTRhJwvhnTNduCxgX7oEhbkhCvfth7
         2sGewvdeiL5z9aJPoFK4wSQ2Otf8frwyWxDO5eZUHzi0EjfF4I77zN8gV8qX73dR02Pq
         WIJvq75Jo+DIi59YGDIxm5DG9VE4OVo5a5kP2mTbqgFLJ+7Ph+vtVlJGZCf66KY6Z8U+
         2zzUxtuEpBKkMHl91JmKMn5FdPYojsHb9xXYZwsLC8WGm3iBUSjT3KYjIQv+3VP7u61h
         I0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tUsFz55Px30MpiSri6WdI5V/eCo3oYtyYbcL/dhllTg=;
        b=DcS2dZRujL09G0Y0tvpPHsI0FYHuikfA9E8W7vtZBzuBPxvk6Hbds6kR5OSS09ZDK7
         HZGLZk17NOME8VsywvfByhSkeGtKyUf9CS71t5k4d5hXIb+Nl+SbzocjhXOa7Tj7X/ou
         2d1Qc8e5O6dRhfcahqRgVbNQGaQ6LBypaFhvnMl2/vP6d4WJ6OZLQrqJuSMUYyaX1aRr
         OsauMRfSccN9SQzWATx7+Ipxiitx5O7D8KsGgaKbVcJuxxy7buO9oEKfiNMHAZwC+ZOI
         Kx0tnVe+BeZ+zGvxykOaC6weTPqdTkfL82RDZcZf2bwmGd+0frkomcCg6jo1XkRW9cgD
         yhcw==
X-Gm-Message-State: AJIora/qk1nE4gp08GQRMPE47hflVHdJFPh8HGANimnz82z9+f0e1qlm
        QYYRVHLAcxsk3mdDLphVdaE=
X-Google-Smtp-Source: AGRyM1saLyzD+s9kp+D/uPSzMWc2PqaZu7GOfp7xjpDubxl8dRQEowDz5sIMFIOiNwhP6y/JIDz25w==
X-Received: by 2002:a05:6a00:cc9:b0:52a:b63a:4e5 with SMTP id b9-20020a056a000cc900b0052ab63a04e5mr43081340pfv.59.1658395894120;
        Thu, 21 Jul 2022 02:31:34 -0700 (PDT)
Received: from fedora.. ([103.230.107.30])
        by smtp.gmail.com with ESMTPSA id l9-20020a170903120900b0016d1bee1519sm1169846plh.102.2022.07.21.02.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 02:31:33 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Khalid Masum <khalid.masum.92@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH RESEND] scripts/gdb: Fix gdb 'lx-symbols' command
Date:   Thu, 21 Jul 2022 15:30:42 +0600
Message-Id: <20220721093042.9840-1-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the command 'lx-symbols' in gdb exits with the error`Function
"do_init_module" not defined in "kernel/module.c"`. This occurs because
the file kernel/module.c was moved to kernel/module/main.c.

Fix this breakage by changing the path to "kernel/module/main.c" in
LoadModuleBreakpoint.

Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
---
 scripts/gdb/linux/symbols.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index 46f7542db08c..dc07b6d12e30 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -180,7 +180,7 @@ lx-symbols command."""
                 self.breakpoint.delete()
                 self.breakpoint = None
             self.breakpoint = LoadModuleBreakpoint(
-                "kernel/module.c:do_init_module", self)
+                "kernel/module/main.c:do_init_module", self)
         else:
             gdb.write("Note: symbol update on module loading not supported "
                       "with this gdb version\n")
-- 
2.36.1

