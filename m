Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3EB573BC0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 19:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiGMRDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 13:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGMRDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 13:03:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D142528E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 10:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657731786; x=1689267786;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=akj+TBO4xcoAO4r0hxw1BS7KiEv34GHE3FWUEfy/7l0=;
  b=hlDxsUaErsBJx9zoM7HM1BS5afhGbz76TlsnXZ3vZIAybPcgPEqYAvLh
   K3ECCeDr1dtf1sgulN+cS5kwG8k6Ly92s+EpU4546iaWYZb5XukFRE72w
   2ZV1e7ilbI5zrUBTCE0zCDv6Nrtz8O5NupCNwaSssq+JdS/tgG9jrrGka
   sFcSmrEqSXFjb3EJ3Nh+83zTyXY3TiiVp3s6zHocBnSUbiTWIKkk6KksO
   68ZmOrZKaTen98nkrsA+wdQqepT5TvQxbj5kuI4azgI9ESeFEw4KEjr5K
   QJ66NbSf9yLf8mNQVG7BTbH+fD+5EOumf4YTHiU0y0QBnBTajVSJtRQEx
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="349256524"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="349256524"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 10:02:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="737954680"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jul 2022 10:02:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AB567F1; Wed, 13 Jul 2022 20:02:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Fei Li <fei1.li@intel.com>, Shuo Liu <shuo.a.liu@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 1/1] virt: acrn: Mark the uuid field as unused
Date:   Wed, 13 Jul 2022 20:02:39 +0300
Message-Id: <20220713170239.84362-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the commits for userspace [1][2] the uuid field is not being
used in the ACRN code. Update kernel to reflect these changes.
I.e. we do the following:
- adding a comment explaining that it's not used anymore
- replacing the specific type by a raw buffer
- updating the example code accordingly

[1]: https://github.com/projectacrn/acrn-hypervisor/commit/da0d24326ed6
[2]: https://github.com/projectacrn/acrn-hypervisor/commit/bb0327e70097

Fixes: 5b06931d7f8b ("sample/acrn: Introduce a sample of HSM ioctl interface usage")
Fixes: 9c5137aedd11 ("virt: acrn: Introduce VM management interfaces")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Fei Li <fei1.li@intel.com>
---
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

