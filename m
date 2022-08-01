Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBFA587147
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 21:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiHATRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 15:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiHATRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:17:30 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE4F26A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 12:17:29 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id b21so8792474qte.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 12:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vQbImrOTohSjwdlYWLYCRrxFO8BX6edWmfF8b90Jrqo=;
        b=nbl59JoF+5LUqsMbv4v1ow5n4j8+noIEjvryDuQMib6rlyePea1pQa+TD3gE7WBUrq
         iFgvrfx4M9H7fmiwPoY9lTEOrlwnMVjpCDB9Jnbo1Kr6DN/pIf7SY42LPKtbRqcQmvjf
         t3AMypZ94M2b8mDj3iaoUxu15W61eZNT9ZbTX9RqnBACH6ROew9sF/CCvS7BtfdohbsS
         i7rhg0wWdxzn5ct9JnpGV+RCOFhz7Cqzdr5AM7FG2M3v13RXyjLFv1Hg5JwZB23OfqsG
         ax0/u1fCOHpyOI6b/ELIDF5edp5ocz1yuFRLCvrz43wofFZ6e6vTtnKNa6D8Db/XU7Ov
         mAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vQbImrOTohSjwdlYWLYCRrxFO8BX6edWmfF8b90Jrqo=;
        b=uSGcmL72An90IpX4WgmFbVnJL2KA4i3euoO+Sp5u61XVzjJD+/JzalPZJ2B85lUKKC
         KAUfHg2LH8ZxXXG8rbGimySO+BWKdxjF6MWOYSMF1gsc3Jp0zNoa9eRlJKycnGEm5wIL
         M0JTDrlcvR457uVwQTvLuqDOMgIo53sHbWlL+JLXbZAZicZJfU+tykJFc+HKMdeuki/t
         64plp9Z50RmVBGJxOWrrfndu6NfSPTiLIo8CGl/ss5vuS4upDc4285QlcJRaGV0Z537S
         fntP30r4q7ggao/rduX4y0VqhwVWtmgb9/Z62MIjL+MppiZgbpdIJVLoqIdjSYcxWcrM
         coBQ==
X-Gm-Message-State: AJIora+VhEhTrrLb3sAsNBg2AE/1RvdMJa78lxnd6xZqVYOMapcxKL7n
        T9Ewib3LYoxs9UGgFito8YA8GRfvYfT6Ag==
X-Google-Smtp-Source: AGRyM1u3p8zFpfzDLya5qV6Ek1G8RW5f8/EVk1av/NZP/wrjKgVMMgBCaOZd0ayQOQ7JAAmNMsP5mw==
X-Received: by 2002:a05:622a:409:b0:31e:e679:bb0a with SMTP id n9-20020a05622a040900b0031ee679bb0amr15151545qtx.45.1659381448664;
        Mon, 01 Aug 2022 12:17:28 -0700 (PDT)
Received: from hefring.. ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id h13-20020a05620a284d00b006af59e9ddeasm8895472qkp.18.2022.08.01.12.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 12:17:28 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
X-Google-Original-From: Ben Wolsieffer <Ben.Wolsieffer@hefring.com>
Cc:     Ben Wolsieffer <Ben.Wolsieffer@hefring.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: disable FDPIC ABI
Date:   Mon,  1 Aug 2022 15:17:20 -0400
Message-Id: <20220801191721.1253291-1-Ben.Wolsieffer@hefring.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with an arm-*-uclinuxfdpiceabi toolchain, the FDPIC ABI is
enabled by default but should not be used to build the kernel.
Therefore, pass -mno-fdpic if supported by the compiler.

Signed-off-by: Ben Wolsieffer <Ben.Wolsieffer@hefring.com>
---
 arch/arm/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c8e3633f5434..88be49b71d40 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -22,6 +22,9 @@ GZFLAGS		:=-9
 # Never generate .eh_frame
 KBUILD_CFLAGS	+= $(call cc-option,-fno-dwarf2-cfi-asm)
 
+# Disable FDPIC ABI
+KBUILD_CFLAGS	+= $(call cc-option,-mno-fdpic)
+
 # This should work on most of the modern platforms
 KBUILD_DEFCONFIG := multi_v7_defconfig
 
-- 
2.37.0

