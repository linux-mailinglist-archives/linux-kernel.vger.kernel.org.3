Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CE455D022
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbiF0OWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237003AbiF0OUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:20:44 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B3511440;
        Mon, 27 Jun 2022 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=mTP9JKWbQi5X9Aiy3D3CFclT8K0qf8xcDbui6f15aq4=; b=W6sqRIxxffo0n30C1l7/fNRAmD
        BZCgVLH7F8ugAgt15IDudG2LwMVm2HLIjKFSNyo/RGTwsxeZXFJuOwqUyFrEklUIsBK2nEvjvAc1B
        VRu8xBrK0DEHlJWwrhrJ+bYeuLw1dkxoX3ZNJCUlTE8QzZY2PsM2CiwcmqPFEQ94jv2OxUpqw9rMA
        IyUwyct/W6JSoFHxz1+s+RqM68+yQouW16bHIRz2JgHZG+Kapnp2JMbP2OXTPBlUQbTSgX5+yHU39
        nB3V9Xw3uHjNIWG92tIrOqpRyke+NRKYKJ3OBpHGz/29ZHzwfjt7tqXUWbklh2Zu5PTYIvUkplE3/
        rRctnsPQ==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1o5pbO-003N2J-7w; Mon, 27 Jun 2022 17:20:33 +0300
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7/v3 16/22] gpu: host1x: Allow reset to be missing
Date:   Mon, 27 Jun 2022 17:20:02 +0300
Message-Id: <20220627142008.2072474-17-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627142008.2072474-1-cyndis@kapsi.fi>
References: <20220627142008.2072474-1-cyndis@kapsi.fi>
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

From: Mikko Perttunen <mperttunen@nvidia.com>

Host1x on Tegra234 does not have a software-controllable reset line.
As such, don't bail out if we don't find one in the device tree.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/dev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 5a57165ab0f6..c28939850bf6 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -423,9 +423,6 @@ static int host1x_get_resets(struct host1x *host)
 		return err;
 	}
 
-	if (WARN_ON(!host->resets[1].rstc))
-		return -ENOENT;
-
 	return 0;
 }
 
-- 
2.36.1

