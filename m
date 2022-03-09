Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817DF4D3754
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbiCIRYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237044AbiCIRYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:24:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C29782D01;
        Wed,  9 Mar 2022 09:23:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 794F361073;
        Wed,  9 Mar 2022 17:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A497C340E8;
        Wed,  9 Mar 2022 17:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646846586;
        bh=mSXOxDm0YQ/4bRgksAVQhm0M51442VyGvpFWc/rjdAg=;
        h=From:To:Cc:Subject:Date:From;
        b=hwmGntSJzO+BOdWggrE8RO+wwrUWI5gbLemWvf6pRnlLQT3jdEGQn6/I2fNO0Kahh
         4PwGFv0QZsr/4eNoxgttSNHt0mCaU1IaxO8rRyXD0E7UeZ+WgRTErF193RDDP4c10h
         Efh3Akk9SCJYaK020CxPZrQlmQCGLsI2kGwi6ThM0rJoGgrJjPOKT9Ym/SMeediYrx
         AmCoB6t3UphglNfOrXN96U+9h1bIakCmmGCuaDafwuHFGtZTYtagakME47Gm9HHerH
         dN+CBm5CnUaD1LpKhSNb8v5MaiJVTd6BMFjyBbP9o6lcqs3EaaBxq+i7Id9IGVbzxg
         vry6HNW6enpRg==
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
Subject: [PATCH v2] docs/kernel-parameters: update description of mem=
Date:   Wed,  9 Mar 2022 19:22:58 +0200
Message-Id: <20220309172258.1183796-1-rppt@kernel.org>
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
v1: https://lore.kernel.org/all/20220309122446.1118738-1-rppt@kernel.org
* drop clumsy and redundant paragraph about Hexagon

 .../admin-guide/kernel-parameters.txt          | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f5a27f067db9..40cd4136331b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2834,6 +2834,13 @@
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
@@ -2844,6 +2851,17 @@
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
+	mem=nn[KMG]	[HEXAGON] Set the memory size.
+			Must be specified, otherwise memory size will be 0.
+
 	mem=nopentium	[BUGS=X86-32] Disable usage of 4MB pages for kernel
 			memory.
 
-- 
2.34.1

