Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA4F53E988
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240271AbiFFPDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240149AbiFFPDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:03:13 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022FABE163
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:03:12 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id cx11so13044582pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 08:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u/qVH/JzAtOjd7wOJnhVf/fg1Cz1T/bObRHmqtOqxLs=;
        b=VP83WIlxTfcsIiCwnGLyHEwOdzkMAjiNd35I7TWu2jZfL2DSyQH8ta3ZleGMiyIkm2
         XBTDF0VeYVsWxbwpO5zhR2Y4lj7wL+5vIUR1mLd5U0p45yg9qOjr7Nvfnmp7ubjErJu0
         NHQWV934SSNf836D85YO6qS/dPtd533HrLp9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u/qVH/JzAtOjd7wOJnhVf/fg1Cz1T/bObRHmqtOqxLs=;
        b=MX8gj/95U5ozbLUZ9JYp83+94LdvjmZcQkyAT2DV/S87fHYeOHVKTrnpyyMxizzud4
         vtJehPQREhjfmDMut1TqbbQ3BuEuqkt9BAxCe1GNhsXx6SWaQWyupKERHWrd4QDBeq67
         4FRZQ2aN8kxjoW4Pv0gusr2/pHyoUi7pGeGTIyl6QN7WxUnIRnpLoZlD7NVcdY6C+NEh
         Nr5CvOLURq/bgiI7dRx97oBbXqgdnVQlo6nGtq2CD3VxXW6N8pTPsx64fqOAdn+RWorL
         6k4wOJPC+VAxINB2NAMlol1KMPX145z4Xk8AxarQxvDN3cP3iW6M6J9PQF0LO8fskV3G
         ZzDQ==
X-Gm-Message-State: AOAM532p/GsrYiq+/jqqnTuIpTUzrVnbKIS3NRByKn1QsveRANjmkISg
        AzE9Mi1fW8b0ULEAjWSbMYrZLA==
X-Google-Smtp-Source: ABdhPJx8aTAJm37UgychcNCv2OMoouLeNCV8OtVUfCNyl2p0kiMAU53Zsa1DMJLOqKWibSVfBx3iTw==
X-Received: by 2002:a17:90b:4c06:b0:1e3:17fa:e387 with SMTP id na6-20020a17090b4c0600b001e317fae387mr41330610pjb.53.1654527791257;
        Mon, 06 Jun 2022 08:03:11 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:a0a:5e4:e24:c8c4])
        by smtp.gmail.com with ESMTPSA id k13-20020aa7998d000000b0050dc76281ecsm7468864pfh.198.2022.06.06.08.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 08:03:10 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongwei Song <Xiongwei.Song@windriver.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] Implement readahead for squashfs
Date:   Mon,  6 Jun 2022 23:03:02 +0800
Message-Id: <20220606150305.1883410-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
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

 fs/squashfs/Makefile     |   4 +-
 fs/squashfs/file.c       | 124 ++++++++++++++++++++++++++++++++++++++-
 fs/squashfs/page_actor.h |  41 -------------
 fs/squashfs/super.c      |  33 -----------
 4 files changed, 125 insertions(+), 77 deletions(-)

-- 
2.36.1.255.ge46751e96f-goog

