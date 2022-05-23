Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04028530A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiEWHVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiEWHUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:20:31 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4183A0075
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:12:29 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id e7so6674001vkh.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ivbtveK1b9xDXzTHiB1+vrFrI8F8zLJqf42Jq8NTt84=;
        b=JrZU0mAtWhyHtnGWfcq4jisbYZkDYfFSSaRvW7hUCBHB5+ZPnkL8XNaBlBWSPG/xHI
         mMEVGvxKf3niaQ4D8oZgj3wzKbz+5/rwz5eyALJmx7eG0kQCD/9RgoZ2mTWfN6QcdKdj
         Do+KMx/FsUkhPKjbh58S9261HdHS7Mf3Zxa6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ivbtveK1b9xDXzTHiB1+vrFrI8F8zLJqf42Jq8NTt84=;
        b=L2IT+R3g9me/r3952zpx4kuebOT4u0d+clNjtewsWISMMFYopX2LBapzDhqMD6ZTws
         0/29q40200ruuHktS60g2YOsOxOQ5m+yX58CxDlX+F1PGVA5OqFiSUySOl7TBilyXJ0Q
         3P1Eni3ilEJSLLe+Gzw/qOSHcJoml7OOzFC2ZePIFGtGwn6fJeeKnyy7+JZpBSXtlhdG
         kcKImnFCIEWSI0Gohp9KtcxGdZYQX7OXIvNRG7XhlapL5PL5hERzv0vq7V2yaNrBI+BX
         tMwQZqaHO1t6jzTMLp920ntDtB2HtMpFCQavmmKz2DrTTW0XqmbOpK88MKyGkhGi/KhQ
         HxAw==
X-Gm-Message-State: AOAM533JGTIVYihG2H9U5ceuy9ZgCewYAy0Vhq6Ba/nerQ6rRFjLXrif
        4oz3bdROpnaVXFq7R6SXQCfsoNDVUwyWuw==
X-Google-Smtp-Source: ABdhPJyT2PNg67dmHFmoI/Hj5YZVhAGhIMtKKzgeiGQjxfk1/InZ7XWSgzgldrF617vESUKPBhniDQ==
X-Received: by 2002:a17:902:a50f:b0:162:28c6:bfac with SMTP id s15-20020a170902a50f00b0016228c6bfacmr2850974plq.99.1653289180789;
        Sun, 22 May 2022 23:59:40 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:76d5:494d:1690:d003])
        by smtp.gmail.com with ESMTPSA id m2-20020a629402000000b005180f4733a8sm3099527pfe.106.2022.05.22.23.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 23:59:39 -0700 (PDT)
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
Subject: [PATCH v3 0/3] Implement readahead for squashfs
Date:   Mon, 23 May 2022 14:59:07 +0800
Message-Id: <20220523065909.883444-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 fs/squashfs/file.c       | 91 +++++++++++++++++++++++++++++++++++++++-
 fs/squashfs/page_actor.h | 41 ------------------
 fs/squashfs/super.c      | 33 ---------------
 4 files changed, 92 insertions(+), 77 deletions(-)

-- 
2.36.1.124.g0e6072fb45-goog

