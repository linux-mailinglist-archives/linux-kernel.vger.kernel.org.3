Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0BA55A8F2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 12:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbiFYKhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 06:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbiFYKha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 06:37:30 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8302A266;
        Sat, 25 Jun 2022 03:37:29 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id by38so5483173ljb.10;
        Sat, 25 Jun 2022 03:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o7jSMSvtnflA0oSrQ3YALnecp8wzRM0jcii6vCYQa94=;
        b=iCrGLxIK0aGalTYNVdNbi4eUvF+oR9pDW1Tj8AdKwlmnj4mEdKz1BiG1unGRh0K9cy
         wkfrDJt2tTd883OT5fFoTWomrZJmQaewjO39heqLdfMtgK9pe9L/EN/+vOwoA8I+ICYh
         wfJu0ze9rp99IuG1e1ekxeplN3KLNjHMBTsP4lgPGit3iw+Wop1uh2KdkNUk0gSY/Pca
         BTjytWRyD70oKrx/Pm8oxsp6gIE4T4KO4OJ0n9+n6JgOMg8AuKAiS/dx5+m/bq2d9vDJ
         POWPp8PwAoYANuNZsD7pp9O9ZTIo0uvqNkmF+5UrbI6ZvXQJJyRBSDAL+9BroriRqFjq
         niSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o7jSMSvtnflA0oSrQ3YALnecp8wzRM0jcii6vCYQa94=;
        b=UtgmGIUXZK4GL5eqsDkX7qZvNOkZNpJ+NCgtY8jEdJaesVjZWDKEt5pLFM2x+LLKz2
         MzfrXz4mUX7wAi9yYHJt0bqVwm+UDxX/WqIy7mCDQbXxBjcbjHa/UcGitQFkPQgCGkEI
         qaPSYDnJ/8TBgv6pQ8jOB+VE7UekfY8rORifsiEpyl0FWLEcCLyz2+h0oskw3k+u1JPj
         RFOIgZD8Susk2ZmAsxUxGZ40UvuhXaAh4ZpyU5iQG14DtLiVkcCixSk5lMYF0tWh2FGi
         htwcI/7k4uJZyJDQIerdWkHe4zQhTZtqx8mtTCM+Hz8g42fzr4PBTe5xrO67EU01Msez
         cxoQ==
X-Gm-Message-State: AJIora9IcxU2PeLich2x0H/+CVg0hly/M7IAAKEbjifuMvhdkqI1cLAD
        vGpyel7pi1VZsfXLKW2vNzQ=
X-Google-Smtp-Source: AGRyM1vhPlo9ZjFu9GQ28dm1ziLUX20dHpsyXGo6Ay2u5xNx9fWZOan+y0vHUlDoIkOuL1f2QTFIEg==
X-Received: by 2002:a2e:880b:0:b0:25b:8aaf:d873 with SMTP id x11-20020a2e880b000000b0025b8aafd873mr1712154ljh.332.1656153447681;
        Sat, 25 Jun 2022 03:37:27 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id z8-20020ac25de8000000b0047ac01fc644sm809115lfq.44.2022.06.25.03.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 03:37:27 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/10] iio: adc: mcp3911: add support for phase
Date:   Sat, 25 Jun 2022 12:38:51 +0200
Message-Id: <20220625103853.2470346-8-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220625103853.2470346-1-marcus.folkesson@gmail.com>
References: <20220625103853.2470346-1-marcus.folkesson@gmail.com>
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

The MCP3911 incorporates a phase delay generator,
which ensures that the two ADCs are converting the
inputs with a fixed delay between them.
Expose it to userspace.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v2:
        - Fix formatting (Andy Schevchenko)

 drivers/iio/adc/mcp3911.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index ede1ad97ed4d..a0609d7663e1 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -155,6 +155,17 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 
 		ret = IIO_VAL_INT;
 		break;
+
+	case IIO_CHAN_INFO_PHASE:
+		ret = mcp3911_read(adc,
+				   MCP3911_REG_PHASE, val, 2);
+		if (ret)
+			goto out;
+
+		*val = sign_extend32(*val, 12);
+		ret = IIO_VAL_INT;
+		break;
+
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		ret = mcp3911_read(adc,
 				MCP3911_REG_CONFIG, val, 2);
@@ -225,6 +236,15 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 				MCP3911_STATUSCOM_EN_OFFCAL, 2);
 		break;
 
+	case IIO_CHAN_INFO_PHASE:
+		if (val2 != 0 || val > 0xfff) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		/* Write phase */
+		ret = mcp3911_write(adc, MCP3911_REG_PHASE, val, 2);
+		break;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		for (int i = 0; i < sizeof(mcp3911_osr_table); i++) {
 			if (val == mcp3911_osr_table[i]) {
@@ -248,7 +268,9 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 		.channel = idx,					\
 		.scan_index = idx,				\
 		.scan_index = idx,				\
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+		.info_mask_shared_by_type =			\
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO)|	\
+			BIT(IIO_CHAN_INFO_PHASE),		\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
 			BIT(IIO_CHAN_INFO_OFFSET) |		\
 			BIT(IIO_CHAN_INFO_SCALE),		\
-- 
2.36.1

