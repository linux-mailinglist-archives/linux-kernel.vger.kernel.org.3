Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20C25307A4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 04:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347782AbiEWCYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 22:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351290AbiEWCYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 22:24:45 -0400
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1E03633E;
        Sun, 22 May 2022 19:24:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1653272623; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Mhs37bNwflasXqUL/nuCgrq5OrJP5e0xOyLOB5ZqNPBJm0BXmZtmekIUzvzC3tWtpxhyNrYY2jRuboKEL58lod/B2rdbJ8FMj0exaZb4rde420WhSFTSsrQLduHEeG4ASDc5mlpaQ829IzO4XtOB3RUqF75auzNngQYMCAIh6z8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1653272623; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=xmuC7wjrBYjPhnZdcSYX8RdIkUmIzgF9HaqzQxuyqjU=; 
        b=UxugHEDpEi0QorwwNIc9ACNyxb+X7cnCWzAZ0wiLIpw+fBZvL2gVix+F24VCIoymaW4LBebUKIMhU/CEmvQ+L59DcWB00kewgS+BDjsPeAy0juqRwNCp9hkb9gVxfGuf3XZitTwV/PXort+Bz096b/5bWUSsStQFO0OhF5sbE1A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1653272623;
        s=zm2022; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To:Cc;
        bh=xmuC7wjrBYjPhnZdcSYX8RdIkUmIzgF9HaqzQxuyqjU=;
        b=XLc1kFNl0NGz9rmVlY9a/eJWxrkgKjYfa9GLc5mpCq/gKyxhikIEtaGXYl8cj7es
        vtvRcf07IguP7Easi7THjk9ibrcp6r8NmofXji6ZikyKNqzHNXJViw2tR3S7DV3ZPTd
        ncBmnDvUxX4htci1SQ0JZClcSKdCdc+0XgxqkIJ4=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1653272623146927.7887030557581; Sun, 22 May 2022 19:23:43 -0700 (PDT)
Received: from  [45.12.140.94] by mail.zoho.com
        with HTTP;Sun, 22 May 2022 19:23:43 -0700 (PDT)
Date:   Sun, 22 May 2022 19:23:43 -0700
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
Message-ID: <180eeba3811.f7218bc260169.7323954027713751119@zohomail.com>
In-Reply-To: <180eeb93909.12110e2de60158.391061173597432851@zohomail.com>
References: <180e702a15f.e737e37e45859.3135149506136486394@zohomail.com> <180eeb93909.12110e2de60158.391061173597432851@zohomail.com>
Subject: [PATCH v2 1/4] regmap: provide regmap_field helpers for simple bit
  operations
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr08011226f0c67c19081218c48c19e9650000330f85c9f9faa1b17b873eb77d42e145bde705c4f5f23435:zu08011227410f90132b5cfda0a647cf1b00006eb8554ca4528fc4bafd598538b251c6156d01c7934d640b80:rf0801122c4ee423217b2876e675ede8960000f2ed2563a4e18840ab19ea1cd4b11ba37511798467510fcee42cf27538a9:ZohoMail
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


