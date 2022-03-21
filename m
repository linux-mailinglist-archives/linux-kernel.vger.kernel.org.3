Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7CC4E2D3C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350686AbiCUQJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350653AbiCUQJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:09:44 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB8125283;
        Mon, 21 Mar 2022 09:08:18 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n35so7232212wms.5;
        Mon, 21 Mar 2022 09:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oYnAnrWU13qc8rQ7MPOxKFwqoXsKN+1WmTS68IkDyt4=;
        b=U4m+zDn0GTX0mHwwqebuxJ0M5yHycuBxla1Ij/IkSns436XbVHpzO/tD1qSFT1EUHe
         4CniCwgSqdJZ0CKwNnAZkgNeHlPJB+6xd25ktJ7Vvy7JXcKmNNcr40d7lg0EZ5A6NGfy
         NQZvQlhC9fovzdDqD3EX3T5sNa8zTpjMrk0D6+U5qG6Lg+udHIGNWB/ivzDpiXyhSKDe
         J9CbxKf5VTnGv5t7BqhkNjuKRxRsOv4V2LsTzbxIP3WbMQ7zyTvJul5RCDZv/8I6DSM2
         jqL0PNoGLClUDQJrvPWR881YN4xR42oyfp3lH7PlBdJCC6F4P/Hedz0ErRhoDEI216Rc
         S4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oYnAnrWU13qc8rQ7MPOxKFwqoXsKN+1WmTS68IkDyt4=;
        b=xaVDHa8AFB8v3COJEYS3fRBLkeMElk+V+0HFYylESpV+sMQbUM/bBrVjeE66wI9Z5s
         60bnHhxjol9HnnzUFdxyXBHQi9fTWNeYPJxhFPAtNcr02X0+B0UpZYRl1aRVNYtUPzLt
         VOQiaeJFisMy4tPVxNe9AiAJqcmMfOdbN4qMTm+ty6P1CgsvMZi4VmCQfvRGLk3XkIzz
         onVh2/UsIvfZuf0rf9Qv7fK2+o+GWATxLmW9aK2LnaLhw8SVV2fV5Ev2Da27eHzbY7pT
         J3J5fXM05CSZh5CoZdNb1/ra7e23YVCq6lV6LQ26xIYBFGdE1B7mtwG8ncYS1BwkcAGk
         akiQ==
X-Gm-Message-State: AOAM531nMYuiyxC34zGUDQt4uf0zYjshQLyuK3r8I4T3FzsSk7WqOQoZ
        92hHniPj1S4TByi4wcwkH4I=
X-Google-Smtp-Source: ABdhPJwf6q/ji2LpZQxcWUGLZjMQmKqUcqRq5So17hNmqC9FvBC10Z2s+FJKuosbJSHGxSJyW/0DUA==
X-Received: by 2002:a05:600c:1d9f:b0:389:a1c4:f400 with SMTP id p31-20020a05600c1d9f00b00389a1c4f400mr27615563wms.171.1647878896550;
        Mon, 21 Mar 2022 09:08:16 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id az19-20020a05600c601300b0038cadf3aa69sm2603864wmb.36.2022.03.21.09.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 09:08:16 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 01/18] clk: introduce clk_hw_get_index_of_parent new API
Date:   Mon, 21 Mar 2022 16:38:38 +0100
Message-Id: <20220321153855.12082-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321153855.12082-1-ansuelsmth@gmail.com>
References: <20220321153855.12082-1-ansuelsmth@gmail.com>
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

