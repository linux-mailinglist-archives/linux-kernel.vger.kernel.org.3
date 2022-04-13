Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE2350028C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiDMXXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239266AbiDMXW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:22:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A29FF3A5D1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649892024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9TsJJXgMRJcJ5j44p3TeuwPX8JX+llrDTE9XXD7pv2Q=;
        b=JkDM5o13rbuO2g0e/8WTdfbJaywXQHsO4KzUg422Q3i5zC5+1z1d09+Q19KqnQ1cmX21w/
        atGFSWglinclDx+VTC2vk+qXnk5uSwcRTimVOP9X7aLOAvOUUJHVtRoZvPmjCC9cqJXHqP
        /gN9qmQMCHLvQ3OQyyxvuQIFXz37S4w=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-zQHlIR8gOZqQxg5HP-Sh2A-1; Wed, 13 Apr 2022 19:20:23 -0400
X-MC-Unique: zQHlIR8gOZqQxg5HP-Sh2A-1
Received: by mail-qv1-f71.google.com with SMTP id o1-20020a0c9001000000b00440e415a3a2so3000761qvo.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9TsJJXgMRJcJ5j44p3TeuwPX8JX+llrDTE9XXD7pv2Q=;
        b=hg0PFG/vT5gn8qkCmHhjHSZo1v0w3p2mePeJtfKGoVTUv7TlB3RmDW+tStjIQRxZDR
         dIWi9Jo/5iBerY4kZjtEp9aOgSx1aO/A7uPJbvSVK/I347q0cHJxk8C8CLMAfXnB1Yh2
         VGg/gmTz3fZIm04b/CWWghCK2iQnv64dG8YBJNv2q08YwTalNjcozoAzdZmTQ5ykqoQB
         8SqzAb1HunFXUr/JlwRWETQlYqeT8hSJx5YwSG07hT46V7rIvXygUtSWF9Ysl939vVGU
         sey+RVMx6y7x9kegTDa1bkgksyeJn4529QkCmkFdQnaxmW8EVptHebNJrrxHSQeecvSq
         9UGg==
X-Gm-Message-State: AOAM530cU9cV2SHO3ObMvPFlG5bEE/6YyY/9d9mHLgamRfNxEA78Vl9M
        8KoXo3ylZyaKE4t4+p/n+Fs55r3DTndq7aIb9yGCQdm6PBVeeZmI0zEdjoLpzrvSUn0R1BJL/DV
        v6OhTXXLgoHbscxxBPAmyNUh8
X-Received: by 2002:a05:620a:4055:b0:67d:61ca:e9f2 with SMTP id i21-20020a05620a405500b0067d61cae9f2mr8351278qko.510.1649892022934;
        Wed, 13 Apr 2022 16:20:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0pFEK1wqpTmd0+kzutwacpYI6JBqcS/3lZ1NkSfSMKTJO/z4tZKaQL9ipfJLew4ZM5sOwcg==
X-Received: by 2002:a05:620a:4055:b0:67d:61ca:e9f2 with SMTP id i21-20020a05620a405500b0067d61cae9f2mr8351267qko.510.1649892022713;
        Wed, 13 Apr 2022 16:20:22 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id b20-20020a05622a021400b002f08f5658a2sm193925qtx.68.2022.04.13.16.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:20:22 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 16/18] objtool: Add HAVE_NOINSTR_VALIDATION
Date:   Wed, 13 Apr 2022 16:19:51 -0700
Message-Id: <94ba30d6e5066fb198f67a477186c89c9cea828e.1649891421.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649891421.git.jpoimboe@redhat.com>
References: <cover.1649891421.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove CONFIG_NOINSTR_VALIDATION's dependency on HAVE_OBJTOOL, since
other arches might want to implement objtool without it.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/Kconfig      | 3 +++
 arch/x86/Kconfig  | 1 +
 lib/Kconfig.debug | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index cb5fc88cb996..d0c00564bbf8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1031,6 +1031,9 @@ config ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 config HAVE_OBJTOOL
 	bool
 
+config HAVE_NOINSTR_VALIDATION
+	bool
+
 config HAVE_TOOLCHAIN_HACKS
 	bool
 	select OBJTOOL
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 410c4e2c7390..c73ca72f5d98 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -231,6 +231,7 @@ config X86
 	select HAVE_MOVE_PMD
 	select HAVE_MOVE_PUD
 	select HAVE_NMI
+	select HAVE_NOINSTR_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_OBJTOOL			if X86_64
 	select HAVE_TOOLCHAIN_HACKS		if HAVE_OBJTOOL
 	select HAVE_OPTPROBES
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index be6ca70d558a..b5fa86994fd3 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -502,7 +502,7 @@ config STACK_VALIDATION
 
 config NOINSTR_VALIDATION
 	bool
-	depends on HAVE_OBJTOOL && DEBUG_ENTRY
+	depends on HAVE_NOINSTR_VALIDATION && DEBUG_ENTRY
 	select OBJTOOL
 	default y
 
-- 
2.34.1

