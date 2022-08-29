Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBA45A562E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiH2V2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiH2V1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:27:10 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75B29F0EB
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:21 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id y16-20020a17090aa41000b001fdf0a76a4eso848687pjp.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=M/5Y14x1SSOe03/jfupiRT6TG6dq1ngDrWV9hskObuI=;
        b=keg1i0nk+izk1klWl7kacG2dqLVFCBBFr7DTBR9Vkh347LyX6fgOptbA6FX9RaUao+
         vJTGW+XEi+UTAE6ZSui/ACoLYvw+CzBRdshi7UOcb6GKyXUkGWluK1e9ViX0u2MOFUby
         n+VIqiL1KgbaHmBILZRqDKCT7yq9OcaG3eWuWfyFbeDAc3tNJSfOayUDVB763p8OZugP
         N6WyMveSXRyt1x9RwdvL650Tufs+g4oBOJJ5iU1MJBZM9QMXfDComRZRSTq/8D/ye7ef
         ZSEe/ZXHQtclALcTUMn5apyFMWCE/g3tgTBxLG+Y3u9vQ4Ps1pm7jxw7nOrCfEth2Ax0
         A9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=M/5Y14x1SSOe03/jfupiRT6TG6dq1ngDrWV9hskObuI=;
        b=8L+vhLiaG5I09SNP640CmMj8yj3iWksJ8Y2EL5WpsyMe3XjdZKywC8sNoJqywIvx8/
         3GBtZn723DbZ/X7e8iS2RoAmVKMYWI+xhHos5iIvjoQJ1jfVel1kAVjRXq7YZ7Oi/I2X
         /hmA41E/b6z599rdCu7giHzWX3YVjiy7cka75Qldi9cfXP3cT1uOmVnP4WPnoB6wld9V
         NTg5iT5h/k31o1pdohiVY1+8x2mhqZn1zGsMyRxxfSa3T5REG8/F9+n+kcBmk1KkTGVg
         r17ImoxXKAqZP3QyofbtzTw8/WziEmqFdWDLitkcYjeFGfYR67T+mhGS7I6XbfgJQS3I
         geZw==
X-Gm-Message-State: ACgBeo3qb091RusDWYEJFZ7N/+DgnXm9kT5l4IzsrSkmsAp2xlyLM2xO
        x1b2v19WctA+telW24ozkr1p74EmWco=
X-Google-Smtp-Source: AA6agR4Lx1uzJZ7T/fCqu0c+3ou3bFPxSP7qIc7HtsIZjbU9yCjHgv7Z+4FP1+5TPgAu6qrR46XQccXnjfE=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:a17:90a:e558:b0:1fb:c4b7:1a24 with SMTP id
 ei24-20020a17090ae55800b001fbc4b71a24mr21113pjb.1.1661808379380; Mon, 29 Aug
 2022 14:26:19 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:28 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-26-surenb@google.com>
Subject: [RFC PATCH 25/28] arm64/mm: define ARCH_SUPPORTS_PER_VMA_LOCK
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, riel@surriel.com,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        rientjes@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, surenb@google.com, kernel-team@android.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
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

Set ARCH_SUPPORTS_PER_VMA_LOCK so that the per-VMA lock support can be
compiled on this architecture.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9fb9fff08c94..0747ae1f3b39 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -93,6 +93,7 @@ config ARM64
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
+	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
 	select ARCH_WANT_DEFAULT_BPF_JIT
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
-- 
2.37.2.672.g94769d06f0-goog

