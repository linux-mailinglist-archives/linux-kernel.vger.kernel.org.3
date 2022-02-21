Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78A94BD4F8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 06:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbiBUFJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 00:09:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbiBUFJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 00:09:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572412AC49
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 21:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=w/dMgRsqmEmeMpqJ8degHyxOLajnMi0PhnljJxOT0EY=; b=HJT74s69pYOdFbeTnFSWq7PEmU
        9vMWqymryHhOeZShKMqgT8CdPVMrn/hkGEKh/NhefCBVlXKfz+IzgM8qq0pTdDCrmDOIe+zab5ZvA
        ZRAhv1N8GqOL/m/FS7ncOQxdRGVBs908QQP/JNxbhxtBkqw/OxSYOip/bqj2L2ZzG+QawEJQo2Hr/
        GVG1KsIsj/Ai/pIvdyjb+N80BdhrzhsnP/gZyXX0vDwA+KnCMIx2WtrHFmV6kUvqVYvbGtYlSwuNV
        OSLbgzToc/BkLhxNqONygpRuyiwV9mGftqi2NrH+8IcBmWGUq+pBChmZkK6RPlWGBoZMTMKV64P1L
        BwI9H9vg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nM0wS-003U7D-7K; Mon, 21 Feb 2022 05:08:56 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFC PATCH 1/2] init.h: improve __setup and early_param documentation
Date:   Sun, 20 Feb 2022 21:08:52 -0800
Message-Id: <20220221050852.1147-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Igor noted in [1] that there are quite a few __setup() handling
functions that return incorrect values. Doing this can be harmless,
but it can also cause strings to be added to init's argument or
environment list, polluting them.

Since __setup() handling and return values are not documented,
first add documentation for that. Also add more documentation for
early_param() handling and return values.

For __setup() functions, returning 0 (not handled) has questionable
value if it is just a malformed option value, as in
  rodata=junk
since returning 0 would just cause "rodata=junk" to be added to init's
environment unnecessarily:
  Run /sbin/init as init process
    with arguments:
      /sbin/init
    with environment:
      HOME=/
      TERM=linux
      splash=native
      rodata=junk

Also, there are no recommendations on whether to print a warning when
an unknown parameter value is seen. I am not addressing that here.

[1] lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/init.h |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- linux-next-20220217.orig/include/linux/init.h
+++ linux-next-20220217/include/linux/init.h
@@ -320,12 +320,19 @@ struct obs_kernel_param {
 		__aligned(__alignof__(struct obs_kernel_param))		\
 		= { __setup_str_##unique_id, fn, early }
 
+/*
+ * NOTE: __setup functions return values:
+ * @fn returns 1 (or non-zero) if the option argument is "handled"
+ * and returns 0 if the option argument is "not handled".
+ */
 #define __setup(str, fn)						\
 	__setup_param(str, fn, fn, 0)
 
 /*
- * NOTE: fn is as per module_param, not __setup!
- * Emits warning if fn returns non-zero.
+ * NOTE: @fn is as per module_param, not __setup!
+ * I.e., @fn returns 0 for no error or non-zero for error
+ * (possibly @fn returns a -errno value, but it does not matter).
+ * Emits warning if @fn returns non-zero.
  */
 #define early_param(str, fn)						\
 	__setup_param(str, fn, fn, 1)
