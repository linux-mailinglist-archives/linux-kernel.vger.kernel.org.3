Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31AB48B744
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 20:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244192AbiAKTV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 14:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiAKTVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:21:55 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8629C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:21:54 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id i14so213193ioj.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jrCLIqtuYbgNVouuG5ORa+RN8I/f0awMF+AbmNAh2sk=;
        b=pSL5HZQewq/WzDPLOeto5UPBPzkn94wdZDYMp6RSz3Kq2GpL+nCeyddASBCwKcJCPi
         2c4GmU+Z3dtTZgrwOw6V7exesG7M7EBxumJpPADTlCpZjABBNkG1MaSpCeI3sl6K1tAF
         VYnFUunoe2DC7rzi7DiKrKBb8RCFKR+ndMQFgCoAitZYO1m4fFKbs+AgZQtYkRXL6qHC
         B3ZkA8gzEY4vrN3/t8OXYJytf5KcCebC4sm1bQkykTvwC0yL/BpVxtlSP7w5i7dw+H8N
         L0/X+tw50ia2e5x6eYy5SZKxHyFp9CVKJTh9r9XHUUH59qWdT0AHZX1suMG6xPK/mkty
         CZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jrCLIqtuYbgNVouuG5ORa+RN8I/f0awMF+AbmNAh2sk=;
        b=EGN3MPonr7sooiuLmj66dq+QvT/zsFBJT8TNh1QhYEkES/Zmfwc1f19qA7hWkd/vDT
         imjRdkGhPxHR8vT2M+Gl7Gks17tLsSBv2otz50RTnmO18kwg1L/KgR3iWjlVh1y8vjNk
         d97GlmopoqFkfbqZkJUZuHa+8ASis0wWijOycMIQ6vXtA10iIII40+eMPIJW4TFmAoPk
         Ka8AVYKzjgKGDLtA1Hkk0K0iOpdBdBpT7ZiWQb3JIWLPAevUNPK216fa6M9BPGvaOWLt
         DdOG9mEYGkrx9l8MbpRG2v24mtb+62iQFDf54VbIGTQyRNivokB+vrrZYzPKQ/MoDxxt
         3/XQ==
X-Gm-Message-State: AOAM531l0WW+wwVthjnwXQNl2ltIq+kSzLZKhYhTq2U9dtEgCIbmtG5Y
        BUPguMYdk8JItRXPs65MIlZ/5w==
X-Google-Smtp-Source: ABdhPJyXCYjzn51tldUZtmuYgDix5KVd3x4gm85mkWgmJtlp6p8R3UGyMprSM68WdtVEjftIEy+D7w==
X-Received: by 2002:a02:7f97:: with SMTP id r145mr2982013jac.319.1641928914209;
        Tue, 11 Jan 2022 11:21:54 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id e17sm6264544iow.30.2022.01.11.11.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 11:21:53 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     jponduru@codeaurora.org, avuyyuru@codeaurora.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        evgreen@chromium.org, elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] net: ipa: fix two replenish bugs
Date:   Tue, 11 Jan 2022 13:21:48 -0600
Message-Id: <20220111192150.379274-1-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains two fixes for bugs in the IPA receive buffer
replenishing code.  

					-Alex

Alex Elder (2):
  net: ipa: fix atomic update in ipa_endpoint_replenish()
  net: ipa: prevent concurrent replenish

 drivers/net/ipa/ipa_endpoint.c | 20 ++++++++++++++++----
 drivers/net/ipa/ipa_endpoint.h |  2 ++
 2 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.32.0

