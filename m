Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C79A53C037
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239342AbiFBVEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbiFBVEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:04:41 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3463A35260
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 14:04:39 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 2A3A12E19A6;
        Thu,  2 Jun 2022 23:04:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1654203874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=i3NKfn+ix8IPierL01zwu9WC+ziebwcUWLk5MPtmKag=;
        b=g+5VeeU2K6xjaA1vUybtfN6kd0EZL0Ac6NHq6pYLD8aNT/E0BjlhBfr6R66I18DDTFoTBR
        DGDtEXcNbVP/Tc042uwce/yQKffrwPu7V5gB7qqBZp90v4l5QpiAZHxMPoiWJLbgLbd/9y
        9CIT85CckGQGtv6UXW7dJlhRbpQkglsAFsQ6GnUQPRpDxBoDiOZmVRBzmlGimz9lWq41tR
        8TGIBuFnF4LGrt9ibf0bfIqf3Nl0eXEI7UkScMt7YLaZi1O+H/xSHxqh4vJTnGM/VoL4Jd
        UEk05GZPTb5uY0AhlvdAUsMhBgXpQk+WWyZx5xEMIIbb/LYREl4x5B16Esj/1g==
From:   Sander Vanheule <sander@svanheule.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v1 0/2] cpumask: Fix invalid uniprocessor assumptions
Date:   Thu,  2 Jun 2022 23:04:18 +0200
Message-Id: <cover.1654201862.git.sander@svanheule.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On uniprocessor builds, it is currently assumed that any cpumask will
contain the single CPU: cpu0. This assumption is used to provide
optimised implementations.

The current assumption also appears to be wrong, by ignoring the fact
that users can provide empty cpumask-s. This can result in bugs as
explained in [1].

This series seeks to fix this assumption, allowing for masks that
contain at most cpu0, i.e. are "1" or "0".

[1] https://lore.kernel.org/all/20220530082552.46113-1-sander@svanheule.net/

Best,
Sander

---
To test these changes, I used the following code:

static void cpumask_test(const struct cpumask *mask)
{
        int cpu;

        if (cpumask_empty(mask))
                pr_info("testing empty mask\n");
        else
                pr_info("testing non-empty mask\n");

        pr_info("first cpu: %d\n", cpumask_first(mask));
        pr_info("first zero: %d\n", cpumask_first_zero(mask));
        pr_info("first and: %d\n", cpumask_first_and(mask, cpu_possible_mask));
        pr_info("last cpu: %d\n", cpumask_last(mask));
        pr_info("next cpu at -1: %d\n", cpumask_next(-1, mask));
        pr_info("next cpu at 0: %d\n", cpumask_next(0, mask));
        pr_info("next zero at -1: %d\n", cpumask_next_zero(-1, mask));
        pr_info("next zero at 0: %d\n", cpumask_next_zero(0, mask));
        pr_info("next and at -1: %d\n", cpumask_next_and(-1, mask, cpu_possible_mask));
        pr_info("next and at 0: %d\n", cpumask_next_and(0, mask, cpu_possible_mask));
        pr_info("next wrap at -1,false: %d\n", cpumask_next_wrap(-1, mask, 0, false));
        pr_info("next wrap at 0,false: %d\n", cpumask_next_wrap(-1, mask, 0, false));
        pr_info("next wrap at -1,true: %d\n", cpumask_next_wrap(-1, mask, 0, true));
        pr_info("next wrap at 0,true: %d\n", cpumask_next_wrap(-1, mask, 0, true));

        for_each_cpu(cpu, mask)
                pr_info("for each: %d\n", cpu);

        for_each_cpu_not(cpu, mask)
                pr_info("for each not: %d\n", cpu);

        for_each_cpu_wrap(cpu, mask, 0)
                pr_info("for each wrap: %d\n", cpu);

        for_each_cpu_and(cpu, mask, cpu_possible_mask)
                pr_info("for each and: %d\n", cpu);
}

static void run_tests()
{
        cpumask_clear(&empty_mask);
        cpumask_test(&empty_mask);
        cpumask_test(cpu_possible_mask);
}

