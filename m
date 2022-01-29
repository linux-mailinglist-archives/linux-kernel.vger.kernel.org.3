Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9444A2ACF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 02:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351936AbiA2BCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 20:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiA2BCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 20:02:45 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D5CC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 17:02:45 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id n6-20020a9d6f06000000b005a0750019a7so7379964otq.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 17:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PpOuM7drLoUIl4lwc9nRVacziqUgNpI3pypkXTl2W3Y=;
        b=d1KeHjFBrMAvw9g0Y2OvCJmODAk04mxW+SRBCM6tzgt3oIKKLc5b6AMyzLmn4N4EBM
         gl8Yrsn39hKQq/eIGu2iIxkAw1+jezSNhAHgoh7UwVNvakRmvjBmffJV/KQ/RhLiRWn3
         IT5Vmh8++kNrg9zpG7WHVKfW8PybZhLCMLGfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=PpOuM7drLoUIl4lwc9nRVacziqUgNpI3pypkXTl2W3Y=;
        b=oipUOqyubIUvC/apP+rPFpsbWYcdxsUHuPqG4nXjBVWCd/8lzR7mcPr5v8IOKp468u
         UP+CcUEmlUCzGbBOhM6pVMYQA3wrbBUlI1WG0JTa1vhWxRtw/BwCvQsbb0waN8ormMrC
         QmRRny7IXhVzX+U2Fw3HhCiW8PKbEjzw6EImpTUTN5lSFg9/U2ZtYx8OM0Xe93BJyTJy
         Rr6csKzxTGS2exqhLHF7fWL8vqeDDNIzQ/DGLjsyun596WS153VKkENUz58IA/swaSvT
         acvZtXMxl637AUTo6Von0S4TBKvnf+0QND+SJHETVKmDXfMCe9HmunobCk5ABf6og+OD
         OMXw==
X-Gm-Message-State: AOAM531lY/lwxXpC0I33jH87qogNJHgrus7MfQFfihn6tR55yT7Wmiwo
        4yatt7Wf4TBSXOkj6zircC3xZFj2NHUfxg==
X-Google-Smtp-Source: ABdhPJz/3ZHiuhZMvZrkACWHCGfBvnGtZ7fWFKhDpm+TarCXGPIFRCPUWV/1NgX9qvfW/h9OMUB6LQ==
X-Received: by 2002:a05:6830:2646:: with SMTP id f6mr5103614otu.290.1643418164967;
        Fri, 28 Jan 2022 17:02:44 -0800 (PST)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id r14sm114295oiw.40.2022.01.28.17.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 17:02:44 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
From:   "Justin M. Forbes" <jforbes@fedoraproject.org>
To:     "Justin M. Forbes" <jforbes@fedoraproject.org>,
        linux-kernel@vger.kernel.org
Cc:     jmforbes@linuxtx.org, Jakub Jelinek <jakub@redhat.com>
Subject: [PATCH] Fix for gcc12 compile issues in ubcmd-util.h
Date:   Fri, 28 Jan 2022 19:02:14 -0600
Message-Id: <20220129010215.781601-1-jforbes@fedoraproject.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the current code builds fine with gcc 11, it does not with gcc 12,
resulting in:

In file included from help.c:12:
In function 'xrealloc',
    inlined from 'add_cmdname' at help.c:24:2:
subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
   56 |                 ret = realloc(ptr, size);
      |                       ^~~~~~~~~~~~~~~~~~
subcmd-util.h:52:21: note: call to 'realloc' here
   52 |         void *ret = realloc(ptr, size);
      |                     ^~~~~~~~~~~~~~~~~~
subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]
   58 |                         ret = realloc(ptr, 1);
      |                               ^~~~~~~~~~~~~~~
subcmd-util.h:52:21: note: call to 'realloc' here
   52 |         void *ret = realloc(ptr, size);
      |                     ^~~~~~~~~~~~~~~~~~

The was mentioned in upstream gcc bug
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104069 where it was
determined that gcc was correct and the kernel needed to change.  This
fixes that use-after-free and makes things build again.

Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
Cc: Jakub Jelinek <jakub@redhat.com>

---
 tools/lib/subcmd/subcmd-util.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/lib/subcmd/subcmd-util.h b/tools/lib/subcmd/subcmd-util.h
index 794a375dad36..7009fc176636 100644
--- a/tools/lib/subcmd/subcmd-util.h
+++ b/tools/lib/subcmd/subcmd-util.h
@@ -49,13 +49,12 @@ static NORETURN inline void die(const char *err, ...)

 static inline void *xrealloc(void *ptr, size_t size)
 {
-	void *ret = realloc(ptr, size);
-	if (!ret && !size)
-		ret = realloc(ptr, 1);
+	void *ret;
+	if (!size)
+		size = 1;
+	ret = realloc(ptr, size);
 	if (!ret) {
 		ret = realloc(ptr, size);
-		if (!ret && !size)
-			ret = realloc(ptr, 1);
 		if (!ret)
 			die("Out of memory, realloc failed");
 	}
-- 
2.34.1

