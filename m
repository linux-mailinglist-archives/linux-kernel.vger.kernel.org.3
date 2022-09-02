Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE305ABB19
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 01:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiIBXR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 19:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIBXR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 19:17:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE68F9969;
        Fri,  2 Sep 2022 16:17:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B6EDB82E01;
        Fri,  2 Sep 2022 23:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E001AC433C1;
        Fri,  2 Sep 2022 23:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662160642;
        bh=ERg2TOZN4AaUjdAMP7nDz5p+LX6W9sfrRqCNVo8lkv8=;
        h=Date:From:To:Subject:From;
        b=AWZ56CzXcVo7rc7Regu2miBQIRJICbRWfZlSkB0V5Y3huCqB7WuYWjbZIUBk3W9gE
         dq5J7UIDoaIFLBs2K3qOfDCEA8FOB4EyKRFRsJ+fiBczD1bayPuks0PB6YUXq3ikRT
         cp+dzQHWsU2l9CbMJBIqPXxp9Jy/wfjcSrbBkyHU4KAa6CYAVIPspabIo28Hc8X21i
         QSTw9fobr9ah21sC06v5mR9Awti7AE24G81EmgqPEa6yVQGaY9VxXk7m8dMp2csLmb
         6kOSl7JWvd6yfAvm+uN48CH9O6MtsHQXWP7dcfirgQcEFHQZ+isqIRVlgHVW1ULYd3
         xpUfW/iPepVbw==
Date:   Sat, 3 Sep 2022 00:17:18 +0100
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Cc: linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, ;
Illegal-Object: Syntax error in To: address found on vger.kernel.org:
        To:     ;
                        ^-missing semicolon to end mail group, extraneous tokens in mailbox, missing end of mailbox
Subject: [PATCH][next] mm/memremap: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <YxKO/jY1x0xTpl4r@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length arrays are deprecated and we are moving towards adopting
C99 flexible-array members, instead. So, replace zero-length array
declaration in struct dev_pagemap with the new DECLARE_FLEX_ARRAY()
helper macro.

This helper allows for a flexible-array member in a union.

Also, this addresses multiple warnings reported when building
with Clang-15 and -Wzero-length-array.

Link: https://github.com/KSPP/linux/issues/193
Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/memremap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index c3b4cc84877b..ad3c38840194 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -135,7 +135,7 @@ struct dev_pagemap {
 	int nr_range;
 	union {
 		struct range range;
-		struct range ranges[0];
+		DECLARE_FLEX_ARRAY(struct range, ranges);
 	};
 };
 
-- 
2.34.1

