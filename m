Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4868D4786B9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbhLQJIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:08:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54508 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233996AbhLQJIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:08:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639732118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MbKEnIMqozJmjIU2Viw6TRTg5VDB7tuZyWJ3ztwdV1w=;
        b=TAZ1vSc+55EYecV6SWm/98+c0O+YKNTBfELIo3xC6S2Dyb5qEuC+5fRBSfaYgFcfueAWlT
        OGt+m3lKpr5rIIl2e9P1AoJ6cuwOiBLQNyWz7UsZhBTdt9u0HObf8bNwZGTvBifwoZuz24
        fPE4axpzGttXRRGDTB7aEcQGsYiU7fY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-xS8qT_EzPv6xrFQI-00Jsw-1; Fri, 17 Dec 2021 04:08:33 -0500
X-MC-Unique: xS8qT_EzPv6xrFQI-00Jsw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E19BF1017968;
        Fri, 17 Dec 2021 09:08:31 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-164.pek2.redhat.com [10.72.12.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3D297A498;
        Fri, 17 Dec 2021 09:08:28 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, corbet@lwn.net,
        hch@lst.de, cl@linux.com, bhe@redhat.com
Subject: [PATCH 0/2] Clean up document and small improvement of atomic pool
Date:   Fri, 17 Dec 2021 17:08:25 +0800
Message-Id: <20211217090827.101938-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains two small patches. Identified this when I tried
to fix a kdump bug that page allocation failure is always warned out
during kdump kernel on x86_64. Since dma atomic pool is initialized very
early during bootup, that allocation failure is always triggered in
dma_atomic_pool_init() firstly. I originally planned to add an kernel
option to disable each of the three dma atomic pool. Finally I realized
it's not only dma atomic pool getting the issue, any later requsting
page from DMA zone will fail. So I changed solution to fix the kdump bug.
While the document clean up and the small fix which allows user to
disable atomic pool makes sense to improve. The small fix which makes
'coherent_pool=0' disable dma atomic pool like 'cma=0', looks more
reasonable than the old behavioud which will take the default atomic
size.

[PATCH RESEND v2 0/5] Avoid requesting page from DMA zone when no managed pages
https://lore.kernel.org/all/20211207030750.30824-1-bhe@redhat.com/T/#u



Baoquan He (2):
  docs: kernel-parameters: Update to reflect the current default size of
    atomic pool
  dma-pool: allow user to disable atomic pool

 Documentation/admin-guide/kernel-parameters.txt | 5 ++++-
 kernel/dma/pool.c                               | 7 +++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.26.0

