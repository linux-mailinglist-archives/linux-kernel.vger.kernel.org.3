Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACFE577A28
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 06:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbiGREnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 00:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGREnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 00:43:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A55DF10551
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 21:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658119390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PJGZghyUiQePHBonFW3MIUSnC6/CE48ju67sSDQu/Pk=;
        b=IOGe+5Yie7HGeZNXeGXBAiHPYGYmA/CiW9vCZA/M3VEywE7C5sBF2G9pJastLKaAa+eV+5
        YvTrTDDZAHeyGHBz4Y79flG1mJh7X2fkODtHi3CPgAhI4RKQbCl1lzVWbLugLScKCcSYNx
        EcyVtfUj0eqma/Xhh6Nyv/8VNqW2+7I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-hm-2lRIaPqGlawZ9S1fbHg-1; Mon, 18 Jul 2022 00:43:05 -0400
X-MC-Unique: hm-2lRIaPqGlawZ9S1fbHg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACEFD3C0CD42;
        Mon, 18 Jul 2022 04:43:04 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-37.bne.redhat.com [10.64.54.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C3F11121314;
        Mon, 18 Jul 2022 04:43:02 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH] arm64: numa: Don't check node against MAX_NUMNODES
Date:   Mon, 18 Jul 2022 14:42:32 +0800
Message-Id: <20220718064232.3464373-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the NUMA nodes are sorted by checking ACPI SRAT (GICC AFFINITY)
sub-table, it's impossible for acpi_map_pxm_to_node() to return
any value, which is greater than or equal to MAX_NUMNODES. Lets drop
the unnecessary check in acpi_numa_gicc_affinity_init().

No functional change intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kernel/acpi_numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
index fdfecf0991ce..e51535a5f939 100644
--- a/arch/arm64/kernel/acpi_numa.c
+++ b/arch/arm64/kernel/acpi_numa.c
@@ -109,7 +109,7 @@ void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
 	pxm = pa->proximity_domain;
 	node = acpi_map_pxm_to_node(pxm);
 
-	if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
+	if (node == NUMA_NO_NODE) {
 		pr_err("SRAT: Too many proximity domains %d\n", pxm);
 		bad_srat();
 		return;
-- 
2.23.0

