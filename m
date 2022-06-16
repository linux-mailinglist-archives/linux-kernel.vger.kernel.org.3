Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AA054D7BF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 04:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357759AbiFPCA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 22:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350716AbiFPCA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 22:00:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4331C5933D;
        Wed, 15 Jun 2022 19:00:57 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LNlhc3ch0zgZQj;
        Thu, 16 Jun 2022 09:58:56 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 16 Jun
 2022 10:00:55 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <enwlinux@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yebin10@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH v3 0/4] ext4: fix use-after-free in ext4_xattr_set_entry
Date:   Thu, 16 Jun 2022 10:13:54 +0800
Message-ID: <20220616021358.2504451-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a macro for whether there is space for xattr in
ext4 inode, and fixes some problems with this macro.

V1->V2:
	Split the patch to make the logic clearer.
	Rename macro to EXT4_INODE_HAVE_XATTR_SPACE.
V2->V3:
	Rename macro to EXT4_INODE_HAS_XATTR_SPACE.

Baokun Li (4):
  ext4: add EXT4_INODE_HAS_XATTR_SPACE macro in xattr.h
  ext4: fix use-after-free in ext4_xattr_set_entry
  ext4: correct max_inline_xattr_value_size computing
  ext4: correct the misjudgment in ext4_iget_extra_inode

 fs/ext4/inline.c |  3 +++
 fs/ext4/inode.c  |  3 +--
 fs/ext4/xattr.c  |  6 ++++--
 fs/ext4/xattr.h  | 13 +++++++++++++
 4 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.31.1

