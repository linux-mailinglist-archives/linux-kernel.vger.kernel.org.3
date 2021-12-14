Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B254747D6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbhLNQX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbhLNQXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:23:36 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70227C061401
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:23:19 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id n41-20020a05600c502900b003335ab97f41so8136348wmr.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=K7KNAkPu1tNb8bk4GPAMmgVYqdU6o+fe9Mb7fPVoOyI=;
        b=G0L/Wdncp6Gni0cblJguzTT3iS9QmzVrffr3F/SfdUNYfhxPW9fK7kTpBD4PnldE1q
         ppln1bGIuFkwcycMoMXPBzJCPg64PGFdw6LxG/xXSdTjx9b7aO+phT9wOvWs7F9e/j9a
         dVjrC4LrZYW65Q8Mxljf+M2EXFWMJu/dZmj731PaaqJ2aRorwhDuwU5TDTo66+7L/g/a
         OZXlOAjxK7I56M4gxWcNfBT1Ta0iLNBOGmoTs5MhpoamF9qbyxugIJhBLcYtr9bQDgPr
         +XZSssz5qZ+zxw+qIUjWCnUuQRw4oJpTS0W4LBdCbg4jljRNLmRAzcLKNLnUamEzkSYt
         QKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K7KNAkPu1tNb8bk4GPAMmgVYqdU6o+fe9Mb7fPVoOyI=;
        b=fmyODbz3bBpSgx/zWMoC+rlxCYnayj6LklRh+sPDAzfuXl4RbBT8i5eMZRwPY7ZE4m
         t/TUAPYC5ybNI/EGkSxvpI9wfHHEWWhkXqUNCe3Wm3Q98ocki4VDrZDXWzMLMXo6txRX
         5I4vw8FvPyQUM9gQSVcdrOPH1KwsHxNMPcZ/9IlEe0FAf/tp25WwtsTi9ExJqDz5loyh
         AHe/Y6XURJw0pQBGF1VhpLG0GyOYyYRvXBjMu8ynsBzq2zrm7oAWv1ccStePs5CD9pL+
         ZMtgAthutcWawtUF5SIN1ZoUE2pObaUX321VbUbLbOLEadcO4sBM0s+zfKEZ+L531bn5
         zsOw==
X-Gm-Message-State: AOAM5302vVUpKgVL7AAjoKguQ/G2enwQSjHFfaLXBPAcnxVX9tTpUHaT
        Pha77g6D97Q1+eDuSWdBswxzn8vAg1s=
X-Google-Smtp-Source: ABdhPJyh8hwv6S6A0JAsQFUdEw4jAxTz8TFmEuQoPKffBGTuVheoEhUhVINkFtZLYMlQqoKqsIhCPBJ7rWE=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a05:600c:3b83:: with SMTP id
 n3mr9260wms.116.1639498997872; Tue, 14 Dec 2021 08:23:17 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:38 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-32-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 31/43] kmsan: disable strscpy() optimization under KMSAN
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable the efficient 8-byte reading under KMSAN to avoid false positives.

Signed-off-by: Alexander Potapenko <glider@google.com>

---

Link: https://linux-review.googlesource.com/id/Iffd8336965e88fce915db2e6a9d6524422975f69
---
 lib/string.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/string.c b/lib/string.c
index 485777c9da832..4ece4c7e7831b 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -197,6 +197,14 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
 		max = 0;
 #endif
 
+	/*
+	 * read_word_at_a_time() below may read uninitialized bytes after the
+	 * trailing zero and use them in comparisons. Disable this optimization
+	 * under KMSAN to prevent false positive reports.
+	 */
+	if (IS_ENABLED(CONFIG_KMSAN))
+		max = 0;
+
 	while (max >= sizeof(unsigned long)) {
 		unsigned long c, data;
 
-- 
2.34.1.173.g76aa8bc2d0-goog

