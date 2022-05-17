Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA60552AD44
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 23:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345271AbiEQVCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 17:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbiEQVCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 17:02:35 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BB2532FD
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:02:33 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n18so18409333plg.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Z9EyYxplJlprEbAHwzyEklGsml74F923zNnokO7mVo=;
        b=c/V79cSjAhaff14NVxtUgJBV3mcV5nu3U5K/bvVPX9Vg6xjXT8RERmCmLeSYo0HJ4t
         F3XA44TJygX3DQSl74bC6rvh2372cKV+LIscomxf1ZdBWj1TybjqKGaMTMv36K1fJD15
         A3/CZhzVvXWKbmdMg36TdJ3RglNI3wlqoEd7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Z9EyYxplJlprEbAHwzyEklGsml74F923zNnokO7mVo=;
        b=Bw/87IaS7yBhE/BnjQgDh2v7eN7RZqdl4GixQ9by/thCHJkrLkJpOLrKliFAMo5oZg
         oW03uvcl/qapotWQwbT0/ZeMUtMnti7XNFsRtMtsMPEREq5s+8A5nBYGFtLSZ+S1C+TP
         lPB3CQsxac7uoVMCeZchDQQw1bSXUbBW+H/gvahFzexs5kIwbygpctFA15fqRavKbIaP
         u9Gt+OE3iJ2aJq9DsGkTu0fFXGU+NKmFuNChizyA3agFTANaZY2TAw3gIGYcGu0YAmsV
         0If2QEgLx9zst38/EXT1UyYQmUcjVGqbVmFi53inroJoC2QMnBAg2zSzyXyiSyFZq2se
         VhJQ==
X-Gm-Message-State: AOAM533oS8zqTjXPxK5+eWysOyA/XzkzydpsUG+sZF5VEpVvlldCpjZ0
        cqcRbrL0Pjvf7cEABmPAS1xufg==
X-Google-Smtp-Source: ABdhPJyc7Vd9LAnl/JmJL2g+C0yiMoarXMN+rMqaZv/VUWY/i+asqMq/jt4XBvXFSw3geJgG/kqCAw==
X-Received: by 2002:a17:902:ccc4:b0:156:5d37:b42f with SMTP id z4-20020a170902ccc400b001565d37b42fmr24137938ple.157.1652821353211;
        Tue, 17 May 2022 14:02:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t62-20020a628141000000b0050dc762817dsm182630pfd.87.2022.05.17.14.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 14:02:32 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] netfs: Use container_of() for offset casting
Date:   Tue, 17 May 2022 14:02:30 -0700
Message-Id: <20220517210230.864239-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3098; h=from:subject; bh=orttEkVGUEq2t79x6yRgFuG1uT8/dXffqR3bmC2jYoc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBihA1mkRAWbagSJth11UQ008WPKRkDzzHwhdGQPppj 2Ev9UDSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYoQNZgAKCRCJcvTf3G3AJmL8EA CAncdo8RHOGW9ZIAXQKDRwViV708RTE73KecQYyXZSrvHFcpf3jmjuZq/TX39ONviQxUkXQzuDuB3e QdcD1XtcpN11NdWYrrgWcRDzlJNyg9KX6iASjNOXUjMtoP2pJNfbpVwkWowBZl8Rv2d4oCkJmcBWAi sEbBtcoLUo5qq/8Msafg6GIlpfSXWVIDBMyaspi9rtvRk6NLgY6+ksqNaIj0mQ3SiM7RLEBdbx0Fi3 sjbwgajMX/qmmHkJ175UH/2wHKq0WVrB5q99nigYbnpHoC0PaxX9mP4/G64u2ShyjQ6I445x0AQvwj fICHxcWE0lthqrLNKWbZlRSi8MTd/qjhil2agLch2C4vDIuEGj7fQtEjmn8D4CCPO0HMd4dwlKEEpP jpc5dVO3tH/XzJcyc8kpqyXHi08ppBGHXmKkA7b/CLAtERe+HNchEy8jkNN6PYySShxDdxPdi5s71+ SiEhSAUoCP+2uyYsrAOlK4GvYkZW6aedyndmXE6c8LCzwVkHxyW3KjABlrSo/MshntZgeWCV0Lyejd CLj0FwBwxcV1GeG8WHeYpMVPPvuks5UoP+sBly+vay3bnAkG5CelOHHoVW2DWwVtdVG1Q+800gZDxa suSswtXdF5ffLvAzicKHcdrKTMEThibT6iDiqdTPzmDXDHcjsQHw7xg8QC0Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While randstruct was satisfied with using an open-coded "void *" offset
cast for the netfs_i_context <-> inode casting, __builtin_object_size()
as used by FORTIFY_SOURCE was not as easily fooled. Switch to using
an internally defined netfs_i_context/inode struct for doing a full
container_of() casting. This keeps both randstruct and __bos() happy
under GCC 12. Silences:

In file included from ./include/linux/string.h:253,
                 from ./include/linux/ceph/ceph_debug.h:7,
                 from fs/ceph/inode.c:2:
In function ‘fortify_memset_chk’,
    inlined from ‘netfs_i_context_init’ at ./include/linux/netfs.h:326:2,
    inlined from ‘ceph_alloc_inode’ at fs/ceph/inode.c:463:2:
./include/linux/fortify-string.h:242:25: warning: call to ‘__write_overflow_field’ declared with attribute warning:
detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
  242 |                         __write_overflow_field(p_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Jeff Layton <jlayton@kernel.org>
Link: https://lore.kernel.org/lkml/d2ad3a3d7bdd794c6efb562d2f2b655fb67756b9.camel@kernel.org
Cc: Jeff Layton <jlayton@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
If this looks good I can add it to my hardening tree, or if you want to
carry it, I can respin this without the earlier randstruct changes and
drop that patch from my tree?
---
 include/linux/netfs.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 0c33b715cbfd..cce5a9b53a8a 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -286,6 +286,17 @@ extern void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 				 bool was_async, enum netfs_sreq_ref_trace what);
 extern void netfs_stats_show(struct seq_file *);
 
+/*
+ * The struct netfs_i_context instance must always follow the VFS inode,
+ * but existing users want to avoid a substructure name space, so just
+ * use this internally to perform the needed container_of() offset
+ * casting, which will keep both FORTIFY_SOURCE and randstruct happy.
+ */
+struct netfs_i_c_pair {
+	struct inode inode;
+	struct netfs_i_context ctx;
+};
+
 /**
  * netfs_i_context - Get the netfs inode context from the inode
  * @inode: The inode to query
@@ -295,7 +306,7 @@ extern void netfs_stats_show(struct seq_file *);
  */
 static inline struct netfs_i_context *netfs_i_context(struct inode *inode)
 {
-	return (void *)inode + sizeof(*inode);
+	return &container_of(inode, struct netfs_i_c_pair, inode)->ctx;
 }
 
 /**
@@ -307,7 +318,7 @@ static inline struct netfs_i_context *netfs_i_context(struct inode *inode)
  */
 static inline struct inode *netfs_inode(struct netfs_i_context *ctx)
 {
-	return (void *)ctx - sizeof(struct inode);
+	return &container_of(ctx, struct netfs_i_c_pair, ctx)->inode;
 }
 
 /**
-- 
2.32.0

