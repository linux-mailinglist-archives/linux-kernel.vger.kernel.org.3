Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367BD46949C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 11:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242049AbhLFLDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:03:02 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:48496
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242037AbhLFLDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:03:01 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 227CC3F1BC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 10:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638788372;
        bh=Mpf1+wFXToHvdF/Ol73oVGZ3N1s6PxZDoxH3qziN9eQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=dXCclNLRRCxEQOKbjzWa2rm+ng7eVoFjD6nrXqW89zYC7fQd+Ecce6HZ7m4dGyAup
         rpIXJ7+PsnHAhU928rPQaLz1jwIWIg8TjSIUVD9M5Satq3pEaYLt4C34oWQ2TnyMBv
         /UE+TmTJk67k9KwHWMw4CR9u0+Gub34G5IK7V/UAorPl7onH9CtzCV1m21fmJBdtWN
         XQMoiEql8dbgCdj7Dktx3qdQ9oNqJxxGheZxyXHLC1hTMAl0BqwPsIc58ubn5j3w6x
         nHBBTpdBjkiznYq65VEOeIB5Y3FFTF6q89XNHvwloGt2ghxIOG9U57SW+GGeuuaZNg
         6cyu737DL0nVg==
Received: by mail-wm1-f71.google.com with SMTP id g11-20020a1c200b000000b003320d092d08so5917524wmg.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 02:59:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mpf1+wFXToHvdF/Ol73oVGZ3N1s6PxZDoxH3qziN9eQ=;
        b=OGx06gKMbYmpm5HISZMb2UCwHtU+k5e9+zINJXjRD4S72UL8ofKC525/URyXJysE/N
         gGhFAQ9AFOGUoQVkqOvE35e1+KXa0oamMypt4ueAlIQRHMx0FclPtzq7xYQFCRRMXuNn
         HyJzfFC65jovw6EUDPoMmRyKFdBnmrqYl1NRXp7rsMVmQsmTQ7VnzXS7RZZp5sEFF/46
         USyuJojccqufB/RW3Sw9qHfhW8XMdHZN05mZfmNkhPY1dc7Wnc1YGK2hHeKWvYgzQ6qN
         xfVvWI4HeTC3Fq0P+f255yK/G+W5YJRwBd6Dw3FKzgoHiyz0s3Zvemk8FrtZL83pK4bY
         4k2Q==
X-Gm-Message-State: AOAM533XH5webfvFypUjiNtQ34GaKWoObc0UWAMD9ilhxuiWk5XvHjhl
        gfdWd3ayPuvpCqqX8fpsGdpVYSKrBQUjq+j3MIUcc5kIQ46Q+zIYT1/WSA0FhuvrCZOI5vLQbsa
        ojvSbx6u05BFr1BMgcoJYIchVNO/v9DnIJeHmja6cMA==
X-Received: by 2002:adf:c146:: with SMTP id w6mr43633022wre.541.1638788371831;
        Mon, 06 Dec 2021 02:59:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXPF8JNT/lii3k1vlfVVxG4fHHOfwgSDGLo6V1yi6JZC+9G72g0N+X1xsL2m+r1nRvWrUGCw==
X-Received: by 2002:adf:c146:: with SMTP id w6mr43632986wre.541.1638788371627;
        Mon, 06 Dec 2021 02:59:31 -0800 (PST)
Received: from localhost.localdomain (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id l15sm10625964wme.47.2021.12.06.02.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 02:59:31 -0800 (PST)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@rivosinc.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        panqinglin2020@iscas.ac.cn, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH v3 12/13] riscv: Initialize thread pointer before calling C functions
Date:   Mon,  6 Dec 2021 11:46:56 +0100
Message-Id: <20211206104657.433304-13-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
References: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of the stack canary feature that reads from the current task
structure the stack canary value, the thread pointer register "tp" must
be set before calling any C function from head.S: by chance, setup_vm
and all the functions that it calls does not seem to be part of the
functions where the canary check is done, but in the following commits,
some functions will.

Fixes: f2c9699f65557a31 ("riscv: Add STACKPROTECTOR supported")
Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/kernel/head.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index c3c0ed559770..86f7ee3d210d 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -302,6 +302,7 @@ clear_bss_done:
 	REG_S a0, (a2)
 
 	/* Initialize page tables and relocate to virtual addresses */
+	la tp, init_task
 	la sp, init_thread_union + THREAD_SIZE
 	XIP_FIXUP_OFFSET sp
 #ifdef CONFIG_BUILTIN_DTB
-- 
2.32.0

