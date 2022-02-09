Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7734AF59D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbiBIPmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbiBIPms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:42:48 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500CCC0613CA;
        Wed,  9 Feb 2022 07:42:50 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id w20so2510548plq.12;
        Wed, 09 Feb 2022 07:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=8dk2us8mXF2421eYiN97FlKKAZjNZsPyFxZ4wTd48vI=;
        b=AzsqGiBtVmnsCEehZbxaVxp/fH2NHg5CwHrun247kP1QCF7YhI32bmmKs1uC4WXETU
         HzareomzoshIj5G8hFUFvsOsNcwEh4HOx7SKukOIR3rZNUboXyKRL2RHFTgxmKy9scoq
         IOMuV/VhIhFabMsvfbdbILEf37uTtRG1nExDxtPl2JWm6IIsD1ZGohMbH8LC3lyNbsdL
         Z6zDvTx5BdEiNMumXqY6l+sRbdFIyR8Av3qWWV3RI6ht3DBdMgEmw0D6BFick55YIkm8
         TpcFF8DzkLe3OiKpPm2tD8KH5s4NdV+4TG5Jz1Km3A65AoNfmCV3HE/ViR51ffG1D8YK
         5zBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8dk2us8mXF2421eYiN97FlKKAZjNZsPyFxZ4wTd48vI=;
        b=s9B6/jwkN0AClngwAtloRkb021gcIsOTJLnIAAwJVw3H9swElkdL+mtnvReY4joFmZ
         COGRtZx+0+IRkTciCyVmUy+AzvKBxquVJ1RKn5IaaFF+ev9v9jGalXvG6fCYLYJYbUyA
         XpTohhHHMs5GdZJQWRVicAnzu6DMmbnRql4/09DEkoAxMYN104fBlgozGKcNGMMq+YNM
         at7FAliX+V+FlgPyIn6hh1KJoQWm2M8P3TGM8pUKOcbEWfKvsjMpKMXYSAw9/c7lYFMV
         Ozz415xJ6042pGlHVrGDVG24D1rFpnkv4RiJ3rx5isVdlyUzMAcnDm/3+ujx8y0d0Czs
         xjDg==
X-Gm-Message-State: AOAM5339gr13g/9+HloFIsgKuyElFqyiVigZxBa0XEXHVnis7srDs1QK
        sDA42BD7az0Y6oA46DXFZw0=
X-Google-Smtp-Source: ABdhPJwxWl5xJhwckijkVrEblldOOK2Xb2fHWgtlnDwqReGrC8WhVvG4blTar3MOVqB716cJbeij6A==
X-Received: by 2002:a17:90a:985:: with SMTP id 5mr3111581pjo.217.1644421369643;
        Wed, 09 Feb 2022 07:42:49 -0800 (PST)
Received: from localhost.localdomain (1-171-21-84.dynamic-ip.hinet.net. [1.171.21.84])
        by smtp.gmail.com with ESMTPSA id l2sm20929152pfc.183.2022.02.09.07.42.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Feb 2022 07:42:48 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, heikki.krogerus@linux.intel.com
Cc:     gregkh@linuxfoundation.org, cy_huang@richtek.com,
        will_lin@richtek.com, th_chuang@richtek.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] Add Richtek RT1719 USBPD controller support
Date:   Wed,  9 Feb 2022 23:42:40 +0800
Message-Id: <1644421362-32104-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Since v5:
1. Change the module license string back to 'GPL v2".
2. Add Reviewed-by in source code patch.

Since v4:
1. Add Reviewed-by in dt-binding patch.
2. Remove fw_devlink_purge_absent_suppliers.
3. Change MODULE_LICENSE from 'GPL v2' to 'GPL'.

Since v3:
1. Fix checkpatch.pl consistent space error in line 332.
2. Refine some error codes to more appropriate one.
3. In psy_set_property, except prop VOLTAGE_NOW, directly return -EINVAL.
4. Use devm_kasprintf to replace devm_kzalloc and snprintf in psy_register function.

Since v2:
1. Fix below kernel test robot build warning.
>> drivers/usb/typec/rt1719.c:492:65: warning: suggest parentheses around arithmetic in operand of '|' [-Wparentheses]
     492 |                                  RT1719_EVALMODE_MASK | src_sel + 1);
         |                                                         ~~~~~~~~^~~

ChiYuan Huang (2):
  dt-bindings: usb: rt1719: Add binding for Richtek RT1719
  usb: typec: rt1719: Add support for Richtek RT1719

 .../devicetree/bindings/usb/richtek,rt1719.yaml    |  85 ++
 drivers/usb/typec/Kconfig                          |  12 +
 drivers/usb/typec/Makefile                         |   1 +
 drivers/usb/typec/rt1719.c                         | 961 +++++++++++++++++++++
 4 files changed, 1059 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1719.yaml
 create mode 100644 drivers/usb/typec/rt1719.c

-- 
2.7.4

