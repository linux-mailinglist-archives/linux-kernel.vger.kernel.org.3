Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55734DDE08
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbiCRQKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbiCRQJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:09:50 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9328CCEA;
        Fri, 18 Mar 2022 09:08:31 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id qa43so17850789ejc.12;
        Fri, 18 Mar 2022 09:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oYnAnrWU13qc8rQ7MPOxKFwqoXsKN+1WmTS68IkDyt4=;
        b=IYWICB10auDKADqRkK67j/3pUWIbxXpjkiWVRzQwBQHdSQmqkByK8FtVcNuz6u9Qh0
         AcWhGteKEAIFcAQizai26018iUQDciXloTAFzjJcuvC1/h0IieBq6mPy4dwCLCiswDmq
         StYaWFrDpMigBpbP0FeefigjNzBJ9CNUBqEbMt5WbspJsuKyTk6YY2twm2HoYirvwh6V
         e6oJ5yVcIhKEOEN8V7IJtHdSWCHhnJTUHTaykVzWO+8hy/8Q632eZsE1GpMEYDPZ1MA/
         wzfAVR/YMzpXg3ZKRCF/bcQx+maQ6JYR3YpY7obcLSKdFfkBzcxkFiHKwmPKCudBFOOm
         ITHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oYnAnrWU13qc8rQ7MPOxKFwqoXsKN+1WmTS68IkDyt4=;
        b=aV/B6U6X9U3gHAE+0E0Rss3l7lsbUxMgqTzL5Uin6fQ5M04rfio5oOS9cAg2XcBasZ
         uZ5eqdco1+I47GmcO1AG2KUbBt0Vbl9eUpiMMUqonNF4grzAIHct8mN+FmdCeOvEKaJ9
         r8M8tZT6IrlU2TgSuibPcYRE24NhFN1iECDlMC/txLdwRqt5kFnYh0i8YKwWKJsu9Vcd
         /CaJufd0mrTMuc++q3gqvjHVP2wNrjLhekvNq5hdeEExnk5m0jqaQphClvrl3yep8G4b
         zIdzD6IltKzk7cESF6GPfkIl6bg9V+M2DsGU/BYWeR91ZyimNTg/xCaE2IaU1JGVsSh9
         dU/g==
X-Gm-Message-State: AOAM533UAVcYiC7E4XNUd1CSc8zkY3rcO9hGCAtdevJY2qZXm0QvoNkk
        05iDnjlvwZ1ZsMk0nNsntOs=
X-Google-Smtp-Source: ABdhPJyjiVrkUrzXJNvhN0lLGaJeq0OTV2S+YCR9gl+sNX3dM8BlHFTyqoVx/vXJPzREo/k3simk8w==
X-Received: by 2002:a17:906:36ce:b0:6d6:e540:ed65 with SMTP id b14-20020a17090636ce00b006d6e540ed65mr9644625ejc.330.1647619710058;
        Fri, 18 Mar 2022 09:08:30 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id e9-20020a170906c00900b006d4a45869basm3754118ejz.199.2022.03.18.09.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 09:08:29 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 01/16] clk: introduce clk_hw_get_index_of_parent new API
Date:   Fri, 18 Mar 2022 17:08:12 +0100
Message-Id: <20220318160827.8860-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220318160827.8860-1-ansuelsmth@gmail.com>
References: <20220318160827.8860-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

