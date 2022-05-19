Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8717D52DB12
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242520AbiESRVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242521AbiESRVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:21:46 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F223A6E8DC
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:21:44 -0700 (PDT)
Received: from integral2.. (unknown [180.242.99.67])
        by gnuweeb.org (Postfix) with ESMTPSA id 91B3F7E2D4;
        Thu, 19 May 2022 17:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1652980904;
        bh=HFxX9idrw0zdJpBNrRQbRvpZcpCfM1y4cC0N7Fy3b+A=;
        h=From:To:Cc:Subject:Date:From;
        b=mCoXqO9OLUH37sX0rZIFtyiYC53Iur1bYZilDaV53h7AJGGn9XR8nsqmQmUNHn7p9
         ldK/pPeXzbDMhqmLfRd+She3pQe7EmVNYlbABsnpjheHcCovjzlajVhSaLmJPjsb81
         BGFJRclOEpl0vh2Z4db5jfhqpE9g3d/+VJICDyTBrCPPbmoURY/MfmHIsg/ezDQ71u
         K6BNbqDLAXSnFEhbNU3YWrpcsw00C7iZpIPDg1F1TrhTeHm2lXxWI/IvRcrty16tCj
         ZbR5E/X80KzYlXeSBCcjZvS0WSMYmOXELBFcw34s3zNS1RdBVL6Glhvn1I33aw1rFM
         CJ7Pcd8bcGGUg==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>, Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Facebook Kernel Team <kernel-team@fb.com>
Subject: [PATCH v1 0/2] nolibc updates for Linux 5.20
Date:   Fri, 20 May 2022 00:21:14 +0700
Message-Id: <20220519172116.283687-1-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Willy,
Hi Paul,

Not much to do this time. Only small nolibc updates here. There are two
patches in this series.

1. Address Willy's comment about overflow checking in the multiplication
   operation [1]. This patch supports overflow checking for older
   compiler versions. Currently, we use `__builtin_mul_overflow()` that
   doesn't exist in older compiler versions. Instead of using this
   built-in, use a simple division to check for overflow in the `calloc()`
   function.

2. The compiler can warn us about wrong `printf` arguments. This patch
   enables the warnings. Currently, only two functions use this attribute:
   `printf` and `fprintf`.

Hopefully, I can send more updates for 5.21+.

Thank you!

Link: https://lore.kernel.org/lkml/20220330024114.GA18892@1wt.eu [1]
Signed-off-by: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

Alviro Iskandar Setiawan (1):
  tools/nolibc/stdio: Add format attribute to enable printf warnings

Ammar Faizi (1):
  tools/nolibc/stdlib: Support overflow checking for older compiler versions

 tools/include/nolibc/stdio.h  | 4 ++--
 tools/include/nolibc/stdlib.h | 7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)


base-commit: 9a9e459ed0e76710f1258b6c1d4c0316b52b4b08
prerequisite-patch-id: e4a9acdc12961f2d4c6bb99e4790b8ffa9d15174
prerequisite-patch-id: 5a618e6a72c7d2beef4ba2c2cf01dadfbaf9a996
prerequisite-patch-id: 1bcffd448f6984eee80d86560af19672cd4ae716
prerequisite-patch-id: 3e31c80bd4dd532e30b4bba76e5d98647e21184b
prerequisite-patch-id: 34e531967a67791d5b3c3e071527de7235715906
prerequisite-patch-id: 14105c6ae9dcc068ddf12a7c1bf431066199b813
prerequisite-patch-id: 4299173943ea579f538da00488fb1a7b1a690a79
prerequisite-patch-id: dd85164f2ec9eb8cea64ab801abac614f9d0c8f5
prerequisite-patch-id: 2c1b940635d1564e26b9959eb57cf9fa6983cb2f
-- 
Ammar Faizi

