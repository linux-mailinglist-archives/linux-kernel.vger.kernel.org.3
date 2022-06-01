Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D05053A2D4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352122AbiFAKjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347833AbiFAKja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:39:30 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90907CDCC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:39:28 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a10so1637181pju.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 03:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iyhf6brMfc11D4/C56YiSyoAx+hrLfJS2MsKHkeQdSU=;
        b=edQmDBvTOZnRp+S7U+hlShKZoD5of6RQ9ZKELHbSmIOTHvZXpjms28A8imaluJwyVZ
         XlSDbNQslUnlxjv8JGlU0NyJ+wI1qa4uqtvq6SU6fKonDTYlt4Ccd6Oxg23l1Ogh8sqL
         Puj21O0B3ZQJVV96/+itll3gIkfOy6v5gwdd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iyhf6brMfc11D4/C56YiSyoAx+hrLfJS2MsKHkeQdSU=;
        b=evKLLNyX2dXnK8DABDSTReddMpSdEk2jxK2zBsV0r+lwKnUpHaSX85DhLxVxK6n0b6
         PQUJ02FbfQFr5rjOZF8Mztjl3mbilRzt4mI3mlHvYo9OmQoG3SD8PKd4qobKOVnSGlV5
         85aCzPKCmzRguiu+nmryTpQ6fG0JiNq3R3dkwJBEIcYHSNR5uJwFpH/twWsYldAQzRfn
         KshWoge9U7XAdnxohfxVqZ9undQfWrZdS0HnqbmB8sDbZrhPqAAxhFXtZVfp+t1TS5PU
         1I91QyLmP0d6djr5c5OBDwa2H4p1t4YYzi2NkkTIiaLKLJXcyHACwnO9kVI9b4nZtgxO
         nSbA==
X-Gm-Message-State: AOAM533RgTS6oMUtwgsVKBWnb0/xJwu4bTvELNp64RgTvNcnbzDHL8Et
        5cXFqul0xWX38teMcV6PvmQZfw==
X-Google-Smtp-Source: ABdhPJxnq7OcG4oa1RcNJb0F7BVW1cIUZX5bmyuaYzhw8LuQyLX+dFmOGjL6+njBxNIEnRHiXx0mzw==
X-Received: by 2002:a17:902:ba97:b0:161:524d:5adb with SMTP id k23-20020a170902ba9700b00161524d5adbmr64905940pls.126.1654079968231;
        Wed, 01 Jun 2022 03:39:28 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:dc30:e75c:ae95:f2d6])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090332c900b00163bfaf0b17sm1183867plr.233.2022.06.01.03.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 03:39:27 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongwei Song <Xiongwei.Song@windriver.com>
Cc:     Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] Implement readahead for squashfs
Date:   Wed,  1 Jun 2022 18:39:19 +0800
Message-Id: <20220601103922.1338320-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
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

Commit c1f6925e1091("mm: put readahead pages in cache earlier") requires
fs to implement readahead callback. Otherwise there will be a
performance regression.

Commit 9eec1d897139("squashfs: provide backing_dev_info in order to
disable read-ahead") mitigates the performance drop issue for squashfs
by closing readahead for it.

This series implements readahead callback for squashfs. The previous
discussion are in [1] and [2].

[1] https://lore.kernel.org/all/CAJMQK-g9G6KQmH-V=BRGX0swZji9Wxe_2c7ht-MMAapdFy2pXw@mail.gmail.com/T/
[2] https://lore.kernel.org/linux-mm/Yn5Yij9pRPCzDozt@casper.infradead.org/t/#m4af4473b94f98a4996cb11756b633a07e5e059d1

Hsin-Yi Wang (2):
  Revert "squashfs: provide backing_dev_info in order to disable
    read-ahead"
  squashfs: implement readahead

Phillip Lougher (1):
  squashfs: always build "file direct" version of page actor

 fs/squashfs/Makefile     |  4 +-
 fs/squashfs/file.c       | 97 +++++++++++++++++++++++++++++++++++++++-
 fs/squashfs/page_actor.h | 41 -----------------
 fs/squashfs/super.c      | 33 --------------
 4 files changed, 98 insertions(+), 77 deletions(-)

-- 
2.36.1.255.ge46751e96f-goog

