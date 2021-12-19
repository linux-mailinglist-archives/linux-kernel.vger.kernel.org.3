Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D1D47A2E2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 23:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbhLSWkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 17:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236902AbhLSWkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 17:40:10 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F63C06173E;
        Sun, 19 Dec 2021 14:40:10 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id t34so8202507qtc.7;
        Sun, 19 Dec 2021 14:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7leHdpaQg3PwahA55nSHAM68OeE/r5eeWqToNrZ4TPs=;
        b=Eb+NaZuiEKmlScNeOI50w2VXZ4Rying3DIBotVg1EMD04TLjdcHgu5SvC7NKi1K9k+
         +NN27fwo4GvG3PWQB/smToRnqRljsWaXijDT+7zB6xGDpD82KF7X0nEPwRjYioGoQxii
         eUsxXTw1FFEIU5UCx7hxzF9Of6JBu4xlz3okVqciUKJ5plBptHeeotJxIJtnQc0213Ur
         E+R8QucKrHbGkFwpqwmZf35jbgqZ2LuqwphWBNH+nIz32ZCalwcF87U2PBwFk8MIQpzw
         Y/6ULIF7ZhVfVyKAYgJGpkxnio7OEuu+i2U5bJUVsqOwOoAxcpOQwmyn4mjX0ER33DUW
         Ph0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7leHdpaQg3PwahA55nSHAM68OeE/r5eeWqToNrZ4TPs=;
        b=0MY85STkBps/rp2Tpw4DVdPwO8OvbAK4SjyuH8Ani+1FNtEEuZRIT+hLRfL5T+6VCq
         v0EMBJ+4rOtoLUIFptEhRREIjjbRuWp5QB8w7lNl8b+KClb47yGQ4B79munjtnDCqcbD
         0VAbws+9tHYWOh1WGoQNMhzZ4+dbkZZIYj9p/zBs88NFLlEqToLdwuUNB77G5oO0NXH6
         h/55QOOBDYo6TsPLQm4uKRLdxIXN/gKoanXJEsZeqVSoA5Vgl3MDTmyjXKXCxqtl3MHc
         4jZt9rHAMg8GUu4Gruq8vQHCTrdtKsJ4ijmvpqNJf5lrrGMUZGMbd91HxI5qEjCfuHxV
         j+hw==
X-Gm-Message-State: AOAM5305RoGK/UsMavXf57xbwW2/NKI+9TjsKjG7pFx7vFlJ6Y9wk/So
        /R6kut5ANjZ9Fg1zcY3VJc8=
X-Google-Smtp-Source: ABdhPJxwnuJY99XWoJOV8ybu+RhV9q4J6//X6PmdbCJ2zuIBibiMgqvK/oxuy3gA1ia7eSCyyMOTng==
X-Received: by 2002:ac8:7c4b:: with SMTP id o11mr10487070qtv.358.1639953609467;
        Sun, 19 Dec 2021 14:40:09 -0800 (PST)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id q7sm4591880qkl.72.2021.12.19.14.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 14:40:09 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v10 08/14] iio: afe: rescale: fix accuracy for small fractional scales
Date:   Sun, 19 Dec 2021 17:39:47 -0500
Message-Id: <20211219223953.16074-9-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211219223953.16074-1-liambeguin@gmail.com>
References: <20211219223953.16074-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

The approximation caused by integer divisions can be costly on smaller
scale values since the decimal part is significant compared to the
integer part. Switch to an IIO_VAL_INT_PLUS_NANO scale type in such
cases to maintain accuracy.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index e3680998565e..66306477aeab 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -23,7 +23,7 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 			  int *val, int *val2)
 {
 	s64 tmp;
-	s32 rem;
+	s32 rem, rem2;
 	u32 mult;
 	u32 neg;
 
@@ -42,9 +42,23 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		tmp = (s64)*val * 1000000000LL;
 		tmp = div_s64(tmp, rescale->denominator);
 		tmp *= rescale->numerator;
-		tmp = div_s64(tmp, 1000000000LL);
+
+		tmp = div_s64_rem(tmp, 1000000000LL, &rem);
 		*val = tmp;
-		return scale_type;
+
+		if (!rem)
+			return scale_type;
+
+		tmp = 1 << *val2;
+
+		rem2 = *val % (int)tmp;
+		*val = *val / (int)tmp;
+
+		*val2 = rem / (int)tmp;
+		if (rem2)
+			*val2 += div_s64((s64)rem2 * 1000000000LL, tmp);
+
+		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_VAL_INT_PLUS_NANO:
 	case IIO_VAL_INT_PLUS_MICRO:
 		mult = scale_type == IIO_VAL_INT_PLUS_NANO ? NANO : MICRO;
-- 
2.34.0

