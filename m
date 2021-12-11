Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4E54714F3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 18:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhLKRev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 12:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhLKReu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 12:34:50 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659ABC061714
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 09:34:50 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso10092177pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 09:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dVvpW/eukBmoMTlk5HcsZTTKJYj8AgRNLRVFbU6iZPA=;
        b=Z23cyDSDIqIJDRQnFPkJGaTIMz2a4MxTBmvLUuUdIMKxARS1DrOOtQujDZJOX1G0xD
         TDbJPW3fthuhNlCtpSZAF7W8Ptc6aMLzIc18z9Qat5w4XygADHIVH1hLBPnN2F7grtUx
         SieDsnFzFEqtBldLZ02ftlxJgoNmfbjaAK85rTLxyUSf6Njyf61lwIPdVXMcUDEfVrDy
         5wREMUKdCYMiRW10ofphMklhJ4gZ0xVHw2X7SYA4L7Z5Sklx1d3YZk34G6OwvZiGFhyV
         nchjc+oEAnOT0+OoeeEpnvPoaR5UrvPm+2a44hU9IOMnS8j4XUSDkjlDwg6DGn2K0zBm
         Zd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dVvpW/eukBmoMTlk5HcsZTTKJYj8AgRNLRVFbU6iZPA=;
        b=6dRc6xBu6v7G7JmCZmSN+FGx5g/lPm9M2600EiI3WSebPZfrpExIewDrJjMP0ovilA
         34ReI2CInx7c0Z9jsQzpeg0HSyVLABRAoBSDFKjalioKQK+l1/RaakEAi7lL/1xhZhUh
         kHvLghBrVffBSytaRf16CAeTkEnFzLPOyGFHPS7fzgc5wiV2i4/fRc8Z3SsWhM847t2j
         XlP0CcdzGgctE9nRjR9geVP5ZM0rIXrMX1dgqmgk1thbEXsn7qEd/KHIHny+XVs6Ywfo
         ydyIhWXrRg0kkZbMPy3F8SmGFnNTQpCRn4yHEoe6YIXBD1z9cQRG0F3JkA5p/NJlX8ab
         i4Lg==
X-Gm-Message-State: AOAM533ICGGX7ThdVWVXA9BLlDsRz6n/rkXXm5xo7D82lqO4fWycSv8K
        b20A4r9ItdHUTaA6oMB5zBx1MshoKRE=
X-Google-Smtp-Source: ABdhPJzM8laXIVBWiQIf9nAU1KvPLrnPTBxli2ePQhr1pxg7zCLZzbXCYYSFb01sH9/c+8Dvtd5roA==
X-Received: by 2002:a17:90a:6b44:: with SMTP id x4mr32217265pjl.27.1639244089767;
        Sat, 11 Dec 2021 09:34:49 -0800 (PST)
Received: from gnu-cfl-2.localdomain ([172.58.35.133])
        by smtp.gmail.com with ESMTPSA id lp12sm2534227pjb.24.2021.12.11.09.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 09:34:49 -0800 (PST)
Received: from gnu-tgl-2.localdomain (gnu-tgl-2 [192.168.1.34])
        by gnu-cfl-2.localdomain (Postfix) with ESMTPS id 8A60B42096E;
        Sat, 11 Dec 2021 09:34:48 -0800 (PST)
Received: from gnu-tgl-2.. (localhost [IPv6:::1])
        by gnu-tgl-2.localdomain (Postfix) with ESMTP id 779F23003CF;
        Sat, 11 Dec 2021 09:34:47 -0800 (PST)
From:   "H.J. Lu" <hjl.tools@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] fs/binfmt_elf.c: disallow zero entry point address
Date:   Sat, 11 Dec 2021 09:34:47 -0800
Message-Id: <20211211173447.4155374-1-hjl.tools@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to gABI, the entry point address in the ELF header gives the
virtual address to which the system first transfers control, thus
starting the process.  If the file has no associated entry point, this
member holds zero.  Update the ELF loader to disallow an ELF binary
with zero entry point address.  This fixes:

https://bugzilla.kernel.org/show_bug.cgi?id=215303

Tested by booting Fedora 35 and running a shared library with zero entry
point address:

$ readelf -h load.so | grep "Entry point address:"
  Entry point address:               0x0
$ ./load.so
bash: ./load.so: cannot execute binary file: Exec format error
$

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
---
 fs/binfmt_elf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index bd78587194dc..bb427c97dc02 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -850,6 +850,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 	if (elf_ex->e_type != ET_EXEC && elf_ex->e_type != ET_DYN)
 		goto out;
+	if (elf_ex->e_entry == 0)
+		goto out;
 	if (!elf_check_arch(elf_ex))
 		goto out;
 	if (elf_check_fdpic(elf_ex))
-- 
2.33.1

