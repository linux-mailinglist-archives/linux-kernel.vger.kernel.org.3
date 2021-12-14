Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58F34747F2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhLNQZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236452AbhLNQYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:24:22 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F144BC0698C7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:23:52 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id h7-20020adfaa87000000b001885269a937so4886515wrc.17
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0mmB6h+qi5LVtavm6Y/uuufvMWDJjURttWeT4uCGgOA=;
        b=krFHkJFRpG5f7PQyylfsyHH+X/3oZHTlM2bHag0ljtZokgaD8/YyPhz0OYtoZljF9p
         a/1WMF9SvMaTb9wiE7MASzLtGFT8CktrQrZ2tpyLjxKkL91geH8UeWWzwvBJv6Bc7oJU
         E+KEPa6RoW0rUQgwUpd0QXBPE9puM5GvMQ0xIh3Tvxtqpf8QygDfsFQSGIminBNT0eKZ
         oLNgqIxe1YY8jSU+kZMraZV6fkCDztyU5gCD/zBdRh535EKhlF+heSFYdyLPxt6xntXU
         vLWuKXkmWn8l2IGs4qKg3zgmOEkTk5yNhec57ZKsf5VC5RbbGWVj9NpQuNXed095KhdZ
         eyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0mmB6h+qi5LVtavm6Y/uuufvMWDJjURttWeT4uCGgOA=;
        b=MrNBG48Uv0XadwpWWXGvs/KPy5oAlbTN0qaEInA9mZulpBHXtbU2E8Jl3o8lOIb5i1
         EQ/HfVUoLAXt4Au8bDMDrVoWMakj66vbYurk97v2bKIUZ6hiaBWX1z0Xc2IOauC8k36m
         pXx1/AwEOz8L5EEBGMwnq5Q1LAcRxe8+O1EsbJsAVKClexjNVVkcPKwdELEp8GawKGJL
         DhY/MxwGGBmdyJSKly9A4WaH4uVySPM5yz+D4VVmU9iPPyRBqU0F26Mxd5JA+JCZiig7
         ppLg6oDdg4iQZkkMM7Vv2WZVRDO6g8SsrQgpRyHdXQbRgBW2SyQ+Mo9MC5lNi/UkIFja
         f0mQ==
X-Gm-Message-State: AOAM5337c8tfdb7RsKiN+E71fhs30qU+ATSeAz3FS3ssDk3wluvp9vn9
        pIrlvnN2fNt3ae7v3XdwvUjGB0zndk4=
X-Google-Smtp-Source: ABdhPJxhhlzbQHoLVXFhNi14NhI+haOVw2i1LSirQray9nV4L8GASwwdRmkzwbZcam5m1xHcTug1lx3xxjA=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a05:600c:1c8d:: with SMTP id
 k13mr2669727wms.0.1639499029840; Tue, 14 Dec 2021 08:23:49 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:50 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-44-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 43/43] x86: kmsan: enable KMSAN builds for x86
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

Make KMSAN usable by adding the necessary Kconfig bits.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I1d295ce8159ce15faa496d20089d953a919c125e
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0dc77352bc3c9..b5740d0ab0eb9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -165,6 +165,7 @@ config X86
 	select HAVE_ARCH_KASAN			if X86_64
 	select HAVE_ARCH_KASAN_VMALLOC		if X86_64
 	select HAVE_ARCH_KFENCE
+	select HAVE_ARCH_KMSAN			if X86_64
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS		if MMU
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if MMU && COMPAT
-- 
2.34.1.173.g76aa8bc2d0-goog

