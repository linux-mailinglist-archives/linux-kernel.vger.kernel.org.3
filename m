Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90D752F37C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238480AbiETS41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353103AbiETSzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:55:54 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C28D104
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:55:43 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id a4so1683872ilr.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uoOxtouvB2bKJ6UVCiMo5Cjkg2ZKrup85zpIf1aDzB0=;
        b=e6Ryj7Zq+U3wpBHXDap84P4ZvYpT25PESVB+ckcxbP74nbMKo57QfygxXO/yHpPO8e
         uOtWnwM4TXYGHrGlmpUjeFpwAlDpkHJzs8dpIekI9p2s0d90tZDE4FIl4SR3BkKsuXqU
         nYTYR89GwrK6FulFl5K1IuzEOmISeXfZnibulWgmNb3yNc/9w8hyfcjMG1PlRt2vlwhV
         bM50/9C5qQDLMxnitjvIOf5m/bQ0a+aLH37m0tWgCsYZxEQdk6ennfynRnESgPLBcvf5
         JxMUQQKOeq5CEAuOc/Wm1Kiw07e9WWIBoWBPH5g77XkjEqV7SRb318lWY0Vv9i/gAxUG
         YIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uoOxtouvB2bKJ6UVCiMo5Cjkg2ZKrup85zpIf1aDzB0=;
        b=lC+xt/d9xWOkL/EQ2ZxWs1K+vIZJy6jxPM5NGX7Xh8S1YqHvXjQEpqpgv0mmo7jH18
         yG575/oVGmnzz2iu0Eg3qgMd2IW5Hazd8T+Acw174YHEUynMMnD2oMmuhQGji29R3B4w
         3qJqWEydfQcb8n/3V7fvA5zTLeV8dgim456W9REtsrC+TTzfjWz8JgQWET9Y1fjh9gtq
         iVVoXu8V05d1w4vMI7r8TQhXRUrCwWQJOo/3cXSKjjaIJn6IQBgKc7n28gIKHYjqPdDx
         daXeSSG8lvK/3K1Ycxv+IVSR/0X1/QOXKywo37GhjJd8vzJmN9uf7Uj3ANQjoIX+hLpJ
         lsGw==
X-Gm-Message-State: AOAM532HnQ9r+A/AJ4G3z2nHnqlblu+IuhMr0+dP0utDDlwTv3kCKccm
        yjPl9Ck7voFE9IaNnCR7rJXO4A==
X-Google-Smtp-Source: ABdhPJxeYYviCHcahevr5mjCfmLcKP4GJXMMv54IZHq8Xbvi5lH3+cx/g0o6T3d/qNDfCSv9uYiLuQ==
X-Received: by 2002:a05:6e02:1585:b0:2c2:5b2c:e3e5 with SMTP id m5-20020a056e02158500b002c25b2ce3e5mr672221ilu.76.1653072942617;
        Fri, 20 May 2022 11:55:42 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id a6-20020a056638058600b0032b3a7817acsm871958jar.112.2022.05.20.11.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:55:42 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/8] net: ipa: kill gsi_trans_commit_wait_timeout()
Date:   Fri, 20 May 2022 13:55:29 -0500
Message-Id: <20220520185533.877920-5-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220520185533.877920-1-elder@linaro.org>
References: <20220520185533.877920-1-elder@linaro.org>
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

Since the beginning gsi_trans_commit_wait_timeout() has existed to
provide a way to allow waiting a limited time for a transaction
to complete.  But that function has never been used.

In fact, there is no use for this function, because a transaction
committed to hardware should *always* complete.  The only reason it
might not complete is if there were a hardware failure, or perhaps a
system configuration error.

Furthermore, if a timeout ever did occur, the IPA hardware would be
in an indeterminate state, from which there is no recovery.  It
would require some sort of complete IPA reset, and would require the
participation of the modem, and at this time there is no such
sequence defined.

So get rid of the definition of gsi_trans_commit_wait_timeout(), and
update a few comments accordingly.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi_trans.c    | 22 ----------------------
 drivers/net/ipa/gsi_trans.h    |  9 ---------
 drivers/net/ipa/ipa_cmd.c      | 15 +++++++--------
 drivers/net/ipa/ipa_endpoint.c |  1 -
 4 files changed, 7 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ipa/gsi_trans.c b/drivers/net/ipa/gsi_trans.c
