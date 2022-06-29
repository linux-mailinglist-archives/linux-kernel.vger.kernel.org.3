Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66549560B1E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 22:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiF2UgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 16:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiF2UgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 16:36:14 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD153AA5D;
        Wed, 29 Jun 2022 13:36:13 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a4so16514595lfm.0;
        Wed, 29 Jun 2022 13:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xOtwBScj9Lxmzdkw+q81TMARjc3Om5pZRv/Q5oezcJk=;
        b=PrK7OSbLhzbEOj5opdJalC7xz9Z7GhnXe1B85uPO9Tfsw296JI/g71giUeUMS8+W06
         vumB7TGERr8Z1twdatqCW5lvQjWzGBpoNhPVOnj4Cpg+d8ewfNOz1q52K2kUzF1BDDW5
         xrzkvTdmlqeHrTmUE+/VZUnOoIpxq83kVSYAY3gE6LGX8l4IoRo3NjA8aI1z/qbbbFVa
         CKv30VRmCDeQoIeMPYeRBLofHXoBySuNiOGNuOLKKoohNDGjcYTfoIAZSPYq2OdV84SL
         UzU46TX3QwnOlHT7xuOK/Y1Z4x37hYGkcqdWJQoBRKKqID/m42HKVQqzlN7ldBDWzdI7
         DEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xOtwBScj9Lxmzdkw+q81TMARjc3Om5pZRv/Q5oezcJk=;
        b=bEinarkCtJEjS9BbRcx7/nRo7X+gpAB+4SEBjSXmm62MGbONW0xaFm/1fIeMOqwDoi
         QU43K1DP7JEtNx+wOWmOAYuFTmtIFhowYv3Ig/rYsUrc2hKYGqMeuUwrcK4H+iSzzw7z
         +c4LzasgAUzF3+ZL/WBbicR/pEdLUDDNN9sfl8PqFvpnv2fucuKT88qY6LOjDj9eVxDm
         OQbEUrn/6ezvEgk3hkjolQM+LsJFpkPlqVPOU9B846yWtvNLvenbM8/MxoE6Gqio0l6f
         Dd0NoiBdEkkB5RCW0dpRknVXsxhH+3WKULmDIVvBskyBbCZx79evGC/n/uUYzHGVQYVT
         dcfg==
X-Gm-Message-State: AJIora/Ro8/tftykQoRvVTiv4l+7ehxwxjNRi5e8LYZdGDIpTS5NlGJ6
        P2ZTujGvkk0kjyz/tJsjMxw=
X-Google-Smtp-Source: AGRyM1urUqs2TBrnpB63fvGorkxp8dib227iuNWf7jQNCY+HVUZ6GMesFtIl9lBjE0Jlz93a6Xib4g==
X-Received: by 2002:ac2:4a70:0:b0:47f:a18e:ae6c with SMTP id q16-20020ac24a70000000b0047fa18eae6cmr3213431lfp.344.1656534972011;
        Wed, 29 Jun 2022 13:36:12 -0700 (PDT)
Received: from localhost.localdomain (c-2ec2f5c4-74736162.cust.telenor.se. [46.194.245.196])
        by smtp.gmail.com with ESMTPSA id v17-20020a056512049100b00478feae4f24sm2727794lfq.268.2022.06.29.13.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 13:36:11 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Oleksij Rempel <linux@rempel-privat.de>, kernel@pengutronix.de,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] iio: adc: ti-tsc2046: do not explicity set INDIO_BUFFER_TRIGGERED mode
Date:   Wed, 29 Jun 2022 22:39:10 +0200
Message-Id: <20220629203910.4836-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
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

The core sets INDIO_BUFFER_TRIGGERED as part of
devm_iio_triggered_buffer_setup().

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/adc/ti-tsc2046.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index 55b35570ad8b..0d9436a69cbf 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -776,7 +776,7 @@ static int tsc2046_adc_probe(struct spi_device *spi)
 	priv->spi = spi;
 
 	indio_dev->name = TI_TSC2046_NAME;
-	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = dcfg->channels;
 	indio_dev->num_channels = dcfg->num_channels;
 	indio_dev->info = &tsc2046_adc_info;
-- 
2.36.1

