Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FADE501FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 02:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348042AbiDOAfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 20:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245029AbiDOAfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 20:35:21 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAABDB0A4B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:32:55 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o5so6534615pjr.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pbmJlQ5qR1kbE+0/nE9kjO/1skZ6I73pg5jrM6AR8pU=;
        b=i4xp4OxhcZ40oUwcpgza1kp7fp5COsqzWZ/fhqpFqeTDyND88jjZOs+776yAiDWpKk
         B9M3ZfUFcIjIWKLuCC2Yey72mJ6TjNlCg4V3mPRLH0UbkP1rspoq+I9fn7B+asSqDFul
         JL9zYGoSQC/6hPIJFRLXwy0BMt+Q+fVwC1/lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pbmJlQ5qR1kbE+0/nE9kjO/1skZ6I73pg5jrM6AR8pU=;
        b=t5AKVciDxpFA6sl5OB6X4cc4HryexQ9v9fHZemmjXhkBTPwH/Cj33k+Ieb5SAIz1t6
         eB4Qo7M2Qabey4pyedcE1tqeW5W0Ci/OWIpuuIW2iNAnLOa/0p/JhKA5m/SDlfRBod8o
         74PjI7qBELkd1An8GQxAph3GM/0IGD+F/fxUjqdc0a10XOEGhUDZtZ0xTIqINs5PV/uD
         GJRYTUHFi7tIeCOZM78C84EBWgDwMBp1xTbyQryintVUjWwuUn9Au/tpQlFhE1205Kbw
         3201TqaFZRp4EIecy+6KA9hDpmlew5GlLNLAXJAtcqt6ln8598lLLWqcE9j4GEkiWSrr
         fFlw==
X-Gm-Message-State: AOAM531vp2MToNWlaQVzCPeByEkv7iGJo+fVoqog+X7iV4BlQfxVD0a6
        JtofG5M0KMrNQrMwbV2OdpcjrCTu53t9Og==
X-Google-Smtp-Source: ABdhPJwpLciy5kX+80ADH/58xXbGxA3ukoZ2ddhMynp/EA/S9RnXSUcbCCLEUDTX2HYLh/N1aPdMWw==
X-Received: by 2002:a17:902:e0c9:b0:158:9b65:aab with SMTP id e9-20020a170902e0c900b001589b650aabmr11948591pla.18.1649982775315;
        Thu, 14 Apr 2022 17:32:55 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:e3e0:734:f81a:d2c1])
        by smtp.gmail.com with ESMTPSA id p12-20020a63ab0c000000b00381f7577a5csm2830187pgf.17.2022.04.14.17.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 17:32:54 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Lee Jones <lee.jones@linaro.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: [PATCH 0/3] platform/chrome: Only register PCHG if present
Date:   Thu, 14 Apr 2022 17:32:50 -0700
Message-Id: <20220415003253.1973106-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I see a printk when booting on chromebooks that don't have the
PCHG device. This series extracts the count function from the PCHG
driver and uses it in the mfd driver to skip registration of the PCHG
device if there aren't any charger ports. This gets rid of the message
at boot and removes one struct device from my system.

Stephen Boyd (3):
  platform/chrome: cros_ec_proto: Add peripheral charger count API
  mfd: cros_ec_dev: Only register PCHG device if present
  power: supply: PCHG: Use cros_ec_pchg_port_count()

 drivers/mfd/cros_ec_dev.c                     | 16 ++++++++++
 drivers/platform/chrome/cros_ec_proto.c       | 31 +++++++++++++++++++
 .../power/supply/cros_peripheral_charger.c    | 29 +----------------
 include/linux/platform_data/cros_ec_proto.h   |  1 +
 4 files changed, 49 insertions(+), 28 deletions(-)

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daisuke Nojiri <dnojiri@chromium.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: <chrome-platform@lists.linux.dev>

base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
https://chromeos.dev

