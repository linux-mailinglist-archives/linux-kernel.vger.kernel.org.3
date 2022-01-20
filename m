Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B33495645
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 23:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378038AbiATWOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 17:14:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58870 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378018AbiATWOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 17:14:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7042A618F8;
        Thu, 20 Jan 2022 22:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C30C340E0;
        Thu, 20 Jan 2022 22:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642716847;
        bh=/BYzlmSc3EXhLhUP/zTY4q87ax/HPCgh9lWXojPLRd4=;
        h=Date:From:To:Cc:Subject:From;
        b=ZQN+YTUBpg91uyZ4bbhz/gPU24X+VcANisoz6Xzwjj7exgzwzpFuPyNh9aOP5ILfA
         Att5HhsxsvrDFeAorzVYvh5YHhlRhIQZ7tH6ZGsEYMBr8MAYsKQ7e35m1XpdYBMjEL
         5f+yXOSDkRsE3/2Ozd1YYy6TRAU1IVeZFkIVuSUn/hijW7H3d+AlubZ4BunU6YzFHU
         9sp1EemqRLM5t5G4+510U04QQjcEKeO7wUfoSu08I1Q3ozNy4qDpwDrfhB1+P8FvRm
         QQwEAWA2WojQQPvBvp4iPtfEisc5EkidFe5VJN9aBqFyFGfz6psr4r+lq0pg7wFNpF
         +QboktrrfJS6w==
Date:   Thu, 20 Jan 2022 16:20:43 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] usb: host: fotg210: Use struct_size() helper in
 kzalloc()
Message-ID: <20220120222043.GA33559@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worst scenario, could lead to heap overflows.

Also, address the following sparse warnings:
drivers/usb/host/fotg210-hcd.c:4017:20: warning: using sizeof on a flexible structure

Link: https://github.com/KSPP/linux/issues/174
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/usb/host/fotg210-hcd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index 7af17c8e069b..c3fd375b4778 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -4014,10 +4014,8 @@ static struct fotg210_iso_sched *iso_sched_alloc(unsigned packets,
 		gfp_t mem_flags)
 {
 	struct fotg210_iso_sched *iso_sched;
-	int size = sizeof(*iso_sched);
 
-	size += packets * sizeof(struct fotg210_iso_packet);
-	iso_sched = kzalloc(size, mem_flags);
+	iso_sched = kzalloc(struct_size(iso_sched, packet, packets), mem_flags);
 	if (likely(iso_sched != NULL))
 		INIT_LIST_HEAD(&iso_sched->td_list);
 
-- 
2.27.0

