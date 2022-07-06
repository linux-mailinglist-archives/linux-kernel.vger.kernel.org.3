Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62165684BA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbiGFKHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbiGFKGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:06:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B5325284;
        Wed,  6 Jul 2022 03:06:53 -0700 (PDT)
Received: from localhost (unknown [188.24.177.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0957D66019A9;
        Wed,  6 Jul 2022 11:06:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657102012;
        bh=3I35O1AT5GLyf6sHTq4insD++gylKKUaNaI+fLxsC3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mKVvA9izt0IBZJgG1uh/thru3eAbfsII5K4qfu7MLrGh7jHSz9auEHbga3XuQGwJO
         ku8doxLrQf8MJPwNSzZuqG7KNUb4PMGBCd56eBCHbfXb8xJKuEOC4JtDv3s1cG6RvN
         PTlQoHrbSkYpZMw/CCOrXH3UrcnJ0yk0VyGi1US9wbfiw0EKsz5INGYXI/JJfUi/2w
         KRrhT3dsKN6ubEZO43shb+o4SZKQNGnCQoImVPy2F2CyXJpwRPGZK33jiXTG57eQ+X
         tl63C1QhZKmv0plHopwXW7g2L3fzyxnPntHzKSJdY+kz7/J7ABN9iLpiaWQikk3oEu
         b0MW0/60EYpTw==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Anastasios Vacharakis <vacharakis@o2mail.de>,
        cristian.ciocaltea@collabora.com
Subject: [PATCH 4/5] spi: amd: Drop io_base_addr member from struct amd_spi
Date:   Wed,  6 Jul 2022 13:06:25 +0300
Message-Id: <20220706100626.1234731-5-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220706100626.1234731-1-cristian.ciocaltea@collabora.com>
References: <20220706100626.1234731-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The io_base_addr member of struct amd_spi is not referenced anywhere
in the driver implementation and there is no indication that it could
be used in the future, hence drop it.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/spi/spi-amd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 1aa19a02a7b6..6eddb950e1ad 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -47,7 +47,6 @@ enum amd_spi_versions {
 
 struct amd_spi {
 	void __iomem *io_remap_addr;
-	unsigned long io_base_addr;
 	enum amd_spi_versions version;
 };
 
-- 
2.36.1

