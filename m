Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6A05AD2B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238227AbiIEMdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbiIEMbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:31:43 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8453461701
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 05:26:48 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id qw34-20020a1709066a2200b00730ca5a94bfso2270180ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 05:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=y7GARGHGPpfPMqaRIp9ae7D7QgvYSCiDFPeV4nzQ3Rk=;
        b=ddTOCduO5x6A/vNQMTAUwanA9sA0BCMeAUh+AbwWZsHDAk9+85xCqrDPAoy/kXj/yM
         pZSbfcwBzuznV/e1nsCZpHlDb15U84fy2lfiqZMe8aoHY/I7P25KzOs1d3vrlFmbReSY
         CMgox+WoZoI864HUj6y69WtC8wXEhJsfJO1HGhmgOHeHxH+VxZafKqFKdLrvdFRpq+z3
         ENymG35akVbdRkGAMGE8Z8s0OdqqWY6HbsmxVcinzKH7wWkH7p+aAzFkQtSI/s7mr3da
         ilHo8C+mpJ4L2avMdUVG4qeyBVv1yqdqrzQBpWWV9P63dsr6gXP1A1YwiJarV7ILSOFv
         WffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=y7GARGHGPpfPMqaRIp9ae7D7QgvYSCiDFPeV4nzQ3Rk=;
        b=buv5hIn8m5999+wgq4bUltWxLp8ktEwGpSNe67WO+6iBZGQhJeDlwty/hgNKONfwF0
         bVfX3TQ7hlP8kFhlCPX8xyrS2MDgca/AZp148jppbDSvpHMDUQWdNDCau+lscENQGjnh
         dd5QSfWI97GSI8RE18bXsnKFSrZ3kszBgbUdGBCH29m6+kvyUtETXGFrV+obLemM3GEo
         cmhQoe1loM4aVvipdcN6jibcSwUyF0eAC95p/rZaXObO6rOT9HuFqWl6oJau38+NQcGq
         NbgPwdcEuqzK0HFYZck1BH48KXzWywf6rFo/z1vQUjVHP0qb+Rrkeb86FzQJM4ee09bR
         g17w==
X-Gm-Message-State: ACgBeo2nOXYLeSqohN1lBVCbF83Tahjzyw6KdSbt+bM3oXqvTY4vyFVe
        A4pH+WRZSfhiOFbXq7hPn20WGDo1q5g=
X-Google-Smtp-Source: AA6agR4QT5xvR//Dr9lpspZ++6X8QeAx9PC0zKsZbmb97U5jvQ2WfdBoaCZHo4G5Gg4skY0cmggOzLItUto=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b808:8d07:ab4a:554c])
 (user=glider job=sendgmr) by 2002:a17:906:fe46:b0:730:ca2b:cb7b with SMTP id
 wz6-20020a170906fe4600b00730ca2bcb7bmr37494826ejb.703.1662380804705; Mon, 05
 Sep 2022 05:26:44 -0700 (PDT)
Date:   Mon,  5 Sep 2022 14:24:47 +0200
In-Reply-To: <20220905122452.2258262-1-glider@google.com>
Mime-Version: 1.0
References: <20220905122452.2258262-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220905122452.2258262-40-glider@google.com>
Subject: [PATCH v6 39/44] x86: fs: kmsan: disable CONFIG_DCACHE_WORD_ACCESS
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
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dentry_string_cmp() calls read_word_at_a_time(), which might read
uninitialized bytes to optimize string comparisons.
Disabling CONFIG_DCACHE_WORD_ACCESS should prohibit this optimization,
as well as (probably) similar ones.

Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I4c0073224ac2897cafb8c037362c49dda9cfa133
---
 arch/x86/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 33f4d4baba079..697da8dae1418 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -128,7 +128,9 @@ config X86
 	select CLKEVT_I8253
 	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
 	select CLOCKSOURCE_WATCHDOG
-	select DCACHE_WORD_ACCESS
+	# Word-size accesses may read uninitialized data past the trailing \0
+	# in strings and cause false KMSAN reports.
+	select DCACHE_WORD_ACCESS		if !KMSAN
 	select DYNAMIC_SIGFRAME
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
-- 
2.37.2.789.g6183377224-goog

