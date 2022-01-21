Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCEC495F72
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 14:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350492AbiAUNJO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Jan 2022 08:09:14 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:32479 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347711AbiAUNJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:09:13 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-doWXCRcfM-qAes0kr1kiQQ-1; Fri, 21 Jan 2022 08:09:09 -0500
X-MC-Unique: doWXCRcfM-qAes0kr1kiQQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85879100C609;
        Fri, 21 Jan 2022 13:09:07 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB67378AA8;
        Fri, 21 Jan 2022 13:09:03 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Cc:     Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Serge Hallyn <serge@hallyn.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Vasily Averin <vvs@virtuozzo.com>
Subject: [RFC PATCH v3 0/4] ipc: Store mq and ipc sysctls in the ipc namespace
Date:   Fri, 21 Jan 2022 14:08:37 +0100
Message-Id: <cover.1642769810.git.legion@kernel.org>
In-Reply-To: <87tuebwo99.fsf@email.froward.int.ebiederm.org>
References: <87tuebwo99.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=legion@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset changes the implementation of mq and ipc sysctls. It moves the
sysctls inside the ipc namespace.This will allow us to manage these sysctls
inside the user namespace. The implementation also removes helpers duplication
between mq and ipc sysctls.

--

Alexey Gladkov (4):
  ipc: Store mqueue sysctls in the ipc namespace
  ipc: Store ipc sysctls in the ipc namespace
  ipc: Merge ipc_sysctl and mq_sysctl
  ipc: Allow to modify ipc/mq sysctls if CAP_SYS_RESOURCE is present

 include/linux/ipc_namespace.h |  24 ++-
 ipc/Makefile                  |   7 +-
 ipc/ipc_sysctl.c              | 318 +++++++++++++++++++++++++++-------
 ipc/mq_sysctl.c               | 120 -------------
 ipc/mqueue.c                  |   7 -
 ipc/namespace.c               |   6 +
 ipc/util.h                    |   4 +-
 7 files changed, 273 insertions(+), 213 deletions(-)
 delete mode 100644 ipc/mq_sysctl.c

-- 
2.33.0

