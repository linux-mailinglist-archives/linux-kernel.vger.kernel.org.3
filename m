Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C06A52FD46
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 16:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiEUO1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 10:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244440AbiEUO1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 10:27:51 -0400
X-Greylist: delayed 70 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 21 May 2022 07:27:49 PDT
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BA13AA5E;
        Sat, 21 May 2022 07:27:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1653143214; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=kE8zz6hAswUKjScOIdc/L6cdfge6ywC8/K021psACIT8bfnsWDNX12TOXGaF24o+fRy5mh3fFe1IqLjD5t24jEh3mpzrl9jLCFxxMRISAX7jJRCsGUw2Rh9n/1QA2q/iAIm14re9C7l4q1DdHSs9FU4LCdKEeeMVto0g2rdtVMc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1653143214; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=z6wL0P2oxKZ7jyZvUo3skmKeJ3yn8l7j8WvpmJJ9y2A=; 
        b=M8rCYV6GiB59j3m+BgOX1X4lnAKime4OmrWk8WgcgzE3L4n0EqlaYFmFFET02HOZ0RQGxPbehPi7/AfYDVuSaRn7FOMi/QEHvhMOei2frLkeCFXrk1s9hvwwrdxvWqZvLDbUePylsElF9rLtB67M9nSZ8FDIQIUeDthH5PXMSI8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1653143214;
        s=zm2022; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To:Cc;
        bh=z6wL0P2oxKZ7jyZvUo3skmKeJ3yn8l7j8WvpmJJ9y2A=;
        b=B2GhqhSMa94on9wZCUJvL7RXvAzQ165f/25zNzDNlaJjcJ8bKuNXAIqT2P67Cm74
        YzWHw3CGZs0WPXde/u8zheC4xHWyn0Aq4Qo4cSt3ztkMW1iOVoIAcFxOEFB8Aq7t8xs
        Ndgoy8YjgbvEcGwl13opJp6lcWYq83UbjRh2G1dw=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1653143213058600.2769632124064; Sat, 21 May 2022 07:26:53 -0700 (PDT)
Received: from  [45.12.140.94] by mail.zoho.com
        with HTTP;Sat, 21 May 2022 07:26:53 -0700 (PDT)
Date:   Sat, 21 May 2022 07:26:53 -0700
From:   Li Chen <lchen.firstlove@zohomail.com>
To:     "Mark Brown" <broonie@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-gpio" <linux-gpio@vger.kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>,
        "Patrice Chotard" <patrice.chotard@foss.st.com>,
        "linux-sunxi" <linux-sunxi@lists.linux.dev>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>, "Chen-Yu Tsai" <wens@csie.org>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Samuel Holland" <samuel@sholland.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>
Message-ID: <180e70393e7.bea7333745868.3931016213640307954@zohomail.com>
In-Reply-To: <180e702a15f.e737e37e45859.3135149506136486394@zohomail.com>
References: <180e702a15f.e737e37e45859.3135149506136486394@zohomail.com>
Subject: [PATCH 1/4] regmap: provide regmap_field helpers for simple bit
  operations
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr080112268bd82f7cfed3b19c5a185cb40000b440e50754e5654c60ed718200cd49c10dbbf299318737c7:zu08011227f8a703c654550416f81083160000e1fe84f8aac27165abd10358815b6ccdaee61e816e1c2fe8c1:rf0801122c62eaae334301465ae91f312300004b5111d98db5b56dfa50c31137c058746397e6037af2420ba3632588fae1:ZohoMail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Chen <lchen@ambarella.com>

We have set/clear/test oerations for regmap, but not for regmap_field yet.
So let's intoroduce regmap_field helpers too.

In many instances regmap_field_update_bits() is used for simple bit setting
and clearing. In these cases the last argument is redundant and we can
hide it with a static inline function.

This adds three new helpers for simple bit operations: set_bits,
clear_bits and test_bits (the last one defined as a regular function).

Signed-off-by: Li Chen <lchen@ambarella.com>
---
 drivers/base/regmap/regmap.c | 22 +++++++++++++++++++++
 include/linux/regmap.h       | 37 ++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 5e12f7cb5147..a37d6041b7bd 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2208,6 +2208,28 @@ int regmap_field_update_bits_base(struct regmap_field *field,
 }
 EXPORT_SYMBOL_GPL(regmap_field_update_bits_base);
 
+/**
+ * regmap_field_test_bits() - Check if all specified bits are set in a
+ *                            register field.
+ *
+ * @field: Register field to operate on
+ * @bits: Bits to test
+ *
+ * Returns -1 if the underlying regmap_field_read() fails, 0 if at least one of the
+ * tested bits is not set and 1 if all tested bits are set.
+ */
+int regmap_field_test_bits(struct regmap_field *field, unsigned int bits)
+{
+	unsigned int val, ret;
+
+	ret = regmap_field_read(field, &val);
+	if (ret)
+		return ret;
+
+	return (val & bits) == bits;
+}
+EXPORT_SYMBOL_GPL(regmap_field_test_bits);
+
 /**
  * regmap_fields_update_bits_base() - Perform a read/modify/write cycle a
  *                                    register field with port ID
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index de81a94d7b30..10b410734d9e 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1324,6 +1324,22 @@ static inline int regmap_field_update_bits(struct regmap_field *field,
 					     NULL, false, false);
 }
 
+static inline int regmap_field_set_bits(struct regmap_field *field,
+					unsigned int bits)
+{
+	return regmap_field_update_bits_base(field, bits, 0, NULL, false,
+					     false);
+}
+
+static inline int regmap_field_clear_bits(struct regmap_field *field,
+					  unsigned int bits)
+{
+	return regmap_field_update_bits_base(field, bits, bits, NULL, false,
+					     false);
+}
+
+int regmap_field_test_bits(struct regmap_field *field, unsigned int bits);
+
 static inline int
 regmap_field_force_update_bits(struct regmap_field *field,
 			       unsigned int mask, unsigned int val)
@@ -1757,6 +1773,27 @@ regmap_field_force_update_bits(struct regmap_field *field,
 	return -EINVAL;
 }
 
+static inline int regmap_field_set_bits(struct regmap_field *field,
+					unsigned int bits)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
+static inline int regmap_field_clear_bits(struct regmap_field *field,
+					  unsigned int bits)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
+static inline int regmap_field_test_bits(struct regmap_field *field,
+					 unsigned int bits)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
 static inline int regmap_fields_write(struct regmap_field *field,
 				      unsigned int id, unsigned int val)
 {
-- 
2.36.1


