Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F70449BA99
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385067AbiAYRrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:47:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56542 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382198AbiAYRqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:46:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6DB6B819DB;
        Tue, 25 Jan 2022 17:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32BDC340E6;
        Tue, 25 Jan 2022 17:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643132759;
        bh=dpNFflG1Kul0cblc0qXDQXXmYLTowF2QDwhwsWST6u8=;
        h=Date:From:To:Cc:Subject:From;
        b=YSaMWp2lLtvrFg8QwQ1S5JB8pAwi3XxyG3y2BfJviBW4/fhmASqZAZAUMlsqY07iy
         jhNpyOQFJCzMIkKYej0uP1C0XcLvqTPiGedh2sSVbDtqgUJf9XYMpBZnOyI55kwZ89
         hx3+qfcw9uiBccsDtVQze6OnVOt5T7Xr3Yb4M+Ci1+NafAe8VMvaUjVF62AEO6ntT2
         pONrQPhwlrQOT4yjvng/IavPvNw2bB6CM0YFeNE832ktu3sqVo5KTbhGgI6h0usaPL
         TY+hWAOp65b1/xmNK615x6akKZfP1c8Ypk8J9/RQBhlXdqs04WQqBl3HBDvX0fJF2a
         ovL21RV50wSFg==
Date:   Tue, 25 Jan 2022 11:52:45 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] power: supply: cros_usbpd: Use struct_size() helper in
 kzalloc()
Message-ID: <20220125175245.GA66154@embeddedor>
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
drivers/power/supply/cros_usbpd-charger.c:107:23: warning: using sizeof on a flexible structure

Link: https://github.com/KSPP/linux/issues/174
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/power/supply/cros_usbpd-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index d89e08efd2ad..cadb6a0c2cc7 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -104,7 +104,7 @@ static int cros_usbpd_charger_ec_command(struct charger_data *charger,
 	struct cros_ec_command *msg;
 	int ret;
 
-	msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
+	msg = kzalloc(struct_size(msg, data, max(outsize, insize)), GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
 
-- 
2.27.0

