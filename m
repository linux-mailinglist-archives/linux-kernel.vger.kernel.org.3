Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204A049D404
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 22:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiAZVEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 16:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiAZVEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 16:04:51 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADD1C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:04:50 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id d138-20020a1c1d90000000b0034e043aaac7so1969445wmd.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DMvBRIpA0/pHSEkKz7ZQmVefisxCnIB7c3bp5JfnGsI=;
        b=L57gwERWThKBhvaTL9wZxDoT9Uhvyw8ANdyTtCWnAuSsuaNszVO/1RbEqab0HZfJ2c
         wS6kqxR/hfcodFA4B62COohudajaOF5MxYXGJUz2u7iJw0JgJ0Fum4LqCbox1EUwHp0Y
         1gYvm+qONdkKKp8cUdKq4f8O6PMhVNucnlCk+ojbLATN0YrFYEqyHFpF/uUvgb1k1kBu
         RIj4UPWfiGVL2MdCALyXFcUjY5Qljo8afk10M7vuGP7xGggLVS2ugt1RsZtbQS0+Os5n
         21788Z6ANCX263OseF9RFedtWrRq2dys6NRUDdxZEVpbzkKc8q+lDL00GEIVstWyhUAM
         lisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DMvBRIpA0/pHSEkKz7ZQmVefisxCnIB7c3bp5JfnGsI=;
        b=V/BIxIe+WY5knMewI7oroIypRUQMRxtO4TqQ6Oi8EeWcsgRFJ+xstKMo04xeOp+MYj
         zASXXz4zU3s4eYhvdnSOlkLZsivLlnInet/y1T3JkXc4u30YhW2zVfvKb8lZY5wHbJ80
         jaXG5NgXQ0u6yvdLKCxXSJxUrvz0PZW4XUEvkGrrfSBzyzD9FHBecTf6vy3UvY2CweIg
         W8+j/dikLc5WKrIOWVunxMMOAc+TaE4h/a9K+hBXf1wn29FuW73CCDIXJ1M0qiI8uWdg
         ebA8/CZRSRgrwKAExeAxjp0hXTWCQoR+LvI2VwLkUPYZ+LRhwYlRw1T0d9O5ljrqm5Ir
         Q4Dw==
X-Gm-Message-State: AOAM532Q6jgMcXqbqavnpFouySS733/cS8GZf5Xkpr5NQP6/74/t6wf5
        qJzN5KMYYfUDr3VmaU1N0V0zGg==
X-Google-Smtp-Source: ABdhPJxxTiJUsakyD/bKlH9lLMOR6zqVufOIQclFGT9QW+h9m5/4JkNUq6391sN7S8QoXfZJZGsH6A==
X-Received: by 2002:a05:600c:350e:: with SMTP id h14mr448174wmq.166.1643231089360;
        Wed, 26 Jan 2022 13:04:49 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j19sm4948611wmq.17.2022.01.26.13.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 13:04:48 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        jernej.skrabec@gmail.com, mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-sunxi@googlegroups.com, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 0/8] crypto: allwinner: various improvments
Date:   Wed, 26 Jan 2022 21:04:33 +0000
Message-Id: <20220126210441.3661782-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

The main topic was to remove memory allocation from requests function.
Doing this on sun8i-ss, lead to some extra fixes to be found.

Regards

Corentin Labbe (8):
  crypto: sun8i-ce: do not allocate memory when handling requests
  crypto: sun4i-ss: do not allocate backup IV on requests
  crypto: sun8i-ss: handle zero sized sg
  crypto: sun8i-ss: do not allocate memory when handling hash requests
  crypto: sun8i-ss: do not zeroize all pad
  crypto: sun8i-ss: remove redundant test
  crypto: sun8i-ss: test error before assigning
  crypto: sun8i-ss: handle requests if last block is not modulo 64

 .../allwinner/sun4i-ss/sun4i-ss-cipher.c      | 22 ++---
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h  |  1 +
 .../allwinner/sun8i-ce/sun8i-ce-cipher.c      | 28 ++-----
 .../crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 20 ++++-
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  |  8 +-
 .../crypto/allwinner/sun8i-ss/sun8i-ss-core.c | 10 +++
 .../crypto/allwinner/sun8i-ss/sun8i-ss-hash.c | 84 ++++++++++---------
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h  |  6 ++
 8 files changed, 100 insertions(+), 79 deletions(-)

-- 
2.34.1

