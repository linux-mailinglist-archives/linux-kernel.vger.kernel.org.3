Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDD9591018
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 13:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237221AbiHLLdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 07:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236894AbiHLLdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 07:33:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1ECAE9F3;
        Fri, 12 Aug 2022 04:33:19 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M41gd1vHYzlW1W;
        Fri, 12 Aug 2022 19:30:21 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 19:33:17 +0800
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 19:33:16 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <rafael@kernel.org>, <lenb@kernel.org>,
        <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH] ACPI: property: Fix mis-use of _Generic()
Date:   Fri, 12 Aug 2022 19:33:08 +0800
Message-ID: <20220812113308.1772-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks wrong to pass __val as the control-expression of _Generic() which
will always return 0U this way and acpi_copy_property_array_uint() is
likely to return -EOVERFLOW error whilst it actually doesn't.

Use __val[i] to match the given type list.

Fixes: 923044133367 ("ACPI: property: Unify integer value reading functions")
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/acpi/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 7b3ad8ed2f4e..1ededa618a88 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1042,7 +1042,7 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
 				ret = -EPROTO;				\
 				break;					\
 			}						\
-			if (__items[i].integer.value > _Generic(__val,	\
+			if (__items[i].integer.value > _Generic(__val[i], \
 								u8: U8_MAX, \
 								u16: U16_MAX, \
 								u32: U32_MAX, \
-- 
2.33.0

