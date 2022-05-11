Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CABA522900
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 03:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240611AbiEKBbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 21:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240521AbiEKBbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 21:31:31 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0E3434AF
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 18:31:29 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id iq10so850560pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 18:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nyT+TEM6YfXjFwh6RP3Mgulu/QW39cAOrSoKYlACyaM=;
        b=meI7q9780fzkqj6a0HhsAQmhu3va+coXBZlxQAwgjwFiDPhNeV2GiDAIgDzjWT5Dni
         rsOyD5RkxOqImMxvbKnwTxybY7H6JTfuS2lsAMjuWh1HUHkXQ4PRvCUSB5wj8KZgbyXQ
         gpQmQW533keZw+eCzRQfdd5meZ/0WUPyR7ifA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nyT+TEM6YfXjFwh6RP3Mgulu/QW39cAOrSoKYlACyaM=;
        b=Io5KKB2e0zU4hXnI6ECZTktzYs9A3v4nm9FNuwGM6xlqRrVEounZJQxHJYuvH63/kr
         mfj7/nlCH9zU8Y+lUhRfE3gED1oznTz/335s1npYjjGPsNPfEW66uwWGz+kEoNAPfukI
         v+YnNTcqVQlA0qjs1R09Y1hL9CZoAWB/weCcaKtV4sMBW29C8azDBPeMIFAKWfnVDN9r
         EqbwoDna4Bz3/1vww2T79o9EWR4hVLizbUGuUfIrET1A6FON33PzBOFsOtQIRxzPR5Hi
         Pd0ogM6Ip7lSJtqcvthhzoPpAajht92mdmsqBX502G+nMhir5XZzm6gJL/3hFtdrEt6i
         SJrQ==
X-Gm-Message-State: AOAM531pwNaoltO5Cp3YOPVyCIarSXXyp5GnUVoVrKO75X38mE8GiGd4
        rUrzq6Kf2rQkVXCgUsQt4by185K/mf289w==
X-Google-Smtp-Source: ABdhPJyVmsGY+I+4n3pCMGU/dXV5in4S+vZlRPTbhVbpJV4FxM/OsoM7PfiNLPYpVZRQ812YNj6kFA==
X-Received: by 2002:a17:903:40cf:b0:15e:9bd0:2cab with SMTP id t15-20020a17090340cf00b0015e9bd02cabmr22614313pld.170.1652232688669;
        Tue, 10 May 2022 18:31:28 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id a4-20020a17090aa50400b001cd4989feecsm2494749pjq.56.2022.05.10.18.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 18:31:28 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Daniil Lunev <dlunev@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH 2/2] FUSE: Mark super block defunc on force unmount
Date:   Wed, 11 May 2022 11:30:57 +1000
Message-Id: <20220511113050.2.I103b609e957667ca427c689fd83990e6ab32f3dd@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220511013057.245827-1-dlunev@chromium.org>
References: <20220511013057.245827-1-dlunev@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Force unmount of FUSE severes the connection with the user space, even
if there are still open files. Subsequent remount tries to re-use the
superblock held by the open files, which is meaningless in the FUSE case
after disconnect - reused super block doesn't have userspace counterpart
attached to it and is incapable of doing any IO.

Signed-off-by: Daniil Lunev <dlunev@chromium.org>
---

 fs/fuse/inode.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 8c0665c5dff88..e2ad3c9b2d5c5 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -476,8 +476,15 @@ static void fuse_umount_begin(struct super_block *sb)
 {
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
 
-	if (!fc->no_force_umount)
-		fuse_abort_conn(fc);
+	if (fc->no_force_umount)
+		return;
+
+	sb->s_defunc = true;
+	if (sb->s_bdi != &noop_backing_dev_info) {
+		bdi_put(sb->s_bdi);
+		sb->s_bdi = &noop_backing_dev_info;
+	}
+	fuse_abort_conn(fc);
 }
 
 static void fuse_send_destroy(struct fuse_mount *fm)
-- 
2.31.0

