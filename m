Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6CA51ACC9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376974AbiEDScm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376832AbiEDScd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AD5A6929C
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 11:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651687674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=U2oH/67Q6J//FOI1Qnr6N8qBEkny2Ova2tLym2RSN54=;
        b=GxsA/7uM8kcB05HIGd/ls4KhLU6b4UXNEwCR57zwBMOZoBSEBOSnFA8A8yxVd8dCmRtNJI
        VCoFum36fRx4QfiE8VEPaIqRWPHnAahmNuZT1OJJFPbsHPWwHpj/K86Mj8clvECJSOav3y
        g9p38VkIOh22eQPdZ5Olt3zZjDAQznA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-unIkFAOXPbiXbNbY3QTpWw-1; Wed, 04 May 2022 14:07:53 -0400
X-MC-Unique: unIkFAOXPbiXbNbY3QTpWw-1
Received: by mail-qv1-f72.google.com with SMTP id j1-20020a0cf9c1000000b0045abd139f01so836261qvo.23
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 11:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U2oH/67Q6J//FOI1Qnr6N8qBEkny2Ova2tLym2RSN54=;
        b=kgJNSIJTlV+Q0Y3FsuYJYHMZC4CAxRtyq9VxS1qyb1Y15UK+pPC7GZDoToRrclk9ip
         285qDvRvBhCsS7eTLQNGBgxjjldyS8WME4BCOB4wOHg3zk23Jro8XJKgs+ukDEXejfM1
         mtQf01z9Vb5qMzGe0475ZWLM3AGFiqQFKo5a5lVM3YYzk8RXR2gaJSnS14A1Yh7eey5S
         IBcw+pW7+kO/EyGyA6+7LmJiZ4TrgDI3UbK5GYhavcNCy2q48v7acURyOJ9ICuZDy9dN
         cm0QXmZuj0uNfrevaIR7yK2p0v58jAYFlkI4fL3VjtjgxGikqDLmGgceITdDijIClpm3
         LjeA==
X-Gm-Message-State: AOAM533Qmjr2jCeOE+8PkL01WHHK29TzQv1BQbdowSoChBev2NMYHGzs
        1mS3k12cvUjDDYkkwdYVAqyV5oeMu1iuTvN/U67omsguH+XcWNXIaFme5oIahSWKZvJlfBEt7r7
        iuQ7nR3CvtyF6N/qVpyItWE1x
X-Received: by 2002:a05:620a:c86:b0:69f:c7cb:935a with SMTP id q6-20020a05620a0c8600b0069fc7cb935amr15045718qki.229.1651687672269;
        Wed, 04 May 2022 11:07:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzq8xseyCKLx3yTn4pbs5KU3Ozho0NQF62zufox08OSuR9+Q1nSdIEfs+h6LEGhzXTAvrcyA==
X-Received: by 2002:a05:620a:c86:b0:69f:c7cb:935a with SMTP id q6-20020a05620a0c8600b0069fc7cb935amr15045693qki.229.1651687672022;
        Wed, 04 May 2022 11:07:52 -0700 (PDT)
Received: from treble.attlocal.net ([2600:1700:6e32:6c00::c])
        by smtp.gmail.com with ESMTPSA id k16-20020ac84790000000b002f39b99f6c1sm7581297qtq.91.2022.05.04.11.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 11:07:51 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update Josh Poimboeuf's email address
Date:   Wed,  4 May 2022 11:07:45 -0700
Message-Id: <1abc3de4b00dc6f915ac975a2ec29ed545d96dc4.1651687652.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change to my kernel.org email address.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 MAINTAINERS | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index edc96cdb85e8..1e1a2264792d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7499,7 +7499,7 @@ F:	Documentation/hwmon/f71805f.rst
 F:	drivers/hwmon/f71805f.c
 
 FADDR2LINE
-M:	Josh Poimboeuf <jpoimboe@redhat.com>
+M:	Josh Poimboeuf <jpoimboe@kernel.org>
 S:	Maintained
 F:	scripts/faddr2line
 
@@ -11348,7 +11348,7 @@ F:	drivers/mmc/host/litex_mmc.c
 N:	litex
 
 LIVE PATCHING
-M:	Josh Poimboeuf <jpoimboe@redhat.com>
+M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Jiri Kosina <jikos@kernel.org>
 M:	Miroslav Benes <mbenes@suse.cz>
 M:	Petr Mladek <pmladek@suse.com>
@@ -14224,7 +14224,7 @@ F:	lib/objagg.c
 F:	lib/test_objagg.c
 
 OBJTOOL
-M:	Josh Poimboeuf <jpoimboe@redhat.com>
+M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
 S:	Supported
 F:	tools/objtool/
@@ -18792,7 +18792,7 @@ F:	include/dt-bindings/reset/starfive-jh7100.h
 
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
-M:	Josh Poimboeuf <jpoimboe@redhat.com>
+M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Jason Baron <jbaron@akamai.com>
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Ard Biesheuvel <ardb@kernel.org>
@@ -21444,7 +21444,7 @@ F:	arch/x86/kernel/apic/x2apic_uv_x.c
 F:	arch/x86/platform/uv/
 
 X86 STACK UNWINDING
-M:	Josh Poimboeuf <jpoimboe@redhat.com>
+M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
 S:	Supported
 F:	arch/x86/include/asm/unwind*.h
-- 
2.34.1

