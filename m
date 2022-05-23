Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DCB530809
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 05:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355463AbiEWD3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 23:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiEWD27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 23:28:59 -0400
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2258D338AD;
        Sun, 22 May 2022 20:28:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1653276420; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=dPUbWOjXkY4D1ACcVOHZ3MXtDhRJQmFAk5i1zb33Z1Mtq9UG5t1wItiavahgnaHxk8Kjr/ayMGFxLTomCkL/dxYc6hww5mr1eKPtMKtrSel7ZHBxWPwZk3wzxnCLhqx/8Aes5iWyNyCYukZqAAN5gc+jnB28ah2oGipAFI/Gp0Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1653276420; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=653U0KohN+HP/o+oh32zgz9fQdD+H+WyjAKskd6wRQM=; 
        b=UA2+PdDFUw9MHs7m4H0OZFs3/7ZT0vSTkO7mQTSVhJ+KfUhx+DMDsYOztADOAHAMiX/j1FsV74wRpVzVUoyU3C6WAAXJY/tga8YsWNPaSmmKVYVJXeNOpF+Y+kaWf5IAaMFSIzLQrGuWLU9cK9svmfVBOiSkkU7UMun9uTifz4U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1653276420;
        s=zm2022; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To:Cc;
        bh=653U0KohN+HP/o+oh32zgz9fQdD+H+WyjAKskd6wRQM=;
        b=BGPgHSw9zhcJWAmXA3KKfh4gS93r9n6Vm3FTOKWL501vLONPa0Uj1GLl55j8hd8E
        226GnsAdqmzLFxaBue8POaXaYzhh5mCH80c8ixkmDrpzcmUxd6jkW8MjnUeGyxpHcZ9
        03jPQ3Qor/JBMT05ykrx9ab9lSIcJlJrAY1RoqWM=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1653276418781727.4269279984867; Sun, 22 May 2022 20:26:58 -0700 (PDT)
Received: from  [45.12.140.94] by mail.zoho.com
        with HTTP;Sun, 22 May 2022 20:26:58 -0700 (PDT)
Date:   Sun, 22 May 2022 20:26:58 -0700
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
Message-ID: <180eef422c3.deae9cd960729.8518395646822099769@zohomail.com>
In-Reply-To: <180eef39205.122d47c8260721.2430302798386025245@zohomail.com>
References: <180e702a15f.e737e37e45859.3135149506136486394@zohomail.com> <180eef39205.122d47c8260721.2430302798386025245@zohomail.com>
Subject: [PATCH v3 1/4] regmap: provide regmap_field helpers for simple bit
  operations
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr08011226ed2a55e7bd2433a4b81fe4b800005e0616bf7185857e4bd1cb23448e26bba9ab7506f720ece0:zu08011227425c9f2bd7997548a7395e4d0000f6efb52c28c80fdb48cce01e25d481c1bbff148752a6239083:rf0801122c3b2638554a7123d4cc66b00400001ada923ad19f8b2f9de5f5d128cb0de0e42e65a3f81cd01f2a58986b9f47:ZohoMail
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

We have set/clear/test operations for regmap, but not for regmap_field yet.
So let's introduce regmap_field helpers too.

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
index de81a94d7b30..5f317403c520 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1324,6 +1324,22 @@ static inline int regmap_field_update_bits(struct regmap_field *field,
 					     NULL, false, false);
 }
 
+static inline int regmap_field_set_bits(struct regmap_field *field,
+					unsigned int bits)
+{
+	return regmap_field_update_bits_base(field, bits, bits, NULL, false,
+					     false);
+}
+
+static inline int regmap_field_clear_bits(struct regmap_field *field,
+					  unsigned int bits)
+{
+	return regmap_field_update_bits_base(field, bits, 0, NULL, false,
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


