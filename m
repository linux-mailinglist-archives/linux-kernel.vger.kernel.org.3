Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450804DCFB4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiCQU5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiCQU5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:57:32 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF08A154055
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:56:12 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id p9so8981795wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xxLigyYubLEfmpzYjesUYMDr681KbgpjvGFg62V3uuo=;
        b=q43mTTbnckKvjJEG6SpmkOL75jCyN+O53AbqkF2sH5XMTWnKY3PtwkqyaFIEcLXBim
         3a5P9Yat03SsVCxysdY+Vius+9jF0kAGvK2I/n8oARjFd3FY/RlfrpMJhteTpo/lMTsb
         Mn0St1xk/mewvcj3k7LJsveBJuz9x+Y2D+9NDvVegPO0tuByXsWqKUec8lQof/z9+E6n
         hrEjrRVUcIeUQ6ZtwLDDoFLlisG/7IFWts55uGoEIvY/8CKvEv4ZJZvPu0PniNQhSGRp
         uPLSb+EBMMR8u5Q3XBqaRUKhL0Y5QN/kudoZl5PEJWeEJC/l+kGAbUjl52UsF3pgIr0+
         Lmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xxLigyYubLEfmpzYjesUYMDr681KbgpjvGFg62V3uuo=;
        b=W1bj6ZsRVzjAR9CmFX4GOlgNFbAzNQjP1EiuTjND7iScciQ9CVqdFA+rigbTT9aZF/
         2GGZnHGNOG6ljNmRQDcuXai065VhH//xc728C/jrfsQJFmsoUDPG81B0i7GvYyrGP9lj
         9PIR8Uu0/tQsvTN8WIZgWiMeFC7QNm3+VBRsq4DmNd4PrBnAEFtxXoexcTLSO40p2Xgk
         kbCjiPnMg8hk7GYrMdDkZRdAAI6HHlz1t2/uRkWoMPOHCPWOnsXv9VzPtJoGbMltUPm4
         1CeG0vQycHvBQ+r1KZR6oL6JWq+xxTcXlRwaVFoN/lWjSRECWqknM1Q04PASFSaN2e7E
         qE6Q==
X-Gm-Message-State: AOAM5327Sh7jAAhZ0WUWM3VX6yH4bL1PtAcg7HXuSrWC/nSTaaEx3l6A
        8DwBLNc8y1fXAzzN+YyX8OuLrg==
X-Google-Smtp-Source: ABdhPJwnwLdUdvOyaa98IK90oH6uDYzGms32CnUFdkUB2BE7Anl0fygB88gDwIBMvxdSPZP7d0z/vQ==
X-Received: by 2002:adf:9581:0:b0:1ed:c341:4ed1 with SMTP id p1-20020adf9581000000b001edc3414ed1mr5616024wrp.299.1647550571570;
        Thu, 17 Mar 2022 13:56:11 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id r4-20020a05600c35c400b00389f368cf1esm3695424wmq.40.2022.03.17.13.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 13:56:11 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au, jernej.skrabec@gmail.com,
        samuel@sholland.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 00/19] crypto: allwinner: lots of fixes
Date:   Thu, 17 Mar 2022 20:55:46 +0000
Message-Id: <20220317205605.3924836-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This series is all fixes which I found on allwinner crypto drivers.

Regards

Corentin Labbe (19):
  crypto: sun8i-ce: Fix minor style issue
  crypto: sun8i-ce: do not allocate memory when handling requests
  crypto: sun4i-ss: do not allocate backup IV on requests
  crypto: sun8i-ss: rework handling of IV
  crypto: sun8i-ss: handle zero sized sg
  crypto: sun8i-ss: remove redundant test
  crypto: sun8i-ss: test error before assigning
  crypto: sun8i-ss: use sg_nents_for_len
  crypto: sun8i-ss: do not allocate memory when handling hash requests
  crypto: sun8i-ss: do not zeroize all pad
  crypto: sun8i-ss: handle requests if last block is not modulo 64
  crypto: sun8i-ss: rework debugging
  crypto: sun8i-ss: Add function for handling hash padding
  crypto: sun8i-ss: add hmac(sha1)
  crypto: sun8i-ss: do not fallback if cryptlen is less than sg length
  crypto: sun8i-ce: Add function for handling hash padding
  crypto: sun8i-ce: use sg_nents_for_len
  crypto: sun8i-ce: rework debugging
  crypto: sun8i-ce: do not fallback if cryptlen is less than sg length

 .../allwinner/sun4i-ss/sun4i-ss-cipher.c      |  22 +-
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h  |   1 +
 .../allwinner/sun8i-ce/sun8i-ce-cipher.c      | 102 +++--
 .../crypto/allwinner/sun8i-ce/sun8i-ce-core.c |  54 ++-
 .../crypto/allwinner/sun8i-ce/sun8i-ce-hash.c | 130 ++++--
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  |  19 +-
 .../allwinner/sun8i-ss/sun8i-ss-cipher.c      | 180 +++++---
 .../crypto/allwinner/sun8i-ss/sun8i-ss-core.c |  92 ++++-
 .../crypto/allwinner/sun8i-ss/sun8i-ss-hash.c | 385 +++++++++++++++---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h  |  33 +-
 10 files changed, 767 insertions(+), 251 deletions(-)

-- 
2.34.1

