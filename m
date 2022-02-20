Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD464BCF47
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238794AbiBTPPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:15:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiBTPO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:14:58 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2191934B97
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:14:37 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so591591wmp.5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kEg7796s41BOvVJTI30ouqjHQa66o1APfohzN4o1DME=;
        b=Z8jB1dmvFHH/f36ZFz17cPTwZJs/tNyCJi7akDgv8kA54oXAqO9mqRnkAiH2lFpvsX
         bqdE861AD/jnb5V78SvHX3qtNN0RdHy7RpzOS8a47g87nNkaONh/Ykwd6WFOwEfkWRFZ
         kAFRa9UwetcCMuFPFOVLz7dB42sn/C+8rmCaZkrK8vIny2iHFoEBmY+t9i3FE4f5xT3j
         HVXboKoOfFt3nMopz0Y5aRd7zAcmRbDCTarMIDWJepOxyWiSkuXfaF9ynaNFS35Yv6Qz
         wNfSFJg2wVWnFf6SHKPxg2dyAkHGmnxUr+7IoE5LFN3KmcJYFKZhnQKg071ndT7RmWjo
         REJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kEg7796s41BOvVJTI30ouqjHQa66o1APfohzN4o1DME=;
        b=0Bv+i/PCil7uWabAzalDe0momvLl1SWfq0Vo6+06y7+pi6JIrjNhTNcTU0ODopP5dK
         bv066aD/Dl6pr/xeC6OihS/0YIF7GvqVkbhZEQlUij3fO3R5mlDX2qwYYfBexcCXqrQ2
         baEhLsbKlblFIFmLAyGv1c2y40kXMkGiUn5SFeoEL5aIdKxfQc7JyalY1PMx8obvxfeJ
         zNue9hDm/nnJ/WW+UWGVShZRzisqwwJGMxC4iFdVfNdbbonrTb25Dp54P2fkqZvxFvmU
         3ucYpGYFrL/FAWhR9ULWeAfCIBffTYV5fYTVq97YSLKfDPswd4W0ecrQQJzMORnfg7Oy
         YUZg==
X-Gm-Message-State: AOAM533ZCI+EbXqx0hEottiD+xS2y+kv66eQoNDwV2OePNn1est8IbEe
        eFxtMQwvnPzGoClL51B0FfdO0W2y5KRTKQ==
X-Google-Smtp-Source: ABdhPJwcJU6pC2psWZ0x3ljFbqCdYvJuf2F1Ho4Qja1/3fATEwoJRwQxODu+I5NtMuH9PY+FBmd9Vg==
X-Received: by 2002:a05:600c:3b06:b0:37c:3ce4:9a31 with SMTP id m6-20020a05600c3b0600b0037c3ce49a31mr14707721wms.192.1645370075635;
        Sun, 20 Feb 2022 07:14:35 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id d6sm46703322wrs.85.2022.02.20.07.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 07:14:34 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] nvmem: fixes for 5.17
Date:   Sun, 20 Feb 2022 15:14:30 +0000
Message-Id: <20220220151432.16605-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here is a nvmem fix for write-protection gpio handling conflict between nvmem and mtd core.
This bug went un-noticed when write-protection handling support was added to nvmem core.

If its not too late, can you take them for 5.17.

Many thanks,
Srini


Christophe Kerello (2):
  nvmem: core: Fix a conflict between MTD and NVMEM on wp-gpios property
  mtd: core: Fix a conflict between MTD and NVMEM on wp-gpios property

 drivers/mtd/mtdcore.c          | 2 ++
 drivers/nvmem/core.c           | 2 +-
 include/linux/nvmem-provider.h | 4 +++-
 3 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.21.0

