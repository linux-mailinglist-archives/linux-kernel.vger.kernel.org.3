Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686A652826B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiEPKno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236729AbiEPKna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:43:30 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA3718B05
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:42:52 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 191so2542553pgf.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gGywS9bHxk5TZLlg9cekFTB0weMYTqUUeiNtr9tZHho=;
        b=aF8Vk35o5gqPuerIPs6Aw+pBQ/K6j6dF1s+VEzN+mv48EULn6pi4887t2cp7eG1SuV
         Cg5So539af0OUXOeoR0S8BqNWeEEh72naBPz0RlsSudJ5mqA5Q4b1SZJ1Sm7pyluQGG2
         Rt3Fr0G55MrmNV1QJwj3LwOPs5TGPB+XMwDJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gGywS9bHxk5TZLlg9cekFTB0weMYTqUUeiNtr9tZHho=;
        b=R4tFdj1RsMRMqAwVTqciqso+923JePk7lrQHtyhdglGK4ZfGsXnmoAQnrOuEDRyHid
         q3oezvcDNfQDNIJAEN7nyZJjw8Qi322gUDVp1jkaKraG7P/gN8Yxjk3gkKCL/W2KNZk/
         HTnOVkscxythNAW2B42nHMDZlWXzAOTkGg6hRCGfxSbZAp4OpZEWHaYXKdK+rVpq4hGF
         P9MnZFeaECqmasHkWERoRjGIikLoRoAhwbn+FYBeRp1q9oA9aElbLO7dT9tB9vHujjX6
         oM5cITlZ8+eqXQ9SxPPyzknqOjtGDvWSJKI/M4J5uB/KKHhzLxLX9i3T/0xZXRZ8krlI
         hf+Q==
X-Gm-Message-State: AOAM533/ZMz5/qLl67bm+v9QLbo5mdOY6B+u+kAI/rkzh2xLHL6V4ZBw
        VaPY58jBUbY/7dUQPfiejBQdNg==
X-Google-Smtp-Source: ABdhPJyncUK3MZU/GJsE8dgsnjOCQKmWoiGt3yIx9nl/FcnEK7brtYhcPM7Q3kN1VggUz9jh08uisg==
X-Received: by 2002:a62:6410:0:b0:4f3:9654:266d with SMTP id y16-20020a626410000000b004f39654266dmr16640705pfb.59.1652697772064;
        Mon, 16 May 2022 03:42:52 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:cdcb:c865:6f65:d875])
        by smtp.gmail.com with ESMTPSA id 10-20020a17090a01ca00b001cd4989ff70sm6191232pjd.55.2022.05.16.03.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 03:42:51 -0700 (PDT)
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
Subject: [PATCH 0/3] Implement readahead for squashfs
Date:   Mon, 16 May 2022 18:42:08 +0800
Message-Id: <20220516104209.1407388-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Hsin-Yi Wang (3):
  Revert "squashfs: Convert squashfs to read_folio"
  Revert "squashfs: provide backing_dev_info in order to disable
    read-ahead"
  squashfs: implement readahead

 fs/squashfs/file.c    | 82 +++++++++++++++++++++++++++++++++++++++++--
 fs/squashfs/super.c   | 33 -----------------
 fs/squashfs/symlink.c |  5 ++-
 3 files changed, 81 insertions(+), 39 deletions(-)

-- 
2.36.0.550.gb090851708-goog

