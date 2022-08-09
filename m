Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B8758DD47
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245388AbiHIRgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245601AbiHIRgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:36:47 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4852C252A2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 10:36:43 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id A715F308CDF;
        Tue,  9 Aug 2022 19:36:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1660066600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JOxZ/n1mG+AA2dVZMQCKulbPFD0Jg/I+TAQ2E5jb4Pk=;
        b=ZCpT2pjXzU52EP2M06gzt9GRdNG8xGPDfzP1s3RXT/RwX4MaoXLvRH01gOnYHbQRrFTvcZ
        XjyMD45MJ9RbHXAeSPJu3GT0nQaCX/9EFqQ00rGjXbpECLb/tH3VrVVReISxCduqXjC4D/
        SbRsY0+HlmR3k3nA+hyb6pNpLYMN8STrsX15n3xOiq7YkqpNg9EZSA0+CcT6uMPOIfdL2Z
        GuetI33PKA4EGKk/9HzLnud2RW41nXn33qx1SXoV2qY0aWjtlN11XWzqU9/kJj212bcVIQ
        OWGzpVK+9050ZIjtoCoegH5xMEfilZmbLPXauHJJYpLlKAreND2NDi17oprVCg==
From:   Sander Vanheule <sander@svanheule.net>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v1 1/3] cpumask: align signatures of UP implementations
Date:   Tue,  9 Aug 2022 19:36:33 +0200
Message-Id: <f7f60127f29aa718fe670dba6761bf9d1243f772.1660066581.git.sander@svanheule.net>
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

Between the generic version, and their uniprocessor optimised
implementations, the return types of cpumask_any_and_distribute() and
cpumask_any_distribute() are not identical.  Change the UP versions to
'unsigned int', to match the generic versions.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 include/linux/cpumask.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 0d435d0edbcb..d8c2a40f8beb 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -202,12 +202,13 @@ static inline unsigned int cpumask_local_spread(unsigned int i, int node)
 	return 0;
 }
 
-static inline int cpumask_any_and_distribute(const struct cpumask *src1p,
-					     const struct cpumask *src2p) {
+static inline unsigned int cpumask_any_and_distribute(const struct cpumask *src1p,
+						      const struct cpumask *src2p)
+{
 	return cpumask_first_and(src1p, src2p);
 }
 
-static inline int cpumask_any_distribute(const struct cpumask *srcp)
+static inline unsigned int cpumask_any_distribute(const struct cpumask *srcp)
 {
 	return cpumask_first(srcp);
 }
-- 
2.37.1

