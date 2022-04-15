Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA16502A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 15:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344908AbiDONDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 09:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347265AbiDONC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:02:56 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD83366B4;
        Fri, 15 Apr 2022 06:00:27 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g20so9838141edw.6;
        Fri, 15 Apr 2022 06:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Xvx5sPX8B110OzO80GAdzNt8JGNouTiqBus5fdMrDM=;
        b=biDGPgDRmjRvL5P6qB2bXUbIMT0usHPwP7HfMBwb+CB18nb24+9XaYg6fBCCYoXSr9
         B5Jh/ZY6DH/VZZk0G/bileKb/aMOn4aOFvk99V2aImxBmpUK1YKViYd+k6G6evAmbLij
         BeFlPMGpPGF3PWFKpKHrGh4I0DIApyVckDgMryKEp+P8aBIjdIJCTzvV9xaE32CVmOvF
         yWrPyC1QE7q5jWiYv+QmW09zpOouekJBJOLArWFjI0Ss2LLGb2ttRU8SYrwYUJkE/KiN
         P1xBu0OmnGWAscnKHbuopxYxM0IwqOnk+KaN7h3KRPOwa9dDFp5oiMGiz8ZRIhFAQq8h
         l1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Xvx5sPX8B110OzO80GAdzNt8JGNouTiqBus5fdMrDM=;
        b=gtG8jYYxnE9//GMU2yQW8QtVZGY94s4VCsCjIMUgFS6Wxm2zlHzxAw53UR6XulXwVi
         8fWzuw6aHPw2GP+uql88Fu/AxExg8za9VzPxMTzLr0SX+mCzYBQuntZ/zIMejOPhKzlR
         p4SuKSKAbXAl1zGBG3w4YK+PJtI3KVr23xWStkbSkCoM0mnq+F90nztUxrObFJ3aFdQn
         eNcz/26Aw+JhISLUxlaQQ25r2YAxeoApxBIE89C48t5vXxKxyEqVB+PBf4QuVlnRtmPO
         6Rqh2q5gwbcwNV0r0GfpLJXvPXVRHYG9sqkqj9W8peNrdUOKLVjy4IKqbMi9JZwnp4hL
         iqgQ==
X-Gm-Message-State: AOAM530MrrpFwMwZv1l16k6WUsT13vrJxTtmpNXW/JJ1B067pmN7QZRD
        WhkmMcctM8p8tNGUZkz/LhHoIS8yOjOstg==
X-Google-Smtp-Source: ABdhPJx2W+uu499IRxWM7GnjnqZ72yWwN2nbCK0M2o5Uy8DhvLlnaQJGhjkVeeu2vg3ntEYap9V6xg==
X-Received: by 2002:a50:c00a:0:b0:418:f10f:b27c with SMTP id r10-20020a50c00a000000b00418f10fb27cmr8005693edb.204.1650027626362;
        Fri, 15 Apr 2022 06:00:26 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id i26-20020a50d75a000000b0041e84bb406fsm2704715edj.0.2022.04.15.06.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 06:00:26 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: [v4 03/14] iio: event_monitor: add linear acceleration modifiers
Date:   Fri, 15 Apr 2022 14:59:54 +0200
Message-Id: <20220415130005.85879-4-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415130005.85879-1-andrea.merello@gmail.com>
References: <20220415130005.85879-1-andrea.merello@gmail.com>
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

From: Andrea Merello <andrea.merello@iit.it>

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 tools/iio/iio_event_monitor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 2f4581658859..1fee44abb836 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -122,6 +122,9 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_PM4] = "pm4",
 	[IIO_MOD_PM10] = "pm10",
 	[IIO_MOD_O2] = "o2",
+	[IIO_MOD_LINEAR_X] = "linear_x",
+	[IIO_MOD_LINEAR_Y] = "linear_y",
+	[IIO_MOD_LINEAR_Z] = "linear_z",
 };
 
 static bool event_is_known(struct iio_event_data *event)
-- 
2.17.1

