Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F94E5A9E3C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbiIARiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234433AbiIARhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:37:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF4A9AFBC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:36:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d8-20020a25bc48000000b00680651cf051so4960010ybk.23
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=OXbMCMaGP4Ta1BmgGlOZJjCZdxKE/BRmpYL5lrPVZHE=;
        b=pWHztwJetxx0qowvevLvkxkCmwM1DSAQ7wjfJnXzpjijYQSBqPMfI0rG6nxi/Vrs1X
         CRVPAVdxEFSJIvF4wmbUwj7aCZVm5fVfcrhjUQbBf8n+p0SayMBlb1is6WVkqvLBgMjP
         AxVJ3sKIAz8Kn28I4Sanz2jyBLjhA5Sgmh51jOnVumpasjSH/FjDxpS14KsDzSHBeJ/z
         Yb37UvWIKHVN5xc1I6JjnIWO9Obyji3HzdX43E3p6Zl4/DUSGGEIR7W2aNpSc1VwX28m
         zHCfb00UkmpquMPwx5yKTUZ6c6Sedty+81FiCoVN909m08MOGYjyTskfX4dvSl+gNSYm
         xxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=OXbMCMaGP4Ta1BmgGlOZJjCZdxKE/BRmpYL5lrPVZHE=;
        b=vgZMM9j7+MbOV4WxH1rvCkchmiAUqzLGkCXE5VuHur8LtLht2OtcAGyVuVbSv+9Kkj
         iHfffOXOQ9xL+/ISFiKs1DcC3mlc3u0GxwGkYGAXGxlblO5m8oMzOLnVfgil6C8xznVq
         bvhQMtZDRkMg+5JumKAy5d3zFa2nnpizr4cvwF2W3WUvak2BbE2XuQTF1MIb+lhNIc+C
         wa+l4h1mb+wYlZRKN4HKTIWaqfWcPmlWC5Nil47XZlOhbz+AuVuIk3wUuP6VqV/J+ndx
         msjItkfKZNRRCYnM4NjlCvfVycKo7DHgQyqPK9RQi2QUwvQqXw2w1qqeS1/dEEiOu2/V
         X//g==
X-Gm-Message-State: ACgBeo26YnXmARWZck8wAJRBoEPntRxssgPntoAHEQRdJPGUVey0+HYF
        AX7HEtimXsn7OoulZNQ0vadWQIoR1qM=
X-Google-Smtp-Source: AA6agR61BxBFn9qdHU9nkuJxxLaKayaG/YdyWtcsF9HYohujUkmqtvR1t3mL9v3jybeuPbaW7lxRg4vyZUk=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:a25:340d:0:b0:696:4dbf:614a with SMTP id
 b13-20020a25340d000000b006964dbf614amr21859755yba.470.1662053781470; Thu, 01
 Sep 2022 10:36:21 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:35:11 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-24-surenb@google.com>
Subject: [RFC PATCH RESEND 23/28] x86/mm: define ARCH_SUPPORTS_PER_VMA_LOCK
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        surenb@google.com, kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
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
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f9920f1341c8..ee19de020b27 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -27,6 +27,7 @@ config X86_64
 	# Options that are inherently 64-bit kernel only:
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
+	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select HAVE_ARCH_SOFT_DIRTY
 	select MODULES_USE_ELF_RELA
-- 
2.37.2.789.g6183377224-goog

