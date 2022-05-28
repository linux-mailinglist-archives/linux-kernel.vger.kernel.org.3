Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20CE536B92
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 10:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiE1IOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 04:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiE1IN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 04:13:57 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF63298;
        Sat, 28 May 2022 01:13:56 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id c10-20020a17090a4d0a00b001e283823a00so2838840pjg.0;
        Sat, 28 May 2022 01:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m0Jp11ciNAmXB/3Pf8JdDNa95fWKHhwkSmYD7UsUFGA=;
        b=PSY5MRuM+7vQLSUanhYSON0qmE76h2jQpxL5Waq+Jr0uf9JrdvzdhDzbwkeKpGpC2u
         v9PGcKg9O6bm+vBOd910pX+NISgKSnJyyh8spAztkp5whbey7LgRU9QsS/qYS0HjAb9b
         +DlPCyyM9HEwNosEpG+nKwTEG5dQ0j394k7WRYcK5+Mi6np5dX6Dd3vnVyDQPd4JygAl
         HM2zsNlrZD3eEljk1PAZn2C1r4IlnnC2vXL8YBVYj09rHQ8c1uzz9/Pr7SctzdhSuYLH
         qJ2Rh2qmOM5nuE4ZyzGQ9b6PSWKzaw8Ff6Yx9N20RVaku0FHEgueyRz+OLc7bmOxIe9/
         xvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m0Jp11ciNAmXB/3Pf8JdDNa95fWKHhwkSmYD7UsUFGA=;
        b=4isribNPRDDfQL/PBkIO5SwvYeDrjpj4p3aMSYro6gLU+EGmIfA3L3dLU7t7eD9Lxd
         ppBRRGDD2Kb/FXzWFL9mXcHh/XSTZxC2rGM6E+fDdaPJP37+DdbHAkBtTbwGc8/LM7nE
         G8oEjI/9LBkUbC94LdECAywKoUdtMWO54KMscT2jZCpXKTlLWmQKYuwmGSRdy+AWR+s9
         QRUdPIohJuqXk4lUH2aR/vRxrZo5Zy8uJANBPW72mkoyIMP0tFVdsm4LCsuGyA3GDfwd
         eZd1ghRurmxc/bGOLdfqT1vUm7vgmwavpTRLThmcVINr4BW6jDkTH/Sf9pcziUIBv54Z
         HNkQ==
X-Gm-Message-State: AOAM533ck+sujQkIUz7hp0ICvD33ohGcys7j0eNi6wu3fWEjjwDkhqMa
        1d/+Fe8MphdS8lvO6xZWuMZeHgQ6Re5jxA==
X-Google-Smtp-Source: ABdhPJzm/AsyK5OPD28rOo/JvvE3CR9OQjk+3MUpDgpx8XJ+vE9sC708IaPeQr8+tsoxLb6x5zKWqA==
X-Received: by 2002:a17:903:32d2:b0:161:d485:613f with SMTP id i18-20020a17090332d200b00161d485613fmr46749255plr.173.1653725635716;
        Sat, 28 May 2022 01:13:55 -0700 (PDT)
Received: from localhost.localdomain ([140.116.104.153])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090ad34c00b001e0c5da6a51sm2774347pjx.50.2022.05.28.01.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 01:13:55 -0700 (PDT)
From:   Yu-Jen Chang <arthurchang09@gmail.com>
To:     ak@linux.intel.com, jdike@linux.intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        linux-um@lists.infradead.org, jserv@ccns.ncku.edu.tw,
        Yu-Jen Chang <arthurchang09@gmail.com>
Subject: [PATCH 0/2] x86: Optimize memchr() for x86-64 
Date:   Sat, 28 May 2022 16:12:34 +0800
Message-Id: <20220528081236.3020-1-arthurchang09@gmail.com>
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
These patch series add an optimized "memchr()" for x86-64 and 
USER-MODE LINUX (UML).
 
There exists an assemebly implementation for x86-32. However, 
for x86-64, there isn't any optimized version. We implement word-wise 
comparison so that 8 characters can be compared at the same time on 
x86-64 CPU. The optimized “memchr()” is nearly 4x faster than the 
orginal implementation for long strings.

We test the optimized “memchr()” in UML and also recompile the 5.18 
Kernel with the optimized “memchr()”. They run correctly.

In this patch we add a new file "string_64.c", which only contains 
"memchr()". We can add more optimized string functions in it in the 
future.

Yu-Jen Chang (2):
  x86/lib: Optimize memchr()
  x86/um: Use x86_64-optimized memchr

 arch/x86/include/asm/string_64.h |  3 ++
 arch/x86/lib/Makefile            |  1 +
 arch/x86/lib/string_64.c         | 78 ++++++++++++++++++++++++++++++++
 arch/x86/um/Makefile             |  2 +-
 4 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/lib/string_64.c

-- 
2.25.1

