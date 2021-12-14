Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8AE7474795
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbhLNQWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbhLNQWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:22:04 -0500
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6CAC061401
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:22:03 -0800 (PST)
Received: by mail-lf1-x149.google.com with SMTP id f15-20020a056512228f00b004037c0ab223so9013372lfu.16
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T+mYYL6aSbEG/4iKq3fuhN/0C7rIH3abijCddrO3Btg=;
        b=DCe7tBgES2hvR4caFxy5bljYM1IT44WZzYzikcnqZUOJYlBBpJqB6nRuLLyzsaMupI
         +zXKLFJ7f3UI79Rmtw28+xRXo8HNv+qUnzkeyIO7L+5D3boqrr2FNBogjt5YON2BTV1u
         AFx1rnPzU6vEU1A6/jgSC9hZLl05kZuxP3s0cd1WgWE7jYEl1d8Mvo0h6VTze1GPd9qP
         u0gcVOi9sYfqx+0A/Hd2f3NIBmpk1jfJD9n/izeZtsvQEeb0tr4plLmMtbjfmWKKRwmf
         pnlj7ZnCniw0y7nFqrzGkFg44r4tZcbmetehf9NjhTG7/aFMSy/ubcrZ5v5wlj0BqfdP
         ahZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T+mYYL6aSbEG/4iKq3fuhN/0C7rIH3abijCddrO3Btg=;
        b=uIh6gmd/AmWRiPgze/C+hNys/Uy0VuQdNpxMAMZZx7dV+P8kd8ODbVWvjAf2Hji60u
         X/Cn9esbfhp2YQBVvSw9lWm7e3d8UvnjT4v+Rj4N6gm611laBy47E0DcIrDbkInfBpJd
         zqf2ZZ3HD+1wBn6k7lS3aMugDc+Sgi/8ggLTuDY7RNVzzFLwVukN74z0G/a6KEUsGUv9
         xHYTGNUIwQVqYWIMUHE915G+sVJ5bIzbepAfWLYwPZiPsqKRvthFJvw2qOspFgiARfBi
         4Xl+0MQ9Bn294ObvSoSccAEIbdQsnKgSX/pkqw6mZvqr2yS1Do5anIZi+L2uGLTinQrX
         H2MA==
X-Gm-Message-State: AOAM533LhKbRRdr8ID9N39S0cHyEcjJh/LVKYgb11SRtS9NCKtATsWUa
        GEqh9z7JDpZka2k8gmL+xIwq+wIb/Rg=
X-Google-Smtp-Source: ABdhPJzSecVDmOS9zjdfpZRUjT0HViIDEGkgFckmlsJrOrsrpGbbAJowPx7hwdmUVKVKoxwpUINCdecE840=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:ac2:44c5:: with SMTP id d5mr5598346lfm.275.1639498921745;
 Tue, 14 Dec 2021 08:22:01 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:10 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-4-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 03/43] kasan: common: adapt to the new prototype of __stack_depot_save()
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

Pass extra_bits=0, as KASAN does not intend to store additional
information in the stack handle. No functional change.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I932d8f4f11a41b7483e0d57078744cc94697607a
---
 mm/kasan/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 8428da2aaf173..6c690ca0ee41a 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -37,7 +37,7 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc)
 
 	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
 	nr_entries = filter_irq_stacks(entries, nr_entries);
-	return __stack_depot_save(entries, nr_entries, flags, can_alloc);
+	return __stack_depot_save(entries, nr_entries, 0, flags, can_alloc);
 }
 
 void kasan_set_track(struct kasan_track *track, gfp_t flags)
-- 
2.34.1.173.g76aa8bc2d0-goog

