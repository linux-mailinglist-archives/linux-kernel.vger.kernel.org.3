Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2695314CF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238464AbiEWQJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238387AbiEWQJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:09:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD522186F8;
        Mon, 23 May 2022 09:09:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8C1AD21A64;
        Mon, 23 May 2022 16:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653322154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4ywoMr61UmNyulUm1OYgOzOzU4gEj3gsscFPBmvSZr0=;
        b=d8CuZxzb28+AguRGeC9cq1qFeJlmern+8wNDOixtu6mV54Sm1yPmHWbOZcNRFCPwyNqaUc
        NwUCvIuPcrwM6cOjmpMHXVsmg2N6xFHmwHjSgeD6URz49d0Fhbq2/7rlCIoh0FzZ6huKDI
        kN0+gihk+pBzkZXziR51IXAAmia7ofY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653322154;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4ywoMr61UmNyulUm1OYgOzOzU4gEj3gsscFPBmvSZr0=;
        b=ZXFNWEdOKAJQ9umVco/MxuBshhf2jIW4d5YMy71n/AicE6eq39HIVKLhJ6QsSqRo7iaUh7
        hUn6iz0amKmZuKDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F856139F5;
        Mon, 23 May 2022 16:09:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RCj5CKqxi2KsKQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 23 May 2022 16:09:14 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id a98d69dc;
        Mon, 23 May 2022 16:09:52 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH] ceph: fix decoding of client session messages flags
Date:   Mon, 23 May 2022 17:09:51 +0100
Message-Id: <20220523160951.8781-1-lhenriques@suse.de>
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

The cephfs kernel client started to show  the message:

 ceph: mds0 session blocklisted

when mounting a filesystem.  This is due to the fact that the session
messages are being incorrectly decoded: the skip needs to take into
account the 'len'.

While there, fixed some whitespaces too.

Fixes: e1c9788cb397 ("ceph: don't rely on error_string to validate blocklisted session.")
Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 fs/ceph/mds_client.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 00c3de177dd6..1bd3e1bb0fdf 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3375,13 +3375,17 @@ static void handle_session(struct ceph_mds_session *session,
 	}
 
 	if (msg_version >= 5) {
-		u32 flags;
-		/* version >= 4, struct_v, struct_cv, len, metric_spec */
-	        ceph_decode_skip_n(&p, end, 2 + sizeof(u32) * 2, bad);
+		u32 flags, len;
+
+		/* version >= 4 */
+		ceph_decode_skip_16(&p, end, bad); /* struct_v, struct_cv */
+		ceph_decode_32_safe(&p, end, len, bad); /* len */
+		ceph_decode_skip_n(&p, end, len, bad); /* metric_spec */
+
 		/* version >= 5, flags   */
-                ceph_decode_32_safe(&p, end, flags, bad);
+		ceph_decode_32_safe(&p, end, flags, bad);
 		if (flags & CEPH_SESSION_BLOCKLISTED) {
-		        pr_warn("mds%d session blocklisted\n", session->s_mds);
+			pr_warn("mds%d session blocklisted\n", session->s_mds);
 			blocklisted = true;
 		}
 	}
