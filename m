Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC116464A20
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 09:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347976AbhLAIuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 03:50:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44294 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242097AbhLAIu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 03:50:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60AAEB81E04;
        Wed,  1 Dec 2021 08:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C81C53FD3;
        Wed,  1 Dec 2021 08:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638348425;
        bh=6gRlmsFqDYVMrg69bxKpYHZwAZBjft8zQxWeV99h/c0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JltDRArANJdRR0hN8dIfhOEc82zorsREi2Vk7mo3stKDDAH9bP/W5YYT8zUoGHThK
         oY/ENcz8T+4UZDG9s1yCq/HqFshaDGqOZ9TgHN0bMP3ED05NGYhq653wM4vZR/488S
         NNFUdzByiU9yAyMrA3wQ3L6QCWcNdRRzlyM4h5iKIhKJmtPBvlqMkONkWaGNv+dNvF
         kbBQ66GmoP3/MpTebCOPHJdMskFN+PNJsh70m+u/4xTb/SbBSdrnxNzx75JznXJ8cA
         r0WMSMX4ClwzZjMuZ7ea7G1PIuAKSbhb3HbbZXe1NuU0IvTpv+Hky94REQEVixE0qu
         DJapUU9J/yuNA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] docs: sysfs-block: document virt_boundary_mask
Date:   Wed,  1 Dec 2021 00:45:22 -0800
Message-Id: <20211201084524.25660-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211201084524.25660-1-ebiggers@kernel.org>
References: <20211201084524.25660-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

/sys/block/<disk>/queue/virt_boundary_mask is completely undocumented.
Document it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/ABI/testing/sysfs-block | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index 5d8b187e1ec54..8cc795476244c 100644
--- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -536,6 +536,17 @@ Description:
 		CONFIG_BLK_DEV_THROTTLING_LOW is enabled.
 
 
+What:		/sys/block/<disk>/queue/virt_boundary_mask
+Date:		April 2021
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] This file shows the I/O segment alignment mask for the
+		block device.  I/O requests to this device will be split between
+		segments wherever either the end of the previous segment or the
+		beginning of the current segment is not aligned to
+		virt_boundary_mask + 1 bytes.
+
+
 What:		/sys/block/<disk>/queue/wbt_lat_usec
 Date:		November 2016
 Contact:	linux-block@vger.kernel.org
-- 
2.34.1

