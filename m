Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BD5568121
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiGFIXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiGFIWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:22:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004C6248D1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 01:22:49 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LdCC94M8qz67gQT;
        Wed,  6 Jul 2022 16:20:05 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 6 Jul 2022 10:22:47 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Jul 2022 09:22:44 +0100
From:   John Garry <john.garry@huawei.com>
To:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>
CC:     <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH] nvme: Fix nvme_setup_command metadata trace event for cdw10
Date:   Wed, 6 Jul 2022 16:16:38 +0800
Message-ID: <1657095398-114310-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For x86_64 allmodconfig I get this warning:

In function ‘fortify_memcpy_chk’,
    inlined from ‘perf_trace_nvme_setup_cmd’ at drivers/nvme/host/./trace.h:47:1:
./include/linux/fortify-string.h:352:4: error: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror]
    __read_overflow2_field(q_size_field, size);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function ‘fortify_memcpy_chk’,
    inlined from ‘trace_event_raw_event_nvme_setup_cmd’ at drivers/nvme/host/./trace.h:47:1:
./include/linux/fortify-string.h:352:4: error: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror]
    __read_overflow2_field(q_size_field, size);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cdw10 metadata is 24 bytes, and we try to copy size of cdw10 metadata from
nvme_command.common.cdw10 into that cdw10 metadata, but
nvme_command.common.cdw10 is only 4 bytes in size.

Fix by making the trace metadata size as 4 bytes.

I find that this warning started first appearing from commit f68f2ff91512
("fortify: Detect struct member overflows in memcpy() at compile-time").

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index b5f85259461a..d6d35f935006 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -57,7 +57,7 @@ TRACE_EVENT(nvme_setup_cmd,
 		__field(u16, cid)
 		__field(u32, nsid)
 		__field(bool, metadata)
-		__array(u8, cdw10, 24)
+		__array(u8, cdw10, 4)
 	    ),
 	    TP_fast_assign(
 		__entry->ctrl_id = nvme_req(req)->ctrl->instance;
-- 
2.35.3

