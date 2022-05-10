Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607E6520B3B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 04:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbiEJCdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 22:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbiEJCcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 22:32:43 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250371B5FA3
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 19:28:43 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id m1so5091541qkn.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 19:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KR84+H+bN0lQo4wWubc5nvH3kSUJYfq+QmRNV3y6a0k=;
        b=kg3DV5xvIdwvYnB14NNn+iQhe6oRv5KYGtp/uGfNnwIcUuEQOwRv6v/onYNXQ9Sd2v
         KdEFfE3V8nwxy/na6sSsFtDkU7IdIw14mjkawCvFJ9xUiYDd68MUKwlKBYL6BY4A7+Gt
         Sx76KKlsjVvMB1VpPr19zJ86eeXgUdZofordQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KR84+H+bN0lQo4wWubc5nvH3kSUJYfq+QmRNV3y6a0k=;
        b=B4fuoIDXh9j36RcJrfcBq8qXvnGIJz4VfjpyRM3ETLNNfwlVKkUhOuleJJcsTOkyyQ
         51FY6CN3Ii8EmLWseTRtpBqVaBRYG0CT7UjPsm0IlbqUITWjmNez6ghbrDsdBu4tR/cZ
         +ZlDKis9+GR7PFWugTaRYXVbjwyduM+QOqwMW+6yeTSFe4MT9J5w1GabME5m7monrs+5
         cmEUwp5llyZt20qPp1zot0vW5FcQuRREeaaWg08bMQ7zRCgVELF/E7LlS9EfTFUclRzY
         i6icPqDan3uTVxzshR7TpammhVqp96FdVRW2xto2dogn6fiKhvKEmMC6rYweaUIiWfXS
         gF1Q==
X-Gm-Message-State: AOAM530Y3LRW5pqQledyduDgbX0lVUbtOc6jAPOiPpwdIrMr2eF4ZB6e
        QugQ0iZLa0FM/H7LboHRmSvrMg==
X-Google-Smtp-Source: ABdhPJzsl0mRS8xiFI417lv8qxMM9KcSjMR34xbPd3Ea7e886h9IDUa9Cnp6DYeSvRK6lpcHhDRbvQ==
X-Received: by 2002:a37:745:0:b0:69f:c741:105d with SMTP id 66-20020a370745000000b0069fc741105dmr14074522qkh.774.1652149722733;
        Mon, 09 May 2022 19:28:42 -0700 (PDT)
Received: from grundler-glapstation.lan ([70.134.62.80])
        by smtp.gmail.com with ESMTPSA id 18-20020a05620a06d200b0069fc13ce213sm7742375qky.68.2022.05.09.19.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 19:28:42 -0700 (PDT)
From:   Grant Grundler <grundler@chromium.org>
To:     Igor Russkikh <irusskikh@marvell.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Aashay Shringarpure <aashay@google.com>,
        Yi Chou <yich@google.com>,
        Shervin Oloumi <enlightened@google.com>,
        Grant Grundler <grundler@chromium.org>
Subject: [PATCH 4/4] net: atlantic: verify hw_head_ lies within TX buffer ring
Date:   Mon,  9 May 2022 19:28:26 -0700
Message-Id: <20220510022826.2388423-5-grundler@chromium.org>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
In-Reply-To: <20220510022826.2388423-1-grundler@chromium.org>
References: <20220510022826.2388423-1-grundler@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bounds check hw_head index provided by NIC to verify it lies
within the TX buffer ring.

Reported-by: Aashay Shringarpure <aashay@google.com>
Reported-by: Yi Chou <yich@google.com>
Reported-by: Shervin Oloumi <enlightened@google.com>
Signed-off-by: Grant Grundler <grundler@chromium.org>
---
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
index d875ce3ec759..15ede7285fb5 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
@@ -889,6 +889,13 @@ int hw_atl_b0_hw_ring_tx_head_update(struct aq_hw_s *self,
 		err = -ENXIO;
 		goto err_exit;
 	}
+
+	/* Validate that the new hw_head_ is reasonable. */
+	if (hw_head_ >= ring->size) {
+		err = -ENXIO;
+		goto err_exit;
+	}
+
 	ring->hw_head = hw_head_;
 	err = aq_hw_err_from_flags(self);
 
-- 
2.36.0.512.ge40c2bad7a-goog

