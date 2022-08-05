Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E48258A6DE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240282AbiHEHRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiHEHRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:17:48 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C70B10E3;
        Fri,  5 Aug 2022 00:17:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id f30so1153056pfq.4;
        Fri, 05 Aug 2022 00:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VFXvqXWuizqTpdBLbyESGII1eVMtZqfMsQFHKhGg+1k=;
        b=XQf9dqVTFmz13HUGeiLAH1G26g87e+Mc4YCTFoKb4qct+L6qSGNLbOl5VTi04nT00m
         R1zAXn2foMABuLBuMLEl/71hCRT+KnuUtvC4BBgxGpKiOjUr0eEj2ys1nE1ia2dNdH0a
         nXif8ZZX0rAIIut4n9jfRXtU/UAcsR7+ZXqmoBQDt12DSCiqBVhvRGuZhSgNNWJ+w0Ha
         H2RUvqP8yLRiwVAviFQJd4wqfMaYDWgmWNGQptivy0NI773b5WJF80Spwp99yHzi2YxL
         cwkqZ7JzZnw/2iahSyy6OXuDZJOSTPuT/MsomlUuTRxVNv+JrLJGBVJRLx4k5nKNmp7Y
         ZAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VFXvqXWuizqTpdBLbyESGII1eVMtZqfMsQFHKhGg+1k=;
        b=dLtGpJps/Ne2LVPjx1UabJ0ce4kSc7IR4FrUxhX7ztEInwVE8+qc/Bps9/V9AgpMi7
         So3LT325FtEgG0vcMCnQLWfbE6BcDyWcMWr+N+3sj2waoQl/Cx7ceg28ynS+qR2sOSYA
         M/MJI19eVJ4b1REnUi5UgdIudc5orwJI2rjJZMMchCA0oTrVL2dqQqn2EKm+rlZ3m6Ul
         SiJcZlEihrSqaBOxv8q3rgfXhfPhy17PM/u968VM98Wo7U/sTsgskGodqIotMeXaCkOO
         SGqr6XifIgY38xCU3TJ7hvG1VgEO5tC4yqxN05f8PtgRe+RsQkkQ74Jnz1m7NPD10535
         tZow==
X-Gm-Message-State: ACgBeo2UKVKFpvofWAkvUWLYPqUYL6pypm5G5rGRCaeeePNoxmyMU0we
        5YD7gDLXPZvjzSwxJonyc6w=
X-Google-Smtp-Source: AA6agR5Uinecy8xRTpSjGSViqI14CB3j4arBg8VlcU0pm01Y6jx/x2HVDMeN6CKWXhujognBwlt2Sw==
X-Received: by 2002:a63:18a:0:b0:41b:475c:6c08 with SMTP id 132-20020a63018a000000b0041b475c6c08mr4876130pgb.77.1659683867547;
        Fri, 05 Aug 2022 00:17:47 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:579:6a6f:254a:2074:501f:264b])
        by smtp.gmail.com with ESMTPSA id z23-20020aa79597000000b00528c066678csm2226147pfj.72.2022.08.05.00.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 00:17:47 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: [PATCH v4 0/7] usb: typec: tcpci_rt1711h: Add compatible with rt1715
Date:   Fri,  5 Aug 2022 15:17:06 +0800
Message-Id: <20220805071714.150882-1-gene.chen.richtek@gmail.com>
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
 drivers/usb/typec/tcpm/tcpci_rt1711h.c                     |  150 +++++++++++--
 include/linux/usb/tcpci.h                                  |   22 +
 4 files changed, 259 insertions(+), 35 deletions(-)

changelogs between v3 & v4
 - remove reshuffling header
 - fix commit message typo
 
changelogs between v2 & v3
 - binding compatible name with did to validate chip
 - remove postfix name "_mask"
 - move get cc status macro to header

changelogs between v1 & v2
 - Seperate patch by specific purpose
 - Fix binding document error
 - Set cc change woakaround without using tcpci ops callback


