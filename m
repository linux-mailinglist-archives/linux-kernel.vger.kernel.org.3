Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBCA51F505
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbiEIHGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbiEIG6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:58:46 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459C815E615
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 23:54:54 -0700 (PDT)
Received: from localhost.localdomain (unknown [138.197.159.143])
        by gnuweeb.org (Postfix) with ESMTPSA id 647107E7F6;
        Mon,  9 May 2022 06:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1652079293;
        bh=S0U9M32154HScyfLSnF1HZ9qZvAR0EcCgcUUKQmmE44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WHfbcEyoxuzZ2fSeGRnGn8fybzzOrakqv0xyTMDpZZADLUDgiaQ5U02yjbXyKtgV+
         IkWPjQvCgsAOUuuQ7J2zbiPNvpxcLTZ/4BWH/81NNxvhWGc2TJhYfi10JS74vBa9BC
         303lJS1TaaNn4Rh512aK20HkxZgVLy/+RjWzhnOlYxJspgX06Bb4yclmPg/nBA5/+w
         5Yr8o8o3jAWurcDjuyrFgQjC3n811L4WZmdzEPqlUErAPppZF+qZaavLhsyHn1F6P8
         sesXfFJujp1R0DbYiZJmJ7XTwesHLxywUqLkUTTNW6zVnhB3Jj6LeUseHuMVg0XkU+
         EFzkaxsQsz+yQ==
From:   Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Subject: [PATCH 1/1] tools/nolibc/stdio: Add format attribute to enable printf warnings
Date:   Mon,  9 May 2022 06:54:45 +0000
Message-Id: <20220509065445.3912334-2-alviro.iskandar@gnuweeb.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220509065445.3912334-1-alviro.iskandar@gnuweeb.org>
References: <20220509065445.3912334-1-alviro.iskandar@gnuweeb.org>
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

When we use printf and fprintf functions from nolibc, we don't get any
warning from the compiler if we have wrong arguments, for example the
following calls will compile silently:
```
  printf("%s %s\n", "aaa");
  fprintf(stdout, "%s %s\n", "xxx", 1);
```
Those calls are undefined behavior. We can catch it at compile time by
adding format attribute to those function declarations. After this
patch, we get the following warnings:
```
  warning: format `%s` expects a matching `char *` argument [-Wformat=]
  warning: format `%s` expects argument of type `char *`, but argument 4 has type `int` [-Wformat=]
```

Signed-off-by: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
---
 tools/include/nolibc/stdio.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 15dedf8d0902..009dd6ae68f2 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -273,7 +273,7 @@ int vfprintf(FILE *stream, const char *fmt, va_list args)
 	return written;
 }
 
-static __attribute__((unused))
+static __attribute__((unused)) __attribute__((format(printf, 2, 3)))
 int fprintf(FILE *stream, const char *fmt, ...)
 {
 	va_list args;
@@ -285,7 +285,7 @@ int fprintf(FILE *stream, const char *fmt, ...)
 	return ret;
 }
 
-static __attribute__((unused))
+static __attribute__((unused)) __attribute__((format(printf, 1, 2)))
 int printf(const char *fmt, ...)
 {
 	va_list args;
-- 
Alviro Iskandar Setiawan

