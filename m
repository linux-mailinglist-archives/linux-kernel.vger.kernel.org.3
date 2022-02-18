Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013924BB0B4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 05:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiBREV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 23:21:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiBREVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 23:21:12 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB2C1AF068;
        Thu, 17 Feb 2022 20:20:55 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id z17so6214598plb.9;
        Thu, 17 Feb 2022 20:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O7HIMK8IeakhG50GR/Ulau2dXDnZ+c8G1mQzoOKGfhY=;
        b=BeOANZqC8rHdl8tNubhuKoq5r1UNKGKN09+Bd/Yif2M9fNDNfj58u9POY6hQzBYyVf
         Iz9+x3HF1+HBN/g9hP6QHHziFKk71k6Vu+60dTODQ3l6AaX1iifGTuwQt6FgLVkB+JdI
         W6XAzjQdOaNbAtIq06KpDIgP1gL498kco+iO1NxNQN3/9ok9ukheqk3ipmO/gclxidfn
         /P+SV+CW6ri3sYUzfMFKhtYhiTuYY6b8hq9pzfGnpBE+VAkhvDx0u068Ml3M6TkLXJdC
         3W1Ik/VNSmUcYN9W61E82mZg/sSAXPWa77XDc3Bi/uN62VQRkbP++HT7RHGt9R/dHVB+
         krZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O7HIMK8IeakhG50GR/Ulau2dXDnZ+c8G1mQzoOKGfhY=;
        b=lXrIuwGqtExep/rRgkfPVl7F46pYoliVANE0Sdz1yCSPPcA9dgPaeLTjfOF96zJlSF
         PizFrAqM1Bgz7fqKekdLo7b9NcTFy9GHTeDuI5I9LuP70cKJgBO9wZJt5xpNBDdP95rn
         15Kr1pi5Yen94H6zivP42JnU+wgqkEWr+HQyKgnP9JC6QP5Oz272/BW7veLa2xUv1y8A
         svFInaWDA4L0K8cX7Yc5+tozgCRInMOVYPuD6LIUfyJuNFJm0Hvj7JDoBxNN7BKLnqhN
         31KCux3+ORiipATWUmE90MU2M0MzyGA4El1glkOwFbQBflvH+J2uoR0VVV7G+3ggR9TS
         V1Sw==
X-Gm-Message-State: AOAM532Fde2k0/CiiiesNvA4frlqX03Enivb8/eopNo/2GEWodMjBVRe
        Hmw+UrIayYiJwQBphQn9tfU=
X-Google-Smtp-Source: ABdhPJzaBpxIn/ff4O9KAnry8TtL+YNcJvdNBastNPqQ2g3NCuT3kTy5WfIcAr1NxYnEVBSs0JqeCA==
X-Received: by 2002:a17:902:d2cc:b0:14d:a21a:cbb6 with SMTP id n12-20020a170902d2cc00b0014da21acbb6mr5719394plc.34.1645158054628;
        Thu, 17 Feb 2022 20:20:54 -0800 (PST)
Received: from localhost.localdomain ([60.243.248.66])
        by smtp.gmail.com with ESMTPSA id h26sm9530300pgm.72.2022.02.17.20.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 20:20:54 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] iio: potentiometer: Change to firmware provided data
Date:   Fri, 18 Feb 2022 09:50:36 +0530
Message-Id: <20220218042038.15176-5-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220218042038.15176-1-jagathjog1996@gmail.com>
References: <20220218042038.15176-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using firmware provided data to get the device specific
structure, if not available fall back to id->driver_data.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/potentiometer/ds1803.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index 0ef3acb13c79..ca28ad147402 100644
--- a/drivers/iio/potentiometer/ds1803.c
+++ b/drivers/iio/potentiometer/ds1803.c
@@ -152,7 +152,9 @@ static int ds1803_probe(struct i2c_client *client, const struct i2c_device_id *i
 
 	data = iio_priv(indio_dev);
 	data->client = client;
-	data->cfg = &ds1803_cfg[id->driver_data];
+	data->cfg = device_get_match_data(dev);
+	if (!data->cfg)
+		data->cfg = &ds1803_cfg[id->driver_data];
 
 	indio_dev->info = &ds1803_info;
 	indio_dev->channels = data->cfg->channels;
-- 
2.17.1

