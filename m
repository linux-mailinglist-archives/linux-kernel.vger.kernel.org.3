Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEB7501E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 00:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347247AbiDNWs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 18:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347232AbiDNWsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:48:20 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7678FC6EDE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:45:54 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c23so5916362plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=yrDHQuYb48YDvHbtAzgjJkyK31UIJkjOnff3p/U86sM=;
        b=4EXXi/qoqg6Olt0vHXOTMdpyoa9bqWxbfOxxLHtrN/t1usD5oljyvFC8cJHbrS5bCe
         u9lU8Uum0EYbwgVD3niC/emY4qpCVsaBQ9/hzXRInPJWVdkD6yqRCvTTZK4JWQwp7vN6
         BJS80WVxP9JPInFsHUA1c67XKH5v4ScAdL8+BPzuy+SQFlVmF3HyX+w2q9mAlQKPTeB9
         ycWnWpndrZS7Opbw4NP8hNikQ4grPBpZ0D67EAo0GsS+2yEm9oVWn48dK8nYYHXo0q7k
         VQg0andWrnvY8j3uxhyVCy93JB5IU/wMO9fY/27TSTCprcW9W08aLKpy+jYKJghKRaYV
         abuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=yrDHQuYb48YDvHbtAzgjJkyK31UIJkjOnff3p/U86sM=;
        b=XJkN7OumqrueC7Or1mxRCpvYRy4rkVlZP/SiUmeE2RQaxNFrjUsE/chiR6PP8+oilM
         rjJa2qdlyzeom7jgZwl/fG7BFZjLw16dBA62ujXMbv7R9zxoxXA7aFRW6Es2ESpvBBKe
         uM3UuHd2v0dDox1hf22gonDIuut1XK+3X3sjc7/XAM5rDTD/8Z9AehbBwLpboH0Zchyl
         2dGWawGu+lA4UYFPkwnwWBoVcGq5a5niy9kYDE+wO6wGwoqP6LqiFTJK9mukeBvxC6h+
         lWHvZUGBfoJ+c4MHEGGbLZ4nDamWNEqo4bBIk6PEgHfh/eVhn3leXGTp7l2j10WoVZT/
         oCHg==
X-Gm-Message-State: AOAM532otEScKIPLp3NLAPuY4hVVNppMyffQrAyTSm5EZSh5eYFMiKOB
        VwrTZyDI+fxh969J3h3SH0yRT8cUWXkL9g==
X-Google-Smtp-Source: ABdhPJylozf6XNHlm1L9F2LPLthfumcFTJLhRp6QX9EUyJeF2D1BQ/HWoOVEEcFvnf1ZtIhqaf4/2w==
X-Received: by 2002:a17:903:213:b0:156:7efe:4783 with SMTP id r19-20020a170903021300b001567efe4783mr49591858plh.126.1649976354027;
        Thu, 14 Apr 2022 15:45:54 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id a9-20020aa78649000000b004fe3d6c1731sm858980pfo.175.2022.04.14.15.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 15:45:53 -0700 (PDT)
Subject: [PATCH v1] asm-generic: Describe the logic beind the __io barrier names
Date:   Thu, 14 Apr 2022 15:45:22 -0700
Message-Id: <20220414224522.28972-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     helgaas@kernel.org, macro@orcam.me.uk
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

These names are very terse, as they weren't originally designed to be
this spread out.  There was recently some confusion as to how this fits
together, hopefully this comment makes them easier to understand.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

---

Maybe we should use 'm', instead of '', for the MMIO barriers?
---
 include/asm-generic/io.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 7ce93aaf69f8..1297807b5831 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -18,6 +18,15 @@
 #include <asm/mmiowb.h>
 #include <asm-generic/pci_iomap.h>
 
+/*
+ * These generic IO helpers provide a handful of architecture hooks, which are
+ * the Cartesian product over three dimensions:
+ *   - Memory (the empty character) and port ('p').  The memory flavor is used
+ *     for MMIO (read/write), the ports are used for port IO (in/out).
+ *   - Before ('b') and after ('a'), which are inserted before/after the raw
+ *     access.
+ *   - Read ('r') and write ('w'), for the direction of the access.
+ */
 #ifndef __io_br
 #define __io_br()      barrier()
 #endif
-- 
2.34.1

