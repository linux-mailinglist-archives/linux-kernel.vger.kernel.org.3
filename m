Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5734150C410
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbiDVW6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbiDVW5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:57:40 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931E23420EF
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 15:21:51 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id e4so10593107oif.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 15:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zshTmKTlwWpNs+bPCyPg2G4xzDcF+pfyEHctS9lyUmM=;
        b=p18Ea3C4s1iYRhpjXGv+Q/z6sLN27GiKyszpjW0gjWX20QRsSCMVqd4yA/Lh7GOi9g
         /NZuoRazntRsAsm7WAgnDef7b9pUyzSbPBgJLpfKe4YaPvU0WJ0QR75I/vUhDq4iF6RT
         QUQKylKyqoeB5ZCAIKx5U/i6opxvjNvTD9dkTdx4Ut2k/jC9uC6xqzQstUbv9ArUTpU5
         eylxKDHkC64LZd0jHtQ00UXgy1/AShQ8KDXPe60eVxQwS3eWzG5ASX7cvsgM48zY4w1Q
         +k+q0r3URNAs8mcCu2n5GkmNiYnEkray5b5LPhbWNoTNHhoOnpg7Ib3g+qRBL5oC5/Xx
         q97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zshTmKTlwWpNs+bPCyPg2G4xzDcF+pfyEHctS9lyUmM=;
        b=PhCatgFXQyzd/nTRSpmg0TJ6sH8hM2NzdWHHkhsvCIvi3wNNIusGLDTLH1LN2+7+eS
         SMOmDdO9Usc+dFzVgi72CIuLe87wy7cMzui6Dm8TVPnvWmpsT+rOPRw9s8UhyZi6qDcw
         GDbgbwZeSCdsDpaKp0B8Hh8/3kfTQ6ttz54nTjs5nrd5Uo4cXzQpj0MwCqUqN7LMzbCW
         c87fUpe2MqEjJuEechm7sVjvdC10yWQq00Azxb2OqZahM7Mkwrz6kjKacHqHadDrIMS+
         IeMsW7om4TjosLJwVku9toAEe+uAzRdk+X7Qwbp6cudvtbAI9RrqMLerFfUinlZre/Et
         cWXQ==
X-Gm-Message-State: AOAM531k6TSC6laqO40CNvDezmJTvUrtXZ4dlXF8TeoTyCqD8TN381IZ
        A2VyZHJbT3ennwhSpnCERYIyzg==
X-Google-Smtp-Source: ABdhPJy2wkzUusvXDfhRYywzAm+d4ZCyFMdNt0N57JRQDI6OHyUJyvx5APLKi6X+9Gnrlb3M4ed0/A==
X-Received: by 2002:a05:6808:1828:b0:322:4891:8832 with SMTP id bh40-20020a056808182800b0032248918832mr7699862oib.172.1650666110356;
        Fri, 22 Apr 2022 15:21:50 -0700 (PDT)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id js4-20020a056870bac400b000e687cdf5adsm1049224oab.55.2022.04.22.15.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 15:21:49 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v5 0/7] typec: mux: Introduce support for multiple USB TypeC muxes
Date:   Fri, 22 Apr 2022 15:23:44 -0700
Message-Id: <20220422222351.1297276-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces a level of indirection between the controller's view of
a typec_mux/switch and the implementation and then expands that to support
multiple drivers.

This is needed in order to support devices such as the Qualcomm Snapdragon 888
HDK, which does muxing and orientation handling in the QMP (USB+DP) PHY and SBU
muxing in the external FSA4480 chip.

Bjorn Andersson (7):
  device property: Add helper to match multiple connections
  device property: Use multi-connection matchers for single case
  usb: typec: mux: Check dev_set_name() return value
  usb: typec: mux: Introduce indirection
  usb: typec: mux: Allow multiple mux_devs per mux
  dt-bindings: usb: Add binding for fcs,fsa4480
  usb: typec: mux: Add On Semi fsa4480 driver

 .../devicetree/bindings/usb/fcs,fsa4480.yaml  |  72 +++++
 drivers/base/property.c                       |  96 +++++--
 drivers/usb/typec/bus.c                       |   2 +-
 drivers/usb/typec/mux.c                       | 271 +++++++++++++-----
 drivers/usb/typec/mux.h                       |  12 +-
 drivers/usb/typec/mux/Kconfig                 |  10 +
 drivers/usb/typec/mux/Makefile                |   1 +
 drivers/usb/typec/mux/fsa4480.c               | 218 ++++++++++++++
 drivers/usb/typec/mux/intel_pmc_mux.c         |   8 +-
 drivers/usb/typec/mux/pi3usb30532.c           |   8 +-
 include/linux/property.h                      |   5 +
 include/linux/usb/typec_mux.h                 |  22 +-
 12 files changed, 614 insertions(+), 111 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
 create mode 100644 drivers/usb/typec/mux/fsa4480.c

-- 
2.35.1

