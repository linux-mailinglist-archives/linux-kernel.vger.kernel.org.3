Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FA056A116
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 13:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbiGGLd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 07:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbiGGLdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 07:33:54 -0400
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BE32F65E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 04:33:51 -0700 (PDT)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20220707113349af81e81e24c363f090
        for <linux-kernel@vger.kernel.org>;
        Thu, 07 Jul 2022 13:33:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=tmOmxJuwDN3a6R4Br5jQIzbrMca5twfGKRAch87aKRA=;
 b=Eo/82hWLvgBjkpDrudwKolNmwotdPnfguGBzU29dqR+tkqAtfMEn+i/KNWiJJfWDVJn7m1
 4JcQ7mjAOrYjHHJ6yAQCxc/zX5mZ4pLMXMVB/hHmvTPXgvNJniSRlihTJi19vCsy4VRGm+bq
 TvpCY+/0FBSPzz4TJDXlNK5YF6H68=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v2 3/4] tty: n_gsm: fix flow control handling in tx path
Date:   Thu,  7 Jul 2022 13:32:22 +0200
Message-Id: <20220707113223.3685-3-daniel.starke@siemens.com>
In-Reply-To: <20220707113223.3685-1-daniel.starke@siemens.com>
References: <20220707113223.3685-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

The current implementation constipates all transmission paths during flow
control except for flow control frames. However, these may not be located
at the beginning of the transmission queue of the control channel.
Ensure that flow control frames in the transmission queue for the control
channel are always handled even if constipated by skipping through other
messages.

Fixes: 0af021678d5d ("tty: n_gsm: fix deadlock and link starvation in outgoing data path")
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

No changes have been applied compared to v1.

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 90060018928f..51447ccccbab 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -891,7 +891,7 @@ static int gsm_data_kick(struct gsm_mux *gsm)
 	/* Serialize control messages and control channel messages first */
 	list_for_each_entry_safe(msg, nmsg, &gsm->tx_ctrl_list, list) {
 		if (gsm->constipated && !gsm_is_flow_ctrl_msg(msg))
-			return -EAGAIN;
+			continue;
 		ret = gsm_send_packet(gsm, msg);
 		switch (ret) {
 		case -ENOSPC:
-- 
2.34.1

