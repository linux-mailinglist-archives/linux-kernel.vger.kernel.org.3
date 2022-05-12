Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30232525243
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356338AbiELQOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbiELQOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:14:50 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5ED6623B
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:14:49 -0700 (PDT)
Received: from [192.168.88.87] (unknown [180.242.99.67])
        by gnuweeb.org (Postfix) with ESMTPSA id 02E317F628;
        Thu, 12 May 2022 16:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1652372089;
        bh=3U63MfFe6NNlA7+9OBTVpsTNg4BhGFmC0heC1eTNPn0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HHlioj8YxvRo7x+f4nbXrHcO5+g3bxMx7SRXW142HTO3mHdehBK/a8rmh2dZeFKYn
         XhLlqi/qE2AvWMJEUpVX/S50PYuFgakb+Ob9XOnwWRRakPLYjEmQCB8q1IP3OGCuwj
         +vZ883/d311UUy85Yab3+b8Gxj1x8I+Q7KoIgR6INIwJonBawsKD4oC/mnpDE5mvAt
         MvBLJ4yXTesfbMl07SLVYdOO/3LXcLSJm1T9ldruIs/qN0o7Wol4jwofXm1wM79NJf
         RIBIwIDE78ze1OKHfdxj89R0jqb5MXWB1boS8Ab9Q0x2Wtb6h3j5JhEkiAX8PskeOs
         4BWfm9SPsUmSQ==
Message-ID: <d988d85f-c704-96cd-13b6-7715ea5cacbb@gnuweeb.org>
Date:   Thu, 12 May 2022 23:14:35 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/1] tools/nolibc/stdio: Add format attribute to enable
 printf warnings
Content-Language: en-US
To:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Cc:     GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220509065445.3912334-1-alviro.iskandar@gnuweeb.org>
 <20220509065445.3912334-2-alviro.iskandar@gnuweeb.org>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <20220509065445.3912334-2-alviro.iskandar@gnuweeb.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will send it to Willy soon.

Anyway, __attribute__ can have multiple arguments, so no need
to write it twice. I simplified it, the end result patch below...

Thank you!

---
 From 7998cda9acdbfec6d6ba73642c27d710996c27ed Mon Sep 17 00:00:00 2001
From: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Subject: tools/nolibc/stdio: Add format attribute to enable printf warnings

When we use printf and fprintf functions from the nolibc, we don't
get any warning from the compiler if we have the wrong arguments.
For example, the following calls will compile silently:
```
   printf("%s %s\n", "aaa");
   fprintf(stdout, "%s %s\n", "xxx", 1);
```
(Note the wrong arguments).

Those calls are undefined behavior. The compiler can help us warn
about the above mistakes by adding a `printf` format attribute to
those functions declaration. This patch adds it, and now it yields
these warnings for those mistakes:
```
   warning: format `%s` expects a matching `char *` argument [-Wformat=]
   warning: format `%s` expects argument of type `char *`, but argument 4 has type `int` [-Wformat=]
```

[ammarfaizi2: Simplify the attribute placement.]

Signed-off-by: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
  tools/include/nolibc/stdio.h | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 15dedf8d0902..a3cebc4bc3ac 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -273,7 +273,7 @@ int vfprintf(FILE *stream, const char *fmt, va_list args)
  	return written;
  }
  
-static __attribute__((unused))
+static __attribute__((unused, format(printf, 2, 3)))
  int fprintf(FILE *stream, const char *fmt, ...)
  {
  	va_list args;
@@ -285,7 +285,7 @@ int fprintf(FILE *stream, const char *fmt, ...)
  	return ret;
  }
  
-static __attribute__((unused))
+static __attribute__((unused, format(printf, 1, 2)))
  int printf(const char *fmt, ...)
  {
  	va_list args;


-- 
Ammar Faizi
