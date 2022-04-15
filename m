Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6C1502D52
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355624AbiDOPuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbiDOPuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:50:22 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4571986F1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:47:53 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q3so10450027wrj.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yLsy6Cg4nTGsce8DJN5bhB9sYWSZN/u1ooAdq1shsLk=;
        b=WofpZkYJduA5PuvzLuKjMGm5LfRHMtkKXOmASzQFM1iFhfMnjmM64iV5kvhVP2v0p2
         EuFG3koJz7aQauCoXnUnU1KSpMWBWKxBuQ9swkkmfo5JQzGjIHnKepNFrnpy5iNkruDA
         yHwMexMsrq5EviVYM7ETRB4tMEtOFZYaYLw6/V4xFI8oiNEwvdobkFDc9SqdYTgWQ8nC
         g9DDbWrR00qjcSOkmDo8H6PPpwQSc/6wmZ5gVhjZ0cgs48j+UnJ7rEgMX73Rxf/cIGjS
         X7xAfhrNezhpGwjKKQz1xGOyWAWdYNIPp+YCWKpOoJWbKCP4leN1v/cnofnhYIQrz5X6
         B18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yLsy6Cg4nTGsce8DJN5bhB9sYWSZN/u1ooAdq1shsLk=;
        b=qpKExsnpyrDjou1h4rH3CF0H0ZPFBPiAj4puRT+0kPvJ8GjTM3UFC2c/4xE4xhMQTc
         RX6M4LCP5as+jgiG7IWbKm5ZKSSAfqSqtl8Rt/NnBN2Z4k3Z4h+5aGIrJZTNCx/8ePMp
         Wn3SutnXXtUFTsYLxmlhGshhDdD+WwDvGU45sn5YfImOnI+Hzjulyj65SeglfRXS1kCD
         2MyrrECEfmFtxK87xHGuKZxuDtiA+FHZFfgmr0057PxFlZ0PCcK5IK1l5ohFzsD3y2vK
         0RW9kV8NEXLvTSYhK9Kw/F461we5xnzpwsrsWwRBxrina7twan4Hplx7jYTvs6RrelK4
         Le+Q==
X-Gm-Message-State: AOAM531BGUlN50RX7wv0hh5PLFHX6q7JqZi7n/OUqDycoqvMOEFiAuK8
        ETWJn85g1kFEaf9IEL05peX38xeGeRE=
X-Google-Smtp-Source: ABdhPJwUnErCAHL9a4AcK17pgWqUQWIkLy2B1nkMsshWvrsNjnjDKIXrvUU7UPMMlAAUD1dZdjbHTw==
X-Received: by 2002:a5d:64aa:0:b0:20a:7f8a:ec97 with SMTP id m10-20020a5d64aa000000b0020a7f8aec97mr2082595wrp.450.1650037672319;
        Fri, 15 Apr 2022 08:47:52 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id a7-20020adffb87000000b00207982c7f4dsm4349655wrr.67.2022.04.15.08.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 08:47:51 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     emma@anholt.net
Cc:     mripard@kernel.org, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, daniel@ffwll.ch, p.zabel@pengutronix.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 0/2] drm/vc4: hdmi: Replace drm_detect_hdmi_monitor() with drm_display_info.is_hdmi
Date:   Fri, 15 Apr 2022 17:47:43 +0200
Message-Id: <20220415154745.170597-1-jose.exposito89@gmail.com>
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

Hi everyone,

These patches replace the calls to drm_detect_hdmi_monitor() with the
more efficient drm_display_info.is_hdmi in the VC4 driver.

As I mentioned in v1, vc4_hdmi_encoder.hdmi_monitor (removed by this
series) is used by some code not present in the mainline kernel but
present in the Raspberry Pi tree [1].
Let me know if you want me to open a PR in the Raspberry Pi kernel
project applying this series and fixing this issue.

Thanks,
José Expósito

[1] https://github.com/raspberrypi/linux/blob/rpi-5.15.y/drivers/gpu/drm/vc4/vc4_firmware_kms.c#L1410

v1: https://lore.kernel.org/dri-devel/20220406165514.6106-1-jose.exposito89@gmail.com/

v2: Add the ftrace command used in the first patch
    Remove vc4_hdmi_encoder.hdmi_monitor
    (Thanks to Maxime for suggesting these changes)

José Expósito (2):
  drm/vc4: hdmi: Replace drm_detect_hdmi_monitor() with is_hdmi
  drm/vc4: hdmi: Remove vc4_hdmi_encoder.hdmi_monitor

 drivers/gpu/drm/vc4/vc4_hdmi.c | 17 ++++++-----------
 drivers/gpu/drm/vc4/vc4_hdmi.h |  1 -
 2 files changed, 6 insertions(+), 12 deletions(-)

-- 
2.25.1

