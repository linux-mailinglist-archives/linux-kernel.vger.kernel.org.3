Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D4B54DFF4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376799AbiFPLZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376791AbiFPLY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:24:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D7ED5B889
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 04:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655378697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PYN4vrazOjpzHbHKN8kGtDEh1xr2C3dAU+DA3wak0OQ=;
        b=dLz+z2R0nsbeoDzFdJJI/wvTyqY3rX5UE8Y14PZbWRLZO+bHKhSnozpSDCnm0z1xCIvJz6
        kQF0YvEGHsaHvhxzE72aUoEqFd2ej1nh4OrcvU670TLKbQVxBJaA+D6bmtkon0R+Fdzwfr
        evJUYMJVo1YWtsrD0DsbcD37T0rGGJE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-8YibE1oZMdSLiS_qp52F-Q-1; Thu, 16 Jun 2022 07:24:54 -0400
X-MC-Unique: 8YibE1oZMdSLiS_qp52F-Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8799B85A582;
        Thu, 16 Jun 2022 11:24:53 +0000 (UTC)
Received: from pick.home.annexia.org (unknown [10.39.192.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40BC91121314;
        Thu, 16 Jun 2022 11:24:52 +0000 (UTC)
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     josef@toxicpanda.com
Cc:     axboe@kernel.dk, prasanna.kalever@redhat.com, xiubli@redhat.com,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        eblake@redhat.com
Subject: [PATCH] nbd: Permit nbd-client to set minimum and optimal I/O sizes
Date:   Thu, 16 Jun 2022 12:24:49 +0100
Message-Id: <20220616112449.3222664-2-rjones@redhat.com>
In-Reply-To: <20220616112449.3222664-1-rjones@redhat.com>
References: <20220616112449.3222664-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new netlink attributes to allow the userspace nbd-client to
control the minimum_io_size and optimal_io_size settings.

This is the kernel part of an effort to implement NBD block size
constraints.

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
Link: https://github.com/NetworkBlockDevice/nbd/blob/master/doc/proto.md#block-size-constraints
Link: https://lists.debian.org/nbd/2022/06/msg00022.html
---
 drivers/block/nbd.c              | 17 ++++++++++++++++-
 include/uapi/linux/nbd-netlink.h |  2 ++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 07f3c139a3d7..ff51b5c577b2 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -99,6 +99,7 @@ struct nbd_config {
 	wait_queue_head_t recv_wq;
 	unsigned int blksize_bits;
 	loff_t bytesize;
+	u32 minimum_io_size, optimal_io_size;
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 	struct dentry *dbg_dir;
 #endif
@@ -338,6 +339,13 @@ static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 	blk_queue_logical_block_size(nbd->disk->queue, blksize);
 	blk_queue_physical_block_size(nbd->disk->queue, blksize);
 
+	if (nbd->config->minimum_io_size)
+		blk_queue_io_min(nbd->disk->queue,
+				 nbd->config->minimum_io_size);
+	if (nbd->config->optimal_io_size)
+		blk_queue_io_opt(nbd->disk->queue,
+				 nbd->config->optimal_io_size);
+
 	if (max_part)
 		set_bit(GD_NEED_PART_SCAN, &nbd->disk->state);
 	if (!set_capacity_and_notify(nbd->disk, bytesize >> 9))
@@ -1876,6 +1884,8 @@ static const struct nla_policy nbd_attr_policy[NBD_ATTR_MAX + 1] = {
 	[NBD_ATTR_DEAD_CONN_TIMEOUT]	=	{ .type = NLA_U64 },
 	[NBD_ATTR_DEVICE_LIST]		=	{ .type = NLA_NESTED},
 	[NBD_ATTR_BACKEND_IDENTIFIER]	=	{ .type = NLA_STRING},
+	[NBD_ATTR_BLOCK_SIZE_MIN]	=	{ .type = NLA_U32 },
+	[NBD_ATTR_BLOCK_SIZE_OPT]	=	{ .type = NLA_U32 },
 };
 
 static const struct nla_policy nbd_sock_policy[NBD_SOCK_MAX + 1] = {
@@ -2031,7 +2041,12 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 				&config->runtime_flags);
 		}
 	}
-
+	if (info->attrs[NBD_ATTR_BLOCK_SIZE_MIN])
+		config->minimum_io_size =
+			nla_get_u32(info->attrs[NBD_ATTR_BLOCK_SIZE_MIN]);
+	if (info->attrs[NBD_ATTR_BLOCK_SIZE_OPT])
+		config->optimal_io_size =
+			nla_get_u32(info->attrs[NBD_ATTR_BLOCK_SIZE_OPT]);
 	if (info->attrs[NBD_ATTR_SOCKETS]) {
 		struct nlattr *attr;
 		int rem, fd;
diff --git a/include/uapi/linux/nbd-netlink.h b/include/uapi/linux/nbd-netlink.h
index 2d0b90964227..1d6621487560 100644
--- a/include/uapi/linux/nbd-netlink.h
+++ b/include/uapi/linux/nbd-netlink.h
@@ -36,6 +36,8 @@ enum {
 	NBD_ATTR_DEAD_CONN_TIMEOUT,
 	NBD_ATTR_DEVICE_LIST,
 	NBD_ATTR_BACKEND_IDENTIFIER,
+	NBD_ATTR_BLOCK_SIZE_MIN,
+	NBD_ATTR_BLOCK_SIZE_OPT,
 	__NBD_ATTR_MAX,
 };
 #define NBD_ATTR_MAX (__NBD_ATTR_MAX - 1)
-- 
2.35.1

