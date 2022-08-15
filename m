Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E51592959
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbiHOGMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiHOGL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:11:56 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF63818E09;
        Sun, 14 Aug 2022 23:11:51 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id r17so9372198lfm.11;
        Sun, 14 Aug 2022 23:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=KE7Doo8+PSeMnrmOEri8h44PeWIbSZ8XCkY/na8+SzA=;
        b=VmBDoQQ9WGgBw/vh9zx81bo1VrynPsT4KZqrCk5M77yMWq0tPdBUHK953G3Eel4vIP
         k+TN3ydT9hw355/+QhomoIT3aVEUzvKQk16GNxWb53JbhWZBR3iHBL+vu0GlEu/bDcrX
         6UWWpwN8QWcO6HcRIeIwr82vh90o8xrGW4VjL1BB6drq8TjEJMGGMONFk3Ioi7W9V3Im
         wYKdXUma3CngzpOS1+ddB/xH0H8rxAiUXqYttJvZEy6DY4cDtYeh3l/pDSUSojDSwVjM
         z8JHhidA7thK3SvWfr4gS1Lh0LiJeZk9JXUxhLs2+tJQMQbyTUcYxZAU4RsFEGkI6EMy
         myqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KE7Doo8+PSeMnrmOEri8h44PeWIbSZ8XCkY/na8+SzA=;
        b=obTmv7Z8dILtHM4R7tO4XlIdD/E55K1K/IpTfouJA+5TYXoaBb9TFDYFgvyaFuMotD
         JAMowEyMpEa5hsZ8+qBtfHmgmZW0mxS+Q2G9jtn9EGmpMxwZ1WpCUzCD+CU5ozC55kl9
         ohboZzU2NwMt7rOUmo6T4loCRh2rTSjusuA+DdrG4tzuGyKd/JZXIqKmZ3/X9WMc8Ir9
         LqPUSKRCSJI6UWf2C5fAhFKYuYKyX70OquvM71sWA+83sVCxm1k6GlLq/4kG1KhbPZgu
         3wwtAItRYN6ABpvbUUtG7FsAxleUQZzIAs9UqpSqzcF0l/uSbr2+lMQFfmHELFcFbZX1
         BmhA==
X-Gm-Message-State: ACgBeo1etnse0sxYzKh2PM78tnt+Jb7HflncVR7zkkRMm5mJmxItSuNB
        Ahjf3rV62T+ON6ABFeW1FII=
X-Google-Smtp-Source: AA6agR6CG2hZmlkRXjNXVTCywbA+MLg4k5oVAR7dgkG5A0gAVZlQajUGkKSwZsVWw4fgG8gCKxm/tA==
X-Received: by 2002:ac2:4c81:0:b0:48a:e6de:213d with SMTP id d1-20020ac24c81000000b0048ae6de213dmr4903521lfl.366.1660543910105;
        Sun, 14 Aug 2022 23:11:50 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id g17-20020a2eb5d1000000b0025d70efeaaasm1296464ljn.75.2022.08.14.23.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 23:11:49 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/9] iio: adc: mcp3911: correct "microchip,device-addr" property
Date:   Mon, 15 Aug 2022 08:16:18 +0200
Message-Id: <20220815061625.35568-3-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815061625.35568-1-marcus.folkesson@gmail.com>
References: <20220815061625.35568-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Go for the right property name that is documented in the bindings.

Fixes: 3a89b289df5d ("iio: adc: add support for mcp3911")
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index f581cefb6719..f8875076ae80 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -210,7 +210,14 @@ static int mcp3911_config(struct mcp3911 *adc)
 	u32 configreg;
 	int ret;
 
-	device_property_read_u32(dev, "device-addr", &adc->dev_addr);
+	ret = device_property_read_u32(dev, "microchip,device-addr", &adc->dev_addr);
+
+	/*
+	 * Fallback to "device-addr" due to historical mismatch between
+	 * dt-bindings and implementation
+	 */
+	if (ret)
+		device_property_read_u32(dev, "device-addr", &adc->dev_addr);
 	if (adc->dev_addr > 3) {
 		dev_err(&adc->spi->dev,
 			"invalid device address (%i). Must be in range 0-3.\n",
-- 
2.37.1

