Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13677520B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 04:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbiEJCcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 22:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbiEJCcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 22:32:43 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CCA1B54A0
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 19:28:42 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id p4so12640010qtq.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 19:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4EWw5JGDEHsMse3xSXgMpkF6wSSyJrohxFDmx4Uh7Y8=;
        b=SU4uW3pGecsbPcp0Kv09VMxlJlYHU5q6PWtTuzMCPY/ZfhDyY8oc/4TlbA+OEF5Qop
         jYot5V3KkZDNg0omlWj2/dOPS7t8ORwIXyq08+Vn+1YHQDQ62dCCCm4CwE/bijZofjl3
         1mi7+08Gi2drCbHG9Baktf2sAwbolyZMKRCpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4EWw5JGDEHsMse3xSXgMpkF6wSSyJrohxFDmx4Uh7Y8=;
        b=8I/lFUyMkpVkrGNrVrs38z+qh8oAivnpe3o2AUk5iGgYAZml5hXihPQ4owcr4l6wq/
         SAAr0EOGBb94nYa5pZFO0v7yWQATyxSVQlyzKyjhYaZQzYfqWkf49dOmfu1QTJYslpQ3
         JtL9oZBjV3LviGPdxc65GNWwMCQOdKU4ZPBoTurDdb+7StF3DIp3eFla/leqr1jqz79R
         NL7LKXzxQJ15/TH0ZudrXS7H9eL5sLXTW3+hWkGH5kIHkE3JB484TQcM2WvS0WmtWR0c
         ntkEG1bBNFrRxQT5r2x7FuBOeAiG3QkG8b6p1JAq/IqEuNlXGYlhnfh6rIlyMnvbKp87
         mfbQ==
X-Gm-Message-State: AOAM530ubB5EdZHmTGTV12+96Mv7ZYboX9C/7NZr4EdAuu6QQfy0c6HU
        /AiqItiVbqoFpF8sml9FlCNKJA==
X-Google-Smtp-Source: ABdhPJxarJEk/ID5VphXnrFWpgEyqqSeuMq9yhKZqIDkr+eRQakSbG0CkYNJ1HoDIjV6KF5zy6aFmA==
X-Received: by 2002:ac8:5e0c:0:b0:2f3:adfd:bd30 with SMTP id h12-20020ac85e0c000000b002f3adfdbd30mr17775658qtx.277.1652149721349;
        Mon, 09 May 2022 19:28:41 -0700 (PDT)
Received: from grundler-glapstation.lan ([70.134.62.80])
        by smtp.gmail.com with ESMTPSA id 18-20020a05620a06d200b0069fc13ce213sm7742375qky.68.2022.05.09.19.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 19:28:40 -0700 (PDT)
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
Subject: [PATCH 3/4] net: atlantic: add check for MAX_SKB_FRAGS
Date:   Mon,  9 May 2022 19:28:25 -0700
Message-Id: <20220510022826.2388423-4-grundler@chromium.org>
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

Enforce that the CPU can not get stuck in an infinite loop.

Reported-by: Aashay Shringarpure <aashay@google.com>
Reported-by: Yi Chou <yich@google.com>
Reported-by: Shervin Oloumi <enlightened@google.com>
Signed-off-by: Grant Grundler <grundler@chromium.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index bc1952131799..8201ce7adb77 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -363,6 +363,7 @@ int aq_ring_rx_clean(struct aq_ring_s *self,
 			continue;
 
 		if (!buff->is_eop) {
+			unsigned int frag_cnt = 0U;
 			buff_ = buff;
 			do {
 				bool is_rsc_completed = true;
@@ -371,6 +372,8 @@ int aq_ring_rx_clean(struct aq_ring_s *self,
 					err = -EIO;
 					goto err_exit;
 				}
+
+				frag_cnt++;
 				next_ = buff_->next,
 				buff_ = &self->buff_ring[next_];
 				is_rsc_completed =
@@ -378,7 +381,8 @@ int aq_ring_rx_clean(struct aq_ring_s *self,
 							    next_,
 							    self->hw_head);
 
-				if (unlikely(!is_rsc_completed)) {
+				if (unlikely(!is_rsc_completed) ||
+						frag_cnt > MAX_SKB_FRAGS) {
 					err = 0;
 					goto err_exit;
 				}
-- 
2.36.0.512.ge40c2bad7a-goog

