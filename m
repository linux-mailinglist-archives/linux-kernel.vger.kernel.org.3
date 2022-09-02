Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFE55ABB08
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 01:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiIBXJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 19:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiIBXJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 19:09:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8E0F2C9C;
        Fri,  2 Sep 2022 16:08:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D51C0B82DE6;
        Fri,  2 Sep 2022 23:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A88BC433C1;
        Fri,  2 Sep 2022 23:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662160136;
        bh=2EJ44p1NOuFdawXtFpve8XNvmzeEm2FRDmCUdz/HBl8=;
        h=Date:From:To:Subject:From;
        b=au+YyFIRlMgEhRXGz70ckRjrpIOuAaiVl2gJ7SM+PD8O3V9LoebKMg1dB+uXCLP15
         oKCNWn2jEm6PeO4FwT5EMauMm6n0aowse6/lvcCMfUB57yt7Pocd/UI+PTSS9mEXaT
         BelPPzovKlaOezhoJ1OQorWQi2XURhh0lPGnW9LP4coy5ypocxeFj1PtunwjpkNHoL
         cXHZ7Nc1W8XFoHpXeQPw1TvmubJ0uaAXJcp5cLe8hpGZwzJWKf1eTb+1GZHWw76aMO
         MnXrLbuxPFP6YrSqSN3fTAJQgmvqsp7EoH3s382Gp1zDzP3CJdLYTzU0lZd4FOV/I+
         xJDjKB8urh/3Q==
Date:   Sat, 3 Sep 2022 00:08:51 +0100
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Cc: linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, ;
Illegal-Object: Syntax error in To: address found on vger.kernel.org:
        To:     ;
                        ^-missing semicolon to end mail group, extraneous tokens in mailbox, missing end of mailbox
Subject: [PATCH][next] exportfs: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <YxKNA/3add4wxI3R@work>
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
C99 flexible-array members instead. So, replace zero-length array
declaration in struct fid with the new DECLARE_FLEX_ARRAY()
helper macro.

This helper allows for a flexible-array member in a union.

Link: https://github.com/KSPP/linux/issues/21
Link: https://github.com/KSPP/linux/issues/193
Link: https://github.com/KSPP/linux/issues/197
Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/exportfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index fe848901fcc3..1640d97e4c0d 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -131,7 +131,7 @@ struct fid {
  			u32 parent_block;
  			u32 parent_generation;
  		} udf;
-		__u32 raw[0];
+		DECLARE_FLEX_ARRAY(__u32, raw);
 	};
 };
 
-- 
2.34.1

