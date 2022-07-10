Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D6556CF76
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 16:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiGJO2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 10:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiGJO2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 10:28:38 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DA838A2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 07:28:37 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 145so2739702pga.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 07:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6aa0cuVDOJA5P8GO2+tz/8t89xrasGrqYGp910RRcbg=;
        b=UjZO2PjvcEp8xFTx+2UH+miWkO8klS/AAvp3MR6A3kMeLkP3Y8M8iOtdOVyyVS1kgb
         GlDYpFookZ5Ndryp5vXENlmWelm6fSohHsiZWJmAoO6pCZ7RUB/gPEts21IfbJibrpNR
         wiLN9Z02sk5tv7m9aApuvl1K3q2Bv6vg/GV9NNFL7aDeI8ej66H5Ac0p6nzyazZtOWJJ
         hEpCi6OUPCkp7SOOi8JDuoxn0U2mKqDrBwF1S4bnK38JddduhXe46uTiJz7KsLdjMbT1
         flC1Mi0KbR6IOCcO2b6Jo5ulb07EiJ9avf88+14wWNAjwxN4S+36ziqOaswYXwpYwcsb
         yWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6aa0cuVDOJA5P8GO2+tz/8t89xrasGrqYGp910RRcbg=;
        b=eMuEGQZlDRUn4c4buah4KAU+saw4aMZEODdKycQaUupHTdKftn67Q40KcOL/BmhOho
         IPQjCB9nzwCKV88f7nEXoajgRKInppvvkTJoqkXCNh9h1h83bfIMrONlphVhHyO/rkW8
         b2ugRAc/vikB5Jp8cp3i2f7Fu9pJlHyc9LGwmMDSoHL3bfcFKW48ui+INrHTzG3vW5mD
         GeBuFgx3tF+jQjedCTbPcfZaore+gRDeWZzsqdaXXkp4PQHdwNzPlVWC66qB5+feys7a
         YwAkGn5XlYpjNc/NhQkh28SVe5QmSVVLEsie6bnp7uAy2ORxn0I/veAuCPmQYQqbJaVQ
         +59w==
X-Gm-Message-State: AJIora+QPgF9hiENlVPEmKfXEWgsOoTzdVu3bOTTci22hvlqtf7boPu8
        +QD16Gzw74/YQAjmrjd81mA=
X-Google-Smtp-Source: AGRyM1vGo2Ia2QFvgU1+lStAtZ7txtzXb+tITVgQn/J/ItzkWVgsvRKW+IDHGJOXuoWrW31fWS60JA==
X-Received: by 2002:a63:8741:0:b0:415:e433:a3cf with SMTP id i62-20020a638741000000b00415e433a3cfmr4759390pge.491.1657463316939;
        Sun, 10 Jul 2022 07:28:36 -0700 (PDT)
Received: from localhost.localdomain ([101.12.54.120])
        by smtp.gmail.com with ESMTPSA id u28-20020a63471c000000b0040c644e82efsm2508555pga.43.2022.07.10.07.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 07:28:36 -0700 (PDT)
From:   Yu-Jen Chang <arthurchang09@gmail.com>
To:     andy@kernel.org, akinobu.mita@gmail.com
Cc:     jserv@ccns.ncku.edu.tw, linux-kernel@vger.kernel.org,
        Yu-Jen Chang <arthurchang09@gmail.com>
Subject: [PATCH 0/2] Optimize memchr()
Date:   Sun, 10 Jul 2022 22:28:20 +0800
Message-Id: <20220710142822.52539-1-arthurchang09@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*** BLURB HERE ***
This patche series optimized "memchr()" and add a macro for 
"memchr_inv()" so that both funtions can use it to generate bit mask.

The original implementaion of "memchr()" is based on byte-wise comparison,
which do not fully use 64-bit or 32-bit register in CPU. We implement a
word-wise comparison so that at least 4 bytes can be compared at the same
time. The optimized "memchr()" is nearly 4x faster than the original one
for long strings. In Linux Kernel, we find that the length of the string
searched by "memchr()" is up to 512 bytes in drivers/misc/lkdtm/heap.c.
In our test, the optimized version is about 20% faster if the target
character is at the end of the string when going through a 512-byte
string.

We recompile the 5.18 kernel with optimized "memchr()" in 32-bit and
64-bit. They run correctly.

Yu-Jen Chang (2):
  lib/string.c: Add a macro for memchr_inv()
  lib/string.c: Optimize memchr()

 lib/string.c | 62 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 17 deletions(-)

-- 
2.25.1

