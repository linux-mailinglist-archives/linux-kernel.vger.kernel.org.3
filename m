Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8478B5A188F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241817AbiHYSM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243185AbiHYSMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:12:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8EFBD174
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661451163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hRCkxRGTLmsrQqX09/lEo5/j9SdQgOT7KVWNp7Ie7zk=;
        b=FqkZw5dynESsGX9VquNDo7jVCYhnIZa9u6hWDQZwXzs563PykXPSrvCzjiXYwWJ1aileGk
        uG+SbCw+gC9NYxq/DKBkvklf7JuoOAUdQ40zHZKRHfeYia3Gmi7PApPWlUgxQMUQwn/axQ
        oTIZ70OSo7+XVaAV0uHMh5csF2ISswk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-398-tqaBro7yPAGTL-N-rk1WKg-1; Thu, 25 Aug 2022 14:12:41 -0400
X-MC-Unique: tqaBro7yPAGTL-N-rk1WKg-1
Received: by mail-wm1-f72.google.com with SMTP id b16-20020a05600c4e1000b003a5a47762c3so11214611wmq.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=hRCkxRGTLmsrQqX09/lEo5/j9SdQgOT7KVWNp7Ie7zk=;
        b=zr4z3xvDSMK3pDmrLL3hqcN2p84PSa2xj3WuaSxWfGqswvNOk8ELkd1OfEBg4bMPmM
         MjID43tIIcVCB9m9jWpx57vQcDyEECYUsf6zyCjZrY7PBcz47IzOpTZx4tlZ9T1w1PBy
         dkmpr7nomWrXpJVhwT/gZqoQGOusZgt+qltuIFn4QcMuRZ5tYaB55gln0ufTr9vaRiQ5
         Ae+vpWioWj2CNps6sOVbh6G0EVtfCRt68D+6jNcdMup7JSzMLKrVgYmuNa77krkUtfDP
         8SQLaFsq5p+NnSTb4FYe7xQHvdnRARLuCXU8x/HqhGfiV2I5IMPiRT6RtuWpY04/ExYU
         rT7Q==
X-Gm-Message-State: ACgBeo1k+qE5Aa/rRuCC5itM4qtWdTazF5XyrVubC3AGZYyx0Q134Ubd
        o9VQ7zPHwin/8qymWc5dVgIQ6PJqk1oNzUPQvUhgHTiZbUsprZWetFpdAOE0rwmSvakhAoyvnTi
        6f4CmmESE3y39HjyG8uv62LcE
X-Received: by 2002:a5d:45c4:0:b0:225:4320:1401 with SMTP id b4-20020a5d45c4000000b0022543201401mr2994483wrs.474.1661451160646;
        Thu, 25 Aug 2022 11:12:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4fjN7hsvjTudH2itqlMcc3FAuj0f548hYAGxBnKB1bc1Mv3He53yWfXNTJ/JWMyImi2TUnJQ==
X-Received: by 2002:a5d:45c4:0:b0:225:4320:1401 with SMTP id b4-20020a5d45c4000000b0022543201401mr2994455wrs.474.1661451160399;
        Thu, 25 Aug 2022 11:12:40 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id w1-20020a05600018c100b00225250f2d1bsm20371622wrq.94.2022.08.25.11.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:12:39 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gal Pressman <gal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH v3 1/9] cpumask: Make cpumask_full() check for nr_cpu_ids bits
Date:   Thu, 25 Aug 2022 19:12:02 +0100
Message-Id: <20220825181210.284283-2-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220825181210.284283-1-vschneid@redhat.com>
References: <20220825181210.284283-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider a system with 4 CPUs and:
  CONFIG_NR_CPUS=64
  CONFIG_CPUMASK_OFFSTACK=n

In this situation, we have:
  nr_cpumask_bits == NR_CPUS == 64
  nr_cpu_ids = 4

Per smp.c::setup_nr_cpu_ids(), nr_cpu_ids <= NR_CPUS, so we want
cpumask_full() to check for nr_cpu_ids bits set.

This issue is currently pointed out by the cpumask KUnit tests:

  [   14.072028]     # test_cpumask_weight: EXPECTATION FAILED at lib/test_cpumask.c:57
  [   14.072028]     Expected cpumask_full(((const struct cpumask *)&__cpu_possible_mask)) to be true, but is false
  [   14.079333]     not ok 1 - test_cpumask_weight

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/cpumask.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index bd047864c7ac..1414ce8cd003 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -574,7 +574,7 @@ static inline bool cpumask_empty(const struct cpumask *srcp)
  */
 static inline bool cpumask_full(const struct cpumask *srcp)
 {
-	return bitmap_full(cpumask_bits(srcp), nr_cpumask_bits);
+	return bitmap_full(cpumask_bits(srcp), nr_cpu_ids);
 }
 
 /**
-- 
2.31.1

