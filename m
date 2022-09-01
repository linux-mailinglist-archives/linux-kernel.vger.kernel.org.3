Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AB55A8BA8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 04:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiIAC7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 22:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbiIAC7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 22:59:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43A2161DF3;
        Wed, 31 Aug 2022 19:59:13 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MJ5Jd716czlWft;
        Thu,  1 Sep 2022 10:55:45 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 10:59:11 +0800
Received: from [127.0.0.1] (10.174.177.249) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 1 Sep
 2022 10:59:10 +0800
To:     <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     linfeilong <linfeilong@huawei.com>,
        wuguanghao <wuguanghao3@huawei.com>, <liuzhiqiang26@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [PATCH v2] xfs: donot need to check return value of xlog_kvmalloc()
Message-ID: <471db2ec-8836-14f5-fb33-579b294943e9@huawei.com>
Date:   Thu, 1 Sep 2022 10:59:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.249]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In xfs_attri_log_nameval_alloc(), xlog_kvmalloc() is called
to alloc memory, which will always return
successfully, so we donot need to check return value.

Reviewed-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
Changelog:
V1 -> V2:
  1.add Reviewed-by: Eric Sandeen <sandeen@redhat.com>
  2.remove santity check of xfs_attri_log_nameval_alloc()
    suggested by Eric Sandeen.

 fs/xfs/xfs_attr_item.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
index 5077a7ad5646..cf5ce607dc05 100644
--- a/fs/xfs/xfs_attr_item.c
+++ b/fs/xfs/xfs_attr_item.c
@@ -86,8 +86,6 @@ xfs_attri_log_nameval_alloc(
 	 */
 	nv = xlog_kvmalloc(sizeof(struct xfs_attri_log_nameval) +
 					name_len + value_len);
-	if (!nv)
-		return nv;

 	nv->name.i_addr = nv + 1;
 	nv->name.i_len = name_len;
@@ -441,8 +439,6 @@ xfs_attr_create_intent(
 		attr->xattri_nameval = xfs_attri_log_nameval_alloc(args->name,
 				args->namelen, args->value, args->valuelen);
 	}
-	if (!attr->xattri_nameval)
-		return ERR_PTR(-ENOMEM);

 	attrip = xfs_attri_init(mp, attr->xattri_nameval);
 	xfs_trans_add_item(tp, &attrip->attri_item);
@@ -762,8 +758,6 @@ xlog_recover_attri_commit_pass2(
 	nv = xfs_attri_log_nameval_alloc(attr_name,
 			attri_formatp->alfi_name_len, attr_value,
 			attri_formatp->alfi_value_len);
-	if (!nv)
-		return -ENOMEM;

 	attrip = xfs_attri_init(mp, nv);
 	error = xfs_attri_copy_format(&item->ri_buf[0], &attrip->attri_format);
-- 
2.33.0

