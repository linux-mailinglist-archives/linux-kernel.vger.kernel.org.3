Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59FB4F694F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 20:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbiDFSUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 14:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240802AbiDFSRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 14:17:49 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47059DB2EA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 09:55:30 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w4so4102479wrg.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 09:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fLTxnGR7/KTIrTDEayIFV/BI/DbPoVL88+VO1j10fPI=;
        b=Z7MBoyVQaoQbXieqx9qBI5GYO+2AdCuq0p9KpnbZlQWWbCS3qGiJEeFFp6bn3jER+O
         YTJeKhwvNRVcLyLmeZMe9urVW7uBNJOsZFDJfCGFgVxT9Z9Ost0Y5KjMQQNrZhXhnfGd
         oRjc8lGI+owp5FFB94h1Xk7sU1irJSkS8H5ALS+OTZQHkukOyrDfFfqYuHu/cweS74N2
         K428wdkELHXOqp9RXLZfqkgTG9WCFHyX56vWH8/H1DzcQgsfRWyvcs4HsoCliB+i/csb
         w1W3uApqQie6RrwI9JmzF1xjBETby2HrhbzroNgT0D0mliRVu38z5WQQamuCweMOTGEF
         Vgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fLTxnGR7/KTIrTDEayIFV/BI/DbPoVL88+VO1j10fPI=;
        b=oeSuYUw+s8kxqKCySXL0SEAdedzt/Yo27p6e6T4yQSXIY737bzR60gfXNlmcTs/nxt
         kC0gy9W+ara6v4o5x+X6ZznjgbaJvyoHpwLznAUdYj6gY3AnuWj7oWPpLi5v7vrDxPcT
         hu5GizY2aj3+yAUFtb8Yqfz5Eqj5XQbSoa8twkhwAuWml+S2gcMM3fM5kOh7looxxrU/
         pYeeGkVvncPPGJv4wzE9Kghi1gqEcvaSm9oBfUvYeKHJUy/PSiUlWlt9VN5901ky5yqh
         WXpCaAXxfqnnRncE1VedI5lDiJ6Hx4OxNd2/RRRZ1EFIZiuRsOu2Qo5Uvqp0xKNrnYWi
         nCRQ==
X-Gm-Message-State: AOAM533d0WNjKpEdTUAZiZ0hmveVaP0jp6nO+u59U76JzUw+0DWy+2rE
        MVHZWJeRGlmOokJwUp8rjF6ugweZA8u+bg==
X-Google-Smtp-Source: ABdhPJwkIAuexl3wfrlFeKQ3C80Sb6JkJaovTFTC+6nDT5lFOmwSus6YA2zf1UDBLUBgluO0yExeDA==
X-Received: by 2002:adf:e5c2:0:b0:206:116a:432a with SMTP id a2-20020adfe5c2000000b00206116a432amr7358435wrn.223.1649264128743;
        Wed, 06 Apr 2022 09:55:28 -0700 (PDT)
Received: from localhost.localdomain ([217.113.241.148])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0038c9249ffdesm5694484wmq.9.2022.04.06.09.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 09:55:28 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     emma@anholt.net
Cc:     mripard@kernel.org, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, daniel@ffwll.ch, p.zabel@pengutronix.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 0/1] drm/vc4: hdmi: Replace drm_detect_hdmi_monitor() with drm_display_info.is_hdmi
Date:   Wed,  6 Apr 2022 18:55:13 +0200
Message-Id: <20220406165514.6106-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hello everyone,

This patch replaces the calls to drm_detect_hdmi_monitor() with the more
efficient drm_display_info.is_hdmi in the VC4 driver.

After applying it, vc4_encoder->hdmi_monitor could be removed in a
follow up patch. However, since it is used by some code not present in
the mainline kernel but present in the Raspberry Pi tree [1] I decided
to send only this first patch and see if the maintainers also want to
remove vc4_encoder->hdmi_monitor.

Best wishes,
José Expósito

[1] https://github.com/raspberrypi/linux/blob/rpi-5.15.y/drivers/gpu/drm/vc4/vc4_firmware_kms.c#L1410

José Expósito (1):
  drm/vc4: hdmi: Replace drm_detect_hdmi_monitor() with is_hdmi

 drivers/gpu/drm/vc4/vc4_hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.1

