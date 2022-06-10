Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DDE5462BB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347410AbiFJJr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347199AbiFJJrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:47:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E2CE2E9DE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654854464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Iej305ZrS3cI+u8eOot8avD0go/WsD4iT9qMHnSK6K8=;
        b=SNP+yHWlj9ee7Kjz+rm2eMZ+cASbmxc/zaxI4Y55FOVtfCjK65qCjzfnDLxlv5x3uuso52
        HCKgH2BsQI8DwGHp3mDSOlpR0wqU37zm5cl5evCKhULmRSvrYSvdfikKM7i9/asEhRJznp
        5223/w6JJW/DkVVi8iR+1DZmpQeRkbI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-CD6ZHAqePD205X0fXSOnrQ-1; Fri, 10 Jun 2022 05:47:41 -0400
X-MC-Unique: CD6ZHAqePD205X0fXSOnrQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9E8D801E67;
        Fri, 10 Jun 2022 09:47:40 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B05818EA7;
        Fri, 10 Jun 2022 09:47:38 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Gavin Shan <gshan@redhat.com>
Subject: [PATCH v1] drivers/virtio: Clarify CONFIG_VIRTIO_MEM for unsupported architectures
Date:   Fri, 10 Jun 2022 11:47:37 +0200
Message-Id: <20220610094737.65254-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's make it clearer that simply unlocking CONFIG_VIRTIO_MEM on an
architecture is most probably not sufficient to have it working as
expected.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/Kconfig | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index b5adf6abd241..f86b6a988b63 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -115,9 +115,11 @@ config VIRTIO_MEM
 	 This driver provides access to virtio-mem paravirtualized memory
 	 devices, allowing to hotplug and hotunplug memory.
 
-	 This driver was only tested under x86-64 and arm64, but should
-	 theoretically work on all architectures that support memory hotplug
-	 and hotremove.
+	 This driver currently only supports x86-64 and arm64. Although it
+	 should compile on other architectures that implement memory
+	 hot(un)plug, architecture-specific and/or common
+	 code changes may be required for virtio-mem, kdump and kexec to work as
+	 expected.
 
 	 If unsure, say M.
 
-- 
2.35.3

