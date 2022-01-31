Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CCB4A5001
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378531AbiAaURi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiAaURc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:17:32 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48ECBC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:17:31 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id f10so2785611lfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O6VKZKKyIdq3g+N3XZft2261A1LgNMUgx3vPs4xCSjk=;
        b=Ah2Yd3veC2m6f5T/74U0jzdt0p5btJfuVBmFunyJcgq6TLZhhdiAMr4076jXVS+Yz9
         qCu1ElnK6NiB3/LI7/jleMqqHvPRLnco5pHWhJc5hGvkizGxCt1raOWk9vnmVH2wE7ln
         y5Qc+gnNzIZP93NBdZOOtNmKhWedE8+uzDGzpozmLA/bG7jDVgONjirc+PC2rbayiXVL
         eBe8WvWc/wRLJ0eCgWLAOSKQOeF4iSnOJDh9adtd5XTmIV3JZRQZFmTzCuf8t+0ah7E/
         WimPA8ajzuB1eKEWuWLmKCPYT7wchEMba8WWdTbP1hD0379uab4QSmuthRFt+z7Y4T+d
         qF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O6VKZKKyIdq3g+N3XZft2261A1LgNMUgx3vPs4xCSjk=;
        b=Hgz6W67wAH5KhvFp0dcTxydK9g5HHq/cznz5IrwVZu14fZiwJP5oPPgiMcbudVY1wh
         5qwHEzk07Jc+hOz1hCi9SRrJK0KtijfGcet4/8iS4dHHkz0OmtF787Wdk0dgdsxVWMKa
         0rnQbkcKg11mGCJlBOAqKJGKf/R5cSIwazADxi9IXsVrxxxMMIqXTQiPB3isjAf6XZUb
         B9gjgqMZCgmntF+ZFDTDA8MVhQt/usQzfqIOZ0OGNXqP2Fjbx+LXKYb/l5gbeYlAVZsX
         saps1pxaBS7aXEr9bmXIhLRf0Rge0rrxw4nlkrrw6bP4XWb4RQQ3F/uBrwW00TSABOD6
         Zuog==
X-Gm-Message-State: AOAM533trv0oNuundMrMM/DdUMWa3p1t/Qnf2RuQ/mTO72lJsQBBQTFM
        iNv+L5Hjgg6Bu6jCBK38w3hg3WtsKaCciw==
X-Google-Smtp-Source: ABdhPJwV8qrc6QshCj8tZe21mpS37iIzE87HOLv6hPeoS3poaA3jb2sBvRLSm2nL4cLbT9FSHffHMw==
X-Received: by 2002:a05:6512:76:: with SMTP id i22mr17083107lfo.294.1643660249254;
        Mon, 31 Jan 2022 12:17:29 -0800 (PST)
Received: from localhost ([146.66.199.134])
        by smtp.gmail.com with ESMTPSA id d25sm1348810lfe.297.2022.01.31.12.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 12:17:28 -0800 (PST)
From:   Azat Khuzhin <a3at.mail@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Azat Khuzhin <a3at.mail@gmail.com>,
        Chris Kennelly <ckennelly@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        David Rientjes <rientjes@google.com>,
        Ian Rogers <irogers@google.com>,
        Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        "H . J . Lu" <hjl.tools@gmail.com>
Subject: [PATCH] fs/binfmt_elf: use ELF_ET_DYN_BASE for PIE (ET_DYN with INTERP) binaries
Date:   Mon, 31 Jan 2022 23:17:16 +0300
Message-Id: <20220131201716.5198-1-a3at.mail@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 9630f0d60fec ELF_ET_DYN_BASE is not used as a load_bias anymore
and this breaks PIE binaries, since after this change data segment
became too nearby the stack:

Before 9630f0d60fec:

    $ strace -febrk /tmp/test-stack |& head
    brk(NULL)                               = 0x555555559000
    $ /tmp/test-stack
    bottom_of_stack = 0x7fffffffc5c0
    recursion depth: 1 (stack diff: 32)
    ...
    recursion depth: 7690 (stack diff: 8365664)
    Segmentation fault (core dumped)

After 9630f0d60fec:

    $ strace -ebrk /tmp/test-stack  |& head
    brk(NULL)                               = 0x7ffff7fff000

    $ /tmp/test-stack
    bottom_of_stack = 0x7fffffffc640
    recursion depth: 1 (stack diff: 32)
    ...
    recursion depth: 146 (stack diff: 157792)
    Segmentation fault (core dumped)

Found this during compiling with clang, that started to randomly
SIGSEGV when it eats some heap.

Reproducer:

    #include <stdio.h>
    #include <stddef.h>
    #include <stdlib.h>

    static int depth = 0;
    static void* bottom_of_stack;

    int inner()
    {
    	char buffer[1024];
    	ptrdiff_t diff;
    	int ret;

    	++depth;
    	diff = bottom_of_stack - __builtin_frame_address(0);

    	fprintf(stderr,
    		"recursion depth: %i (stack diff: %zu)\n",
    		depth, (size_t)diff);

    	for (size_t i = 0; i < 1024; ++i)
    		ret += buffer[i];

    	ret += inner();

    	return ret;
    }

    int main()
    {
    	for (size_t size = 0; size < 128<<20; size += 16<<10)
    		malloc(16<<10);

    	bottom_of_stack = __builtin_frame_address(0);
    	fprintf(stderr, "bottom_of_stack = %p\n", bottom_of_stack);
    	inner();
    }

Fixes: 9630f0d60fec ("fs/binfmt_elf: use PT_LOAD p_align values for static PIE")
Signed-off-by: Azat Khuzhin <a3at.mail@gmail.com>
Cc: Chris Kennelly <ckennelly@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: Fangrui Song <maskray@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: H.J. Lu <hjl.tools@gmail.com>
---
 fs/binfmt_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 605017eb9349..9e11e6f13e83 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1117,7 +1117,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			 * without MAP_FIXED nor MAP_FIXED_NOREPLACE).
 			 */
 			alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum);
-			if (alignment > ELF_MIN_ALIGN) {
+			if (interpreter || alignment > ELF_MIN_ALIGN) {
 				load_bias = ELF_ET_DYN_BASE;
 				if (current->flags & PF_RANDOMIZE)
 					load_bias += arch_mmap_rnd();
-- 
2.35.1

