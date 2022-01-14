Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8685A48E82B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240284AbiANKRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:17:52 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:31160 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236985AbiANKRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:17:52 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JZxxj5YSZz8wP0;
        Fri, 14 Jan 2022 18:15:05 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 14 Jan
 2022 18:17:50 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <richard@nod.at>, <dwmw2@infradead.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <libaokun1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH -next v3 0/2] jffs2: fix two memory leak when mount jffs2
Date:   Fri, 14 Jan 2022 18:28:52 +0800
Message-ID: <20220114102854.3399585-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V1->V2:
	In jffs2_scan_medium,
	if s = kzalloc(sizeof(struct jffs2_summary), GFP_KERNEL);
	returns error, go to "out" to do clear. Null pointer dereference
	occurs when if (s->sum_list_head) is executed in "out".

V2->V3:
	Sorry for the noise, but there seems to be a more elegant way to
	fix the memory leak in jffs2_scan_medium. When memory allocation
	fails or CONFIG_JFFS2_SUMMARY is N, s is NULL.For the former case,
	add the new tag "out_buf" to avoid it.In the latter case,
	jffs2_sum_reset_collected is also an empty function and does nothing.

Baokun Li (2):
  jffs2: fix memory leak in jffs2_do_mount_fs
  jffs2: fix memory leak in jffs2_scan_medium

 fs/jffs2/build.c | 4 +++-
 fs/jffs2/scan.c  | 6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.31.1

