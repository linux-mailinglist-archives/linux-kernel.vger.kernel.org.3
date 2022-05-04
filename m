Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217D051999A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346202AbiEDIXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346326AbiEDIWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:22:45 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 May 2022 01:19:08 PDT
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFA923159
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:19:08 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202205040818030c5c21e9e1d91fcd69
        for <linux-kernel@vger.kernel.org>;
        Wed, 04 May 2022 10:18:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=12HT1Ao5+Dua+FFTNyr8TB2uAbEalM9eEJBJCOeiwO8=;
 b=lB/W8dXsBrELvP8Fnf096jLJonej7ONtbTXq/+9zW+cf/YrcE2ryxg5nE2tKh4mb7pDg8k
 eryqF2uNN7lznS2oG1Xx94zgT6ApV2iHnjBykWMEB4oUv8XKapFTBS+IEZ0hCqi7Psai59wF
 faKQY/2xbR3Sqh3dAIywrVIxui45Q=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 1/3] tty: n_gsm: fix buffer over-read in gsm_dlci_data()
Date:   Wed,  4 May 2022 10:17:31 +0200
Message-Id: <20220504081733.3494-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

'len' is decreased after each octet that has its EA bit set to 0, which
means that the value is encoded with additional octets. However, the final
octet does not decreases 'len' which results in 'len' being one byte too
long. A buffer over-read may occur in tty_insert_flip_string() as it tries
to read one byte more than the passed content size of 'data'.
Decrease 'len' also for the final octet which has the EA bit set to 1 to
write the correct number of bytes from the internal receive buffer to the
virtual tty.

Fixes: 2e124b4a390c ("TTY: switch tty_flip_buffer_push")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index a38b922bcbc1..9b0b435cf26e 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1658,6 +1658,7 @@ static void gsm_dlci_data(struct gsm_dlci *dlci, const u8 *data, int clen)
 			if (len == 0)
 				return;
 		}
+		len--;
 		slen++;
 		tty = tty_port_tty_get(port);
 		if (tty) {
-- 
2.34.1