index 87e1d43c118c1..bf31ef3d56adc 100644
--- a/drivers/net/ipa/gsi_trans.c
+++ b/drivers/net/ipa/gsi_trans.c
@@ -637,28 +637,6 @@ void gsi_trans_commit_wait(struct gsi_trans *trans)
 	gsi_trans_free(trans);
 }
 
-/* Commit a GSI transaction and wait for it to complete, with timeout */
-int gsi_trans_commit_wait_timeout(struct gsi_trans *trans,
-				  unsigned long timeout)
-{
-	unsigned long timeout_jiffies = msecs_to_jiffies(timeout);
-	unsigned long remaining = 1;	/* In case of empty transaction */
-
-	if (!trans->used)
-		goto out_trans_free;
-
-	refcount_inc(&trans->refcount);
-
-	__gsi_trans_commit(trans, true);
-
-	remaining = wait_for_completion_timeout(&trans->completion,
-						timeout_jiffies);
-out_trans_free:
-	gsi_trans_free(trans);
-
-	return remaining ? 0 : -ETIMEDOUT;
-}
-
 /* Process the completion of a transaction; called while polling */
 void gsi_trans_complete(struct gsi_trans *trans)
 {
diff --git a/drivers/net/ipa/gsi_trans.h b/drivers/net/ipa/gsi_trans.h
index af379b49299ee..387ea50dd039e 100644
--- a/drivers/net/ipa/gsi_trans.h
+++ b/drivers/net/ipa/gsi_trans.h
@@ -205,15 +205,6 @@ void gsi_trans_commit(struct gsi_trans *trans, bool ring_db);
  */
 void gsi_trans_commit_wait(struct gsi_trans *trans);
 
-/**
- * gsi_trans_commit_wait_timeout() - Commit a GSI transaction and wait for
- *				     it to complete, with timeout
- * @trans:	Transaction to commit
- * @timeout:	Timeout period (in milliseconds)
- */
-int gsi_trans_commit_wait_timeout(struct gsi_trans *trans,
-				  unsigned long timeout);
-
 /**
  * gsi_trans_read_byte() - Issue a single byte read TRE on a channel
  * @gsi:	GSI pointer
diff --git a/drivers/net/ipa/ipa_cmd.c b/drivers/net/ipa/ipa_cmd.c
index d57472ea077f2..77b84cea6e68f 100644
--- a/drivers/net/ipa/ipa_cmd.c
+++ b/drivers/net/ipa/ipa_cmd.c
@@ -26,14 +26,13 @@
  * other than data transfer to another endpoint.
  *
  * Immediate commands are represented by GSI transactions just like other
- * transfer requests, represented by a single GSI TRE.  Each immediate
- * command has a well-defined format, having a payload of a known length.
- * This allows the transfer element's length field to be used to hold an
- * immediate command's opcode.  The payload for a command resides in DRAM
- * and is described by a single scatterlist entry in its transaction.
- * Commands do not require a transaction completion callback.  To commit
- * an immediate command transaction, either gsi_trans_commit_wait() or
- * gsi_trans_commit_wait_timeout() is used.
+ * transfer requests, and use a single GSI TRE.  Each immediate command
+ * has a well-defined format, having a payload of a known length.  This
+ * allows the transfer element's length field to be used to hold an
+ * immediate command's opcode.  The payload for a command resides in AP
+ * memory and is described by a single scatterlist entry in its transaction.
+ * Commands do not require a transaction completion callback, and are
+ * (currently) always issued using gsi_trans_commit_wait().
  */
 
 /* Some commands can wait until indicated pipeline stages are clear */
diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 586529511cf6b..5ed5b8fd3ea36 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -478,7 +478,6 @@ int ipa_endpoint_modem_exception_reset_all(struct ipa *ipa)
 
 	ipa_cmd_pipeline_clear_add(trans);
 
-	/* XXX This should have a 1 second timeout */
 	gsi_trans_commit_wait(trans);
 
 	ipa_cmd_pipeline_clear_wait(ipa);
-- 
2.32.0

