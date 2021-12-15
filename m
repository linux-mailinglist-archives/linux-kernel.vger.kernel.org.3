Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A300476674
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhLOXZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhLOXZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:25:00 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388C7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:25:00 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id n15-20020a17090a394f00b001b0f6d6468eso657594pjf.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lOr9C9xGp11EEnMY3mMNWnNiJYgAxYlemMxGk2HFuRg=;
        b=lytFoHtl0Lj32T5InjYLVfxQZpi2WKgvEyhVMgT1fI8y84D6tHBNzP2H6nWgdcqK3N
         8Q+vb5MLG21B7TUEc5BQ6PqqSIr73XjfrIE6XGlg3dEZTiDafUr625Fj5zwbf88NLuT8
         RzFSK+dzcaGBASN30uynT15pcz545Ls0qCol8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lOr9C9xGp11EEnMY3mMNWnNiJYgAxYlemMxGk2HFuRg=;
        b=NK4vjCBbrplbCHkJvMnRFW/nLYUyBAhKftTw8SQmxjGLvASDy2RwJ7rQc550vrELJm
         RTxxcg4roc0S0qWomHAcA7lmHxlXnSjtkmKqVU6n2cm79n/83QKa3+5HRsiqBXlwX8Rc
         7AyaSed7tS+8LCi5R1UllYcBcodWinGtDzkofrDXVCkfTfD7N5tuq1rjSPTWI1awpwYa
         TjDCSohZdA8EioXnZiWoOvhHwDmLzJ3OVbPQ15vyP10atKCYhN1doeO2wFHyqxwedkrl
         ZMjK+sLF4PGsP4W7ov11eWu48pnRPiFk1zNT+Nr7ZdUcbjx79scGicdO1yMC97HP0oy4
         r85w==
X-Gm-Message-State: AOAM532Kapfi1eHsM0cNCM9nXQ+EqoiwhJ3j5kgJbGLBaZ1rDsGaM2eZ
        cjuRl8obmggZ+QS0TrOJn184Og==
X-Google-Smtp-Source: ABdhPJzWEzTUG8xEzsrfCljx5peyqWkmmblcXXzUthtaiwkcoc9pZyhh5uOifCLoK13xyFngR5KyTg==
X-Received: by 2002:a17:90a:6fc2:: with SMTP id e60mr2518511pjk.207.1639610699761;
        Wed, 15 Dec 2021 15:24:59 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j8sm3236014pgf.21.2021.12.15.15.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 15:24:59 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>, Marc Zyngier <maz@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] irqchip: Use correctly sized arguments for bit field
Date:   Wed, 15 Dec 2021 15:24:57 -0800
Message-Id: <20211215232457.2069969-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2200; h=from:subject; bh=I5WDSOsav2JhZZJmDTlc6oPqCbgqurX0/oC9QsVqu7I=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhunlJSnbmL3ZFf+n4wr1+7GmFEXHGYrRsE7Q8E7L9 /lzhAIKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYbp5SQAKCRCJcvTf3G3AJozvD/ 9GyRwY3NUXGkDc/Q4t0UwRNQico29xfXJltIzBTh6tlvI7Biv8/ruDgWE70+c+a7kC4/1A+NdotwIv lQdb+4QCzYClI5CTvxH0kPJ/b11FIh40lGWCnRKqNHXHOJ0ecy7BbE0X07BQ8xwd3M4IXoYjSx6FeX G4ToOFW0FRfAm11n2yLD+55iykcvj13VU270+zWTvQqguzHp6Oz6Be763MpCTDOjAnCzxGkXYTN57z xun+YfYZp/gLKUeyKDn4WMNusAhyQKWTSCAXgy55PxOH+RP/bgPglm/DtZfE/u0Lw0odUDlgrqhg8G 64C8c3pwHSLKYSIQen2HvyEQMYFA3t+adusVD7uuwSCF1i/nv3mW6F4xUy5Z5SL/VtgV/SbeMejNdF cikyDiACgF6WTERpVdpyKAQ9FTXG2LTI9yf4Euk367u/3oaAejNmjspB5tqwLhqcg4hjkt0NpyD9Kh XCHWAi6+BsUZFr7LaJr3BaCwh+trqI8SoJJySRRSImbVvWz/UzDZcGg/xoRwtVJqr5kfJ2j0wpxAWq lR1pZ8BsOyriLEOT1hYXWfUqCFx538qX1tVSByGdiJngbG2I8bUF0hKtCvUANm00D5C54GlfAt1PWk XFs/ugvJqjEZlrYlGB2V/BHSNl1Qp1JdN/+utLfM/rYPNdh20qRbd9UAXmbA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The find.h APIs are designed to be used only on unsigned long arguments.
This can technically result in a over-read, but it is harmless in this
case. Regardless, fix it to avoid the warning seen under -Warray-bounds,
which we'd like to enable globally:

In file included from ./include/linux/bitmap.h:9,
                 from ./include/linux/cpumask.h:12,
                 from ./include/linux/smp.h:13,
                 from ./include/linux/lockdep.h:14,
                 from ./include/linux/mutex.h:17,
                 from ./include/linux/notifier.h:14,
                 from ./include/linux/clk.h:14,
                 from drivers/irqchip/irq-ingenic-tcu.c:7:
drivers/irqchip/irq-ingenic-tcu.c: In function 'ingenic_tcu_intc_cascade':
./include/linux/find.h:40:23: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'uint32_t[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
   40 |                 val = *addr & GENMASK(size - 1, offset);
      |                       ^~~~~
drivers/irqchip/irq-ingenic-tcu.c:30:18: note: while referencing 'irq_reg'
   30 |         uint32_t irq_reg, irq_mask;
      |                  ^~~~~~~

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/irqchip/irq-ingenic-tcu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ingenic-tcu.c b/drivers/irqchip/irq-ingenic-tcu.c
index 34a7d261b710..3363f83bd7e9 100644
--- a/drivers/irqchip/irq-ingenic-tcu.c
+++ b/drivers/irqchip/irq-ingenic-tcu.c
@@ -28,6 +28,7 @@ static void ingenic_tcu_intc_cascade(struct irq_desc *desc)
 	struct irq_chip_generic *gc = irq_get_domain_generic_chip(domain, 0);
 	struct regmap *map = gc->private;
 	uint32_t irq_reg, irq_mask;
+	unsigned long bits;
 	unsigned int i;
 
 	regmap_read(map, TCU_REG_TFR, &irq_reg);
@@ -36,8 +37,9 @@ static void ingenic_tcu_intc_cascade(struct irq_desc *desc)
 	chained_irq_enter(irq_chip, desc);
 
 	irq_reg &= ~irq_mask;
+	bits = irq_reg;
 
-	for_each_set_bit(i, (unsigned long *)&irq_reg, 32)
+	for_each_set_bit(i, &bits, 32)
 		generic_handle_domain_irq(domain, i);
 
 	chained_irq_exit(irq_chip, desc);
-- 
2.30.2

