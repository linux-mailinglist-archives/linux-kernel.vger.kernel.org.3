Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EE44D2F5C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiCIMsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiCIMsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:48:43 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5BF1A838;
        Wed,  9 Mar 2022 04:47:41 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KDBkb3SSGzBrJk;
        Wed,  9 Mar 2022 20:45:43 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 20:47:38 +0800
Received: from huawei.com (10.175.101.6) by dggpemm500017.china.huawei.com
 (7.185.36.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 9 Mar
 2022 20:47:38 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Wu Bo <wubo40@huawei.com>, Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, Wenchao Hao <haowenchao@huawei.com>
Subject: [PATCH v3 0/3] scsi:iscsi: handle iscsi_cls_conn device with sysfs correctly
Date:   Wed, 9 Mar 2022 20:57:56 -0500
Message-ID: <20220310015759.3296841-1-haowenchao@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found a NULL pointer dereference in iscsi_sw_tcp_conn_get_param(),
the root reason is we did sysfs addition wrong.

The origin implement do device setup in iscsi_create_conn() which
bind the alloc/init and add in one function; do device teardown in
iscsi_destroy_conn() which bind remove and free in one function.

This implement makes it impossible to initialize resources of device
before add it to sysfs during setup.

So this patchset splict both the setup and teradown of iscsi_cls_conn to
2 steps.

For setup flow, we should call iscsi_alloc_conn() and initialize some
resources, then call iscsi_add_conn().

For teradown flow, we should call iscsi_remove_conn() to remove device
and free resources which related to iscsi_cls_conn, then call
iscsi_put_conn() to free iscsi_cls_conn.

V2 -> V3:
  * Fix some bugs and optimization the code implement.

V1 -> V2:
  * add two more iscsi_free_conn() and iscsi_remove_conn() than V1
  * change the teardown flow of iscsi_cls_conn

Wenchao Hao (3):
  scsi: iscsi: Add helper functions to manage iscsi_cls_conn
  scsi:libiscsi: Add iscsi_cls_conn to sysfs after been initialized
  scsi:libiscsi: teradown iscsi_cls_conn gracefully

 drivers/scsi/libiscsi.c             | 23 +++++---
 drivers/scsi/scsi_transport_iscsi.c | 90 +++++++++++++++--------------
 include/scsi/scsi_transport_iscsi.h |  5 +-
 3 files changed, 66 insertions(+), 52 deletions(-)

-- 
2.32.0

