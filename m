Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F8D533F5E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242428AbiEYOkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiEYOkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:40:25 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6399326E5
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:40:24 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id jx22so28687929ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CLjQF+Tk2Dzg/+o3qFGpi4ZRr2G7ec0w/EcVuau6V3o=;
        b=gNP79hxx2bGKSSokzC/ujzec2WuXtVPOMlNGUx6axODqSxaeUuQThaQXqkJWd9ShqS
         nCjDFv30ZMjMfJ1iIsYpUOkda+HM2Qu4QFCzxP0b3w2Wx6t7T8ZSWL0eIGND8IRKDB/1
         /e0bq53RAXlWgk28rxW6UuGBVKBCuQXdjaFQRLXmJkYyH0H+YNZvKUXSeu2rSOOuvZ9O
         JholRfIWHOz5KIhrmwwJ7gCFRtcVK90lHQpqN+EVd7yYC5ocyiig52ny8obY7yhd94vf
         AfTIxpsnVHTY48Dqu23sM1S47Ao7Qv6gHTdoeMdCoIUk0FM8uPLfB1G766bQ/as80z6m
         zvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CLjQF+Tk2Dzg/+o3qFGpi4ZRr2G7ec0w/EcVuau6V3o=;
        b=q7fNVfOwuy1t0IoMX5iV6bQkP8mHpy3N5gsrreXmdQIbZaBc2PB5oscfzzJ6Cl2MRn
         Hsv3nL8h5II6yoi5YkmKPYHSCvai70R3MBpIR0g+UFXjcfdRc2gL7CJ57kv3sS/Ezoly
         8wD+yj9mhRYnd++2dwpwX6zjpkJyzXX4/0SUh5HuHQBmnweUGsnYVF22eHMt8SOrYrnJ
         1mNvjK5pSh3v3auONxLdhKxC5/bVQVqT3pQRF1+IgUKxaQzRwDnMl5zX0MViz6of7T3C
         YizOZHhM3qA8/3Qx9RrSbZqWh3Pv1wbdqy854esboUSGx/SaSSeRdKD65JZ1obJxEg6p
         oIIg==
X-Gm-Message-State: AOAM532UDks3hjZ9kLM+iDPYsHzwuK3jqykk6dm7Y8c1LGvsl+horwXu
        PTPcynPXMs0yCTqRp0ZXCu4=
X-Google-Smtp-Source: ABdhPJxxpyp3+790QyGn2MuWx/D1L+faCOhc9lYzD23MnLAmKwkFiYUVUoMVVxHcPCHtBTYO7t4dyg==
X-Received: by 2002:a17:907:7745:b0:6f3:674a:339 with SMTP id kx5-20020a170907774500b006f3674a0339mr29675341ejc.207.1653489623224;
        Wed, 25 May 2022 07:40:23 -0700 (PDT)
Received: from localhost.localdomain (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id 4-20020a170906224400b006f3ef214da7sm8288262ejr.13.2022.05.25.07.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 07:40:22 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Waiman.Long@hp.com,
        paulmck@linux.vnet.ibm.com
Subject: [PATCH 0/2] locking/lockref: Use try_cmpxchg64 in CMPXCHG_LOOP macro
Date:   Wed, 25 May 2022 16:40:11 +0200
Message-Id: <20220525144013.6481-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces try_cmpxchg64 into CMPXCHG_LOOP macro
to improve generated code a bit. x86 CMPXCHG instruction returns success
in ZF flag, so a compare after CMPXCHG and a related move instruction
can be eliminated.

The second patch (optionally) enables lockless reference count updates
for X86_32 target with X86_CMPXCHG64 config flag set. When try_cmpxchg64
is used in CMPXCHG_LOOP macro in lib/lockref.c, the compiler avoids
double-word compare and related move and produces quite optimal code
around CMPXCHG8B for a register starved X86_32 target.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman.Long@hp.com
Cc: paulmck@linux.vnet.ibm.com
---
Uros Bizjak (2):
  locking/lockref: Use try_cmpxchg64 in CMPXCHG_LOOP macro
  locking/lockref/x86: Enable ARCH_USE_CMPXCHG_LOCKREF for X86_32 &&
    X86_CMPXCHG64

 arch/x86/Kconfig | 2 +-
 lib/lockref.c    | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

-- 
2.35.3

