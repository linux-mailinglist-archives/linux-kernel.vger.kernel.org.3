Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1122548208
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiFMIj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239358AbiFMI2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:28:19 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933BB18E01
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:28:08 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso5308592pjk.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=saBjD3jkEUAS49RaWaPJ2CNN05fMmd8ePuqMGDaRHaE=;
        b=GWjyteMFDcjNXMDDwlym/BUvNopN71bba50Say1gw3+3U8Ne968cx6QbHNqKAGVv2d
         VWGuwX8FLIJYeNY6ueLNoLkOx6FKLFptYMyvZDXC0eXfYMRIhAlqMmj9Cmqud0di5sJm
         1DmX80WUdvuhlTDYsBa/0Ih78fBv4p52f6b9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=saBjD3jkEUAS49RaWaPJ2CNN05fMmd8ePuqMGDaRHaE=;
        b=LtIcWocPK94cqre4ul9xNECDXi2TOwWlEswK5fFD+pFbDtaAFC1nQ8HOvMIA+wl8Ac
         2I+mXFvOjvxdy3auLhrYqCA94pkCDNN+p4QafY0/12GBRHFIK9jOo7I9lcTrRF4sn7ZA
         nJ62jOddGHkUFqAGAiAMxTEYMdhtsg93iLTyd+qAwsed6VDNABqFit78UrjiWIMZ2HyU
         fU7BiAA0cJeG1fSxXrB3Eh3v47L1FZmdpS+G81YDvcZPhZCNqe+Ye3BthjwwIBuobB6p
         BrWCap0WFM3LYkK/kIxAy0Gu22op6gplYtIhg6oASXinGuMClLDZBQ7LVIlcOgsgF98X
         W6mA==
X-Gm-Message-State: AOAM5308mS7bGTTg3q5z6u2GrzBGbOUVwo2t16JzbdBJqs3XcAHw8Twc
        oFBP4HEjUiPLtfYcdUMznzhS/Q==
X-Google-Smtp-Source: ABdhPJyawO1X2eUGQdWidB0Npz/qLDSDbCezpShHfaKWeq7WwHzabxErc1ZlXqq4fySaJfYf3Opngw==
X-Received: by 2002:a17:90b:1808:b0:1e2:a335:ad04 with SMTP id lw8-20020a17090b180800b001e2a335ad04mr14505671pjb.110.1655108887412;
        Mon, 13 Jun 2022 01:28:07 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:79ca:e1d9:ad5:dc9e])
        by smtp.gmail.com with ESMTPSA id br8-20020a056a00440800b00518a473265csm4624906pfb.217.2022.06.13.01.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 01:28:06 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Xiongwei Song <Xiongwei.Song@windriver.com>,
        Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/3] Implement readahead for squashfs
Date:   Mon, 13 Jun 2022 16:27:59 +0800
Message-Id: <20220613082802.1301238-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9eec1d897139("squashfs: provide backing_dev_info in order to
disable read-ahead") mitigates the performance drop issue for squashfs
by closing readahead for it.

This series implements readahead callback for squashfs. The previous
discussions are in [1] and [2].

[1]
https://lore.kernel.org/all/CAJMQK-g9G6KQmH-V=BRGX0swZji9Wxe_2c7ht-MMAapdFy2pXw@mail.gmail.com/T/
[2]
https://lore.kernel.org/linux-mm/Yn5Yij9pRPCzDozt@casper.infradead.org/t/#m4af4473b94f98a4996cb11756b633a07e5e059d1

This version is based on next-20220610 and the following series:
"Squashfs: handle missing pages decompressing into page cache" [3].

This version is a refresh of ca1505bf4805 ("squashfs: implement
readahead") and 9d58b94aa73a ("squashfs: always build "file direct"
version of page actor").

There's no change in 4af2bd190a5b7 (Revert "squashfs: provide
backing_dev_info in order to disable read-ahead"), but it's carried in
this version too for consistency.

[3]
https://patchwork.kernel.org/project/linux-mm/cover/20220611032133.5743-1-phillip@squashfs.org.uk/

Hsin-Yi Wang (2):
  Revert "squashfs: provide backing_dev_info in order to disable
    read-ahead"
  squashfs: implement readahead

Phillip Lougher (1):
  squashfs: always build "file direct" version of page actor

 fs/squashfs/Makefile     |  4 +-
 fs/squashfs/file.c       | 92 +++++++++++++++++++++++++++++++++++++++-
 fs/squashfs/page_actor.h | 46 --------------------
 fs/squashfs/super.c      | 33 --------------
 4 files changed, 93 insertions(+), 82 deletions(-)

-- 
2.36.1.476.g0c4daa206d-goog

