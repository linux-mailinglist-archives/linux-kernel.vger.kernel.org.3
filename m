Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AD758DD48
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245618AbiHIRgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245152AbiHIRgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:36:46 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E62252B0
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 10:36:43 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 915AC308CE1;
        Tue,  9 Aug 2022 19:36:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1660066601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CdNsFW8BmdC6Xp+NKHPLPlR/rbAil8TvL/l8WLev1Qw=;
        b=DhqZXpR5jsXxk6UUDCFNVVCXig9nbC2Iv2WJpgsfuhEF23sXrQdtdzFiHLHrpyyS2KK+6e
        dpiPn/0E1qd7jw5Q+5qhH/56CuDGB41c766qRf9FSjrArRQGDqDTlkgxy7Z9Smj4D+Tk+f
        +6vVzsrkxKVLxFAeH/JIK0sIGqLccXid39slzhcgF7KxfjdSC0779iGW/quothxnzSfkWF
        BOzR9PbDMsLCFyaKAjHnAILxRAo/GpcUsVaanDmyxd6iashykT5WP7rSUGXpeXj5Afm5Lh
        U/JZ3uTHRspJ1EqtvlexQe0iJbPXqVsXDXi+aS2dcyD2rNX2Puih31zM2lAnnQ==
From:   Sander Vanheule <sander@svanheule.net>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v1 3/3] lib/cpumask: drop always-true preprocessor guard
Date:   Tue,  9 Aug 2022 19:36:35 +0200
Message-Id: <37f6ddf22de46a81b07861682347fa2f25bb0c69.1660066581.git.sander@svanheule.net>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660066581.git.sander@svanheule.net>
References: <cover.1660066581.git.sander@svanheule.net>
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

Since lib/cpumask.o is only built for CONFIG_SMP=y, NR_CPUS will always
be greater than 1 at compile time.  This makes checking for that
condition unnecesarry, so it can be dropped.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 lib/cpumask.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/cpumask.c b/lib/cpumask.c
index 8baeb37e23d3..f0ae119be8c4 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -109,7 +109,6 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
 }
 #endif
 
-#if NR_CPUS > 1
 /**
  * cpumask_local_spread - select the i'th cpu with local numa cpu's first
  * @i: index number
@@ -197,4 +196,3 @@ unsigned int cpumask_any_distribute(const struct cpumask *srcp)
 	return next;
 }
 EXPORT_SYMBOL(cpumask_any_distribute);
-#endif /* NR_CPUS */
-- 
2.37.1

