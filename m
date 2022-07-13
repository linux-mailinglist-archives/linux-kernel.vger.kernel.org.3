Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0800E572CD6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbiGMFAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbiGMFAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:00:16 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C399B32073
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:00:15 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dn9so17829465ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XK3eAznYnMqkqX/6bVlmokqUaWC4Z4VLgnMUjqyOqbY=;
        b=bnDnQdMDZOLk1M8qct8iD/0HC/IJw8m5L+UKGGR+jVys7wZxRZ6wlSxw5NAwHAByBv
         a4NQ5RjNMeFpeg+ddzGQNlZQPlLF8bB8k6Ut4w8CSUG5jwPMCCL1LMqIXSFQlUSTTKdW
         H2xJ4f2nGqgPMB340WmbH7GijolBIoU5oGxQ2JSiZN+6EbIglxL5CCyyPF/Sh/X+F8wh
         PztmArOWTNt1v2ho7e/t8CY9JEdua7JmOzD9NZLVP0+08yOllpWKbJlgYm+BENfoaBjI
         AcT5hXnDqLy+bmgYgmGfW6kTEUnKezSJ/9bEDUZZiGZ2CNKG351jEQ6rWozg7nkdd4bv
         jfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XK3eAznYnMqkqX/6bVlmokqUaWC4Z4VLgnMUjqyOqbY=;
        b=RTgL50+iVldVnQJDrKJCN74ptHU6cGC0lX2ySzJGvYPaQ4FnIEJvYTGlM8k6YO5ruB
         WQuufS4GzRNXTAtdVECiJ9nJ95gAyz3qFD4n8EuhS5ehrU4n4Y2Lt27o+zCbgCLoF0jx
         DTcVLDXTTsEtEnAsBjPdACiFT90F+5bQHjRDSr6lhh2tRjUfBDrUoqaUCtf2Qqa+zUIw
         Z4WvPKOA5D+bcFJO0ix+puW+H6XQuFILrDL5o0yBKcRj16sskXRj6fmMI+BFNZ0zdz/p
         pEIRnIa0H/LxrDye9+7RsrY+0Sim1msdd9cO4D5pSRH7baq6PGMv29IlWUGq9aqieKyq
         uj8Q==
X-Gm-Message-State: AJIora9/UD2zWKe0buY3ujHWyShuoPWRG3Z1Cs+WI1TevYM0OzPzBNnT
        3HeMBnQVVK672IA/6I89p5ObZLUSk44=
X-Google-Smtp-Source: AGRyM1tbi+i09pjDzb48Bp764UEb+iKcQH7L4pxqx18VkoNmQFOqFncOsUacjnS2oLCmUPqw1p5qOg==
X-Received: by 2002:a17:906:31d9:b0:726:a68b:b666 with SMTP id f25-20020a17090631d900b00726a68bb666mr1562836ejf.159.1657688414376;
        Tue, 12 Jul 2022 22:00:14 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id oz7-20020a170906cd0700b0072b16ea4795sm4474967ejb.48.2022.07.12.22.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 22:00:14 -0700 (PDT)
Date:   Wed, 13 Jul 2022 07:00:12 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] staging: vt6655: Rename wData to reg_value in two
 macros
Message-ID: <8f2e9451a24e380c997fcf7c87249f7ed9b66787.1657657918.git.philipp.g.hortmann@gmail.com>
References: <cover.1657657918.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1657657918.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix name of a variable in two macros that use CamelCase which is not
accepted by checkpatch.pl

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/mac.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 16c18a1ed22e..2a31c94156b2 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -546,9 +546,9 @@ do {									\
 
 #define MACvWordRegBitsOn(iobase, reg_offset, bit_mask)		\
 do {									\
-	unsigned short wData;						\
-	wData = ioread16(iobase + reg_offset);				\
-	iowrite16(wData | (bit_mask), iobase + reg_offset);		\
+	unsigned short reg_value;					\
+	reg_value = ioread16(iobase + reg_offset);			\
+	iowrite16(reg_value | (bit_mask), iobase + reg_offset);		\
 } while (0)
 
 #define MACvRegBitsOff(iobase, reg_offset, bit_mask)			\
@@ -560,9 +560,9 @@ do {									\
 
 #define MACvWordRegBitsOff(iobase, reg_offset, bit_mask)		\
 do {									\
-	unsigned short wData;						\
-	wData = ioread16(iobase + reg_offset);				\
-	iowrite16(wData & ~(bit_mask), iobase + reg_offset);		\
+	unsigned short reg_value;					\
+	reg_value = ioread16(iobase + reg_offset);			\
+	iowrite16(reg_value & ~(bit_mask), iobase + reg_offset);	\
 } while (0)
 
 #define MACvReceive0(iobase)						\
-- 
2.37.0

