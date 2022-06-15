Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A519154D488
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348103AbiFOWZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347056AbiFOWZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:25:12 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305AD313A1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:25:11 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y19so25908254ejq.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OPpdUjGRZZkJcBOgKvfJS/uuetRCNbFJlRDAPw4R+Yk=;
        b=kSsI9SMqHAQ1CDKJbcb3BpS5M8YGxijeJP/J5mMfyxoebkxevCW5/dqT+Vbq7+QhSC
         Ts2SFYywtP0SqCV4d12ODyi44me1JaplsF/6eTMNzuJ1jasothkrun2lnpxYkARUf35w
         YiP9vxT2AObIEM5y7KD12/+ef+ROn+gapoS21WqKTPEExvUKtCklqNu8dpHX8ONTdnum
         sMzzjgEvrXOOR/CsqfgnQ6wgBjiOHHFlZywo0Rlk/0iWhwmMzrLKelefffBEmnA+IXoA
         kqYODG0IcP9tFxeEFXf3BAOFuoaB96wax/oMv58PvVdn1AxDIEPKB4AyH8wnEDPZszTu
         HZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OPpdUjGRZZkJcBOgKvfJS/uuetRCNbFJlRDAPw4R+Yk=;
        b=uvbL+KnoH9PEkDsNCN5FQ4pqPPe2wuDNSdj+SX+CdW5nRtEV548zjnMPuKJnrVp6Dv
         t1vGRfD6HFllMBq63IcN1utDpVuJJZP86jKbccUR8H+MVPQjMiPYP5M9J0dTmI+QPa6X
         pvEPj7ghmkvXDkgZygeyEfhHrGGq8a1Ad7Op7/7t0sHaUUKYWL59VDk/In9Jt1yRGTqH
         QadgBe9W0dsS8k1wDqpCdgOFnH6gbjwIzOhDSG4pdSKYnJ5YijLkug3Za2rd938kkVl3
         et2PUDyJYGEeVcm3pBWh57su7PbyvbP13nqDJbiapxd9QT3x0r23sEFc+CoryxSX59Ra
         HN2A==
X-Gm-Message-State: AJIora+AKLsiFuCjIU9tCRox2A4YeeqZBX+YXQwE/w3yWfgta+VQZHSm
        DAcXy/6qbUN0dF334nRbVz8=
X-Google-Smtp-Source: AGRyM1vI/D+O4LZ4ySsC2+t6KUGm2z97f1pkIxRNL4gT7CNUTTTXahnM/pWVAC43Oc7OnBhS3MbFNA==
X-Received: by 2002:a17:906:73d4:b0:715:701c:ae96 with SMTP id n20-20020a17090673d400b00715701cae96mr1829346ejl.50.1655331909687;
        Wed, 15 Jun 2022 15:25:09 -0700 (PDT)
Received: from debian.home (90-180-208-18.rcn.o2.cz. [90.180.208.18])
        by smtp.gmail.com with ESMTPSA id y3-20020a056402358300b0042dc25fdf5bsm350427edc.29.2022.06.15.15.25.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jun 2022 15:25:09 -0700 (PDT)
From:   Jiri Vanek <jirivanek1@gmail.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>
Cc:     Vinay Simha B N <simhavcs@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiri Vanek <jirivanek1@gmail.com>
Subject: [PATCH 1/2] drm/bridge/tc358775: Return before displaying inappropriate error message
Date:   Thu, 16 Jun 2022 00:22:20 +0200
Message-Id: <20220615222221.1501-2-jirivanek1@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220615222221.1501-1-jirivanek1@gmail.com>
References: <20220615222221.1501-1-jirivanek1@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function for reading from i2c device register displays error message even
if reading ends correctly. Add return to avoid falling through into
the fail label.

Signed-off-by: Jiri Vanek <jirivanek1@gmail.com>
---
 drivers/gpu/drm/bridge/tc358775.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 62a7ef352daa..cd2721ab02a9 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -339,6 +339,7 @@ static void d2l_read(struct i2c_client *i2c, u16 addr, u32 *val)
 		goto fail;
 
 	pr_debug("d2l: I2C : addr:%04x value:%08x\n", addr, *val);
+	return;
 
 fail:
 	dev_err(&i2c->dev, "Error %d reading from subaddress 0x%x\n",
-- 
2.30.2

