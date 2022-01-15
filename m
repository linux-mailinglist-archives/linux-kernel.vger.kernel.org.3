Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6343148F390
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 01:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiAOA4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 19:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiAOA4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 19:56:40 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EC5C061574;
        Fri, 14 Jan 2022 16:56:40 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id e8so921193plh.8;
        Fri, 14 Jan 2022 16:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=lL0LBy1q4fDmIfsePXwWEWFjmCmkm8zieBUz0OTp2io=;
        b=UJdYAlXcdTZ8B1/TB0b9f/J46ipwhNW3pAdZlb4PY5PX+D/sBBWss3FGm67aisN41G
         ZXV5GUQUFmt7fmkJszykTTbGPnqOLIAIeLBsh8kDXSnN4jwAIy9qqCvc1f7U8Y8sHaYZ
         hQ0wXD4YW+P0e9VIRONIj5WlKR1QO/3JGt2ReISBAdNWD4dcDGDxNn9BSEsJHb9BVQoX
         sImlEIeGnw+qwPAnjajXNxykfFfs+nEKjvRFVtK0vUgA/8e/b7iO7P4NhonbeXcgm+Fk
         L6PI4T4W9JMqCc5Sykf6d3r9wjE3OihT2eDW2CKhObyzkCpzYdm7OAWsNGXJewXkCQsB
         yrlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lL0LBy1q4fDmIfsePXwWEWFjmCmkm8zieBUz0OTp2io=;
        b=F/T9odxXV+TIonf6T2uckxb0TX5h5YjSE3CmXhLTQ1tzhFU8+QD16rPpZEVsjxBO7u
         poNP5DtmCgdfj/uDSFjNSTmn079WZYvFKpmkfoD9931WwA+m50Dngq4tTEEMDdrYu8+M
         Dmoh2/r7NR13bQ51aFpgVb+h3r167tr0cqeOSU3VwNjFg59DqdhQthgBLH2Wnv/+76Rg
         EplNK3tBDfbqkKIzdCuBoDsTHZ3QXyceQHUCC9LPbmodbn/Hj9E/TyjUYbP7c/hcosDd
         tLS7VTQQZSjJ+T5+dGrF708tIu22mqatHd5YCWpR18M9C1nmq7IYD8RpCTjfmK+xa7bJ
         aVxw==
X-Gm-Message-State: AOAM533/iaH0t+fd5JHggBu8vlTJiCu6PaLKmTFRqQrpmyAStYveRixo
        Nsv8epurjf71HNvvW+fAOos=
X-Google-Smtp-Source: ABdhPJxDAYWFsBM0R8cLN7Eisj3Jo3sSNeJJMJzwZvWZez66ROAwcWeZF4UhlCqBqdY3H1x+FKQNyA==
X-Received: by 2002:a17:90a:1c1:: with SMTP id 1mr13398620pjd.151.1642208199718;
        Fri, 14 Jan 2022 16:56:39 -0800 (PST)
Received: from localhost.localdomain (1-171-7-64.dynamic-ip.hinet.net. [1.171.7.64])
        by smtp.gmail.com with ESMTPSA id j18sm5335570pgb.27.2022.01.14.16.56.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jan 2022 16:56:38 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, heikki.krogerus@linux.intel.com
Cc:     gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com
Subject: [PATCH v2 0/2] Add Richtek RT1719 USBPD controller support
Date:   Sat, 15 Jan 2022 08:56:29 +0800
Message-Id: <1642208191-7254-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

This patch series add Richtek RT1719 sink only USBPD typec controller support.

v2:
Fix below kernel test robot build warning.
>> drivers/usb/typec/rt1719.c:492:65: warning: suggest parentheses around arithmetic in operand of '|' [-Wparentheses]
     492 |                                  RT1719_EVALMODE_MASK | src_sel + 1);
         |                                                         ~~~~~~~~^~~


ChiYuan Huang (2):
  dt-bindings: usb: rt1719: Add binding for Richtek RT1719
  usb: typec: rt1719: Add support for Richtek RT1719

 .../devicetree/bindings/usb/richtek,rt1719.yaml    |  85 ++
 drivers/usb/typec/Kconfig                          |  12 +
 drivers/usb/typec/Makefile                         |   1 +
 drivers/usb/typec/rt1719.c                         | 976 +++++++++++++++++++++
 4 files changed, 1074 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1719.yaml
 create mode 100644 drivers/usb/typec/rt1719.c

-- 
2.7.4

