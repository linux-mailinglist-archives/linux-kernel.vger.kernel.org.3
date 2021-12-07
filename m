Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9955E46C7A0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242278AbhLGWoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:44:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27830 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232475AbhLGWoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638916847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dc3k+a7/fq/cwVCEtRZxiDaCp7bjEz2vnqprGXYHsaI=;
        b=Hg5EHf+N/Y5Tz0nN+MJcdiHTQm0Bxaghj8r4P2oOVn+ceg13MrUgGkDapK2Y2wI9oV/6ci
        4pcpxgGR+iIWq8LwSw1L+I60AvQejQ2pgXXDfUPu4WDGkKpui1Nw9FP1VeOpvIlB3DPf5r
        vjUelS+xh1CYERdkQjMKTNHVZapmONU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-0Ya5XjeiMSKNHLp9HgQbUQ-1; Tue, 07 Dec 2021 17:40:43 -0500
X-MC-Unique: 0Ya5XjeiMSKNHLp9HgQbUQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D19548015B7;
        Tue,  7 Dec 2021 22:40:41 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.22.32.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9417119C59;
        Tue,  7 Dec 2021 22:40:20 +0000 (UTC)
From:   Nico Pache <npache@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     shakeelb@google.com, ktkhai@virtuozzo.com, shy828301@gmail.com,
        guro@fb.com, vbabka@suse.cz, vdavydov.dev@gmail.com,
        raquini@redhat.com, mhocko@suse.com, david@redhat.com
Subject: [PATCH v2 0/1] Dont allocate pages on a offline node
Date:   Tue,  7 Dec 2021 17:40:12 -0500
Message-Id: <20211207224013.880775-1-npache@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent page allocations from occuring on an offlined by adding a check
to confirm the node is online and if not, use the closest node. Some
further work is needed for my previous solution to be complete. This
will provide a fix to the problem while the more complete solution is
being worked on.

V2:
 * drop the first patch that will introduce a regression by adding a
   branch in the hotpath.
 * Remove the for_each_online_nodes introduced as that will require
   further work for memcg and hotplug to work correctly. Long term a
   rework will be needed to either allocate all pgdatas or update all
   memcgs when a new node is onlined.

Signed-off-by: Nico Pache <npache@redhat.com>

Nico Pache (1):
  mm/vmscan.c: Prevent allocating shrinker_info on offlined nodes

 mm/vmscan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.33.1

