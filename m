Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AE7500286
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239109AbiDMXXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239206AbiDMXWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:22:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19CC32899F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649892023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qUjGUDFGqMEo+MVbOZaiIzdIYLW+uz87eKQwOgrZglU=;
        b=QBBNNp7y3K5gKyx6SnZb8oEq99XLdAGFGXCg1knJGauV6wL7K5Tb7JPbt+AfBQmapSZgyV
        9IA3MJsc3bb54bV2+NIOAzNzaqNqHqPv/Le9dhkMHmm+MVmP3mB9da0oC/HA+vvHdX31VV
        m4Qim9Dz4Y1QSVcRFFGb26Xup8A7lQs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-h3jFYSdAME-tWJtBBo9eig-1; Wed, 13 Apr 2022 19:20:22 -0400
X-MC-Unique: h3jFYSdAME-tWJtBBo9eig-1
Received: by mail-qv1-f72.google.com with SMTP id jz4-20020a0562140e6400b004461f104a7cso1072761qvb.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qUjGUDFGqMEo+MVbOZaiIzdIYLW+uz87eKQwOgrZglU=;
        b=LuV3uWi92jGbtUf4QymbkKqxsskCAFCsuVCa6lPc42oUfKdmx9DYhRVZav6Jpgrs+p
         OvLgENeJjXVnydmpvo204+jn9PQokkGW53sx8EFXY44BatNOSDVdq3ItbOx+dePm6R57
         RLGEuyA03rSMJx7CUPzTLH822kEzoc9F2b50Fq8tYi4QDJfRqXCF5j0CA5GLrgTiBYHB
         VeFpTWbrh/2iQQwVW3mAEuCUkWeI3tbu+oAGMfKeg1jIFPAp02zC1ILhcYzfXiJRBZYr
         H2uWhVv4lpNmNW5I1B27naYrD90r3Apgmkc/ckVe4AoF/+RnbWKlDKQEeixdmFQVbxbm
         YasQ==
X-Gm-Message-State: AOAM533lIHHcSYMah9XLiu7WrScQsNtXfvjQaGDzNHo3Tx79Kz40J3yD
        xulzhTdb6UtHHllwTzE7A1/TrTlYggnPZCV96GNoZ6Y2mxZJRtIQdTbQHIFLkDmODpEE7Ulqnud
        LeEZZ1hlO9Vhune77SdEuOqJE
X-Received: by 2002:ac8:70d8:0:b0:2ef:cee5:b117 with SMTP id g24-20020ac870d8000000b002efcee5b117mr9049865qtp.115.1649892021452;
        Wed, 13 Apr 2022 16:20:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgkiS+yVYgbKFfVpVm+LB8DEXJ4HafDZjeVew0YcW7PGYdn9Dx4Yt/KMUMTDyBStPOjByEUQ==
X-Received: by 2002:ac8:70d8:0:b0:2ef:cee5:b117 with SMTP id g24-20020ac870d8000000b002efcee5b117mr9049857qtp.115.1649892021194;
        Wed, 13 Apr 2022 16:20:21 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id b20-20020a05622a021400b002f08f5658a2sm193925qtx.68.2022.04.13.16.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:20:20 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 15/18] objtool: Rename "VMLINUX_VALIDATION" -> "NOINSTR_VALIDATION"
Date:   Wed, 13 Apr 2022 16:19:50 -0700
Message-Id: <8d830d35e1fef33378192ac1a1c6291920618a2f.1649891421.git.jpoimboe@redhat.com>
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

CONFIG_VMLINUX_VALIDATION is just the validation of the "noinstr" rules.
That name is a misnomer, because now objtool actually does vmlinux
validation for other reasons.

Rename CONFIG_VMLINUX_VALIDATION to CONFIG_NOINSTR_VALIDATION.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 include/linux/instrumentation.h | 6 +++---
 lib/Kconfig.debug               | 2 +-
 scripts/link-vmlinux.sh         | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/instrumentation.h b/include/linux/instrumentation.h
index 9111a3704072..bc7babe91b2e 100644
--- a/include/linux/instrumentation.h
+++ b/include/linux/instrumentation.h
@@ -2,7 +2,7 @@
 #ifndef __LINUX_INSTRUMENTATION_H
 #define __LINUX_INSTRUMENTATION_H
 
-#ifdef CONFIG_VMLINUX_VALIDATION
+#ifdef CONFIG_NOINSTR_VALIDATION
 
 #include <linux/stringify.h>
 
@@ -53,9 +53,9 @@
 		     ".popsection\n\t" : : "i" (c));			\
 })
 #define instrumentation_end() __instrumentation_end(__COUNTER__)
-#else /* !CONFIG_VMLINUX_VALIDATION */
+#else /* !CONFIG_NOINSTR_VALIDATION */
 # define instrumentation_begin()	do { } while(0)
 # define instrumentation_end()		do { } while(0)
-#endif /* CONFIG_VMLINUX_VALIDATION */
+#endif /* CONFIG_NOINSTR_VALIDATION */
 
 #endif /* __LINUX_INSTRUMENTATION_H */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 616b93d5db6d..be6ca70d558a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -500,7 +500,7 @@ config STACK_VALIDATION
 	  For more information, see
 	  tools/objtool/Documentation/stack-validation.txt.
 
-config VMLINUX_VALIDATION
+config NOINSTR_VALIDATION
 	bool
 	depends on HAVE_OBJTOOL && DEBUG_ENTRY
 	select OBJTOOL
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 480a49e47fbc..96dbaaeaecd1 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -156,7 +156,7 @@ objtool_link()
 		objtoolopt="${objtoolopt} --lto"
 	fi
 
-	if is_enabled CONFIG_VMLINUX_VALIDATION; then
+	if is_enabled CONFIG_NOINSTR_VALIDATION; then
 		objtoolopt="${objtoolopt} --noinstr"
 	fi
 
-- 
2.34.1

