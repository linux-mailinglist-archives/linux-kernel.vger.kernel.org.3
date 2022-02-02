Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6404A6E86
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244402AbiBBKTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiBBKTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:19:36 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D375C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 02:19:36 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id m9so38741249oia.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 02:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=6l/DM9ImdTh5sC0SRd750Jv7/fvf3BxvSlWsRYW3v9E=;
        b=n6ADlOVcwJanVuG0T/+5Kbdup+OsZIMmLP1/tPJiWcOUE3h7RbfySDMyHh7FeB32y5
         VijQ88s2IR1yv4sId07MURPl3tyg3mFN9VCw69XLBEUlmJsVzmikLrk9wpUwlZZH0OZQ
         LgYwRKiOr+yid7GCGmEG+N6zs4pPIQi7vWmPaskYZGt2pO7/ePVxfxlJMZ4IZ89qEmzD
         nT+Z68t1JgWvkU8SKY+qQKfSzMjkdOXjFwk9lpCWlruASzcpXDCEVCS1YUwsJ5yy0ZdE
         D+40dEM5pIsKeMVCSZwWAWmrPav2PmaAE7a64FBBc2V5F5C7r1a78lcccvKUZP4MEUtl
         sQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=6l/DM9ImdTh5sC0SRd750Jv7/fvf3BxvSlWsRYW3v9E=;
        b=NzobvH+a/ahjivRsZRicW/x9QP1EFAxMTT+SmcF/Vvly5ZYNwXPggB1oxTXJH9rlVS
         kCEOkSH0j+NB7zNtgWnxgLeoX1T/wuiV3GHgpChxMroSaLqMj5t9rtV4dbfUlR+yl+9o
         6pTvuQGq76cfhTWfvMezRNv31FkMx2Va3yAFTfG193u0JPxeKxxXyqeWF/y6TCZiFRSL
         cTNlhWQGpm+IteXi+bwOU6O3NGagpTTl14yyn4DKdmnrK2F8cYp9E4MYME8iO2H6laPt
         ELXx9rTkl0bWLyvy7dRWYx0m6ZELHbk7+WEmsgl6R/Gbk7c//iiyPhxZrSAxnTY/ERMU
         bPCw==
X-Gm-Message-State: AOAM532LLFMtXZef9R/2L8rAFtf+7xq2GBPGCGMSwZqDOu0Ctdx2huzV
        mxOFwHoMOhfABf4cviQA0sI1E557epn65g==
X-Google-Smtp-Source: ABdhPJxSkLH6GxdI9JND7Xhd4KKafvqdYxf53Tn+Tb93DmL4IBDf4jnThIILPhIHzxjiY/+Qyzf60A==
X-Received: by 2002:aca:398a:: with SMTP id g132mr3938732oia.207.1643797175048;
        Wed, 02 Feb 2022 02:19:35 -0800 (PST)
Received: from ?IPv6:2607:fb90:c231:2d7a:bcf9:65ff:fe5e:34ca? ([2607:fb90:c231:2d7a:bcf9:65ff:fe5e:34ca])
        by smtp.gmail.com with ESMTPSA id c21sm11357463oto.55.2022.02.02.02.19.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 02:19:34 -0800 (PST)
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Rob Landley <rob@landley.net>
Subject: [PATCH] try generic compiler name "cc" before falling back to "gcc".
Message-ID: <e64d3b56-9f60-4cc6-0110-a4db7543d8e1@landley.net>
Date:   Wed, 2 Feb 2022 04:22:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Distros like debian install the generic "cc" name for both gcc and clang, and
the plumbing already does CC_VERSION_TEXT to include Makefile.clang if necessary.

Signed-off-by: Rob Landley <rob@landley.net>
---

Tested that llvm works with the hexagon toolchain wrapped as:

$ ls
hexagon-unknown-linux-musl-ar   hexagon-unknown-linux-musl-objcopy
hexagon-unknown-linux-musl-c++  hexagon-unknown-linux-musl-objdump
hexagon-unknown-linux-musl-cc   hexagon-unknown-linux-musl-ranlib
hexagon-unknown-linux-musl-ld   hexagon-unknown-linux-musl-readelf
hexagon-unknown-linux-musl-nm

 Makefile |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 3f07f0f04475..f3f8df88f249 100644
--- a/Makefile
+++ b/Makefile
@@ -427,7 +427,7 @@ ifneq ($(LLVM),)
 HOSTCC	= clang
 HOSTCXX	= clang++
 else
-HOSTCC	= gcc
+HOSTCC	:= $(shell cc --version >/dev/null 2>&1 && echo cc || echo gcc)
 HOSTCXX	= g++
 endif

@@ -452,7 +452,8 @@ OBJDUMP		= llvm-objdump
 READELF		= llvm-readelf
 STRIP		= llvm-strip
 else
-CC		= $(CROSS_COMPILE)gcc
+CC		:= $(CROSS_COMPILE)$(shell $(CROSS_COMPILE)cc --version \
+			>/dev/null 2>&1 && echo cc || echo gcc)
 LD		= $(CROSS_COMPILE)ld
 AR		= $(CROSS_COMPILE)ar
 NM		= $(CROSS_COMPILE)nm
