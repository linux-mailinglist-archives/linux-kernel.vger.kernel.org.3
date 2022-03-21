Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECE54E34CF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiCUXqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiCUXqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:46:40 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB96814A1;
        Mon, 21 Mar 2022 16:45:14 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q8so11398420wrc.0;
        Mon, 21 Mar 2022 16:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oYnAnrWU13qc8rQ7MPOxKFwqoXsKN+1WmTS68IkDyt4=;
        b=nfnXXrJNDBHu6L3/3fnL54OTuTY/TOoyupK/y0ERfHUB5ubPg+IHTueg23BCOcpUJA
         MQlYbLnrR24YvkzaCAvJhMT6PnmyVSUOyP4xBQQAgxD6SDZ1JVYkqi3nK/QzbCYGRl07
         IEXAqkQ0rtbFma5UBKPuK42mtYHscR+oMx3jX2v0GMuVF+chm3lHgjZ3OzFCDiqPIGiZ
         XNJrKS3R5ttsAH7CK/jJJdg7vWCmDnnYTEgXcyzojtXpTxzjYRMtOhXBAfP58gOHGu4s
         37YSgTJURd+g5Yn//AvkAdHDxy2e14ZN6ll8LkuXCvFjFlgqwTsLUS9psAz0rQOSZUw4
         NjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oYnAnrWU13qc8rQ7MPOxKFwqoXsKN+1WmTS68IkDyt4=;
        b=4p/6zB/fZQRLtN7rCaAfn1tOIeMzHb3oLyU0W/RwvPHxgufJYnc208GQHTRCIgMgdA
         u6nnY+Cibn71XkencMqftlalJyTf+evDP3SfjeDJN8NaRgepL0bywb3N6l4yUNyCdDoA
         75IAUoNgtOmIvOmpFB3WpbJM7Q0stVVCjlvr19Pzde1AjdADwWnrSBGODymbP/lRBLR6
         NpeNZKX0oXHAC9y5qsI3vLRoCwG07wo7v6lpjGfurHi6jZaClaW2OCWJ9jD89dDQogSg
         QEbU4TaE53me5bxtikLCk4WOlUXaMbz+lvqkNFJMq3SZVk68kDHixDUuLa5adItfJnJc
         TDXw==
X-Gm-Message-State: AOAM533IHooV10K1imH0avxjQAcKLfr/FxfLr/UqJ1GQY22dP2yECGi4
        tc5Jt3QNuAZrO38QQ2YMhHNh6EkOnqE=
X-Google-Smtp-Source: ABdhPJz6fFRCSWvddMgG1C1fG5SdUZrT01T7lf/GjbY9YYA8kELNPFzSv3x9irwbdz+4n77HV4Tk8Q==
X-Received: by 2002:a5d:64c2:0:b0:203:951c:17f2 with SMTP id f2-20020a5d64c2000000b00203951c17f2mr20466856wri.518.1647906312892;
        Mon, 21 Mar 2022 16:45:12 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id n10-20020a5d588a000000b002052e4aaf89sm105497wrf.80.2022.03.21.16.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 16:45:12 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v6 01/18] clk: introduce clk_hw_get_index_of_parent new API
Date:   Tue, 22 Mar 2022 00:15:31 +0100
Message-Id: <20220321231548.14276-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321231548.14276-1-ansuelsmth@gmail.com>
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
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

