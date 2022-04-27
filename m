Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33555114CA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 12:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiD0KSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 06:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiD0KSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 06:18:15 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B1931316E;
        Wed, 27 Apr 2022 03:13:45 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id q8so1137839plx.3;
        Wed, 27 Apr 2022 03:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1C1O4qQcGaAVxBHfYfmRjgPqtuMUIW3qAkaHngqvDes=;
        b=NlE9mJ5p7PFfL2h8xzZtuCRTGWvpzPKaA1aFLOoH9Ktft0+MBAqiMLe9WR9zZ+q1tG
         M2hj910wONU/0LgyvpOkBj/o8KoCenPqXS6p7SMBU17RP92WX27hKFpCFwSQLGf8PO0r
         UOUp1geb3AK11zri/1W0EYN3Eh9y8RmQyGnaLbdhZ6lNcz+PCKOKA+JsXw14bdPcHMQF
         w+inUUtuNakbrJ2b7ZsdLSv6PPMuniBSx79OmDdr50Bpn7NDj/b56neoaAlgo/Kn3Fhy
         YoGnNb/VpokgIRhgWhzRWoScdi1iwTvKj1QZIzlmss146M3Rrl5/ICnnx7RgiA9P79lY
         SLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1C1O4qQcGaAVxBHfYfmRjgPqtuMUIW3qAkaHngqvDes=;
        b=53oW5IyMJbKiMDG02lOD9aMAbR/HwSs9G1mfATFCPwJIFu2Iw1iPvs6wrrWEIW8S5C
         H6R1uBD2tPil5PoC7E49JF+0MmpdKcrfuRdq7kSNX6FgXJmqqzMB3NQCCPlTzmC1NlV+
         UVuABzcrnwGv5OuYy568k+H2HrR0KlQtAykh5mkFiZMFrECcr38TC/JEL9Mfd5xOOPDK
         Hk9DRuzqPWSI5wEAtkMoMwgvsayoM6LsqbBzwkfSl4fKwVwegC4pfg59W5JeRJr7+aCr
         knI0+W+fjvR8YxfDOMkW8ML5slJLWy8p363+cfqSDGMRCxis0xMDRBhCXeLRqloQH2Fh
         Lpjw==
X-Gm-Message-State: AOAM533Ux0CwP/xYm/bd5s5vMd3vBYnsgpeK9+S7Jgj1/giZ2BGtKi+a
        0f6EmTxg0tmfPb/TGknMzw52BFGf6gQGZg==
X-Google-Smtp-Source: ABdhPJzz9M4sSrRhLl/SVH2jOIGF0Fae8qCGPAcsCMAJ6QlQWlTDkHN6EP6kfL6MBcOG4iYcm0V59w==
X-Received: by 2002:a17:90b:164b:b0:1d1:b0b7:9033 with SMTP id il11-20020a17090b164b00b001d1b0b79033mr32105321pjb.164.1651054142386;
        Wed, 27 Apr 2022 03:09:02 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id h7-20020aa786c7000000b00505bf336385sm18260649pfo.124.2022.04.27.03.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 03:09:01 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com, lee.jones@linaro.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/4] Add ums512 clocks and relative bindings file
Date:   Wed, 27 Apr 2022 18:08:44 +0800
Message-Id: <20220427100848.3525710-1-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

This patchset is add the UMS512 clocks support

v2 changes:
  adjust description and add the "sprd,ums512-glbregs,syscon,simple-mfd"
  compatibles to fix match failed logs in the dt_binding_check.
  add the property license and copyright notice.

v3 changes:
  fix wrong indentation and hint: "maxItems" is not needed with an "items"
  list when use the latest dtschema.

v4 changes:
  move the syscon bindins from clk to glbreg yaml file by pickup 
  chunyan's patch for global registers bindings
  fix the comments from Krzysztof in v3 patchset
  add the Acked-by: Krzysztof in patch v4 3/4
  fix the  warning Prefer "GPL" over "GPL v2"

Chunyan Zhang (1):
  dt-bindings: mfd: sprd: Add bindings for ums512 global registers

Cixi Geng (3):
  dt-bindings: clk: sprd: Add bindings for ums512 clock controller
  clk: sprd: Add dt-bindings include file for UMS512
  clk: sprd: Add clocks support for UMS512

 .../bindings/clock/sprd,ums512-clk.yaml       |   71 +
 .../bindings/mfd/sprd,ums512-glbreg.yaml      |   68 +
 drivers/clk/sprd/Kconfig                      |    6 +
 drivers/clk/sprd/Makefile                     |    1 +
 drivers/clk/sprd/ums512-clk.c                 | 2199 +++++++++++++++++
 include/dt-bindings/clock/sprd,ums512-clk.h   |  397 +++
 6 files changed, 2742 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
 create mode 100644 drivers/clk/sprd/ums512-clk.c
 create mode 100644 include/dt-bindings/clock/sprd,ums512-clk.h

-- 
2.25.1

