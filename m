Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9B74647D7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347230AbhLAHXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:23:22 -0500
Received: from esa11.hc1455-7.c3s2.iphmx.com ([207.54.90.137]:62323 "EHLO
        esa11.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347207AbhLAHXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:23:21 -0500
IronPort-SDR: uTHmd4yy9h88suelOl1038q0rHlv1nfx9zJ2+F4cCLM7pihh67L+o3BHFDq3EnFX0jTPaSLHaF
 q785b6ez9PfM7L3e8Ll994QDVJJgq+2mKN4swsGavE2QNvH7FoWLAO4mJZNlToUhclzUbSxgqW
 YIbC3qbfXJNbdBA5accYCWVeokJppiYUf0WGnp9Ym6NM+SD7yhZYi2bg8uWlmzLxh1vIWRQc0S
 cv4szuCxc6e7/xt7NU8tW+VOPtrDpaPH3RPBkVLlMuAKAMl+D6yRdpASI6lMxTL477RvgcAgGB
 eSXTDyaBSF0Cd2z6TQmFpEVb
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="34210207"
X-IronPort-AV: E=Sophos;i="5.87,278,1631545200"; 
   d="scan'208";a="34210207"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 01 Dec 2021 16:19:59 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 19C59E0404
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 16:19:58 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id F32A2EA0EC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 16:19:56 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id 953704007EDD3;
        Wed,  1 Dec 2021 16:19:56 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     linux-kernel@vger.kernel.org, riel@redhat.com,
        mchehab+huawei@kernel.org, will@kernel.org,
        catalin.marinas@arm.com, gregkh@linuxfoundation.org,
        corbet@lwn.net, ionela.voinescu@arm.com, pcc@google.com,
        bilbao@vt.edu, matorola@gmail.com, rafael@kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH] docs: document the sysfs ABI for "nohz_full" and "isolated"
Date:   Wed,  1 Dec 2021 16:18:52 +0900
Message-Id: <20211201071852.3568489-1-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing documentation of sysfs ABI for "nohz_full" and "isolated".
"nohz_full" was added by commit 6570a9a1ce3a("show nohz_full cpus in
sysfs") and "isolated" was added by commit 59f30abe94bf("show isolated
cpus in sysfs"). However, there is no documentation for these
interface.

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 69c65da16dff..a9d5d87b6a41 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -666,3 +666,16 @@ Description:	Preferred MTE tag checking mode
 		================  ==============================================
 
 		See also: Documentation/arm64/memory-tagging-extension.rst
+
+What:		/sys/devices/system/cpu/nohz_full
+		/sys/devices/system/cpu/isolated
+Date:		Apr 2015
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	information about CPU isolation.
+
+		nohz_full: (RO) the list of CPUs that are in nohz_full mode.
+			   These CPUs are set by boot parameter "nohz_full=".
+
+		isolated: (RO) the list of CPUs that are isolated and don't
+			  participate in load balancing. These CPUs are set by
+			  boot parameter "isolcpus=".
-- 
2.27.0

