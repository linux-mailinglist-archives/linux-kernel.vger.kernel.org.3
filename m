Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774AE594F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 06:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiHPEYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 00:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiHPEYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 00:24:00 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFDB1A4001
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 18:00:57 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M6CRg5klSzkWPg;
        Tue, 16 Aug 2022 08:57:35 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 09:00:54 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <phillip@squashfs.org.uk>
CC:     <nixiaoming@huawei.com>, <wangle6@huawei.com>,
        <yi.zhang@huawei.com>, <wangbing6@huawei.com>,
        <zhongjubin@huawei.com>, <chenjianguo3@huawei.com>
Subject: [PATCH v2 0/2] squashfs: Add the mount parameter "threads="
Date:   Tue, 16 Aug 2022 09:00:50 +0800
Message-ID: <20220816010052.15764-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220815031100.75243-1-nixiaoming@huawei.com>
References: <20220815031100.75243-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.189.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, Squashfs supports multiple decompressor parallel modes. However, this
mode can be configured only during kernel building and does not support flexible
selection during runtime.

In the current patch set, the mount parameter "threads=" is added to allow users
to select the parallel decompressor mode and configure the number of decompressors
when mounting a file system.

v2: fix warning: sparse: incorrect type in initializer (different address spaces)
  Reported-by: kernel test robot <lkp@intel.com>

v1: https://lore.kernel.org/lkml/20220815031100.75243-1-nixiaoming@huawei.com/
----

Xiaoming Ni (2):
  squashfs: add the mount parameter theads=<single|multi|percpu>
  squashfs: Allows users to configure the number of decompression
    threads.

 fs/squashfs/Kconfig                     | 24 ++++++++--
 fs/squashfs/decompressor_multi.c        | 32 ++++++++------
 fs/squashfs/decompressor_multi_percpu.c | 39 ++++++++++-------
 fs/squashfs/decompressor_single.c       | 23 ++++++----
 fs/squashfs/squashfs.h                  | 39 ++++++++++++++---
 fs/squashfs/squashfs_fs_sb.h            |  4 +-
 fs/squashfs/super.c                     | 77 ++++++++++++++++++++++++++++++++-
 7 files changed, 192 insertions(+), 46 deletions(-)

-- 
2.12.3

