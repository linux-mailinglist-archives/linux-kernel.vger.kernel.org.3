Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F0A500A51
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242100AbiDNJtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241594AbiDNJq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:46:58 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 02:44:03 PDT
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD1C710CE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:44:03 -0700 (PDT)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20220414094254ee00ff8e333c5c7a66
        for <linux-kernel@vger.kernel.org>;
        Thu, 14 Apr 2022 11:43:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=d8jKoM9faKsGDQmqC/btc4Rd+AthsQGvuIMNUMeUktA=;
 b=bnygzUD5p6LhzJ+6pWthHULcIJN48ylDv+Bvyl3FblVIRF+VXzJZnTWUwOH9Z3OZSE1tYH
 eyViCjnp2AZY4wZ8Nled9dCfHdzJlMDgDkDECHEfBYhYf88iOopLiNRbR8LYUc0rVNkwp70E
 LQqN0n4ufysRsTKmPQ7V+5Hipcxss=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 20/20] tty: n_gsm: fix incorrect UA handling
Date:   Thu, 14 Apr 2022 02:42:25 -0700
Message-Id: <20220414094225.4527-20-daniel.starke@siemens.com>
In-Reply-To: <20220414094225.4527-1-daniel.starke@siemens.com>
References: <20220414094225.4527-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
the newer 27.010 here. Chapter 5.4.4.2 states that any received unnumbered
acknowledgment (UA) with its poll/final (PF) bit set to 0 shall be
discarded. Currently, all UA frame are handled in the same way regardless
of the PF bit. This does not comply with the standard.
Remove the UA case in gsm_queue() to process only UA frames with PF bit set
to 1 to abide the standard.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 1905a0fea89b..cf861598a646 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1871,7 +1871,6 @@ static void gsm_queue(struct gsm_mux *gsm)
 			}
 		}
 		break;
-	case UA:
 	case UA|PF:
 		if (cr == 0 || dlci == NULL)
 			break;
-- 
2.25.1

