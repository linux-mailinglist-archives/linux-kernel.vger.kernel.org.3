Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0050F530027
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 03:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348298AbiEVBAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 21:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348205AbiEVBAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 21:00:07 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F3639BB3
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 18:00:05 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id l15so7737505ilh.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 18:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QKpWuvor5353AGWAKQRnBlR2jwT4S//yqIRK+fSNZWk=;
        b=eyiXHhFYeqlKXBdEh0qZtBEceIQlGhwQFov7FtZTiamgX4c3N7rmeqDJ9VjjaQtcNS
         UsYBS2WvXFrpb7ifKEUHr8BhglhyRzrp17SD1cUQiem9ZSKkM/hQ3hjsyApUsgytXxWT
         xAAt/BXM2fyEtjDzZ5If03IUIriSFgtRQHzX9Tuds5Sr/UgaKdXTUuEMO7d/TrWXkS93
         //pZz/QvJ55CSamp4sg6GIIva5/V21UsDVGu4y/Rv/1j/R/FK2694qhebPpW2cjaBt23
         lInvLJVjlcR+cbD0fyLYlwg7jKEMM32J3NXZ3uGTg5joSq3GOJtEwF8r7ISQMV5238bY
         BXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QKpWuvor5353AGWAKQRnBlR2jwT4S//yqIRK+fSNZWk=;
        b=r6sKCNTe/cQlV9TvVvbU4fEV2Ygbv3tRL63L2O2UtqvhxGSA1rzYZd4rqbJzQF/ij5
         Ke3xWLBxvF6mFeJueBYJielUvIJ+S5E2sfrP6PawTrGTggytLg8zaf2UhF4R01EWz5UZ
         5mx69dxqucAMqDJPPXHZmoM8FkZEpHcpedln0BT0ig6I6Y15T8pXk4qQLmsU5A9WWRVe
         HpM2MnZ+O6GJyYBWX3+bMyMjzuzEASS/MPlSJV0r1kov7yH0ULFpbzDlXxfZo08vA+ie
         LS3jpweb7WkOW5KHdjLEPvV/Y8oMdkwcrohBgL72h92GVz3p7LjDiF0+GRkX8Fpg+FOh
         hnJA==
X-Gm-Message-State: AOAM532E8nFIGE5VdLL/uyO5+d9zqBUYPVmrGfdRwStslnhZBiXoDSdE
        2H5EUneFq4cb8NIb9ACbzUxHkQ==
X-Google-Smtp-Source: ABdhPJzwsgBwQcxz++V/OfI8ibnzh7s5eOX43rN63fw+IctTZ0dplBW5LczJi9V5LxIbdvlQFfNS6w==
X-Received: by 2002:a92:bf06:0:b0:2c9:b21d:6db7 with SMTP id z6-20020a92bf06000000b002c9b21d6db7mr8205967ilh.222.1653181204506;
        Sat, 21 May 2022 18:00:04 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id t21-20020a02c495000000b0032eacab7e07sm939366jam.93.2022.05.21.18.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 18:00:04 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] net: ipa: fix page free in ipa_endpoint_trans_release()
Date:   Sat, 21 May 2022 19:59:58 -0500
Message-Id: <20220522005959.1175181-2-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220522005959.1175181-1-elder@linaro.org>
References: <20220522005959.1175181-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the (possibly compound) page used for receive buffers are
freed using __free_pages().  But according to this comment above the
definition of that function, that's wrong:
    If you want to use the page's reference count to decide when
    to free the allocation, you should allocate a compound page,
    and use put_page() instead of __free_pages().

Convert the call to __free_pages() in ipa_endpoint_trans_release()
to use put_page() instead.

Fixes: ed23f02680caa ("net: ipa: define per-endpoint receive buffer size")
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 0f489723689c5..675b7135644b8 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -1385,11 +1385,8 @@ void ipa_endpoint_trans_release(struct ipa_endpoint *endpoint,
 	} else {
 		struct page *page = trans->data;
 
-		if (page) {
-			u32 buffer_size = endpoint->config.rx.buffer_size;
-
-			__free_pages(page, get_order(buffer_size));
-		}
+		if (page)
+			put_page(page);
 	}
 }
 
-- 
2.32.0

