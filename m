Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17A75370A7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 13:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiE2LCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 07:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiE2LCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 07:02:04 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0BA6948A
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 04:02:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u3so11252948wrg.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 04:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0B6lPr/sbtBS+5h8GOoxESv/ZQ22BbLfnRBa62Z38ZI=;
        b=QFtqQHNzFqmv5q6czfWB0xYYwp6786SUdsP5aMmzcUF8WcXftvxYSNjxJy4ZZO8tcS
         n8WrDZN4Fzffii2uwysqrQsq7AgCB76Sd2pbiUCNQYJtL6szpozFSSaw7m7ZEYsd2u+V
         +1ZWTxbZ8QDo6Cf3BjwYaVdkupHk7qCC6PNuh+qWsPKv7vqaLXF4Hu19DFM9Clr7skuR
         MpFL74Pii9ywvBrGJgaNeImOjjQziw98gziDR1qrBtyBstvmraF6DKO4QwJ3k56sQ1/I
         oWE/fwqUsd/iY/EYOTo0OWPZqXzDGwB91tbhvgdgrhZ2B4lPula6Xej6/hE9PwYPAEx1
         frvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0B6lPr/sbtBS+5h8GOoxESv/ZQ22BbLfnRBa62Z38ZI=;
        b=BTYl0c94Nt+aVybTUvBglgpLpJE8kFhemwljrNGHMyQM/QLmqTbNg199TbYTqnqNOz
         bayIL15VoNyOJMDmek0hkpa5nQRQL774Q/YACdC6kUPzvCXQPwZvqeMA4aYZQyWzCRob
         8WXHFoexif0ztHPUx0y3NpU/DI8BHqsqJBC55wPUozqincAd3PckOnLDESs8qtBe2pmM
         7mmfizR+8ZPQsOghT8h2G9yzDf463XST2wF65DkhdtexoiWsvOO3DJCV4CT55SH79gbi
         NOGsvKiRb7iQhcJJx1r7uCMadL6JLNRkUMB82aLwCVBZG38CK1HY1asWRVVANBJh/C3o
         lSUQ==
X-Gm-Message-State: AOAM530mbG0LdRFF2iKw0mAXnpcxiv00nlH5L46zsjvkSUPQ4R4mz5x1
        l0HzJX5BXs+nqqy6Fy0m6U9W9R4Uohbq6oCmsr8=
X-Google-Smtp-Source: ABdhPJxJyBUU5tSxu9PfLLqVudqyXmJySrMbx4BMxAfDmjtAeVLBI3E552LJ1OyG0GsqcPad/VIpfQ==
X-Received: by 2002:a05:6000:783:b0:210:179b:1ff4 with SMTP id bu3-20020a056000078300b00210179b1ff4mr9409613wrb.168.1653822121112;
        Sun, 29 May 2022 04:02:01 -0700 (PDT)
Received: from vmu1804.lan ([2a06:a003:501a:a7ce::887])
        by smtp.googlemail.com with ESMTPSA id m1-20020a1c2601000000b003942a244f2fsm7503771wmm.8.2022.05.29.04.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 04:02:00 -0700 (PDT)
From:   Mikhail Zhilkin <csharper2005@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Mikhail Zhilkin <csharper2005@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        NOGUCHI Hiroshi <drvlabo@gmail.com>,
        INAGAKI Hiroshi <musashino.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Karim <Karimdplay@gmail.com>, M <x1@disroot.org>
Subject: [PATCH v6 0/1] Add support for Sercomm partitions
Date:   Sun, 29 May 2022 11:01:56 +0000
Message-Id: <20220529110156.189564-1-csharper2005@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for Sercomm mtd partition table parser. It's used in
some Beeline, Netgear and Sercomm routers. The Sercomm partition map table
contains real partition offsets, which may differ from device to device
depending on the number and location of bad blocks on NAND. All necessary
dt bindings has already been added previously.

Changes since:
v5:
 - Fix undefined "__udivdi3" on 32-bit platforms (Reported-by: kernel test
   robot <lkp@intel.com>): limit patch scope to RALINK platform only
 - Sort variables

v4:
 - Add Acked-by to the first patch

v3:
 - Fix commit message of the first patch
 - Add Reviewed-by to the second patch

v2:
 - Fix mistakes in dt-binding
 - Add patch for new vendor prefix
 - Add vendor prefix to scpart-id property

v1:
 - Add dt-binding in a separate patch
 - Remove redundant braces and logical NOT operator
 - Define pr_fmt
 - Replace kcalloc by kzalloc
 - Use of_get_child_count() and alloc big enough array before the
   for_each_child_of_node()

Mikhail Zhilkin (1):
  mtd: parsers: add support for Sercomm partitions

 drivers/mtd/parsers/Kconfig  |   9 ++
 drivers/mtd/parsers/Makefile |   1 +
 drivers/mtd/parsers/scpart.c | 248 +++++++++++++++++++++++++++++++++++
 3 files changed, 258 insertions(+)
 create mode 100644 drivers/mtd/parsers/scpart.c

-- 
2.25.1

