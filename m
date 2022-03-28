Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2664E8C14
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 04:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbiC1C1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 22:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiC1C1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 22:27:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77A7433A2D
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 19:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648434350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xsHhfUs66bbbXza3E8A4RMVlljtRM9C2VkSN3/JNqDo=;
        b=i/kDV5Mw+RBNOU1BCKtdmihcxkysBPqeefVvO+mh+IQcsDiea4nTAhfSfECxMvwzOZCvDN
        PT2jRYm76qBNgx96dAFFWFk1hUAlOGd8CJ5SrNe/NAMEu/lgVD5ss1I5BAh2sAMhr9h96m
        bnBsBKw2xaMy1+cNon0sH+Upqtr4mZk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-pec7M6aaOvKoHry213u1uQ-1; Sun, 27 Mar 2022 22:25:48 -0400
X-MC-Unique: pec7M6aaOvKoHry213u1uQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17E6E811E78;
        Mon, 28 Mar 2022 02:25:48 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BE301400B1C;
        Mon, 28 Mar 2022 02:25:44 +0000 (UTC)
From:   xiubli@redhat.com
To:     jlayton@kernel.org
Cc:     idryomov@gmail.com, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>
Subject: [PATCH] ceph: remove unused CEPH_MDS_LEASE_RELEASE related code
Date:   Mon, 28 Mar 2022 10:25:35 +0800
Message-Id: <20220328022535.847164-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

The ceph_mdsc_lease_release() has been removed by commit(8aa152c77890)
and the CEPH_MDS_LEASE_RELEASE will never be used.

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

