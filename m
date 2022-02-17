Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F514BA5C4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243203AbiBQQ16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:27:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243135AbiBQQ1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:27:45 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A969D4FD;
        Thu, 17 Feb 2022 08:27:30 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x5so10580035edd.11;
        Thu, 17 Feb 2022 08:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fyI2iByz/xYB8pZuuXPhbshZsKIQbcfM5MPfG9RLCsY=;
        b=nBs7uAcscx9WfUNJY3gcaoQY74z4LftQQuRgfAM8WoeXda5KHoWRwpyj9uvfpdhpYu
         vqQKGu3W67QhqnxQe/qthsJ5M3vO3kUiXdV69MaANkfZxLuQfqrylYxAACZZ3TLTGube
         AoNIol/LwnCNCuoPA9Vmpz07hsGheIE6HdWThoiSTzOT8PN0F4BkIaOaA2TKasmDwMZS
         ma2r+MJKiHyarg/iFhiccHBmTiWYX2aUShrYna0qSeeNV8uYp3D8cYUZueGPaXVK5VHD
         LEwyTzogmyaQxhVAUIi0CKuV5bbxaeYcdNrlSNDfGuh74hbuvNuwXgBWX7UZNMaMBs6+
         tlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fyI2iByz/xYB8pZuuXPhbshZsKIQbcfM5MPfG9RLCsY=;
        b=eJxnkxtp261jrXDwSrfIcIblp5l54K0Tn0gcwVQ8bBTq684Z5yAmqBISwhjPJhADNE
         N4pmrcTQrx0VPZbQq75dzPo4pwyGQRGuWgz0taGMUeDxCTnOdg6mXzYeiUXjSKChDYKR
         3nv+Xn1fk+lAxqizTi2gNUr47hkkVQ0vRqwusC2rqMC/Fx/5UvRXuBy4kldy5PYgXbGc
         dUfIV9kenO+MYwDFhMNXmol1Oob1xWrxWAyqxSVD+Y5EfDQZRyyKhNKgCaN5XsTr3gHg
         1GsY9bh529dwrSowRYNh4sJJYItyZJBszxyEELKhOGwYIbvMRxpbLIumxRdZsDKh/O24
         lLRw==
X-Gm-Message-State: AOAM532uN08CpIx/PBA2Wlc+XL+WVv+OI5ZktJSLcmz9D1nqS8xpyBre
        Xg4uGUgGXp+lfmcnyUYkbzM=
X-Google-Smtp-Source: ABdhPJxSS5KNdV320jE2881gKcYrlsut0U5dhkFGzCu0fABv3gSNNHc+Dso7Q914nGnLlUPwIvWn7Q==
X-Received: by 2002:aa7:c98a:0:b0:410:b8fa:6faa with SMTP id c10-20020aa7c98a000000b00410b8fa6faamr3508169edt.117.1645115248595;
        Thu, 17 Feb 2022 08:27:28 -0800 (PST)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id j13sm3653742edw.24.2022.02.17.08.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 08:27:28 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v3 06/13] iio: event_monitor: add pitch, yaw and roll modifiers
Date:   Thu, 17 Feb 2022 17:27:03 +0100
Message-Id: <20220217162710.33615-7-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217162710.33615-1-andrea.merello@gmail.com>
References: <20220217162710.33615-1-andrea.merello@gmail.com>
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

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 tools/iio/iio_event_monitor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 84c90b8fdd91..436ac2f6b907 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -124,6 +124,9 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LINEAR_X] = "linear_x",
 	[IIO_MOD_LINEAR_Y] = "linear_y",
 	[IIO_MOD_LINEAR_Z] = "linear_z",
+	[IIO_MOD_PITCH] = "pitch",
+	[IIO_MOD_YAW] = "yaw",
+	[IIO_MOD_ROLL] = "roll",
 };
 
 static bool event_is_known(struct iio_event_data *event)
-- 
2.17.1

