Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664DA46DF9A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 01:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241605AbhLIAns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 19:43:48 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:49330 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbhLIAng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 19:43:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 38252CE241A;
        Thu,  9 Dec 2021 00:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD68C341CD;
        Thu,  9 Dec 2021 00:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639010400;
        bh=lN6irFSPdhVHSZbXhcFEryQ2TyUCysymqpfoNti6hp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RVyL+3ACtIVF1qBcKVueuHMLbaRMi+taZDSnzOO/y0mW/w8y/87ndad7KL0U0/ETi
         8amArDqT8t3X5VaYaJTEvFfzCQiE9lhc0DUtlKbghCCfySmGvJPv7gYUD1NsuManNZ
         D0obQDABtwv5GAkx0H9/X0JxAiOmzABIchqwI4q2YN7XN8tKMIEuZqvyODeaCFyHHD
         Ruy02vxoKEvsyaiyAD0UeWWGJQYVLYr5aYAgDWToXw3U8/NNH3eXyJ4mHJxQhfx1dY
         l9+N84C1kBp4FjZEkQTSr3WAD5YQfQTKC1/OHb00S9rhjj0u479bNuhinV+qOB6F5j
         hELnrmK+A2H0Q==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 5/8] docs: sysfs-block: document stable_writes
Date:   Wed,  8 Dec 2021 16:38:30 -0800
Message-Id: <20211209003833.6396-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209003833.6396-1-ebiggers@kernel.org>
References: <20211209003833.6396-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

/sys/block/<disk>/queue/stable_writes is completely undocumented.
Document it.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/ABI/stable/sysfs-block | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index de3b86a3dfa55..288626e8cb532 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -516,6 +516,23 @@ Description:
 		scheduler module, if it isn't already present in the system.
 
 
+What:		/sys/block/<disk>/queue/stable_writes
+Date:		September 2020
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] This file will contain '1' if memory must not be modified
+		while it is being used in a write request to this device.  When
+		this is the case and the kernel is performing writeback of a
+		page, the kernel will wait for writeback to complete before
+		allowing the page to be modified again, rather than allowing
+		immediate modification as is normally the case.  This
+		restriction arises when the device accesses the memory multiple
+		times where the same data must be seen every time -- for
+		example, once to calculate a checksum and once to actually write
+		the data.  If no such restriction exists, this file will contain
+		'0'.  This file is writable for testing purposes.
+
+
 What:		/sys/block/<disk>/queue/throttle_sample_time
 Date:		March 2017
 Contact:	linux-block@vger.kernel.org
-- 
2.34.1

