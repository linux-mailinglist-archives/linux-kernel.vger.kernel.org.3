Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2094A4806DD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 07:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbhL1Gu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 01:50:28 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:34851 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhL1Gu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 01:50:27 -0500
Received: from kwepemi500010.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JNQBt1Gl0zccDZ;
        Tue, 28 Dec 2021 14:49:58 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi500010.china.huawei.com (7.221.188.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 14:50:25 +0800
Received: from huawei.com (10.174.178.163) by kwepemm600010.china.huawei.com
 (7.193.23.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 28 Dec
 2021 14:50:25 +0800
From:   luhuaxin <luhuaxin1@huawei.com>
To:     <paul@paul-moore.com>, <eparis@redhat.com>
CC:     <linux-audit@redhat.com>, <linux-kernel@vger.kernel.org>,
        <fangxiuning@huawei.com>
Subject: [PATCH -next 0/1] audit: ignore userspace log when backlog limit exceeded and backlog_wait_time is 0
Date:   Tue, 28 Dec 2021 14:50:22 +0800
Message-ID: <20211228065023.118744-1-luhuaxin1@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.163]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audit backlog overflow is an actual problem in our system. We set
the backlog_wait_time to 0 for improving OS performance. Therefore,
under the impact of a large number of audit logs produced by sudo, the
backlog in buffer will greatly exceed backlog_limit.

When the backlog exceed the backlog_limit and backlog_wait_time is set
to 0, the process will only sleep for a very short time (jiffies). The
backlog may still exceed backlog_limit in extreme cases.

The more reasonable way to fix this problem is:

1. If backlog_wait_time is set to zero, ignore the log;
2. If backlog_wait_time is set to non-zero, let process sleep for
backlog_wait_time.

The above log limit logic is also the same as that in the existing
audit_log_start function.

This may not be a perfect solution, a further discussion maybe
necessary.

luhuaxin (1):
  audit: ignore userspace log when backlog limit exceeded and
    backlog_wait_time is 0

 kernel/audit.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

-- 
2.23.0

