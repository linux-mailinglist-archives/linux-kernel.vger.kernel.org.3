Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709F94E2BCC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349974AbiCUPTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349910AbiCUPTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:19:14 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E80111DF9;
        Mon, 21 Mar 2022 08:17:48 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u16so20158478wru.4;
        Mon, 21 Mar 2022 08:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oYnAnrWU13qc8rQ7MPOxKFwqoXsKN+1WmTS68IkDyt4=;
        b=IMlnXW0jc/BrvYdtOmrfmgwd+fMG79sK67+4kSiAUIWzlFHMzdRN87XOjJ3/ax8QIg
         Ldl/gjYhaqxhfCe8/VNvswVzLyPkVDNCbMvoOqfNVQ2JrmgebtS/oyBlLAj4YVXEs8Me
         fPHV22nl7gvkR+g31m6bokFeh7sx0nCm4zJ8Z16IhrJy2hEI90YpnsAxcX1ORENgZgTP
         kkWIjGcUiKFGinwEGL4kZl87qBxaWx4sQt2V7Bpzx2UHeVSp+aebyCJsbLY8Rv9ekTrz
         wCJ1T40jpzC/YzJ7JEJQYuwwgsmthmagRxDx1B/ojfu+WxsgWhf7WIuW59taBIgHq0Zl
         zeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oYnAnrWU13qc8rQ7MPOxKFwqoXsKN+1WmTS68IkDyt4=;
        b=oBSz+ofAkAqwoMzGsMPw2SI7R9LRiHyjDVFKFGDbR5ysNQskLXZVvwb8UuAdYsrgWU
         H1vdt2X7JxinibG2aH7YZdoWLXz3jvaAdrCf0RN4IAYwUHk5w3JDJ1yjw9KLEtyPvTC2
         GNdAm/xREH4dLdZG6TM2k8qWeCDblAg8abuEiFW6HIwsemo8ZzGd8G0+j5Lc4iHC2sg5
         3YT73ct7QfYYH3Qd4ACvbSzbR3mxPYBvJt3fG8f47NkVLh+sxY/6OVMrCVLOxvjIkkda
         lgYT2OZHqzzW0eZ1sWDupRzZbc+Z0TP89QBexiyK4zQARuwjDd9Q+0k9ulrLtOdS81gD
         5g4A==
X-Gm-Message-State: AOAM5307Dy2w/SLVda022eZIzXiwro6k+ynsI5EvcD/7DEgnkIUUaZBD
        0bIFjXXxtnymqOkWJ9BdHxs=
X-Google-Smtp-Source: ABdhPJxFix6hOHLNyB7fo+uQHtTEJNFGP2SmB0UgZOCmb7owFDbYFkRfjOhMxf7rAu50gdXd1VpWdA==
X-Received: by 2002:a5d:5510:0:b0:203:f97c:f98 with SMTP id b16-20020a5d5510000000b00203f97c0f98mr11975301wrv.200.1647875866615;
        Mon, 21 Mar 2022 08:17:46 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id 10-20020a5d47aa000000b00204012e4373sm7239729wrb.101.2022.03.21.08.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 08:17:46 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 01/18] clk: introduce clk_hw_get_index_of_parent new API
Date:   Mon, 21 Mar 2022 15:48:08 +0100
Message-Id: <20220321144825.11736-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321144825.11736-1-ansuelsmth@gmail.com>
References: <20220321144825.11736-1-ansuelsmth@gmail.com>
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

