Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0BC500279
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbiDMXWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238856AbiDMXWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:22:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E2421B7B0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649892000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WHwtgBFXaVRPDxpgXVknAcXgf6im9N3NqhP05P8+ItY=;
        b=JYw2gmlRdeRG6UTAZMoS7O8h5yLAhTW3AaXS03i0WQKWTr2BdKEMoFBf9qndjOMqPS4Gek
        9QmRNLZloAK1gs9gpIQ4KXSodNfTLCjYfcmGNTM0Y58ZT1V4n/XIv38c9ewlK9t2GRYIgK
        yvhAeNgynancLXGWWMmRIiFLYw+RSj0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-MAMQ73tMOnOzHf_BF5kjyg-1; Wed, 13 Apr 2022 19:19:59 -0400
X-MC-Unique: MAMQ73tMOnOzHf_BF5kjyg-1
Received: by mail-qk1-f200.google.com with SMTP id h8-20020a05620a244800b00699fb28d5e4so2135163qkn.22
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WHwtgBFXaVRPDxpgXVknAcXgf6im9N3NqhP05P8+ItY=;
        b=fjxtI5O8L/pZsvyIxrc4d7GuMi3iSohJpB9GXuZMU1DU6sdcbv0BkgRcQ2f3n4OQ9M
         llyzJZL7n1WPHiRjMQCyS80UeDOS0Na/InyaTcW4MuHn2/SOhZQQMyXmI1/dtKD07SEk
         q/hNOYbqS6r+kUM0R8LG2J2MEi4FhOf3UpHgcmIuFSb7Jcw/M0JdCCX+8h/guRgbmvSf
         8emtTi5dRNpPUTXVTF9u2aDdKrzEaln/RDuYv3osRQRhrZgcVATApwFT8vwdFvwT9re/
         32Hn4YMSO6HXkT+T+V8IGGMA1g92FBdmv8FsSJHmOJnO+ZryrJ1a6K+QhgycVMkRpEPy
         fPOA==
X-Gm-Message-State: AOAM533O1c1tw+D/NrJ7yLBpIs78tVh6dqiVN28etBGGKab0PHdDb0/L
        iTcdiQCzS9FUwvZ2PMghdb4E80FgUObcjrkh3w/+BaVBaGsUCqhddoQkqpGWtjQ1v8zOroZV4ID
        YS+L+21i7cr0MepfOScfKZhnY
X-Received: by 2002:a05:6214:c83:b0:441:51c7:9dc9 with SMTP id r3-20020a0562140c8300b0044151c79dc9mr1032427qvr.83.1649891998739;
        Wed, 13 Apr 2022 16:19:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxK9G/2dn/UjZoKpRBN8/k1+sDOKT3FCsijjvf4/H/VFtzXaH6mAb5/vczmxNrXcN0x6fTE6A==
X-Received: by 2002:a05:6214:c83:b0:441:51c7:9dc9 with SMTP id r3-20020a0562140c8300b0044151c79dc9mr1032419qvr.83.1649891998552;
        Wed, 13 Apr 2022 16:19:58 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id b20-20020a05622a021400b002f08f5658a2sm193925qtx.68.2022.04.13.16.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:19:58 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 01/18] objtool: Enable unreachable warnings for CLANG LTO
Date:   Wed, 13 Apr 2022 16:19:36 -0700
Message-Id: <7b12df54bceeb0761fe9fc8269ea0c00501214a9.1649891421.git.jpoimboe@redhat.com>
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

