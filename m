Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF93D4747D9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbhLNQYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbhLNQXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:23:41 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ADFC0617A2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:23:26 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id q17-20020adfcd91000000b0017bcb12ad4fso4851379wrj.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lDpTBNT0I1htzh1pdmjOA/Qp6nY6br0HXEMQd54phuU=;
        b=ArbC5Qlw/tWeRiWIZ1Y48jy30BP5Te592XfZpzZzD9zBlvepDTy+VQtTG21UxQ8inK
         yQOL5/iUYpmsTAyvZc8sQ9pumSl56H835fYEsQC9eio3bftA2y4TABqOc425Iji7rzD0
         do7F/rEnnb+z0YaTwIqETnbFACe96SBPqBguZuj54fKEJhmlonknYdgCZJITPILp2O8R
         g/Ch0maZBcRaaUc1L/BUARrklla29VQPtw7qZiFG7IkzEUDEQh2/qgw8/gSMxyyP557X
         lu6CsOw225+EBUfCeJYIAFjyIdvEIiMwSAf2MXapEHMvfzu2rBKYIJpXiVaqCG5w0PwO
         hITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lDpTBNT0I1htzh1pdmjOA/Qp6nY6br0HXEMQd54phuU=;
        b=SElhGGh16DQ5+VZkO9EiIaPV+5h0I9TkVLJ6+h2B2vpvZGQLpbm+7jyxFzcCZjYSS+
         fU5YmwBMVHmi8X3iFH81e2hq26I4rPo1kGhe4xfAZPBRT63jZMNVki6+IWZ071keCsi8
         jtDjMp9+MwILHyQ64SWxN0IN1+HDP4Hj58cG+AL1FduCNKvTpgyhRHhbV994oZBa6TS/
         kDTa5tGz7ZSg1F59K+wK2PrKmnwfNmw0oEAjyz4StbARJWKhs5/6udtW9ZIF7UU7sLzE
         NP9j7tV4VUieLgRxRNGjz0AB5JxVmWxFV5mQpWj37xmYzIaof5Kvn9juYBsi79wHDSe3
         ohJQ==
X-Gm-Message-State: AOAM531Lxkc+Lz8QbGFqS/hrI44v5mEPIp3yxGRCdyJZgexcy8kfjyTM
        tNLa4jIoG93HUzUzfvst3hPSovwnB0g=
X-Google-Smtp-Source: ABdhPJzd3+JglaYvwaWg/MkbkJuCDnCFW7n3Gc9z2XLMoLSMqx+inrD6O9GNKx7jFbb1Shu5Z94RjWGqmAw=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a05:600c:1d1b:: with SMTP id
 l27mr5819855wms.1.1639499003427; Tue, 14 Dec 2021 08:23:23 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:40 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-34-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 33/43] kmsan: disable physical page merging in biovec
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

KMSAN metadata for consequent physical pages may be inconsequent,
therefore accessing such pages together may lead to metadata
corruption.
We disable merging pages in biovec to prevent such corruptions.

Signed-off-by: Alexander Potapenko <glider@google.com>
---

Link: https://linux-review.googlesource.com/id/Iece16041be5ee47904fbc98121b105e5be5fea5c
---
 block/blk.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/blk.h b/block/blk.h
index ccde6e6f17360..e0c62a5d5639e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -103,6 +103,13 @@ static inline bool biovec_phys_mergeable(struct request_queue *q,
 	phys_addr_t addr1 = page_to_phys(vec1->bv_page) + vec1->bv_offset;
 	phys_addr_t addr2 = page_to_phys(vec2->bv_page) + vec2->bv_offset;
 
+	/*
+	 * Merging consequent physical pages may not work correctly under KMSAN
+	 * if their metadata pages aren't consequent. Just disable merging.
+	 */
+	if (IS_ENABLED(CONFIG_KMSAN))
+		return false;
+
 	if (addr1 + vec1->bv_len != addr2)
 		return false;
 	if (xen_domain() && !xen_biovec_phys_mergeable(vec1, vec2->bv_page))
-- 
2.34.1.173.g76aa8bc2d0-goog

