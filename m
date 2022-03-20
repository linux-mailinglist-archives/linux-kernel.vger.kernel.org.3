Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CC74E1CA4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245511AbiCTQ3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239460AbiCTQ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:29:37 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55773344FD;
        Sun, 20 Mar 2022 09:28:13 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so7222684wmb.3;
        Sun, 20 Mar 2022 09:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oYnAnrWU13qc8rQ7MPOxKFwqoXsKN+1WmTS68IkDyt4=;
        b=duToya5GyaLrkMJnWO2Ls+N6vIz4sThEzI6BF9OYmhyrvl2ruxuAfIao2I+rTdaSxw
         vtKjV3zt1JeGbrLC3LH77YcdTpotON/o+N9hXrKbwXwsnp2eu9LZk55EKEdegcdJH8nc
         9FopJPT3Ga9wLmX+fRy2UJ3xmZgsIXOCzwcoowAuU274HQGiJ2sPETOzW5adLwcxdN6J
         vwjj2m4+PMmLjCTRlMzvDM1i008MbYFC91MrF8TgYYm6XkH6XynhZbGfq3noMXWt9F9p
         wb86T2fp/y9DXDctCyM6lVPgW3qijB+nasEaHRHzoWSEULfQCAe96nPRxbdJjmMNQhaG
         /HCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oYnAnrWU13qc8rQ7MPOxKFwqoXsKN+1WmTS68IkDyt4=;
        b=tO8yRoCZxVMsm+9C4JZJNoL6bG5toPHoEgBeZHJci/KhImNuZUUX4jdnjOjVq3W9kh
         qf9pWKg0PFn36ArL/c79RhIuEVe7zgJqp64jmluZsIe+Pwnsp9Oxju2QrdZZI1KHLzAr
         E+cdulUSJxo+gb25V8/+VZLnQoaVkfMOQBL3XpftFb8s+X6XqqteA+m0DL0StK/V/FQh
         VY6wELNxP/zL6o0QupUmmwuMXsu1gPkM4NLUuzQSAskjgTAnbiTrE/Kl5l32sQURnq2q
         8PxHctC1GRRfj/vTkehnWWgQIW9IEf9Y82MSl3gNUnBR7t8tyZ8Q5SxvtIgPCfqhBj3+
         MK+Q==
X-Gm-Message-State: AOAM5303J64dTi7U/0WVPzRUNHjVdJD2hn+kTWEUqZM/5y4wpQKikBLv
        apHO2hSDnK8wAxyVzIco7DTOP+M8FJE=
X-Google-Smtp-Source: ABdhPJzsF2L39vQVemrWbD2ydWVKnPPXKF1H8NNqmf5MZ1reKui8rBG7oZSXKiz9gJuAoFmP0qhQ/g==
X-Received: by 2002:a05:600c:3d0e:b0:38c:9b5e:52c0 with SMTP id bh14-20020a05600c3d0e00b0038c9b5e52c0mr4428465wmb.3.1647793691696;
        Sun, 20 Mar 2022 09:28:11 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id y6-20020a05600015c600b00203fa70b4ebsm6760085wry.53.2022.03.20.09.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 09:28:11 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 01/18] clk: introduce clk_hw_get_index_of_parent new API
Date:   Sun, 20 Mar 2022 12:34:13 +0100
Message-Id: <20220320113430.26076-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220320113430.26076-1-ansuelsmth@gmail.com>
References: <20220320113430.26076-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clk can have multiple parents. Some clk may require to get the cached
index of other parent that are not current associated with the clk.
We have clk_hw_get_parent_index() that returns the index of the current
parent but we can't get the index of other parents of the provided clk.
Introduce clk_hw_get_index_of_parent() to get the cached index of the
parent of the provided clk. This permits a direct access of the internal
clk_fetch_parent_index().

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/clk.c            | 14 ++++++++++++++
 include/linux/clk-provider.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 8de6a22498e7..bdd70a88394c 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1726,6 +1726,20 @@ int clk_hw_get_parent_index(struct clk_hw *hw)
 }
 EXPORT_SYMBOL_GPL(clk_hw_get_parent_index);
 
+/**
+ * clk_hw_get_index_of_parent - return the index of the parent clock
+ * @hw: clk_hw associated with the clk being consumed
+ * @parent: clk_hw of the parent to be fetched the index of
+ *
+ * Fetches and returns the index of parent clock provided.
+ * Returns -EINVAL if the given parent index can't be provided.
+ */
+int clk_hw_get_index_of_parent(struct clk_hw *hw, const struct clk_hw *parent)
+{
+	return clk_fetch_parent_index(hw->core, parent->core);
+}
+EXPORT_SYMBOL_GPL(clk_hw_get_index_of_parent);
+
 /*
  * Update the orphan status of @core and all its children.
  */
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 2faa6f7aa8a8..5708c0b3ef1c 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1198,6 +1198,7 @@ unsigned int clk_hw_get_num_parents(const struct clk_hw *hw);
 struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw);
 struct clk_hw *clk_hw_get_parent_by_index(const struct clk_hw *hw,
 					  unsigned int index);
+int clk_hw_get_index_of_parent(struct clk_hw *hw, const struct clk_hw *parent);
 int clk_hw_get_parent_index(struct clk_hw *hw);
 int clk_hw_set_parent(struct clk_hw *hw, struct clk_hw *new_parent);
 unsigned int __clk_get_enable_count(struct clk *clk);
-- 
2.34.1

