Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520FB4611BF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 11:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244076AbhK2KK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 05:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243281AbhK2KIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 05:08:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A21C0698C3;
        Mon, 29 Nov 2021 01:47:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3AFA61265;
        Mon, 29 Nov 2021 09:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BDBC58325;
        Mon, 29 Nov 2021 09:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638179276;
        bh=INPTpNH82uZnt9Dd9GOkeIbAFEVs1Y0clSg4UoK9T8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VsPOUxP1Fi7Th/1KlzEPtARVVMaRY6WLk9lWcaqVjJT/gA5PpcYArqyf0A+wqsfyU
         8DbFAkOQWLhvgV0vTSN56Ld6f4w7CMcOsHBJ7Hf7NzgnOvSsXg4luYkkQWnSCfQNcg
         O1nA3mCgwDKCn2l2YV6VtFJY5UIACP/XQYi+iE+9vQcd0f9anaID8G0YCtgl+c1L3X
         gXBpcfIoSfRyKuIuuTo4hiz+eSKVJA3ew1wD3RxcfYAj1rvbRfqT08FkwlPMp3fd3P
         600/Yj3jTKGmwxh2vmNm+JZUKf6q8G51yv+dY9iVD340C/Y2WJSXwg1hiQcLWeOCBU
         riVwaUIBBFFQA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mrdGM-000RBK-Cu; Mon, 29 Nov 2021 10:47:54 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 07/20] media: si21xx: report eventual errors at set_frontend
Date:   Mon, 29 Nov 2021 10:47:39 +0100
Message-Id: <e955d3f208794bc9589401f316910f30afb93aa6.1638179135.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638179135.git.mchehab+huawei@kernel.org>
References: <cover.1638179135.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs while setting the registers at set_frontend,
it is silently ignored. Yet, the variable status is updated.

Change the logic to return an error if it fails to write values
to the registers.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1638179135.git.mchehab+huawei@kernel.org/

 drivers/media/dvb-frontends/si21xx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb-frontends/si21xx.c b/drivers/media/dvb-frontends/si21xx.c
index e31eb2c5cc4c..001b23588389 100644
--- a/drivers/media/dvb-frontends/si21xx.c
+++ b/drivers/media/dvb-frontends/si21xx.c
@@ -711,7 +711,7 @@ static int si21xx_set_frontend(struct dvb_frontend *fe)
 	int i;
 	bool inband_interferer_div2[ALLOWABLE_FS_COUNT];
 	bool inband_interferer_div4[ALLOWABLE_FS_COUNT];
-	int status;
+	int status = 0;
 
 	/* allowable sample rates for ADC in MHz */
 	int afs[ALLOWABLE_FS_COUNT] = { 200, 192, 193, 194, 195,
@@ -747,8 +747,6 @@ static int si21xx_set_frontend(struct dvb_frontend *fe)
 	rf_freq = 10 * c->frequency ;
 	data_rate = c->symbol_rate / 100;
 
-	status = PASS;
-
 	band_low = (rf_freq - lnb_lo) - ((lnb_uncertanity * 200)
 					+ (data_rate * 135)) / 200;
 
@@ -832,6 +830,9 @@ static int si21xx_set_frontend(struct dvb_frontend *fe)
 	state->fs = sample_rate;/*ADC MHz*/
 	si21xx_setacquire(fe, c->symbol_rate, c->fec_inner);
 
+	if (status)
+		return -EREMOTEIO;
+
 	return 0;
 }
 
-- 
2.33.1

