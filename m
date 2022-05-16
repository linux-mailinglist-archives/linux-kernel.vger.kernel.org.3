Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7579527EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241309AbiEPHwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241258AbiEPHwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:52:16 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F7F27151;
        Mon, 16 May 2022 00:52:16 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id q4so13665530plr.11;
        Mon, 16 May 2022 00:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VHwMpClyQynjA2cM8OcoohBNhLjDi14SgAXOvOdZEbo=;
        b=nGIjLzNobp+vqVe56g2rvlpS7/7o46TAxZoO0J80VdDyZ0eI8m534CnQp0WOqzc4yl
         141mrcvH/BsjZoB0P0n5vSQU9+C7ZxD3kOZlObtSFqfXAd7HcXMioy/WoVP2eQIwTOuE
         X2N5wDDCqpQJWnKOCB40o88MBMmnshdzaX4dhV8DD22pj7Dx4ToH2q8ARFG2kHlif4/U
         0H2/mE+n5ncdNPXE4y1+c8N2NnrFZgrM7zEUP+hJ//vB3wl5eniAmItPwmwYwFOwdX3r
         wlfrqHSNk0/J/m3CIoH9R+GdS82N2ELf7Zg0NEEwKEK2zHj2ZW1N/Xuoa+2G+MQD+B0t
         iXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VHwMpClyQynjA2cM8OcoohBNhLjDi14SgAXOvOdZEbo=;
        b=ni1gb6a/IWZojlAdX6TzDyUqmASOyoPmIcR0fQPbAV57AX4091xSJ+zhoBq6CPJqna
         7B8NfH1aB9L7HgD4Y4MZ4sATEz09oStM2Pne9EQ7X0QX1i1gtlsv8oaDxiKFkL6LIn3Y
         uXue7pUCHgU/5fTC2C8WYpKrkjyKNk0jvE1Tw137mMEEvHY1ctNNOd5ZwHaWPPQfJg0v
         TWWq1wcy5P58orhIm7oEHkYmgprGGuOcy1EV/p8hjmCB/Y67YrdUdhaRmgKxu0DxF11G
         Cd5VDxU4ndr2Z9EjCbTX+vIPrWXxAh/FdP7oknbQRSM1gQnogh8IS3t/d+LUcYmTEFQg
         EEsA==
X-Gm-Message-State: AOAM53298SQBNz9LDdQnD/IOfVpPBw4tZuFSwTTzQXaxLGQHp6frxkfK
        ljkR5YKoBccTTKbeBg+r9So=
X-Google-Smtp-Source: ABdhPJz276ABAIAuW896KA5vz0XXu814EgBO3IQUcxDqw00HuNKFl6XPbstTD15t/E9qCoX4qIZKFw==
X-Received: by 2002:a17:90b:1e03:b0:1dc:5a7d:bba8 with SMTP id pg3-20020a17090b1e0300b001dc5a7dbba8mr17849338pjb.156.1652687535848;
        Mon, 16 May 2022 00:52:15 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id hv19-20020a17090ae41300b001cd630f301fsm7809297pjb.36.2022.05.16.00.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 00:52:15 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: aspeed: Fix refcount leak in aspeed_adc_set_trim_data
Date:   Mon, 16 May 2022 11:52:02 +0400
Message-Id: <20220516075206.34580-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_name() returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: d0a4c17b4073 ("iio: adc: aspeed: Get and set trimming data.")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/iio/adc/aspeed_adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 0793d2474cdc..9341e0e0eb55 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -186,6 +186,7 @@ static int aspeed_adc_set_trim_data(struct iio_dev *indio_dev)
 		return -EOPNOTSUPP;
 	}
 	scu = syscon_node_to_regmap(syscon);
+	of_node_put(syscon);
 	if (IS_ERR(scu)) {
 		dev_warn(data->dev, "Failed to get syscon regmap\n");
 		return -EOPNOTSUPP;
-- 
2.25.1