On an unpatched build, with NR_CPUS=1:
    [...] testing empty mask
    [...] first cpu: 0
    [...] first zero: 0
    [...] first and: 0
    [...] last cpu: 0
    [...] next cpu at -1: 0
    [...] next cpu at 0: 1
    [...] next zero at -1: 0
    [...] next zero at 0: 1
    [...] next and at -1: 0
    [...] next and at 0: 1
    [...] next wrap at -1,false: 0
    [...] next wrap at 0,false: 0
    [...] next wrap at -1,true: 0
    [...] next wrap at 0,true: 0
    [...] for each: 0
    [...] for each not: 0
    [...] for each wrap: 0
    [...] for each and: 0
    [...] testing non-empty mask
    [...] first cpu: 0
    [...] first zero: 0
    [...] first and: 0
    [...] last cpu: 0
    [...] next cpu at -1: 0
    [...] next cpu at 0: 1
    [...] next zero at -1: 0
    [...] next zero at 0: 1
    [...] next and at -1: 0
    [...] next and at 0: 1
    [...] next wrap at -1,false: 0
    [...] next wrap at 0,false: 0
    [...] next wrap at -1,true: 0
    [...] next wrap at 0,true: 0
    [...] for each: 0
    [...] for each not: 0
    [...] for each wrap: 0
    [...] for each and: 0

On a patched build, with NR_CPUS=1:
    [...] testing empty mask
    [...] first cpu: 1
    [...] first zero: 0
    [...] first and: 1
    [...] last cpu: 1
    [...] next cpu at -1: 1
    [...] next cpu at 0: 1
    [...] next zero at -1: 0
    [...] next zero at 0: 1
    [...] next and at -1: 1
    [...] next and at 0: 1
    [...] next wrap at -1,false: 1
    [...] next wrap at 0,false: 1
    [...] next wrap at -1,true: 1
    [...] next wrap at 0,true: 1
    [...] for each not: 0
    [...] testing non-empty mask
    [...] first cpu: 0
    [...] first zero: 1
    [...] first and: 0
    [...] last cpu: 0
    [...] next cpu at -1: 0
    [...] next cpu at 0: 1
    [...] next zero at -1: 1
    [...] next zero at 0: 1
    [...] next and at -1: 0
    [...] next and at 0: 1
    [...] next wrap at -1,false: 0
    [...] next wrap at 0,false: 0
    [...] next wrap at -1,true: 0
    [...] next wrap at 0,true: 0
    [...] for each: 0
    [...] for each wrap: 0

For reference, the generic implementation with NR_CPUS=2, CONFIG_SMP=y
    [...] testing empty mask
    [...] first cpu: 2
    [...] first zero: 0
    [...] first and: 2
    [...] last cpu: 2
    [...] next cpu at -1: 2
    [...] next cpu at 0: 2
    [...] next zero at -1: 0
    [...] next zero at 0: 1
    [...] next and at -1: 2
    [...] next and at 0: 2
    [...] next wrap at -1,false: 2
    [...] next wrap at 0,false: 2
    [...] next wrap at -1,true: 2
    [...] next wrap at 0,true: 2
    [...] for each not: 0
    [...] testing non-empty mask
    [...] first cpu: 0
    [...] first zero: 1
    [...] first and: 0
    [...] last cpu: 0
    [...] next cpu at -1: 0
    [...] next cpu at 0: 2
    [...] next zero at -1: 1
    [...] next zero at 0: 1
    [...] next and at -1: 0
    [...] next and at 0: 2
    [...] next wrap at -1,false: 0
    [...] next wrap at 0,false: 0
    [...] next wrap at -1,true: 2
    [...] next wrap at 0,true: 2
    [...] for each: 0
    [...] for each wrap: 0
    [...] for each and: 0

Sander Vanheule (2):
  cpumask: Fix invalid uniprocessor mask assumption
  cpumask: Add UP optimised for_each_*_cpu loops

 include/linux/cpumask.h | 42 +++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

-- 
2.36.1

