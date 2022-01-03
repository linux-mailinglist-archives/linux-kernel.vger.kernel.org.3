Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F83482F95
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 10:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiACJp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 04:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiACJp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 04:45:27 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3166CC061761;
        Mon,  3 Jan 2022 01:45:27 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d9so68891911wrb.0;
        Mon, 03 Jan 2022 01:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=T5DDOgxL5O1mGP/BjJa3BFAGfWgawXo/hAw4SBh7aQo=;
        b=qDyMwxMDBtZgDNyVeZwTUcVrV6LGcEYlyYLR+dMs1cTDEdKZRvSDq1Kfr+CZ7yn46M
         8WHie5401uZN7dnziHiF+eT7KVxJDjK3IXqPjH3gxIfd+FyU3SOLSdWL5aQNfb+x4i9f
         avNtewEodCpIjke6bPV40Vii31eMHD6O6TkVZZfe1D7QlkiVJ6vPs33nKxRi36TLx2FJ
         8K+q8IJinUvOP2PV/5YomLyJWuaAXrKiDLa02JwpYUwCXDI/sG4mQQdgtZIq3WihT0ai
         wTfX8hZL4VYD2gvOmBxe9ZaQDPEtyiXqUEI+/8hsLbCbi3SVz2A6At954TLqYcTaOq77
         +NFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T5DDOgxL5O1mGP/BjJa3BFAGfWgawXo/hAw4SBh7aQo=;
        b=c1uyImMQsQScBpUUT+8aBo5jXUjqG+3rW2PFDggtGRdRZy+An7J9AfLYhtkm0v3FgO
         Gk8FL5D9fXweBfiW6+0dG5KpSrhoxi8aZLq8nfiUBYk5kdQIoy13qzWg/NG1hU3DY+re
         CeFZwoUINfPO2zo2XiGafDOKza1qWrA4MhG0ybi4uFADzOvU1UL4m4fSgsX5q8oudan4
         EfhfXpk61GWcwsMIQAr/sB9rmOl35/FTuEAF/4e7vdxXBeIn+LVWODzFATqilQXrySj+
         W+HIJi1/fiNiYqX14Jlz0c2orKttL18cz6ob6Q8N9Y+35RbcnL9m14rJN5pTx6ODUUyp
         g6kQ==
X-Gm-Message-State: AOAM530rNMlEbAHcpCpFhM60drTobt0POEf35x+6koabhsUwaW7zya6f
        4gOXLePfg94KKO6YEgVdZBpj+bJzLgE=
X-Google-Smtp-Source: ABdhPJyouQt7Kd6GIh4yY07o8rR3F5X49jA7mZgyI26ial9IKj5xt80kUeVo5RM6no7IF7YZsDwMgQ==
X-Received: by 2002:a05:6000:11c3:: with SMTP id i3mr37798770wrx.426.1641203125700;
        Mon, 03 Jan 2022 01:45:25 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:26e8:4300:8413:3f69:6728:4e17])
        by smtp.gmail.com with ESMTPSA id u20sm40035335wml.45.2022.01.03.01.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 01:45:25 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Nicolas Pitre <npitre@baylibre.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i3c@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] i3c/master/mipi-i3c-hci: correct the config reference for endianness
Date:   Mon,  3 Jan 2022 10:45:04 +0100
Message-Id: <20220103094504.3602-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The referred config BIG_ENDIAN does not exist. The config for the
endianness of the CPU architecture is called CPU_BIG_ENDIAN.

Correct the config name to the existing config for the endianness.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 1b73647cc3b1..8c01123dc4ed 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -662,7 +662,7 @@ static int i3c_hci_init(struct i3c_hci *hci)
 
 	/* Make sure our data ordering fits the host's */
 	regval = reg_read(HC_CONTROL);
-	if (IS_ENABLED(CONFIG_BIG_ENDIAN)) {
+	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) {
 		if (!(regval & HC_CONTROL_DATA_BIG_ENDIAN)) {
 			regval |= HC_CONTROL_DATA_BIG_ENDIAN;
 			reg_write(HC_CONTROL, regval);
-- 
2.17.1

