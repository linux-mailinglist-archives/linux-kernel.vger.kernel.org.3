Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CE94B9A96
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbiBQIHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:07:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236345AbiBQIHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:07:15 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 00:07:01 PST
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CD227DF3B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:07:01 -0800 (PST)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20220217080556eb13713ff72e72840b
        for <linux-kernel@vger.kernel.org>;
        Thu, 17 Feb 2022 09:05:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=1PPSTDXqlzyXQhlxtHT8JuIds5BO+gt8oYzfP79dzIw=;
 b=f97meTGniVSpdNfFcFarDXigvz7uWji+MTf5hGOp8qubvwq83E1cM5SdMSIHkqVP+oe4Hl
 KH/I5NNV+hkBjygxJsoPt9qJHImsFcqpdulpGz6F/JRocBRExn2qeUT+x3wuZUBDTljGDUGW
 WZuK1p/NXoxlM5GAV41p/AjpFeoPQ=;
From:   daniel.starke@siemens.com
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 1/1] tty: n_gsm: fix encoding of control signal octet bit DV
Date:   Thu, 17 Feb 2022 00:05:49 -0800
Message-Id: <20220217080555.5387-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-7517:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
the newer 27.010 here. Chapter 5.4.6.3.7 describes the encoding of the
control signal octet used by the MSC (modem status command). The same
encoding is also used in convergence layer type 2 as described in chapter
5.5.2. Table 7 and 24 both require the DV (data valid) bit to be set 1 for
outgoing control signal octets sent by the DTE (data terminal equipment),
i.e. for the initiator side.
Currently, the DV bit is only set if CD (carrier detect) is on, regardless
of the side.

This patch fixes this behavior by setting the DV bit on the initiator side
unconditionally.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 0b1808e3a912..e199315a158e 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -439,7 +439,7 @@ static u8 gsm_encode_modem(const struct gsm_dlci *dlci)
 		modembits |= MDM_RTR;
 	if (dlci->modem_tx & TIOCM_RI)
 		modembits |= MDM_IC;
-	if (dlci->modem_tx & TIOCM_CD)
+	if (dlci->modem_tx & TIOCM_CD || dlci->gsm->initiator)
 		modembits |= MDM_DV;
 	return modembits;
 }
-- 
2.25.1

