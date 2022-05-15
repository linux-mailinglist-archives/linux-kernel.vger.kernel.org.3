Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA165279B2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 22:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbiEOUBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 16:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbiEOUB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 16:01:26 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA84115E
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 13:01:25 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u23so22653752lfc.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 13:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KXD8XuC6lGBVzyqbnaNhW/9Jgk1+Ek/2FLjcPeEVLJA=;
        b=KH5+P8Xoi5HgyXB7Y+7GMpsUsGVV6RDdEUampVl6jnhZxuvpLkdrzHHFIKi7VLgOQV
         UHr4MVDLXs0NOxd0t6wApmnjRo/n5HKhEWi5ibYjjxhZk6DICECGZBfkulbgqbHT+ooC
         0zuvcX3HGyZnBWz3TWGwWAPPyT5qhoIWXKS4z0HltbTR+DvoYj2xi2DLU6uHAUffPtzN
         gZ0vPGsW3tKgS22I72Agpv/XHZeE5sZjxnkjZMMozRBvYgZZn0wGBdqXoqzBA1Q7GthI
         SPXY4w4bg6l4OX1pH7GxfPPkob/iAgAqYr4U9KF+RCLnZ1dbUoHkHP+y3gmPSyTainix
         vNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KXD8XuC6lGBVzyqbnaNhW/9Jgk1+Ek/2FLjcPeEVLJA=;
        b=rsfpPh087jIm0aQ0UHR18DwARtzX5hFi5v4Eo0aaOlNTUvNJqsBAvK8H05/bemhOKv
         gE7L62Iu70m8q95v7WfR1v5xjo3qooydT0RO1szgI06psWtp80bmx8X8O8gXckVpfA8R
         7XtDZanPWvEd6iueCRmTwr+E/yMHxx8NgAnb85KZPi3g0brsk2I59/Fhm8zWY41PxCvk
         XRhlV7DIIXa/9xfatPQiGdmPe1vHMPXJ5u5kUNa0jOmoqDQK8WJSwMPrNcprDo00dNc3
         seE2cXwgIR1ldA7Ervv0TCd9XW5RRyebIvKL0h8oUEPj1kTq1eyrvw07JFgNrp1dIqdN
         JsPQ==
X-Gm-Message-State: AOAM530C+6IAeAa37Gq1fO/UhIjr49kZvjyfES2Vgo/yVheY6JlmW5fw
        qKRZ7NNvneYGseDIUDFkKmTSSM7kH4Q=
X-Google-Smtp-Source: ABdhPJyVp1bL9PhOCNDmLztDmC0ZfC5UKbkq60mzC+SVyNyN8IH8vEaPFuRcGyaj2fVkg6u9xESa5Q==
X-Received: by 2002:a19:ca02:0:b0:474:854:ed5c with SMTP id a2-20020a19ca02000000b004740854ed5cmr10574246lfg.643.1652644883805;
        Sun, 15 May 2022 13:01:23 -0700 (PDT)
Received: from localhost ([178.170.168.3])
        by smtp.gmail.com with ESMTPSA id j20-20020a2e8014000000b0024f3d1dae96sm1295878ljg.30.2022.05.15.13.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 13:01:23 -0700 (PDT)
From:   Maxim Zhukov <crazycdeveloper@gmail.com>
X-Google-Original-From: Maxim Zhukov <mussitantesmortem@gmail.com>
To:     chi.minghao@zte.com.cn, varad.gautam@suse.com, arnd@arndb.de
Cc:     akpm@linux-foundation.org, shakeelb@google.com,
        vasily.averin@linux.dev, manfred@colorfullife.com, dbueso@suse.de,
        linux-kernel@vger.kernel.org,
        Maxim Zhukov <mussitantesmortem@gmail.com>
Subject: [RFC PATCH 1/1] ipc, sem: fix backward compatibility with x86-32 kernels
Date:   Sun, 15 May 2022 23:01:03 +0300
Message-Id: <20220515200103.1408370-2-mussitantesmortem@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220515200103.1408370-1-mussitantesmortem@gmail.com>
References: <20220515200103.1408370-1-mussitantesmortem@gmail.com>
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

Since with commit 275f22148e87 ("ipc: rename old-style shmctl/semctl/msgctl syscalls")
we have changed behavior:

ksys_semctl lost parse ipc version (ipc_parse_version), because the
new syscall works with IPC_64 only, but the parse function has some
side effect - it removes IPC_64 bit from `cmd`.

Some libc forced sends IPC_64 bit in semctl syscall[1][2][3], this leads to
a bug - X86-32 kernel does not have compat headers and does not
correctly parse received command (cmd) from semctl syscall: cmd have actual
command and IPC_64 bit, thus throw EINVAL error in ksys_semctl

This commit forcibly removes IPC_64 bit from the cmd for restore
backward compatibility.

[1]: https://elixir.bootlin.com/uclibc-ng/v1.0.40/source/libc/misc/sysvipc/sem.c#L58
[2]: https://elixir.bootlin.com/musl/v1.2.3/source/src/ipc/semctl.c#L48 -> https://elixir.bootlin.com/musl/v1.2.3/source/src/ipc/ipc.h#L22
[3]: https://elixir.bootlin.com/glibc/glibc-2.35/source/sysdeps/unix/sysv/linux/semctl.c#L124

Signed-off-by: Maxim Zhukov <mussitantesmortem@gmail.com>
---
 ipc/sem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index 0dbdb98fdf2d..824244170000 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1706,7 +1706,7 @@ static long ksys_semctl(int semid, int semnum, int cmd, unsigned long arg, int v
 
 SYSCALL_DEFINE4(semctl, int, semid, int, semnum, int, cmd, unsigned long, arg)
 {
-	return ksys_semctl(semid, semnum, cmd, arg, IPC_64);
+	return ksys_semctl(semid, semnum, cmd & (~IPC_64), arg, IPC_64);
 }
 
 #ifdef CONFIG_ARCH_WANT_IPC_PARSE_VERSION
-- 
2.36.1

