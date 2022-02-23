Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49394C1151
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbiBWLdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237515AbiBWLdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:33:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72F7537BEF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645615972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9zlGa6br0c39oKdANUse/M0gLmRqJHCFXxLHhx7TVM4=;
        b=aaNKrJgUvZdmoXt2MoHpO/Ru15BPLY8hdmLvqI3QB5lvRV0kFB/pg5Lze8DQnfjLxD+tFE
        x7RmL4yw6mRccrj/XqFOM47bSK0rpbo7TgFz7FD4oO4iSwxEmCpe9zniY/UH0C2F8rUzb5
        GAPiguKnIyh+pdcuas/ni8bZ1gzTZvg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-CNeKcLYINQq7yFV3u3g-Ew-1; Wed, 23 Feb 2022 06:32:49 -0500
X-MC-Unique: CNeKcLYINQq7yFV3u3g-Ew-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1773D1091DA2;
        Wed, 23 Feb 2022 11:32:48 +0000 (UTC)
Received: from MiWiFi-R3L-srv.smartont.net (ovpn-13-167.pek2.redhat.com [10.72.13.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78D54797CE;
        Wed, 23 Feb 2022 11:32:35 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, dyoung@redhat.com,
        akpm@linux-foundation.org, bhe@redhat.com, x86@kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 0/2] x86/kexec: fix memory leak of elf header buffer
Date:   Wed, 23 Feb 2022 19:32:23 +0800
Message-Id: <20220223113225.63106-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory leak is reported by kmemleak detector, has been existing
for very long time. It casue much memory loss on large machine
with huge memory hotplug which will trigger kdump kernel reloading
many times, with kexec_file_load interface.

And in patch 2, clean up is done to remove unneeded
arch_kexec_kernel_image_load() and rename functions.

V1 post can be found here:
https://lore.kernel.org/all/20211029072424.9109-1-bhe@redhat.com/T/#u

v1->v2:
 No code change. The v1 post has been acked by Dave Young but not
merged. In v2, just merging the old patch 1 and 2 as per Dave's concern
in v1 post.

Baoquan He (2):
  x86/kexec: fix memory leak of elf header buffer
  kexec_file: clean up arch_kexec_kernel_image_load

 arch/x86/kernel/machine_kexec_64.c | 23 +++++++++--------------
 include/linux/kexec.h              |  1 -
 kernel/kexec_file.c                |  9 ++-------
 3 files changed, 11 insertions(+), 22 deletions(-)

-- 
2.31.1

