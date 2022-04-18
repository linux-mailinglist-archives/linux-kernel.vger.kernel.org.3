Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75535506025
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 01:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbiDRXUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 19:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbiDRXUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 19:20:42 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E77823BD1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:18:01 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id d19so4453497qko.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uzTGDQP0f95uJjkIzcCv5mUHYF5rmou/7UB+HwmJESo=;
        b=LnzjpeDIks5TxNNm0jxFG63+BZztr6COd+ExcQMvzsOqsM2haLamtMZKk1rooCKegZ
         w8gBU/C1SS8idFiRcEUjcNBkHGFgTft3LgIZVsVd9IbJQSPzZGwR2f603crEAbL8kW/J
         8b25ke05TK3yGUKeqeKEO2VSaHD7XesZa1wMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uzTGDQP0f95uJjkIzcCv5mUHYF5rmou/7UB+HwmJESo=;
        b=JHamgZ7YRleSZqSDvlDnwDp0+Y8AWMBQjxOQ9NQPCSDx02ap+nPyTWnYwzlg/yn2kP
         W8fVSKQfSOWnpsiNecl7Xv3I/4Js6TxzREm637B8MuXAO/EZfaE+eCisy1QMTmsRWF9b
         tizu1ryHxNIjbTLVclx0KhUtKtDH1ETJwgK/iyUYLwVc4U/IbQS4HxQohJ4+H0mISdvV
         iwm9hvK5lZGhmbdPRWrFrF3wrJPPZsnzv0DrxLuPYkvUtav35O+nnl1U/0JmKzh3mORt
         iviiWzJgNRPu4tZCTfFaHMlUCnclVBOOwgX3gzOPsCu79RefMYykrVa4k73CnGFThuhA
         fURA==
X-Gm-Message-State: AOAM530QsBSuxDKiQ+AzkHjIQw1pikYxrVXFJgMLIg60dV9Y5KI4p65Y
        Nqxd7mGSgo5o5iIS6RdSRHWtVA==
X-Google-Smtp-Source: ABdhPJxsj1wrb92DBhSr8MmPgWD1TRSXaztHAb6okgzlnASHT8TV/adbzOw2yNkVM0aCjPWfsKYqqg==
X-Received: by 2002:a05:620a:1724:b0:69e:883a:85b6 with SMTP id az36-20020a05620a172400b0069e883a85b6mr6297843qkb.247.1650323880498;
        Mon, 18 Apr 2022 16:18:00 -0700 (PDT)
Received: from grundler-glapstation.lan ([70.134.62.80])
        by smtp.gmail.com with ESMTPSA id a1-20020a05622a02c100b002f17cba4930sm8214048qtx.85.2022.04.18.16.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 16:18:00 -0700 (PDT)
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
Subject: [PATCH 1/5] net: atlantic: limit buff_ring index value
Date:   Mon, 18 Apr 2022 16:17:42 -0700
Message-Id: <20220418231746.2464800-2-grundler@chromium.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220418231746.2464800-1-grundler@chromium.org>
References: <20220418231746.2464800-1-grundler@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

buff->next is pulled from data DMA'd by the NIC and later used
to index into the buff_ring[] array. Verify the index is within
the size of the array.

Reported-by: Aashay Shringarpure <aashay@google.com>
Reported-by: Yi Chou <yich@google.com>
Reported-by: Shervin Oloumi <enlightened@google.com>
Signed-off-by: Grant Grundler <grundler@chromium.org>
---
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
index d875ce3ec759..e72b9d86f6ad 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
@@ -981,7 +981,9 @@ int hw_atl_b0_hw_ring_rx_receive(struct aq_hw_s *self, struct aq_ring_s *ring)
 
 			if (buff->is_lro) {
 				/* LRO */
-				buff->next = rxd_wb->next_desc_ptr;
+				buff->next =
+					(rxd_wb->next_desc_ptr < ring->size) ?
+					rxd_wb->next_desc_ptr : 0U;
 				++ring->stats.rx.lro_packets;
 			} else {
 				/* jumbo */
-- 
2.36.0.rc0.470.gd361397f0d-goog

