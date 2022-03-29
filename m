Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1AA4EADA4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 14:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbiC2MuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 08:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbiC2MsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:48:14 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58D725F641
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:42:47 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id v9-20020a509549000000b00418d7c2f62aso10949038eda.15
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BxrNv7I9TyEaPnGly7TdSY5yHzK/Q3Z4xNLrOUnkClQ=;
        b=F1YYot40OfwHFlJIBEjvvi7+vEf+sISqzpxyEMm9RXg7yBeYOovpz1ifEVjxkb+8Tp
         ug846iZxjLR7LfZGindUZ5W5ZYWx9SXUM/LIzPff3L9xOwWnmqR34pPLPPicL7EpVaWh
         BceAVU1QYjQ33h5UnMxF7NMbTCP79zz+hCjBe7DzaqQKiuOmpo0Q92dqE8k4H4xhYPJ5
         8QBDPgbSjW2Dxw8rRJh4j124haAPk3WZ7kH3MZRK7aTRX+53Kfdw+whZ5Qh3OkEuEe4V
         /YzlCDf1dkIQcIX6qS1kNTRw9/AS3wlsNX6fJ044mUGy/rWkdQ4G5sXgY/2nnNeFCaLN
         ovQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BxrNv7I9TyEaPnGly7TdSY5yHzK/Q3Z4xNLrOUnkClQ=;
        b=pChCIOBw5Gwsp1UMHjnMYttdpjWi9Cd7wkYMPALOGWCmPqopcg0GHkwz7JDTCExlbV
         f+Zzo8PLhpMOm8CabCEPiu0yD3Ef83VdIYlbZGgRrHZkEm4zcB8KMVbsfERL62ptJRiq
         A5zMTYTTeq2aDAP/04dG9avWOe0jrrrJjfc5pwPq6ntQUYmMHuGCsZ0CS7CHvOdf6D3J
         qcG+Ho5N5BlzOOisbK430wc/rfPT5o6uWmz+fuBAs8SPgcAh1a4QdffvAuFrp4WMa7Nw
         VGqi0JxwW049Y08lYUGsuBcciImbaBGzZ0JaGAZWMzdUxolqPwGlMVoCEizopH7AOd2S
         nGrw==
X-Gm-Message-State: AOAM53338x+PGjQHcIY04VdZvTjtHN7Vk4hRBL8w4xeDdTVw6bPbil7w
        HNaY0vEDWS210tBcOj+k4OmQhe5ncgU=
X-Google-Smtp-Source: ABdhPJwCpxSBAahtijoWXTLXmqk0cIsPTNznjrswrMwUWM6rymRvh0IEM+UvEt2qc+MfcoyqAjf1DJp1rgo=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:906:c1c6:b0:6d5:cc27:a66c with SMTP id
 bw6-20020a170906c1c600b006d5cc27a66cmr35151648ejb.650.1648557756848; Tue, 29
 Mar 2022 05:42:36 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:40:17 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-49-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 48/48] x86: kmsan: enable KMSAN builds for x86
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
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

Make KMSAN usable by adding the necessary Kconfig bits.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I1d295ce8159ce15faa496d20089d953a919c125e
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 646a7849be4cf..1c4601e198d5c 100644
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
2.35.1.1021.g381101b075-goog

