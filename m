Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D6E5A5266
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiH2Q6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiH2Q5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:57:54 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08F39A9A8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:57:53 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id d1so6785091qvs.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=2yr+D2Z29fm9kNcmJTj1HTUfj6bYsT7aNdzDoDu4Xao=;
        b=aSJhhvppoLOB6ONuv9L4JT71wLnlDbFq4KocMuPpcLUo4xQKpg13BQKZXekAECmTCE
         rS4MdiDt+MzI2Rnt7WhpFZ2IJFw/FEurV0dhPBUR9UTHGXwYoFvliQg0eypzjaeLK53g
         D4s6kzlK8rduE56YR2+jhOPKJlVrGX/WKfb3mj9qCqn1zDm9nsEESfmb319Q+fUdRBsO
         PcAV2NUxBnigcKfJV3vCw5YLFgLuwujZHl47BONWFlDmYrAd1JqwnmSOY1ZovfWJ/jvc
         qQedichT1M940tLrhnVKf9bm+4TIeR9NqQ6xl5g+E18eoxUJThGdqarbvdwl6P+q5+0q
         3LGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2yr+D2Z29fm9kNcmJTj1HTUfj6bYsT7aNdzDoDu4Xao=;
        b=V7IG3TTsTe3hrmUoBs62fAnv/ja7gNOL+kvfroHbbSipAd9/UuHcyTnCKSTtrA0eQt
         KncYMtc0bJUR5968RNzn01+y8yt4m+O86EdK3ZDTx2HUouQQrmq1dTJZYyl/dJjNT1yn
         qkHJ6kqP9k2NYXmSw4u8fXzXSiyhbBY0Y++YMGHkYo3QYN4+qLPGAMmw2r6J7Qu6zbBa
         Zy3r8IaPDGEUUCaqNad5lZ3a9Qn5AMkzD+UzbFu39sC+LjOT5HC8FAkYZTX9l/UeY5OU
         LGg3tN5ZlczhQKXxuUFQOxg/t7n7dvNsrrEuDiPkStVL5CWpdpcebfNtGS4jYiLKDWO8
         bV6w==
X-Gm-Message-State: ACgBeo0sqdcv3WURYdAYN/L8I8tyEoV3x3isUXcfQB/HbzRyDucdmjb+
        P801GhcJx7w5psmoNULSUa3THOXayao=
X-Google-Smtp-Source: AA6agR70/L2QQF1ATcyW9dJWSu3GjTEPOXrFklOHn8IearbWOsTPA6LLLD5k3ft+hnipvZIO3McLVw==
X-Received: by 2002:a05:6214:2409:b0:499:606:153f with SMTP id fv9-20020a056214240900b004990606153fmr3076912qvb.20.1661792272804;
        Mon, 29 Aug 2022 09:57:52 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:5d44:81a:c7bc:27d1])
        by smtp.gmail.com with ESMTPSA id he7-20020a05622a600700b00344f7cf05b4sm5488592qtb.14.2022.08.29.09.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 09:57:52 -0700 (PDT)
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
Subject: [PATCH 2/4] lib/cpumask: delete misleading comment
Date:   Mon, 29 Aug 2022 09:57:46 -0700
Message-Id: <20220829165748.1008477-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220829165748.1008477-1-yury.norov@gmail.com>
References: <20220829165748.1008477-1-yury.norov@gmail.com>
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
index bd047864c7ac..f70bf9ffa9d3 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -67,10 +67,6 @@ extern unsigned int nr_cpu_ids;
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

