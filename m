Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857F44C05DC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 01:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbiBWAWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 19:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiBWAV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 19:21:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10D9E26ADE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 16:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645575691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6O5b7F9+Nae+ObOZVmouefPRZ/Flywmd4HmN3PpnlME=;
        b=IBg+Gshzvji3QBoJRsZfQVeIBLRZBBGvMOzYfACUgXwv1Jt/V7YrOaMm7tZqi0aPh2LViE
        NKWMoqEFUDHsmDjhIB6zFcCzI+W7gsM7qxaIMsA/ZNi/MgkNFlfOfER0jX6Ae6EK915bEH
        9mN7p01cb9MX8+8UxguIRdlsnjTTHUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-SU_cSuwTNLW-pE8LVhyPKA-1; Tue, 22 Feb 2022 19:21:28 -0500
X-MC-Unique: SU_cSuwTNLW-pE8LVhyPKA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76E35180FD73;
        Wed, 23 Feb 2022 00:21:27 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 665AB1006914;
        Wed, 23 Feb 2022 00:21:23 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] locking/lockdep: Remove obsolete generation counter comment in lock_class
Date:   Tue, 22 Feb 2022 19:20:52 -0500
Message-Id: <20220223002053.486875-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2421b7f3573b ("locking/lockdep: Remove ::version from lock_class
structure") had removed the obsolete version field from the lock_class
structure but failed to remove the corresponding generation counter
comment leading to confusion about what generation counter really
is. Remove that comment as well to avoid confusion.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/lockdep_types.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index d22430840b53..9c62d274b71e 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -118,10 +118,6 @@ struct lock_class {
 	unsigned long			usage_mask;
 	const struct lock_trace		*usage_traces[LOCK_TRACE_STATES];
 
-	/*
-	 * Generation counter, when doing certain classes of graph walking,
-	 * to ensure that we check one node only once:
-	 */
 	int				name_version;
 	const char			*name;
 
-- 
2.27.0

