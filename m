Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB4A4BC91F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 16:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242527AbiBSP2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 10:28:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242517AbiBSP2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 10:28:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA455D1B4;
        Sat, 19 Feb 2022 07:28:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78B1160B47;
        Sat, 19 Feb 2022 15:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E29C340F1;
        Sat, 19 Feb 2022 15:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645284505;
        bh=vUH/5R6TeSCnTi3AJJW3p5EjrFJ4SqZT0J7ODzHJu9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXoTRyhqCw7q2oNqk0AzPctSLoPBI730vd0lzrpHqtkMMTxAdjHX+zvwhalzf01w9
         4+A73snev4Z2tFNsA/M3bjPakA3t5ghH1zryud+HltQyba3u4mCku0Lz3nV3COQCmL
         M/C96vNw/4MtJFC2/967XfHoUitqRMrou/A26CocD5jsYNfVAosywnqImpGW7A2klE
         heYbGLZmma+OPyMZCjlnQmdJeX/5WyOSHIsDAbjoX9ccI7cesSXWkbJ3li/zjfy2Ty
         ZEe1wjLRIGQV/YbMAel/zWmJTHfMFu0HRYWS9q+lZTgCIsvZSvnQlx3W6mJ1WoSCRB
         ZroNOENQwBEug==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v9 1/6] math64: New DIV_U64_ROUND_CLOSEST helper
Date:   Sat, 19 Feb 2022 16:28:13 +0100
Message-Id: <20220219152818.4319-2-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220219152818.4319-1-kabel@kernel.org>
References: <20220219152818.4319-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Pali Rohár <pali@kernel.org>

Provide DIV_U64_ROUND_CLOSEST helper which uses div_u64 to perform
division rounded to the closest integer using unsigned 64bit
dividend and unsigned 32bit divisor.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 include/linux/math64.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index 2928f03d6d46..a14f40de1dca 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -300,6 +300,19 @@ u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div);
 #define DIV64_U64_ROUND_CLOSEST(dividend, divisor)	\
 	({ u64 _tmp = (divisor); div64_u64((dividend) + _tmp / 2, _tmp); })
 
+/*
+ * DIV_U64_ROUND_CLOSEST - unsigned 64bit divide with 32bit divisor rounded to nearest integer
+ * @dividend: unsigned 64bit dividend
+ * @divisor: unsigned 32bit divisor
+ *
+ * Divide unsigned 64bit dividend by unsigned 32bit divisor
+ * and round to closest integer.
+ *
+ * Return: dividend / divisor rounded to nearest integer
+ */
+#define DIV_U64_ROUND_CLOSEST(dividend, divisor)	\
+	({ u32 _tmp = (divisor); div_u64((u64)(dividend) + _tmp / 2, _tmp); })
+
 /*
  * DIV_S64_ROUND_CLOSEST - signed 64bit divide with 32bit divisor rounded to nearest integer
  * @dividend: signed 64bit dividend
-- 
2.34.1

