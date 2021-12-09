Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9FF46DF9C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 01:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241675AbhLIAnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 19:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241498AbhLIAnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 19:43:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F79C061746;
        Wed,  8 Dec 2021 16:40:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB95BB82333;
        Thu,  9 Dec 2021 00:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92052C00446;
        Thu,  9 Dec 2021 00:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639010400;
        bh=b3K9Nj6GMD0TSZap+1QDuzGQ5JETQw0RNVbhy2D9m/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qvthDnOufOhVNsnsM1t0Jj/bU6ufK6qWJ2ycAgEsXnJd8awMRpRLjN26Z/xbGhMoe
         QZBbVeDnuwvLrYdT2CgekZ6kcKvBYlkFb0h2EVMyF5TZIT85LbPiA4q9N1FvDWWuSX
         YkKUrkJzIawhvOxmMQl+gkXVW0ICRXgCyV1aNUS+kSGBdAWXAkgl/uKPwLNLQZXTdS
         EJ4mTf+9yKrmAjmv3obvap0+Qz6Gopr0YnVKcIbYmMBVQIjNUPoCn/Nmsm37LJkqVT
         nucZS5HhaKZcmM7QXhyv+BTE5VA9yRf61geUYDhTbf8Hp5NT9xJk+oT36uYmFhDsE8
         4puhMg4vXZ98Q==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 6/8] docs: sysfs-block: document virt_boundary_mask
Date:   Wed,  8 Dec 2021 16:38:31 -0800
Message-Id: <20211209003833.6396-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209003833.6396-1-ebiggers@kernel.org>
References: <20211209003833.6396-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

/sys/block/<disk>/queue/virt_boundary_mask is completely undocumented.
Document it.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/ABI/stable/sysfs-block | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 288626e8cb532..8dd3e84a8aade 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -544,6 +544,18 @@ Description:
 		CONFIG_BLK_DEV_THROTTLING_LOW is enabled.
 
 
+What:		/sys/block/<disk>/queue/virt_boundary_mask
+Date:		April 2021
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] This file shows the I/O segment memory alignment mask for
+		the block device.  I/O requests to this device will be split
+		between segments wherever either the memory address of the end
+		of the previous segment or the memory address of the beginning
+		of the current segment is not aligned to virt_boundary_mask + 1
+		bytes.
+
+
 What:		/sys/block/<disk>/queue/wbt_lat_usec
 Date:		November 2016
 Contact:	linux-block@vger.kernel.org
-- 
2.34.1

