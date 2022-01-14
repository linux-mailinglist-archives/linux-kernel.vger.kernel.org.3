Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B8748ED85
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243048AbiANP67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbiANP67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:58:59 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80C6C06161C;
        Fri, 14 Jan 2022 07:58:58 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id l16so4228641pjl.4;
        Fri, 14 Jan 2022 07:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=aCz7uOSROw/TpBhWiSGDLB3cBYDeYWeYdW+iNwHuWsA=;
        b=BLehW1OtNjI+ALeReVSZ5qpdSHSqMe9R4r9CJA23AZnyw9gmN/WM4/EZIeoU6HpW6r
         +s4v54EqIAn9rhBPqRtLp6Zg/R91FGyrtGfyqC5zQv4/r/jbFgrdYOom65LdiAlEa8D7
         K87AYXc7koSU17BhQScNzFqUW2DrqR5RplvudtYOKOjcd8867CRZ/CbaD+OeKMpJOafO
         /65ItUvWfQDoqPvYmzEgw+i9VaUwQNrEN2NEFSCFG/z07Dp0uYYb+yotAaEho52CKev0
         MX4tLWzpJY0FyCgmU8qa42oAavuQkAQb2TiEY0y0aAHW/EeFLcbpys6u+qg/H+ij1ETo
         bl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aCz7uOSROw/TpBhWiSGDLB3cBYDeYWeYdW+iNwHuWsA=;
        b=W3UOTEb4rfWYwpKk+VCZKkwIZUx5jQW8u22Fixx7p4zDv0WmhF6MVKuck5qBcuTRIn
         fT9Z4hiGNEjtkX/5H+iy21bMbLYs0z3cJdrJgCynyGbVqmKTZDxcAYCMNzZGFo/6NEdK
         XIjceMdpQjd0JKgk3oPm5pC0xTLlNE/cC/UnkAjG11StHpSfu2ujl6rRYO9TQMQ5n/+d
         XERpMxgcTnI40PeKCSkth3E+OIU1w96FCM3NJJAoAf+L3DNvP5v6CvdsanregvmF6YXD
         Z3/8AIHBiSCF8xOd06zJ6Kvs+iBiSVvTw1WG/kbtgxOgfYgsggsjJHUpgaRJ3G/i+U93
         s/Hg==
X-Gm-Message-State: AOAM531pJA05Q86W7dGDpM+W1pO0HSJIIHUyYUB5v4PwBg4eXfZ9QMJS
        vm/m8t25OnEXY0gArUCu1TZpKwD8w+I=
X-Google-Smtp-Source: ABdhPJyABw3ha0ikwhwkRhlhsD4NdO587RcU28rq4dgeZZvAZ1oBF5wty90hx7jU8o1fY4WHggQUGQ==
X-Received: by 2002:a17:902:c944:b0:14a:79cd:a7d3 with SMTP id i4-20020a170902c94400b0014a79cda7d3mr9460037pla.49.1642175938264;
        Fri, 14 Jan 2022 07:58:58 -0800 (PST)
Received: from localhost.localdomain (1-171-12-230.dynamic-ip.hinet.net. [1.171.12.230])
        by smtp.gmail.com with ESMTPSA id e3sm5076831pgl.59.2022.01.14.07.58.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jan 2022 07:58:57 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, heikki.krogerus@linux.intel.com
Cc:     gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com
Subject: [PATCH 0/2] Add Richtek RT1719 USBPD controller support
Date:   Fri, 14 Jan 2022 23:58:47 +0800
Message-Id: <1642175929-25337-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

This patch series add Richtek RT1719 sink only USBPD typec controller support.

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

