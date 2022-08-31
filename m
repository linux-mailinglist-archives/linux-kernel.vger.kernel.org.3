Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0F25A7D30
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiHaMXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiHaMXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:23:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E22D3989
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661948626; x=1693484626;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L0YM3ONxeEizbE7TRZN3GSHlQQo2GntyFRjVX1BT5ps=;
  b=bP4XZ67/YWymVQZ+woUax18V0STHVMHGq3jNvCRvltO9IFhIaklS1UPF
   aiGosNDgm458OH/sQ3X9TCp7g79hXu8Z7lXBd1U2EEQOVCQ18xrRiosGU
   TfxbHzq6sFslHie/1l8IoNXa6aG6aZJ5Zeh1tucxJHztdEdJ2Y7bNUdRk
   9GGFEMvsJ6tbm/SuWRtxXaU28oTYUxcm7ceb9I39IAJK8AwyFf5F2xn1J
   7bLd9sUObRBtexUz/WndUdIA71W3XZCLI1qh3Rgc1+Is/XuIKPbOCakYw
   3Cgmqa7RklglKXN1sSsZQmpNXewcx8LvxOoIHxBS+vuFjap9qLfkz3Bau
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="296218481"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="296218481"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 05:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="612079414"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 31 Aug 2022 05:23:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 80F1E174; Wed, 31 Aug 2022 15:23:58 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Shuo Liu <shuo.a.liu@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Fei Li <fei1.li@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 1/1] virt: acrn: Mark the uuid field as unused
Date:   Wed, 31 Aug 2022 15:23:56 +0300
Message-Id: <20220831122356.65544-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the commits for userspace (see Link tags below) the uuid field is
not being used in the ACRN code. Update kernel to reflect these changes.
I.e. we do the following:
- adding a comment explaining that it's not used anymore
- replacing the specific type by a raw buffer
- updating the example code accordingly

The advertised field confused users and actually never been used. So
the wrong part here is that kernel puts something which userspace never
used and hence this may confuse a reader of this code.

Link: https://github.com/projectacrn/acrn-hypervisor/commit/da0d24326ed6
Link: https://github.com/projectacrn/acrn-hypervisor/commit/bb0327e70097
Fixes: 5b06931d7f8b ("sample/acrn: Introduce a sample of HSM ioctl interface usage")
Fixes: 9c5137aedd11 ("virt: acrn: Introduce VM management interfaces")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: converted to Link tags (Rafael), explained what was wrong (Rafael)
v2: added tag (Fei)
 include/uapi/linux/acrn.h | 5 ++---
 samples/acrn/vm-sample.c  | 3 ---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
index ccf47ed92500..04fa83647ae5 100644
--- a/include/uapi/linux/acrn.h
+++ b/include/uapi/linux/acrn.h
@@ -12,7 +12,6 @@
 #define _UAPI_ACRN_H
 
 #include <linux/types.h>
-#include <linux/uuid.h>
 
 #define ACRN_IO_REQUEST_MAX		16
 
@@ -186,7 +185,7 @@ struct acrn_ioreq_notify {
  * @reserved0:		Reserved and must be 0
  * @vcpu_num:		Number of vCPU in the VM. Return from hypervisor.
  * @reserved1:		Reserved and must be 0
- * @uuid:		UUID of the VM. Pass to hypervisor directly.
+ * @uuid:		Reserved (used to be UUID of the VM)
  * @vm_flag:		Flag of the VM creating. Pass to hypervisor directly.
  * @ioreq_buf:		Service VM GPA of I/O request buffer. Pass to
  *			hypervisor directly.
@@ -198,7 +197,7 @@ struct acrn_vm_creation {
 	__u16	reserved0;
 	__u16	vcpu_num;
 	__u16	reserved1;
-	guid_t	uuid;
+	__u8	uuid[16];
 	__u64	vm_flag;
 	__u64	ioreq_buf;
 	__u64	cpu_affinity;
diff --git a/samples/acrn/vm-sample.c b/samples/acrn/vm-sample.c
index b2dad47a77a0..7abd68b20153 100644
--- a/samples/acrn/vm-sample.c
+++ b/samples/acrn/vm-sample.c
@@ -29,8 +29,6 @@ static struct acrn_io_request *io_req_buf = (struct acrn_io_request *)io_request
 
 __u16 vcpu_num;
 __u16 vmid;
-/* POST_STANDARD_VM_UUID1, refer to https://github.com/projectacrn/acrn-hypervisor/blob/master/hypervisor/include/common/vm_uuids.h */
-guid_t vm_uuid = GUID_INIT(0x385479d2, 0xd625, 0xe811, 0x86, 0x4e, 0xcb, 0x7a, 0x18, 0xb3, 0x46, 0x43);
 
 int hsm_fd;
 int is_running = 1;
@@ -63,7 +61,6 @@ int main(int argc, char **argv)
 	}
 	hsm_fd = open("/dev/acrn_hsm", O_RDWR|O_CLOEXEC);
 
-	memcpy(&create_vm.uuid, &vm_uuid, 16);
 	create_vm.ioreq_buf = (__u64)io_req_buf;
 	ret = ioctl(hsm_fd, ACRN_IOCTL_CREATE_VM, &create_vm);
 	printf("Created VM! [%d]\n", ret);
-- 
2.35.1

