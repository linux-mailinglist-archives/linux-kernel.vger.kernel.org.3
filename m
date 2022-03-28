Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF7C4E97A3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242544AbiC1NMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237730AbiC1NMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:12:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9225F1088
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648473036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oPUIgDa6HUJFIkt4naHdYuQa7qYarBWstooAkOY/xAM=;
        b=QJJi6vDCZDZTPaYBBRkK2slHKNGphLQHTLgh4AGdBv+4ZPUJz1IDuec2HhdkiD9bah9MCD
        Z5QnmzhjVeU/R/DZpyTBkQwbIimGq0dPw4gMAohcvjpRbSOyZ9QCySFjRdtNtsxbAHi5eX
        rqp/ecjYa3tP9a4KEvKpKoC7V0pfhiQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-251-Z2czk1bjP4-S1atZAJ09mQ-1; Mon, 28 Mar 2022 09:10:33 -0400
X-MC-Unique: Z2czk1bjP4-S1atZAJ09mQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7838180159B;
        Mon, 28 Mar 2022 13:10:32 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB2F3C15D59;
        Mon, 28 Mar 2022 13:10:29 +0000 (UTC)
From:   xiubli@redhat.com
To:     jlayton@kernel.org
Cc:     idryomov@gmail.com, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v2] ceph: remove unused CEPH_MDS_LEASE_RELEASE related code
Date:   Mon, 28 Mar 2022 21:10:26 +0800
Message-Id: <20220328131026.923174-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

ceph_mdsc_lease_release was removed by commit 8aa152c77890 (ceph:
remove ceph_mdsc_lease_release). ceph_mdsc_lease_send_msg will never
call this function with CEPH_MDS_LEASE_RELEASE.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/mds_client.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 459c6f23915f..a89ee866ebbb 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4424,12 +4424,6 @@ void ceph_mdsc_lease_send_msg(struct ceph_mds_session *session,
 	memcpy((void *)(lease + 1) + 4,
 	       dentry->d_name.name, dentry->d_name.len);
 	spin_unlock(&dentry->d_lock);
-	/*
-	 * if this is a preemptive lease RELEASE, no need to
-	 * flush request stream, since the actual request will
-	 * soon follow.
-	 */
-	msg->more_to_follow = (action == CEPH_MDS_LEASE_RELEASE);
 
 	ceph_con_send(&session->s_con, msg);
 }
-- 
2.27.0

