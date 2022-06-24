Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0989559C62
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiFXOg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbiFXOfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:35:41 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB2EF5DF19;
        Fri, 24 Jun 2022 07:35:14 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 7936616C7;
        Fri, 24 Jun 2022 17:20:19 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 7936616C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1656080419;
        bh=3UfPEG9NoKRc1ViJ6X0Y9kRe75ENoa5FpKOJZHHMvCA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=inwkX13nS0X2iKzNJaH4/HkGk26DDShbl+yYtQ/QVb1TapyRSSO7ktwRGdPpYnWc6
         cg8maVixDEexpiSUPxe/nhmIaRbWfpXlXhMPASKKmFPP4fVfhEfAm7zSQsgH01zT6D
         W/EEvA5dYgUpJ+xAspM2Uj2NsLVj3D+nuYiYyjZg=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 24 Jun 2022 17:18:59 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-clk@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v5 1/8] reset: Fix devm bulk optional exclusive control getter
Date:   Fri, 24 Jun 2022 17:18:45 +0300
Message-ID: <20220624141853.7417-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220624141853.7417-1-Sergey.Semin@baikalelectronics.ru>
References: <20220624141853.7417-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most likely due to copy-paste mistake the device managed version of the
denoted reset control getter has been implemented with invalid semantic,
which can be immediately spotted by having "WARN_ON(shared && acquired)"
warning in the system log as soon as the method is called. Anyway let's
fix it by altering the boolean arguments passed to the
__devm_reset_control_bulk_get() method from
- shared = true, optional = false, acquired = true
to
+ shared = false, optional = true, acquired = true
That's what they were supposed to be in the first place (see the non-devm
version of the same method: reset_control_bulk_get_optional_exclusive()).

Fixes: 48d71395896d ("reset: Add reset_control_bulk API")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v4:
- This is a new patch added on v4 lap of the series.
---
 include/linux/reset.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/reset.h b/include/linux/reset.h
index 8a21b5756c3e..514ddf003efc 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -731,7 +731,7 @@ static inline int __must_check
 devm_reset_control_bulk_get_optional_exclusive(struct device *dev, int num_rstcs,
 					       struct reset_control_bulk_data *rstcs)
 {
-	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, true, false, true);
+	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, false, true, true);
 }
 
 /**
-- 
2.35.1

