Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B661C4EAF73
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbiC2OoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiC2OoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:44:04 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D49633E0B;
        Tue, 29 Mar 2022 07:42:22 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id h19so15105065pfv.1;
        Tue, 29 Mar 2022 07:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=qQMU1UOC6msMA3QkNjDMmv91MNuawzJ089EgdBRJGvA=;
        b=EQ7JkrvxubOLSNofl3ON/g00u7rH3PWvEGSSAUuOpWtSCDlXofcS8lqvZGsn13dUe/
         Z0LCpWK7t4N3WZIZaE4WoLXqWCDK+UTQAEouqqBOhPsCR0GxKMA6MLcIQDlMNyLaXNwj
         N0UsSmpgrubLLW5G5BleOQ1PH0riIBAUp2miCBeOJA4AFCRZ2e9RYAWnIylkQ0fPxmwb
         zPVh/msbI5wZ0P/8P0nwQpXJg5EJpdKujGOEnqOi4kArQHk1XA0Yttn2FosTIYoWbCyx
         D/RuoQxcnRWsYVdaN3ooPixr5+vGKtaTfKNeV1G0WkSOsBEApy77cd1SvwFvjtHHyr1z
         dIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qQMU1UOC6msMA3QkNjDMmv91MNuawzJ089EgdBRJGvA=;
        b=upJD4pCH8OWv3dbRJBISYdJ5BpE/eY7W6F0e7BpxnUyrden6IKZ5qHkro5PTgjvmE+
         DXomIVhio8U6wYSC7L7uhUL+1DEP+44+LI+L9+puwRvtJ1h47qN7jlBlFQknyHX4dVRS
         RseORn5xV3gu6eToV7j2IbpuIBF4jIdbdldwIrnD2Xx2JIJnkwko3Tg0eu/mqfovTENq
         ylXKq95iwx7XlwaA0fkq2OuepYMbCyyb0z/CDCFih1EhQxQ9eZx+EBXJZ0jiceTk6W0q
         45pwwVC4DeXCCxii/NbHtwXVDPJ0LWJ4vA/1ATPNJpAG9Hm5Q/VPpfDK5hzY1kjmDLsJ
         W3Og==
X-Gm-Message-State: AOAM530WS0qakmKJQ3qiCoYFrap2wogW+LL02zn5hbz2JCjMBHcavqqf
        hhDgSP9aeQQ0kRojC6pcpJY=
X-Google-Smtp-Source: ABdhPJxPqwp6ekKWfuJMbn8EADeIw4d5Ch/FS1LyZlVrhohnAp4b5HYT3kVeHCnS4btwqEEsuk7ADg==
X-Received: by 2002:a05:6a00:130e:b0:4f3:9654:266d with SMTP id j14-20020a056a00130e00b004f39654266dmr27980051pfu.59.1648564941642;
        Tue, 29 Mar 2022 07:42:21 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id ij17-20020a17090af81100b001c67c964d93sm4349569pjb.2.2022.03.29.07.42.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Mar 2022 07:42:21 -0700 (PDT)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, lhjeff911@gmail.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, tony.huang@sunplus.com, lh.kuo@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v5 0/2] Add mmc driver for Sunplus SP7021 SOC
Date:   Tue, 29 Mar 2022 22:42:02 +0800
Message-Id: <cover.1648551070.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for mmc driver for Sunplus SP7021 SOC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Tony Huang (2):
  dt-binding: mmc: Add mmc yaml file for Sunplus SP7021
  mmc: Add mmc driver for Sunplus SP7021

 .../devicetree/bindings/mmc/sunplus,mmc.yaml       |   64 ++
 MAINTAINERS                                        |    7 +
 drivers/mmc/host/Kconfig                           |    9 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/sunplus-mmc.c                     | 1212 ++++++++++++++++++++
 5 files changed, 1293 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
 create mode 100644 drivers/mmc/host/sunplus-mmc.c

-- 
2.7.4

