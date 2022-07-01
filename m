Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973B5563379
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbiGAMYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiGAMYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:24:51 -0400
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0779327CFE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 05:24:49 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20220701122446812e1f51978c908374
        for <linux-kernel@vger.kernel.org>;
        Fri, 01 Jul 2022 14:24:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=H4/cdYWoV7hcFcg04cuIby6EbLcAlaypN+URV4tzbk8=;
 b=NxWToFnf7UzUGLpUaITnnLpy2aPA4fSoWnKmGjKaUFdQDCSXx34ENQoz0Wid/xwe/7hJw7
 4VOvCLG38+6QRzGX8NU/mwZkAwPNgXGpYMKi9GYlaPiA4JUabMxpkWM2CnhypCUMTeLRanzD
 BxeEPzpkF2X2q2vz2yARVMg0uHHEs=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v5 2/2] tty: n_gsm: fix resource allocation order in gsm_activate_mux()
Date:   Fri,  1 Jul 2022 14:23:32 +0200
Message-Id: <20220701122332.2039-2-daniel.starke@siemens.com>
In-Reply-To: <20220701122332.2039-1-daniel.starke@siemens.com>
References: <20220701122332.2039-1-daniel.starke@siemens.com>
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

Within gsm_activate_mux() all timers and locks are initiated before the
actual resource for the control channel is allocated. This can lead to race
conditions.

Allocate the control channel DLCI object first to avoid race conditions.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Merged v4 into the tty-testing branch. No other changes applied.

Link: https://lore.kernel.org/all/20220701061652.39604-8-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 79869f2b570c..ba399a660573 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2497,6 +2497,10 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
 	struct gsm_dlci *dlci;
 	int ret;
 
+	dlci = gsm_dlci_alloc(gsm, 0);
+	if (dlci == NULL)
+		return -ENOMEM;
+
 	timer_setup(&gsm->kick_timer, gsm_kick_timer, 0);
 	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
 	INIT_WORK(&gsm->tx_work, gsmld_write_task);
@@ -2513,9 +2517,6 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
 	if (ret)
 		return ret;
 
-	dlci = gsm_dlci_alloc(gsm, 0);
-	if (dlci == NULL)
-		return -ENOMEM;
 	gsm->has_devices = true;
 	gsm->dead = false;		/* Tty opens are now permissible */
 	return 0;
-- 
2.34.1

