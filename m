Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF06F52508E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355192AbiELOt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbiELOtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:49:24 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D8AA246DA0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:49:22 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 413131E80D70;
        Thu, 12 May 2022 22:43:46 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kj5QDLbieTlH; Thu, 12 May 2022 22:43:43 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 3C0451E80D6B;
        Thu, 12 May 2022 22:43:43 +0800 (CST)
From:   liqiong <liqiong@nfschina.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        liqiong <liqiong@nfschina.com>
Subject: [PATCH] mm: change "char *bdi_unknown_name" to "char bdi_unknown_name[]"
Date:   Thu, 12 May 2022 22:48:29 +0800
Message-Id: <20220512144829.5148-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220512082637.24649-1-liqiong@nfschina.com>
References: <20220512082637.24649-1-liqiong@nfschina.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"char bdi_unknown_nam[]" string form declares a single variable.
It is better than "char *bdi_unknown_name" which creates two
variables.

Signed-off-by: liqiong <liqiong@nfschina.com>
---
 mm/backing-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 7176af65b103..4982ccc63536 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -20,7 +20,7 @@ struct backing_dev_info noop_backing_dev_info;
 EXPORT_SYMBOL_GPL(noop_backing_dev_info);
 
 static struct class *bdi_class;
-static const char *bdi_unknown_name = "(unknown)";
+static const char bdi_unknown_name[] = "(unknown)";
 
 /*
  * bdi_lock protects bdi_tree and updates to bdi_list. bdi_list has RCU
-- 
2.11.0

