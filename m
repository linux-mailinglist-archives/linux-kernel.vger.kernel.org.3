Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B1A46C9BB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239226AbhLHBBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238974AbhLHBBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:01:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAB0C061748;
        Tue,  7 Dec 2021 16:57:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA27CB81F26;
        Wed,  8 Dec 2021 00:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB12C341CE;
        Wed,  8 Dec 2021 00:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638925049;
        bh=qsC4hUoks9qZEzFdXzOQJQtkxZyTe1zi+Uf/zpPh68A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PNmzTXp0JbeTsVYbdF1Wb/iitqdhuk2phev3PLTHe3nOMu/wC5BxWkKTklcl89CsJ
         NPkiqNXnsCwFdBot4a7kUPrYuL+qB9AHYR+Aas9wdV+irgsbhMiNtpCDz3shiYYl62
         VESXCJjKhBKEzml3x81ePV2t7+/EiMNQq3z/xn14lZkv9KvMO8ePN/I5z/h5nn4+px
         CIZkCjbqmZVBItLOUZhtJIgYOgCDes3NC1HPGBNQykT0g9Oft7VnH8iPpB1s6EfudZ
         5OIy+S4yPvRXvHNzxYggrhgDRGnS8MIINBfvGn1DgZgD+4HdD20GbQ6yzsx/WQy6Po
         I0OHPxb6KiVgg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 6/8] docs: sysfs-block: document virt_boundary_mask
Date:   Tue,  7 Dec 2021 16:56:38 -0800
Message-Id: <20211208005640.102814-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211208005640.102814-1-ebiggers@kernel.org>
References: <20211208005640.102814-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

/sys/block/<disk>/queue/virt_boundary_mask is completely undocumented.
Document it.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/ABI/stable/sysfs-block | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 30ce8dc587bb2..e988742a54a4c 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -537,6 +537,17 @@ Description:
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

