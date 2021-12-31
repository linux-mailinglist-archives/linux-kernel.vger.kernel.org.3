Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902924822A5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 08:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242770AbhLaH4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 02:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhLaH4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 02:56:00 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4399FC061574;
        Thu, 30 Dec 2021 23:56:00 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id l11so24560904qke.11;
        Thu, 30 Dec 2021 23:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7zbpRrLBrCKgX6NkoRmj/V8e4hwO+gRAuTh6iRR6fRI=;
        b=gZeajJuxp7WDIeKV55HDgQxImZZ8Zp1E+Uks8G+1W/dECIW0wqGPRC/T41C0A9uaOJ
         CyR1IkcYi+7jNKy/+HG+2kKZe/AijQd/evChNOe2vXnLD3nVU8XLceptctr2mJQ3gteM
         iFfwsVnefhAph6n0r5o+adjSCMprBSdp78HJLN+SeeJi/R6nWtEl91hqolwr4a+m4k5J
         sdxZDPp6Jx8WTfhtlBhePiP/Ndgfmh6Uv4xck/GpVn625MgCGlN6C6vF8NOhaJEtChN7
         4gyLUKez/v52X29BDG8majal6Nt1GjYA7/5dmFKmcUjtB9/LOWdx0bmQyrSSlBYUkHy4
         p/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7zbpRrLBrCKgX6NkoRmj/V8e4hwO+gRAuTh6iRR6fRI=;
        b=XvaaZ5qor8hrx2MK6Zj2HvXDNrvRE1bIFYeFfm9IC1GNT+cEZtKdgKcLSC90qORYzr
         9mrhH1ciFUQyErXNAjy8I+hKK1iNLrPlsA2RydR7J2PEwePcim2+FaAXOSAJIYktVQyW
         D/zYmf27IktOF6nzx1Ald1EnOVeGBhabkFRc65KCjIw+7DZmWlZESGUBlt9DT6FBsHLD
         nQeV6Xujnzm2GE+vFXKUzm3LANSELA+uZCRBUq1qWJoLz/d3cTjfj+c/ugRDFvmb7+YW
         QWdWjEg6dOtMsqS3DDX1DdgSiYXo3/FGKmI82V+CUlGG/Rw/VMFHaCoqndYQnespRwG0
         mh7Q==
X-Gm-Message-State: AOAM531+uSee9aHcFHnwYXEjLoIgYReNh1OpSKiI3zRA1VLUlDzEKa8x
        1nrGbNDG8LrAdp0nUirQEEw=
X-Google-Smtp-Source: ABdhPJyKkY7fb4yE50itA6Vyq1mfU98xDilbpOVABc56ExnAcKSWM8rEgm1SyQmncVQP7Y+Trbf7pA==
X-Received: by 2002:a05:620a:450a:: with SMTP id t10mr24054473qkp.412.1640937358326;
        Thu, 30 Dec 2021 23:55:58 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y16sm19779866qki.41.2021.12.30.23.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 23:55:57 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>
Subject: [PATCH] Fix compilation errors when using special directory
Date:   Fri, 31 Dec 2021 07:55:51 +0000
Message-Id: <20211231075551.589515-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

When we compile the kernel with cross compilers, if CROSS_COMPILE is
specified by the path containing special directory like '~', some
compilation error will occurs.

Here's an example:

$ make ARCH=x86_64
CROSS_COMPILE=~/x86_64_gcc9.2.0_glibc2.31.0/bin/x86_64-pc-linux-gnu- all

error:./scripts/mkcompile_h: line 64:
~/x86_64_gcc9.2.0_glibc2.31.0/bin/x86_64-pc-linux-gnu-ld: No such file or
directory

Since there are many other similar scripts using these variables, in
order to solve the problem from the source, add realpath in makefile to
turn these variables into absolute paths.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 Makefile | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index fe5a4d8e4ac5..cdbb747787ac 100644
--- a/Makefile
+++ b/Makefile
@@ -459,14 +459,14 @@ OBJDUMP		= llvm-objdump
 READELF		= llvm-readelf
 STRIP		= llvm-strip
 else
-CC		= $(CROSS_COMPILE)gcc
-LD		= $(CROSS_COMPILE)ld
-AR		= $(CROSS_COMPILE)ar
-NM		= $(CROSS_COMPILE)nm
-OBJCOPY		= $(CROSS_COMPILE)objcopy
-OBJDUMP		= $(CROSS_COMPILE)objdump
-READELF		= $(CROSS_COMPILE)readelf
-STRIP		= $(CROSS_COMPILE)strip
+CC		= $(realpath $(CROSS_COMPILE))gcc
+LD		= $(realpath $(CROSS_COMPILE))ld
+AR		= $(realpath $(CROSS_COMPILE))ar
+NM		= $(realpath $(CROSS_COMPILE))nm
+OBJCOPY		= $(realpath $(CROSS_COMPILE))objcopy
+OBJDUMP		= $(realpath $(CROSS_COMPILE))objdump
+READELF		= $(realpath $(CROSS_COMPILE))readelf
+STRIP		= $(realpath $(CROSS_COMPILE))strip
 endif
 RUSTC		= rustc
 RUSTDOC		= rustdoc
-- 
2.25.1

