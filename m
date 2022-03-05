Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52864CE506
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 14:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiCENjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 08:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiCENjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 08:39:52 -0500
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE4A2409C
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 05:39:01 -0800 (PST)
X-QQ-mid: bizesmtp80t1646487530t0ad08pm
Received: from localhost.localdomain ( [114.222.120.105])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 05 Mar 2022 21:38:34 +0800 (CST)
X-QQ-SSF: 01400000002000B0I000B00A0000000
X-QQ-FEAT: F3yR32iATbigXkT0FCE9DsObg5oq/MN3OGcaVKW3SzyBGnuKqNLFJhhrnBSss
        OEeEKWXCYXFgWxlBFjnddgdP3hYrW7Boq5CIhmIdRlax3caNoJd34bgMazPzJnmFaSCfE3U
        irLUm43siAqYb5/xhKRPLiPLZEVIApzI5pl3OhTu1wDyiDdpEL2zhysTrZtfdaROI3Zk+rk
        1rHdciWu44nEdT/JA0tNNTgnCq3sX2lqdwmHvBWyCE27uiY+8eY2pssFLWh7wr/WMrF2ANT
        oVua3dfwqv32zcYaPeEnJ2bhGSnjYDtnkSG9ZN2M1T7NoWMcLMGznKLejy6drQVQBqqpDNF
        ShmC+9yljlPiUI2pvM=
X-QQ-GoodBg: 2
From:   zhanglianjie <zhanglianjie@uniontech.com>
To:     Juergen Gross <jgross@suse.com>,
        David Vrabel <david.vrabel@citrix.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        zhanglianjie <zhanglianjie@uniontech.com>
Subject: [PATCH] drivers/xen: use helper macro __ATTR_RW
Date:   Sat,  5 Mar 2022 21:38:23 +0800
Message-Id: <20220305133823.158961-1-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use helper macro __ATTR_RW to define HYPERVISOR_ATTR_RW to make code more clear.
Minor readability improvement.

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
index feb1d16252e7..fcb0792f090e 100644
--- a/drivers/xen/sys-hypervisor.c
+++ b/drivers/xen/sys-hypervisor.c
@@ -22,11 +22,10 @@
 #endif

 #define HYPERVISOR_ATTR_RO(_name) \
-static struct hyp_sysfs_attr  _name##_attr = __ATTR_RO(_name)
+static struct hyp_sysfs_attr _name##_attr = __ATTR_RO(_name)

 #define HYPERVISOR_ATTR_RW(_name) \
-static struct hyp_sysfs_attr _name##_attr = \
-	__ATTR(_name, 0644, _name##_show, _name##_store)
+static struct hyp_sysfs_attr _name##_attr = __ATTR_RW(_name)

 struct hyp_sysfs_attr {
 	struct attribute attr;
--
2.20.1




