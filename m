Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FB656A114
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 13:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbiGGLeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 07:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiGGLdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 07:33:54 -0400
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53572B186
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 04:33:50 -0700 (PDT)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20220707113348b365bb8b4603bba964
        for <linux-kernel@vger.kernel.org>;
        Thu, 07 Jul 2022 13:33:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=W67wyaO2xOIGG6zFJudTz0xEL57vL/G0q650GVjP03A=;
 b=kmKdDPslDJwc7czA7+rVfAQ4TQp7gcPPw6Al9Bxkuqc0SMZPS5Jku/OaSNd/j1xu1iynBK
 1MDSYH+qTNxqxcLE+FYivPbx4MNXrCdL+gY5zDoaj7mwJdGkfbJ0QHJYNkEP1jkXU8uA7h8e
 uZkNEcCBlX2xcGxnPByns0/Ff6iIA=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v2 2/4] tty: n_gsm: fix DM command
Date:   Thu,  7 Jul 2022 13:32:21 +0200
Message-Id: <20220707113223.3685-2-daniel.starke@siemens.com>
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

n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
the newer 27.010 here. Chapter 5.3.3 defines the DM response. There exists
no DM command. However, the current implementation incorrectly sends DM as
command in case of unexpected UIH frames in gsm_queue().
Correct this behavior by always sending DM as response.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

No changes have been applied compared to v1.

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 1a70e7ae90cc..90060018928f 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2207,7 +2207,7 @@ static void gsm_queue(struct gsm_mux *gsm)
 	case UIH:
 	case UIH|PF:
 		if (dlci == NULL || dlci->state != DLCI_OPEN) {
-			gsm_command(gsm, address, DM|PF);
+			gsm_response(gsm, address, DM|PF);
 			return;
 		}
 		dlci->data(dlci, gsm->buf, gsm->len);
-- 
2.34.1

