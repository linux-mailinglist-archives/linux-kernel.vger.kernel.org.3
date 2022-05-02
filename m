Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6362A5177E5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387306AbiEBUXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387278AbiEBUXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:23:12 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B869DF15
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:19:41 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b19so20838844wrh.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 13:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gHQq/HbsAlHHV5dqqwIj84YLck22Yu9PAMCyZC7DDlg=;
        b=LhY6QwHdTM8sO/y2wOJB+t3eHiBsNzak+h83Hp4m1J1hvq8ai83m8COBHL6j7pk4++
         lUxqqs0i53dp7mv9Lwl9FGd6WdMFi+W2ao0Arx56y6kr8ZwBcqYVwkFvIZ1JM3zrVPx9
         NXgwPejXSwFqFXpyvn38xsn0QiDAYpQkc8+O/3q8Sf+Vg4LOzjQyppokaset9TCI9WXy
         99PTZiBAsrye6OPHbuW28pUBewwxLmxHAfdnIMUUWNiZOJPHoBD+9zdtMpPBy1wpge9D
         clJEPuF8TPSHJePDPmKXWasUEVE8i5rTDXSXSJeNTy3HG+tz3IgDe8BeZOaEf58D6AWm
         5BIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gHQq/HbsAlHHV5dqqwIj84YLck22Yu9PAMCyZC7DDlg=;
        b=zy8ZQPsDVTO3yK5wDREVSg6HpbxD06IYqHWMtSAdPqroeHKRf8wYHRlh6pSYCSZIIF
         EMlCKF4ngx0l+ky5kATdOTDS13PU9H7Btv6wRqZGDNGiBXSNVFBm20YCFLTTgMgAn4Wu
         68Zmt5fCqtVKrSMTB0jZuqcI/xtKhjwECgSUugQMf3Riru9ClMEvZxFjIS5iccp2KGtk
         z5HnhlILorplZoiA7hhRTwBC5xBh3Hls+VvsJWJveCaZ6dXXiqwBNs2/Hw8zsTDz4W/2
         QrKOYYphp6hTNJIyDVR/YBxNZzFi1CNc4496yM+WtoiE2HWdjvqMuwqyhly13X97DquZ
         jruA==
X-Gm-Message-State: AOAM5309ZY1In7XY54qG3g8nMTKIG1P4tM1GaPofHn2mIS/YJGUZDr3b
        gsQp5dyqhWSFK0XgDhcrLsTjse9fkKLpQA==
X-Google-Smtp-Source: ABdhPJyE44hLvQer5Bbx+kYLVwMvd9SshPAUhOsXy+EXdn+wzgYlCJsdPJrr9y/rc/y9ZXR2/xn2ow==
X-Received: by 2002:adf:d1c9:0:b0:203:c4f8:dd17 with SMTP id b9-20020adfd1c9000000b00203c4f8dd17mr10464782wrd.633.1651522779746;
        Mon, 02 May 2022 13:19:39 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id l2-20020adfb102000000b0020c547f75easm7238183wra.101.2022.05.02.13.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 13:19:39 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au, jernej.skrabec@gmail.com,
        samuel@sholland.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 00/19] crypto: allwinner: lots of fixes
Date:   Mon,  2 May 2022 20:19:10 +0000
Message-Id: <20220502201929.843194-1-clabbe@baylibre.com>
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

Change since v1:
- fixed endianess of hash_pad() paramaters

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
2.35.1

