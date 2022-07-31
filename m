Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F2958614B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 22:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238285AbiGaUWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 16:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiGaUWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 16:22:09 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1C06409;
        Sun, 31 Jul 2022 13:22:08 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gk3so4829114ejb.8;
        Sun, 31 Jul 2022 13:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yr5+q+JM3o8tON+G+gzSojqkXnczjKV/yjxOMb4VBNI=;
        b=h83uGoEOuDmb3wllOMQgY6tMMEQBajwbi2mDKq75Idp0jFfkXaMA/jZeJH5pmgPeoX
         uzybojeMG1KTgMET2iKYLHJMOfO1IYHUZWi8kyI/QH9BbpVg9C5lwJTueHPLPqdONtvv
         1gEW/H+r9IZ2fypRU7yrFhRTdn8GCAL5f7rLCud37BsBEJ0jqXMP7njpHk0LKHvIGXsU
         y/qJyRZTniyFIydQBEXuY1NjoxbAlNDJYyBj+BxaTvXgYbdebKuxFZrnFwqRLRtYvEev
         c2lw0XjkRQQNH1RcPiontoahj/K3U66HMCslsxO0/8EB/G2Wz0tinVjHm2eMDzMH4ZW0
         AXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yr5+q+JM3o8tON+G+gzSojqkXnczjKV/yjxOMb4VBNI=;
        b=kelfOrJrGcwgJtJu2XcPOJCfY6Z8HaK9X7nRLE1irau4WoNalsgbTc57SxoVyAnXmV
         rXbMAzMANAgmhTHR5y7WPktXuOp6IjmkCl3iBZyIgn947hNWX+/Hioh85182yZ8fcYES
         NhNwRDiOXVG+Dygm3+o2NwUbZPX+pTZaTublX0EZdICxupxEbtDEuBHj/6JlTX3WrnlR
         yDbzarX9A3xpOxkVQ2woiFIXlIL3jv/vbwuSHqJnqFmwPCXt8wqRpVwwiTCzc9hhYB72
         5VdNqv5UZpMJrJpNVC9jogD0FPgMhqN7rJXm+lYZjeAcQ45XfV/fwZl2GQFjZ/pHKsyD
         U1aw==
X-Gm-Message-State: ACgBeo2OkQQNk34pLionlsCnTvV82mKnfKAREmukpzgeDnvQ+2wck/xQ
        iTPBMJ0HYXOzDTr090RDgj/q8MbS/C8=
X-Google-Smtp-Source: AGRyM1tzSqwxup0zNjeSWFcxKlgoqhuBqlx0kzDJYV8AFThavBynMJ+59pTRou2Vj4eym/WE8Rw7Dw==
X-Received: by 2002:a17:907:b04:b0:730:4bee:5171 with SMTP id h4-20020a1709070b0400b007304bee5171mr5723794ejl.199.1659298927037;
        Sun, 31 Jul 2022 13:22:07 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-115-050-116.95.115.pool.telefonica.de. [95.115.50.116])
        by smtp.googlemail.com with ESMTPSA id q23-20020aa7cc17000000b0043d0955d546sm4978629edt.69.2022.07.31.13.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 13:22:06 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bert@biot.com, sander@svanheule.net,
        mail@birger-koblitz.de,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 0/2] spi: realtek-rtl: two small improvements
Date:   Sun, 31 Jul 2022 22:21:50 +0200
Message-Id: <20220731202152.1358252-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a successor to my single patch [0] "spi: realtek-rtl: Fix
clearing some register bits"

Changes since v2 at [1]:
- Added Sander's Tested-by to the second patch (thank you!)
- Dropped HAS_IOMEM dependency as this is already implied by CONFIG_SPI
  (thanks Sander for spotting this!)
- Extended Kconfig help text with the module name to make the Realtek
  driver consistent with others. Thanks to Sander for the suggestion!

Changes since v1 at [0]:
- Added new patch to enable compile testing for the spi-realtek-rtl
  driver. This makes it easier to verify coding style changes (such as
  patch #2 in this series) where the binary result is not supposed to
  change.
- Updated the original patch to drop the RTL_SPI_SFCSR_CS change as
  it's not fully clear why that code is written as-is (and due to
  lack of hardware I am unable to runtime test the changes). Also
  move the ~ operator from the RTL_SPI_SFCSR_LEN_MASK definition to
  the place where it's used. Thanks to Sander for spotting the mistake
  in my initial patch!


[0] https://lore.kernel.org/lkml/78673dc7438a03bf9ed0103a935abf0172f146ce.camel@svanheule.net/T/
[1] https://lore.kernel.org/linux-spi/20220728152118.1429161-1-martin.blumenstingl@googlemail.com/T/


Martin Blumenstingl (2):
  spi: realtek-rtl: Add compile testing support
  spi: realtek-rtl: Improve readability when clearing the size mask

 drivers/spi/Kconfig           | 11 +++++++++++
 drivers/spi/Makefile          |  2 +-
 drivers/spi/spi-realtek-rtl.c |  4 ++--
 3 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.37.1

