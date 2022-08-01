Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFC3586760
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiHAK1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiHAK1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:27:16 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACC0193FF;
        Mon,  1 Aug 2022 03:27:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b133so10195614pfb.6;
        Mon, 01 Aug 2022 03:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zu3aM2YK1KWHPeKKhSOJs6YxEAilw7bAa6MW8k/JltA=;
        b=WfaWyfkt6tJ49YpWh+5wndqOCfSXywFGtmQ9y/z70N+fuPM34NVOxSWj12kMppPlCs
         I0kss5yBUPfzdpGfKv2f0QIQNr0k59mUreB7uS9uNOKGgqFfURIAyISeZ2cohSa/+cOA
         me//6R2mWthsK2cYrWdhVdZL+aecjiwXgRqg0bE9F3IhrQ0hgVhQOIYN2C/DFqwpy/NN
         atOZH/fwLxj4PQzstH2TRAKlU3B/km+a6cbUeUpMePRV7wThDB37ZBCSbaOO8w76ZAXI
         VU88TGcpSd/Xgf9RZEPEZCwacjcMFRzK/tlmrenBbaS6s/eeQOF9M5p4p1Jt2X2VMZ8v
         CPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zu3aM2YK1KWHPeKKhSOJs6YxEAilw7bAa6MW8k/JltA=;
        b=b9iE8UYfg6dKU73MS9PVZJQZGCMkjnLp6kkGiCRISDowu6dGYgbPL9jRuW4VrsbRPk
         UdEmKWdCemWYMUNt1Ljsu73MB5xaopSul0mnZ1QZroPW+SCvQ1OBMignsFy07shveoBv
         rQTBb/ISdTu2SLb6ZGOhRKywkIwogxzhOVPBcik+Fui7dqe6LNzTeLhiFMXCdwlPAVGT
         KD6zSvD+Txl84b3eFhbh5BOOQRnktBBdTKe9vUbOnHKYCZF7lUSUi5ZfC2Au65x173Re
         KknE70H1SZCJzhoFA0tICf3qq1NaRXcK6uzUWue3MxZdK3u2JISGJRn/Q5/KHq7Lw0QR
         UVWw==
X-Gm-Message-State: ACgBeo3rEq/CF339tC0q/qi52xU7B0EbpxSkR23qzeV3TsVM+7xnj//Q
        dLWJ+DPl08stiItf5DQmRfrhLcGXzxU=
X-Google-Smtp-Source: AA6agR7tGhlvJo5XynXtui/xyRKKpa7QO9f9snQDF35ye5jsHPYTx+gGIf3X8evGPbX6V5yHW4YxAA==
X-Received: by 2002:a65:4941:0:b0:41b:faf4:3223 with SMTP id q1-20020a654941000000b0041bfaf43223mr4365795pgs.546.1659349634693;
        Mon, 01 Aug 2022 03:27:14 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:579:6a6f:8d46:b2ef:57e3:7c30])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b0016c6a6d8967sm9199302plb.83.2022.08.01.03.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 03:27:14 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: [PATCH v3 0/7] usb: typec: tcpci_rt1711h: Add compatible with rt1715
Date:   Mon,  1 Aug 2022 18:14:40 +0800
Message-Id: <20220801101447.86207-1-gene.chen.richtek@gmail.com>
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

This patch series add binding document for rt1711h and compatible driver with
rt1715. Also add different remote rp workaround and initial phy setting.

Gene Chen (7)
 - dt-bindings usb: typec: rt1711h: Add binding for Richtek RT1711H
 - usb: typec: tcpci_rt1711h: Fix vendor setting when set vconn
 - usb: typec: tcpci_rt1711h: Add regulator support when source vbus
 - usb: typec: tcpci_rt1711h: Add initial phy setting
 - usb: typec: tcpci_rt1711h: Add compatible id with rt1715
 - usb: typec: tcpci: Move function "tcpci_to_typec_cc" to common
 - usb: typec: tcpci_rt1711h: Fix CC PHY noise filter of voltage level

 Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml |  100 ++++++++
 drivers/usb/typec/tcpm/tcpci.c                             |   22 -
 drivers/usb/typec/tcpm/tcpci.h                             |   23 +
 drivers/usb/typec/tcpm/tcpci_rt1711h.c                     |  159 +++++++++++--
 4 files changed, 265 insertions(+), 39 deletions(-)

changelogs between v2 & v3
 - binding compatible name with did to validate chip
 - remove postfix name "_mask"
 - move get cc status macro to header

changelogs between v1 & v2
 - Seperate patch by specific purpose
 - Fix binding document error
 - Set cc change woakaround without using tcpci ops callback


