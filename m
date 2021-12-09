Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5384B46F269
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbhLIRtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbhLIRtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:49:09 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D42C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 09:45:35 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so6525755pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 09:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iIiD2tB1mZcC9000R3dPN0Ssy5fUgmj5OI6G5tIxfyQ=;
        b=fW+wTj8NxqXzmqEv5QlWp2Qhp1wrUdcZ6JbL1FPSHnzDR4Gxe3dDW2vhhLUWduQwuo
         qiDnm+BpjiZwf4I1gPplqveXGR/aIyMah8/6MaLzBgELzYHJy/Fr3+GDWR+cfiOMHOgB
         543/NHKBnfpE3p8CmSK0ItrN12zBNXCHknhTLXqUtc8gNrXjzUU/MB4Svmbq0RfaLxDn
         Qir80+jQTw1aEsCpWby/z0L5/CmZgCybgieqHFP1SKcIaHMSta2plOIskL17JEho/hG1
         o3c3ewCGQwBuGn9EM0tIAvoWQqHGACjOX4oba696klIqN7M0UCFVXOKriezd0diKjSO5
         Gp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iIiD2tB1mZcC9000R3dPN0Ssy5fUgmj5OI6G5tIxfyQ=;
        b=VHjLsYlSvGf55Vh7Lm4dWblnMDs7voFbv7OYqlEYkxOYiRr7eo+30BAbc04RPdMBz/
         EqOB3NSvkGoRE+fjEYcqKXRLKLBweG1HCpFAnaB3RYyct5rX06h/vzmU2+SO/1MhE1fG
         BjG2u5LZgDwhIToGkuFdNvKqpGHMmx4VV6+bY2UWHfKfcOqveXgscIqo3BCKYQEsY+ZP
         6JEct3yWDzYLCWTK6WYU58eqlh/UqbgA/vsAMojEnBJ86ZyHM+NrefCWDJC1k5pjQKdR
         I9dreAZ2gcZRcc1xlL0MEM8HlQBb6ONJXnjYGyoQ26cUujfrhU8XV9fy2eNuth6HuHdi
         ugJA==
X-Gm-Message-State: AOAM532uy2oOq2U2QLqwgJ8yytBvdeZnhlX9t4YPp8/pJ8y1N+J6u7Jh
        7bN//lmupQKcWxc1t5d0ovY=
X-Google-Smtp-Source: ABdhPJweZ2hQonU5W8DsUPavTDofIgmCkEal3JT8z/7rb0LDv8Qq6wHaWLE60MAv7AvYLlMAIOqeeQ==
X-Received: by 2002:a17:902:ab14:b0:143:77d8:2558 with SMTP id ik20-20020a170902ab1400b0014377d82558mr68916770plb.54.1639071935399;
        Thu, 09 Dec 2021 09:45:35 -0800 (PST)
Received: from gnu-cfl-2.localdomain ([172.58.35.133])
        by smtp.gmail.com with ESMTPSA id l6sm297867pfu.129.2021.12.09.09.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 09:45:35 -0800 (PST)
Received: from gnu-tgl-2.localdomain (gnu-tgl-2 [192.168.1.34])
        by gnu-cfl-2.localdomain (Postfix) with ESMTPS id 86CC942013E;
        Thu,  9 Dec 2021 09:40:53 -0800 (PST)
Received: from gnu-tgl-2.. (localhost [IPv6:::1])
        by gnu-tgl-2.localdomain (Postfix) with ESMTP id 467C13003CA;
        Thu,  9 Dec 2021 09:40:52 -0800 (PST)
From:   "H.J. Lu" <hjl.tools@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Kennelly <ckennelly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        David Rientjes <rientjes@google.com>,
        Ian Rogers <irogers@google.com>,
        Hugh Dickens <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH] fs/binfmt_elf: use PT_LOAD p_align values for static PIE
Date:   Thu,  9 Dec 2021 09:40:52 -0800
Message-Id: <20211209174052.370537-1-hjl.tools@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend

commit ce81bb256a224259ab686742a6284930cbe4f1fa
Author: Chris Kennelly <ckennelly@google.com>
Date:   Thu Oct 15 20:12:32 2020 -0700

    fs/binfmt_elf: use PT_LOAD p_align values for suitable start address

which fixed PIE binaries built with -Wl,-z,max-page-size=0x200000, to
cover static PIE binaries.  This fixes:

https://bugzilla.kernel.org/show_bug.cgi?id=215275

Tested by verifying static PIE binaries with -Wl,-z,max-page-size=0x200000
loading.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
---
 fs/binfmt_elf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index a813b70f594e..bd78587194dc 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1110,11 +1110,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			 * independently randomized mmap region (0 load_bias
 			 * without MAP_FIXED).
 			 */
-			if (interpreter) {
+			alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum);
+			if (alignment > ELF_MIN_ALIGN) {
 				load_bias = ELF_ET_DYN_BASE;
 				if (current->flags & PF_RANDOMIZE)
 					load_bias += arch_mmap_rnd();
-				alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum);
 				if (alignment)
 					load_bias &= ~(alignment - 1);
 				elf_flags |= MAP_FIXED;
-- 
2.33.1

