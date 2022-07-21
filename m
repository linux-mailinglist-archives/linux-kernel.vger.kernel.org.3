Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A0C57C42F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiGUGLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiGUGLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:11:52 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7EBDEED;
        Wed, 20 Jul 2022 23:11:51 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p8so857426plq.13;
        Wed, 20 Jul 2022 23:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hrNHNw16EtOJwmuHD6+jFO4HKihV4GZ3PvUBJ8NHGuI=;
        b=f27tBFsGDqOXxvVijYhuUVpOOhEW1Rn7ZrcZxMUPW7rSW7+oyqTeJhNS+YfBzCCTLL
         hkuaYfM+ir/7uu1CpwzxSFOW2U9x0QlTW5VrHGjST563MaYaDlhPSRUC2N6JHGQpkwBq
         xoX1AqJ1JU/Ghj2/nliNk76dQVcXmYTNENTV3KTy0fxOAVQ0VfSOW9a5HgO0bRFMtaON
         MgzF4ckfXsf12kVqjbu0uw3ngorpPGqv8f0Z5huF2kvu6v6Yg51+QibKPpEmm4NAyAOt
         1qRn9W5meWXgPMTF7n7YVTGoBP+HNYgcWu+d0stnSMwMLa5b1muu2e/zAlEAZQ917yMq
         zYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hrNHNw16EtOJwmuHD6+jFO4HKihV4GZ3PvUBJ8NHGuI=;
        b=TJHwrPrbysXB2WyyhMWO9DsCHIa6l5x4SvzdWsF/uvxoKkPZ8uaJ7nO8C6cq8n4zEI
         Sm3fXaF8Rn9y0r5qtcIm0WjYmBCl67hn7umDJQGyPA0RtUzXb4YGfLVntyM3K9d4zQ5l
         WskzSdd08K8QWSu/BNt4vIvOe5FgSqTShcpNc0aaz3uTjEISVQfiVsE5mG4XIK5qeLX2
         Y2YqdBJoYW+7WWZpRoJ8atjc2IFF/E2YQZaxqopyrr/B/2h98Yy1VRzlQnr3phNkEMz3
         xpkjIlLo/ZNGKOaHXmeNAY0FNHQIO/nL7mH7KEccBTgJUxsftXVkqn/+m7qxDddXqrpK
         peVg==
X-Gm-Message-State: AJIora/6VIZthIRPZDGytgRa6p1jcLjvTaPga08K2+J/XKKzihMmHREe
        JarpQQCyOehJ8w7mV/VBuawCYyA9mBs=
X-Google-Smtp-Source: AGRyM1uReszn1uuG5YGYJ9YgbsUQ2xWaVFcROuI1lnpL+jlECstktasvh2IKpjzEsWICRDNSBxddUw==
X-Received: by 2002:a17:903:1c5:b0:16c:4b1f:c5ff with SMTP id e5-20020a17090301c500b0016c4b1fc5ffmr41955463plh.158.1658383911076;
        Wed, 20 Jul 2022 23:11:51 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:46a:8b75:f825:a44d:6d0d:6d6e])
        by smtp.gmail.com with ESMTPSA id 13-20020a62170d000000b0052ba782f4cbsm744998pfx.7.2022.07.20.23.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:11:50 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: [PATCH v2 0/6] usb: typec: tcpci_rt1711h: Add compatible with rt1715
Date:   Thu, 21 Jul 2022 14:11:38 +0800
Message-Id: <20220721061144.35139-1-gene.chen.richtek@gmail.com>
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

Gene Chen (2)
 - dt-bindings usb: typec: rt1711h: Add binding for Richtek RT1711H
 - usb: typec: tcpci_rt1711h: Fix vendor setting when set vconn
 - usb: typec: tcpci_rt1711h: Add regulator support when source vbus
 - usb: typec: tcpci_rt1711h: Add initial phy setting
 - usb: typec: tcpci_rt1711h: Add compatible id with rt1715
 - usb: typec: tcpci_rt1711h: Fix CC PHY noise filter of voltage level

 Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml |  100 ++++++++
 drivers/usb/typec/tcpm/tcpci_rt1711h.c                     |  155 ++++++++++++-
 2 files changed, 248 insertions(+), 7 deletions(-)

changelogs between v1 & v2
 - Seperate patch by specific purpose
 - Fix binding document error
 - Set cc change woakaround without using tcpci ops callback


