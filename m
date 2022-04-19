Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94ECA5066D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349936AbiDSIXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237934AbiDSIXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:23:21 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Apr 2022 01:20:39 PDT
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAAA2CC97
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:20:39 -0700 (PDT)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202204190819367227a901f5d77c1197
        for <linux-kernel@vger.kernel.org>;
        Tue, 19 Apr 2022 10:19:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=iq3DrAL7P13m16XZiQMLTG/b02/7hkWGyY4ZwOKkH7c=;
 b=LrukbCnh+CYrJLVbjMgFK3T1i4WGo/1CwQEatFtqf3vGFB6akDmXX0/XUgqwZYCIKNwBCL
 gl5fZj7cdfLAqXeWC4j16yzxOleaEI4qvGnwwibDO7W6pq09eRUuLOvG1NlmZONbL+vmevfP
 fsLvDZVlqwPISmqti636BZCZtEGFU=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v2 18/20] tty: n_gsm: clean up implicit CR bit encoding in address field
Date:   Tue, 19 Apr 2022 01:19:30 -0700
Message-Id: <20220419081930.5886-1-daniel.starke@siemens.com>
In-Reply-To: <YlkRvMhDfwgNZptV@kroah.com>
References: <YlkRvMhDfwgNZptV@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

