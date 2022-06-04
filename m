Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB1053D804
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 19:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239242AbiFDRQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 13:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239119AbiFDRQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 13:16:18 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFB2286D6
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 10:16:15 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 8F80E2E2939;
        Sat,  4 Jun 2022 19:16:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1654362971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=43KXIoq1D6bklJo+f5FH1Gs3lknZQq9mQVsSDG8wsAw=;
        b=sFX2aPP2xERNo6JHr1+Q0XRUXA8EPdR31koEmHzTMj1I15c6TMH/DlcjH6+gbwrk3axLth
        n7MNOjTpHUVg+320V9mk8A9zc3nPxvx4d8NemPyu1gtC3Qfext1uShxyPFe2MLIphRiwIE
        UpJHYla+HxRexNDRy7HLs0zaeZJJbH/Oc8nInnM2z8YvIutc0tXcOtABsc6c2SDYzBAGxD
        8imeEYnOpJp12VVgOmmq0KzXEPQ6o5jLz3IvgoOPJe3s2FEpYpvZ0indQxNmm8MwI44onk
        88udotzaZSdDwVDLVHNMOWezmb5laak1zC0xsJEsR0WDSNxkhOhSPjNTaJw7EQ==
From:   Sander Vanheule <sander@svanheule.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v2 4/4] cpumask: Update cpumask_next_wrap() signature
Date:   Sat,  4 Jun 2022 19:15:59 +0200
Message-Id: <a24984f17364ae9f9965d351386ed19dd73b7ae8.1654362935.git.sander@svanheule.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654362935.git.sander@svanheule.net>
References: <cover.1654362935.git.sander@svanheule.net>
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

The extern specifier is not needed for this declaration, so drop it. The
function also depends only on the input parameters, and has no side
effects, so it can be marked __pure like other functions in cpumask.h

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 include/linux/cpumask.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 7ccddbc27ac3..f37ce00741a3 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -210,7 +210,7 @@ int cpumask_any_distribute(const struct cpumask *srcp);
 		(cpu) = cpumask_next_zero((cpu), (mask)),	\
 		(cpu) < nr_cpu_ids;)
 
-extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap);
+int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap);
 
 /**
  * for_each_cpu_wrap - iterate over every cpu in a mask, starting at a specified location
-- 
2.36.1

