Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3FC54F331
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380328AbiFQIio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380211AbiFQIid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:38:33 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E22E689AB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:38:31 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 184so3488114pga.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K+DkLreQJFdtzIaPZdznlpaTpcwmK3UqwA6ApgLZ4TQ=;
        b=Lk366whEMkptSrLGRqAclQQ2FcZrq04kAssYDgRTppdYfoFU9F8gaIEBPsIOZ7WgdH
         7hRdbHaR+fLKNo99gbAdrz9+6McDkQp0stDBWrUqEP6bmBGyOdzvvyDeH4Y+ZXwbNkcn
         qkh89tsvJEYcOetnsx3qNK1W3/0tGw/saX9r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K+DkLreQJFdtzIaPZdznlpaTpcwmK3UqwA6ApgLZ4TQ=;
        b=sJpT/ggpsqGyytHwWiVDkCzWaJLixcHhO5BACbUlp/7Sb25h6rUPl2D1kF+6PFu6Rt
         7cCzP3g2Xw5mzyXyMiSRanQlDdCEUmOKMb44hmWveIATUT/0h6mZW4m/kmloLhwYlZc1
         wBjMVklYzhYg1j8Xv4GlQpDMCT69UIYD3ppL1lnqW6NrL4odkw+TOCtDxa83gbtrcEvc
         wk7dk+EhmMiMg8NutvrIOWDEqiJgkW3oEaBBhdTr6IdzJI1b4wrlnLZkeQNY7WqFLupf
         TbqidxMFBtWsV2Boil0s8979lD5fXtDL1MQFohXh6sUVozZ6/I0ln7kBn2sp+XpeKvFa
         rsug==
X-Gm-Message-State: AJIora98+vMEVfgAGdB+CRawgZ+S/wgMknj1JpU8Y+YXKM8r00Fi5LRM
        xHRtlrE0JNcyvtOVcV3v5KN9BA==
X-Google-Smtp-Source: AGRyM1vwvZ9tYychzYFYTXO02HMgABTJZ+teUXxcNrO+NvkZckUklScM0dCZh5cI4L6b+8J6tXMMSQ==
X-Received: by 2002:a05:6a00:2999:b0:51b:e3c8:9e30 with SMTP id cj25-20020a056a00299900b0051be3c89e30mr8750954pfb.41.1655455110868;
        Fri, 17 Jun 2022 01:38:30 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:a0dc:9427:fea8:f78a])
        by smtp.gmail.com with ESMTPSA id d12-20020a62f80c000000b005185407eda5sm3154103pfh.44.2022.06.17.01.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 01:38:30 -0700 (PDT)
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
Subject: [PATCH v7 0/4] Implement readahead for squashfs
Date:   Fri, 17 Jun 2022 16:38:07 +0800
Message-Id: <20220617083810.337573-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
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

Commit 9eec1d897139("squashfs: provide backing_dev_info in order to
disable read-ahead") mitigates the performance drop issue for squashfs
by closing readahead for it.

This series implements readahead callback for squashfs. The previous
discussions are in [1] and [2].

[1]
https://lore.kernel.org/all/CAJMQK-g9G6KQmH-V=BRGX0swZji9Wxe_2c7ht-MMAapdFy2pXw@mail.gmail.com/T/
[2]
https://lore.kernel.org/linux-mm/Yn5Yij9pRPCzDozt@casper.infradead.org/t/#m4af4473b94f98a4996cb11756b633a07e5e059d1

v7 adds the patch to support reading fragments in readahead call[3]. No
changes on other patches since v6, which is included in next-20220617.

[3]
https://patchwork.kernel.org/project/linux-mm/patch/20220617030345.24712-1-phillip@squashfs.org.uk/

Hsin-Yi Wang (2):
  Revert "squashfs: provide backing_dev_info in order to disable
    read-ahead"
  squashfs: implement readahead

Phillip Lougher (2):
  squashfs: always build "file direct" version of page actor
  squashfs: support reading fragments in readahead call

 fs/squashfs/Makefile     |   4 +-
 fs/squashfs/file.c       | 133 ++++++++++++++++++++++++++++++++++++++-
 fs/squashfs/page_actor.h |  46 --------------
 fs/squashfs/super.c      |  33 ----------
 4 files changed, 134 insertions(+), 82 deletions(-)

-- 
2.36.1.476.g0c4daa206d-goog

