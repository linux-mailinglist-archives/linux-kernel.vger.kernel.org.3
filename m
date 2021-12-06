Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A247D468FBA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 04:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbhLFDhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 22:37:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39863 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236194AbhLFDhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 22:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638761662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=n5oc0wDl7UWuJyJPykXMInKWer6Lbzbx5MvcEoFOwbQ=;
        b=XQNpy8wLy9vOW05a3HusFtXhRBBvTfC6maczXPgexzRYMUNHWIbZB9XFk6CFu6njBccpXj
        f8qtrR6ij2M5eh/+06W15YwYLfsUhr2XeIpqyGdNOb6rg0+KWwMSX6zDJdcwL5jIFC7ng3
        VTcifUUDU6HMGb8qtQFCVW4itFcIjJA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-80jAtYPYPy-qslHQs-RcMw-1; Sun, 05 Dec 2021 22:34:19 -0500
X-MC-Unique: 80jAtYPYPy-qslHQs-RcMw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC4D22F23;
        Mon,  6 Dec 2021 03:34:17 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.22.16.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 439445BAE2;
        Mon,  6 Dec 2021 03:34:16 +0000 (UTC)
From:   Nico Pache <npache@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     shakeelb@google.com, ktkhai@virtuozzo.com, shy828301@gmail.com,
        guro@fb.com, vbabka@suse.cz, vdavydov.dev@gmail.com,
        raquini@redhat.com
Subject: [RFC PATCH 0/2] mm: Dont allocate pages on a offline node
Date:   Sun,  5 Dec 2021 22:33:36 -0500
Message-Id: <20211206033338.743270-1-npache@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent page allocations from occuring on an offlined node by adding a
check in _alloc_pages_node and correcting the use of for_each_node when
allocating shrinkers.

The first patch is more of a defensive check while the second patch
directly relates to an issue we have found during testing.

Signed-Off-by: Nico Pache <npache@redhat.com>

Nico Pache (2):
  include/linux/gfp.h: Do not allocate pages on a offlined node
  mm/vmscan.c: Prevent allocating shrinker_info on offlined nodes

 include/linux/gfp.h | 5 ++++-
 mm/vmscan.c         | 8 ++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.33.1

