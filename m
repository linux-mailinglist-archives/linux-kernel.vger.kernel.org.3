Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FA34AA43D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378076AbiBDXWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:22:37 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:45530 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiBDXWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:22:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CECA1CE24BE;
        Fri,  4 Feb 2022 23:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C62C004E1;
        Fri,  4 Feb 2022 23:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644016953;
        bh=ILdoUIoX1tocW/C8hL7JwqWasbTDT9C6TZUJmP/1rAk=;
        h=Date:From:To:Cc:Subject:From;
        b=XHSTQxHzY2S6CQM/u4VOOLGOCbBtDuJ65nRjfmKCzV1O0vY6bK2p6/HNXln7/BlWn
         wEhQg7YSoNVZdgCb4xVJsrPQkY7+d6Ttu+nTlXWlQRSHRxJotEOSg7/NByCI+4gTfu
         t/AbKhVB1emP2zkY9DW/K7OxzBUfcJYIfCutKD2DF/knwcVRBcxjbMJ3zzT7+cxxSO
         BiWZDQf4IOsTOM1eMwzOCaqgidXBalCuEtjPzdIgT617yYAoaNcbEpvqE5SSEbtYmw
         Yd/CjOqnhLDcrw8H1uj9DIV8OTkTCxLCi9wm60owaQWmewMhkrusCq0rqAz3cQ//1M
         73WxerqL/b78Q==
Date:   Fri, 4 Feb 2022 17:29:44 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] staging: gdm724x: Replace one-element array with
 flexible-array member
Message-ID: <20220204232944.GA454945@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use “flexible array members”[1] for these cases. The older
style of one-element or zero-length arrays should no longer be used[2].

This helps with the ongoing efforts to globally enable -Warray-bounds
and get us closer to being able to tighten the FORTIFY_SOURCE routines
on memcpy().

This issue was found with the help of Coccinelle and audited and fixed,
manually.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/staging/gdm724x/hci_packet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gdm724x/hci_packet.h b/drivers/staging/gdm724x/hci_packet.h
index faecdfbc664f..3bb01e94f3b5 100644
--- a/drivers/staging/gdm724x/hci_packet.h
+++ b/drivers/staging/gdm724x/hci_packet.h
@@ -34,7 +34,7 @@ struct hci_packet {
 struct tlv {
 	u8 type;
 	u8 len;
-	u8 *data[1];
+	u8 *data[];
 } __packed;
 
 struct sdu_header {
-- 
2.27.0

