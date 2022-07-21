Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0667957C8E2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbiGUKZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiGUKY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:24:56 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271B82CCAF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:24:55 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id tk8so2361748ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DDlxv6f17NMMsNj65PpLbDHfFZ9n6R5iig5GSNIQc60=;
        b=BXbAH2QpOuEtDBsyknn63KMdYDqwYJ04QkYENBBBubvPKw5ufJQQ2RYWkh8TUehmAp
         eRg1pqewIA/nWrCKjZm9eUb5/F7/+M3SfQb3fG2M/j37/NW+H4x5xwUZB8pLViC0hPap
         mpJRkHmRolRjatLFK46JVrwFPwWbLIjnK/IPCnz962aIg/Ya09URDokHXSDpIDp++KMU
         IvdBpBpqCcplCkrF6gXYiY5M/0zk2Ofj6aGIuMQ3j/QygHzKx4yIlYJ5mdI9YATue7Lz
         mzIUg11Y/4YGn1/EkK5qinmyWQ1dBof6ytJgv5ZSspVQS1IpsGnFb75wrOwzRzVcwf/U
         M+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DDlxv6f17NMMsNj65PpLbDHfFZ9n6R5iig5GSNIQc60=;
        b=ET6+jQTJ58dGyZ0sdmpHn115+aKN1D4Gtmcd1ce5NX2rBaWQypBiRWUd5bCwvqeIst
         enH36Tc0Y8a9kTfK0Tb8c46mYPBP6uH4Hgtmu2yl/dOpWfyUtDVVBXJf9sdaPbDynVXa
         ysCMHsdzhjcGba37Ty5hljh4EGpPyRipl7GpmwAlAThGHUb8aL8tkUZQ3tzWOCKVRIv0
         f1h/YHVIIYu4M4UyodAJfBkeWcqAjJDFtuZwhKFUNGSE/k46CksOfY9IYJLTAH9fGsbU
         CoEgKkhKRrUFaH9cwlT3Ua1zgpgZHdrv8MMz9OS6Lvis1K2TWkEzJCnMLz8PT3RA5a5D
         DXPQ==
X-Gm-Message-State: AJIora/MWySZgUnCmDvDTtwexDplENFknaOR7V/1eAHzFHfR3DwCnVfq
        BFfBiXaZjLQl7R4GzS+b9Zk=
X-Google-Smtp-Source: AGRyM1uT4hp2Itp4P40blzsKlm6eCx6+8avKdG3J/Wu5vQx5h0kQMV6Q9zWDGrdUxUc9Zz0qPjlN4g==
X-Received: by 2002:a17:906:9c84:b0:6e0:7c75:6f01 with SMTP id fj4-20020a1709069c8400b006e07c756f01mr40510180ejc.103.1658399093753;
        Thu, 21 Jul 2022 03:24:53 -0700 (PDT)
Received: from localhost (92.40.202.7.threembb.co.uk. [92.40.202.7])
        by smtp.gmail.com with ESMTPSA id bv4-20020a170906b1c400b0072f0dbaf2f7sm653335ejb.214.2022.07.21.03.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 03:24:53 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, srinivas.kandagatla@linaro.org,
        bgoswami@quicinc.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next 2/2] sound: soc: codecs: wcd938x: Remove spurious type_base from irq chip
Date:   Thu, 21 Jul 2022 11:25:58 +0100
Message-Id: <20220721102558.25457-3-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220721102558.25457-1-aidanmacdonald.0x0@gmail.com>
References: <20220721102558.25457-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to set type_base here: the chip doesn't set
num_type_regs and none of the IRQs have type information so it's
not possible for regmap-irq to configure IRQ types.

Type registers are also deprecated in regmap-irq, so any IRQ type
support in the future should be implemented using config registers
instead.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/codecs/wcd938x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 781ae569be29..aca06a4026f3 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -1298,7 +1298,6 @@ static struct regmap_irq_chip wcd938x_regmap_irq_chip = {
 	.num_regs = 3,
 	.status_base = WCD938X_DIGITAL_INTR_STATUS_0,
 	.mask_base = WCD938X_DIGITAL_INTR_MASK_0,
-	.type_base = WCD938X_DIGITAL_INTR_LEVEL_0,
 	.ack_base = WCD938X_DIGITAL_INTR_CLEAR_0,
 	.use_ack = 1,
 	.runtime_pm = true,
-- 
2.35.1

