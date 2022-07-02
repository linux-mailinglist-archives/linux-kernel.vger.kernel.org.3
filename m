Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC901564148
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 18:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiGBQIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 12:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiGBQIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 12:08:43 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4058BE0C6
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 09:08:42 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 2B6492F29DE;
        Sat,  2 Jul 2022 18:08:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1656778116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9/sd1UNeYBxDZ/PxaUTdlpYf5mSD1eCp0bTuKG3MEE4=;
        b=7xNwjdXJBs8aSZWdsKNKz6mIkDpg9yXrCQURvoiDC0XvxZMnQMnzSjmJZRlBHWpPCyez7q
        L+j4tphaOO5xsdyGGfUnsnPvzRviiCe+WuxJV5S3+4piJH4RXDNsBsukAJyishTs7VVhsO
        2CG4DK/nCDhmPLEVEcOtTTWjkdALaVKjeVAG9uhIUR/rs6+UkAF/oUZws5H2ZM65G+WkYZ
        H60PmnD39Jx7lKfiOyZmTpCk7foS/W3cos6viYk2cDVvFOyBuToPuiaT2z/8UTZbL7C6+c
        YQ94DXIVjlNu6vM/YmF7aMMTp+XrEKj5/fdfFBl9Lm4F12jTvGE5cXQ1Ltr5PQ==
From:   Sander Vanheule <sander@svanheule.net>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        elver@google.com, gregkh@linuxfoundation.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, vschneid@redhat.com,
        Yury Norov <yury.norov@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v4 5/5] cpumask: Update cpumask_next_wrap() signature
Date:   Sat,  2 Jul 2022 18:08:28 +0200
Message-Id: <72ab755695b74bb5fbaa756ae4c0edd708d172f1.1656777646.git.sander@svanheule.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656777646.git.sander@svanheule.net>
References: <cover.1656777646.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The extern specifier is not needed for this declaration, so drop it. The
function also depends only on the input parameters, and has no side
effects, so it can be marked __pure like other functions in cpumask.h.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Notes:
    Changes since v3:
    - Add Andy's Reviewed-by
    
    Changes since v1:
    - Split off patch from other changes

 include/linux/cpumask.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 6c5b4ee000f2..523857884ae4 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -229,7 +229,7 @@ int cpumask_any_distribute(const struct cpumask *srcp);
 		(cpu) = cpumask_next_zero((cpu), (mask)),	\
 		(cpu) < nr_cpu_ids;)
 
-extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap);
+int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap);
 
 /**
  * for_each_cpu_wrap - iterate over every cpu in a mask, starting at a specified location
-- 
2.36.1

