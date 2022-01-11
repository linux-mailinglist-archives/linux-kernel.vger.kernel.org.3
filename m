Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6CB48A8BA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348697AbiAKHsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:48:06 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33478 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348682AbiAKHsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:48:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FD7C614CB;
        Tue, 11 Jan 2022 07:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BCDC36AEF;
        Tue, 11 Jan 2022 07:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641887282;
        bh=bst8MtsKlBT1ntZk0xas+PDw1Hr2JI/ZKVMtFJgfm1w=;
        h=Date:From:To:Cc:Subject:From;
        b=GLnMhYmjsfpHqorr9zb4hbJNpn4aQcPmXofkv0SSBkxMwm+ABkePN2G8BlnLDwbOf
         x4islPqNV5/TlXLG/8Ena9YJpYOkn9zeFt5HnINERRxqYX1YaCO7NGsgJBMt/Mq9XW
         6eHlSMhi7+uFm+H6og9LBdF2I2UiNC7qk1rClptwMEb1j1Wp0kdVrCnwQN5kDUNKu8
         HBnAm96p2G7qvN8oBwAwOuLBwTavDnY/K6AjqIwEQKKPltUkKAY4Ktghh05pxheTKT
         0uO4Q9EE1tS17LbmZihbejoAeXhW3oh7SYAmFiYIUU8vUfSoyvHngHt5SPe4T0xWJd
         Gtc+egLO7r4RA==
Date:   Tue, 11 Jan 2022 01:54:27 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] usb: host: ehci-sched: Use struct_size() in kzalloc()
Message-ID: <20220111075427.GA76390@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worse scenario, could lead to heap overflows.

Also, address the following sparse warning:
drivers/usb/host/ehci-sched.c:1168:40: warning: using sizeof on a flexible structure

Link: https://github.com/KSPP/linux/issues/160
Link: https://github.com/KSPP/linux/issues/174
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/usb/host/ehci-sched.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
index 0f85aa9b2fb1..bd542b6fc46b 100644
--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -1165,10 +1165,8 @@ static struct ehci_iso_sched *
 iso_sched_alloc(unsigned packets, gfp_t mem_flags)
 {
 	struct ehci_iso_sched	*iso_sched;
-	int			size = sizeof(*iso_sched);
 
-	size += packets * sizeof(struct ehci_iso_packet);
-	iso_sched = kzalloc(size, mem_flags);
+	iso_sched = kzalloc(struct_size(iso_sched, packet, packets), mem_flags);
 	if (likely(iso_sched != NULL))
 		INIT_LIST_HEAD(&iso_sched->td_list);
 
-- 
2.27.0

