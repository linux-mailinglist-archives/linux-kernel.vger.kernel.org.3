Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E21B529E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242388AbiEQJ36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiEQJ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:29:56 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6672B19A;
        Tue, 17 May 2022 02:29:55 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id pq9-20020a17090b3d8900b001df622bf81dso1744638pjb.3;
        Tue, 17 May 2022 02:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=g/E3VZeeSx4dDu8xOt4mwfu7kFDlErlaUWZ6ZYy2iJw=;
        b=UOVO1JuagN5fkOqvm1Vfy3AVFOBCw1JxX6OnVGhCSluKau7tPaGepitnU5YhrG7tJL
         Op3DU7A+Yvb4zB9t2mX1kpJO5JsTWzVQSgaBk14JZj6Dy9Ludaz1/w7ZM+wVc+ywR/xo
         9QEjJ/kXok6b3uVmcIuXT3XNIEjJ19RyjAxfaMKrFCeegNkMmMB2YVRcoGoRTnZgNOvL
         6MoWjdtJOojboVq/zxmxMS7wuVEc7ojQGmJ0WZB/TgCipZXEvRHH0zsIsJq+yRhjK8kD
         YOMOomvkhKLemPFTKf8JSJpWcBSwuMD43/Hqkm6dGyZKYmrDDO3eJ/mQo1qygmoP44dk
         b3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g/E3VZeeSx4dDu8xOt4mwfu7kFDlErlaUWZ6ZYy2iJw=;
        b=IrhGiZtEw8jVwhbBZSru8wumNOpXFj3OENTr9FVD04fUc5f5Q3nCtNkZspx7eYmC6j
         P5im36aFEJFve9DvHDKNQNKh9Nq8n3YdIM3gOwUYg1DJKpFNwgub1X2tt79zUr/gbtN5
         o8gXX3lbqWTWNus0qEZqVykZtj3LhBHCrWO9KHkwzxFcX2O2HHjiuNpyGGwFnVVvg+nF
         YxreG9lISwvKLb4DIuOqDX7qjZy4t+SIDxutRDUgE34qlT7TSjT0Oe4HU0pCMbcRCUt1
         S0MqW0AViPj20QQngRfue0i9USeOMUDFWUy9AqYrgaQnidPfm4BbmR/BQpveQi55MmYb
         hmug==
X-Gm-Message-State: AOAM532yoRFaGE4eO+Lq7iuW20nml/i5nGggLyVIvx37cYpr93gtpy5B
        2l3bqvopsPr4bdbuOU9wEh8=
X-Google-Smtp-Source: ABdhPJxPA24MheatYMK3fvrNDnXIJtoCA2tqst7+IsHsKo/cdZGTnbPL6EGXUjwLJlWTmEiWdOLzDg==
X-Received: by 2002:a17:902:d58f:b0:161:9abd:cff1 with SMTP id k15-20020a170902d58f00b001619abdcff1mr4898522plh.135.1652779794666;
        Tue, 17 May 2022 02:29:54 -0700 (PDT)
Received: from localhost.localdomain ([116.89.131.16])
        by smtp.gmail.com with ESMTPSA id h17-20020a62b411000000b0050df474e4d2sm8399720pfn.218.2022.05.17.02.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 02:29:53 -0700 (PDT)
From:   Medad CChien <medadyoung@gmail.com>
X-Google-Original-From: Medad CChien <ctcchien@nuvoton.com>
To:     benjaminfair@google.com, yuenn@google.com, venture@google.com,
        tali.perry1@gmail.com, tmaimon77@gmail.com, avifishman70@gmail.com,
        robh+dt@kernel.org, alexandre.belloni@bootlin.com,
        a.zummo@towertech.it, KWLIU@nuvoton.com, YSCHU@nuvoton.com,
        JJLIU0@nuvoton.com, KFTING@nuvoton.com, ctcchien@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH v2 0/3] RTC: nuvoton: Add nuvoton real time clock driver
Date:   Tue, 17 May 2022 17:29:23 +0800
Message-Id: <20220517092927.19537-1-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support Nuvoton NCT3018Y real time clock.

Changes since version 2:
 - Fix errors in rtc-nct3018y.c.
 - Fix warnings in rtc-nct3018y.c.

Changes since version 1:
 - Add nuvoton,nct3018y property in NPCM devicetree.
 - Add new property in rtc binding document.
 - Add new driver for nuvoton real time clock driver.

Medad CChien (3):
  ARM: dts: nuvoton: Add nuvoton RTC3018Y node
  dt-bindings: rtc: nuvoton: add NCT3018Y Real Time Clock
  RTC: nuvoton: Add NCT3018Y real time clock driver

 .../bindings/rtc/nuvoton,nct3018y.yaml        |  44 ++
 arch/arm/boot/dts/nuvoton-npcm750-evb.dts     |   6 +
 drivers/rtc/Kconfig                           |  10 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-nct3018y.c                    | 592 ++++++++++++++++++
 5 files changed, 653 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
 create mode 100644 drivers/rtc/rtc-nct3018y.c

-- 
2.17.1

