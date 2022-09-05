Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105CD5ADBB5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 01:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbiIEXI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 19:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiIEXIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 19:08:38 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DBA647C6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 16:08:27 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id s22so7095813qkj.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 16:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WEHKHp4kn4V6UYQyjoIY/dqbYCfhgoChOkAi2IzYwg8=;
        b=X4PKt6fFt/RIqUVAvPGMJDPAeR2/o/H695HAeDwsdTrhicxzgeZYQcPlcFO5PDUeEe
         DTmQ2hu8/MIomiJIt3FXja+/yeIoB98wi8wtgUwhJ0pg16zFXZ9cjudcQYJpmTT/5BnG
         NICGE1AnIjW7xyggdGWQ4GHW1pch1wTBJ+Zo5sI76gPKTDQbY2eJEqNG13DgSbOcM/aG
         B1LZ9TLd6ZPFvVTpBOJUxJAu3CN81C/rKPKg4Vb5DpLiLOfVDQFOVqbLK8sJPJ3F1/l0
         uR74mtEH2NxS3qDr0E4cP5YHABriyev21n0VlsTzhFxrzKBVlTFchwWVazt80nWWBVFH
         CJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WEHKHp4kn4V6UYQyjoIY/dqbYCfhgoChOkAi2IzYwg8=;
        b=faJjbcpXC5hnh8B7Pi+ttdn9x1eZLiWq3I0zwUzO8bNi/RKck9imixAIwaE2nx/BS4
         epfDzI7JwgYO3WFNFUVVLcFR4yy9cHKS5qFqkUxqSycvZtNhvICrhqYXuB6ZZNo68wMN
         ZgHhGVKUGVGcCJ3pMBLRHEsxkGyp/McMuSNT+zb114qj0E56ceTbxmoolU8SQUup2Y9q
         B+VQaRFcj8ie8KD4dvUFmxKwFNKzXPJsEC/9neFGC/f2t8+BxUfwN7LHEy62gi74SlzX
         NGCzCWTsOEZCpr6jK4alTLo+1UEbRFz7o8kI/bLcDb24hmEwRNzKpmGNLBPc6fIuWF/5
         UTzQ==
X-Gm-Message-State: ACgBeo1p0UWio51Z3Ed/dIywjOp0zg02yS+lY34AwQfI+cH4qTDqyNcz
        Y4sEEUbkNwtSmCpWAMgJAnIvLXx1Cg8=
X-Google-Smtp-Source: AA6agR58DCLIIGF0c9auUdxzbOvavzjfTdGwnTCZNfXNbqDh9liVIgHjykLWpSCIAoCu4nzGLcz3Mg==
X-Received: by 2002:a05:620a:2989:b0:6bc:5cdc:88e9 with SMTP id r9-20020a05620a298900b006bc5cdc88e9mr34410118qkp.141.1662419305859;
        Mon, 05 Sep 2022 16:08:25 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:dde1:6b3e:62e9:1461])
        by smtp.gmail.com with ESMTPSA id g16-20020a05620a40d000b006b93b61bc74sm9789783qko.9.2022.09.05.16.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 16:08:25 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH v2 3/5] lib/cpumask: delete misleading comment
Date:   Mon,  5 Sep 2022 16:08:18 -0700
Message-Id: <20220905230820.3295223-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220905230820.3295223-1-yury.norov@gmail.com>
References: <20220905230820.3295223-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment says that HOTPLUG config option enables all cpus in
cpu_possible_mask up to NR_CPUs. This is wrong. Even if HOTPLUG is
enabled, the mask is populated on boot with respect to ACPI/DT records.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 0588bfe350d4..8bac1dee8448 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -72,10 +72,6 @@ static inline void set_nr_cpu_ids(unsigned int nr)
  *  cpu_online_mask is the dynamic subset of cpu_present_mask,
  *  indicating those CPUs available for scheduling.
  *
- *  If HOTPLUG is enabled, then cpu_possible_mask is forced to have
- *  all NR_CPUS bits set, otherwise it is just the set of CPUs that
- *  ACPI reports present at boot.
- *
  *  If HOTPLUG is enabled, then cpu_present_mask varies dynamically,
  *  depending on what ACPI reports as currently plugged in, otherwise
  *  cpu_present_mask is just a copy of cpu_possible_mask.
-- 
2.34.1

