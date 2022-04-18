Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F37505D0C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346645AbiDRQ5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346630AbiDRQ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:56:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 653B434BB4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650300733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WHwtgBFXaVRPDxpgXVknAcXgf6im9N3NqhP05P8+ItY=;
        b=K+tLHQOcqfZJqA82ngLxu9EfYGZvJbRyelKKqYwawmF/hctj9LBgQ042fo11ncrIVdBp/n
        oerK0SYisg1sIg0vJJb7+OK8H451gp12QjeR/5C3f6oK1a1mhT0GqIb4iDYv1yRYgpnOKC
        LzMRiVd8AMJ07+eB/vrUy6ew3T0iVJ4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-SHPNHb6tO6mlmiXqA_mGFA-1; Mon, 18 Apr 2022 12:50:54 -0400
X-MC-Unique: SHPNHb6tO6mlmiXqA_mGFA-1
Received: by mail-qv1-f72.google.com with SMTP id eo13-20020ad4594d000000b004466661ece9so1379959qvb.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WHwtgBFXaVRPDxpgXVknAcXgf6im9N3NqhP05P8+ItY=;
        b=Cp20nsAWqDC9+AA2EFTaoLZPerTNyVXB8bMJOyWYrvh2u31x+uxWVTvG5yfNIy/+QQ
         Tj7z1wD5cihWeMvlTK785KJB4ZGbA5poo8Jlm8MnW+eJU0E09zgyZRgFE5hZeEEyRTTG
         q6Jf8mgPU/mYiPPE7cab98HXkfMeouDQNIwMW7Gqo3PMIws/kCgYZ+erw4fetIH3CjLU
         4Lz71ob4RkW4LTqtkrxv/V8uJRDu/IRENKf6qnEaO7xaqWPM4peG6RmFsjLy/kZqX+vZ
         dLRqFAJqfXhZWiUf6NoC3iq5MgajX2YLnwG9JgsfIg35xwH8Gb1vEOIx/jbtOdN6EUOv
         PdIw==
X-Gm-Message-State: AOAM532rS29tf7quGAg9RCoD7XLfsxfz6iv4dXZj1WAR7BcLn2c2/iN0
        tXXm20r7zdo9lYYJTZT/1Ec4LF2SCr7ptLonHr0+18FthuqhZQGKcdwrTlu6o+WdPId21JmI6Z7
        9I2WP4TiPLDr9cVOwN7ujDmCN
X-Received: by 2002:a05:620a:6db:b0:69e:84e3:5059 with SMTP id 27-20020a05620a06db00b0069e84e35059mr5494234qky.709.1650300653947;
        Mon, 18 Apr 2022 09:50:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbWQYYsvn90H1BnF5L8o1UGM3/9JXhiIclvSAkzCGZCOu7kfxyf1pecjQS5e4NPEffWlm8uw==
X-Received: by 2002:a05:620a:6db:b0:69e:84e3:5059 with SMTP id 27-20020a05620a06db00b0069e84e35059mr5494227qky.709.1650300653717;
        Mon, 18 Apr 2022 09:50:53 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8670f000000b002e22d9c756dsm7277059qtp.30.2022.04.18.09.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:50:53 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 01/25] objtool: Enable unreachable warnings for CLANG LTO
Date:   Mon, 18 Apr 2022 09:50:20 -0700
Message-Id: <7b12df54bceeb0761fe9fc8269ea0c00501214a9.1650300597.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650300597.git.jpoimboe@redhat.com>
References: <cover.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With IBT support in, objtool is now fully capable of following vmlinux
code flow in LTO mode.  Start reporting unreachable warnings for Clang
LTO as well.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 scripts/Makefile.build  | 2 +-
 scripts/link-vmlinux.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 9717e6f6fb31..33c1ed581522 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -231,7 +231,7 @@ objtool_args =								\
 	$(if $(part-of-module), --module)				\
 	$(if $(CONFIG_X86_KERNEL_IBT), --lto --ibt)			\
 	$(if $(CONFIG_FRAME_POINTER),, --no-fp)				\
-	$(if $(CONFIG_GCOV_KERNEL)$(CONFIG_LTO_CLANG), --no-unreachable)\
+	$(if $(CONFIG_GCOV_KERNEL), --no-unreachable)			\
 	$(if $(CONFIG_RETPOLINE), --retpoline)				\
 	$(if $(CONFIG_X86_SMAP), --uaccess)				\
 	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 20f44504a644..9361a1ef02c9 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -140,7 +140,7 @@ objtool_link()
 		if ! is_enabled CONFIG_FRAME_POINTER; then
 			objtoolopt="${objtoolopt} --no-fp"
 		fi
-		if is_enabled CONFIG_GCOV_KERNEL || is_enabled CONFIG_LTO_CLANG; then
+		if is_enabled CONFIG_GCOV_KERNEL; then
 			objtoolopt="${objtoolopt} --no-unreachable"
 		fi
 		if is_enabled CONFIG_RETPOLINE; then
-- 
2.34.1

