Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4079525D2B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378169AbiEMIXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378091AbiEMIXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:23:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05B025B076;
        Fri, 13 May 2022 01:23:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ED1562010;
        Fri, 13 May 2022 08:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7369C34114;
        Fri, 13 May 2022 08:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652430226;
        bh=VdFOgS93MTxgXl8MYQIAwcaYqU9bLXsKmrW93/ntJg4=;
        h=From:To:Cc:Subject:Date:From;
        b=PfQaWywtP3MmwhELVywMZUOkmEL1ASj8IdxGcQw4A2AK8y9PTl2RpYUycHBziE6oZ
         cfkbD35954X0w5scVzxeuNVU1Rr/4C1Qe9uFsQfSmcvBEJIuRk8mPRpHaQIJMLTqFu
         5PCYI3bam5smrDfPvBAjEN0zYO3IyeYQPaR1Blco1qIoBjRZDME7+NyYPBK1ckpyGZ
         Z2tjR6wNNnsVyJTMzOI31w4Sz2l8+yhRHqOYOzBWL1g2qqDLP4G3pW9Gb3RRDKmObm
         PNW2e2G+67QipmYeuIZKfOh1qikOHSFLcwR09yvtIG0MaUtlL6lxODo20wuyNhDdeL
         nW68QlqAnl4Qg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1npQaO-003DpF-F4;
        Fri, 13 May 2022 10:23:44 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH] media: atomisp: don't pass a pointer to a local variable
Date:   Fri, 13 May 2022 10:23:43 +0200
Message-Id: <671749e03ec7b4d7adf044745c0c55acf1a02358.1652430219.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As warned by gcc 12.1:

	drivers/staging/media/atomisp/pci/runtime/rmgr/src/rmgr_vbuf.c: In function 'ia_css_rmgr_acq_vbuf':
	drivers/staging/media/atomisp/pci/runtime/rmgr/src/rmgr_vbuf.c:275:33: error: storing the address of local variable 'h' in '*handle' [-Werror=dangling-pointer=]
	  275 |                         *handle = &h;
	      |                         ~~~~~~~~^~~~
	drivers/staging/media/atomisp/pci/runtime/rmgr/src/rmgr_vbuf.c:257:40: note: 'h' declared here
	  257 |         struct ia_css_rmgr_vbuf_handle h;
	      |                                        ^
	drivers/staging/media/atomisp/pci/runtime/rmgr/src/rmgr_vbuf.c:257:40: note: 'handle' declared here
	cc1: all warnings being treated as errors

The logic uses a temporary struct to update the handler, but,
instead of copying the value to the pointer sent by the caller, it
replaces it with the content with a local variable. That's wrong, and
may lead the caller to use a weird value.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 .../staging/media/atomisp/pci/runtime/rmgr/src/rmgr_vbuf.c    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/runtime/rmgr/src/rmgr_vbuf.c b/drivers/staging/media/atomisp/pci/runtime/rmgr/src/rmgr_vbuf.c
index d96aaa4bc75d..39604752785b 100644
--- a/drivers/staging/media/atomisp/pci/runtime/rmgr/src/rmgr_vbuf.c
+++ b/drivers/staging/media/atomisp/pci/runtime/rmgr/src/rmgr_vbuf.c
@@ -254,7 +254,7 @@ void rmgr_pop_handle(struct ia_css_rmgr_vbuf_pool *pool,
 void ia_css_rmgr_acq_vbuf(struct ia_css_rmgr_vbuf_pool *pool,
 			  struct ia_css_rmgr_vbuf_handle **handle)
 {
-	struct ia_css_rmgr_vbuf_handle h;
+	struct ia_css_rmgr_vbuf_handle h = { 0 };
 
 	if ((!pool) || (!handle) || (!*handle)) {
 		IA_CSS_LOG("Invalid inputs");
@@ -272,7 +272,7 @@ void ia_css_rmgr_acq_vbuf(struct ia_css_rmgr_vbuf_pool *pool,
 			h.size = (*handle)->size;
 			/* release ref to current buffer */
 			ia_css_rmgr_refcount_release_vbuf(handle);
-			*handle = &h;
+			**handle = h;
 		}
 		/* get new buffer for needed size */
 		if ((*handle)->vptr == 0x0) {
-- 
2.36.1

