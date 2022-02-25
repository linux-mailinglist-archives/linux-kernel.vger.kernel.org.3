Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBFC4C4D35
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbiBYSEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbiBYSE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:04:26 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D76278C87;
        Fri, 25 Feb 2022 10:03:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5EAE41F44A;
        Fri, 25 Feb 2022 18:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645812232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Yfx6BYjupT6FJvPBiP/J6fWBiTk107w6SeEj7q5Klk=;
        b=r3D13KGnpbppsRc9ii4T3MVnbZvbDjeh6yA6fQk7REw/+y+ZXzlktrZItPebE7krOc99xc
        TzS3d3sDIVyPqWxY8Xlgo2aAcTfVNvyWHgYJUcvRHhak60KuhKWhRcuR/vvyW21NeeJIZk
        t1fQ+KavQ7Bm4nwRAZvFAFB5KqsuVQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645812232;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Yfx6BYjupT6FJvPBiP/J6fWBiTk107w6SeEj7q5Klk=;
        b=nVmGh+q4eZWpix4pbXiN1758PxD8VAfz1Am5Gz53Wz110bSoIsAkKRRrdINxdhsApPsSWB
        CpPYX3D6UBHMulBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2EDE513EA7;
        Fri, 25 Feb 2022 18:03:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yKLVCggaGWKSRQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 25 Feb 2022 18:03:52 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Subject: [PATCH 5/5] slab, documentation: add description of debugfs files for SLUB caches
Date:   Fri, 25 Feb 2022 19:03:18 +0100
Message-Id: <20220225180318.20594-6-vbabka@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225180318.20594-1-vbabka@suse.cz>
References: <20220225180318.20594-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3076; i=vbabka@suse.cz; h=from:subject; bh=Z5xj7PzTOFSpE0pbr9lBjpkfetxkbHzTO1UejCdWQ8s=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBiGRnl7O4Oyi/9lFUUrqVMZhZ+sJjFUodWofVv+pRg xGljxtiJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYhkZ5QAKCRDgIcpz8YmpEATlB/ 9C6Oy0ADNsAs+rGleFVl1L9e7F1la8CZjE3ErKtX85TVjMuqT1HKpQ6muldsYcC/SUyUfeArKVLgnM 6Tl6j546wWnlAVosCWzv8VUKAMd38RPN3iqGTDrkAwOi7BipFHg7tFX1qY5ILSKs2otLDQ7I8WjZaf GgvBhm41OPN6BLpLF181bxz19jgTlSJjlXtK7RGlsqfiSO6eCzfgbXo5l1wDbQQqobtl2uUCxeDF0m sw0U3kCDx/dU4NvK/CrsVbqXma1grWuKaXAIMZoDAXaGMRd5YlZjIXn7Ng9BR+lVMj8z1i5GjumQTb gBdgcKqYgjHh9BG8Jz+OCIoZq2xSnJ
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Glitta <glittao@gmail.com>

Add description of debugfs files alloc_traces and free_traces
to SLUB cache documentation.

[ vbabka@suse.cz: some rewording ]

Signed-off-by: Oliver Glitta <glittao@gmail.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org
---
 Documentation/vm/slub.rst | 61 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/Documentation/vm/slub.rst b/Documentation/vm/slub.rst
index d3028554b1e9..2b2b931e59fc 100644
--- a/Documentation/vm/slub.rst
+++ b/Documentation/vm/slub.rst
@@ -384,5 +384,66 @@ c) Execute ``slabinfo-gnuplot.sh`` in '-t' mode, passing all of the
       40,60`` range will plot only samples collected between 40th and
       60th seconds).
 
+
+DebugFS files for SLUB
+======================
+
+For more information about current state of SLUB caches with the user tracking
+debug option enabled, debugfs files are available, typically under
+/sys/kernel/debug/slab/<cache>/ (created only for caches with enabled user
+tracking). There are 2 types of these files with the following debug
+information:
+
+1. alloc_traces::
+
+    Prints information about unique allocation traces of the currently
+    allocated objects. The output is sorted by frequency of each trace.
+
+    Information in the output:
+    Number of objects, allocating function, minimal/average/maximal jiffies since alloc,
+    pid range of the allocating processes, cpu mask of allocating cpus, and stack trace.
+
+    Example:::
+
+    1085 populate_error_injection_list+0x97/0x110 age=166678/166680/166682 pid=1 cpus=1::
+	__slab_alloc+0x6d/0x90
+	kmem_cache_alloc_trace+0x2eb/0x300
+	populate_error_injection_list+0x97/0x110
+	init_error_injection+0x1b/0x71
+	do_one_initcall+0x5f/0x2d0
+	kernel_init_freeable+0x26f/0x2d7
+	kernel_init+0xe/0x118
+	ret_from_fork+0x22/0x30
+
+
+2. free_traces::
+
+    Prints information about unique free traces of the currently free objects,
+    sorted by their frequency.
+
+    Information in the output:
+    Number of objects, freeing function, minimal/average/maximal jiffies since free,
+    pid range of the freeing processes, cpu mask of freeing cpus, and stack trace.
+
+    Example:::
+
+    51 acpi_ut_update_ref_count+0x6a6/0x782 age=236886/237027/237772 pid=1 cpus=1
+	kfree+0x2db/0x420
+	acpi_ut_update_ref_count+0x6a6/0x782
+	acpi_ut_update_object_reference+0x1ad/0x234
+	acpi_ut_remove_reference+0x7d/0x84
+	acpi_rs_get_prt_method_data+0x97/0xd6
+	acpi_get_irq_routing_table+0x82/0xc4
+	acpi_pci_irq_find_prt_entry+0x8e/0x2e0
+	acpi_pci_irq_lookup+0x3a/0x1e0
+	acpi_pci_irq_enable+0x77/0x240
+	pcibios_enable_device+0x39/0x40
+	do_pci_enable_device.part.0+0x5d/0xe0
+	pci_enable_device_flags+0xfc/0x120
+	pci_enable_device+0x13/0x20
+	virtio_pci_probe+0x9e/0x170
+	local_pci_probe+0x48/0x80
+	pci_device_probe+0x105/0x1c0
+
 Christoph Lameter, May 30, 2007
 Sergey Senozhatsky, October 23, 2015
-- 
2.35.1

