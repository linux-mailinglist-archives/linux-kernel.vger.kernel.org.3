Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115EB529C73
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242933AbiEQI2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243431AbiEQI1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:27:48 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2E54926A
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:27:32 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x23-20020a17090a789700b001df763d4ed0so1670238pjk.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OQSG90JJ/COqv9mWqt/xzSdYdvO+juHcEsbjP8h9uxE=;
        b=XcC1UInh58Jl4PGskeuciU5P2OCq/na/kier41kk7nJnA+K4cEl02/LJnIEGZgSSbw
         46fOUd7SGbpqEEc3PJLWzP0fGpCcY9nhGSToswlzecCHtOUtlh3tdUCq9U5gVrQ65glI
         WbHgy4IsWtvjdPvjNZVgKPhcTQK2xWks8//qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OQSG90JJ/COqv9mWqt/xzSdYdvO+juHcEsbjP8h9uxE=;
        b=HInvC7TGOabtKIkuf9y8zJEkbIlL4u8GqWPqg18U435BAi++R/IIINiTrQG/z2TLw4
         dCHuIcX1yRjLsDVDUQ3GK7d+O5drmriC/+1NVt9fbdJW/davyBLvnNjChTKzQGMMlsNu
         6BgPkeCsSiLWXTfnjHQdneTYtCmMJ79rfC+TtKyIrLVNUpJ4MEe1VinDrwpy/kpZzhWp
         1TP4rlRQosQTluACyfL3omxrcAC03bD2cbli+PzEOpVfwSyLWV3cxOw8TWlQU3jBNSt+
         eYB+LX5mORr8DEBefIq1Q8hM4ui2hUQlE7rSsRwPepfIAqWAKxu9ETIzCipnOET2mfWw
         kJ+Q==
X-Gm-Message-State: AOAM5337dC9eEJx7ucMuY+VGlxIifsky2ULRezSAlzcPqyqAXoDLyLVE
        t6wjO6dF88cbApHntPNQ5dhvpw==
X-Google-Smtp-Source: ABdhPJzacU5LTBci6tcDoYr6acvV+Apcw/E8uyjMeF6Su/oDlkem6pI1bRcqtwJR4I+BtXjbHyL8Dg==
X-Received: by 2002:a17:902:ce87:b0:15e:a619:4294 with SMTP id f7-20020a170902ce8700b0015ea6194294mr21385038plg.157.1652776052116;
        Tue, 17 May 2022 01:27:32 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:beb2:ec58:2159:9a33])
        by smtp.gmail.com with ESMTPSA id k9-20020a628409000000b0050dc76281d3sm8615083pfd.173.2022.05.17.01.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 01:27:31 -0700 (PDT)
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
Subject: [PATCH v2 0/3] Implement readahead for squashfs
Date:   Tue, 17 May 2022 16:26:48 +0800
Message-Id: <20220517082650.2005840-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

 fs/squashfs/Makefile     |  4 +--
 fs/squashfs/file.c       | 77 +++++++++++++++++++++++++++++++++++++++-
 fs/squashfs/page_actor.h | 41 ---------------------
 fs/squashfs/super.c      | 33 -----------------
 4 files changed, 78 insertions(+), 77 deletions(-)

-- 
2.36.0.550.gb090851708-goog

