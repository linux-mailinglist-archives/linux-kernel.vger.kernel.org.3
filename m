Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAAC4B91AA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237956AbiBPTp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:45:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbiBPTpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:45:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C1D2B0B0E;
        Wed, 16 Feb 2022 11:45:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5A99ECE288F;
        Wed, 16 Feb 2022 19:45:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58ABFC004E1;
        Wed, 16 Feb 2022 19:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645040726;
        bh=nV83EU5BC6L679ZHewC4G3ylEOOQGrWb+Knyt4QxiZc=;
        h=Date:From:To:Cc:Subject:From;
        b=MAvPwRZPatgu0YtwoH60uhnzF7GDZL1DEw3ZsLTIE6ZwtzOfVMXcsvTtodGeyYdP9
         k//erXEpCq9TJOOZT/SNiIgtDLnmAqwwZfd39YbdZAvMqwh+21MHRG2Oh8bNfKC976
         qO70O8GrdgnzQk9ynUVZiM6dbdINFzlnG/DOSFNJNHzmNDXQqj8hdwSp1QZ3o4Pr2K
         GLPZAJaxVWGZbXBUr27gzvWcr1QyoPUjIwjpNyQcKv0ZH3DrXEf3B4jZozUKg/C+tF
         tOrHIlmpwQRJD7s5qFgK559nnrCYntqg/ISNm8gNOcUtAPli6C8Jf6Tqv2osOj/N+N
         0D4v0FaVQ8NRA==
Date:   Wed, 16 Feb 2022 13:53:06 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Cc: linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, ;
Illegal-Object: Syntax error in To: address found on vger.kernel.org:
        To:     ;
                        ^-missing semicolon to end mail group, extraneous tokens in mailbox, missing end of mailbox
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] uapi: wireless: Replace zero-length array with
 flexible-array member
Message-ID: <20220216195306.GA904220@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a regular need in the kernel to provide a way to declare
having a dynamically sized set of trailing elements in a structure.
Kernel code should always use “flexible array members”[1] for these
cases. The older style of one-element or zero-length arrays should
no longer be used[2].

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/78
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/uapi/linux/wireless.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/wireless.h b/include/uapi/linux/wireless.h
index 08967b3f19c8..3c2ad5fae17f 100644
--- a/include/uapi/linux/wireless.h
+++ b/include/uapi/linux/wireless.h
@@ -835,7 +835,7 @@ struct iw_encode_ext {
 			       * individual keys */
 	__u16		alg; /* IW_ENCODE_ALG_* */
 	__u16		key_len;
-	__u8		key[0];
+	__u8		key[];
 };
 
 /* SIOCSIWMLME data */
-- 
2.27.0

