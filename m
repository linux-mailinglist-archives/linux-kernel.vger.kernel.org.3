Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031AA532E96
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 18:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239490AbiEXQIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 12:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239739AbiEXQHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 12:07:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20C4C40;
        Tue, 24 May 2022 09:05:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5EAAE219F7;
        Tue, 24 May 2022 16:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653408351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8iddqCc5isiky802Ee1iFfpa1otxcjEUWsnncIcYI5M=;
        b=cJMBSRW0w26pmB3bFs0gZyNGjHDTOsWGZZPBr3S+qej1fCNG48omqBo1fKRMBYRUb8JGr0
        6JCeKnp9jWmByEV3zeJ/S5uMwutnWsoQ4U8UZTq1RU/41EkNhPMNxryS0rFmrAaCbAsbSd
        QNFNVLO2kTgzWznt7xyoqqyLe8iQd6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653408351;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8iddqCc5isiky802Ee1iFfpa1otxcjEUWsnncIcYI5M=;
        b=k01FNnHR55HGU2CNNpjQ3F24CoVIZ0UTzerXe6GynB1wa0Q/NJW59aPZrhvAAHauKCxBTB
        IvXjUbefvxaZq0Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6D1413ADF;
        Tue, 24 May 2022 16:05:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uqPKNF4CjWKETgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Tue, 24 May 2022 16:05:50 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 27971f8a;
        Tue, 24 May 2022 16:06:28 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH] ceph: use correct index when encoding client supported features
Date:   Tue, 24 May 2022 17:06:27 +0100
Message-Id: <20220524160627.20893-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feature bits have to be encoded into the correct locations.  This hasn't
been an issue so far because the only hole in the feature bits was in bit
10 (CEPHFS_FEATURE_RECLAIM_CLIENT), which is located in the 2nd byte.  When
adding more bits that go beyond the this 2nd byte, the bug will show up.

Fixes: 9ba1e224538a ("ceph: allocate the correct amount of extra bytes for the session features")
Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 fs/ceph/mds_client.c | 7 +++++--
 fs/ceph/mds_client.h | 2 --
 2 files changed, 5 insertions(+), 4 deletions(-)

I hope I got this code right.  I found this issue when trying to add an
extra feature bit that would go beyond bit 15 and that wasn't showing up
on the MDS side.

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 1bd3e1bb0fdf..77e742b6fd30 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1220,14 +1220,17 @@ static int encode_supported_features(void **p, void *end)
 	if (count > 0) {
 		size_t i;
 		size_t size = FEATURE_BYTES(count);
+		unsigned long bit;
 
 		if (WARN_ON_ONCE(*p + 4 + size > end))
 			return -ERANGE;
 
 		ceph_encode_32(p, size);
 		memset(*p, 0, size);
-		for (i = 0; i < count; i++)
-			((unsigned char*)(*p))[i / 8] |= BIT(feature_bits[i] % 8);
+		for (i = 0; i < count; i++) {
+			bit = feature_bits[i];
+			((unsigned char *)(*p))[bit / 8] |= BIT(bit % 8);
+		}
 		*p += size;
 	} else {
 		if (WARN_ON_ONCE(*p + 4 > end))
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 33497846e47e..12901e3a6823 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -45,8 +45,6 @@ enum ceph_feature_type {
 	CEPHFS_FEATURE_MULTI_RECONNECT,		\
 	CEPHFS_FEATURE_DELEG_INO,		\
 	CEPHFS_FEATURE_METRIC_COLLECT,		\
-						\
-	CEPHFS_FEATURE_MAX,			\
 }
 #define CEPHFS_FEATURES_CLIENT_REQUIRED {}
 
