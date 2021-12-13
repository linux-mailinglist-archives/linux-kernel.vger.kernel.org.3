Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A44472C3E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbhLMM1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:27:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38238 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229766AbhLMM1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:27:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639398462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=AXDQj/M+Kv+QlgV1YzJntHLLjz9azaZev3PPgfKBnRw=;
        b=BMNNPjiwbRxuF0+qrBwtMKPOUQpR6RO/vm3jt3LzxYFJMe+6LhNYqLLCKJEteJeNoNL5TI
        Vchv2G/kFwYTWvMyOQcivVpdhjFdFzllwdM30X2Mn3O6JT73H5x5lb5RD7WAEsp4aaFVSv
        IqG2gUK19m5R193RcBnUxl63w+MX1Ww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-OmAssip9NgygODina39F0A-1; Mon, 13 Dec 2021 07:27:37 -0500
X-MC-Unique: OmAssip9NgygODina39F0A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E08810144E1;
        Mon, 13 Dec 2021 12:27:35 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-202.pek2.redhat.com [10.72.12.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA6F177F29;
        Mon, 13 Dec 2021 12:27:16 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        cl@linux.com, John.p.donnelly@oracle.com,
        kexec@lists.infradead.org, bhe@redhat.com
Subject: [PATCH v3 0/5] Avoid requesting page from DMA zone when no managed pages
Date:   Mon, 13 Dec 2021 20:27:07 +0800
Message-Id: <20211213122712.23805-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Background information can be checked in cover letter of v2 RESEND POST
as below:
https://lore.kernel.org/all/20211207030750.30824-1-bhe@redhat.com/T/#u

Changelog:
v2-Resend -> v3:
 - Re-implement has_managed_dma() according to David's suggestion.
 - Add Fixes tag and cc stable.

v2->v2 RESEND:
 - John pinged to push the repost of this patchset. So fix one typo of
   suject of patch 3/5; Fix a building error caused by mix declaration in
   patch 5/5. Both of them are found by John from his testing.
 - Rewrite cover letter to add more information.

v1->v2:
 Change to check if managed DMA zone exists. If DMA zone has managed
 pages, go further to request page from DMA zone to initialize. Otherwise,
 just skip to initialize stuffs which need pages from DMA zone.
  

V2 RESEND post:
https://lore.kernel.org/all/20211207030750.30824-1-bhe@redhat.com/T/#u

v2 post:
https://lore.kernel.org/all/20210810094835.13402-1-bhe@redhat.com/T/#u

v1 post:
https://lore.kernel.org/all/20210624052010.5676-1-bhe@redhat.com/T/#u


Baoquan He (5):
  docs: kernel-parameters: Update to reflect the current default size of
    atomic pool
  dma-pool: allow user to disable atomic pool
  mm_zone: add function to check if managed dma zone exists
  dma/pool: create dma atomic pool only if dma zone has managed pages
  mm/slub: do not create dma-kmalloc if no managed pages in DMA zone

 Documentation/admin-guide/kernel-parameters.txt |  5 ++++-
 include/linux/mmzone.h                          |  9 +++++++++
 kernel/dma/pool.c                               | 11 +++++++----
 mm/page_alloc.c                                 | 15 +++++++++++++++
 mm/slab_common.c                                |  9 +++++++++
 5 files changed, 44 insertions(+), 5 deletions(-)

-- 
2.17.2

