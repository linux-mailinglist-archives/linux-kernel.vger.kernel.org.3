Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D85055A8E6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 12:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiFYKhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 06:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiFYKhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 06:37:31 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F152A42A;
        Sat, 25 Jun 2022 03:37:30 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id q9so5517097ljp.4;
        Sat, 25 Jun 2022 03:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EFo8yVv76+QKgYsUZG2r1Y+bUYCEAcBjASCnIiNxJ0k=;
        b=B+TiX6soRjyv8tcAgYV3WYUUA99102wxcm9Ti4aoyD19TXEHjTRB9kD03qx4866ah9
         g6sfU4PuCcVjS/vkC3uzTdKGFXDXBPGszEogcdDw0hs9eHbGa6ZGI/xm4FJ1dMGJ39kG
         X3zrAS3UHQwN+jvGXA4Ub1F7nUnouyDC29HEFpBQujAcAA92l/vYZHGvW1F9tDCXO4t/
         /jkm4al0iq58HhPFmzU2G3LNlzQWdm01bhW516NrhkCpGeBroUz28Fz1reIO2gzhq09z
         BI8R27pzsoX6i1gWiCjaCoq+LEODTvrTPxNoX3uaz1rZSiw4DphXU2a6iP3FgzNWJXMQ
         NZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EFo8yVv76+QKgYsUZG2r1Y+bUYCEAcBjASCnIiNxJ0k=;
        b=O498qiUvpsUta0SkJoG09RoAV7zbgmH7faJfNADREswhtTkpXCrfj9UtFYpOsnA3+W
         l4zZWmxdUbRSeletI047qu/W+Dcl+WU0X9QSkhVWtAy+GifinU6IcMfrZKMhiyLRAcxm
         2id03kDUhmXa90qdhVwdD96o6un5ERfljqM96Lr2Xy/N4RycIbabYfb8Az8akGfp/bxk
         jsFAgwLbFGnzpz8YRvFLsGTUDY4X81TMikQKFZRPo48hCA2k4J0gxPdZFnp9uKWWgDvF
         flwJZteFjEi0hK5PhGMFdzkitOngwWdaKEI9Umv6+XcDkEr0D0eq5QwiYkXnEtixEGez
         FeVQ==
X-Gm-Message-State: AJIora+V1pSVpm3eelEUA3J4gppF3FW1e+o3Gdb8eLsVO/ayIMelmOhV
        dkWpnQ5ib8nkZErzEOOQhlM=
X-Google-Smtp-Source: AGRyM1sfuiPIr4jIryx93VmN+kG+LFlZdA5qReU+zcSg+rqjOlYVYnKTxRyr33pSebfEAFM1Ir/jkw==
X-Received: by 2002:a05:651c:1189:b0:25a:7f29:6015 with SMTP id w9-20020a05651c118900b0025a7f296015mr1666197ljo.179.1656153449130;
        Sat, 25 Jun 2022 03:37:29 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id z8-20020ac25de8000000b0047ac01fc644sm809115lfq.44.2022.06.25.03.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 03:37:28 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/10] iio: adc: mcp3911: make use of the sign bit
Date:   Sat, 25 Jun 2022 12:38:52 +0200
Message-Id: <20220625103853.2470346-9-marcus.folkesson@gmail.com>
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

The device supports negative values as well.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v2:
        - No changes

 drivers/iio/adc/mcp3911.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index a0609d7663e1..a019264e73e3 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -144,6 +144,8 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			goto out;
 
+		*val = sign_extend32(*val, 23);
+
 		ret = IIO_VAL_INT;
 		break;
 
-- 
2.36.1

