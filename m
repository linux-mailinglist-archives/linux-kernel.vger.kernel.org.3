Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDF7572100
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbiGLQej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiGLQeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:34:07 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E7724F35
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:34:06 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id ay25so5046679wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c6teTydIk4t8Jfe1GVRPgDH0Cnjkz/LFOBPcMOzjX2k=;
        b=hbds50A23XdPZ/MyWEgqMas3xkVJigPUarGAZzquZM+KlNSQ33HCScs6eR7wUTsgHD
         fYFLfQ7Md51SPaLgl8ZlgfwKJtXDS6geGTTU7oJltqPmTreoCtt8W0cKZXAr6oUPx4qH
         mplCIVlA2kTiad+2PpKQCPfgdPV51Ya9LZ6eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c6teTydIk4t8Jfe1GVRPgDH0Cnjkz/LFOBPcMOzjX2k=;
        b=m/nx+CCp5I3uFZ4rSrWvpVi+i3q9ewg/Zaddk6vBzbJu56E7yKxVcM+SIWzPvmD7ng
         BWYnh4BEupnLLazJS8+a1q/4uDkRfz4qEu+EwVtUAmvDxJ9jHM6UArdOhaqeHBdq7+WX
         LgOP2B/xyIfRe3kssKPsEEatIbojOv9IOLztEHB0HoOYKKi3Sl7cdgLb1pyYGNgoXfWp
         t7KOxn7Lkf6tqYCG50ArP7C4bVbd77efdn8UlbJl4kC1U3HjLnU0oWabL2MLbmbI8pFu
         FmMkqPcTBtamg2E0zJpxJhGWjDcgnxPmFwB8a7jp8kGPPnoq3rnxTzsT0ikDS0/4sDp0
         N05g==
X-Gm-Message-State: AJIora95QPX0MURaq7NLWDgLIP9elIVT1NhGiZZOqpDt8i7zJOctRRRD
        qoCOfpEk0nzTSf8K+KBfAncGYg==
X-Google-Smtp-Source: AGRyM1tP4uQpddYbZ4q00ptDRsb/ZshNUi01VxF56FnV1BI4J+d4SLP6x/KGAAn3PqSt902XmWc3JQ==
X-Received: by 2002:a05:600c:190d:b0:3a0:585a:256 with SMTP id j13-20020a05600c190d00b003a0585a0256mr4619381wmq.54.1657643644965;
        Tue, 12 Jul 2022 09:34:04 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-53-214.cust.vodafonedsl.it. [188.217.53.214])
        by smtp.gmail.com with ESMTPSA id j16-20020a5d6050000000b0021db2dcd0aasm2321052wrt.108.2022.07.12.09.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:34:04 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     tommaso.merciai@amarulasolutions.com
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/6] media: ov5693: cleanup code and add dts support
Date:   Tue, 12 Jul 2022 18:33:43 +0200
Message-Id: <20220712163349.1308540-1-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
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

Hi All,
This series cleanup code on ov5693 driver and bring up dts support, also add
documentation for ov5693 camera sensor

Inspired by recently Quentin series:

 - https://patchwork.kernel.org/project/linux-media/list/?series=64807

Tommaso Merciai (6):
  media: ov5693: count num_supplies using array_size
  media: ov5693: add dvdd into ov5693_supply_names array
  media: ov5693: rename clk into xvclk
  media: ov5693: add support for acpi clock-frequency prop
  media: dt-bindings: ov5693: document YAML binding
  media: ov5693: add ov5693_of_match, dts support

 .../bindings/media/i2c/ovti,ov5693.yaml       | 103 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 drivers/media/i2c/ov5693.c                    |  57 ++++++----
 3 files changed, 142 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml

-- 
2.25.1

