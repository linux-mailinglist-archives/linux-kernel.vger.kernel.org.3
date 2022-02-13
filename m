Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D9D4B3C67
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 18:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbiBMRPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 12:15:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbiBMRPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 12:15:54 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F1C58E72
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 09:15:47 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id j13so2626653ejk.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 09:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c9MPHlFrwB1AIaRrVksm22KgsTglVC3BMVPKSN6mOUY=;
        b=ofyDYtpNgouEVX7gOtAFSj8cSZCLEz3TXD/HACNOFQcx8n+b91koIqr/LG0Ql3hmbJ
         mJDqwzf8EjqIzQ70RdtYAk9Em5zmqln6NL4J9qHB4+a9O07QV+iirtWG2JRqPkpezi75
         ZK8sAWcRuJ+5JaelIw0b5NfEPyjz8Mn+bDF0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c9MPHlFrwB1AIaRrVksm22KgsTglVC3BMVPKSN6mOUY=;
        b=YTsCdLymK5zzRnfix7bh3UJXIeLqkdT56kJg3w/P2wUlULVz28xpaDX0f6+0M3PHom
         SiBRnC9EGqnedsvtOoeoNOKF2msws6PdPQB0ZODbceJNGlpaCM/HI/4R554lVPB3nWf1
         2WIx2+PHZZA/Z3m4DejCSW2fb9oOtjBjZhuuaF7NqVaFDSBzIJU0HUydREc+xOzjo586
         ACZzKweCFobarTkWHj57gLr6r0Hbz3DctHOIRd5zVmfGTQMn5py19RPQg7GRyGb+vHz7
         TUiTOZI0D0vHtJs4TT1+u8cYpvmCGoAFJPhzSGRiP29bnVqrrFzK63n2sT68xRp+5fgK
         qGig==
X-Gm-Message-State: AOAM533rG+XHiF6uipl08oNFWDle6283sXUnVVw2NjE66jzka/pAf3gJ
        cVDD9aiC82bcjsC6YIMsooYNyFc+hTl3TA==
X-Google-Smtp-Source: ABdhPJxzrYnp0KzwWb+SoSyHHC1bsVKGey8t110wlfenAXc4cu3PVtFf+zECOtq9bIZ7nETEOWUSwg==
X-Received: by 2002:a17:907:3d94:: with SMTP id he20mr8574709ejc.637.1644772546240;
        Sun, 13 Feb 2022 09:15:46 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-52-8-210.retail.telecomitalia.it. [82.52.8.210])
        by smtp.gmail.com with ESMTPSA id o10sm6598878ejj.6.2022.02.13.09.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 09:15:45 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH 0/6] Input: edt-ft5x06 - Improve configuration
Date:   Sun, 13 Feb 2022 18:15:26 +0100
Message-Id: <20220213171532.346270-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series was born from the analysis and mitigation of a crc problem
raised by an M06 type device. The added sysfs attributes were helpful
in debugging the problem. Patches that change the report rate on driver
probing, mitigated crc errors on kernel bootup. The patch to get/set
report rate by sysfs for an M12 device, has been tested.


Dario Binacchi (6):
  dt-bindings: input: touchscreen: edt-ft5x06: add report-rate
  Input: edt-ft5x06 - get/set M12 report rate by sysfs
  Input: edt-ft5x06 - set report rate by dts property
  Input: edt-ft5x06 - show model name by sysfs
  Input: edt-ft5x06 - show firmware version by sysfs
  Input: edt-ft5x06 - show crc and header errors by sysfs

 .../input/touchscreen/edt-ft5x06.yaml         |  8 ++
 drivers/input/touchscreen/edt-ft5x06.c        | 81 +++++++++++++++++--
 2 files changed, 81 insertions(+), 8 deletions(-)

-- 
2.32.0

