Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1235553C4D1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 08:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241430AbiFCGUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 02:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241392AbiFCGUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 02:20:37 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D4231DF4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 23:20:31 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id j6so6471000pfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 23:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h1P/A46rz0jqr+k+LHINMkdY2BqpjbSfON2jDhuttCk=;
        b=bRZbRb0c6vbM3h5BD8ZwiJVDiaraTaM+flEivzgjZibK0703ajhsQiA8SeXBzTeQ1P
         46URkWniAu7UOdd0g5z18mB6RKn8Pl+vNRONvHyOQecR9ML6/X/pPE6fwFrRKLJo0oa+
         C2IgTYWwxQKmoD4u35TwTBCoFjh4cFWtJ3rmBoUmGqWBJK813JfzuUer5YoTeWP827EZ
         9Vs/UuOC9ESJ14R1Ej/3XMqgIRA9WFWuL3ND0z7t3SOsHkCGkqfwSrYrSkxA/XS60QIb
         l/0Ehy1R919k5a8HA37sEv6333fwbsejHKjQZNgARebERYHCUvytBq8iKFxxQM0rFRVE
         4sUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h1P/A46rz0jqr+k+LHINMkdY2BqpjbSfON2jDhuttCk=;
        b=qdqzh+pUG1RXVmgJaRfrBI6sPN+sS7gtutpwFGsu6urQU/vMQgHDCeGIPH6HTcefJJ
         SdqD1JKZRVvSlqvu056UlUQRY2p8zQXYlVKebZloeZghTd0nyrgqxJa9U0EOF2dbqzHn
         stlQfqd3BE5p41vYHTqTbtZmbeC4NW/jFV0uK99GXw/GqvSverwcaTzNi+zrq74OnDFD
         O6S/plG+lGRg1xb2Lieo+i4ejmhZmqfiCKtTPIHe9HVNib5b9YOdcaEfGMljmjmKvpRj
         ZEsgk6qlFNSiCL4IwAKjtxUkGAkdRxr8VtjiyqA8V9pET8XvlOZAYDe4aFirRqJrwE6t
         pKrw==
X-Gm-Message-State: AOAM5337sXePFk4PhODAhUysGxJLVkeX1NkEwKrncbxc7btwtOVCsBm2
        2HOgIUZE1LdaGaWYd9/7jWbqRA==
X-Google-Smtp-Source: ABdhPJxY4oWi3mOzIZS/bc0MEnpzrXKxSgYmAb7SDcvCmYxl2hJuyDWFqwYtZZ4Gx+IVApZ9JlK5RQ==
X-Received: by 2002:a05:6a00:10cc:b0:505:ada6:e03e with SMTP id d12-20020a056a0010cc00b00505ada6e03emr8905928pfu.45.1654237231271;
        Thu, 02 Jun 2022 23:20:31 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902d65400b00163cc9d6a04sm4606486plh.299.2022.06.02.23.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 23:20:30 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] OPP: Add generic key finding helpers
Date:   Fri,  3 Jun 2022 11:50:16 +0530
Message-Id: <015602dc3313be081ce2b5b2057361dab95d55b9.1654235445.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1654235445.git.viresh.kumar@linaro.org>
References: <cover.1654235445.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are three type of helpers, to find exact, ceil, and floor values,
replicated for multiple key types, freq, level, bw. And all of these
helpers share a lot of boilerplate code.

Add generic key finding helpers to reduce code redundancy.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 132 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 1ee218dcb0b9..7ef6eafc7946 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -420,6 +420,138 @@ int dev_pm_opp_get_opp_count(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_count);
 
+/* Helpers to read keys */
+static unsigned long _read_freq(struct dev_pm_opp *opp, int index)
+{
+	return opp->rate;
+}
+
+static unsigned long _read_level(struct dev_pm_opp *opp, int index)
+{
+	return opp->level;
+}
+
+static unsigned long _read_bw(struct dev_pm_opp *opp, int index)
+{
+	return opp->bandwidth[index].peak;
+}
+
+/* Generic comparison helpers */
+static bool _compare_exact(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
+			   unsigned long opp_key, unsigned long key)
+{
+	if (opp_key == key) {
+		*opp = temp_opp;
+		return true;
+	}
+
+	return false;
+}
+
+static bool _compare_ceil(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
+			  unsigned long opp_key, unsigned long key)
+{
+	if (opp_key >= key) {
+		*opp = temp_opp;
+		return true;
+	}
+
+	return false;
+}
+
+static bool _compare_floor(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
+			   unsigned long opp_key, unsigned long key)
+{
+	if (opp_key > key)
+		return true;
+
+	*opp = temp_opp;
+	return false;
+}
+
+/* Generic key finding helpers */
+static struct dev_pm_opp *
+_opp_table_find_key(struct opp_table *opp_table, unsigned long *key, int index, bool available,
+		    unsigned long (*read)(struct dev_pm_opp *opp, int index),
+		    bool (*compare)(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
+				    unsigned long opp_key, unsigned long key))
+{
+	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
+
+	mutex_lock(&opp_table->lock);
+
+	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
+		if (temp_opp->available == available) {
+			if (compare(&opp, temp_opp, read(temp_opp, index), *key))
+				break;
+		}
+	}
+
+	/* Increment the reference count of OPP */
+	if (!IS_ERR(opp)) {
+		*key = read(opp, index);
+		dev_pm_opp_get(opp);
+	}
+
+	mutex_unlock(&opp_table->lock);
+
+	return opp;
+}
+
+static struct dev_pm_opp *
+_find_key(struct device *dev, unsigned long *key, int index, bool available,
+	  unsigned long (*read)(struct dev_pm_opp *opp, int index),
+	  bool (*compare)(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
+			  unsigned long opp_key, unsigned long key))
+{
+	struct opp_table *opp_table;
+	struct dev_pm_opp *opp;
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		dev_err(dev, "%s: OPP table not found (%ld)\n", __func__, PTR_ERR(opp_table));
+		return ERR_CAST(opp_table);
+	}
+
+	opp = _opp_table_find_key(opp_table, key, index, available, read, compare);
+
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return opp;
+}
+
+static struct dev_pm_opp *
+_find_key_exact(struct device *dev, unsigned long key, int index, bool available,
+		unsigned long (*read)(struct dev_pm_opp *opp, int index))
+{
+	/*
+	 * The value of key will be updated here, but will be ignored as the
+	 * caller doesn't need it.
+	 */
+	return _find_key(dev, &key, index, available, read, _compare_exact);
+}
+
+static struct dev_pm_opp *
+_opp_table_find_key_ceil(struct opp_table *opp_table, unsigned long *key, int index, bool available,
+			 unsigned long (*read)(struct dev_pm_opp *opp, int index))
+{
+	return _opp_table_find_key(opp_table, key, index, available, read, _compare_ceil);
+}
+
+static struct dev_pm_opp *
+_find_key_ceil(struct device *dev, unsigned long *key, int index, bool available,
+	       unsigned long (*read)(struct dev_pm_opp *opp, int index))
+{
+	return _find_key(dev, key, index, available, read, _compare_ceil);
+}
+
+static struct dev_pm_opp *
+_find_key_floor(struct device *dev, unsigned long *key, int index, bool available,
+		unsigned long (*read)(struct dev_pm_opp *opp, int index))
+{
+	return _find_key(dev, key, index, available, read, _compare_floor);
+}
+
 /**
  * dev_pm_opp_find_freq_exact() - search for an exact frequency
  * @dev:		device for which we do this operation
-- 
2.31.1.272.g89b43f80a514

