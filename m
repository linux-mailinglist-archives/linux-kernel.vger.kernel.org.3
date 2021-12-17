Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A077A4786BA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbhLQJIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:08:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60045 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234014AbhLQJIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639732119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sT+g3CTtmuJQa5zGo6KTILdE5kw3zymgexb1EZSOqJ0=;
        b=bFeBFbpgAalirjuPM4YvF16ahzoEMR9jTG59g4pmPkOvrx0MYX5S9DnUCpv4p0JFVu42KK
        95ZFu4wmcwk26zRKi71Ki8P7xrICRFd52Ff7O5XTQWEiW8pjuL0e0ROJhTp09DQQqEeisZ
        yUbJjt09m/Ms1x+Wg/bCzL9Ok/AUgU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-PY05FEHuPQCSFtN73MMsaA-1; Fri, 17 Dec 2021 04:08:36 -0500
X-MC-Unique: PY05FEHuPQCSFtN73MMsaA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F369593A8;
        Fri, 17 Dec 2021 09:08:35 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-164.pek2.redhat.com [10.72.12.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E6CD7A488;
        Fri, 17 Dec 2021 09:08:32 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, corbet@lwn.net,
        hch@lst.de, cl@linux.com, bhe@redhat.com
Subject: [PATCH 1/2] docs: kernel-parameters: Update to reflect the current default size of atomic pool
Date:   Fri, 17 Dec 2021 17:08:26 +0800
Message-Id: <20211217090827.101938-2-bhe@redhat.com>
In-Reply-To: <20211217090827.101938-1-bhe@redhat.com>
References: <20211217090827.101938-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 1d659236fb43("dma-pool: scale the default DMA coherent pool
size with memory capacity"), the default size of atomic pool has been
changed to take by scaling with system memory capacity. So update the
document in kerenl-parameter.txt accordingly.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9725c546a0d4..ec4d25e854a8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -664,7 +664,9 @@
 
 	coherent_pool=nn[KMG]	[ARM,KNL]
 			Sets the size of memory pool for coherent, atomic dma
-			allocations, by default set to 256K.
+			allocations. Otherwise the default size will be scaled
+			with memory capacity, while clamped between 128K and
+			1 << (PAGE_SHIFT + MAX_ORDER-1).
 
 	com20020=	[HW,NET] ARCnet - COM20020 chipset
 			Format:
-- 
2.26.0

