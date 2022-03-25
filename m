Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ED34E783D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 16:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354628AbiCYPpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 11:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377700AbiCYPnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:43:49 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67511B6D09
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 08:40:03 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id a7-20020a9d5c87000000b005ad1467cb59so5744438oti.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 08:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ypjTi2QLglCgiR41jmHNzqOUbU21d8Eiot5Yiruzzgs=;
        b=N4t7XbHe4uReKLLLQVouF1CC1EXRPOEqBjekQXhgY+x10SXRnA2ht3/Mpfvx84fWdc
         k3wO9YDMbL7yby0tiJcsVhds4vYgV+Xfp59XpRrot0hsXMRJZilfBVbSS6q6tAvaAqEn
         McPJ3u2WAO2OMAr7EjIt/+hUTVOt96tnYM1fRBlBvMk5z5jz/HyLLzAUv7ONbk6bjXQ2
         moAQSk2U5rEzb1xAPo+uJnKv8VkgtjMzB/ygE8WthIXWvEquhQ6YfdKz43Qp05N6Owqg
         00hp6obuogSK9oxu6OFOKG76qsAOx3OnE3novTCASWJjA0YwJjz5mhDxhkAANwlS3x+P
         RY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ypjTi2QLglCgiR41jmHNzqOUbU21d8Eiot5Yiruzzgs=;
        b=5WQY6kLGppGThZKnSjtWqNOUj1tVstdl0Y5Y848YiltvKNLqhpoAcI51hU8GTzA9gt
         jw3V+Z677gQYHsvU8tYplAq14Z/5iFxSxCbjcGqkrO5/NGz/hy7WJVrL+k32BzxZc3oD
         Jf6l5WW+V/Z9a5VrYAVITsc8VORmmM/OgZjUnrBvA4jiLx+PAvQ2K7KnWV8gVTfgFnue
         Jmt3CmQN2MjkXbravWPBTVtDK7KpjpFjHM4Te5zCBs7XgcSj3tSpY66rRyOa2RNDPHwh
         n2Uw7FJ1h8hmvM6GDJsEuzd7nNnhooH2VSmhXyT5Lk5g7sX9Kd83+LJz9t+Zw4f1wsuB
         iVwA==
X-Gm-Message-State: AOAM532xomGLpgRTFtq7xLdq1OOv+D5tNwrKj4Nqspf8dfbUwDB//lMp
        FtooOZga1Tp1ZAlFw+0Qi8PTW+iXmA==
X-Google-Smtp-Source: ABdhPJyr82KC37WZP7qqBRs45gXzOqO5pqcjJiFxg0Sv03AbzMpnskpjOYOnBR6yoET7SdwAFVZhXw==
X-Received: by 2002:a05:6830:1185:b0:5b2:4c85:5ee9 with SMTP id u5-20020a056830118500b005b24c855ee9mr4527447otq.335.1648222802518;
        Fri, 25 Mar 2022 08:40:02 -0700 (PDT)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id el17-20020a056870f69100b000de9672ac3csm1709566oab.52.2022.03.25.08.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 08:40:02 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 0/4] x86-32: Clean up GS segment handling
Date:   Fri, 25 Mar 2022 11:39:49 -0400
Message-Id: <20220325153953.162643-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Since commit 3fb0fdb3bbe ("Make the canary into a regular percpu
variable"), the GS segment is no longer switched on kernel entry for
32-bit kernels.  Clean up the remaining code that handled lazy GS
switching.

Brian Gerst (4):
  x86-32: Simplify ELF_CORE_COPY_REGS
  ELF: Remove elf_core_copy_kernel_regs()
  x86-32: Remove lazy GS macros
  x86: Merge load_gs_index()

 arch/powerpc/kernel/fadump.c               |  2 +-
 arch/powerpc/platforms/powernv/opal-core.c |  2 +-
 arch/x86/include/asm/elf.h                 | 15 ++-------------
 arch/x86/include/asm/mmu_context.h         |  2 +-
 arch/x86/include/asm/segment.h             | 12 ------------
 arch/x86/include/asm/special_insns.h       |  7 ++++---
 arch/x86/kernel/process.c                  |  5 +----
 arch/x86/kernel/process_32.c               | 11 ++++-------
 arch/x86/kernel/ptrace.c                   |  6 +++---
 arch/x86/kernel/signal.c                   |  8 +++++---
 arch/x86/kernel/vm86_32.c                  |  4 ++--
 arch/x86/lib/insn-eval.c                   |  5 +++--
 arch/x86/math-emu/get_address.c            |  2 +-
 include/linux/elfcore.h                    |  9 ---------
 kernel/kexec_core.c                        |  2 +-
 15 files changed, 29 insertions(+), 63 deletions(-)

-- 
2.35.1

