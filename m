Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E194D427A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240331AbiCJI2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240326AbiCJI2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:28:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8DC41312;
        Thu, 10 Mar 2022 00:27:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B40BB8254B;
        Thu, 10 Mar 2022 08:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A27CC340E8;
        Thu, 10 Mar 2022 08:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646900863;
        bh=lH6TNST8z+31kpvCNG8FuLutvp8PxFIvRRmTnLYxqCw=;
        h=From:To:Cc:Subject:Date:From;
        b=DQegw6R5caHc88KySqVtU1vH86//yELhBTtsmfAnD12HZsUdI7G2QvqpH0QQeqMwX
         QQ5ohxya3KLIHlBinvH57fX5ED4ji1IpiV60pX9v+hJMOn4igo3J6d5stPpbvlWvw0
         IS0wfHyGXTsdnowDoiEdIqGYWMz+siZ6n6d5GfAoiiLPkUYEr8K9rxXCzfZjqefnyA
         w426wDkwnYMcazj6cIEvu1Fgwmlbo3jsUbvIbSrwsW/MvT17zWpXUqbaK3nEX+9gBB
         gBWLU7h4Zepz+1JHkyk70RbwzdMWkPeByENTonVstUGhZyFaBS9x+dnu4gPx9DStV3
         Nia9AZme1QDAQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Mike Rapport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] docs/kernel-parameters: update description of mem=
Date:   Thu, 10 Mar 2022 10:27:36 +0200
Message-Id: <20220310082736.1346366-1-rppt@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The existing description of mem= does not cover all the cases and
differences between how architectures treat it.

Extend the description to match the code.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
v2: https://lore.kernel.org/all/20220309172258.1183796-1-rppt@kernel.org
* move Hexagon description to make it better visible

v1: https://lore.kernel.org/all/20220309122446.1118738-1-rppt@kernel.org
* drop clumsy and redundant paragraph about Hexagon
 .../admin-guide/kernel-parameters.txt          | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f5a27f067db9..5b84cca62990 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2827,6 +2827,9 @@
 
 			For details see: Documentation/admin-guide/hw-vuln/mds.rst
 
+	mem=nn[KMG]	[HEXAGON] Set the memory size.
+			Must be specified, otherwise memory size will be 0.
+
 	mem=nn[KMG]	[KNL,BOOT] Force usage of a specific amount of memory
 			Amount of memory to be used in cases as follows:
 
@@ -2834,6 +2837,13 @@
 			2 when the kernel is not able to see the whole system memory;
 			3 memory that lies after 'mem=' boundary is excluded from
 			 the hypervisor, then assigned to KVM guests.
+			4 to limit the memory available for kdump kernel.
+
+			[ARC,MICROBLAZE] - the limit applies only to low memory,
+			high memory is not affected.
+
+			[ARM64] - only limits memory covered by the linear
+			mapping. The NOMAP regions are not affected.
 
 			[X86] Work as limiting max address. Use together
 			with memmap= to avoid physical address space collisions.
@@ -2844,6 +2854,14 @@
 			in above case 3, memory may need be hot added after boot
 			if system memory of hypervisor is not sufficient.
 
+	mem=nn[KMG]@ss[KMG]
+			[ARM,MIPS] - override the memory layout reported by
+			firmware.
+			Define a memory region of size nn[KMG] starting at
+			ss[KMG].
+			Multiple different regions can be specified with
+			multiple mem= parameters on the command line.
+
 	mem=nopentium	[BUGS=X86-32] Disable usage of 4MB pages for kernel
 			memory.
 
-- 
2.34.1

