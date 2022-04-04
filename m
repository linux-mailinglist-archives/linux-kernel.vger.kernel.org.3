Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F30B4F1E01
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382412AbiDDVvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379204AbiDDQnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:43:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A450F35856;
        Mon,  4 Apr 2022 09:41:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2E1961F390;
        Mon,  4 Apr 2022 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649090481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bei0JZDnlsbNqP4J+qIzBne1zsUAj2g0RJqQ6r2Qiqw=;
        b=i0ObrEE+b2RebhFzMnlcKdL0BqgE865TCRWCuhUnAv17qBxbGvIcJplUrQaMTs8YblHn+x
        JVYozogrIS2Flhw1EeDSlj69/ISgAxaOJXo8Mn306ngj4wFWuSk/ION7LdkcmFuho1kt6R
        AVD9SLP//1+twgSKqikQFnTX4ieiAgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649090481;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bei0JZDnlsbNqP4J+qIzBne1zsUAj2g0RJqQ6r2Qiqw=;
        b=pjR4WFPCNtrEDWu4FIUpx1x9XcuuyDgEQPSsLzovOSperD09sJK2XCWlVGiXuHNbagn1dx
        JIOhyrVxO5bavqCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC0B112FC5;
        Mon,  4 Apr 2022 16:41:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yPnrOLAfS2LjfAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 04 Apr 2022 16:41:20 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Marco Elver <elver@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Subject: [PATCH v3 6/6] slab, documentation: add description of debugfs files for SLUB caches
Date:   Mon,  4 Apr 2022 18:41:12 +0200
Message-Id: <20220404164112.18372-7-vbabka@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220404164112.18372-1-vbabka@suse.cz>
References: <20220404164112.18372-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3418; i=vbabka@suse.cz; h=from:subject; bh=aiEHhTlwaPsxqCPnZoF+zACTkJmNyiCa8U4FMIlm4hU=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBiSx+n9eEtd8BOf/2A9Gbbt9oR1Y/79g1fBU4U6ywZ pM9StUiJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYksfpwAKCRDgIcpz8YmpEECtB/ 9deLfjoG4HXeZchPe/4/vX8Z2LlMjZ83wdxrA0d76J0Ln8c9FtzXuvRCjAhEdYj2UCH80jXW7fMBWF NDqQnwSChm4yVLEyZ9tpycx4qYoRFuoLCug2IVu6YKqglXKFFdMelZXfeqQT7YszkiDYbUTrfmShc/ fZp5U2dZ32SnH3TCbuM+x9Pe8K1tl9FEX0d4pl7xGrHArnPkyB3cA2wLoFleb0C/ZnuJ8R8cCuZQfG 9VHsYtj7qeRn1sgF6cqJ/ycMZf443uHFR6U/7Up+st7X33szxhjIQPP0hto8IlaHBeI2PS+sRU8viJ kT0X6iWUw5xO/W47QkjQckQ7Ozq0xe
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
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
---
 Documentation/vm/slub.rst | 64 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/vm/slub.rst b/Documentation/vm/slub.rst
index d3028554b1e9..43063ade737a 100644
--- a/Documentation/vm/slub.rst
+++ b/Documentation/vm/slub.rst
@@ -384,5 +384,69 @@ c) Execute ``slabinfo-gnuplot.sh`` in '-t' mode, passing all of the
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
+    Prints information about unique freeing traces of the currently allocated
+    objects. The freeing traces thus come from the previous life-cycle of the
+    objects and are reported as not available for objects allocated for the first
+    time. The output is sorted by frequency of each trace.
+
+    Information in the output:
+    Number of objects, freeing function, minimal/average/maximal jiffies since free,
+    pid range of the freeing processes, cpu mask of freeing cpus, and stack trace.
+
+    Example:::
+
+    1980 <not-available> age=4294912290 pid=0 cpus=0
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

