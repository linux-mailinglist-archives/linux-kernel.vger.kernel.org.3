Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E962E5282A2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242769AbiEPKwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242980AbiEPKvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:51:17 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB45BF72
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:51:16 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id i8so110595plr.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5qABwBGQeqRGyH4s8D1h5zI8q8n2HwL4/08QSvpU+KQ=;
        b=VSDQMlv8C2J9HnzLs/CYYNTmLUOIJa3xmXUvEFaE+GppMb+UfDrfgb9MvmDs2L4DgE
         fAw8N2GLUo5h45FxctT4TbOBV7xvP5WLkymIZTfaMtTUwmiFhjVIi+IE9N+TRYbne3W/
         xUqNzX7bvQkIEWp/4H5F17zPthIGutwTcK3pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5qABwBGQeqRGyH4s8D1h5zI8q8n2HwL4/08QSvpU+KQ=;
        b=m05Zgg6LyULmXeu2ZsdblF3el+JBfIiW8omyCWZhjNWe+he2eo3XkGegz9ecvok2lY
         AJjl0UlooN/ZK7pkmbVs/5CyGkaE/ZHB+Mq+g0hhDRHiEFz3dTRFRQhhax/bb4/v6BkG
         j4F+xEzXvwjuwc+yBCGD/TuG6lBbCJEzD+jQKIjafVW0kjPH4GEduuCZatXMAAanOdek
         dNWL2GdIQr9RLNQEYfPEW7TbPVbSCTtAU5WhDGKgGBw30MiVppmdsFsOPcQoYT6crmTq
         9fimt6zw7cvu+VNFsrXRvwl5EvVMmN1JC0bDXZ3iSb2aBVB16Esn8lb3BIx9xXpzhJkF
         n54w==
X-Gm-Message-State: AOAM533B4rjAaFm8JjvfvBYlKdkphJtNMGii6e31s4lDKC5Kvu/QGQGB
        BrzoRpyHElUd7JFCvlr0lM4pLA==
X-Google-Smtp-Source: ABdhPJzEhc6Nq+jLxQgfZOwbXkTmoQiUhXix3nS4TzvMkiag7XSXc+R5p+oyIy22fYfHXoiCxcP8fQ==
X-Received: by 2002:a17:90b:33ca:b0:1dc:e5b8:482b with SMTP id lk10-20020a17090b33ca00b001dce5b8482bmr29885251pjb.165.1652698275616;
        Mon, 16 May 2022 03:51:15 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:cdcb:c865:6f65:d875])
        by smtp.gmail.com with ESMTPSA id o14-20020a655bce000000b003db8dd388afsm6332778pgr.10.2022.05.16.03.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 03:51:15 -0700 (PDT)
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
Subject: [PATCH 0/2] Implement readahead for squashfs
Date:   Mon, 16 May 2022 18:50:59 +0800
Message-Id: <20220516105100.1412740-1-hsinyi@chromium.org>
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

Hsin-Yi Wang (2):
  Revert "squashfs: provide backing_dev_info in order to disable
    read-ahead"
  squashfs: implement readahead

 fs/squashfs/file.c  | 77 +++++++++++++++++++++++++++++++++++++++++++++
 fs/squashfs/super.c | 33 -------------------
 2 files changed, 77 insertions(+), 33 deletions(-)

-- 
2.36.0.550.gb090851708-goog

