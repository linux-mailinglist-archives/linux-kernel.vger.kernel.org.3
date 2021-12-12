Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B2E471CFF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 21:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhLLUlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 15:41:46 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:42965 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhLLUlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 15:41:45 -0500
Received: by mail-pg1-f170.google.com with SMTP id l18so8103794pgj.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 12:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4YfyjGwL0fO0EBfR6sx5TSf2Ji7D/1iZdFBNX3WGH7k=;
        b=hbZk86Rh1ja1EVHycDQbZ5yhi4p9SSDvYPjGKJA/IUu4H5QveCu1Y72pfgQkVB4rum
         3N+GTtAA/5jJiJ1MW2n/42+JDntgW4GfoTy58tfUiORfs3weAzAZS1rnHtq6TKwwFQFH
         +ifqIsSFgOhvY6dDZO0pOBfIgamNmlhAnVc8/NLkIOZIuM4xV0m36kWT4kpLa4UYsxg0
         AkqYI86C4HU79SluLPZf8RpdkLu1AKgekuScKB7iH5eHNeMd9cNLedd5bbi+ObqgJxPn
         Cn8DpP04ByBv3odfcbLSIN2AUkMJEWMta1ILSj9vr79OeG8/I7RJUK+Ja3E66pzMrkK+
         O85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4YfyjGwL0fO0EBfR6sx5TSf2Ji7D/1iZdFBNX3WGH7k=;
        b=e5coIaJmkHAloj7NOcQZFNrvY1vnrGGInpvLrx28CIYcmTVchkscjnfdEOsX6n5BiM
         31gikM8ie4sFacNzDZXwYaXG2VTC35VdIdXPifWfjAAoA0U56qBpkxKQ1gmUha3sFSeD
         D0xHQDDDVzwRPM/wAtsdask+Uex+8dGrkN4D/fljomhfgjm8Oub36UJmaiTQC0MNmGc3
         JezLBGPdn2Ha1DQ3iZseC6L62O4MeueF4bTnpi2/krhIMPiO24uXO1b8UEigeUcRWDNy
         bTMSZE/Br4Gs0ww4Z9kqnwFNt39ohPVB9gqca8WoiR/05qHc7/E8I1t8H13szjWmS2PP
         mGUw==
X-Gm-Message-State: AOAM531HTSU+VnfUsT7nYD1uJSsPRWUAzOjK3CA8wwWEi+j19MCPDaBE
        0om9XkbthUd/quFh6WZGONG4CN8QkP8=
X-Google-Smtp-Source: ABdhPJywP8j3exLzGmCuikhLrBPKLXZfk1c0trkn6italit9wM/Ke4t9+6K8im8es1+camrVLKxB7Q==
X-Received: by 2002:a05:6a00:1693:b0:44c:64a3:d318 with SMTP id k19-20020a056a00169300b0044c64a3d318mr30051864pfc.81.1639341645572;
        Sun, 12 Dec 2021 12:40:45 -0800 (PST)
Received: from gnu-cfl-2.localdomain ([172.58.35.133])
        by smtp.gmail.com with ESMTPSA id j7sm10178745pfu.164.2021.12.12.12.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 12:40:45 -0800 (PST)
Received: from gnu-tgl-2.localdomain (gnu-tgl-2 [192.168.1.34])
        by gnu-cfl-2.localdomain (Postfix) with ESMTPS id 4AABF4208A3;
        Sun, 12 Dec 2021 12:40:44 -0800 (PST)
Received: from gnu-tgl-2.. (localhost [IPv6:::1])
        by gnu-tgl-2.localdomain (Postfix) with ESMTP id 1C39A300326;
        Sun, 12 Dec 2021 12:40:43 -0800 (PST)
From:   "H.J. Lu" <hjl.tools@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH v2] fs/binfmt_elf.c: disallow invalid entry point address
Date:   Sun, 12 Dec 2021 12:40:43 -0800
Message-Id: <20211212204043.231568-1-hjl.tools@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Linux, the start of the first PT_LOAD segment is the ELF header and
the address 0 points to the ELF magic bytes.  Update the ELF loader to
disallow ELF binaries with entry point address smaller than the ELF
header size.  This fixes:

https://bugzilla.kernel.org/show_bug.cgi?id=215303

Tested by booting Fedora 35 and running a shared library with invalid
entry point address:

$ readelf -h load.so | grep "Entry point address:"
  Entry point address:               0x4
$ ./load.so
bash: ./load.so: cannot execute binary file: Exec format error
$

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
---
 fs/binfmt_elf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index bd78587194dc..7f035022131b 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -850,6 +850,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 	if (elf_ex->e_type != ET_EXEC && elf_ex->e_type != ET_DYN)
 		goto out;
+	if (elf_ex->e_entry < sizeof(*elf_ex))
+		goto out;
 	if (!elf_check_arch(elf_ex))
 		goto out;
 	if (elf_check_fdpic(elf_ex))
-- 
2.33.1

