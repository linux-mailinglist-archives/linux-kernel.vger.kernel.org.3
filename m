Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E423647F5D2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 09:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhLZIZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 03:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbhLZIZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 03:25:45 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB396C061401
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 00:25:44 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id v15so20855693ljc.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 00:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wj9Dlof0Sm1oSqOE7UH+0bYOtV78mP2BR3sY8NRgVfk=;
        b=M9wnDPn58e7MYWkQ9Zcbf3x4PabKQnBj4KuDC9T7vXo8BASPMjZvS8iyCSJ+QUKDUk
         4QU6tyjXQi6lkPmiBbBFlQYb5D996fioUCoUAmiPr8yG/LugszutrCAK88cZ+xqfYBdQ
         OC54KO9kKXcLzM+BFxxdp0ltWKSCIMWqy9YSMsTNuraTzIbtUz4d+Ehy+8IaWT3fny+E
         /j5/vP1g4fm5nzzE3+LT9gEB/dj1xgcueSaOdEPlBMmE9HXQoHMWMOPkUWmcoTwEBZql
         9xSndYoQWOfI77beS2j0OAvwLKlZKakGRjo0Z9Z5PtnZDjjF54JB8l4wJkERFdrNciZ6
         jh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wj9Dlof0Sm1oSqOE7UH+0bYOtV78mP2BR3sY8NRgVfk=;
        b=Uo/NYZ5wOYbbICtU0/M4jdNCA7uYLFfvlVb/OxXeGrGt0ECpkzjv9i1kgdkiDiDCc7
         E9h7SzawuCwxgEKOQfACGI63NxguuIZo4WNheFk7chw7qPPGYVfq3/TCTKSvG32d4iiR
         zbQ8V41YK7JFcovM2OmW1Jnv9qM/eU3ujwu1UKN4gYyTWd5tS87QNDmHlTodMfoZ5/oB
         Jnz8Wk5xX0kaJyDa6kJEa20Wv5pc5J9P9D4BjhIM1tmr0/SrIyD7QEEf2Y6M8+wrcUsP
         ZdWI+oAYIFC6DPOTJEGkN2aNm0QYM2QzwHFHpdiocuuFYetCL+9RLlqjQ0od1PDgGLuo
         RtAg==
X-Gm-Message-State: AOAM531OvycvimZancWFB2tQQLCXuN3/W25q+n+VrrB2m92zdjZMPm7Z
        Uxp3jeLhKTAFRyrmD5fczea2cA==
X-Google-Smtp-Source: ABdhPJwXYDAUz9uu4jc8ZhRoQQ/TsrLQscIr2VwvkqjVFaNaw6JhSpm2/tpD56HFfU6CM04TGvzsFA==
X-Received: by 2002:a2e:5c04:: with SMTP id q4mr10307421ljb.334.1640507142703;
        Sun, 26 Dec 2021 00:25:42 -0800 (PST)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id z5sm1309023lfd.184.2021.12.26.00.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 00:25:42 -0800 (PST)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Gromm <christian.gromm@microchip.com>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 1/3] staging: most: dim2: update renesas compatible string
Date:   Sun, 26 Dec 2021 11:25:28 +0300
Message-Id: <20211226082530.2245198-2-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211226082530.2245198-1-nikita.yoush@cogentembedded.com>
References: <20211226082530.2245198-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "renesas,rcar-gen3-mlp" instead of "rcar,medialb-dim2"
- the documented vendor prefix for Renesas is "renesas,"
- existing r-car devices use "rcar-genN-XXX" pattern.

There are currently no in-tree users to update.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/staging/most/dim2/dim2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
index bd102329d8c8..044e4bdeeaf2 100644
--- a/drivers/staging/most/dim2/dim2.c
+++ b/drivers/staging/most/dim2/dim2.c
@@ -1086,7 +1086,7 @@ static const struct of_device_id dim2_of_match[] = {
 		.data = plat_data + RCAR_H2
 	},
 	{
-		.compatible = "rcar,medialb-dim2",
+		.compatible = "renesas,rcar-gen3-mlp",
 		.data = plat_data + RCAR_M3
 	},
 	{
-- 
2.30.2

