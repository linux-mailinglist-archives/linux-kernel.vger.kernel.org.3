Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E912480F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 05:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238644AbhL2EOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 23:14:18 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:39861 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232404AbhL2EOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 23:14:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V0Bi34J_1640751246;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V0Bi34J_1640751246)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 Dec 2021 12:14:14 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 0/5] erofs: get rid of erofs_get_meta_page()
Date:   Wed, 29 Dec 2021 12:14:00 +0800
Message-Id: <20211229041405.45921-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

erofs_get_meta_page() is actually inflexible since it's too
close to the page itself.

In order to prepare for folio and subpage features, introduce
on-stack meta buffer descriptor instead and convert all
erofs_get_meta_page() users to use it.

It can also be used for new potential backends such as fscache or mtd.

Patches are trivial.

Thanks,
Gao Xiang

Gao Xiang (5):
  erofs: introduce meta buffer operations
  erofs: use meta buffers for inode operations
  erofs: use meta buffers for super operations
  erofs: use meta buffers for xattr operations
  erofs: use meta buffers for zmap operations

 fs/erofs/data.c     | 102 +++++++++++++++++++++++++-----------
 fs/erofs/inode.c    |  68 ++++++++++++------------
 fs/erofs/internal.h |  22 ++++++--
 fs/erofs/super.c    | 105 ++++++++++---------------------------
 fs/erofs/xattr.c    | 123 +++++++++++++-------------------------------
 fs/erofs/zdata.c    |  23 ++++-----
 fs/erofs/zmap.c     |  56 ++++++--------------
 7 files changed, 211 insertions(+), 288 deletions(-)

-- 
2.24.4

