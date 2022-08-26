Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085EA5A2AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244015AbiHZPN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343787AbiHZPMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:12:30 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B137DF093
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:09:31 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id w20-20020a05640234d400b00447e6ffefccso1265265edc.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=+5QrT5xfdlDeiLaqkJXiB84dUzsqj5PxvneJHk/QPSg=;
        b=psU325BcC9yCrTgirTaG4c6+Xtt5yEuOoqBDgzPyoh8Hu/P8wcF78qEe5Fv8Uq6mxM
         5keARp+YcPeQ8kw2cba6I1H8TcR6qm0KRbaLOkU+IfLk8PtK83FSP/gowyt+6cMWfvxZ
         fE9laQ1Snqp2aoMqiOY1YPig7tDAMkED/KaWIJ682ZVuc6+uGvL4n3H/HrRhkL0dFAfP
         qPPg29aXbvpDPvKUJJFkWAZ+F418Tz4/xxZqjZPJP6QnWJRDQgXx2bOBAWB+HjiGP74T
         HU0Ev+YyOY48tZD9hgwrs4RkUWaxRCmaLSAihTVflh5YMg0/YJxLiIdMMS9B8R/uWWUE
         aznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=+5QrT5xfdlDeiLaqkJXiB84dUzsqj5PxvneJHk/QPSg=;
        b=Z/aPbPORWwAZct2WQX6mam5o4G6hpoH5ViXa+VLHBQg+sexlLFfQVIUHZxTqqWUZkN
         icFjFnRORb1zSgFUABLiF7DH8ZICKi0gP6sFPZtG71DmW6f6XxNI7vnCqvzi8O/rkDjm
         JEyntHUu02XzWwWmQPlf0CQHWLdrTfQut0UtAVCkqiJh8r16+oljHVlC3K8C+GKnmnju
         Xb+18njkewCBRKSXzPhGqtMOcNM1VS/4S/yVEveKH5mF2N5eHrgbbxdTzX+Hyhu8xCCD
         UGEuSPXjqZTqwsnEHzForrB0EFEEQgBh3od7ivypcLKGHKKlN5ZsUoA+TIpiYUFbVs8V
         DC1w==
X-Gm-Message-State: ACgBeo3pTEiskqfF1mw8Uju3X5sVvEstpaYvabbRFjEYRgaPHhX9m9hZ
        0N86hAZIUqfP3Q8iBM3Jt8KtaHZmwAI=
X-Google-Smtp-Source: AA6agR64mNuFawO1j56e/34eHqe4IGdV2CngnQTQuYSPV0pxJ0eEBVtcq2c/F1Fd/CUKRPUFcQzSoaSzSas=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a05:6402:496:b0:443:a5f5:d3b with SMTP id
 k22-20020a056402049600b00443a5f50d3bmr7388597edv.331.1661526570674; Fri, 26
 Aug 2022 08:09:30 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:07:51 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-29-glider@google.com>
Subject: [PATCH v5 28/44] kmsan: disable physical page merging in biovec
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
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
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN metadata for adjacent physical pages may not be adjacent,
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
index d7142c4d2fefb..af02b93c1dba5 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -88,6 +88,13 @@ static inline bool biovec_phys_mergeable(struct request_queue *q,
 	phys_addr_t addr1 = page_to_phys(vec1->bv_page) + vec1->bv_offset;
 	phys_addr_t addr2 = page_to_phys(vec2->bv_page) + vec2->bv_offset;
 
+	/*
+	 * Merging adjacent physical pages may not work correctly under KMSAN
+	 * if their metadata pages aren't adjacent. Just disable merging.
+	 */
+	if (IS_ENABLED(CONFIG_KMSAN))
+		return false;
+
 	if (addr1 + vec1->bv_len != addr2)
 		return false;
 	if (xen_domain() && !xen_biovec_phys_mergeable(vec1, vec2->bv_page))
-- 
2.37.2.672.g94769d06f0-goog

