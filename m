Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA3E515ED8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 17:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383029AbiD3Pl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 11:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382955AbiD3PlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 11:41:24 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF1BA0BDF
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 08:37:57 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso12922607pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 08:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=GsO1g7Ro+rsf0io9vopg1aQfP2P2g91oLlrkEyQDXiM=;
        b=kF7TN9WBue7gogtLcWCSwM/BfmlmiiSeL5p6P+r9TFf7mJTPo7V03Vb2pERNLvb7OE
         aRiiolMYojHxd4x5cQCGpG9H2wT2LX9AGbU77WuAKd7VD9xTc7yVRQuxr9CmreoFTg1r
         PvNjg/njaujbrqAe+WzlaHXAa3YGjcCyPClqxCArzRUK1f4wnu8wIGOKQzuuPux3fanL
         dNudXAVOCI0w1bdRz0Bat3QH8ewK8iAbnP04kEkDwytD4R2TvR69JqSwtluXppkeLWp+
         iJKg4ylgLJ4xSXkYkJB/5TkTjMKtqArr+XkBvDHr/ZIlgr8RD4A5+MLPtRKEzg0pyefW
         MJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=GsO1g7Ro+rsf0io9vopg1aQfP2P2g91oLlrkEyQDXiM=;
        b=SztZCg7Irw9DEZqONvxSKesn6z0ZcEF6APu61/lpWngVny6pAg1mr9gHQBjLrhZOdB
         7QL7/GXN24KtnfS3LCjCiYGqT5pN73PUYKEbW2jp5hRXly9fLl0oUEyYc9np8hzR9WTM
         3X9WbEX4zmrBJA8YRGrZBKTjcmFO0m0kdpU+7QOyDsavpsH0+zn5wbzkAjwWwHjb34Iv
         fY4fWzRtOUraGFgCfixPMiVu1BBBHemlhrwj3rcITri3JRVcTDIXX3MERqeuL9Gh3E7k
         GuhLiCEGt/iQLn3ZnTfrTLaD0ljFgHXpY67ILP3p7c4nu4ysvJo9IauuwSTC9A87gb7k
         BTYA==
X-Gm-Message-State: AOAM5308ViM4rX0k2TCv3lgDAXYZtin/wPBjqDvxDwKONS80D0U01bxv
        qDLA161WEpm/VXzo4ZqYABpuh2cuDln5yQ==
X-Google-Smtp-Source: ABdhPJzNtj8d/a+lfHQeb2reqO0YCZeJo7LPF+70BVvrDTXjKfwmfYC5tWlm1kzXph5Ui9RlcPxgHQ==
X-Received: by 2002:a17:902:8d8e:b0:159:4f6:c4aa with SMTP id v14-20020a1709028d8e00b0015904f6c4aamr4142558plo.115.1651333076544;
        Sat, 30 Apr 2022 08:37:56 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id m2-20020a17090a2c0200b001d7761ee6fcsm12923373pjd.3.2022.04.30.08.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 08:37:56 -0700 (PDT)
Subject: [PATCH v4 3/7] asm-generic: qrwlock: Document the spinlock fairness requirements
Date:   Sat, 30 Apr 2022 08:36:22 -0700
Message-Id: <20220430153626.30660-4-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220430153626.30660-1-palmer@rivosinc.com>
References: <20220430153626.30660-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     guoren@kernel.org, peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will@kernel.org>, longman@redhat.com,
        boqun.feng@gmail.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        sudipm.mukherjee@gmail.com, macro@orcam.me.uk, jszhang@kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        openrisc@lists.librecores.org, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

I could only find the fairness requirements documented as the C code,
this calls them out in a comment just to be a bit more explicit.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 include/asm-generic/qrwlock.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 7ae0ece07b4e..24ae09c1db9f 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -2,6 +2,10 @@
 /*
  * Queue read/write lock
  *
+ * These use generic atomic and locking routines, but depend on a fair spinlock
+ * implementation in order to be fair themselves.  The implementation in
+ * asm-generic/spinlock.h meets these requirements.
+ *
  * (C) Copyright 2013-2014 Hewlett-Packard Development Company, L.P.
  *
  * Authors: Waiman Long <waiman.long@hp.com>
-- 
2.34.1

