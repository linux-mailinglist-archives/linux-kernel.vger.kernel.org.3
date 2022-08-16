Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9A1595F98
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbiHPPtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbiHPPsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:48:45 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6461478584
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:45:07 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-ha1Jl9NgO0yPMXlwnnXOSA-1; Tue, 16 Aug 2022 11:43:58 -0400
X-MC-Unique: ha1Jl9NgO0yPMXlwnnXOSA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16BCD29ABA0C;
        Tue, 16 Aug 2022 15:43:57 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.40.208.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61A412166B26;
        Tue, 16 Aug 2022 15:43:55 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        linux-doc@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 3/3] docs: Add information about ipc sysctls limitations
Date:   Tue, 16 Aug 2022 17:42:45 +0200
Message-Id: <9b566b9b7313300d60b7dfd785ab041bed757ae0.1660664258.git.legion@kernel.org>
In-Reply-To: <cover.1660664258.git.legion@kernel.org>
References: <87wnc1i2wo.fsf@email.froward.int.ebiederm.org> <cover.1660664258.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After 25b21cb2f6d6 ("[PATCH] IPC namespace core") and 4e9823111bdc
("[PATCH] IPC namespace - shm") the shared memory page count stopped
being global and started counting per ipc namespace. The documentation
and shmget(2) still says that shmall is a global option.

shmget(2):

SHMALL System-wide limit on the total amount of shared memory, measured
in units of the system page size. On Linux, this limit can be read and
modified via /proc/sys/kernel/shmall.

I think the changes made in 2006 should be documented.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 Documentation/admin-guide/sysctl/kernel.rst | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index ddccd1077462..9ad344b5e7a1 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -541,6 +541,9 @@ default (``MSGMNB``).
 ``msgmni`` is the maximum number of IPC queues. 32000 by default
 (``MSGMNI``).
 
+All of these parameters are set per ipc namespace. The maximum number of bytes
+in POSIX message queues is limited by ``RLIMIT_MSGQUEUE``. This limit is
+respected hierarchically in the each user namespace.
 
 msg_next_id, sem_next_id, and shm_next_id (System V IPC)
 ========================================================
@@ -1169,15 +1172,20 @@ are doing anyway :)
 shmall
 ======
 
-This parameter sets the total amount of shared memory pages that
-can be used system wide. Hence, ``shmall`` should always be at least
-``ceil(shmmax/PAGE_SIZE)``.
+This parameter sets the total amount of shared memory pages that can be used
+inside ipc namespace. The shared memory pages counting occurs for each ipc
+namespace separately and is not inherited. Hence, ``shmall`` should always be at
+least ``ceil(shmmax/PAGE_SIZE)``.
 
 If you are not sure what the default ``PAGE_SIZE`` is on your Linux
 system, you can run the following command::
 
 	# getconf PAGE_SIZE
 
+To reduce or disable the ability to allocate shared memory, you must create a
+new ipc namespace, set this parameter to the required value and prohibit the
+creation of a new ipc namespace in the current user namespace or cgroups can
+be used.
 
 shmmax
 ======
-- 
2.33.4

