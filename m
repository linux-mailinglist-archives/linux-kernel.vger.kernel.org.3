Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12ADA5842F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiG1PVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiG1PVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:21:45 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F89361B0C;
        Thu, 28 Jul 2022 08:21:43 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id p5so2580675edi.12;
        Thu, 28 Jul 2022 08:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xzlenXkL6gjd6fcYEpmVquteo43qcjfw6HpoMyUOvUw=;
        b=QAXyGpnsjoLWG2bKOX3OeePe+kYWr6zPiEWyrp7Yq6xsnZpYRup7/v6/HH9GwA2Zam
         zpiya57E/EDW//EutfcbezUhFB3sjx+r/KS1LWXaZmHj50qsHcGRusox3nTcZz8sjo2G
         Lu62r9EbU4sQNhDvqLOd4OJxcZJ6sbB0knrpJ+HfEykIcZEvhRTd2wFzXX2J3A/loiiD
         hvugu8yPKbGT9vc1WC/nRPnDyAXlRI9HB/WqPkZaJ6j7PQp4B+nRa/xHH7W4qSYBF0V0
         c8kuf9bljP8iWWhMpOdEDADTmQm+fY/uE/BaJfhwgX4umo6ZNDc0Ov2wkskBTbTvWPIz
         Nixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xzlenXkL6gjd6fcYEpmVquteo43qcjfw6HpoMyUOvUw=;
        b=S93N5iOow8yaVMW9YcGKuOn1HyFmBvORafsQGBx/dFeU2NXp2V+LO9qUuQ5LGnfqVC
         3s5fnsNXlc33FPxynOAWvyf/7J9tugy3oAo1xW/Y6jts5fkQ7zkNJ53TVC1vMlrfEUPD
         urxzOzVLolld/n2h2IyjuXFjr6Xm8RPIWWRVxP2m6l9XqzpnPnj3ZXbroa+TZb0GeDlT
         dKxrB0iXAhmaAJyYPNWxjKWi6kFutcC1KU4TFAGzMlxeiUjiI6Wyoqbb2G2xIO+cAJ3L
         +ZpyN7KWCf7kYpa74U7QwAzq7MmopwRcT42iqzDjC4ZXNXeN5Z2KGEgMVkOG8lwb2qu4
         ZO7w==
X-Gm-Message-State: AJIora+EAUXVar7CVF0HUcMJnMm4yUtZhiNRC3MJAc4KSjPM0+rAW7qO
        aVfYxh1RyI67Ol89AYTG4+lblZcMPgw=
X-Google-Smtp-Source: AGRyM1v+zkfjHJTcyRUTLSz/L0oSXD7ouc+QqqcvHyPlzs+kZtr+qnwE7m9gwkqzyYwAIQEDpJ9PVw==
X-Received: by 2002:a05:6402:294c:b0:43a:91a9:a691 with SMTP id ed12-20020a056402294c00b0043a91a9a691mr28325239edb.182.1659021701205;
        Thu, 28 Jul 2022 08:21:41 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c001-5600-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c001:5600::e63])
        by smtp.googlemail.com with ESMTPSA id e20-20020a170906315400b0072a881b21d8sm525006eje.119.2022.07.28.08.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 08:21:40 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bert@biot.com, sander@svanheule.net,
        mail@birger-koblitz.de,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/2] spi: realtek-rtl: two small improvements
Date:   Thu, 28 Jul 2022 17:21:16 +0200
Message-Id: <20220728152118.1429161-1-martin.blumenstingl@googlemail.com>
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


Martin Blumenstingl (2):
  spi: realtek-rtl: Add compile testing support
  spi: realtek-rtl: Improve readability when clearing the size mask

 drivers/spi/Kconfig           | 9 +++++++++
 drivers/spi/Makefile          | 2 +-
 drivers/spi/spi-realtek-rtl.c | 4 ++--
 3 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.37.1

