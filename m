Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19204474755
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbhLNQQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbhLNQQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:16:44 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAD6C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:16:43 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so16608401wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AmgkymR9haOFT9fuurSvbtWN6rxOeKgu2ZPiSoag26Q=;
        b=S0HCKpPdv0aGzhdeTCgzdLPyaPU2SxHZ+GU/joalX0OuobxFQydPcVzfEZ/u733I2d
         fJ7Ekot9HvPUl49H3Kl78ZBnT6M/oTHEyGKWtITtldzhNj546EnytZXvH0YDcupLmXuL
         9YD+HKPr6hhpg+6mqgX7GtuZ0zzrSomeq4j0rUsiX21XKqaNOCdupYV/zDMd3E0OpCvt
         2B4gS9dVvhiBCM+PLUR8+pM2DU7W5QI6p/XHWOLNR1EzRCeqbXg8+alvgNu090ikStzQ
         dqAne2B2Tj0rC4TmQCEL8wYpO6vN3SeflCfICY0hmKZJbrk4cHvJivT1M6cH2W5/pg2p
         Vb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AmgkymR9haOFT9fuurSvbtWN6rxOeKgu2ZPiSoag26Q=;
        b=wJBMWG0KIpXuVg2a7z3ClgICVyrKT08iKh/TeRHYlyiPj7EfHTCAY6OYcKFHVzc54u
         UXw8ky50smMk0kFetyLY56e89QI+WRiDB9gZGLkkstCNINFyd5lqzy0UCalvTk6/QLs/
         ZM34exm0Hz2s8+DhLUiT0ZE0/xZ8BK74tPfvnmniVyuhoAZNCewHTJ5Fr+hEtaGpxA74
         6JJDkLqGtpHEiDoG3foWPFRkSAbsfVNO2rAt4JdFQbjS86Hsp8FkLIy1PhbZb9ka/1/k
         wJ9f2NsZeyD3ZfmL2NrwL0qzK1CdVc1kDb8gcsb1dIDQk06aX3BrVTO9ueYqAFIu4Bnk
         whxg==
X-Gm-Message-State: AOAM5308p2O6TvZSXONDujPxDnsGDvZaY/64s9C3VFU76hnodScUTYGr
        G08Drj91n8Om2cxOm3YxEdXljA==
X-Google-Smtp-Source: ABdhPJwD77E4ftv7qBq+s4ZQFO8uD366PZA247DTyhNmc1Ml7+ImDjC8MxX0aXZvGuA1xzNDWwLRXQ==
X-Received: by 2002:a7b:c257:: with SMTP id b23mr8285418wmj.67.1639498602119;
        Tue, 14 Dec 2021 08:16:42 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a9sm295116wrt.66.2021.12.14.08.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 08:16:41 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mjpeg-users@lists.sourceforge.net,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 00/18] staging: media: zoran: merge in one module
Date:   Tue, 14 Dec 2021 16:16:18 +0000
Message-Id: <20211214161636.1886900-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

The main change of this serie is to merge all zoran related modules in
one.
This fixes the load order problem when everything is built-in.
But this serie include several more fixes found while working on this.

Regards

Changes since v3:
- Fixed a lock up when doing a capture
- added fixes patchs from Hans Verkuil
- dropped DC30 patch, I will send a new patch later for adding DC30D

Changes since v2:
- added the 4 latest patchs
- removed DEBUGFS kconfig option
- fixed Dan Carpenter's reported codec issues
- fixed kernel test robot's reported issues on vb2_dma_contig_set_max_seg_size()

Changes since v1:
- add missing debugfs cleaning
- clean some remaining module_get/put functions which made impossible to
  remove the zoran module
- added the two latest patchs

Corentin Labbe (14):
  staging: media: zoran: move module parameter checks to zoran_probe
  staging: media: zoran: use module_pci_driver
  staging: media: zoran: rename debug module parameter
  staging: media: zoran: add debugfs
  staging: media: zoran: videocode: remove procfs
  staging: media: zoran: merge all modules
  staging: media: zoran: remove vidmem
  staging: media: zoran: move videodev alloc
  staging: media: zoran: move config select on primary kconfig
  staging: media: zoran: introduce zoran_i2c_init
  staging: media: zoran: fix usage of vb2_dma_contig_set_max_seg_size
  staging: media: zoran: clean unused code
  staging: media: zoran: fix counting buffer in reserve
  staging: media: zoran: calculate the right buffer number for
    zoran_reap_stat_com

Hans Verkuil (4):
  staging: media: zoran: fix various V4L2 compliance errors
  staging: media: zoran: fix TRY_FMT handling
  staging: media: zoran: drop kernel log spam
  staging: media: zoran: drop read/write support

 drivers/staging/media/zoran/Kconfig        |  38 +-
 drivers/staging/media/zoran/Makefile       |   8 +-
 drivers/staging/media/zoran/videocodec.c   |  68 +---
 drivers/staging/media/zoran/videocodec.h   |   4 +-
 drivers/staging/media/zoran/zoran.h        |  18 +-
 drivers/staging/media/zoran/zoran_card.c   | 398 +++++++++++++--------
 drivers/staging/media/zoran/zoran_device.c |  15 +-
 drivers/staging/media/zoran/zoran_device.h |   2 -
 drivers/staging/media/zoran/zoran_driver.c |  56 ++-
 drivers/staging/media/zoran/zr36016.c      |  25 +-
 drivers/staging/media/zoran/zr36016.h      |   2 +
 drivers/staging/media/zoran/zr36050.c      |  24 +-
 drivers/staging/media/zoran/zr36050.h      |   2 +
 drivers/staging/media/zoran/zr36060.c      |  23 +-
 drivers/staging/media/zoran/zr36060.h      |   2 +
 15 files changed, 349 insertions(+), 336 deletions(-)

-- 
2.32.0

