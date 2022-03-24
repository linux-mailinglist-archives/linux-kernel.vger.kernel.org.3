Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B194E67C7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352277AbiCXR2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351424AbiCXR2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:28:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1041B1A9C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648142824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=liRbImRNW+7P8M0AFLGtjRyZSDyrWzFoWmyeKMsK9gQ=;
        b=B12Z8zRexv7Tys+ZC8uIawi/jFNr6wTX2Wbt/iA0JnNzQ5NtA4K8J1RQ986i8CXPazHztD
        2pBKhSdfdXPFGm6DIeX+lOi+Y4/zF5o3BrMDk44xM0n1CzmXR/pRRs2WBR62H/qUTGsM1q
        MWMVZJuDFDXjFD8m2ajMa1OZ0t0LjPE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-381-9U8aWrC0P3CJqDd7yigCfA-1; Thu, 24 Mar 2022 13:27:03 -0400
X-MC-Unique: 9U8aWrC0P3CJqDd7yigCfA-1
Received: by mail-qk1-f200.google.com with SMTP id bj2-20020a05620a190200b005084968bb24so3489824qkb.23
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=liRbImRNW+7P8M0AFLGtjRyZSDyrWzFoWmyeKMsK9gQ=;
        b=QjiVc/+WJtkcJ8YXaBW68uOU+zfEl4TxE/0BZAydGAZxdsnmKOWr3DfmjddfEkf3EG
         ey2gebbtv6ZaHlAiSipzwAPWUiCADymhic3bYkj1s9rttNysLTnZ/Bs7ZSHR5HMS/uEH
         te91GOnECrHGDAmWNHs1lAsxlyAGnrGKjrhhKp/nFjbIrQh4OZA9H0aJ/FXTem+ImtL6
         cJAbQ+Q8UVU6NUDPZ82BFVHl3SSQV7ZKMWOqdmofZu6LCCaplrNfaSVPr7VS29ebxyDx
         isvLCVOpFIyyykmQzJVWlnr4uR2aUc7jxbryU/CpR0H8T4u7mg75XRE3hXnEY3e0ehB5
         EkLw==
X-Gm-Message-State: AOAM533BEqiOhDNFptxmi1Alrw29eKWoQEBjsm+1aoKVr2woWveWzten
        +GE4BJHNlwyYYKIH0BOXI6DhE/yhDUS+UL3pvhQ/3ASydvvx9286nhcf5mUcZ9des26LGlClfqx
        Q4t0qkTKz7CR/3amQOqjcEml9vF/HkPzUYTcBL/6Zy8HKnF5VVKo2wXQ0kB5mj+ufRwHT+zmPdg
        7J
X-Received: by 2002:a05:620a:370c:b0:680:9d9e:ecfe with SMTP id de12-20020a05620a370c00b006809d9eecfemr3825830qkb.307.1648142821979;
        Thu, 24 Mar 2022 10:27:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoRa+4NSOlOggFdzYFCyPhvXbLJa7Ooafl0DS0H8lqYYl0wdhBQkyvH/e0Vt0LXWhsBn5ANQ==
X-Received: by 2002:a05:620a:370c:b0:680:9d9e:ecfe with SMTP id de12-20020a05620a370c00b006809d9eecfemr3825800qkb.307.1648142821680;
        Thu, 24 Mar 2022 10:27:01 -0700 (PDT)
Received: from fedora.hitronhub.home (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id bm21-20020a05620a199500b0067d5e6c7bd8sm1886515qkb.56.2022.03.24.10.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 10:27:00 -0700 (PDT)
From:   Adrien Thierry <athierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Adrien Thierry <athierry@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Stefan Wahren <stefan.wahren@i2se.com>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gaston Gonzalez <gascoar@gmail.com>,
        Ojaswin Mujoo <ojaswin98@gmail.com>,
        linux-staging@lists.linux.dev
Subject: [PATCH v2 0/2] Add support for bcm2711 in vchiq_arm
Date:   Thu, 24 Mar 2022 13:26:45 -0400
Message-Id: <20220324172647.167617-1-athierry@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this patch series is to use the bcm2711 compatible string in
vchiq_arm for the Raspberry Pi 4. This allows using the downstream device
tree with the upstream kernel.

---
Changes since v1:
- Removed duplicate compatible string for bcm2711 in
  brcm,bcm2835-vchiq.yaml

Adrien Thierry (2):
  dt-bindings: soc: bcm: bcm2835-vchiq: Add support for bcm2711
  staging: vchiq_arm: Use bcm2711 compatible string for bcm2711-based
    RPi

 .../devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml      | 5 +++++
 arch/arm/boot/dts/bcm2711-rpi.dtsi                           | 1 +
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c    | 5 +++++
 3 files changed, 11 insertions(+)


base-commit: ed4643521e6af8ab8ed1e467630a85884d2696cf
-- 
2.35.1

