Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D113A4EC98A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348762AbiC3QUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348731AbiC3QUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:20:07 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBE214080
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:18:20 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id b188so22498643oia.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
        bh=H6QR/4ouQfk9FE1Mq7xuyrN7l9UoiQk8uluEByQoOHQ=;
        b=RqSI4fNKvXFL8zCI/BX/buhXp0l1JG3sm7WVBKM06CM7JGW8tKlTuiq8UdQdw/kWYW
         8nVzRxRhtP3oyzlF3WWaIuFv+V5JgVcJuJYtiLbngnx36eVda71vd922hF7Y8khrxJXw
         uFmEKBVhQ0uah/iMbAspAjhqPuODbN95rTGTsrjIAy+ePk6qyn75iIrpHyWuS262cN4d
         pATkt+9R+wh8w3WsqPy7xetENLEw8rx8a8xWmCNkvWVgzhyvUKIQ/k4fyW9ON+1IOchC
         LNEzVHX1lfDI69xQURCzSYtN6U+gWHGfQFhZopVud8E9mah1HsCmNUNHwJoq1g5VjJa7
         ltEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=H6QR/4ouQfk9FE1Mq7xuyrN7l9UoiQk8uluEByQoOHQ=;
        b=sJh3US4DEjN/C5nV0EZQHqOMXBDrVnBXDPrXtotC1zGwrX2+7MPzIlHNbbEJqE4o+x
         O1b2hPaowq6oINs+JfJ7xZFcnNI6RvjAibkyqPguPbLMJhkw08F/7S/aQ4spWrPCEiJI
         HGpjKrU5qynI4k7cP/1acW0y4VzkdKinQLC6+1c5Oq6jMQIxc4au/k3hY5em8zs+gRab
         BQnnSZCT8cyUIxKDpdh1Yzlh5kjR5BZfAXeZtRXkaIcg7mE5OCyAeBf3tfc4hi6jKZvt
         qRwklaCHFXfUP8RULIUP08Agvkkjv+Ug6ZL7r+iuyIQBCP82Nybhq9cz38ZajkT/PfeA
         r3Fg==
X-Gm-Message-State: AOAM531hEEe1oP1q30GN62EwAzTsWGSAa6y7Q+5LUDMnCMr5StT4B/rI
        XA5pyAZHccL6NLxoznKK65O6tWEv4xU=
X-Google-Smtp-Source: ABdhPJz/EAuu/vkBaTG8M9nRR+k3ADwRyyVgmSy+UlP9DngPkChvvY9UOd4EUMgQ+6bFCQZb4kCdqQ==
X-Received: by 2002:a05:6808:2083:b0:2f7:5d2e:15f8 with SMTP id s3-20020a056808208300b002f75d2e15f8mr243573oiw.66.1648657099497;
        Wed, 30 Mar 2022 09:18:19 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([187.19.239.165])
        by smtp.gmail.com with ESMTPSA id c8-20020a4ad788000000b0031ce69b1640sm10013417oou.10.2022.03.30.09.18.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 09:18:18 -0700 (PDT)
From:   arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0349640407; Wed, 30 Mar 2022 13:18:15 -0300 (-03)
Date:   Wed, 30 Mar 2022 13:18:15 -0300
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH FYI] tools headers cpufeatures: Sync with the kernel sources
Message-ID: <YkSCx2kr4ambH+Qe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

---

To pick the changes from:

  991625f3dd2cbc4b ("x86/ibt: Add IBT feature, MSR and #CP handling")

This only causes these perf files to be rebuilt:

  CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
  CC       /tmp/build/perf/bench/mem-memset-x86-64-asm.o

And addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h

Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 3edf05e98e58625c..73e643ae94b6f220 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -388,6 +388,7 @@
 #define X86_FEATURE_TSXLDTRK		(18*32+16) /* TSX Suspend Load Address Tracking */
 #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
+#define X86_FEATURE_IBT			(18*32+20) /* Indirect Branch Tracking */
 #define X86_FEATURE_AMX_BF16		(18*32+22) /* AMX bf16 Support */
 #define X86_FEATURE_AVX512_FP16		(18*32+23) /* AVX512 FP16 */
 #define X86_FEATURE_AMX_TILE		(18*32+24) /* AMX tile Support */
-- 
2.35.1

