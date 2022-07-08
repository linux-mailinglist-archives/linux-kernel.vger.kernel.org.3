Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3037956BE08
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238058AbiGHQCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238961AbiGHQCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:02:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B28C74DC8;
        Fri,  8 Jul 2022 09:02:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o4so31155290wrh.3;
        Fri, 08 Jul 2022 09:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X+3sBXRp/zeIpi+smlmCJit5ubHlk/qV0SMuYjGyKHw=;
        b=XKU1NRB3a0LaCzrPjePainKaedFiQqRolh+uGgZgbfV+W/87GfwTTFKw9slVJwb6qe
         f2FIy6e+GCTKj3ckoRu9bFugR1cC/J7XenV2JzQgfX2x4wkLsd3F5C1u6LPKOpActlAX
         xu9eFgNa5nYZd9RIOMqUoV4LH2LKD9CTIYgq/Um2o1ToVCTTrEpWWKLJJx9Ut+TT/bbO
         1ioUj8IY0KOQt5zPvNOiktONrmaMJwzyckhSV1bkFdemoI9aZHgglyXuhlCLGtegAwKZ
         nK0zvp4oQzNNDvy4Avm1c7eCncZq112FonbJCAWK2R2+lHpv9K8rfGa0eyNvBM5M6xTF
         mhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X+3sBXRp/zeIpi+smlmCJit5ubHlk/qV0SMuYjGyKHw=;
        b=2bFMJiNFOiZFOxQX1ihC8kvNYqlQTowNlLygyPOT0qbAmr8sOKksja5zNJNEJDyUUb
         Bxr6Z10h4OZ6RQD8UmnHtCdm8dXCu1vKL35oOx1FtIbMXTfyagXJC5oSA189d+mg58Io
         lv56dxfcBjsOVwdhcBxzNjr0wOhnfcQEIq4gqWnBFHmZSruww380LkG2Cw0aZwsHRMH3
         zax0LkyhLjwUpAOi62NeYTG3pu4lo06J6vhJ+VvTD/EVa/aB4g/spwaIBF4wSwbLZsiM
         UdVT7uVmvYEIWWhaYJNYOkMiUSU+82PucvrOVsZUgNxHD76we1TV0JwfqGOWcmxF0TcY
         mRlQ==
X-Gm-Message-State: AJIora8I4ccur3064KzlcYVR8xdDzz8yEpOPMA3HhaTxxkJNMkHhU1dK
        6LpJgRLR/OADECvyBLOTrtGgH02+bpk=
X-Google-Smtp-Source: AGRyM1uAbe3JEknDQ+quc/MmYhHL3bxnlIbNXaROFVRb2ZclK3fmAO4vCIa2G/zxkkF+3OwBlQlJ+w==
X-Received: by 2002:a5d:4346:0:b0:21d:5dfe:b29b with SMTP id u6-20020a5d4346000000b0021d5dfeb29bmr4057696wrr.672.1657296128931;
        Fri, 08 Jul 2022 09:02:08 -0700 (PDT)
Received: from localhost (92.40.203.144.threembb.co.uk. [92.40.203.144])
        by smtp.gmail.com with ESMTPSA id l3-20020a1c7903000000b003a04962ad3esm2593863wme.31.2022.07.08.09.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:02:08 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/11] ASoC: jz4740-i2s: Remove unused 'mem' resource
Date:   Fri,  8 Jul 2022 17:02:35 +0100
Message-Id: <20220708160244.21933-3-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
References: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
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

This isn't used and doesn't need to be in the private data struct.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 576f31f9d734..adf896333584 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -98,7 +98,6 @@ struct i2s_soc_info {
 };
 
 struct jz4740_i2s {
-	struct resource *mem;
 	void __iomem *base;
 
 	struct clk *clk_aic;
-- 
2.35.1

