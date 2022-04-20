Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07034508598
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377533AbiDTKSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377530AbiDTKRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:17:55 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Apr 2022 03:15:08 PDT
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B0962E7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:15:06 -0700 (PDT)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2022042010140142f38d9dfe652359bc
        for <linux-kernel@vger.kernel.org>;
        Wed, 20 Apr 2022 12:14:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ieRvSfzJc1NYOPDOUJRBMLhqaqAbjJNtd7H/SPVP6kA=;
 b=b36bfNTEUoDGWRCe8XvZHCKF3BmqBw4CWRSROYtGu6t/wgOSNn2tuLlgoF8rCNwwPiGKhW
 ckWXh+DPSRN0N6BMX74XspxmbVWv8vtQ/uWqdywlsx3HyafsUza/MRaGeIoTq48xmvMjnPxG
 e70bXuT4Y51dttt0mJvUwIGW/Za9Y=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v3 3/3] tty: n_gsm: clean up implicit CR bit encoding in address field
Date:   Wed, 20 Apr 2022 03:13:46 -0700
Message-Id: <20220420101346.3315-3-daniel.starke@siemens.com>
In-Reply-To: <20220420101346.3315-1-daniel.starke@siemens.com>
References: <20220420101346.3315-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
the newer 27.010 here. Chapter 5.2.1.2 describes the encoding of the
address field within the frame header. It is made up of the DLCI address,
command/response (CR) bit and EA bit.
Use the predefined CR value instead of a plain 2 in alignment to the
remaining code and to make the encoding obvious.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

All remarks have been incorporated. The commit title was changed from fix
to clean up and the fix and backporting remarks have been removed. The
remaining commit message body and the code changes remain untouched.
This is version 3 of the patch because the second version was missing the
change remarks.

Link: https://lore.kernel.org/all/YlkRvMhDfwgNZptV@kroah.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 9bf5aa508f0e..1beb4b28cd18 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -751,7 +751,7 @@ static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
 
 	*--dp = msg->ctrl;
 	if (gsm->initiator)
-		*--dp = (msg->addr << 2) | 2 | EA;
+		*--dp = (msg->addr << 2) | CR | EA;
 	else
 		*--dp = (msg->addr << 2) | EA;
 	*fcs = gsm_fcs_add_block(INIT_FCS, dp , msg->data - dp);
-- 
2.25.1

