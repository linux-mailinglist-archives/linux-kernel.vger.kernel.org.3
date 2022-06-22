Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB5B554B42
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357168AbiFVNZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357274AbiFVNYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:24:55 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A4839145;
        Wed, 22 Jun 2022 06:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=9UM/4/gB5wcm+IeNSkrcMKxLYpue+oHqXAFXchZ+pMk=; b=0r5AesKWDN1uqFV2G3Dr4jNfz5
        4+GKcUKfrkcbec28IioF2+XL4kP3oIdjdg92DNSWMSxMzMco+T721BB7xH0pGuKzcZPFUNibaZy1t
        jBZ7E6DWqaGZTrE81ZwSRsQrESAwqdmpSifMPxYMGESJsbY93jJL/lZxPD92Qjj8DjSBay8Yk4UME
        Giad3WHS34X5c1CX9pn+qYCV6ocsY1BjIFRjBXwq+UuHSvvmO8At4cJ8HFAR1VJBEn986AuF5Z6lw
        mTkcSHMWPsS5V+PWxKAhUfgRAM6h7w9zfYCJE+7R7ZKJSzBmbXJjwxdYZeacNQwdv3f4gPcs03DQI
        ufOqaXtQ==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1o40Kl-000abh-6p; Wed, 22 Jun 2022 16:23:50 +0300
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Timo Alho <talho@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mian Yousaf Kaukab <ykaukab@suse.de>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] firmware: tegra: bpmp: do only aligned access to IPC memory area
Date:   Wed, 22 Jun 2022 16:22:59 +0300
Message-Id: <20220622132300.1746201-1-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timo Alho <talho@nvidia.com>

Use memcpy_toio and memcpy_fromio variants of memcpy to guarantee
no unaligned access to IPC memory area. This is to allow the IPC
memory to be mapped as Device memory to further suppress speculative
reads from happening within the 64kB memory area above the IPC memory
when 64kB memory pages are used.

Signed-off-by: Timo Alho <talho@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/firmware/tegra/bpmp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
index 5654c5e9862b..037db21de510 100644
--- a/drivers/firmware/tegra/bpmp.c
+++ b/drivers/firmware/tegra/bpmp.c
@@ -201,7 +201,7 @@ static ssize_t __tegra_bpmp_channel_read(struct tegra_bpmp_channel *channel,
 	int err;
 
 	if (data && size > 0)
-		memcpy(data, channel->ib->data, size);
+		memcpy_fromio(data, channel->ib->data, size);
 
 	err = tegra_bpmp_ack_response(channel);
 	if (err < 0)
@@ -245,7 +245,7 @@ static ssize_t __tegra_bpmp_channel_write(struct tegra_bpmp_channel *channel,
 	channel->ob->flags = flags;
 
 	if (data && size > 0)
-		memcpy(channel->ob->data, data, size);
+		memcpy_toio(channel->ob->data, data, size);
 
 	return tegra_bpmp_post_request(channel);
 }
@@ -420,7 +420,7 @@ void tegra_bpmp_mrq_return(struct tegra_bpmp_channel *channel, int code,
 	channel->ob->code = code;
 
 	if (data && size > 0)
-		memcpy(channel->ob->data, data, size);
+		memcpy_toio(channel->ob->data, data, size);
 
 	err = tegra_bpmp_post_response(channel);
 	if (WARN_ON(err < 0))
-- 
2.36.1

