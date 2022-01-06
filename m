Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92AE486A9E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 20:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243430AbiAFTof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 14:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243403AbiAFToe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 14:44:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1521CC061245;
        Thu,  6 Jan 2022 11:44:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9216061D3C;
        Thu,  6 Jan 2022 19:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0814EC36AE3;
        Thu,  6 Jan 2022 19:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641498273;
        bh=QQcxc6J4i4UsXhEOPSxPvwGHPaHvWb6qL/1+WRep1rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jXo0mKowG/Z9oVi08B8qTxOs97N6rLAzJ09p8FBnZJwPlvbN3HSvKiimkGLdANlj4
         lc4NP+bB1EYOyxKzJ81rj0f0DFOHEFhuwieTE6KVRR6Du2zDuCRQzeGzYLqKyEnIJP
         6oGOBS8ONjhhcbLQQX3Lmcu2KHjxGMgwM8mIO1qvRMK+ABpRNGm+mBHTKGqwKdMfLj
         4Ab4TPipl9hynWMF/gpJuq63BRTF07I7kt8xdQ9ET0b9EmwMkdBGRQI+FpNIXwLuu7
         7ToBGsAM5/EvQT6f4VtJ4S1IB9L209I540zD+s5M6PbQw6Qma0yDnO8yK1U75bBLuT
         0JJgU7Vv/Lxag==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1n5YgY-000Vzo-Rq; Thu, 06 Jan 2022 20:44:30 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Robert Schlabbach" <Robert.Schlabbach@gmx.net>,
        Antti Palosaari <crope@iki.fi>, linux-media@vger.kernel.org
Subject: [PATCH] media: si6157: fix a tune regression for 6.1MHz
Date:   Thu,  6 Jan 2022 20:44:29 +0100
Message-Id: <71025d9c4f8d37f23cf080ee69e1d583bf320e3e.1641498239.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <trinity-59d726d3-993c-43c9-9e44-5be5cdfae74d-1641493525223@3c-app-gmx-bap38>
References: <trinity-59d726d3-993c-43c9-9e44-5be5cdfae74d-1641493525223@3c-app-gmx-bap38>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch which added support for 1.7MHz and 6.1 MHz has
two issues: there's a missing else for 1.7 and the value
for 6.1 MHz filter is decimal 10 (0x0a).

Fix those.

Reported-by: Robert Schlabbach <Robert.Schlabbach@gmx.net>
Fixes: 98c65a3dac95 ("media: si2157: add support for 1.7MHz and 6.1 MHz")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/tuners/si2157.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/tuners/si2157.c b/drivers/media/tuners/si2157.c
index 481c5c3b577d..a484239333ef 100644
--- a/drivers/media/tuners/si2157.c
+++ b/drivers/media/tuners/si2157.c
@@ -460,10 +460,10 @@ static int si2157_set_params(struct dvb_frontend *fe)
 
 	if (SUPPORTS_1700KHz(dev) && c->bandwidth_hz <= 1700000)
 		bandwidth = 0x09;
-	if (c->bandwidth_hz <= 6000000)
+	else if (c->bandwidth_hz <= 6000000)
 		bandwidth = 0x06;
-	if (SUPPORTS_1700KHz(dev) && c->bandwidth_hz <= 6100000)
-		bandwidth = 0x10;
+	else if (SUPPORTS_1700KHz(dev) && c->bandwidth_hz <= 6100000)
+		bandwidth = 0x0a;
 	else if (c->bandwidth_hz <= 7000000)
 		bandwidth = 0x07;
 	else if (c->bandwidth_hz <= 8000000)
-- 
2.33.1

